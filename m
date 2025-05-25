Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82464C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4187582BDA;
	Sun, 25 May 2025 12:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZvIcGm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B582F836C1; Sun, 25 May 2025 12:48:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC23183726
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so12154985e9.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170123; x=1748774923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFtBPmzmCjdZlKBrDQgtAlIS7l8QnTXqSxTGIDF/bzY=;
 b=AZvIcGm0aalwl3gSQuJzBTwpRNnLqHKZCh2HTk9eEDrzbJT1jHQKm/NVJfaBU1vU3N
 v8SMgJEVUTPoL4xxUm2Ujl0uJJZGSZ/QUxjONT40PN/bGeRatjTxi9HwWKxJfXx+fFWx
 vYlvZPuIKLCuYcyR8Lq2vLjpSlxGo81DPdMjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170123; x=1748774923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFtBPmzmCjdZlKBrDQgtAlIS7l8QnTXqSxTGIDF/bzY=;
 b=eBLMUgxKNX9fHlGB1kFnN0VycQ4ZkWsOi69gADhO5w4uV8E4cTiRBzKryoXRa1i9kS
 qVPaS21pfvcEHfXrmurZvr62oH5PYmgoqLS5y6FoZrZqxjscXJkSlpR4stRxmF2nrOsn
 ir7TfJ8M0SovnNJXdBBFLHVnVwt6Ne73Txhwoxear6lLqSHvNDlq5dVN4wj1J6+/OCrR
 fPfqpiySHrBjHjmO7hXcXrZTwiKtvyRnwe6FMirkl2ApYJMG9q3ECk46/DVMHh9r8zWM
 McDQWUgX78fVdmif/iDXix9B/Lw0CUHykqYtC5zSXrW4M5+DiOStlKm/fv/ozxyxNIrM
 IpBA==
X-Gm-Message-State: AOJu0YwX7HJFiTe1rsOI5OMeiBDJ/NZpHmU86AadXwADM8G7OldckGAE
 ihrnXmtvto6de4BwoDWv5mmi6rllffQ3S81lachXjFOseVVCJVfP2YGtdCbdq6BbKd+0ZHfDMIl
 MFe+G28oO
X-Gm-Gg: ASbGncupq5S9Kzl8YLbVoeKuYkGC65bPNZRaErwsE5paMvmXXFxdm0iOpxLe8XcHrkL
 r62t9s2NQfklFmmyEkCsmENDFfdl+b4qRu+VggA7/3f0l3HycsCw/GPzC7PN5lpVUCo+SRKwffe
 Ehd2Mg3qH9j8Tg0YHNFq2mgEtU+ToyWphalG9hl8Cds68H+ckIH+zDNmt5Db0Zm7biBCnjdOJpm
 jgQbS/nMnj+Q/pn7BO2EYQDGHl+bOk1xjaIap5IP95ifQUcdZg0qDxmfZ1vcnpByEvJ9/N111QJ
 Wls3+lxcTUB9mSuawzRNEmmSeHZ57W/eIb4SS3q+S+3xvQYas6BWhp0e9H6E2WRG6rR1riI=
X-Google-Smtp-Source: AGHT+IHz5+XQvfK8Bvj7RB4Uc1UAgajY1mmrQHHrnbnaZdkQuFIDRC2tPXlFCRvmU8VbWV0Wwh3LIA==
X-Received: by 2002:a05:600c:3caa:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-44c937d1443mr50424185e9.14.1748170122834; 
 Sun, 25 May 2025 03:48:42 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 22/25] rockchip: Update binman image for new skip-at-start
 setup
Date: Sun, 25 May 2025 11:47:58 +0100
Message-Id: <20250525104801.1440260-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Now that the skip-at-start feature is properly used in Binman, drop the
various workarounds in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out the fixes for skip-at-start into a new patch

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index c5d55b87164..ab205d5d13c 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -28,7 +28,6 @@
 			bootph-verify;
 			compatible = "fwupd,vbe-abrec";
 			storage = "mmc0";
-			skip-offset = <0x8000>;
 			area-start = <0x7f8000>;
 			area-size = <0x800000>;
 			state-offset = <(0x7f8000 - 0x400)>;
@@ -129,7 +128,7 @@
 
 		vpl {
 			type = "fit";
-			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200)>;
 			description = "FIT image for U-Boot TPL";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
@@ -174,7 +173,7 @@
 # ifdef CONFIG_BOOTMETH_VBE_ABREC
 		vbe-a {
 			type = "section";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			spl-a {
 				insert-template = <&spl_template>;
 				size = <0x100000>;
@@ -211,7 +210,7 @@
 # else /* CONFIG_BOOTMETH_VBE_SIMPLE */
 		vbe {
 			type = "fit";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			insert-template = <&fit_template>;
 		};
 # endif /* VBE method */
-- 
2.34.1

