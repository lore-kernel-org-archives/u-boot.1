Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CCAC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 06:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4970D831B4;
	Tue, 12 Aug 2025 08:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uHqED5qO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DBC831BB; Tue, 12 Aug 2025 08:03:37 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588AA83106
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6185a9bb91eso75854a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754978615; x=1755583415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXZ6ggbrIvwlYU9cXJr84fNqFVnCNZSKAb4Yxn2oFfc=;
 b=uHqED5qOGrWdvpNg+T8qtALUB/NgwVIZMUdK/MbuH82TimMuB117cG1ocUFsRawh6k
 IASdmImzNNuHiasD7Rh1U6RUH2TTluQIa7TSuwfmcM0KWqYCJDlVKzDIgtAMfei0t1db
 etYf7pZvHSycE/qmq6TSwKnfwC7QCgsZIl/8FvTotjqxS3fyxuxyxAkx5GGVds2g4Ofq
 vOjNXJClFzoh4788yAXfQrJ/KtAL33ea0zIAmz9xIViQsCKOtrs2PeIY2eUpnb4PO0/N
 mRXntwPQA1VS7bdTXXCVQu766DqEN1qWOI3QfHNRZOIEvGHNkw5RuQBN0dYEzq5xRnA2
 zlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754978615; x=1755583415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXZ6ggbrIvwlYU9cXJr84fNqFVnCNZSKAb4Yxn2oFfc=;
 b=p+tEcmDXIqD9w37B8uZI7YRFW4V75G71CvvgKvqjgQtacS5a4Zt2iYIz9a0ejAeZVL
 SZuAfsJO9CzNvbinLAsntljZBula6Gg5B8RjtS9Pbo3dX8v95nG92vkUAJU6SmwMCrfr
 vAvIqFjfF7ns40n3c19Hr++sYrAdvUBC8sUnSgt+DW8jDGVaTaMhKiDmqFjbJYqgUQeS
 spGm4rKbQIXG2k3GaCye8Q1F2/AAzF7tLSxVtmUdLXN2KMF5caZlQdHTX2JBA50ncB2U
 rQLnqPCcPz5ByKY5YLgpp8j9uLYRX33MpY+XitfQSH3nwvLWqkr0VxA1aNifa2LOrmwk
 M/Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5pv30KOCm2/IXz6Y4hGmfgHFnNzdxEKpP6lWUtCfGh7kyN2Fo+5JdQ2AlTz+9mBJefjefQBM=@lists.denx.de
X-Gm-Message-State: AOJu0YyZM7o8HyFtjZkzIhsVPLoP508ZDHsnQcCryE++7eTWZbai3ERy
 LN/YZWKoh9cPICu7eX8LSK7bkasdhv8rV+Lg8qSvTx7WBKiTQgDgSjYxW0ZQo8Z9XU9bTAJIzEH
 gQCyvhvk=
X-Gm-Gg: ASbGncuCWAeO/akUg19b21I31exRTcb/jtYnIfbhM8z1W8rHS2b0QzvnnKBVkUFrTYy
 CW79mgzumDlcFqylivpt6FP8N0SDTi/UDLDAQ7tevAj2xGfaBIigzi7BFkyuo+qRTJP2yojlRQw
 KxoS6tstJwgt1mCnFZ2TrSjSKzjcmZfFDUq7GzmqImfZ51O/S34R5YbOShQDbdTsslmzmy5pIxQ
 pioSV5IAPn+plQxmXZCdSmugnrt1jQ1omub0WGym2oWZ3OWFpj4/3ObDnkysc4hS7Z7G7IsR1ca
 MUtLQW1MEdGHup1MzBYPe0mM45O0fReLD6ia2QtFoFiPN1AH0krb/MzEyEZ+/ytwIHuVR/hJnjU
 x1iiJx/3hQkYFqy7ozUIfM1ffow==
X-Google-Smtp-Source: AGHT+IFw9LSeeAjxRSh5owrHi/jLvyu02/xRUt28N4FMiodW1B3tCMy+Iblnv0UtKhDe5R7yEULbwA==
X-Received: by 2002:a05:6402:5cd:b0:615:c767:5ba1 with SMTP id
 4fb4d7f45d1cf-6184ea2b87bmr1758634a12.3.1754978614712; 
 Mon, 11 Aug 2025 23:03:34 -0700 (PDT)
Received: from hera.. ([46.198.241.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8ff9ae5sm19197857a12.43.2025.08.11.23.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 23:03:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] tools: fit_info: Make usage() static
Date: Tue, 12 Aug 2025 09:03:25 +0300
Message-ID: <20250812060326.1193684-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

The function is only used locally so declare it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/fit_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_info.c b/tools/fit_info.c
index b2642ec5b763..c9e4236d09f5 100644
--- a/tools/fit_info.c
+++ b/tools/fit_info.c
@@ -26,7 +26,7 @@
 #include <image.h>
 #include <u-boot/crc.h>
 
-void usage(char *cmdname)
+static void usage(char *cmdname)
 {
 	fprintf(stderr, "Usage: %s -f fit file -n node -p property\n"
 			 "          -f ==> set fit file which is used'\n"
-- 
2.49.0

