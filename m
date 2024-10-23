Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD89ECF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFB48934A;
	Wed, 23 Oct 2024 15:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ScEM8s/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1B18938E; Wed, 23 Oct 2024 15:29:34 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF828934C
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso4963451f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690171; x=1730294971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=ScEM8s/y0sYx5Vki80am3E9LWI2rC/NgngPgRjjHYELqWCKr6eaJ17NQLvZRV55Jst
 Gn/Ks+vf2IxAcGGp3oZ061zCVBuFi4VJ5eTKQjOiBS+U5eZb8oupW6GVLlfy/s/8w1jv
 sAL0r2JKUcpW82TQDszM1Pq9MFTMDPxA1aes2Gi9f+ZfHYLd1wWb1EcIyvy5JYDcbJyP
 uwrOFPal5TpjFm8sj0DVnx0z1lS/uIId8IFMSJEkAibCB9zDhdXGhb30C6ShZHhY7GOi
 h1Ai9l9a+Mhj7AgrmzuhavEr6KV2d5mT9VL5PavdDqS3o2TJT5QQvB6Tk3+FYaTGXlXF
 LRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690171; x=1730294971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
 b=QTtRJG4soEcEs4QCI35fMR2T3HAQtImGIIJOnH1+ay8XxCWMEhe/lPS1eX/xZGcGXx
 Mb1n9tf1obhePjhgSsv5PabHXelbIUVtcLDds41iBRg3Z2FdWZPBqASyFV0v4EJN8SzD
 6kOS7og5H+XCUhZjgLbxkHYb7rRESLtoUUEIFVM5EfHQwL4Jhxm+aqmRiU4vC4i+M0LL
 CYuFe0IdRF7fF8Vreu7ZiVp7bPMYvVFSmtblEeYcws7XRaYOqdtSHnsM4eWoMclscORC
 pxHV1TzbxseltjFHWcGl2YPGCjcAWaTl1nfjKrQvlPW/0zCdaEuwQbhKH/ZoOB7Zu7YJ
 3Fcw==
X-Gm-Message-State: AOJu0YyoL6JH6/dHU7OOgpi+BhedB6df2r77tl9nfzwBgXpIp2p9HuUh
 RKKFiPt546/+1VJGQdwWi66TscFD501LXIUQXTI53xd5HUGHwta0u/itDTBkD7ZNhQ5EmfuK8C6
 E
X-Google-Smtp-Source: AGHT+IGLjL+6vyLcXWbbuwanzigVPV1pSr+WMRIjbyA1L5nsp+zjh0NaqGT9d1TKcaDQH7UYJdPcmg==
X-Received: by 2002:adf:a31a:0:b0:37d:377f:da4f with SMTP id
 ffacd0b85a97d-37efcf1df9amr1590681f8f.27.1729690170717; 
 Wed, 23 Oct 2024 06:29:30 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:30 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 32/37] arm: Implement read_mpidr on armv7
Date: Wed, 23 Oct 2024 15:20:15 +0200
Message-ID: <20241023132116.970117-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

