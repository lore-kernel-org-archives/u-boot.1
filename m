Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C25FC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7915B8831C;
	Tue,  7 May 2024 20:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="E4S2nTVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E698831F; Tue,  7 May 2024 20:41:30 +0200 (CEST)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BFD88116
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1715107286; x=1715366486;
 bh=DVdgnGSpIo+am3iCcH8zcHK6iJ374tYs/x3qRTUJbhY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=E4S2nTVj6Igtg/LaR78+3hdFnMl3p6dZPSc+gfx7B4cbnFfMZLE4KrlEUCuzo4O3S
 K0MHzOyS1ySU5GIHjGNg0WaO3aNo3UHRUmJgB+AupkrqBeYinRxueinw1IDCC2kGPQ
 kNnPtA6Bt38f4Ch3PV8doHY4Sb+f/srcz7ITkj52E7b3JS9OgatYQke6iRYMz/l759
 24ysiMMGqHDgt6IaogpMg2mOfrik1Ox4aRUUe2RU8CnuIUoBe68PRehYvBaXMSxbYZ
 h4+VDTzlqyiIvANMsdIKiAVlEq7/QMcymCBZos6EBLVFaVO0Idizk6zAkCbu/N3V9L
 OFAnZFLHuwm+w==
Date: Tue, 07 May 2024 18:41:23 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] mach-snapdragon: do carveouts for qcs404 only
Message-ID: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: cd9e94e31d640f25447f020596271e11ac77cf82
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

The newly introduced carve_out_reserved_memory causes issues when
U-Boot is chained from the lk2nd bootloader. lk2nd provides a
simple-framebuffer device and marks the framebuffer region as no-map in
the supplied /reserved-memory. Consequently, the simple_video driver
triggers a page fault when it tries to write to this region.

As per Caleb's advice, this simple patch only does the carveouts for the
qcs404 SoC for which it was originally designed. The intent is to do the
carveouts for more Qualcomm SoCs in future.

---
I'm not sure if it's feasible to get this in for the 2024.07 release,
but it'd be great if we could - it's the only thing that breaks U-Boot
master on msm8916 devices that chain from lk2nd.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 3d5994c878..b439a19ec7 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -467,10 +467,12 @@ void enable_caches(void)
 =09gd->arch.tlb_addr =3D tlb_addr;
 =09gd->arch.tlb_size =3D tlb_size;
=20
-=09carveout_start =3D get_timer(0);
-=09/* Takes ~20-50ms on SDM845 */
-=09carve_out_reserved_memory();
-=09debug("carveout time: %lums\n", get_timer(carveout_start));
-
+=09/* We do the carveouts only for QCS404, for now. */
+=09if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") =3D=3D 0)=
 {
+=09=09carveout_start =3D get_timer(0);
+=09=09/* Takes ~20-50ms on SDM845 */
+=09=09carve_out_reserved_memory();
+=09=09debug("carveout time: %lums\n", get_timer(carveout_start));
+=09}
 =09dcache_enable();
 }

---
base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
change-id: 20240507-qcs404-carveout-only-7a15bbf3fd89

Best regards,
--=20
Sam Day <me@samcday.com>


