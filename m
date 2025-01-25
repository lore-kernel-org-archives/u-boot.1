Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DA1C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 19:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3DF80EF6;
	Sat, 25 Jan 2025 20:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="BbGcNpha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D22380F0E; Sat, 25 Jan 2025 20:59:22 +0100 (CET)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA8280EF4
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737835158; x=1738094358;
 bh=8fRm48JdMTsOQ7slrKDVl4kYs2AIqMeG0qjxp1myXYw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=BbGcNphalNTaw+YceqkkfOQQXuRkUh8amOLYcBahkdpypkUZSfB1rHK2tcZaj1iMt
 S6AWs+/MNT6oJLS+Eq7QpB1uDlJCFZj+cq8osFegfKlwPU7DNE5H21MqcLbwu1Hi/E
 +Y4xbRBuklnLQd+P+aGF6rToa6zUS8XSygFnDN/g6kGdeU5KXwHypxwybbNEYgzIzV
 z3yNRxnNs12e/1Jx8aHHKwwWTsi80vZ7nNmvK1yYroYQ7dGp2DBBXRninDYocM8IVd
 QAHtxoTfuyQo/rQ80+qMPLJbRsa1XGPabdzAAdgPLNZUiC6ZnupMO8inC0FunXtqe3
 h0y3RGiwgwLRg==
Date: Sat, 25 Jan 2025 19:59:15 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 1/3] mach-snapdragon: use PSCI sysreset driver
Message-ID: <20250125-msm8916-sysreset-v1-1-62073932ff0e@samcday.com>
In-Reply-To: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
References: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 8689886fdd5da9cd692eee40cf0ad6b0fa89549b
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

Drop the `board_reset` function from mach-snapdragon board code, and
instead use the standard PSCI sysreset driver.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 5 -----
 configs/qcom_defconfig           | 2 ++
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 2ef936aab757c7045729a2dd91944f4f9bff917e..eba98b73ae629671662ecc2b060=
544a931718748 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -187,11 +187,6 @@ int board_fdt_blob_setup(void **fdtp)
 =09return ret;
 }
=20
-void reset_cpu(void)
-{
-=09psci_system_reset();
-}
-
 /*
  * Some Qualcomm boards require GPIO configuration when switching USB mode=
s.
  * Support setting this configuration via pinctrl state.
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a4e7a21c31151103e4272147bc27eeddb11b41ed..d19be69190da4e2ddfbb60c4d44=
ff793e804c523 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -119,6 +119,8 @@ CONFIG_QCOM_RPMH=3Dy
 CONFIG_SPMI_MSM=3Dy
 CONFIG_SYSINFO=3Dy
 CONFIG_SYSINFO_SMBIOS=3Dy
+CONFIG_SYSRESET=3Dy
+CONFIG_SYSRESET_PSCI=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
 CONFIG_USB_XHCI_DWC3=3Dy

--=20
2.47.1


