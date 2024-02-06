Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B13C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851A087C9E;
	Tue,  6 Feb 2024 23:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDABB87CE0; Tue,  6 Feb 2024 23:32:15 +0100 (CET)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D2A876AE
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-51149a45fd0so1019599e87.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258732; x=1707863532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+onfv2HKZG+Gf6Kndb8262dDz/qceLw8kOaa7MpYu7Y=;
 b=VpwOMzsUsKqgXSQ2tlTsYp/STNNI+iXugSMpKitixXqh813AurAkdHoG9GYkx081Zy
 Nnohpp91P+uGS+T6ZzY9Tm1c8vHLo0tg5dJJOxrkQm1GQVG6tPDl0TaTPZHV6pGzDMhf
 RuYIHZM813NZewR80684Ka++LiY5O6dXuey9Ja4tJM0M0CZ6Ny4xklouOCEjonWqfHYz
 7+eqFsobMf8zT8i3osXd9IrWV7Wo4mbXojuXj3YZf/hERnrz5T/rn5med2XAEe45mgrz
 ///z0XRccSNgRpQu6Nz1+gBXGCneRilUBIAWAfMbcNlaVvFwQSmci1AgYEOPNF0SsjOS
 j3ng==
X-Gm-Message-State: AOJu0Yw2TzfttIdZsSrfd/eg+KFR8EcWo81Ez/u5hwWJokLWORYKjT5f
 6p/Cdex55uZGUCYkUa4MxXrjamsM1l/boPNlGAh79eR1XSjhdp0mZs2pq7/iTmzrZQ==
X-Google-Smtp-Source: AGHT+IFHCePmOYAESXwoBmxZ904TXtG16dSrKunBP0h4dGZPOJ9fwjOrvKpA6rwK+khrRDTUpL9ZUA==
X-Received: by 2002:a19:650e:0:b0:511:643a:f6f8 with SMTP id
 z14-20020a19650e000000b00511643af6f8mr372211lfb.0.1707258732428; 
 Tue, 06 Feb 2024 14:32:12 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW35bFfMpMVO870w8BCy847JmSErl5ZRHZ5f/k29MzmQ0/Rk8tjUu+ey0xGx3kLQ3WpPe8aWMcB/XxyiFNhknXIDWWKzYnud/Ndn/UKv+QCDdKhjSQCiCxNLZU=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 b12-20020a056512070c00b00511609fb46bsm211416lfs.163.2024.02.06.14.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:11 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 7/7] doc: android: avb: add slot_suffix param details
Date: Tue,  6 Feb 2024 23:31:53 +0100
Message-Id: <20240206223153.3060433-8-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Add info about slot_suffix param for avb verify.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 doc/android/avb2.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a072119574f..c0b2bedb831 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -39,15 +39,17 @@ Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
 different testing purposes::
 
     avb init <dev> - initialize avb 2.0 for <dev>
-    avb verify - run verification process using hash data from vbmeta structure
+    avb verify [slot_suffix] - run verification process using hash data
+        from vbmeta structure. Provide [slot_suffix] if vbmeta partition
+        is slotted
     avb read_rb <num> - read rollback index at location <num>
     avb write_rb <num> <rb> - write rollback index <rb> to <num>
     avb is_unlocked - returns unlock status of the device
     avb get_uuid <partname> - read and print uuid of partition <partname>
     avb read_part <partname> <offset> <num> <addr> - read <num> bytes from
-    partition <partname> to buffer <addr>
+        partition <partname> to buffer <addr>
     avb write_part <partname> <offset> <num> <addr> - write <num> bytes to
-    <partname> by <offset> using data from <addr>
+        <partname> by <offset> using data from <addr>
 
 Partitions tampering (example)
 ------------------------------
-- 
2.34.1

