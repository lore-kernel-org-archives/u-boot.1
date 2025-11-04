Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0CCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5F383952;
	Tue,  4 Nov 2025 22:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ovYNODx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640EF83956; Tue,  4 Nov 2025 22:55:15 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7AC83936
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c51f56f3fdso3118802a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762293312; x=1762898112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=atfSHtLJQeZuDZ0WWS3tx+O3jIjpTnauMp9/d4p6Xwc=;
 b=ovYNODx8CS87/6Y0QL/vX0DMEkVkGLaHdZKXfAX0Ozn8V6r17UVUSlDHT4f1qkFPl2
 2Lfa5PsN9YNbTxAQfANg9B4ifPmgc7iAmeGfYv39LePh2/7hEIPq/5o54PXlOpx7CII5
 zK4Kctd0SPukyHK8LWNUqPH4CAAdh+ABC2yok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762293312; x=1762898112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atfSHtLJQeZuDZ0WWS3tx+O3jIjpTnauMp9/d4p6Xwc=;
 b=crZqp3xAZLwNxZVAvJrQWj5D5S7BEe3W5czdvV6aRur5E/UjxbZPbkgRRM4u8bQRWB
 fXSujhODlxeMYtJBjuWvyQDFKNSqtCtVeCIidMzfrnAmDeilw+CS2rdtkGRFQ6mACqHi
 RCKasrqFVJip46fiAlzcqzByR0hqs3zpcSaV+meoFkVdZzE8zyMBM/KTlkiNDp7nQGLe
 Z+zVyfPbN7pGJIRydXJw6SDBEQlfXTszzU2B4W16zY0B9PzWX4EMWxg8TuSMI95+phQf
 zpiK1cYf4f0qnZZG/4ivbHRn4/dOtMyt2Ut1DDwdDexdjjCbZBKZ/S9+de0bSlwwUx/j
 JA2w==
X-Gm-Message-State: AOJu0YxNz5WoeZEhCtn7zKLyjU02cqQMPMXBS/4xmmbMxZDKmHOTzcgw
 sgUWZdYf3q9mfD7RspFBeddm6wBTBU9ds0ubNm2gbhVaur4onmhsmXdr1RYuiS3p5wuuEVZjGs5
 rjHdbCPRBlA==
X-Gm-Gg: ASbGncuXb5DR1vcn+kEehRkOXNqyxCXFSz5mamDCKU1gGkBpvKSaElFpBrLFW2+ql04
 KHtH3PcIuL/oozYS4pD7P8xlGURqoi1bO3N2b6mSqF9IKhaRFIyJ7MfjZNaLzOE7Ffid6g3qZF9
 FXDLjNUc70Ff8BLvOdcbOJUboh/zOd9zaQz6+LdDHKre8T9qFpDD47kpykElwYrpAU1WEp6EoUQ
 iX0NAkW+E+RH0OPsa/PKyoPm2HI8etkQSXuEngwVx3g56T1UDTJ4BbfiavP0UNn85esyw6W2fN/
 Y03FrCtGaMpSg8ZdNncl2onptStMJs26iEGNsLoa9goQbVtcgdWpyanU1xSwO1UEfkP02KNwhex
 rnnYCo6og6ui5pvWbzrXM54tqVMqNY8hBNYjVVFZbr4c4mX53b8YZjyTRaVtkUep6pHk27Il+EK
 mCcpwTENGrW4+Gi4NXxWKBUheOn31M8/XvKzQo2cD9vA==
X-Google-Smtp-Source: AGHT+IEsfn3A55s52uXwEld8KVdOLpJZBRuDMBhaQgpz6D9xmenShoMJl7n8rzYENymx2/53c37w3A==
X-Received: by 2002:a05:6808:1510:b0:44f:8f02:d62a with SMTP id
 5614622812f47-44fed2e85camr427739b6e.7.1762293311883; 
 Tue, 04 Nov 2025 13:55:11 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd84952c4sm1038073b6e.1.2025.11.04.13.55.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 13:55:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH 1/2] labgrid: rpi: Rework the writer to be
 more robust
Date: Tue,  4 Nov 2025 15:55:08 -0600
Message-ID: <20251104215509.2371164-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to always correctly write the correct file to the correct location, we
need to first ensure that our newly generated config.txt file is readable to
everyone, as it may be accessed by another user during transport. Second, as
this is a file for the first partition, tell write-files this rather than
assume it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/writer.labgrid-trini.rpi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/writer.labgrid-trini.rpi b/bin/writer.labgrid-trini.rpi
index 83ce516..000c403 100644
--- a/bin/writer.labgrid-trini.rpi
+++ b/bin/writer.labgrid-trini.rpi
@@ -40,7 +40,8 @@ case "${board_ident}" in
     ;;
 esac
 
-labgrid-client write-files -T ${configtxt} config.txt
-labgrid-client write-files -T ${build}/u-boot.bin u-boot.bin
+chmod 0644 ${configtxt}
+labgrid-client write-files --partition 1 -T ${configtxt} config.txt
+labgrid-client write-files --partition 1 -T ${build}/u-boot.bin u-boot.bin
 rm ${configtxt}
 echo "Done writing build"
-- 
2.39.2

