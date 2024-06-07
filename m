Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270CEC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 16:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FCD88047;
	Fri,  7 Jun 2024 18:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FXS+7roM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D513288444; Fri,  7 Jun 2024 18:51:37 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2363788422
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 18:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c685bfd86so187805a12.2
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717779094; x=1718383894; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=FXS+7roMetXyDc/Pv05lNuLGv1ZTgelhFuy6OYWPsCSv+m7e55Ek370go2yhwQCj6W
 Ev+D8mDBVF+NZAdmTOpWmwgG6jiK8BaWfKtIJYy/6m7rHXuwZargUP5+08uNUuy6aQH4
 z8p5LRWjr+6QYy0HsUA5Z2OM1L0HzS4vK9OgKbrkt6uoS1LlM//QNm29MXGIIo1UP2Mh
 0byytrJJ0qHfC2KdKru9QTf3znmzYOwB9ky9nMxZ9SiT5qv5Je5sUFafCdxTRfqWo9lQ
 FKatgLQN6Rbuvz4nGrd8fio+9+7KvWZDIm4N8FA/pVx2umz0MCsRVpIP8VQVXatavKKt
 HVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779094; x=1718383894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=h9aRRZ3ZZRI07d9oTS43QIswprB8e5K4DhXlEETOT4RAuwXVGSCB9QtXXOWFr1TQM7
 RRWO3f/4BBTVLnn7gDmkLBm/wa3Jz0LUYYPZKcb1dIHdOtHk/hS7bKqBQ6jBDSnwYy0J
 O7Hxueuny7521wlFv4NI0GmI97FnR+5HVjhNhGwgxfHJCY3/3gnU8Cso7lrS+6uZsErg
 fbLAwgTIja1oCX3Gvsb/vPpxIGzsbOkNdpVUaM/6RdZg2h4fk6FnteLIxyjJNDtuHIHO
 Xg+wzTNPGUv5BoV7K5nSeAZnq8hET54rlDgMaO9fnbATQM+rDjlyE0oIZlosNGCVubZG
 eu2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx8+gNGWv44r6gJ1/7f/b/X0hC0wUs4RRNUuBMTS+DRL6QqtDIBTe1m+C5/FrAJp/1ex5XN2jqoE9gPQ8PcWQHLt/7aA==
X-Gm-Message-State: AOJu0Yx+2ABbrBFUww46oz+28mVCcrQz9wZ8Sa1FFlNONUqB4ubpBslF
 Dvq/m6FLZ7QIrYRLYakJrQdFvgs3DJikPn2v6rAM6WWasMgK/he9PlDKjwct8vs=
X-Google-Smtp-Source: AGHT+IGT8yrfD+eUC/YIUnlm83GEMZQJChbbq7zDAEj175SgcR3JwICTwatyCEIXjowHNUBjcBjaVQ==
X-Received: by 2002:a17:907:5c4:b0:a67:a2e0:9dcc with SMTP id
 a640c23a62f3a-a6cd56108ebmr261864166b.5.1717779094581; 
 Fri, 07 Jun 2024 09:51:34 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581c05sm266720466b.7.2024.06.07.09.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 09:51:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 07 Jun 2024 18:51:19 +0200
Subject: [PATCH 1/2] arm64: mmu.h: fix PTE_TABLE_AP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-caleb-upstreaming-v1-1-99094dabb3d9@linaro.org>
References: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
In-Reply-To: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e1xnCDVDSraolIJhnHUmQGQpqz/i168ZLEa3Z2JGSc4=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGZjOpShY9QPzmwK4ZNqY4EdBh4LwqTMrsHpObJVCzvhcYyTs
 IkCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmYzqUAAoJEAWDMSsZX2S2f0sP/ioi
 i5aMeh/1osHkPUUntvUgs8S1L02YKkBhNcQXwkphepHmQIw7XxoW8PJjG1/o9o17T8jJ4R9w0Wn
 GfWITdAZx70aOrD8SvAW9Xzi/8dRNxKiG3i0xqBBG6IeUs4yv0KSeTYEYZIe2MP4tQSCDep0i33
 aBvGkkolfZKp8iZZtJZ98aODWRy7+cWUx/kw+GjvQ04U795qTmYMRKrzy1daQ29r9Z9HR8+85TX
 q7eFW3rN6Bj69R2ISUxpmWuCGvIthuE/5GqeCQ3/uM9c9FHPhXxVR0yGur18Qj/kOyd3l4j07dX
 B6DYN6NRkqTBcmpQydZ3zTo54vsLikmelRfbz+BFv8ia3CwE1vOZhK4QSlePV1ZQ6XnBThMzCG9
 fcEnispb8bk3EjAScZ1B++IERCqPml7xnHoEZ4SVT/fFR53bG/sHUb5DA4qFNlYxMZcBMBn6ioB
 a8upygHljNN0145DNhh0Hq2e+wpL1BjkHfNt0/1Xg2jqLTvkKCZyXGRAxtZq3zdWbKkWt/wJnP5
 htXZfaet2CLLzbUFkr1z6IW2X184cuGUfoQ0LjTkkc72JTzK8N14D+3VbIZXrH34VBrqSWArIv+
 xQ+fM9G9HDsl76bOW6LTTDZcIb2FCFV/OBe2CsBeRWLuKfRh82HJfNVvnXPrnXM2pL7uTHNWR50
 Kr+tP
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The APTable attribute is two bits wide according to the ARMv8-A
architecture reference manual. Fix the macro accordingly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/include/asm/armv8/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index ce655ce7a952..52cb18b9ed5e 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -50,9 +50,9 @@
 #define PTE_TYPE_VALID		(1 << 0)
 
 #define PTE_TABLE_PXN		(1UL << 59)
 #define PTE_TABLE_XN		(1UL << 60)
-#define PTE_TABLE_AP		(1UL << 61)
+#define PTE_TABLE_AP		(3UL << 61)
 #define PTE_TABLE_NS		(1UL << 63)
 
 /*
  * Block

-- 
2.45.0

