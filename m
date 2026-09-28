Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FFBCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A2DE405E8;
	Mon, 28 Sep 2026 15:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0w5ySL0s-Yj; Mon, 28 Sep 2026 15:07:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F4B14065E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608063;
	b=FbUnaHYj4/Hpo/jXdMNKWhoy9sgXC53ydSz4VXqU/d9VDi6NYEV6et+YYXKPtlF9CAWh
	 fla/GJkL4Sr2eGNkWRiAS0COevEcT/wvMVlf69cgRPdZ7UVCBp+zHBj6Wc4U2GKvIWWEb
	 bHU2g+4eOFiNDwNsguevruzfpkC3IoD2D3CApeRVeY6PeAjNv1fRTnEfZW126Gfp+ioAy
	 eRNMz9/ON4VgGN9Ylzrp8x1AyrQJrILyjrtYC1D/odJ+l9gJYwdFozwFW+JHCfe4ikD0o
	 ioswZQZ+EDBA3BDP/rGNfuknNSWQkjRECnKaS2NDbkPEltTuv78iGV4NjJYH5hO2ZMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9I/vbTUy1hj1+NMnirt+UmvCW6jk1jkJmwfGktzmRgU=;
	b=XYCXTE4f3AJ91Gkjd0RIgqv23TMtzkyBgHo3yDzGLaPAcOC/548pLs0C7FIgH08j85NE
	 SBcC7BwLvmiGZbYjPRufgwkXGy1edqWm83/4pVxKqhqE/5APa3HlVQt56VgvEraKRELMP
	 0QbTMtB2cLwI5z5sqqxlgS5EyzYMYC/1rszpdE2QwVOSu+o8yYL/TtIrdA5nIS5iYZtuR
	 WE/weCSwri+iT6xL+P5m22YdBsbtOPQ92FvGkCn+3N95K2gIyVfRZmJtWsMfOzheZaBit
	 CA4c1I5SyOQidKDYYp0zAZ2XpKjLVGEA7XsMHhyKfeGke+1dw7BwMkj2WnXPpEFdOkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608063;
	bh=9I/vbTUy1hj1+NMnirt+UmvCW6jk1jkJmwfGktzmRgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DA2Ub/lT7wN43nUzFDJrpGw3NQIPWpJ9VRUZszPDjvadDOy6AF8QpDvgqbsuUuKnH
	 0Xd9GAzsS5w4OaH6DpFMuDOA/IpQ7hVZT4+TmF56BYdoK7ysAfRXarykJdIQ0UD6N0
	 aNdCtMKjFg4eEBC1qVIzc2s7CLD9iQE59lEM+H5C5NbCTcMUY1JdD3d5WFsHTK8IO4
	 bQGMHS4wppxEfSDmjmvi6t8ndxORS2sTaP9gKMgZAHIfhSXRwmcugF1/aHan6j+FqC
	 pjTjdhTXwvaA3mbxqNHqde1xuM3JsbJUVR0BfvEYp07kC9E8vQuPxG4ID7YJ9ohAMR
	 bDOU+BF7DZI9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F4B14065E;
	Mon, 28 Sep 2026 15:07:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C19AD1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D5AE401ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFuiA3IKFgL7 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7B29B40055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608060;
 b=hrNgMXmsMlkZGGrpLUWetJbZ+GkikOT7RxxFSubfI1lksdLoE+2qF1Q+XUJwFNFqoXja
 1T2o9AfkSGXBWytAGJgNwme+lrHSFo3HVr38/lfksgEsv3nDM5YDOcMX7lnGjy0u5aVnM
 FNlliIhdhnFnUAPbcPKnWBVmN99J/3XTPVEWkFKEf7/XCHyYK8B1j3t1yzduV5Z2sE3Fc
 c1iudCcqHkdRluTq8aclpwq0hz21cJlJe9IIWwfsXtogRNRaRZ2c9DoUZMCCQP8IWF8EE
 xScWm3s8NGHX4lDJ80hRyeeuM/Plgfkv7qwwcu8lFTRdN+V0UxcX09Nd4nhjN4ITK0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608060;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=9I/vbTUy1hj1+NMnirt+UmvCW6jk1jkJmwfGktzmRgU=;
 b=HZ4DvFmavT1aVgN5/PrjUY54DvmOyCys2doumfRQmZNxtaT7ZkIBF6wyFQTpKeP3Fh+9
 USsB9QHApSrWwCjTgxd7Ea2oFKq3XrTEqPs+t7ndFamcWfFBZhFbcLWkRL4mxKHyU/ELK
 qO70Ip0YMd/bjeWdcK3lVV1orT4KgTNdWq9w62jpotaEmzqKRAcRxzCmthRmmcvPtOZXW
 57knJXgBlzGYeHjzYWZz0BhxwmkDXayZvTV6DXaE7scrradEbPr/xboWd63ljkKM9zOH4
 jkEMDFKGd5iaJ+uddvXryOSMdYuZA1+o41dS/hVF9yRAr5ESvvW2zQZiS6e0hot2xrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CpEPffWy; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CpEPffWy
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B29B40055
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:40 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so19352085e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608058; x=1791212858;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9I/vbTUy1hj1+NMnirt+UmvCW6jk1jkJmwfGktzmRgU=;
 b=CpEPffWyGdDsKHfY6l6vwqT3JVKoF8foyrW5R+zdUMU7uLPNZy2Udlkdl/KPZL49yU
 fWq8EyusMUz42GlEvYZieyoIAKNCZwccMD7f1WU+VD7mQa5KOYYrO57Q5oos+4L/Clp/
 98iY7NMavMnUkOYlKU1qGOXM4amyvyT16jl3a7Xl26vTgXRuarRk+LuEmfJtDTgjvycI
 2K8vxdylIvA1CuiYqnoJVxVP+Wj+BcUSRYGPwUVO7cdPU9EkxrrBeyw3g1EMvCTcGLGb
 /gKOKGQW7SSKf4DS/N3StUNnivsO0OZfo+Y0+0sFkZFN1vsbEFp6X+8Qnp/fLwDSkGko
 f/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608058; x=1791212858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9I/vbTUy1hj1+NMnirt+UmvCW6jk1jkJmwfGktzmRgU=;
 b=mT0BYqY7QIYfa88r50ePQNK9L5BTv85aYFnOGVnH17yBxTnajahaKS1pTw6i5PuY58
 NzOcYKrxGGEfTk6HaF0XZCUztEMpZ7DufpeMG2Vhh7UhPkwL+Zu9G0OPsz58wUDmvniF
 PefMZcRuY4ujkQY9Rmw46uzO9sz2uQRYBTGvH8eb+WqhIGMdqRfhln06RH2/MItCm5yi
 gsYQep+Biy58LxD5YiFG3onfEttrDcTm5Em7xzh+rYCJCe1HKUCaxjGK+HXuSDRlZDwU
 jyrMSlyRBDLYkXwpR+7QgB4yI4kiZ2j1MYPXIV9PMmuPBHxUYuopp35kZZECYSYCOrUW
 L+kA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIScoP1IvkPVIcZrPL+5pBv3O9vnERQBFTPKhDAkqUe9O9TRLPfEz+kCtjdWi1aIJzXW6IzsY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0261QlI67eENp1cni+SbpRGOLQKAKAbKPnu2/znI5UUC+Hkcf
 CAez6dMm78B2Buw+oHWxq0PcxePv0oWSiJkiHwoNgQDJEtoM40pguqVJznbyIV69DLI=
X-Gm-Gg: AYBFou0ivhUf72A+w1TAcnh33K0FAvyp2bh+1o3BzTQsNGh7SvgN9Stw++vs5S5rK1j
 EEwskGO+LxNr29YllliCVP2gkgIf3RkIvOMBqTFiOq/HZE6xFipsGnHPDWW8gwJOyuu9LFkaJQe
 /VHaOxMOxhJecdVa2vL7YPQTEwMvUzEqMIlWGJOrhaRqZl3GljVeSse86+lKgIzZoaA/UMfCtV0
 NAAym23SKvopylijbwLbMibXaBJzjM9BNbcGQvJMomc/Qtntol2fs0+cPFgcMW+n7tqcnbkqmK8
 6YV5NdTfsi9K4bt0slzB0Ka6BlZsAcs66WfXZTUSgfup1SdT5BhrwwV3YCeQyfywQPvjUQhzk9o
 2qMN0Pjw920tv9S5NE/AqYGMLw2pComl95xH3p7oG3Gl9VMblB7/PXFY4qdmex/tLinrf+h0kUG
 JtPfG5mg43rmSMW2h18NYLxQG7LhRRjI0G05d5jCf/tTJA+IcQs54vHZB1eTOlJEWJnrtecQWJG
 xJvJtJxQd+zSNbUIWN5D7bDOtokpd0tiYouTHDcmpz51zCVw2M/Vhthm8xJSi/6consipMRzG7w
 xik2WaXjTIkowfENJapYQu86q/pNuI+gG67fcGKNT+27vGLCnnRQmzY=
X-Received: by 2002:a05:600c:3494:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-49fff7399f4mr86992625e9.18.1790608058310; 
 Mon, 28 Sep 2026 08:07:38 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:07:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:49 +0200
Subject: [PATCH 12/13] configs: mediatek: mt8365_evk: enable dsi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-12-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the configuration required for the DSI pipeline on Genio 350 EVK:
video, regulator fixed, dm_gpio, the MediaTek DSI driver, the PHY uclass
and the startek kd070fhfid015 panel which is the default display for the
Genio 350 EVK. That panel drives its reset and enable lines through
GPIOs only, so no backlight driver is needed.

Everything else the driver needs, the MIPI DSI PHY included, is selected
by CONFIG_VIDEO_MEDIATEK_DSI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

CONFIG_VIDEO also turns CONFIG_CONSOLE_MUX and CONFIG_CMD_CLS on by
default. Both are turned back off: the display is only there for the
boot logo, the console stays on the serial port.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8365_evk_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index cc01dcf434c..8d47e4b4b97 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8365=y
@@ -12,24 +13,31 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
+# CONFIG_CONSOLE_MUX is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_CLS is not set
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6357=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_PANEL_STARTEK_KD070FHFID015=y
+CONFIG_VIDEO_MEDIATEK_DSI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

