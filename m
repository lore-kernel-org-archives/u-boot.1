Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC1C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBC088823;
	Tue, 11 Jun 2024 22:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bwweXeHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A59A887E1; Tue, 11 Jun 2024 22:02:47 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8465C887FF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-37597eba356so14071665ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136164; x=1718740964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+efTwnbqAclrkOcv0sY5l3taj6AFXPXyErZ/eaktCgY=;
 b=bwweXeHeZNdhD4m9hF9axIna+v/0Gzqa6NWW2ailtEVJRTPR+3SV83JdB6tedMZli9
 uiF9jCe8wj0vQYw1huCqzqL30xre2lKkqhxe/BJoGW3yL5Bb0gXZmfDVlFLOw6jpZ5xA
 ya9mFmsP3YQkbyMfpRqd39psZ8c5d/ncHgFQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136164; x=1718740964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+efTwnbqAclrkOcv0sY5l3taj6AFXPXyErZ/eaktCgY=;
 b=pt/mdOHT1ggH8Orwa8lrO8wIc6KyqZD0nL6zRrUvDJqiUb7ZMVjaODCY0MUJzJuk77
 aM6b1y4cuFP9vuHCWzIy7HcEl3/OMvPDlZw26TFRyTPPySHMDNK0gmUdbbACjCjBLH52
 vaw7EV5fK2krtrAMgbcbrQjgCKqib7c0//ZMgDqez6DucBGYApbt+GccRWBLn+kVaB6T
 JlO/MNZVnIDqLBiXwz+CevYy9JTCZmyZYZuEEmf5cAnCIfNzp+5D+ggCIJgkLNwdUCMf
 nObnihNaOF34e4r3VkiBfQ27DSkks9utksYDk9GVDbF70myEpMrcmFmrnsylhlrfdjHW
 GGCg==
X-Gm-Message-State: AOJu0YwS/LTaF7AhRJ2QF+Z7n7CQF321/s70MhyoSp500+t5jk9pTS1/
 dAbH3sMd9pqDWmLARDWJ5u+VOdgHY3J4wwol97Qt0z41iSSvI0oExpOYxB8CnMV5uv/C3oBVNyI
 KuqAs
X-Google-Smtp-Source: AGHT+IFM1CKR/cpcdUjsMg3TKldI2dX+bKnElQTjCq1NJCxE4OwvUCMwm6Q484YevtVsVidC9j9GSg==
X-Received: by 2002:a05:6e02:1908:b0:374:ada1:296b with SMTP id
 e9e14a558f8ab-3758032247emr160896835ab.8.1718136164286; 
 Tue, 11 Jun 2024 13:02:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 38/42] test: Fix mulptiplex_log typo
Date: Tue, 11 Jun 2024 14:01:52 -0600
Message-Id: <20240611200156.2245525-39-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Fix a typo in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/u_boot_console_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index eda48cd35f7..1b00821c5e9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -97,7 +97,7 @@ class ConsoleBase(object):
         Can only usefully be called by sub-classes.
 
         Args:
-            log: A mulptiplex_log.Logfile object, to which the U-Boot output
+            log: A multiplexed_log.Logfile object, to which the U-Boot output
                 will be logged.
             config: A configuration data structure, as built by conftest.py.
             max_fifo_fill: The maximum number of characters to send to U-Boot
-- 
2.34.1

