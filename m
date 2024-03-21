Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2639DC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D44987EDE;
	Thu, 21 Mar 2024 16:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TnAzBbQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D2F880B5; Thu, 21 Mar 2024 16:31:42 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF66487EDE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41412411622so8104275e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711035099; x=1711639899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owy7VK7wNfG9po6h9q0aoufsINQOqNJnLzyr5kRhEyM=;
 b=TnAzBbQz3NhUEYV2U+t1UDnCYjKNMifKb+O0B0GIltyibABj9paKvCInUkbre46DtG
 3MQSNQVmTNSBjucYRebB8893YbEkEHkncqsu9KfSFto4G6sH0KdZxtB2l6mmSj/iZFQY
 G+22fL5RnvmZt6a1EYVayjI2jM70JbLYzGlnCxClcT43RnDaf3fxDFIQiKyPGtx0JDK4
 Vgnd1UsGsEpSFZsifriX82CxcKN2Aqh3jvnovu4svAAk8ZH3aDIY++1wIWJUlg8/Dgk7
 B5lyCMtD4Z/af12nBUPLWixI+4NMYY0AhibwTBkwT6pg58kJdShokIvmhG0JiXD3SnZH
 oSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711035099; x=1711639899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owy7VK7wNfG9po6h9q0aoufsINQOqNJnLzyr5kRhEyM=;
 b=dClUeqNCbh/XBI8NrNq00KW648wHz8kX4mu10EIaUEfA6tQKIq+QoyYHOPH+MuiPfD
 0yBwqp0L5ah8V7MhZB2ezmfJQd82Z1Nu0AvVVQY3kSdzGWG/iqVGulx4MMO+5mXOb9x9
 htKkWbCwDfXveFuRtc0G4eVxmjCISJV+c/8dHXzu94U0jmJmbeduhlvPn4MvKG32Y5Ap
 l+Xj35lTYlCMidm+MQmz6PaDsP2sstVcHkuu4Resb1CwVByyeAUaSg8eyCzoPeikYdbc
 MDgjba2AhMbxVEevewKgXNU2T8yoBJajdCSXK4hjq7qLgjrc+YUXWLzegvOEh4+DBEAP
 /qpQ==
X-Gm-Message-State: AOJu0YzHiPoJnVpWXzNDb2PbJiwUE0Cn+S9vEgCDbTsfehhqP+VmJj1B
 /hRadak3eupF4e2OchT71i76q1acH5aEX7dqskJ6vYG6TVa0zN2oxw5xDm6k2YI=
X-Google-Smtp-Source: AGHT+IEDUEoxop/5+yXxw0YbgzDlH8YgZCYUKNko4mzDMKQWk21UafK5xiGHM93i6kVImfapmYtaVw==
X-Received: by 2002:a05:600c:3582:b0:414:69be:54b0 with SMTP id
 p2-20020a05600c358200b0041469be54b0mr1679725wmq.22.1711035099200; 
 Thu, 21 Mar 2024 08:31:39 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b0041413aefeb9sm5906854wmq.48.2024.03.21.08.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 08:31:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] usb: gadget: UMS: fix 64-bit division on ARM32
Date: Thu, 21 Mar 2024 15:28:28 +0000
Message-ID: <20240321153004.709994-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <87zfurvdze.fsf@baylibre.com>
References: 
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

The patch introducing support for dynamic sector sizes changed the types
used in some divisions, resulting in the compiler attempting to use
libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
lldiv() to handle this correctly.

Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Hi Mattijs,

Sorry for not catching that sooner! I compile tested this locally and a
CI pipeline is running here: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/20029

Regards,
Caleb
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

