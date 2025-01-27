Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97F0C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710CB8191C;
	Tue, 28 Jan 2025 00:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="uoiB6S5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E50D812BB; Tue, 28 Jan 2025 00:03:25 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9B6819D2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738019001; x=1738278201;
 bh=aNyyIvNEkIBfz9eQook21E45XzUt0530guT/1rcNs+k=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=uoiB6S5hIKHTbKFgMyE3IC8YTFI7wzEaV9QZ6ue1iOObZ5eXe3hU95zroFcPNAJUg
 q9UnxVNtJf3t10Fj+qqjXTziOOFpBpzMGgSlGxLhYkDhpdyZWrPbZ9Fr78iedDZcNG
 zZGFmJJFzJDi0UVmIH7QW5of3zNRwtuu3eZ4JLJtb5nECArmdLqwiPVvvF9Sy+ZpOT
 pStQ0Rmc1vNIEjkfAdwGqk7b0jK57V++kES05h3vQkcWLoQoln33X002ibBSy6p00A
 V+CJokLKfcaEizLQFfgrbL+SwraiHj58QSdeiLm+VuotCDU1gPbCwGHi4sU1TEOsnl
 FBx6+J15DBv/Q==
Date: Mon, 27 Jan 2025 23:03:15 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 4/6] mach-snapdragon: fixup CPUs with PSCI enable-method
Message-ID: <20250128-msm8916-smp-support-v1-4-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: a5a6311acadf767ae606b914b9d4b079d18fded5
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

If there's no PSCI implementation, then change the enable-method of all
CPUs from "psci" to "spin-table". Later, when spin_table_update_dt runs,
it will further patch the CPU nodes with the necessary cpu-release-addr.

This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enabled,
since that also determines whether spin_table_update_dt runs.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 41 ++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 75b9cf1a8a1b3383665eb2d4e6725efe59718de0..396898e270bb744151ffd2f0f4e=
a319f6018dcd4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -181,7 +181,9 @@ static void show_psci_version(void)
 static void qcom_psci_fixup(void *fdt)
 {
 =09int offset, ret;
+=09uint reg;
 =09struct arm_smccc_res res;
+=09const char *prop;
=20
 =09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
=20
@@ -196,6 +198,45 @@ static void qcom_psci_fixup(void *fdt)
 =09ret =3D fdt_del_node(fdt, offset);
 =09if (ret)
 =09=09log_err("Failed to delete /psci node: %d\n", ret);
+
+=09if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
+=09=09return;
+
+=09/* If spin-table support is enabled, make sure any CPU nodes with a
+=09 * PSCI enable-method are updated to spin-table. Further, any PSCI
+=09 * power-domains properties are removed.
+=09 */
+
+=09offset =3D fdt_path_offset(fdt, "/cpus");
+=09if (offset < 0)
+=09=09return;
+
+=09for (offset =3D fdt_first_subnode(fdt, offset);
+=09     offset >=3D 0;
+=09     offset =3D fdt_next_subnode(fdt, offset)) {
+=09=09prop =3D fdt_getprop(fdt, offset, "device_type", NULL);
+=09=09if (!prop || strcmp(prop, "cpu"))
+=09=09=09continue;
+
+=09=09prop =3D fdt_getprop(fdt, offset, "enable-method", NULL);
+=09=09if (!prop || strcmp(prop, "psci"))
+=09=09=09continue;
+
+=09=09reg =3D fdtdec_get_uint(fdt, offset, "reg", 0);
+=09=09ret =3D fdt_setprop_string(fdt, offset,
+=09=09=09=09=09 "enable-method", "spin-table");
+=09=09if (ret)
+=09=09=09log_err("Failed to set CPU%d enable-method to 'spin-table', this =
CPU will not be available to booted OS! %d\n",
+=09=09=09=09reg, ret);
+
+=09=09log_info("Patched CPU%d enable-method to 'spin-table'\n", reg);
+
+=09=09prop =3D fdt_getprop(fdt, offset, "power-domain-names", NULL);
+=09=09if (prop && !strcmp(prop, "psci")) {
+=09=09=09fdt_delprop(fdt, offset, "power-domains");
+=09=09=09fdt_delprop(fdt, offset, "power-domain-names");
+=09=09}
+=09}
 }
=20
 /* We support booting U-Boot with an internal DT when running as a first-s=
tage bootloader

--=20
2.47.1


