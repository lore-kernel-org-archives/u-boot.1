Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B050C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38FD81433;
	Thu,  6 Mar 2025 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMoXdmZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4833581668; Thu,  6 Mar 2025 17:04:55 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 186C5805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d3db37f4e6so6873675ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277091; x=1741881891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=AMoXdmZ5v9BVkf8G3SBurQDBB2cUrfISaJjRFvhSj5JK5Z9Xnk6VK9qaUkq4zXniHz
 E9pqAPWTwHetRciGr46fc7rk5PaJNDAkp8YVr9ZCNBHWVQUfUgnfPm8ua39YYXYd+UVJ
 RLdYRzkGbNVw4vSfANHD+VzwlNQTi2Jk088l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277091; x=1741881891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=raWQTzuqX9y1Kx+cXvuhcmawqDdPOG8Rhe5SNvyfNJ5oQVo1cgD/521qJp41mymApK
 nzl9TqP3Xvch3xv6xyZDG1Z3UVOPCjlx7tcTlR0knOU5d4WViITganE3NO/VdP+TazHt
 bnd1+kQSYgncxKeeqe95SWDg5kR20kejlEoIiarsp1/UNGOJMHVL1QPNfNWnTpew63vT
 ewLLmIwvxjkD39kDemgSW+w1sUURjZPrVJH7et61ivBA3TLf4lR/hoX0lLrcOF+TTU9H
 i8yndSJkGBGFLvgXvc+b/keX7AJadOijl5xRSAZhWEQX7IKUnrHvFkxT0S/+MZ5SOv+r
 SFGg==
X-Gm-Message-State: AOJu0Yzr3GETpX8EOkG76Z7LkS7+s2+M8P37j+cdxWo+iq1PbdIPiNR3
 ZxqH5Hh9mwj05NB05TPLYMjpSwkjBquPWtNk5AEvyACzeGJ7yzC+j+atrm7/l9gy83SRBWOwv48
 =
X-Gm-Gg: ASbGncufiwwRfPap3j9vsrXj5RkGY36hteJH7Crj2tZDotefRwhd0bRVFogjiDfLcGF
 5wJ2hPBZYPP+7iX7tHxcwAmku4XBQny8lbPeG6PB4ef7LGIEUTA7E0gLWMLlDwMdxKOdbAOWzat
 szT2yC6MAAGTu7Ki1pVym59L9DuT2QEyWUh/J6zDWVmV1SBnftsHq97AO2ITXfuJTDs7BCf5ddp
 kiX/uuT9dvCZOitrO2IVcatUXmifhc0fkYLiwW4P6tBLsimEWsHeK0fVbZ8YExtFBnGI7NscSH4
 D2e/pBvBDvlJ4QnJVrWbdMD6aBs2/8OIJPcEa0MIZhC17JB7mzlPrDAiDjZZ0v5AGKGzAeFWoym
 Mqj7L9g==
X-Google-Smtp-Source: AGHT+IEHoRbMPwTnHpDPcG/zy4ub15op6y6hB0H5sqrByUUYw/NHEz/nuI8hGBP9wtFwSWLaOLqBCw==
X-Received: by 2002:a05:6e02:2168:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d44193d992mr391015ab.7.1741277090692; 
 Thu, 06 Mar 2025 08:04:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/47] x86: Expand x86_64 early memory
Date: Thu,  6 Mar 2025 09:03:30 -0700
Message-ID: <20250306160428.3041057-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The SPL and pre-reloc malloc()-space is not large enough to start up
with a display. Expand it.

Switch the order of SPL_SYS_MALLOC_F_LEN and SPL_TEXT_BASE since this
matches what 'savedefconfig' gives us.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 792ba06c2b8..af275e8ce8f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,13 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x1800
 CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4800
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.43.0

