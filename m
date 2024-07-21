Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF28C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E148851B;
	Sun, 21 Jul 2024 12:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UUSLSXFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020A78841D; Sun, 21 Jul 2024 12:10:11 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E05883AF
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36844375001so1635704f8f.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556606; x=1722161406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cs6BMRzzdgzXSquuZ7Q0J4JSEU1HiAdklbTHEkuJ4N0=;
 b=UUSLSXFbbvUbSXwJXTvYhI5jhO3OUYwPBbeO0YOofKCxdH3qaC9Fj4TBuiqWY5XY9Y
 iZvmc44fAartXacp8OEECcoj/NKsbRbuAbUoYjXkAkCk7t8tcfd+V0HTh6+zjP52tIMN
 kbYm+jGRdaF3ioRLiRcQyBM4l2/hVo9EK1+Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556606; x=1722161406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cs6BMRzzdgzXSquuZ7Q0J4JSEU1HiAdklbTHEkuJ4N0=;
 b=bmVMTWwY0d6fxKrs18NmK1RXKsOK8W5TLZAQShiszAINosgqEw9uR2kWBjUIHKf9j0
 HrlkIaqINZC7CvP+H83lX+h59w3wZKviMYyndIYdR9tIN1TBWAggkt0ZBwK5/2W3NgUn
 M6MgHd86sIOSr7j2I1gUKAMo5f1vN+oSGej/IP6rKVv0+VKsrSJpr6hQd4Wm02EWw3J8
 plSCpjjK2WVVuHoSN+3Fiw/zoMNUowKmhHvX8vtPKWMa13MqTq3Wgp5xGU/W1q1bpwTg
 z/yvYipnzRgAxxGiDoMQo3ErhfbWEeFBblxO8lXNSOXp9PMwwOInlzXR9cBhFp1w8XXY
 pyLQ==
X-Gm-Message-State: AOJu0YxpWdCqSLj6jH6RYTu2G485Njq8lsVx1NaYSJYru10o/99rJdIU
 w37BLHQhE1hfCv0mYMHcXvkDEJbvP35+Zk2f2HeC8W3I+H9nWdLt1gUcopEvzg5p8U02oY6dZK4
 =
X-Google-Smtp-Source: AGHT+IHa5wNV8wjprEj+1Mi/LLDraQaq5d8lL7nqKlsKbbOVUH6IH/kw6+gzTcbcxJFXuCq+tMW5MA==
X-Received: by 2002:a5d:6310:0:b0:35f:f90:f383 with SMTP id
 ffacd0b85a97d-369bb2c3a02mr2098403f8f.56.1721556605893; 
 Sun, 21 Jul 2024 03:10:05 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/21] spl: Set SPL_FIT_FOUND for full FIT also
Date: Sun, 21 Jul 2024 11:09:32 +0100
Message-Id: <20240721100940.3202027-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

This flag is set for simple FIT, so set it for full FIT too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split out into its own commit

 common/spl/spl_fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 2a097f4464c..527a5691ac6 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -941,6 +941,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		if (ret < 0)
 			return ret;
 	}
+	spl_image->flags |= SPL_FIT_FOUND;
 
 	return 0;
 }
-- 
2.34.1

