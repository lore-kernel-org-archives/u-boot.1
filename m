Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D8D32D8E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE673893BD;
	Tue, 12 Nov 2024 11:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LiOCHhSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F2F893BD; Tue, 12 Nov 2024 11:42:54 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5700A89227
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE82B3F2A5
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731408171;
 bh=WjjNkEruQiPOXxglMz4yDuva2qvXZZAKeJvnqaDjzXM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LiOCHhSr9AosvaYPZ3ZwIqiRDDK0fBcYwE+3DApMiYxK9A/kR4QI6iHkwRzHEB8D/
 8FfNLdUgV2Ufwli5ji2C2BA1U9fnBfnplTjJogG9eD8GhCxSFsTJmXawkzmey3nh30
 YQn9qWdQOOsKkRdvUfXikOEa8NA6Nfo9znNSlBtcoK7aA+32kYQBb/iadXr8pHhDhs
 JMnWehJZb7v1DJJkiIHq6LfYnUc2YL1haRpBKqmPIT8JgHNUWdM33ddT1fZ+FUR6OC
 CFAQJgZHVRaGjyNoidqtX665oP1sNG32Ukqde1PzwggW013OT1sTtxaJSABTp6hkFX
 9zz9yDl50rZ0g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315544642eso42543375e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731408171; x=1732012971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WjjNkEruQiPOXxglMz4yDuva2qvXZZAKeJvnqaDjzXM=;
 b=xMDe4CLDswba6PstxhJpsgSwF9NakA/ge7/29XV9lnzcfvTdpaF0wDfxUQ5igBF+ut
 1WjXVCRe2azwjxR5jfFCV47hm1bbl+oOttZ0JdR2UrsZljbmrJUjTRf0m2IxLKChgf1t
 7+RDIFVE4DroL+oDI0v7pqI8ElViAjy5+2NjxXLwtNDbYE5S3u1IHiAcKe3IRQ+mNnDX
 89abe+6RYwjKH56tEStSMcJDCZMvvpkajwWxT8XjzcjKsTUHcXxOmuKUtrQj0czUA3+X
 RdN7y3UX8p18ULsIXWNhk1lzKI87c+ykMgNpvpsu8PRjp5YDM33G5jMKKnSBLwe/Inou
 isnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQHq6JToHWU4E6iqENEDNc2dWF6bQDrLcifSj24P6Yr/uTu+HaMaJRF4cNOmTVLGiYMVZXRc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy34tC/bcrbD3VnX9rHfMi6A/W/82g1q59zEIufJ2bS/Qu4u12E
 KXuMWM3MG42fJ8fObQxRIBEzKZFpKkIxU3YN860R/CfqcpjDIM6wU21gWAo7lEyRXBk5yAYQZOS
 4Zd1QKZ8ahqCDWQA+1xy08tph5GQ6xbzvj8SDrllrttauQnGluJGEmPo0HPWeePs0kl8=
X-Received: by 2002:a05:600c:3b8d:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-432b751b65dmr127910155e9.23.1731408171368; 
 Tue, 12 Nov 2024 02:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNMJNOJe/uS5YVEsaoNXLFMyJpEt33G5vNfG1+wfhKEBKx4wXxri4aOOv4utG6MRIxhlm1eQ==
X-Received: by 2002:a05:600c:3b8d:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-432b751b65dmr127910055e9.23.1731408171072; 
 Tue, 12 Nov 2024 02:42:51 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed997313sm14996400f8f.53.2024.11.12.02.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 02:42:50 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: SiFive Unmatched: enable 'env erase' sub-command
Date: Tue, 12 Nov 2024 11:42:23 +0100
Message-ID: <20241112104223.41927-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

With the move from script based booting to using bootmeth a lot of
environment variables have changed. To always use the default environment
it is recommendable to erase the environment stored in the SPI flash.
This can be done with the 'env erase' sub-command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/sifive_unmatched_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 1ea744ffa80..565373ea04f 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_EEPROM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_PWM=y
-- 
2.45.2

