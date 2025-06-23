Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE1FC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFDB83055;
	Mon, 23 Jun 2025 14:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u6xkG/Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511668210D; Mon, 23 Jun 2025 14:11:01 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D6F81E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso7662668a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680659; x=1751285459;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bsOXXO4+4EVuui+YkOlTB4vm37VNuUfZ+FEKWOI53jc=;
 b=u6xkG/DwHmAc2pyClFZKiwex7lnvU5fTLOFHPrXr9cGBXwXDKqVjtwQhQ8aeLcGdE2
 QYVHWstSh3x/Ml2hC9PTjQGGqxEz5LKZGA8FMaOZ80K1AIeobZ8nt5pnml/qyh8IvGGC
 UthaG276skdvQZKhUH4ewvV5KGesmUtCb5Go3hpTj2cSBF0gl926q0lglTIOLGHQdJSp
 hBuhTu5ySTfpXKsgd7E+hsrmlDeh2gJol8UFqGYVmPS4unZl/Vzud0WPx+BkObeKSzPM
 dnh3NgUNDHTSHN9SBmrYdtEAKKggQGZJ02sFn0QxGoJbdzaV1Om1Awur8aDZVmL/9mcw
 CeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680659; x=1751285459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsOXXO4+4EVuui+YkOlTB4vm37VNuUfZ+FEKWOI53jc=;
 b=R5UaSlNRhY9JB2sCEjW6FM5VjqfUxFphdHAX08Vfdg1tBFdDhg4KcxFR1Qi2f1u7MA
 0VjCMkKmFc4HCLjGxKeemPGSa4/Mj8sYL60MTSqGe7tAxlqxMPP42hT7yC6qnlJnPaVH
 HjXxyE5X+elX61/wa3mliz6qq0jUppxMD9rf7pRuPKTGaw2oKMyn/hhwA1OsAvHIGRgH
 3OSh7nIfJtfFZXZoULhs4swyYOFcEgtm0KIw8OdEYsOjWFl5KANNEh7BjybgR8vMrELE
 lYYUr9xSO7YAbJRA5GXNeSvnuCuf2W6JSNdqpR52nemlybagR2xgsXQG/ikIIbclJgov
 8e2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJIRtGHNAuyqx2GlVJyn7428XoDfeASuhha36Vvp7lUP6MQom0JDpMDgey00osBrvab/MeNY0=@lists.denx.de
X-Gm-Message-State: AOJu0YwFL2d0FkFD16mXMYrdMiy7aEwljp1XMCDZIM557Tumu6Ec1zDK
 4Xm6uWr87/neKvLEncGB8MEcrC40yZOc+mTZoXu1JSyfoOQ+G5zQ6XGonHkKGQHYVpI=
X-Gm-Gg: ASbGncuWjisDQvdHcdQxTLGFiNZ+6WI+kTS1kzeJvIPLx6LZfSCPwcypPycCrGe9ueo
 MoKSVPc/Adc7jkj1uLZgK9wOsWS1XnqM3mzNE/3qm84RJChJcJnhUZvdl4T3LBMMc8YOHJNFUIl
 RMAn1O6v37XTQoEv88ZAsBB96Y9tzsPbz++GY/OSYPAVrKIDGkM1ptZs9XjI5ZaR4EkUMdiTQff
 l6wUTOkLeV5gjjE9+zPHjJaG4DNwRP1VNalaoYUpEG4DbUEr2nGCm28oC9xAS57rtaOQyOmamSG
 R2F2sO4Idtr7aQXLJGk0Q7T2xYc0Mr8Yplix5RMT4nBfq8zlMDqUJsYFQfE=
X-Google-Smtp-Source: AGHT+IHcSAzlnAZFvpT7MRjS2YBStHcseAqf9pP7JCkYd8o5fuaj8xsTW7LjZrwCBjLX2NN/ie9EIg==
X-Received: by 2002:a17:906:c105:b0:ae0:1fdf:ea60 with SMTP id
 a640c23a62f3a-ae057d83c6emr1331150266b.25.1750680658890; 
 Mon, 23 Jun 2025 05:10:58 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0a0aa1ceesm25370266b.70.2025.06.23.05.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:58 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:45 +0200
Subject: [PATCH v3 22/22] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-22-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4mX0CaDAiFcu+j+kWUgWS9Tz++IuEQD6wNQR6gbV0ZE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIFx3jPRadTV6aPq/ykntmR3yzWf5ISVcopEqPf6usj
 MT3vZ0dpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMJH/9Qx/OD6k/clwyH1y8N+C
 pOeMR8XPmBo1lsbPZl4ro/DS/bRfJCND90SDPw0LVq203PYlUz9eVOmYIRP7878G7vdKmTgTyn8
 yAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 21a381e81137ee970215b370974707f0146be727..595e41d570e723bfe93103d57697fbe1e87d34a8 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -122,3 +122,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.49.0

