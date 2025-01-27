Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E67C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7CD8128D;
	Mon, 27 Jan 2025 15:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="DjQ58o/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6D981292; Mon, 27 Jan 2025 15:49:05 +0100 (CET)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C36E81276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737989341; x=1738248541;
 bh=5jfEI7Kavxh4hSoxuvkG/j+hDq30yKv6MgdIfxzAbtc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=DjQ58o/EW3KqRBNgMUBJy96SZJ99Yo0F5GOWS7j5pBQs9bvI4YV9c6km/g3fYx5b7
 sszDvQM9sRV8TlLFab++oI4YQzejm0niB9MrlNv5o3mczF1jnh7OTSSPFlZvouhK0Q
 lwjkMT7LERrwUCL070tZH5IbWhxdubagXB4NbB17Fn+uMiCxI4HlaXgLQaENpxEcXi
 vPFReogGD49A7QhBduTa/mzB5opMbtKF1T/lAI5GkcMpy/mZBDWkHvBkBGS30XeODO
 J3XfyKA1hiRLfeZItjWwDTpeVYBPw/67hBcAlhddcyjWKwpQYUshQCXZQC72Cr8sTw
 +G5vSUVOpvYQQ==
Date: Mon, 27 Jan 2025 14:48:55 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] mach-snapdragon: handle platforms without PSCI support
Message-ID: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 20eacb95d5396e408d43f5243d3cf842e02b2dea
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Most MSM8916 devices shipped without PSCI support. The history is quite
nuanced (a good overview can be found in [1]), but the end result is
that the upstream DTs for this SoC pretend that PSCI exists, and it's
expected that the bootloader handles the case where it doesn't. This is
codified by the de-facto bootloader for MSM8916 devices, lk2nd [2].

So we handle it here by deleting the /psci node if we detect the absence
of PSCI. We need to do this early to ensure sysreset works correctly,
since the PSCI firmware driver is PRE_RELOC and binds the PSCI sysreset
driver.

Additionally, show_psci_version is updated to check that PSCI exists.
Currently this banner outputs "PSCI: 65535.65535" on devices without
PSCI support, which isn't very useful :)

[1]: https://github.com/msm8916-mainline/linux/issues/388
[2]: https://github.com/msm8916-mainline/lk2nd/blob/8183ea2/lk2nd/smp/spin-=
table/spin-table.c#L237

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 43 ++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index e87551784b8d7afb4186533d43b8bddacba9faec..75b9cf1a8a1b3383665eb2d4e67=
25efe59718de0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -162,11 +162,42 @@ static void show_psci_version(void)
=20
 =09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
=20
+=09/* Some older SoCs like MSM8916 don't always support PSCI */
+=09if ((int)res.a0 =3D=3D PSCI_RET_NOT_SUPPORTED)
+=09=09return;
+
 =09debug("PSCI:  v%ld.%ld\n",
 =09      PSCI_VERSION_MAJOR(res.a0),
 =09      PSCI_VERSION_MINOR(res.a0));
 }
=20
+/**
+ * Most MSM8916 devices in the wild shipped without PSCI support, but the
+ * upstream DTs pretend that PSCI exists. If that situation is detected he=
re,
+ * the /psci node is deleted. This is done very early to ensure the PSCI
+ * firmware driver doesn't bind (which then binds a sysreset driver that w=
on't
+ * work).
+ */
+static void qcom_psci_fixup(void *fdt)
+{
+=09int offset, ret;
+=09struct arm_smccc_res res;
+
+=09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+
+=09if ((int)res.a0 !=3D PSCI_RET_NOT_SUPPORTED)
+=09=09return;
+
+=09offset =3D fdt_path_offset(fdt, "/psci");
+=09if (offset < 0)
+=09=09return;
+
+=09debug("Found /psci DT node on device with no PSCI. Deleting.\n");
+=09ret =3D fdt_del_node(fdt, offset);
+=09if (ret)
+=09=09log_err("Failed to delete /psci node: %d\n", ret);
+}
+
 /* We support booting U-Boot with an internal DT when running as a first-s=
tage bootloader
  * or for supporting quirky devices where it's easier to leave the downstr=
eam DT in place
  * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
@@ -212,12 +243,16 @@ int board_fdt_blob_setup(void **fdtp)
=20
 =09if (internal_valid) {
 =09=09debug("Using built in FDT\n");
-=09=09return -EEXIST;
+=09=09ret =3D -EEXIST;
+=09} else {
+=09=09debug("Using external FDT\n");
+=09=09*fdtp =3D external_fdt;
+=09=09ret =3D 0;
 =09}
=20
-=09debug("Using external FDT\n");
-=09*fdtp =3D external_fdt;
-=09return 0;
+=09qcom_psci_fixup(*fdtp);
+
+=09return ret;
 }
=20
 void reset_cpu(void)

---
base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
change-id: 20250127-qcom-handle-absent-psci-6e8e8af7bcd7
prerequisite-change-id: 20250120-qcom-parse-memory-updates-96ffe248cdf1:v3
prerequisite-patch-id: 65448b5a93120d2117c1361035afc9bd911d005f

Best regards,
--=20
Sam Day <me@samcday.com>


