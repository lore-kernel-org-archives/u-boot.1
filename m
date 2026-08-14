Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6698EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3081880F87;
	Fri, 14 Aug 2026 08:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sdtc7dlRxOMK; Fri, 14 Aug 2026 08:18:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D2FD80FAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786695484;
	bh=pElHAy51RdIkK8d4oN9y/rwG14pi7F/F8eZSva/5zxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CCmlcFi/eiNUYGG4IhDy6ySVi1R+SezNL5N8BRXJYhLS82sGVJVv29iYMUbQvBckX
	 ddOvsaNIV2E/gFxX3s8+06XXjLAg+j97kEI+YpDKlRzw/isjr5OPxQUL2DvV1Jnj09
	 SvTnuFu3/T+FFMr0ZTdVfd9wdgQVA981uSnX6hvBvilaqDWbcnWR2iM56YwUuf209c
	 z86duhqFlvYnuDsfKA43q/LwkRA9PiWStH820SXc+PJyWPsFkXIz9zCYU3Ji2hBuKq
	 35H3JfZatyzLPu5QmtjvQg+R4QCRNsdU2FrDXTeNILGewsZPcvvWq5GL4c3E9wRgzg
	 vkwtqzm9t6Pfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D2FD80FAE;
	Fri, 14 Aug 2026 08:18:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DD77139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F5DB80F70
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puhkbAycTqrY for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:18:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3845280FA8
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3845280FA8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aURwn2Dh
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3845280FA8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:01 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so10169275e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786695479; x=1787300279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pElHAy51RdIkK8d4oN9y/rwG14pi7F/F8eZSva/5zxs=;
 b=aURwn2Dhvk2sHlJA9QvTsGC8Rb4FrayGngISsiTfMJNvH57C4iBzpSTy8td2BZ9n1o
 RKmi07HC4M+nyv00EhqXD7E+u3xMA1BwnzB99sK1m7LKNIARYYpmg/bJj+XkNWAb6PIY
 GrkeC1xrmzP78B9KGNPgbqlQ/L5POtHmQ3gwD1/Sb/V+YM7aSkgMPA4GSA+M6BWmooV3
 xnX1/uqtiTnwcX3raJ4Npl7puSbafAvOxlutR02+OBi97kEMSdHDprbJ4Bum1Jyv06Gq
 ddVkpQutazWgF3FC4Ek3H2Ua84XnrM9KIucfrydQIq4T0HKS7l3A1knT0zZRQNHJSwBK
 z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695479; x=1787300279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pElHAy51RdIkK8d4oN9y/rwG14pi7F/F8eZSva/5zxs=;
 b=VtlSju+fpt/cNB5s2FR1GXpBfujanrq7ISxkihqk43/P/69YJuZb6GavxBnuMT6pKV
 68Fytr9AGSW7LeJW5yFkKSDG0BxjR45GeRpu3RUhOjC5RdTvuaOI69NN1gVknMNuwpSM
 Lvb5oWNUCyMnq1aSCrMaHG13UF57Zr0Y9tVFVnUAhqUO+jS812PbgfrqaicZydSmwU9m
 1n9Mw6XyBGgmdEOhq0FKPZqsHRfK47XOZ0xEOgcrLWiHbk54Ic1VheuVJ1ZmiFr3btCI
 HHpgKHzU6wS0o0X7EtsMvjscyboPHiAcC5URlS8jeTF5NYLwjR9sw+BAyNVilmJj1lkf
 TOvA==
X-Gm-Message-State: AOJu0YztvYj/RTlavu470e2phRbRnwfBU2MjKpL1TSFZFOAh/6u3n1Zh
 AXsej6OYgns1Tm3p+i+/L6FfqUfmka/GPeKNRXanJVFFB86ST7NxyxLWG+RSFuC/
X-Gm-Gg: AR+sD10es9jqz0aLIypN79ZUK7pDRM/2k9k5ZujYS97zA6OaPIswAglnuU51UEQ/lpT
 arMtI3c4kIplY06KLVpHxMgUIU3hEy1WXe2EKymlRSjyVswMclTtY399qViG+jOW3080EQzIruN
 Va52MsXFBM+MCGLytTzWB86GbtCJdWEurVe5Fneh4W11r5g118gGAqWA8kSqRRx8zYe0zAntvKg
 q7RpOiOWrXQfehZRD4Nf6vHJMlY2VhJbXn8OWad/qBEmF71v5clzAlHXVcDNrFBGyLHvLKYTDHP
 5BH1Y0Rap9MsPoaaAbRE/5AicK5xBM2ewPOaCBpe8nCQenD9tn+C7bV450HJyZeM+AXq5iLojLy
 A5wM7ASC0Woa3vAO/nLYJhYatiwaQTQhGUXQjrLSDq+6o5ZxBhQ9MwGMrKVeEjJyI32YLktfpzU
 UqxrwfiaNYihn4xSNw5Dit1pRzsMWnvkqcdR4jj3sYM6KOaI+RiYyrJzWu7YesTwFfbO/Cd8RIT
 V18
X-Received: by 2002:a05:600c:4e13:b0:498:11b5:3ff7 with SMTP id
 5b1f17b1804b1-499879bd2e1mr50731245e9.18.1786695479084; 
 Fri, 14 Aug 2026 01:17:59 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm33918625e9.3.2026.08.14.01.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:17:58 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] colibri_vf: restore the pre-2017 text base,
 the BootROM refuses the low one
Date: Fri, 14 Aug 2026 10:17:55 +0200
Message-ID: <20260814081756.2498285-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814081756.2498285-1-mehmet.fide@gmail.com>
References: <20260814081756.2498285-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Since commit c0f432c37780 ("configs: vf610: increase maximum size and
enforce correct limit") U-Boot for the Vybrid boards links at 0x3f401000, right
at the start of the OCRAM gfxRAM area. On a Colibri VF50 the BootROM
does not start such an image from NAND at all: the module drops into
the serial downloader, verified by the 0x23454523 UART association
pattern echoing back. The WinCE-era Toradex loader dies the same way
when handed such an image with its flashloader command. Relinking the
same tree at 0x3f408000, the value used before that commit and by the
vendor fork since, boots through both paths.

The low 28 KiB of the gfxRAM area are evidently not usable as a load
address for the ROM, so give them back and correct the size limit to
match (0x3f480000 - 0x3f408000).

Tested on a Colibri VF50 128MB IT V1.2B on an Iris carrier: cold boot
from NAND, both text bases, one build apart.

Fixes: c0f432c37780 ("configs: vf610: increase maximum size and enforce correct limit")
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 configs/colibri_vf_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 5145e947e88..beb64189d5c 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
-CONFIG_TEXT_BASE=0x3f401000
+CONFIG_TEXT_BASE=0x3f408000
 CONFIG_SYS_MALLOC_LEN=0x0220000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
@@ -16,7 +16,7 @@ CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=520192
+CONFIG_BOARD_SIZE_LIMIT=491520
 # CONFIG_EFI_LOADER is not set
 CONFIG_BOOTDELAY=1
 CONFIG_FDT_FIXUP_PARTITIONS=y
-- 
2.54.0

