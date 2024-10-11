Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344F2CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF488937B;
	Fri, 11 Oct 2024 12:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="IIOZbXrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4760D89378; Fri, 11 Oct 2024 12:35:30 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A398937A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99422c796eso309311566b.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642927; x=1729247727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=IIOZbXrnmk7QJnZeIc45GfeXDpBwS1D/HqbVa1Em6j6rATd8WFxuQTXzFaP0n35iUM
 lP96CUANGMlEwO+NPyI6z+QppN9xvH4plsAAf4VHzmTXX4xyDn1B+wBTpIdk3lgvbV1a
 VpYiADvAKgK9fOsQpCUtWFahfwKiFP0pnmMFhbshWjQY3GpmiotT4yTDXwHtRTGmJavf
 1c2lTt27o5vqFeUHrC7Dt8e6T4THYMWFnaQ1T2fZJ1P5nAYN/FMyNhpin3f9ECgegJ40
 elLerrEeJbotTqWlarlc5btdZWZNlAtZN51eAZXCe5cbFyu/Bk0gMLPv96c7herm9sCH
 jogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642927; x=1729247727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=cv72gzjSSR2wE99CghcA8YC3/SWhnS415BknsHw96lz3X9cGAEgzoHKuenTHQGpO2m
 MsM9QRn7vN1CPJWEenSBV9EjR+YQnTWofJJDQaR+lyP8PW0qpLGwCfJaRgKK+OZ7VlIe
 8SwRefrCi3Kek+mWwdvEAJHiA8u+VR+pXWi3dgtdBxYO3XCryajkgpiReD7vpocBXCtU
 awi2hdNG/Stg2KUiFslb8HH/wKXX1Arh1zd88aPczQ55SW8G9d4R53JU6zGO/+oc8eim
 IB94LzdssD1QbQwoGlqDnewJGFLIfRrDeD5iUgEJ8tkwKSvdwCUv9jhC0srQ90KOlDDl
 tqHg==
X-Gm-Message-State: AOJu0YyrTSBKct5YtkHTphQS7q6josm6y1k6ZKisDN2GwmXD73v8sA8b
 iRlvLIFgy3KmqUkIcvM1msTN6kbPVw/c5zoafz+XiRMC2raHTjmOSOhEVsx3MmQ+UFCY4JW8A8t
 C3tE=
X-Google-Smtp-Source: AGHT+IEhwHbLJA90IWSn8bl/coknUY+AQCYOqY3PT23wFnbUy78uWpMbKYCrqY9LbjzEgIUCvqOoCg==
X-Received: by 2002:a17:907:7b87:b0:a99:4acc:3a0c with SMTP id
 a640c23a62f3a-a99b95ee687mr198200466b.53.1728642927511; 
 Fri, 11 Oct 2024 03:35:27 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 32/37] arm: Implement read_mpidr on armv7
Date: Fri, 11 Oct 2024 12:23:13 +0200
Message-ID: <20241011102419.12523-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

Implement read_mpidr() on armv7 to make use of it in generic
code that compiles on both armv7 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..9eb30c2ade 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,6 +394,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2

