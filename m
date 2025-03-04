Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11ECC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239D0805C3;
	Tue,  4 Mar 2025 17:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kpKkQ6+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66239807D9; Tue,  4 Mar 2025 17:04:57 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506D58004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF0E13F85F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741104294;
 bh=ikTCQH93S1tB9PQl8PzxKK+5DlCBOYoBoer2wGGYC98=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kpKkQ6+Sc51VeCtrqYiHA4Cg8LoHva0x7nVyBDBclISqDc09FA/ENS+GRdHJ+00Zl
 OEF5/6K+ZBAplIkqjF/TAaexPWtpPib+HWRaHeimsdcUe8ahDPI41vip3KpmOP56iY
 siTuN8p8tmU4fTncvK6WmXvA+GQKD5o9COWZcM9ChryKbHfV1z5qukD4bhZp+CjJv9
 zkZQk0dhsjIPrfBwX7EVrAqO2sDvfKpIWOK2WbQCEV9WN7WiWJjSB9IWQJHtUiurDW
 TrNyA6UyoYRXy1mMmS/KWoPAZOZnZkpHDdoh4W0bRJcdNQI0S3qYijekdxtyXkAMqD
 abdf05mUEFH3A==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390d73c20b6so3960240f8f.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741104294; x=1741709094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ikTCQH93S1tB9PQl8PzxKK+5DlCBOYoBoer2wGGYC98=;
 b=IrlbBzls+iozLmzaqAGThTHGa+a4n0iVIBN1urG8/Nl2chkS4rZ4yD1Sw8CY80P8fr
 sJIx55Gh9wZjA/xJeitwHH3KirMqTsB43yEmhtsiRa0oOrKO7UzIeCLxgKh9VtsQCmWY
 JmSJI1iZGeRvBQcuRdMyaOm2bu3L/0oGgyqdrOjACp/sroeYUkIP+zG++b9ixnHeBcoC
 srcnJcRB3udxYea9rw/BdMGLAHgQH503Ia5P0+GDg3xC3bDSeGFsgmkahTDiiV+5G65b
 nHX4mw+3wq8NHEHWpvIQwyRXDyAqy2C/iQim4BQ4ELqY/z0lpkPOUVZwxKtGIL5q+k1D
 lzHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUAov1dcGi9ktBBHgDt9936IkqLLu3VEf2wXjwu8z51oGNIfOLglXynN5CXAKPE1P7ASqOdHw=@lists.denx.de
X-Gm-Message-State: AOJu0YwGgRlxzfzhiwD99PUuvAv1VHFiqABXffkJ4prbLHH2Wd94h9Qk
 vjdJR+wHVO1ctkle2zxwCqG5zaA9a+s7MGp9Baacq+a0vWCjiOil0qKODfXAj/2Jp+jj+hki9zY
 tTJ0aCJIpdyJDuzPO9uNlvyeJydvrTMgo5B9pRfAuUCbdT34xYKupZIikC95Yx32Q1dI=
X-Gm-Gg: ASbGncvmOpkw1aMI6O4oq1RRjpKSjDi4HgWL5xw5ysHuBpjkPynn4nu5CNkaePvXtel
 vcMiD2PItnsRGvcQaJC+Fw7es9ytiIJOVbLq6ct+9k9U4f3c39MWut9NUVlL1V6abweafaAMZRa
 Z9QYYSBJV+cU2yHNNFjH8HhOMi+MJhMSqr+QLvhu2ggKPJ7JIsKD02jwnHgebizF30ZVMa3wUyp
 iFMFwqGElJ049JAC97/mQDtxF9HwnTVXQe5gz/713L9A4zHNEJpR/jcgIZk2Zcq+XE5TPtDjEdR
 u8oO9SFcpF5R5F/kVaqgctG5z+2IBqugQRSQRSIPnh3MXdYL
X-Received: by 2002:a5d:6d0d:0:b0:390:e9ea:59b with SMTP id
 ffacd0b85a97d-390ec7cc14emr15149388f8f.18.1741104294322; 
 Tue, 04 Mar 2025 08:04:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhBQ4G0Fdl6RLmLnhNSMqmI21mT5MBCe/8B+UZCJkFnhUc2+Lb1ioEhRf2ZxtW/UTKMoPtzw==
X-Received: by 2002:a5d:6d0d:0:b0:390:e9ea:59b with SMTP id
 ffacd0b85a97d-390ec7cc14emr15149253f8f.18.1741104293196; 
 Tue, 04 Mar 2025 08:04:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:a0ef:4a3:ef0c:4a59:c55b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc186de4sm11463595e9.1.2025.03.04.08.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:04:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dumpimage: fix handling of StarFive SPL too long
Date: Tue,  4 Mar 2025 17:04:03 +0100
Message-ID: <20250304160403.380961-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The header of the StarFive U-Boot SPL file u-boot-spl.normal.out has a
field indicating the payload size. When copying U-Boot SPL from a
partition the copied file might be too long.

Currently in this situation a misleading error message 'Incorrect CRC32' is
written.

We must use the payload size and not the file size when calculating the
CRC32.

Write a warning if the file is too long indicating the correct size. This
enables the user to truncate the file accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/sfspl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/sfspl.c b/tools/sfspl.c
index c76420ce21b..516e96e8dd9 100644
--- a/tools/sfspl.c
+++ b/tools/sfspl.c
@@ -70,11 +70,14 @@ static int sfspl_verify_header(unsigned char *buf, int size,
 		printf("Truncated file\n");
 		return EXIT_FAILURE;
 	}
+	if ((size_t)size > hdr_size + file_size)
+		printf("File too long, expected %u bytes\n",
+		       hdr_size + file_size);
 	if (hdr->version != DEFAULT_VERSION) {
 		printf("Unknown file format version\n");
 		return EXIT_FAILURE;
 	}
-	crc_check = crc32(0, &buf[hdr_size], size - hdr_size);
+	crc_check = crc32(0, &buf[hdr_size], file_size);
 	if (crc_check != crc) {
 		printf("Incorrect CRC32\n");
 		return EXIT_FAILURE;
-- 
2.48.1

