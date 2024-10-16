Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6858D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CDB88F23;
	Wed, 16 Oct 2024 08:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="CacMooP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5041F88F28; Wed, 16 Oct 2024 08:13:39 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B2B88F20
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso3202408a12.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059216; x=1729664016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=CacMooP2AttyXQZqDAJYpX+WuQSJ/phlhkkQNogCNj2BeJ36Cqd5CK6R1hhyJde7uJ
 J++OYXWEGybz47IZYOxp+GT5Ur32l4bPT3Tr82zZcENWz5rrSHGHu4n1RLWOY3LGTzos
 Yn7R9end9Y6gFVxvPQYi+4ul5tceEy8MxAs0tO4ELZn4fRhKyOAxFUyeiXLHzjY+425u
 rY5dCYAzxgpZiTDXBSBDrY0pGIf+vyG1SogMjzEBXLrx7PTk9VSgGcY+1nx6TxpcWE/C
 XVWMhBk8o6VhVQUwPUhYFBVN0g6Rdlsbd6G+SdhspNbxhmdA35Rc9NltjI8O03mKFuYP
 XxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059216; x=1729664016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=bLhgyG4DRqfVoEA8xVIl1VA4aBAYAAlzGTpngegWiYr7psfJV5eL+6+0dAAmoCwPWM
 9wRQGZ2GKpd2C1rUuoNR9+J3Te/rID55sa+LOTyBGT9LFI8c77pzGFG22+y7sQi9zgMS
 F7uhslGVLHH+oXx9KUgiv1bLXZCGTU9bZZaKmdz4U17E7wkOn0AvN9OB/xOW3wZF+e0G
 8cFjX1h6cm/78Php6h6cbdFlw3XXOcErfhxrHjJTHC7Hm1JcKTnW6BPHeBkVJQtwrQ53
 vpbt26Dh5pwMBy+CDpDnydfcmqb2rJaU/uxX58mYoQfx8VPM8LJ3CLPcl2TFlx5K21mq
 nOEA==
X-Gm-Message-State: AOJu0YznXjr1dSYJd2OLjZ+cEDqYfts6MRb0nUdQmjhPbC5Ee513VClh
 iOj0itVi9f9cOURk9LF+cM9BbAQSn2ptqZkHKIfI6ApPlRYc7k2E6O9SHkv6h16S0Jo8VSvQueQ
 i
X-Google-Smtp-Source: AGHT+IFmXDRm37sAJCzhK5tUWURDIwZmaKBhYRlauxNFMFiq4Uwn2TV4U+zYrwkgk9O+873VwQvCWQ==
X-Received: by 2002:a17:907:e282:b0:a99:fc6b:44f3 with SMTP id
 a640c23a62f3a-a9a34dd8032mr198541966b.44.1729059216603; 
 Tue, 15 Oct 2024 23:13:36 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 32/37] arm: Implement read_mpidr on armv7
Date: Wed, 16 Oct 2024 08:04:18 +0200
Message-ID: <20241016060523.888804-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

