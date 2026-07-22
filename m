Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4BC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5079A40A7F;
	Wed, 22 Jul 2026 19:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDJDWXNOpv3R; Wed, 22 Jul 2026 19:47:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B6DF40A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784749625;
	bh=029kwIRR1LkDpW4sRuEak4mvKtga4/w2OQWlL5AUdZo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jHESIwTgakGH1mMvaow+q+td4Ekcaiu5o3UuB7AbQZnmQakRDU+cDkjTXw83+WDi8
	 tjfSAh7d/qWWrft6VkGuQOEiF6mon3f7tDRg6dSPXUypjcU6ByY7VQpR4RO2Ta2OlA
	 +9udJZhwOLM9WKfnMPQEL0XymsZbzrML3a/JbTWoNgm6Q8ZRxa8TA73l95/hMUkK7L
	 CornWXHqGS1N8gA0xLHBVPnSGKxOuqREYfFhxtqboFtYQC7bU4gP5XPB2IfRcYr3bI
	 B56UHk41EfXQTH3+Atg1tLWpDEJ0X+W7kfFHbTt+VCpfYg9nANOXx7dujRzmvqw1Ll
	 qYoYLYzSgH/Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B6DF40A8D;
	Wed, 22 Jul 2026 19:47:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F1D139E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0188440A91
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T__YBHtBz48S for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:47:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 66F4D40A7F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66F4D40A7F
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66F4D40A7F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:47:03 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso13052674a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784749622; x=1785354422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=029kwIRR1LkDpW4sRuEak4mvKtga4/w2OQWlL5AUdZo=;
 b=sNwwMHfZru8mpLOF6cJLkXR9Iv8GTn4PsSUuojaiU1ctasr2eORyUGhUFHORnNPwdn
 AObJratf//NY1UKBOEHxe4Mp4EV/luOEXhpU5bD9cnfQ1MNRXh0YB1QTwSNr4+n4OdPX
 WjlOQFHlpksUyRWP8bHlq31DLOGs3Uhqp5wgLTjNqWNXsU+9DFmgXcZ4y0tYBI7WsroJ
 KnYWbtpy9/rmCozYGsZdstPQmutI5ibQkNmO91ksZE44gJb/buKqDntTEFPkZUsgtuNy
 mFHGTTH7NKUmIJJcmFcdwWg0C6ZA1N9K7wg2ZV5fCGjKKiaeixPzmYwyFgko6ScMKAvc
 36sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopxJWnk0gZ8F6pXWnPjwfzqkSczGzDJ3HaEX2Jxw8CknbRzbGxDssegeE14dU3WLxQ85JQI6Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyzXD9y92MsFgSdhotTP4W9qyCNgo5ZRQTXJZKWotWZVWZCXQ1e
 g3lr/WxftApvKXlTV16klNfaMrU9qAU+fGTub9aqMuZdfKgxlsqDn6t/0nlnOA==
X-Gm-Gg: AR+sD11FCij0ZfoZpBLMIj7dkmNmHi2g3EY4ipGyZK/KfKHn9BmQGHku3rOVUSrpSm5
 ySVrnbPTbganCPxRY6cKDCqnILoXyp06lCCyxZ9EUuq29sQ1vtZYAq2uC6wTHJhrFpBKLdbsfhF
 hQHFSPNZ0Cim9EqACCyhOpNa47Vdp3xf9IZO2KtJ0WV9kKliioQ+aa+N3KS5GOS/ZrQwBliNx8j
 C8Z5nGfXBxp7eJnzp/fYXnUQguiZjjN+FEHcaCR4yoUJOR92ubZW2tlxxA2BvP/xX/WLLGdHqQY
 44POW6VekJnYrh3IBO5esyTEQhDa/9yH4zLZAgy5bggylEhJi66bjEvW8okE8tL6rZkmuEUb1el
 RliDww/Gsb53AktK+uwIP7eHRf7QUVpAscKJpqP6sAuurOKfLg+se6pxAtAEM8xg69qIX+eSS3S
 bm6aCLsg3uWV5xeAC/MMxkCGgCBSbFpJ+0VogZqJa51X3UMPI=
X-Received: by 2002:a17:90b:388e:b0:38d:e658:5959 with SMTP id
 98e67ed59e1d1-38ec6495933mr131384a91.5.1784749622472; 
 Wed, 22 Jul 2026 12:47:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f42bbsm9287280c88.14.2026.07.22.12.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:47:01 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v4 4/4] rockchip: roc-pc-rk3399: Enable redundant environment
Date: Wed, 22 Jul 2026 16:46:38 -0300
Message-ID: <20260722194638.1285159-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722194638.1285159-1-festevam@gmail.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784749622; x=1785354422;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=029kwIRR1LkDpW4sRuEak4mvKtga4/w2OQWlL5AUdZo=;
 b=GfIEuuAgGp72LiIk5O1aYJK9VctPVXzITfMIpmCYYR8jaawBBBV2LsTTn1QPybULVd
 bd9Ixv3V0bWdeTH1JlyI/AWDrDqTanv4OzZUSAy7t0CAEwZkK0E8G2mhbpCduUqgW8Ot
 xA2AfGFnvsfFlggWCBKxTK8o2Tjzh/2x2MIEsnGs2dH76/mo38OaFupqIzEOy/8ECxl0
 lpCbiXMOgItaFyNrekjzvMyHEH4kqkioxXSIKYCCrCC6sidxVby+lnLWu2dEXymxob7j
 mlH3JDGymJ1lIPZG5rD9nAvHnze98FQE2WXSUASRgsQaQ3f0EnAIASD7uU/JksmuusaI
 yY0w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GfIEuuAg
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Keep the primary U-Boot environment at its existing 0x3f8000 offset and
use the preceding 32 KiB region at 0x3f0000 for the redundant copy.

Both copies are aligned to the 4 KiB erase size and together occupy
0x3f0000 through 0x3fffff. Redundancy protects the environment against
power loss or an interrupted update.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v3:
- Preserved the primary environment at 0x3f8000.

 configs/roc-pc-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 53182dc8251b..4347bab598ab 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F0000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -41,6 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0

