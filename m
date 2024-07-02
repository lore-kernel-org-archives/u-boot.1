Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0ECC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78579883B6;
	Tue,  2 Jul 2024 17:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FR2IBbVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE6A8852D; Tue,  2 Jul 2024 17:38:14 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE7988495
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so452185f8f.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719934692; x=1720539492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MDdylNRAMaJwbN8WvRyEeOB+toBEHdcPGadcMVzf4Ic=;
 b=FR2IBbVOsXPHwQHfjeSbMbLPgjL9DKUsTZJ5oOqTvSbhq8Gw/qfgX5GTjxa4vnvObz
 Iwq+tIF5APtujs4EzZjehP/f+RIZtC8JNv+S9CZbXoYII2T5WoakwgHCuSmFBhSVtJcv
 TFxLO0ytyB/WYeNgYl2pyWWD05CXrd2tp26/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934692; x=1720539492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDdylNRAMaJwbN8WvRyEeOB+toBEHdcPGadcMVzf4Ic=;
 b=DCUy/GbqHT7iDY66hWOWkZUuqR3NdBrgcsCbSkVbxjwIyotQRBSdUx5b47DXnYoCA6
 1Pu9/n8SIZt4bKRI+oC2WXqUSFlVWAFPDrygeBdPAvnayARLTU/MpjJRladgY9XQ+U+Z
 mgI/5wYD4eOnSODMnRDNw70W36EFxmSc9VP+iVRafW4HY/ums+QHU+eX7XEWngLDB+Av
 3WnJmdnX2LEK29r7YsQedGcb2VhdfsAaE5a7RO1qPX/KLh89ych2wqcscqrOVlgKsMXk
 nh6okgtKFuEPvYblVih+whLrzJ3CxuyRI+fW0jk7NhiuQ53oRcQe7QRKfC0senMf4INf
 hj6A==
X-Gm-Message-State: AOJu0YwxCP3LeZsgwJC45jjDJjGED4NAo62mQ982l6jnkIzyuY9LTW9r
 AFVFfYF19Zg2e6Ck7x/OKm6GDzjgMJI6zq1X4fP0AW9MhaBLKDsE7IgLzxoIc7U0mv2xKEMPMkw
 =
X-Google-Smtp-Source: AGHT+IE1C8kWZeYVYI14JmCcInFMyAMVDNrsHyHWAVKGeL54DHZkPOg+jJ2qLeA6Tm8a5p+6P1ai1g==
X-Received: by 2002:a5d:47c3:0:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-36774f89a60mr9708616f8f.25.1719934691780; 
 Tue, 02 Jul 2024 08:38:11 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678c379cc6sm1235700f8f.49.2024.07.02.08.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:38:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] mx9: Correct repeatable build error
Date: Tue,  2 Jul 2024 16:37:39 +0100
Message-Id: <20240702153739.2651815-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

For some reason every second time imx93_11x11_evk is built it gives an
error:

   make O=/tmp/x BINMAN_ALLOW_MISSING=1

It seems to sometimes skip generation of the .cfgout file and then
eventually Binman complains:

   ValueError: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n
      spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000
      ./mkimage-out.spl.mkimage': Fail open first container file
      mx93a1-ahab-container.img

Correct this by using if_changed instead of if_changed_dep

The only reason this hasn't come up in CI is that buildman did not retry
failing builds of current source, but now it does.

Note: The logic in this Makefile should be moved to Binman, e.g. these
warnings duplicate Binman functionality:

  WARNING 'bl31.bin' not found, resulting binary may be not-functional
  WARNING 'tee.bin' not found, resulting binary may be not-functional

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ef0caed3f7f..640e332e78b 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -227,7 +227,7 @@ flash.bin: MKIMAGEOUTPUT = flash.log
 
 spl/u-boot-spl.cfgout: $(IMX_CONFIG) FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call if_changed_dep,cpp_cfg)
+	$(call if_changed_,cpp_cfg)
 	$(call if_changed,imx9_check)
 
 spl/u-boot-spl-ddr.bin: spl/u-boot-spl.bin spl/u-boot-spl.cfgout FORCE
-- 
2.34.1

