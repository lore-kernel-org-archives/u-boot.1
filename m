Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CA4C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D3883526;
	Sat, 24 May 2025 06:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awA8gcnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF60883510; Sat, 24 May 2025 06:25:33 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCB183303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad51ef2424bso83828966b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060731; x=1748665531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbHPSj5gUTzcMmB1FmNBvUWX2RzivL4bkFszXLzaNkA=;
 b=awA8gcnzPYnuGwQVnAcUiLgNITzNFABak72l3uvUWUxntOFkdfIcgBtMVuHhoxnybK
 JMd3JSkPIF8UAv1l6jVCxe+o7K9iW4XQKJ67U8NYjgeWRGN549E7UW8fsWfxkhVio14p
 mnYX1ktGa+uy7LPIGINWZ40bjQW1G+JTFMTwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060731; x=1748665531;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbHPSj5gUTzcMmB1FmNBvUWX2RzivL4bkFszXLzaNkA=;
 b=PHP6R17ZIhy8aSU7q2eL7PNoXHbhh4xIAxkGipf4fgXg2IITZLRTxd1ozFK7MpiZ4+
 wJPkXECnRkczJc6mdYIOkdziLCQZOjg04wGAAVwqN1oeu8UxVRtnfP4gZBR1UYfpX7J/
 wlvWJx3Exy8E8Qcq0T7O7irskBT4JfOW8dB7V7kr8HNSz0OX2wAcj+UkozIK/B5f5nAv
 T5oQY+FUtkcbyhqIMfIsrqQSnv7DJT2DZVbJ2Q8HlsB9BNn4DY1tFs9Ga23hoES17HWA
 AtnR3j3n44fK3TUlWCgFaM7IKQi1c7AoW1l64FICXLUvsk1Z/MeAlT7cthDElb93h5PS
 ZUQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOnq7u1kK1MOACWVkj67t5uKxnEo/MabLJ+wFIirUkQ9sBP3zSIsYPJGNcqHEIkEYiRa8IhWE=@lists.denx.de
X-Gm-Message-State: AOJu0YybfUgVflMdvxH+ozh8eJBXoGAx4U3AkbiKpAmpjuuvPl+9Jy7u
 quHdbjNgXn/QXR6Oy5Ne9gi5a1j0/J/+ZSIJRrTHooH+v12e8E95x7BO2y/LmuhE18GEmT7kAjh
 ODU/Bu3F+CMvjrbXAw8xe5WM/J1PkX7ojbJd0A+wC
X-Gm-Gg: ASbGncvZJP1IT4tAU4vFEOAm+4pRPgToowJ4hZp14ulYYAonx90X9DzTipp6zQoI8tS
 y6ZmVfBU+qsqHf2SHDaEPcYpI4v3we9NQdQLViRDojTgTryu3SJgG9h79iOiUVFItPhtCJs+w3u
 VEdVjIrwS5l8aebIYLBvLAd+QGncPjjbo=
X-Google-Smtp-Source: AGHT+IG1kC9avb30ZCrb0iggNGC7vMQyUj/CxVaNP2Z68PKT3WiNMEU0jl8Zf+hBg/FSeeau+MdnQwi0eGd6UoPR9AE=
X-Received: by 2002:a17:907:6eab:b0:ad1:77ae:d18e with SMTP id
 a640c23a62f3a-ad85b318f00mr133837966b.56.1748060731378; Fri, 23 May 2025
 21:25:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:30 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:30 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-11-sjg@chromium.org>
References: <20250508072907.207175-11-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:30 -0500
X-Google-Sender-Auth: 6mmb-Y8C7-OMm5iuDQkTT5PRziY
X-Gm-Features: AX0GCFsLMs-7GT08gFN-4U7xB2G8Hu_PZcUhO54eLDaON-CltL6jBbxXQbS4kuA
Message-ID: <CAFLszTiq20pXYXVgQyMPVpF=eWn7oJV3AvWqbY9Wvwo=kBFpWQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] patman: Use variables for series ID and title
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Rather than hard-coding these values in the sample patches, use
variables so that we can refer to these in tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
