Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89387CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 05:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC93483990;
	Mon, 10 Nov 2025 06:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcI+UO+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8856D839A8; Mon, 10 Nov 2025 06:01:01 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E3883979
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 06:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso3015045b3a.3
 for <u-boot@lists.denx.de>; Sun, 09 Nov 2025 21:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762750858; x=1763355658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pX13JscueWUK/Xg/2wkv9mXIhzGeQAm/8Sg2GP1iI0s=;
 b=GcI+UO+ouRlwH6D7koKeBfEn0QSYUxwzeZXZx/RbpZepxqF6Eyt1NOnsrN3g5OI/Qo
 vOwX3FDksxk+Ut120Su1rsYGJsz0/VWjeQbSJoXmY9XBB3pq3KA7ZzxLAWxZ5VDPeTi4
 v/wIRleslBynuX3rPsORsT0Vnc4QTL2ZOSLHhMtWeg89aIV5UjE0GeykV7dW79zFPc9c
 0/EzxzObJxuIedTTkmGd4Z1TQcJJ7BuZYQBpmJLt0hwPK8+1d6N4cNFylDV6CVbCIRVn
 MuPx0nX8JHoVGrB7Vj19jVt25Q10dNKMsRGY8OWEXKcapz+brp/dlo7AErJhlz2hpGMY
 Bjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762750858; x=1763355658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pX13JscueWUK/Xg/2wkv9mXIhzGeQAm/8Sg2GP1iI0s=;
 b=BabmEXxXtWBOHUh5XBXfDLUf/tzeY5fPMsKhgP99GChhPp9RDxTNXBm2DtbifdSunG
 OibF/HYMpIG2yAYRHPXj0vKqoaqyeNxtmXCR09Tndf0XgYErdY9PI6BQ5s4dZLpRppWj
 z0B0p6hNXsbV8rR+cmztNrDmciPnot4TDEO+RIb47fs5EGQHDDOeKTBD8jckWQcbPGYF
 7EW1RGDZR7fPWA77NtFkzhng3q/+0EMIGtamBGwQhvAE83sYjlc8W8Bvuy9w+LI17Vot
 SQNk7CgfNSAfjHAL5Y769H0K3Knu7Y2e9NpCT4HtOUgdUiodW+u9t5KJpOqQOyVREQCg
 Y5Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx75J0Ikl7uItt6uAtqueC++xjiEt/iO5nbRR8fbWzFRPI/Jgy8ofB+4zkLFcsjhBH6BJ0jKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxHleBALXrIa1L9yW67nW02/1MwJ/TX7FYaunwD+DFpGt6AjrYH
 gY/p75r981i08TtRlO0aFwh7U/5LQ8QaJhZpKMtgOjq4IMFcG+Z00J+X
X-Gm-Gg: ASbGncvbCeUia4rnwbqVlP1obbZ75e0Pv0z/ElMJ8J6ueNHMniIk9/c+aeOOkJ59mbO
 9IUla6+7fAdmnhkYOlA2B0QS4R2QYlmbdT0ENKee7s1+7nRH4J+SHWL9BvHZLxVaEPRp/SgqDE6
 iJxhx+5nQEHCzRoCts06iqmkONNHf56occjkqj3N7tsyI76j+RHtVE1/J8q0aK0hYGKfGKOKUdF
 W5N7cw72V6lFLAgmjGf2S48oMVx+ACKB0cbSVB1V83QOt10E8e+p2jenRi9xEfpA8piK+GjfuSO
 plvlQIs/4SeTkLGFYZ/O8B58D/O/s8NwgS8k2yduN+WyEum6XPENgCSz9dBgWQrRhjKJ8DLhPxF
 nqfQ0lZOTS3j/uNwupT41InuIaUAo4Ih4W6S4Z58nGHQk1tZk4q4QSalCvG73LP+xLmMOx8XLOb
 jWgOMWUXAwaxLhycH9ksBhCclAC79Okv7XtucRhA==
X-Google-Smtp-Source: AGHT+IGCkCKG7td/AC9A73f5p2ZXX6MQqHZFD7KGddozngPrp5ZQYd8bMyHpuCC/c3jDVXN77vOajg==
X-Received: by 2002:a05:6a00:1823:b0:792:f084:404f with SMTP id
 d2e1a72fcca58-7b222f0f4ddmr7610812b3a.0.1762750857613; 
 Sun, 09 Nov 2025 21:00:57 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.189])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cd05d17asm10293631b3a.72.2025.11.09.21.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 21:00:57 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] sync socfpga common u-boot dts
Date: Mon, 10 Nov 2025 13:00:40 +0800
Message-ID: <20251110050040.183-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

The dtsi for socfpga common should
turn on L2 and memory and no reason not
to do so

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/dts/socfpga-common-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/socfpga-common-u-boot.dtsi b/arch/arm/dts/socfpga-common-u-boot.dtsi
index eb3d1039314..ff9da15665f 100644
--- a/arch/arm/dts/socfpga-common-u-boot.dtsi
+++ b/arch/arm/dts/socfpga-common-u-boot.dtsi
@@ -5,6 +5,10 @@
  * Copyright (c) 2019 Simon Goldschmidt
  */
 /{
+	memory {
+		bootph-all;
+	};
+
 	soc {
 		bootph-all;
 	};
@@ -14,6 +18,10 @@
 	bootph-all;
 };
 
+&L2 {
+	bootph-all;
+};
+
 &rst {
 	bootph-all;
 };
-- 
2.25.1

