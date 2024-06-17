Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E7C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51BC5882A7;
	Mon, 17 Jun 2024 10:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pTZQcy15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F61088271; Mon, 17 Jun 2024 10:03:57 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F1387CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so499872766b.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718611434; x=1719216234; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=pTZQcy15RYr8G3HCmGTdwAnk7t0kTZDENMqUf+VTwRNeubVaC2yDBge7e7tCI4FtIm
 +3ISOh1YN5ip+J/2jKa8ogN5Khticc5jne4TG8sZ2xzwLwM8niZPkTC6zNpYttRnHA0B
 V5clHnw25M+WRYCb+ZF0lEy6DSHzw+eQOTcIv1IaH79fmg2WKNIwqVrhZVq2baB9dpx7
 pN9x6s++Z8EOFm6/+FhdFxintH8LbJOENGw/GKhAaBy/SDYe8GXGMrqjGRyfduz6Yfn5
 pN2DVJD9FNTUFmk8+gqTH5f/1EjcVjpdeQJqzC1Zg3255rqqkQcv8Rz5aJAlQ/0Sj00E
 47xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718611434; x=1719216234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=pzs8exgROZlPicMQPNYxdyg0svDRjF2qc/WUe/Gu9inM2Eo6GK4071WBNEA1Fz9bwz
 yFz+s0nFka9+nmtjX5bSxjpPzo1PPq4gVpGGGgdPw+bBhC8YNqWe2X3AAnxWcH06wgmQ
 U+e+onAOoNRmZRrpkspMrbh/l7Brj4gqVzTAIAnzZjzd04zjtrqec6Inbt85zx+bCp27
 /gwK/+BH+BxjUYm1f4I+lmKGcuvId14VXcZ2dYc85WBpYhcIw1SDPH+TNMU8JATKEHDv
 dFbqYDYiwA3xrstqrJhuB1ELanIv3oyvP4L6XDHH7LKXpDDAiLWDqEQlb/60vyI4b0AJ
 iLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIBkGkVgrw0d2blFwJkuh4l8FZOkLVGoXjVi9hv+j7ZKTlw4M0AsKxHxGXJs9ZpkI4sVQvpxPc0d1qLoTbyHy+vAnc1w==
X-Gm-Message-State: AOJu0YxsZyhWKhOKyzLmWX32vTDbXhSvO35DFN6ErBj6G0UYcn5+BmQW
 iv9efwk9P5ipe1Hv4sMaSz7DUNBBkLQakVePVOGvk2kpHsV/yXDHUqti9rZq2Xw=
X-Google-Smtp-Source: AGHT+IHTuG1SnyE1Guhjx2+D4ltOt4VJCgVimRLsvTF85KbAbN6KHFRrySPEVana6vdguROGIly0uA==
X-Received: by 2002:a17:907:c5c5:b0:a6f:73df:15ce with SMTP id
 a640c23a62f3a-a6f73df184emr361659966b.54.1718611434346; 
 Mon, 17 Jun 2024 01:03:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd79sm493224966b.132.2024.06.17.01.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:03:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Jun 2024 10:03:47 +0200
Subject: [PATCH v3 1/3] arm64: mmu.h: fix PTE_TABLE_AP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-caleb-upstreaming-v3-1-1ba35dc9179d@linaro.org>
References: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
In-Reply-To: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e1xnCDVDSraolIJhnHUmQGQpqz/i168ZLEa3Z2JGSc4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb+3oFukAwp7776hOWqO7rJA16qJeGTByJuFCP
 lHiFmck3/WJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/t6AAKCRAFgzErGV9k
 tr5wD/90lTEfZeCt+aDC1OEnNIyAazDOKLLzokGcylprpLqYTCpvjcnF1Zh8oxPh8Ywa+PBnRkE
 xitGmYRh73sGN29ARmIUv0hfi1bnNchI3KXWbEUbMLVD9J3ETt7C8sCseXgOYWZRBDaXFJIPeTa
 fNTYzP8YIOwnY70mRZh29hj7/Gq2EYU9sUCg+uwhNv+mbaMD5o6ONYknW9laJJpB+W+yTJRYu0X
 okQckJlEK2aIR5GsZwYc0/zjQTujmlUD7X0Abb7cXyFJ1u/VKOmPWX3RqgaxXu60nyPcahgSGUf
 uF458ncTs4BBqA82DA3wAN58f+pWmvlE5RvPcG88VNabTuEULyes5T2vJ/9KuZ4FdpZwuhgD051
 EYTMTiacbGbAvglofmk65T3jwpjdbsbPt80pA7TIvj2MHC2mXDS5oWDo5t7/DnndhHVXeGazxno
 8pU/m5UQJjUFC1Tuz/ltu4sNkpGljOPL1P/+zGm3M/t0PtBHJYMYa9nEtijfiNeH9IdXDQshewD
 o6bEZ9VBmNDJAlLK4CB/r2lXiBlPwJV78GkV5zqgMhGJx0F4wJ829D3X4gtxQV6oJtqpXlGmtbX
 Rvhiz7qaarPC2QqnOWW+DZisL144w1fpNdJkZe8wZYUiSZ+n8Jd42yQCq0CChNyKA5/CjiL75KO
 3Flyj/NQnFvzadg==
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

