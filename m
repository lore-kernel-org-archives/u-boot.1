Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D8EC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A362488934;
	Mon, 29 Jul 2024 18:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RnCBnRPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AAF888D4; Mon, 29 Jul 2024 18:19:48 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C9288867
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a1e1237e9aso216463085a.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269985; x=1722874785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHQzg8SXXDJnEuSV1she6fiejiJTho2QxWW5iVYeawQ=;
 b=RnCBnRPpr7wS8uPY/83NCNE0NeqIboVYp745UeihBKkU8zb+cC2oOW6eZiYYdvaTd1
 U4PV3ihm0rqv/WV6TNT24/te1D5jqiSW1bSHh+hwppAIZ7WVcu6dox0+cwbnaFH0rCe6
 Rv2l/lJRMqfyBE8vGMEYKV7uXc6z1KpSEt7WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269985; x=1722874785;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHQzg8SXXDJnEuSV1she6fiejiJTho2QxWW5iVYeawQ=;
 b=RMQSlI2PYROUxs/SX4YyhdFgNprK5npOiy6e05/i99dBYxGeGCcAGGxSb3nxR/0mi7
 p88gOY33BdCaCcrH9SDcAan8hKV8hVZOyUocgoDxYqCR6sQEVYmlh4kV1Jp0gql2T6/V
 0Xy8bS5TxHOZsjRzLbwWXZSN/nDIgn9MfK3WDFGkmxrjLewumRm1rzkQGr6AdEMqhMZJ
 HZx0CeA+p3ePypZu64Fvh4cBIBk27aXOZ/xICMmvGFQP8K4f21KhPpt0zpL4Y219xNCA
 rL0KIFUsN1f7/7OT3WcGdvUPq8VEfLnShMwIu7/wGpC76QTnBIDMKxPlsHeIJh2Unsfi
 ol4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQr8QJH80YQxKA9Dp8yvG8JmtBCIAhpQMEv2uk1rL3SV+Mu7stU0O3p4NKogxdfO4CGBnpZxJs3dGS+UCtKff66xbg1w==
X-Gm-Message-State: AOJu0YwA3bW1lGbeDrmI45Pbi7LGBcntA6yt08xVW9fIdRuA6xVWsiAI
 3ss/9gV9fWIwvbVn+njW3qoq1FtYdJay5RU3gQZUtm58A0AGtLbPX/r7N1FKUSPGUa8AgilSEh0
 oQayKdraRu2FSg0YuhurmIg/V73cAG6nnCdy2
X-Google-Smtp-Source: AGHT+IG9Q4nsGwMQk79c9fWzEDJtGmFTPi3M4ot2E/Vmm2Oy40vki1SKHxJrRYjwgcecBS0cGNApr9iwE8dnYtTavvY=
X-Received: by 2002:a05:6214:234b:b0:6b5:9146:6251 with SMTP id
 6a1803df08f44-6bb5599c26fmr99107456d6.12.1722269985415; Mon, 29 Jul 2024
 09:19:45 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:45 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240718091125.3788990-26-sjg@chromium.org>
References: <20240718091125.3788990-26-sjg@chromium.org>
 <20240718091125.3788990-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:45 -0700
X-Google-Sender-Auth: UB5cGgRcsftLMGq8-S_5vzO1u2U
Message-ID: <CAFLszTiKAzLAG8pmez-Mrs=A4Eiei3kLEv-xpiRP64e+PM+QMA@mail.gmail.com>
Subject: Re: [PATCH v2 25/26] qconfig: Sort the boards by name when finding
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

There is no particular ordering of the board list at present, since it
is generated by a multi-threaded process. Sort them by name to make it
easier to see if a particular board is present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a new patch to sort the boards by name when finding

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
