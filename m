Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3CCC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 11:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CCCE87DAF;
	Sat,  2 Mar 2024 12:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLM3Gsqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB6387DCA; Sat,  2 Mar 2024 12:20:38 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0208A80AE2
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 12:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412d67e4ec1so2038885e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709378436; x=1709983236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nhdwVPY1BBiSG+paRc438/4JnZrYkdVWvhDk1vhc/H0=;
 b=MLM3GsqjK8HqHjzLZHcxwtRrR/0o40GON+ENHa38b1nFLuzNaG/ixq1ZAjuXEqaEF5
 YmcM+c+gzkA/pebpTAXgC4XQdwMdGMjkqbrHgLYyz/jW4uygpKqM42KJiat4xxwjh5fD
 m3x7y+OFVsvYPdUCqoG/XW0nPBNba6hzPm+v5Rg1rx4VjDEYaCuxMZijiS8TTstag7Wv
 WeGNjzrgm9B9PzBnRp4TfvztHqglLx0ULt6lzDxKiV75n6S7Hz1V8mpP3xt6SYueZigK
 S3MW9OSvGoE0C9OeYiaWVOCJkS3q41CJYQayoA1pa9igsI7jNnzGrQFijGZpy0rjI5ue
 PsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709378436; x=1709983236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhdwVPY1BBiSG+paRc438/4JnZrYkdVWvhDk1vhc/H0=;
 b=nHOQBY/qSr0R5mbHmflWCH/S691Rrpjqz30db/TM2u2CVSiHfWEYFazgjNLva7Dl2s
 dBc8KOwMwuaUfSVTcID+rFA2Qhtm7zwzNn52WnCLEl8zOblyHHuNrQogjRkqzem868cA
 23jwtV1SU5/NX8G/DSdUn8VYdD5KTtOOBAzY0OOc8Si4qVUqn0x3mNhBlxnFSTe21xZv
 iFe0VLAUlTumJAut9mcQCoN8AeeBnoGA6VUh4sR0FQhTyuHQrYM7gSCh3iSq6d+ZEe8p
 kModZCmna8/4lgDyWBFFRptqJPC5Yu3w+APiBiinetKX6fKTUpPEW24ScxBd/6W/8Pe5
 s72g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSKnVu0RKhR+/aMowFkNAzsOZpSIFyUfv9gDWqcMKHhuaA/wEgYTmxvv2OS6xHkx9Wh5sEULx4s5CX7m1g5aI32tFRSA==
X-Gm-Message-State: AOJu0YyoRRIIsG2aCzCWnPAV7FX5eME2rghTAF5FyF/8XJhgthfx5Y1W
 NwBRJi4f0ieogjf2sylsbXDXJsvxc6eAw/dboR0TabiXfdaPOUIb
X-Google-Smtp-Source: AGHT+IH+xJcRC4mSh8d2G3VArCQwZ1EdOOwA4wRNg+DeRE3kuZsK+w2TSclnOlpX3Lx0gLfZQBXG7Q==
X-Received: by 2002:a05:600c:1c12:b0:412:9e4a:62d3 with SMTP id
 j18-20020a05600c1c1200b004129e4a62d3mr3329769wms.6.1709378436096; 
 Sat, 02 Mar 2024 03:20:36 -0800 (PST)
Received: from morpheus.home.roving-it.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 j42-20020a05600c1c2a00b00412db03f182sm392429wms.11.2024.03.02.03.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 03:20:35 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: mark.kettenis@xs4all.nl, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4] disk: dos: Add all options for EFI System Partitions
Date: Sat,  2 Mar 2024 11:20:31 +0000
Message-ID: <20240302112034.593441-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.44.0
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

The EFI spec states that the ESP can be any of FAT12/16/32 but for
compatibility doesn't necssarily require the partition to be the
EFI partition table ID of 0xef. A number of arm devices will not
find their firmware on a FAT partition with an ID of 0xef so also
allow the original FAT12/16/32 partition IDs as they are also
permissable for an ESP.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- Add 0x0c option
- Make hex constants consistent
- Move from if to switch statement
v3:
- Fix switch brain fart
v4:
- Drop boot_ind out of switch

 disk/part_dos.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 567ead7511d..a35181dff4f 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -40,10 +40,21 @@ static int get_bootable(dos_partition_t *p)
 {
 	int ret = 0;
 
-	if (p->sys_ind == 0xef)
+	switch (p->sys_ind) {
+	case 0x01:
+	case 0x06:
+	case 0x0b:
+	case 0x0c:
+	case 0xef:
 		ret |= PART_EFI_SYSTEM_PARTITION;
+		break;
+	default:
+		break;
+	}
+
 	if (p->boot_ind == 0x80)
 		ret |= PART_BOOTABLE;
+
 	return ret;
 }
 
-- 
2.44.0

