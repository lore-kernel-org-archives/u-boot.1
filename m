Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE48C369D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9736881FC6;
	Mon, 21 Apr 2025 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IDmxkt+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206E08197F; Mon, 21 Apr 2025 18:26:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEBD817C4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F41841A0F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252784;
 bh=Wymna1SiKN1W49fv/Z2U4RSxlOGzloK9fNlbY2L5G6k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IDmxkt+zW9Jiuo+tnkYoCQJuhPh2WZ6UYbm1XpiSEEjPZa/8FsIjxFZmAqDPNkRVR
 5EkGeJk1pNmj5shqiHKkyn2Q65ZO21WYzrs6f+PRfKvmziEa5qh4mNIKTqP2KOTxOu
 1627Eivfh3PkWcecBPvctx9wH4OEOPJJi7XbfDX0IgWirox97Uvr01t7LRzqMBTpLA
 1Wg9LmoU6Wv0aqyYRmJ2X2f+CwlWf6iIHQvUttZ4h9hPUzumHBRoytd/46+eKbTi84
 S+jS4O9mLZfUIGOl8jntOJa6tYML/iZfkVHfxqroK4355qkc4uLl55MEvk5jD2L5gl
 6KjO22f3X1RWw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so23093925e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252782; x=1745857582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wymna1SiKN1W49fv/Z2U4RSxlOGzloK9fNlbY2L5G6k=;
 b=vOPg43Crbna/LQ+5TEbPuPUAId2/BsRQiAYa4vrjua7mhyUZktV7qXedfcXOTLiPbw
 RDWpOYLm+vHFs7O2BM/ODMLtbMQve0jQPukiqqsrAqmPxqNNO/Ka93txJqmaEG9aBxDt
 kLVFH5GpsXfmkZYu3aK7I3L+MWRYnGy9E6vzLCpO3cTNaonQxqTYwtD8wVXDEFQXsQlG
 rj9pP/YfjLfQCT7H7Jy4qMCAQVi+UbW9kB4UtB+wHFTyf7PCoACEkV2uFHAhQ5x0pf6D
 JDSjD2IldzML758pUaFIIrHHZDgMBgn/4scjB3fOF6yynXgezOEB+Cs1zS7cZC9mO5Uz
 Bjfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA31f1kOg01L7mJ2ZXboP9JAvfyI9UfM+AcCBv4ydKsJY4Cn9lL/djV9TQtZ4t1MKtuasMdEM=@lists.denx.de
X-Gm-Message-State: AOJu0YxF/+moKboMTeq77V4HNRO72FdikpSBXAiGqGxsu5zv2BQ61DEu
 0O9S3Gp0IjvThImD+viOriLdQJshmYuDzg5lza0hbZpjZQH8XBaiICjM62a8dGoGTygt3JkSr5j
 CJD1H5nj2mAebJpaMyucpMQYqs/jhGHVxBBAVejHTakWKljTaqC75WwT6676zxauQ+eY=
X-Gm-Gg: ASbGncvRHZj7MXN1ipMM8q4z5cNS9qUWfishzkarZZ2UezEH/StrxHviho2rHbAM54e
 WbsWySSMEIXTd/6qFuaiRIeomjbb2Bj32jvEqTzkMAGuQsnjo7/Cpw/jVN5irwWdYluSH+VBNNB
 JBTywg7gpxZB+RiST6Fz1LgdqjmYmnawEMVTal9aT+zTLPYJwLY44aJnfv/fTF53ETdlyTvauqS
 81IJBdl1CZxziFAuzbaxAxFT4qh1QjSua/pHP+WUNRyXn74JQCOJnnO2Sv3fq0JP0jFkUiskGBa
 k2lLFFbOgT5V/zAQpGCDwzuF3luIdGjPWUPYJqA+yuMf+UEGBgL2UdlihaLMWywoGDuL7RQOU8i
 Quv2gZdGoIFl4Cw==
X-Received: by 2002:a05:600c:198e:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-4406ab676e9mr111920265e9.2.1745252782491; 
 Mon, 21 Apr 2025 09:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi5301tP0O7ZxTGVErkAgc6ydoJ/EwePbX8j8a0KzdtuDABXJxsIinYj0MASSA2bK4OMhwVQ==
X-Received: by 2002:a05:600c:198e:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-4406ab676e9mr111920075e9.2.1745252782135; 
 Mon, 21 Apr 2025 09:26:22 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 5/8] boot: prevent recursion in bootdev_hunt_drv()
Date: Mon, 21 Apr 2025 18:25:52 +0200
Message-ID: <20250421162555.1200687-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

If an implementation of the hunt() method calls bootdev_hunt() itself,
an infinite recursion may occur.

Set the sequence bit before invoking hunt().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootdev-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3791ebfcb42..da757a49481 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -791,6 +791,7 @@ static int bootdev_hunt_drv(struct bootdev_hunter *info, uint seq, bool show)
 		return log_msg_ret("std", ret);
 
 	if (!(std->hunters_used & BIT(seq))) {
+		std->hunters_used |= BIT(seq);
 		if (show)
 			printf("Hunting with: %s\n",
 			       uclass_get_name(info->uclass));
@@ -801,7 +802,6 @@ static int bootdev_hunt_drv(struct bootdev_hunter *info, uint seq, bool show)
 			if (ret && ret != -ENOENT)
 				return ret;
 		}
-		std->hunters_used |= BIT(seq);
 	}
 
 	return 0;
-- 
2.48.1

