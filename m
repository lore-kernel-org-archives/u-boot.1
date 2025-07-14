Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2A6C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 16:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B09082E37;
	Mon, 14 Jul 2025 18:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U9yj9NJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF4D82F14; Mon, 14 Jul 2025 18:40:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEDA82CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 18:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso2597039f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752511248; x=1753116048; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vO2//hp+Yr2BMnJ5yLPF2IsJnAf9rgmselSIxW0wmOs=;
 b=U9yj9NJONGO/o9mmIBaDPf7m1hXWoE33wH83SN9b1dQY6W7vNUp4YJsq/PLKWAnm8d
 A4HRtgdPqopeHXWLkp9ql7ZeRL+39U/T+xGfYWzTo6lx0FsqLHzQNImWxNGcqjINQpjw
 9GoTCT9GEz3PW8ZL7iE40K6bD8x+IDiM1DI6k4hkVW+pEl4jiX4R1b7mHlkh1mwLq4Pj
 bFnCFp4XCoNx2YSb7aUoUmfme6boh/oclvQXTwrcWn+n9JBuLIG6iUpWuRwJPm/cV0AM
 OFfpGtL44CCiUkoJm1z4q4j/7l6gRPj/a45VwApx+AI8tt8Wuq2lmH/mVVImzjo3p6pv
 fWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752511248; x=1753116048;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vO2//hp+Yr2BMnJ5yLPF2IsJnAf9rgmselSIxW0wmOs=;
 b=wZ2OW/z5u/rG8NkvDsi516yQTGENXYJfSzveQBVkSefUrJ4S42CpLTqi4r9y1grwDJ
 6KkPE3xBOmTCGhYexWIgN0OOmRiKYjfd4I7yaEA3qDR4xIsJIkbUp+VkuGfEdp3W23yF
 llZEQTfN4xng1jX2KeepzOaDvXSUGMuPCUE5rC39xzN3cvgteMEk6iinWVBKgNoX7/br
 l4sO1FaA4nhvPcJfaa2n/+Z0FDEJszmFMXOcL/5SdWzHvGGlcG89TlJbLhDWXaszaN3j
 +0siCBRAvD9F6s3W/adTSIQscD6GHazl4QrUJhzaGFmMHO3mCM0ZMDTdzFMG3T3+SB0z
 dxiQ==
X-Gm-Message-State: AOJu0YzrpkZpNtVqLJD9GNKLm9rhwJgWlnn3mInZB8E1f7FIdVe1U9Ay
 6+KsOfmP9ybWZEz96SsJdrIZLlpIcs2WoSgWcQo1OsaOWGqI1vy3dALUDN5K69K9J49le2fv8tx
 23vu+
X-Gm-Gg: ASbGncvAFCFTe5kFw9T+JR9H9jDJMMBF8F0PoOYUh8E3oIOlyF2FADOiwifIASUNO5P
 eBvJPExEv8qKmO6h2KNOwDlLc5gb8THJ/96DJlwSd08HUsRhSoz7KLCmseIMmxWgqDpD+iMlz/a
 pKhG6m6bwCxdaA1Ql4GcqgQsdhHhxsr7exWAd0CjbjeZTa3WEKmX+l8LjkXWkdfUl+kIcUc4wAT
 okf+eKe6wZXsZATnDZL6MoUjx/cAr1/ZoevecP5kZt9F/kKMkkgDrpV6umFwXwmMN3FOAxS2Znk
 Ph+Uzc7Sj1/9Zd/oaiGLVjv/NGGCx99NeBglK1e3lBuMrtQvVZfIVLx5vF48xSIUHw/AL8lKPAK
 p6NNHtItMLEU71sWzLgBU1juZ+7jthPRfRrD3xeMfVLQvl2FbnQ==
X-Google-Smtp-Source: AGHT+IFbAkRk24Z+oMp802hBKXh+OvYXbguzLGeVY9gJJ4cFgDFFrKPgN0Ny1ginq4Bjeop0/OeQLA==
X-Received: by 2002:a05:6000:250c:b0:3b6:333:256f with SMTP id
 ffacd0b85a97d-3b603332832mr3951064f8f.58.1752511248421; 
 Mon, 14 Jul 2025 09:40:48 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:3743:80cb:93ed:a9a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm13078821f8f.16.2025.07.14.09.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:40:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 14 Jul 2025 17:40:47 +0100
Subject: [PATCH] lmb: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-lmb_unreachable-v1-1-20173f22b6ca@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA4zdWgC/x2N4QqCQBAGX0X2dwfnYWa9SkTsnZ+5oFfslgTiu
 3f2cxiGWcmgAqNLtZJiEZNnLlAfKkoj5wec9IUp+HD0p7px0xzvn6zgouME16c2hXM7+K4LVKr
 IBheVcxr3bmZ7Q3fxUgzy/a+ut237AQwX/+V6AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Code after a break is unreachable so remove it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/lmb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e5a0677e3f9..3d13dea726e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -214,8 +214,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 
 			coalesced++;
 			break;
-
-			return -1;
 		}
 	}
 

---
base-commit: e80998a77b97fa52e9321a56e004d8adfd8125d7
change-id: 20250714-lmb_unreachable-dc6c296f0882

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

