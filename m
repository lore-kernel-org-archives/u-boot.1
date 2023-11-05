Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004EBC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 02:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FC686F9E;
	Sun,  5 Nov 2023 03:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPoKMVle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B881886FA7; Sun,  5 Nov 2023 03:28:02 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619E186E7A
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 03:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41eb4210383so3143101cf.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 19:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699151266; x=1699756066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=11c2B2ULn0MUn5+8uBbjAQRJxHIIfVC+aVEkyFIvKBg=;
 b=VPoKMVlel59qSxbP8V3y0WO+X8zUiuQ6E8szIQFSk3Tp7i4lqRZjH1Abl/OpOd91RD
 KA+2Lkm2ELLa2ygKszHKi0yqOslRsgiHBT4V08sLfz9BNrielHDakxE1yPPHLM/KWgMr
 mFR/4uJxq08psdGWTD77v+3kP61COMTfhrQhgfzkcWucQANNCopghnoJAbw1au15/xgL
 5AOomeb0kqY34cbaqDP/sIR1Mj9bvCZ9SoqODi40L8+kcS5oPqvuWTjBIcaKSGkDsMuk
 H4nij2iGvzSiIIixohtD+yF88hsySVsddZhIs5TlREfnTb2rRcIEhCLZ8IPZ0kSxDKx2
 n56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699151266; x=1699756066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11c2B2ULn0MUn5+8uBbjAQRJxHIIfVC+aVEkyFIvKBg=;
 b=pHEKs6ehPLsqquPBMxKyDLYJ8ca9/xzpgXPOe3AvaabglGdc6XjDervG+9uUJuQca6
 TYCllS2t1URQzENhTe2/rk4MJOu3BU6x/427MtDGWLOGDP8S8VTLdqJQUDXBpMaWi9NC
 gEoIRnU1eYlhh2YyqqS8FE46OKW/Z8bNqipagSBAfdD2uX8R8Uq7Lyk6vmYlG2mnAHQC
 1dvDz3CrZpQZRxGJShX06Da1lraDlZ34TxFcaUdHVJ4tjJihEX7asYihDMIWJ85aA7Af
 zs83KC1GpceXYOXMDnd3DhVz8zipe9389XuEXXnFxnCzvakbz/9PauGFu0onSZlwJw0I
 OnNA==
X-Gm-Message-State: AOJu0YwZe7dm3f36teP7q5SjaTmI4B4P4YzmebACFzrYnlgrAsKm5z8M
 LIvwUa52VAzw58Qw8zks1Hc=
X-Google-Smtp-Source: AGHT+IG3K/xVqxPujvVoz0+Xw7vCfo/uRpRMGnoiV4GkR2tELaKFkLtXhCMu9UyiYmSCaZUbDSdytQ==
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id
 c7-20020a05622a058700b0041e1dffbed5mr28421250qtb.37.1699151265922; 
 Sat, 04 Nov 2023 19:27:45 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d9-20020ac851c9000000b00419cb97418bsm2101133qtn.15.2023.11.04.19.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 19:27:45 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Eugen Hristev <eugen.hristev@microchip.com>,
	u-boot@lists.denx.de
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Date: Sat,  4 Nov 2023 22:27:42 -0400
Message-Id: <20231105022742.632175-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Several AT91 boards are quite close to their SPL size limit. For example,
sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn't
even fit with older GCCs.

All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD. This
shrinks SPL by around 30%.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---
This has been BUILD TESTED ONLY!

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c984..a589cee395d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -568,6 +568,7 @@ config ARCH_AT91
 	select GPIO_EXTRA_HEADER
 	select SPL_BOARD_INIT if SPL && !TARGET_SMARTWEB
 	select SPL_SEPARATE_BSS if SPL
+	imply SYS_THUMB_BUILD
 
 config ARCH_DAVINCI
 	bool "TI DaVinci"
-- 
2.37.1

