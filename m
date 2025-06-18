Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24ACC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FA182EA2;
	Wed, 18 Jun 2025 16:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="TUkUPT9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C39882BCD; Wed, 18 Jun 2025 16:25:36 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0296482C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-607c5715ef2so11448903a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256733; x=1750861533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1B7KrfbYFhLcZW/1eVr9ocl7isAfLPKWL3pwWUOSRsA=;
 b=TUkUPT9Jm+Yvdsnwz/IxvOpHhKV3x0YWaKqlGaiErDSNsUN/09UkNTGAlNl2uO5b7H
 hJNp53x+2ZLDzvubBg8Hsqlq8sEQZFPS5PSAGN/1KK7Yx8sB4oGrsvSfalD8rAff2GPb
 oiFbWJKv0oPXztqmCQ22HQiBezr/t8x6mEp0nPXljYohLCZkRR6v8xCndWRFyHCkdeYF
 bFPKNZo6aqo2TlTHNFLIJ2PSi2g1W0tf91Qov8q2dC8pzRCODvxPhyCmG6oqb7ZR+yZg
 VKCF2GnTB0ngdZkv7H5tC1UoqNo08s+I4trTpd3gEvK5ZlUaSuSBi2pnnZgAkI8sRwvv
 iW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256733; x=1750861533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1B7KrfbYFhLcZW/1eVr9ocl7isAfLPKWL3pwWUOSRsA=;
 b=SQ+Iul1IaHjZUx8NbLn54FKpMrgwziTCAajuK0LEi0+sLBEIkpaQwnKjTYv+4QrtO5
 58ivIhZwsf7GYdXGwwObUv2/AzIH0yJgK/NNQP7gZA2yzJXvelXZK1jK4ossY0btAFcC
 tqijoy9ZR7T31Or/NV0QI9u6PmUpWjY3ykWe+V6lXcfu4V0TKau6yBPbU/IZL8bd5HFq
 v2IntyiV7VJfaIDEcBi+N7No1kGizxrQyz7gdCCRR7yzPTiHILMOlNF5Sgm0I7UfVZ87
 v8vYpE8ujY2g92/hFuo0Z8u9O65OZ8Qiq1H2BLweAv0RG93VPCiG3Vu/+oqK9awzJrqL
 l27Q==
X-Gm-Message-State: AOJu0YwltcAWhppZ0y6MFWSRyBxgheFXO3N/1zeOrdlxiXei06fRHYAS
 xjqEBTXevdupHB/nqP2sX4aJ8jiN4QlQfKOmkOwFYU66JJKMJ68AsIYGeibh28CgNA0=
X-Gm-Gg: ASbGncto2WMWIm9O04ouonJwkaqoox5B0K+UIftpftcKrBSpIXdyHgdhTdZmZ0jyAY7
 eWDrWGiSZlMXqY9/dzmS6FPd4hFcV1SatgiascNDjCLJngupaHbdT6JD5t0t5XQVYXzWeXVh3N1
 4hVkUYL7Ek27L4uqpzKWmXJTAXge5lBpZjEY1qomdUdE/vTsdbfGrZKX4BE5FxXrenGR6T3f88T
 7qHWbIFRwo21fDfnTVmyrO/wlUqM6ZL5xvntwTrXNN5eSeMO094CUkuhLkUwGHm9PfluQQEI5is
 FY+xL9Roggnjt8SY5N1nC/11P46hNwGPmwCU4qRtsKiWeCklYYokJI5J4al10ZistmKPEbvolzs
 ALp0Qi/e34gXcpAsavTaqTPfWgiGKE7NN
X-Google-Smtp-Source: AGHT+IGLU2OgSSexu6ebFyErj2n1H/ReUg3bSDqrIYIOeHg0A7FhlZ2MGBqefwThRatr8hBGF8WUxQ==
X-Received: by 2002:a17:907:6010:b0:adf:d157:4331 with SMTP id
 a640c23a62f3a-adfd1574436mr930480366b.44.1750256733416; 
 Wed, 18 Jun 2025 07:25:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:24 +0200
Subject: [PATCH 8/8] board/qualcomm: add debug config fragment for SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-8-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=638;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=n0iu5cNz2EgXLiQzCdkEJMBcpEgn8jWB8pMFxZFdMJA=;
 b=sdUilZ8m8J1AvGIuz33uJhP1kbHdd212u8UN72mbGfhhii8bQafkKp/QfQT3i9TcYsdof5wTb
 RP16Y5GVqidD/XArDOJWKcFd+XWkNY4JJcP0d8J34CGW6tnRo9uPLvR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Add a fragment similar to others to enable earlycon.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 board/qualcomm/debug-sm6350.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/debug-sm6350.config b/board/qualcomm/debug-sm6350.config
new file mode 100644
index 0000000000000000000000000000000000000000..1379ddeac93f1beb59bdbff4ae9a90b4f0a0af2a
--- /dev/null
+++ b/board/qualcomm/debug-sm6350.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x98c000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600

-- 
2.50.0

