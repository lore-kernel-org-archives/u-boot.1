Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEEEE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6911806F4;
	Sat, 11 Jan 2025 01:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jdAV/BOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74E780786; Sat, 11 Jan 2025 01:01:56 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EF7807BC
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so67410039f.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553711; x=1737158511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhDaDPw97OFhuvkVemnAE0kR+gd2M32irzua9SKwE5M=;
 b=jdAV/BOlel2nyBByvdSxXimdh8IwI8AjSD1SRCiGWG+LFBRVLhqLx0a63ZWYc7tGFP
 E0qjolWys8ztpdrnTbLmYU924BV1Qj+D4+RCZkcRdff424/JgvQ1S0HEuRvrJONbMb3W
 3ZbUvTBB4VFjHtl7qjG7jKBvxU0aUmxouX+i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553711; x=1737158511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhDaDPw97OFhuvkVemnAE0kR+gd2M32irzua9SKwE5M=;
 b=Mh35M1cnv7+j0QAWLpVbLKyG45LA8BWOUtPqRQugVYbh/z8QSrwNHSpFQLi383VAkM
 R4+OFVRsIwSAgaAajXZP4vVxkjXe7xBkxSgokg3nCkzGkJD8Ko+VZMcAv7DXCC0fArxe
 NGPheN0yyW7SW3Jl8RRItDYYEbprD5VGpueAd0+l5Vgki5zV58H9KOAsLNyD3HlJKf4T
 31D6m8iUAD3c+tiVGGRmU4eEeoPjghc7EpufGwIb6ufZef/mlQbtQKM0OZ9wmq8ILMtu
 CvszF+wts2rL2lj61uH6f9I99B07L8fX4FDscn5OVPbKVov75mY6uWBPwD+vNAnj0Tlw
 vO3w==
X-Gm-Message-State: AOJu0Ywc2ERlqitVDh1LEkZBWoEEz2n/ITagIVUDtBZhKkfb15sTGz6m
 SryuTIaOVHfKcrHWDfgv4X7V7anuTzFg/RSPSsxKHZ1cXdRSAmVTlKJLDbMb7UznfUTfVcrTVJw
 =
X-Gm-Gg: ASbGncsZoaKuU9qP/IB7SJQaoVTWipy0WL3kWeHj9yY6XBHHp35oJRT2UoLRIXbBTA5
 zql1dumZyqSYefLoqbsfjM6QUDBXSOSjA/M+RvVeAtvOQlSOPS9SAeJg6tP7A5iDDEYzXFKJHDH
 jPrSIWt1SPOBJ+XlRCWG7laRHe9FR89b+nPIRCbLRUd/FC2di1Vfvw+OOQnHEAUzKQpPySgorYK
 nyh/W82U6cnjnaBGz/JFJum4FxxRW0G/Oo5x98DYwFPKGMqCGiXalNbzYX48MqpdhPKMLoewbMQ
 foFqwZkF/x5s0now1w==
X-Google-Smtp-Source: AGHT+IHZnODohQ1VxbDiTbx1yIpULR/BgzCegb09YikOiUyf7ACCrcHP0vp8kys1QX8EH4ZZ2w8KIQ==
X-Received: by 2002:a05:6e02:1d0a:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ce3aa5b1ddmr97820945ab.18.1736553711018; 
 Fri, 10 Jan 2025 16:01:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 27/30] x86: emulation: Enable bloblist
Date: Fri, 10 Jan 2025 17:00:26 -0700
Message-Id: <20250111000029.245022-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Add bloblist support so that tables can be generated and placed in a
bloblist, then passed to a payload using UPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to enable bloblist on x86

 configs/qemu-x86_64_defconfig | 2 ++
 configs/qemu-x86_defconfig    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2771a4b9e19..792ba06c2b8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -33,6 +34,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 947d15cd727..0b0e10c795f 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xFFF00000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -23,6 +24,9 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
+CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.34.1

