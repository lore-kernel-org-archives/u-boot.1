Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A61C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F7D8852A;
	Tue, 28 May 2024 16:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yzyskwoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8938857C; Tue, 28 May 2024 16:18:34 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB677884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-794977cbd66so27159185a.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905911; x=1717510711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7g9MzR4EmLA6mq0C8lhXvx5n9KiR/7Sw8WDz9rHeHI=;
 b=yzyskwoXZ97KmwznGqTNtQJZ5KyTwo+OBgGXiJg3qXrpihXN5tDBQj40pr6aC9k0N3
 vbGxQyDc3M3HGH3aLzh330AT/MNktx0TmFgiunlvgQ4PqCWAW2AFqqwPaDLK8W9CU/JE
 kjVYm8ne+Z4RD84OWwcEuMKJPhADYje/BOW5XdYgY+1LNeNUe8ZR6zOl7HZIXVE7Nwep
 DzF3qv6ruftJBE/h9znBnzydGcW/moA6NTcxuwUeOZ9amvJj0WK1sj8Wqh5kz3PiU4Tp
 ym2VgDhnhbKz67cF9DDB0PN6NcK8WOfbrCnjbL55svYik3+ZYfCxfdQSW8afrMZFSSGw
 V1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905911; x=1717510711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7g9MzR4EmLA6mq0C8lhXvx5n9KiR/7Sw8WDz9rHeHI=;
 b=TWZfjA1Wy3B+f7WoqePhuowe2VIHWmQ7ZxGdVqa+gZRgkHFCAX1DeQzxSOv/7bSaGE
 io20i/lIXRyYHO6F8ZqcAeGwCH2+gRIwG6jci575/+laERBXQ/IqxUIBh9r/l/6rd0P2
 9nG2eUNjspAw2p913FOasOwXoanG4avBQKxzdO/i+IsqraFezHk3A0eOvD6zq4aqTwZ/
 TL5FPGQ3nwtx24Xk22cEi3RCsfaw6Y2R/rrz7pYtDCoA0qIroiXI87KIDcx0p71FKhB9
 WROsqbahw8B54RN+f4cG6EbtPWAttdfZ76iTSTEL+zBy3MgI5rrgbgA2Jm49a8eTwjs7
 Ie4Q==
X-Gm-Message-State: AOJu0YzYZvaOVKnhUckUGLZVzoEec30RgzY5H3Kdcc17m+8QNhwfXl/D
 W4O4mzfL/r2MMxH8jVmd7n/HtDQy/Eq//O1f0lAYnhZZIt2hu1uEb5FptN1RJvK8NoKrz5cEgai
 LJ0c=
X-Google-Smtp-Source: AGHT+IF3q9AWdUHtZSTXJ5RD32j+fvjGR6fy3Q9bVTmCpdOCtMIo6yNwC/shTpyxs77PxmW9dKVPdQ==
X-Received: by 2002:a05:620a:468b:b0:793:f24:c37e with SMTP id
 af79cd13be357-794ab097b32mr1491913285a.46.1716905911526; 
 Tue, 28 May 2024 07:18:31 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:18:31 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 23/25] asn1_decoder: remove ASN1 decoder when using MbedTLS
Date: Tue, 28 May 2024 07:09:34 -0700
Message-Id: <20240528140955.1960172-24-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

When building with MbedTLS, we are using MbedTLS to decode ASN1 data
for x509, pkcs7 and mscode. So we can remove asn1_decoder when
MBEDTLS_LIB_X509 is enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.

 lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 3534b3301ae..7e3dc1084fb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,7 +82,9 @@ obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
 endif
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+endif
 
 obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
-- 
2.25.1

