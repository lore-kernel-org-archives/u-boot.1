Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED55E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4D680511;
	Fri, 20 Dec 2024 05:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fxcBdmkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0391D8039B; Fri, 20 Dec 2024 05:06:12 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2EDE8051F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso309117866b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667566; x=1735272366; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cwvq7VyH0VuT9231Ws7CT8xCEqWRtfTv9J3ly1MmKQA=;
 b=fxcBdmkGSOGU15zGzDkMJak+FZ8jzDMUjKK/bepNAzAoQ2jHPSNy72OVgJcJ17o5Vp
 hDS55mWbp1DO2moC/AX866DkOocpLgcmB1KOKvSBIP6pDFElT0Q85tHxOUrajsQByYXu
 cStPxpAoRqQo3M658DYzEWcwGN9C6unE1vKG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667566; x=1735272366;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwvq7VyH0VuT9231Ws7CT8xCEqWRtfTv9J3ly1MmKQA=;
 b=iSeR34u7HR/Z5Fjht1/G0SGCmKM3N+BUIusV3ogfkHNnp+5znDBJo+JhxW2SDngc53
 WyABbdtPS9F/XGr7MMFD5QWURiVZOaym6d59glhdR7fexgZTfjg3iPfQHZt5q7W0o39V
 r7NLOB3OehmvmCM+/m6bqfZcC3SwquO04b8TPXSREINQTn0Eav4s3lisXXKOAT3L3CZG
 5uwbw7RLOpWF4aVKO6qE0C2sUNnAQ6s6PBMccu0skXBF7HPvk/Ty8LVeUSXzS/zoMfTx
 lmRmX1eW+QnrWAXIPZsm8L4BgeGegWizWwZBOW1k06Uyr6QhGoHZ0IpEkws27yM536sy
 pSsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpPZFxplNI6WJSRRApyygU1dUG6beWKUDfkSiRaGvlZBuOBXYy24Lz/5vE6MVacLBbDgypeow=@lists.denx.de
X-Gm-Message-State: AOJu0YwvufNexAUwG9WL/7mHVdqyHdDT1vRT5Xrp/JXk1EK6JBTCENsf
 3MCr8rnQh3ydIKLPbTIsD/SMzW4kWk8HKl2Bpi8900onpRG5dDiDgHR2/FAXB24Z9+rKrQQkk6O
 YXcAGKJH7j+BA3w0qT7zOVUkTQBXj9eKwD6CA
X-Gm-Gg: ASbGncsTWpFs261ibfBYUH9sXRZwZmJy8gBe8XGd7d+PzG8ChCBkLuekCimqpavCHje
 PXg4JYfRtgvnSVZtYm3TGv18/CHcPrz+b7m5KFCg=
X-Google-Smtp-Source: AGHT+IFdNvwrbSTgt3JdimzYShEiMFYdOPGTjFYFGATefV9xwlEPxrQL09Bh2J7tTEBrQoornWp4ANgIEG04OggngGo=
X-Received: by 2002:a17:906:f583:b0:aa6:8bb4:5039 with SMTP id
 a640c23a62f3a-aac2b0a562amr83833866b.20.1734667566237; Thu, 19 Dec 2024
 20:06:06 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:05 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-22-sjg@chromium.org>
References: <20241206023626.2456858-22-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:05 +0000
X-Google-Sender-Auth: 2rBfm1NSJwx2l0BkC-bWMku94BI
Message-ID: <CAFLszTj_wy3WMMEbaNt9FQiJC=XR7GbFJRjkM_=D71s63j9G2A@mail.gmail.com>
Subject: Re: [PATCH v3 21/46] net: Keep the bootstage functions together
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

Move the bootstage_mark() function just before net_loop(), so that the
IPv6 code is not in the way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
