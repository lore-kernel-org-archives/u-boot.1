Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B5C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32AB83FAA;
	Mon,  4 Aug 2025 18:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rQGBiLX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC6583FA7; Mon,  4 Aug 2025 18:04:01 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D7B783F9B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so869022f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754323439; x=1754928239; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PmK7IADCsjger2E4ug0g3CDHXHX452DSPRMGBGHbm0c=;
 b=rQGBiLX2nfBXU+Si/GfC3i5LDXuBWNW6eTLss1dbecxFbv6gr9m6uEcTFRBjlNkD8g
 4L26fxhIFzxLb+xzfrWFOO6Le3uqdTGdx+uKXp0Q49ToMiP0SEytuhlBkyGPWlARYYo2
 rIYBum404whkwXFP5HltM4dE0SBqOlBJ9lZkH4YfYVFNoq0GdEL6RXk50gC4o5YbNud+
 LOBHoWLU0aa8rN99uu++rc1KYE110Wzz2ULu/oROoSclXUilXQuKcsTCohjGVJkACmzv
 8YKOQlV/uWuiRFoF6l936pOs/fnVbkQJXY/CHQYa8h8efkdHw/l1Tfrk87TuwhHBti+A
 PgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323439; x=1754928239;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PmK7IADCsjger2E4ug0g3CDHXHX452DSPRMGBGHbm0c=;
 b=IoudjGa1xRTluO2EoJzLqkRcZX1hWCOg3O/7NCkb+BF2aou/pQSMC6HN3NnsyCejrU
 uGzkVkt/guXyn1tK8AVSGHZD5DOBSr2Q9wnwfANQdY2F4g8Z50vnHMOvDnzAhj0CzyQq
 DUuA8chGatIsWoSIw1XU1XGhd8N1qsQyoHq9zjImKj1rPnh5ELY+r8PqO2UG2pY0QeEl
 mMPi6/0C1pVbVxfvHcuj6gFzvCcrOITVayHNiHG4XXcCb2DDTWOCH7FGBZsBU5o6UX/N
 UGCDyJhHLPceHWCjoBQ4qqtQHvZoP57wf7fOSiXJv4Jvc7qbaMJxk7NUtwjREl571qnv
 V6SQ==
X-Gm-Message-State: AOJu0Ywdjnl2Ax7CCPmH4gRml2eLXrCRfuN1ln/+HoytpbeVVZoE8M0X
 j3Gc6E+wvdo8jF6KK8v308CgOgt2U76Rz1hbboJfY4RlD4P6OJxyc704YhZYRKGERuM=
X-Gm-Gg: ASbGncssXrKQ9/g1JF1wcay66SVdm+wic8AYiiTFX7djZRqnmOMSJFQ8whK7NlTPa55
 xPcFPWy/qyYMwDXfmD7Eax3UihpoFZvRQL+YcYDiypqXSLmBAqEGmebg+pV8bPEueXK8bjrLtTY
 oSoOF7dCv9J1+/fZfOMXqKzi5B4M+KUBqdLwqEq1KhwlJgF6CFF56XDn7adZtz1Sgequpc0XA5x
 NURRKvWzLHY6+FXcgxvvuxLWs8uOCbXubr2tWTawchXQwni8TkRfxZPbk+DNrpYCLd8DN1wbePU
 tnw+8OtGH9K56Q2jyh4g/qi6LgQOaWavEytRcUKsqoXlEgc+gFFjnXucSr6Nr+pnsMxLkPvvZ3b
 nAObiSCAymWG4Fag81uLAMp7MoQmURgrwI6RjJ69te4emMkfvv/g=
X-Google-Smtp-Source: AGHT+IFoMipYxy36SK/RgAu2pFvz1mSHoocv0bKC4A5s4esTK/e1xDYkStgeEdskgbgXSak1XhWlFA==
X-Received: by 2002:a05:6000:290c:b0:3b7:8cac:821b with SMTP id
 ffacd0b85a97d-3b8d9470d82mr8224210f8f.20.1754323438529; 
 Mon, 04 Aug 2025 09:03:58 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm15901598f8f.15.2025.08.04.09.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:03:58 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] net: fm: Fix some Smatch reports
Date: Mon, 04 Aug 2025 17:03:56 +0100
Message-Id: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzZkGgC/x2NwQrCMBAFf6Xs2UAMFY2/IlKS9MXsoVF2gwil/
 97U4zAMs5JCGEr3YSXBl5XftcP5NFAqob5geO5MzrqLvdnRVLQpLxNaMdm76L3z8zVl6kEMChM
 l1FSOZAnaIIf4CDL//pfHc9t2YU3R93UAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

Smatch reports some issues with incorrect tests for timeout and
dereferencing before a NULL check. Fix them.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      net: fm: Correct test for timeout
      net: fm: NULL check dev before dereference
      net: fm: Correct test for timeout

 drivers/net/fm/eth.c       | 9 ++++++---
 drivers/net/fm/memac_phy.c | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-net_fm_eth-f92b9929d7cf

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

