Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8286AD42B83
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521B78943F;
	Tue, 12 Nov 2024 14:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/wW2BbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E086589457; Tue, 12 Nov 2024 14:59:35 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4235893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83abcfb9fd4so219188339f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419972; x=1732024772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NI3FtHWlvIvcTd3+n+RJwzyPhq3FJPy+RgLUnUdaoI=;
 b=k/wW2BbFv0KHcQGjLwFGs6uni6xPoPC/oWsLD7BEH0AdZ4nR4j+2pC9yYwWO0jLvwh
 DMLhD+yy/1MO6BNEOTlBYFcUs+UTrMqU3XPhCuna2R6mSHyU3udXdyT3z74gZl25JZmj
 9x/cQxinOTAuXUz4/s1DpjWBXfJmhg7MVplkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419972; x=1732024772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NI3FtHWlvIvcTd3+n+RJwzyPhq3FJPy+RgLUnUdaoI=;
 b=sPQPWEQc1u/uo5NK68EKYwJqu9FMBe8E77wIApGNVZXKxOP8r7U1L/T23fxeiJJBBr
 6CHMA+hg8+PQl0R7coK7lf38iGzWKxe+T+9rBI0K/y0lZt6XJ5kW4/atfI76VB4mpAnO
 Db64wse86SAra4Oy5EbvtkN1ScU99M2wVA9uLT2oJs3C3Sd7/T7iwYELoQXnbLxMMpuE
 82anKsQDZlojCQlScagqqB29V4B3P7eNIBZHOBlMTbPKcr92smoI2Mfyv33eNlSif/gM
 JKExufoXRpmcSx/y0KqsGoR8ljrrRpm0c4TYmdncYSmZpUOkj58PUtSZe1vSllbUGnUC
 ypCA==
X-Gm-Message-State: AOJu0YzsWfSSP59xxTjMOVcV7rhmu7EwByNigM3Q7zbxEW5fMyPL0bOd
 lCrihSd2iw6aabFfnFHEwMRkqqlfYcnfGEkKLU398Va131wv3nTH+H1eI6NO6aGUI8eKGJqsYuw
 =
X-Google-Smtp-Source: AGHT+IG2JtaSqU+9/sDUtRtgOQMU3xTXeIgFJA94aewagm5xB/cY4KlhDiCFL8GIJxHk5JMGhrTTGg==
X-Received: by 2002:a05:6602:1350:b0:83a:c4e1:7d50 with SMTP id
 ca18e2360f4ac-83e032a16e9mr2057337239f.2.1731419971974; 
 Tue, 12 Nov 2024 05:59:31 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/18] x86: Expand x86_64 early memory
Date: Tue, 12 Nov 2024 06:58:55 -0700
Message-Id: <20241112135911.630586-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

 configs/qemu-x86_64_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 008eb46a01c..218c3535d15 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,13 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x1800
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4800
 CONFIG_SPL_TEXT_BASE=0xfffd4000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
-- 
2.34.1

