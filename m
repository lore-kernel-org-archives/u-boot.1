Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6769C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 22:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7C788AE1;
	Wed,  7 Aug 2024 00:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XoxErKoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0E488AEB; Wed,  7 Aug 2024 00:12:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152DF88ABD
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 00:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCB5F3F17F
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722982310;
 bh=T8C4fVX84FXgvZITdxsSBXKeb/Uk5Abciz/iXNmKo4s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XoxErKoTtVftpky5KXuRxJKCbMMCWAaWsZR2eitLfCpd6vZRBuuYcTI/C9mgqtscb
 mXISW854j5NaqxxJkojIJ9nlf7sQDcj2mtaHaHkcNZNTWTJo1RtsHMLzQ4zIv9OBZM
 +cNmVYrRmWNaFEbYyv9D73sc2FyVZvr1k2j6m1WNRxz8+FR+qSeKMRfDfr1qxrQS/q
 +TQOaLhO75/5oE5K22naBoLLt2LbxLlccLY3YlCC+KRq6pd6zAkDSBlAo+3BT/yD4k
 JueSHpEkJrkEGZFqLqy1Zqa9wUI4zhWvS1jkmj3BxGbgQNOIrn357wmZAndJsAkB3O
 32PqRc0Xa56fg==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef23a67c5bso11821931fa.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 15:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722982310; x=1723587110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8C4fVX84FXgvZITdxsSBXKeb/Uk5Abciz/iXNmKo4s=;
 b=qvXj9UdBAE7yTvvvzwTx410GxjxlUFrvtg9EOZv7hqowxe9NS8xIKyLUfooi2QBoS8
 d+UGR4htDa92ZiK0LlLmH0gbaNlSuf+Wz46t2e4oFfTV1P3qZMKmfpKNPIBZTuPDAQSu
 jrs3V2Woi26BkzxwoPjy5WSpDxx+6pWZRm9g54+ixRhKkxhuMPwuVMvZC8p6xP/olHsZ
 wKAbx4wnz6VwoLFJItU37XN6E0j6ppheJbWqwT6DwAeltOW0kHWAsAxfdIab+IrfhAdX
 hi2HBJKH4443qbC1zrm3VeaR6WV/21umLwWgRqczmqkZ/D9QiYoQBjPJSEQZONDbgkZK
 NlJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDmC80zeyAK2wKDMu/ybqsBCgu+obN1xVkzlpchGVQ/Msl5YEKiybU+1vC8BVJaL5g7JoiMgmFdav5nrn6Jtm52qWcKw==
X-Gm-Message-State: AOJu0YzxFX4t0KuIa4wyVYE9NwgqZadlCqcZ3Ijno32sHqT5NMUF2A2q
 coq3bEpZK6TzqugcocODuXh3u5jtWHatx8Z2Op1SLPj791msdZDIdy/BHN67URm8WcO221avD5/
 vx8pKUEW3l3fOonppQ8fbhPXGcC/TIsgESeWxyOIslt5WBQgyxPx6Hk1uQuGIg10MTUY4yM6jLR
 A=
X-Received: by 2002:a2e:6a1a:0:b0:2ef:295b:4946 with SMTP id
 38308e7fff4ca-2f15aa87067mr110609101fa.4.1722982309970; 
 Tue, 06 Aug 2024 15:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbPGq8ZNAK2KO3pWarPczeQvLkTIMwweQyjy4EQcXlcFZFSGyJ4iqPf6Q5bW7GSh/h/6GPKA==
X-Received: by 2002:a2e:6a1a:0:b0:2ef:295b:4946 with SMTP id
 38308e7fff4ca-2f15aa87067mr110608991fa.4.1722982309434; 
 Tue, 06 Aug 2024 15:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3031:2e0:52b3:22a6:b8b1:7d3b:dbe7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290580c496sm479985e9.42.2024.08.06.15.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 15:11:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct description of efi_get_distro_fdt_name
Date: Wed,  7 Aug 2024 00:11:38 +0200
Message-ID: <20240806221138.210530-1-heinrich.schuchardt@canonical.com>
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

Use the correct function name.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index c5ecade3aeb..f882622fdad 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -14,7 +14,7 @@
 #include <vsprintf.h>
 
 /**
- * distro_efi_get_fdt_name() - get the filename for reading the .dtb file
+ * efi_get_distro_fdt_name() - get the filename for reading the .dtb file
  *
  * @fname:	buffer for filename
  * @size:	buffer size
-- 
2.45.2

