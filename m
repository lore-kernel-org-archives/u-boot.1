Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B82CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5870484702;
	Mon, 25 May 2026 04:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="E8J/KyA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0C483EF9; Mon, 25 May 2026 03:29:14 +0200 (CEST)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060938039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672550; x=1779931750;
 bh=uoiwZTH25xsDBhyriL8HRAVGx5kNtRTZm+gPDOihVkk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=E8J/KyA69BSS94B6PGoGuoeotxBUkx9DcaBuN9gFsFsFjJbCj1LBBPYUh45LnmVpb
 Rw3dlEALXt1fnRFjaQt5XevGxtquNytT40NchVixsw1Wa7aMiAoDNrNArvB/5E6sxA
 IxBY0iIJXB2bOdMIShd4ORrlLbSEzQZY1CBXL23c4U+5uwaPHMk46d+Q0/nxPoqBCz
 wnoyhRtv3+LgknqS5lk/79cusucj+jBGDj9DqPG0aC9YILxpkL5yTbL947FsOJQQ9c
 BXk1Q5b4pqlK4WN3g0B1p6P5IDQa4qnPDsn1LSVoZQRVLeUabA2xUumPheurGz1rS8
 lHnQPWGysuN4Q==
Date: Mon, 25 May 2026 01:29:04 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 04/14] arm: rockchip: rk3576: add DDR GRF syscon region
Message-ID: <20260525012824.121-5-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 7a79c22ae981afc179b4b24271abcfca2703c331
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

The DDR GRF (at 0x26012000) controls PHY clock gating, LPDDR5 CS
toggle, and the dfi_init_complete mux.  The DRAM init driver needs
it as a syscon.

Add ROCKCHIP_SYSCON_DDRGRF to the shared enum in clock.h and register
"rockchip,rk3576-ddr-grf" in syscon_rk3576.c.  Also add the missing
#include <syscon.h> and fix a trailing-space inconsistency in the
pmu1-grf entry.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 arch/arm/include/asm/arch-rockchip/clock.h    | 1 +
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/=
asm/arch-rockchip/clock.h
index 95b08bfd046..a6b399da4ff 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -39,6 +39,7 @@ enum {
 =09ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
 =09ROCKCHIP_SYSCON_VOP_GRF,
 =09ROCKCHIP_SYSCON_VO_GRF,
+=09ROCKCHIP_SYSCON_DDRGRF,
 };
=20
 /* Standard Rockchip clock numbers */
diff --git a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c b/arch/arm/mach-=
rockchip/rk3576/syscon_rk3576.c
index 0dbf8f8d9c0..64934afeeaf 100644
--- a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
@@ -4,11 +4,13 @@
  */
=20
 #include <dm.h>
+#include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
=20
 static const struct udevice_id rk3576_syscon_ids[] =3D {
 =09{ .compatible =3D "rockchip,rk3576-sys-grf", .data =3D ROCKCHIP_SYSCON_=
GRF },
-=09{ .compatible =3D "rockchip,rk3576-pmu1-grf",  .data =3D ROCKCHIP_SYSCO=
N_PMUGRF },
+=09{ .compatible =3D "rockchip,rk3576-pmu1-grf", .data =3D ROCKCHIP_SYSCON=
_PMUGRF },
+=09{ .compatible =3D "rockchip,rk3576-ddr-grf",  .data =3D ROCKCHIP_SYSCON=
_DDRGRF },
 =09{ }
 };
=20
--=20
2.45.1.windows.1


