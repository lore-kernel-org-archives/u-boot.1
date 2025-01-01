Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB6DE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE1B80352;
	Wed,  1 Jan 2025 23:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NKOpQ0hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE1280379; Wed,  1 Jan 2025 23:22:08 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EDE88031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso142306415ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770124; x=1736374924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j/igWgf/WmW6qsOC6khjUe+FbenpNaMkuXDGTDypaM=;
 b=NKOpQ0hBlmIiKsX1jtIwWj7ytqO5RC6Mq9vvXwUGOvVpMhG1Qm9Fn2CMue7ULYZZqL
 rFD/TJEzOh1damOMYh1QIcLoXyox9vTZlB7oMZmZ6TNXGF7hWcW8nLpmY8WftkSCOk8E
 JjUHDSJNi8fl9F48RNQ9DofrXQq2AOc27fN+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770124; x=1736374924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j/igWgf/WmW6qsOC6khjUe+FbenpNaMkuXDGTDypaM=;
 b=LZ5IccogBXIitY0kHKO2UsuAZdonamynYS0h6a369Yl2zqboBdGBmndqKEDHE0tuDv
 4Z5nUkH4LtSDsOWkhfZ0sL56BoXpb08XqdKw6viKIvHnj5KhQPOOUK4ubucdERJRnrZb
 1IihDwsISaaSsfBGCjGeexN3lXJKmlCkUjgDPqbr+UCDUP4lDCtsiHNGNq84VlURwaD4
 CM14/HrSLIqywWQwSL1iWqzFVshFa8tEIqRn+6KHb+4vnXJ6XDOH6cUmzP95ABeo9pV+
 briVHTeiiVEcvvnZgI9CoO7Vi/7BPOWtD2ACY4SRw0yN6hfSB9dxeX/aWoOd5JYPb5QV
 M8bw==
X-Gm-Message-State: AOJu0Yxk6k3GecneNmI4z3f35U1LWrpcOdkqBPBwbHUfcwwXL5H+pM9M
 SEPNr0LJGXExcJD4PJd07wNq2N9GDYm78JWHnKfYYQ1Vs4eDXtJQLaJKBjF6yEQo7FZvzzSv8pI
 =
X-Gm-Gg: ASbGncsL4KhqsQ+s7ZltIffHyIQn2uRjb5ZjprP02eb1vuAEpeFbSxr9mWwcWX664cF
 zpmEVIwZgoAWnF7zcWHsICRAdLw+h2MugAHqYwgmtIaWVSDfXn1uVipD6jEMceLDbNGmb1EQmVZ
 5FdkYnyZOYyzkqp1Ym8pskJyZniduIJFpaUbCrYqx7sC/n5+7ZXBgg/cMZcJOBz5uTn14xB3UNV
 FVG0fbe+PWJjnbkv6Xc3oNaDQOJo/1osxR+cNoFpA8Skox+7rU0XMw=
X-Google-Smtp-Source: AGHT+IE+w9yV4tTa/MtlxKK9Og0R9yDRp/cn6XQR53r3dRQYYgzZ3JHGgHTMXtdQx8PJDL3Mpx3dow==
X-Received: by 2002:a05:6a20:d43:b0:1e0:dcc5:164d with SMTP id
 adf61e73a8af0-1e5e045824emr79021378637.8.1735770124360; 
 Wed, 01 Jan 2025 14:22:04 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 42/67] upl: Set bit 32 of the address when using ISA
Date: Thu,  2 Jan 2025 11:09:28 +1300
Message-ID: <20250101221003.1944600-43-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The convention is to set bit 32 to indicate an I/O access. Do this when
using an ISA serial port.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index b0246f72597..a5a1da9cb57 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -62,7 +62,7 @@ int upl_add_serial(struct upl_serial *ser)
 {
 	struct udevice *dev = gd->cur_serial_dev;
 	struct serial_device_info info;
-	struct memregion region;
+	u64 addr;
 	int ret;
 
 	if (!dev)
@@ -74,10 +74,13 @@ int upl_add_serial(struct upl_serial *ser)
 	ser->compatible = ofnode_read_string(dev_ofnode(dev), "compatible");
 	ser->clock_frequency = info.clock;
 	ser->current_speed = info.baudrate;
-	region.base = info.addr;
-	region.size = info.size;
-	if (!alist_add(&ser->reg, region))
-		return -ENOMEM;
+
+	/* Set bit 32 of the address if using I/O */
+	addr = info.addr;
+	if (info.addr_space == SERIAL_ADDRESS_SPACE_IO)
+		addr |= BIT_ULL(32);
+	ret = upl_add_region(&ser->reg, addr, info.size);
+
 	ser->reg_io_shift = info.reg_shift;
 	ser->reg_offset = info.reg_offset;
 	ser->reg_io_width = info.reg_width;
-- 
2.43.0

