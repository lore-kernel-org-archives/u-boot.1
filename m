Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC0CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D865588206;
	Thu, 28 Mar 2024 19:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I5kfjqVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB979881F3; Thu, 28 Mar 2024 19:00:00 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638A8881DA
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-341cf28e013so767995f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648798; x=1712253598; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2rIilUL3fPgdL00EeRjYvSoOr0+tfQS+h1cCC5JbimE=;
 b=I5kfjqVpwcB/0Gp8M8SJpbDZAaZzXCtGrA7xgpiGvRyh879yMn+pKi/VGQE5kNyJpm
 z+CAKhv7+SSDRgiC9v94I1qAkOO6dMbkB47vuM3bOAwaVkJo5bzQKrMqLoelRzLOcnDr
 86xqCnPNYawsDpnpL3QgjPteuMX/Yh27YIki3/2V3DLLjr5vuRnbrxvL5rdoKEf++c7C
 BNoO8nZE4t70iPvr61CBKw75HakBq8eHKW2WpkKAaS/4S7oPLDuU7ywux4/ywufYBAB4
 eBfoN4OP4IOCsSk+Dc2Id/5wSE+gmrhldVZN2GLZnTxedm61nnD6ZRQr1h0woYWibW1y
 1TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648798; x=1712253598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rIilUL3fPgdL00EeRjYvSoOr0+tfQS+h1cCC5JbimE=;
 b=IKPJ7Uqx+bksd27kQYu6+snJDOyWtTY6w43C49uEDIMKwcLOwK380RBRn4s1ModD7i
 t/xsCP566EbF6V56sHyQKWPNpxuuAYZp/hOXqy8uqMzN3gomz1M2Rd5Fk/DKkNPkj+uK
 l9sKnxpyL3qsG7ouM9wZcKQE93FwVCy6kB4f0yefYO5lIzOGGHLer3lxM0L8PzCjuepi
 Ez6kzlIMT1dSQuBmlK1ahIowlSOS1w70dV6ee9sUqUm9MC4Dt+Dl2k2cnpg46iZY2tz7
 MFQt7INxireDTXStlreO9cnYuY/6ETBXG2ddStkMgQ+3o7b57ZKZI6pQGqWbwYJMuMQA
 33/Q==
X-Gm-Message-State: AOJu0YwU6+TJcwuBTKKL/kv4ePOlUVy+77WLFXlvDt04B1QaqGw92l2G
 RmFyg6c+GZF2l53xPvBraOC6mwqwhAfQNjFmjEeZnLjtEdA53pniZNOCWcRNvJgv77nfy4lef7p
 3
X-Google-Smtp-Source: AGHT+IEKnYH+hmQ41BxEwLeXif5Vq4SBfYvLO8afUoAsUh14fRRqRX4smMnwnRosgE1Upw+UKTjxcA==
X-Received: by 2002:adf:fa42:0:b0:33e:8b93:87c6 with SMTP id
 y2-20020adffa42000000b0033e8b9387c6mr2678093wrr.42.1711648797948; 
 Thu, 28 Mar 2024 10:59:57 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:22 +0000
Subject: [PATCH v5 16/16] usb: gadget: UMS: fix 64-bit division on ARM32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-16-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GILrVlJTLB7vGoUqwXYfiSFWeP5Fqv5LLGhQ18mVlh4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVwHLU3WZuzJkhAQvvLzAOPldO9bixbuywjcsfvp+
 tOPN4QkdZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ1Kgz/E/m8La2Z4haV5PP
 LM6scOvA0flRgQxOctVrqkNX6KotWMPIMFN1Xb3RwyarF2mlCYcmqXqudrzP2Xqmxdv+7ZN/5hX
 XXwMA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The patch introducing support for dynamic sector sizes changed the types
used in some divisions, resulting in the compiler attempting to use
libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
lldiv() to handle this correctly.

Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index d880928044f4..ef90c7ec7fb5 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -239,8 +239,9 @@
 /* #define VERBOSE_DEBUG */
 /* #define DUMP_MSGS */
 
 #include <config.h>
+#include <div64.h>
 #include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <common.h>
@@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / curlun->blksize,
-				      amount / curlun->blksize,
+				      lldiv(file_offset, curlun->blksize),
+				      lldiv(amount, curlun->blksize),
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
 
@@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
 			amount = bh->outreq->actual;
 
 			/* Perform the write */
 			rc = ums[common->lun].write_sector(&ums[common->lun],
-					       file_offset / curlun->blksize,
-					       amount / curlun->blksize,
+					       lldiv(file_offset, curlun->blksize),
+					       lldiv(amount, curlun->blksize),
 					       (char __user *)bh->buf);
 			if (!rc)
 				return -EIO;
 			nwritten = rc * curlun->blksize;
@@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / curlun->blksize,
-				      amount / curlun->blksize,
+				      lldiv(file_offset, curlun->blksize),
+				      lldiv(amount, curlun->blksize),
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
 		nread = rc * curlun->blksize;

-- 
2.44.0

