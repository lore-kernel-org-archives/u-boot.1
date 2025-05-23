Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C96C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CB383280;
	Fri, 23 May 2025 15:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IYJVSWjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D149830B4; Fri, 23 May 2025 15:18:56 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6113683280
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad5273c1fd7so1560015466b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006334; x=1748611134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kam7lDCWZfkiyGcFKZWxmCGYdTvsrErDSsvY6sVQC4A=;
 b=IYJVSWjfBSigGN3u6dpvhZ9HotuYfAWHhGgBpsEcAQyCa1zhOkGXNw8BLgLcqEONVZ
 g28HvlOgdU4G2ywkiarewkHr1XnX9WVT6CqROm/TmhRL4qlG7PbfMyFMLty68eCgzIEV
 Dpqx60Wg319hO3+KKsvlqHClLW3H3cVqeQGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006334; x=1748611134;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kam7lDCWZfkiyGcFKZWxmCGYdTvsrErDSsvY6sVQC4A=;
 b=SwWvlPrAjNxsBpAfCxH4j2g9z8tRtZlTtcV2OMI5p70JaCqs3IbWTiZFZQeWZAmsJr
 hOp6n/3WhoWn18DXfvV3sIuQ1krsjJ7hPcIPCoaUWC82TheiQ59IJG2hy2vGJttx/aE2
 +KjqMkaa1J1yEp+iir/J5dE4gUPSjBFRc/VkMXO3oiwR/ExZOemnPcstFuVGh+5kDHRC
 nCQZ6aR0MdFXu0w3ahUPaGXPqec+xNUqlf/QzJZzxNfccWx9bpZKNyxpE/Ff1qB2haAQ
 7xX5QMKxeE2ItUX+LbM4N4A6ABqbhZQQHLw3HLcTipOum+TN12tSvD0lXa6TrKDvz/40
 FxWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg0N9g+Qfu+isQk51a4QbwqgW/Gb8IDmMH9j55gouIDTi5CaLM+0bs29xArB9O6vOKuY/N6Uo=@lists.denx.de
X-Gm-Message-State: AOJu0YzgYw1xiLpAcyD7uFT2j6XYHr6OqdBQJ33fH+CmVn6QwnQ54MkK
 CP3wYUQUtWIqsRxVUvuJgXKW+aYEV0m4XyGM5MpS+rgXrkokBwg4CfLYM38CR4ckb4yjzKbO/pi
 6pN4xkXGRxlqm/XWCPtbiBtT6r/NyT9Fqfvi79mAj+64afw8HKYoA1kYl
X-Gm-Gg: ASbGnctNWdJBOlcy3rSrUs4yW6HPvXV1LVOrT0R6hPK3xX0OBwmgeWqpUxokEnBYpF/
 vnGerCuN3qhaN+ryapdGf2+WZHj4lF5vvGd/lzx01fpilXtpNARSS/fhVY0/pU217GG4+xQ+S/q
 UBXe+45V/HxYTnbbUKS4Y/KhzlPd/6eMEBDOmOGYZvlPrS
X-Google-Smtp-Source: AGHT+IFRJTx4Ua6sIi59ENvJXTlaUSd38qzrJwmZ88aRV/GAVYW+XPVDOAvOZhXl6tLYLpk4vRWfGH/pdAF3DRzrdls=
X-Received: by 2002:a17:906:6a26:b0:acb:5343:e75 with SMTP id
 a640c23a62f3a-ad536c23c18mr2405913566b.34.1748006333794; Fri, 23 May 2025
 06:18:53 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:51 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:51 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-16-sjg@chromium.org>
References: <20250504132356.2317305-16-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:51 -0500
X-Google-Sender-Auth: AGaYn4_pah6we3FA3kIt6PaBhlk
X-Gm-Features: AX0GCFt2_HRLLuIMNKVHzEJOpLpK7jrkEkyAr3O19ULpnGnGhKKimaZRxbhvK14
Message-ID: <CAFLszTgQxrpjkLAM-hyire_C6k4NLvOESbvv3Ws5MsDTvSnsYw@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] patman: Add aiohttp to requirements
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This module will be used for accessing Patchwork, so add it to the
requirements.txt file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rework commit message since this only updates requirements.txt now

 tools/patman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

Applied to sjg/master, thanks!
