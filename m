Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2081C2BB85
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54989881D6;
	Tue, 18 Jun 2024 14:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F1jIWr7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD2788271; Tue, 18 Jun 2024 14:29:20 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5AA888137
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C6EB43FE0F
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718713756;
 bh=Mg3T3XVUyri38CW0vnpjiZ07/sgNbkul9AEgl6bgtJg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=F1jIWr7OF3reJ4UZwjhynUYUElfCoo2OTbFORBYO8ZkW2LuebpoheF5DmYeGqBloB
 mion8zlmLPQB3cfDett1L0H1nLgw628ZGStMEJqFifj0CtiLIN3oETshEJO6SeA54m
 iKA5DNkPfEyvrj51D/gs5raSGzF4iP5PKcfjXglONqctKaPT+elxoABJH6nWld1Cxl
 3zkDOkcAyv2jKE6LK17AU7WOWxxbD7i3iBryiSwUdS6F/n/+MWomMno77P+qKHGQzB
 06/r4dyMsnYa9ltmaNZXiKq+R5qcAEhedZ26hWnUqxVV+CyGdOd5WlJHCcACee2XyR
 h7Qnfgu9edc7Q==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f10585251so2828144f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718713755; x=1719318555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mg3T3XVUyri38CW0vnpjiZ07/sgNbkul9AEgl6bgtJg=;
 b=on4xbpLRXdW3MMa/Ph+e4ZnPUONoklml6xFgpY+FM3RWDXLWlpUTBy8MB2jWTRiD2Y
 /YerY48kT33MLPGjd/lB/ElY7MIrB1SiQdxSxV1cwiVMCzGwOO+Z1lBCWiNTUVxvtlV4
 L7D3u3SaWSmbktwjh8kWsGGAlpsvXNIP29PnT7Pg7tpCkJ/iNvNmddP/qU4AZ9F/1D80
 ZqLsDFzoCH2wsRAZd3agFvBnssEdw/1ZhNULnuLY8n3NMQt6DuIRomhyMFZSJz7gd5m0
 kbfPvFj5C2y23a+b6Xn6OKNrnlEcEolxdydaYuK+UJpjR+WlTO4X1aZ0MBNf7IgePYS2
 XJEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRf2+LDckKRvBQqx59CRofeT4+4oJ/iJB7zEvBWUQl2kXXoHdTBEV0OR+2dA1coZynXYT0ZH9WSCRuxMlcn8P1aAL7NA==
X-Gm-Message-State: AOJu0Yzx3hmWT53E5VrEuBEVzCHwDzxmAsTwZWowpXyleK6NH2HVtswL
 5m9s7OhBWFQnEq6Pxa9HoEITX50pt4orLXWJ7/erJdSSr5Q0SjKVEy2HmUH+msM8/ihKKw6kW8f
 c7jxvMUuOShqBeGry2kkKxHOi+Aqfc3GMRZumd/nGLm2l7/RryFIav+K38BMApy0z63M=
X-Received: by 2002:a5d:4535:0:b0:35f:1c18:347d with SMTP id
 ffacd0b85a97d-3607a78da32mr8584586f8f.63.1718713755753; 
 Tue, 18 Jun 2024 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfOU52QbhnPWQBFeUmTjtKLra+Hmsegudk6Lyc9tQ2Bf0h9x2Kg+Z0A0B8fg3z6jUVsfaZBQ==
X-Received: by 2002:a5d:4535:0:b0:35f:1c18:347d with SMTP id
 ffacd0b85a97d-3607a78da32mr8584572f8f.63.1718713755387; 
 Tue, 18 Jun 2024 05:29:15 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c785sm13962062f8f.34.2024.06.18.05.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:29:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: correct kaslrseed description
Date: Tue, 18 Jun 2024 14:29:13 +0200
Message-ID: <20240618122913.127692-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
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

The number of random bytes generated is hard coded as 8.
The command takes no argument.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/kaslrseed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index e0d3c7fe748..e9b0e3d5985 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -68,7 +68,7 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 }
 
 U_BOOT_LONGHELP(kaslrseed,
-	"[n]\n"
+	"\n"
 	"  - append random bytes to chosen kaslr-seed node\n");
 
 U_BOOT_CMD(
-- 
2.45.1

