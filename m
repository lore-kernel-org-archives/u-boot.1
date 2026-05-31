Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A4CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C19F8485F;
	Sun, 31 May 2026 23:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENhl4o/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAED84862; Sun, 31 May 2026 23:04:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0042C840ED
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso335573a12.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261488; x=1780866288; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vY8I/CGUXHliUGlZg+v3SXDxzP+7+kLffOjNPlqCF+E=;
 b=ENhl4o/ybCBMEAebM1+VPUHKJJkch7Brf0fIdL1XPX/X521GRekNLZ0HwgFTq+qc0w
 W2oK/jkAFBfysCxg84zzuJtNb6CiSw9nqspuq77IIDibs5O7bt0xD+jwDXBdlXZ4ogDh
 T8Ck5x+WbokBSlwIJ8JL7rWQig68wnZuFvsRXlnX0qcfJMKDOvfGSoQ5oawQ00wxHLEp
 Qzx9cpPscDqIOWThXUWZamX9YoiBhhSPuFL3IIrhjNMEKWUvTXWfh1usQp7XxDEJRpsM
 t9pgfWQ5ghzQAtueQ5KTz7UNHJr3cO6RntAvfTGU1s5hopvCVRoaYQCHgk7dMMbQzbim
 8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261488; x=1780866288;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vY8I/CGUXHliUGlZg+v3SXDxzP+7+kLffOjNPlqCF+E=;
 b=iyzqMyDkubseSAH355QKqv43aqUNAtDvB73GOcP9n8OYlT5CF6PsfCvCfD+06MkAgi
 i31qUN7ACTjn52skz0FcbJei/Uuy8RSDFhRT7mWUlKlvNaoy2lzRdFCKlgs/DCcoCakU
 1npHdwL20/4vlfglp459aUhq2zW8s55p3XhlQyizwXDs4635y/XrWzQaSZGEEGKQyE/o
 IhMiJlfm664HWrJHmsqBzvBZ8BvYF9yu3Q+1IH3BYwGU0a+ZKsOgM1d4MEFvA9QIiZnR
 J3bCVKcrKG8w0QkV3K6leV3z0xAEUz+OcFGVWTW2/AfD/Gamcm65O4ZTf67FenVz113/
 vGMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IfbkvXV4biN5PG83DfIKwZHdOgysU6Lzl1UdiRTs61iQ8rxGosBrKIyJ04ZnhXYXCeKS467I=@lists.denx.de
X-Gm-Message-State: AOJu0YwmW/mmufFyeAreA5SiGtjGnPkPvOu5vmavcIJyaxI0VWpzvG4U
 pV2O74Vi8Sm9IRIIL4HaZDCIcjXGZKRBTLK1LMt6iD7lDmoDZKFnglYO
X-Gm-Gg: Acq92OE4Cj/n5SBEfw+7gP6a3y18cKLk6vqZ9hHQQY/t8q6aJkI1pTaaHGNSTeLbcgR
 pg4ujK4NS1VpbySEAUj87n980zF+1Ksn8CfVupOvK7vdxoQgVtoZsKqbecAHJyuQwKvCCEmQudd
 FgIbSajyKycHlzh/1+9911cBvG4uNe6iS/heG4IaFE2mPPJNyLAldajvWtz3FbIPQW2wHxGnz9/
 Y4JfIaZ/trpT50rfJ3RylX3JcuctsVXARPpIwNAcAna/uQK6nEOsBNHQXgGLYOA6IpcMiKYI5de
 esPb1m6+G99rqr8aVwk8zyr9ets3kTvzK79C8zWr9BXc9h6VdNDmJyJq92k1km6yEhvOCqUTbx8
 Fl4JYarQYNR5epVrHS4e1K4MsqcN3a8aOTIrg7wp30uSR3TC8VFIXAcQhpAUwT1VqnfyXcK9Gac
 7T4JL1OX8hpYG3IewyOKbgKs/CC2qbQ6s5GiK4FD9Xok7EAeK2xH/RxRVFi0iVLILoLaHA//Dt
X-Received: by 2002:aa7:ca5a:0:b0:679:5bb:45bb with SMTP id
 4fb4d7f45d1cf-68c8a375081mr1175123a12.5.1780261488319; 
 Sun, 31 May 2026 14:04:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68ceb79176asm1310189a12.4.2026.05.31.14.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:04:46 -0700 (PDT)
Message-ID: <2be3fe40-fc27-41d8-8baf-42abc556c172@gmail.com>
Date: Sun, 31 May 2026 23:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 12/12] rockchip: configs: enable USB in SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Enable USB in SPL support for mk808.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 configs/mk808_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b8c6f516591a..3a65e4f699ae 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -46,6 +46,7 @@ CONFIG_SPL_MAX_SIZE=0x32000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_DM_RESET=y
 CONFIG_TPL_HAVE_INIT_STACK=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
@@ -87,6 +88,7 @@ CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_USB2=y
+CONFIG_SPL_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -106,6 +108,8 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
+CONFIG_SPL_USB_DWC2=y
+CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
--
2.39.5

