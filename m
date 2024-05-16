Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F66BC25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356F88827D;
	Thu, 16 May 2024 11:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r9mKMqN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C47858704E; Thu, 16 May 2024 11:15:52 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81D88826D
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34e0d47bd98so5040372f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715850944; x=1716455744;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sglo65XMHmczjFUKMb7iW2SnGAG9MHSaIcE86hL9Y4=;
 b=r9mKMqN70nWP40glBX9SujZqPZMpF0jS/dAk1K1PQRWsQA5MB6TCgrHRSh6PZPWKSY
 SaTJjXjVBErDnxWCdIfsXNgdZELmgECkqxA1jbxHUc3qhA4GyupAFkA40EYrWnlSXbbs
 nLlifeE/ezMm0IJKAmwSpBf7T6A8eCl9XV9214R4uN1OlTN2tPz9uYer9kQMFBFQz/zd
 OSncro+7w8+VmZHvz3FeXczooNqiWCwPUOevBbtmxIs6su/TIxTtwsv5IV9Riy2fwFqh
 6OvD1gJ2G8pF//v6gDEqRTwahT9qrpfSh1D/D1O9aUtnYyUtoo59pNWXy1j90NAA1yRm
 qKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850944; x=1716455744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sglo65XMHmczjFUKMb7iW2SnGAG9MHSaIcE86hL9Y4=;
 b=Nce80igupKEf/4BASLtQKRerGwJ7Q6Q1E56xfOLqTHxSktm0cwyiYiRDkljGWi86gF
 WIHterkmdxf1Vjv6paMJPJ0iKNLHHBM7hO1Dgn0S+lhq+hTTRezLAQkYXCzNW2qi8I+D
 z/khQMCTZMB4o0hdU5BvF69aSYuRf0tbxPJpvsAdA4Fw2CaiUZmAR+lbQveBjL6zu8g+
 Sffgv8oyril8ZlH1SDQ4F1MbUQUVQeVATpE/dJSOp6usRYmLwRnBmJ2xtB7erV5yzaoQ
 opNZ6UxRaA7fvYbrvkJmqTG2vMddtyp4V0VtLteOvKmH6zgGaQODP0X/m2PhbXrDQ1Pj
 k2KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKYYml9X1XT6M2TVbjHl19Mxa+kS84/kaimCqVLcRgdCSBzcOAXAmCtEfw0EzbWUcXZq3vt/Zjr6v+FA5AiPAvkqRQTw==
X-Gm-Message-State: AOJu0YwyiWy7dbFc+dR6UosejxIB4fMHYeNtyf8w54O40u/pl3N10Jmt
 9fR7MYTzNJUf2IuFji+SrR2ayHK4Bq6hKCoJP9PKX+3pKYFcWS41g2f+UvndQWQ=
X-Google-Smtp-Source: AGHT+IGK1cEEkH3GlNIF0yd3XjULdBjlsSn/ZSLpor+dalMqwgZ0T8cvz6Ns1qivtqSVM8GRyCFsAA==
X-Received: by 2002:adf:ffcf:0:b0:34a:4b4b:7f4b with SMTP id
 ffacd0b85a97d-350182861d4mr19877928f8f.19.1715850944354; 
 Thu, 16 May 2024 02:15:44 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-351d95d47e7sm1072603f8f.117.2024.05.16.02.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:15:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 16 May 2024 11:15:41 +0200
Subject: [v2][PATCH 1/2] MAINTAINERS: add tree link for fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-gadget-maintainer-v2-1-23cc916df434@baylibre.com>
References: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
In-Reply-To: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

Fastboot patches go through the u-boot-dfu tree.

Add a link in the maintainers file for it.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6853288975c0..05217db79f7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F:	test/py/tests/test_event_dump.py
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h

-- 
2.44.0

