Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2548E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F80B804F9;
	Fri, 20 Dec 2024 05:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9i7bX8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EA280087; Fri, 20 Dec 2024 05:05:59 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94478037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so242996566b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667557; x=1735272357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSlsQluOYS7qj6gYi3jyU6NI+Ymxx8FY6+8c8Jbzpjo=;
 b=d9i7bX8TxsoeqpFEVlxUwjE9jVX5IaN0O05r3KeQXGFuQhcJyJnAwFH6LPrJL0jiKZ
 WB+D3Wj1rTR4scB0Nw5o1zbmsbP805cbqTXx+kenC8sgAmZQvRSV4Pd7F8o8krojWahu
 1ctf46wNtRL5/KH+gXHwYVSt33N95lUbAfPYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667557; x=1735272357;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSlsQluOYS7qj6gYi3jyU6NI+Ymxx8FY6+8c8Jbzpjo=;
 b=N3Dw3ZwewGNp3z5QPmWMpv2S9qfJaUqO5bj8CBW3yLgshSTzCGVVjDkrcb1GQAW/en
 J4LQYo/wOu7BillMVWbMV+/pzbyVjwG9nYw7MeKL0Nf2tDEWxsu8dMiYjX2JeSae9XKR
 zhBIr0XPCa2Wmjqj+wkjySVlERo6lAb0ehqvtIB4zvmxgucPdWPlPf4XszPeaRb/gIFR
 rYfj8q28I15/g1x/J3yysk8Ua4vFydcq4O6SPs/vjf6fVKRK/ZJxwG21a9BaZO5u4TpV
 vvfpJNO+xkgT/iL3ebJnC3kc5z2eKV/Gt//VsbfSLQRjNaS5ARiVNPMWdsery3kwDUWV
 ynYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcQcJB+y0EEw7dVwTpnyP61v2l1LQQhEzOubnZyn50XBpY46TabGhlqzyon1dRjbFCmmZnxVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6fLiyoRfn4uiXyRnR82kCel5k2eyp5nP7WyCyaJ96Bi2StPWh
 w4K/rbrYJMvQipMud02Iw7gSv7/NrMYbKGLiKf6lLyFssBrSIqJcuo70Nfri0uBRzx8hvJ0ooLj
 kgPNq0cnC+F3tbDDVSQUkOnKjBFNw+og7LYQB
X-Gm-Gg: ASbGncszAkQnFxWWVi4j73qNAhhPfm5zPX+54PbzMTmOqy70Doh7ehq5nI9kMoakC5K
 rzdYTO2KEjhQoj94Kolq8VLBkJTfFOiMt+k4o7Vo=
X-Google-Smtp-Source: AGHT+IHAQXW7CN6LG2dEoFYeWEWt/cQFi23jIGv3GVWz1Z9dHMMAbybkTvXCyActA95sT6+Il+P8TYU1TV+IK/AJjP4=
X-Received: by 2002:a17:906:7314:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-aac2ad9e06emr83957166b.14.1734667557297; Thu, 19 Dec 2024
 20:05:57 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:05:54 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-25-sjg@chromium.org>
References: <20241206023626.2456858-25-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:05:54 +0000
X-Google-Sender-Auth: uj7dakla9LGp0su5wwzKREF3GZs
Message-ID: <CAFLszTg1k+cTKE4MhVGoJYzFC2mKv0RnuFYCzuEaH-tgXXromg@mail.gmail.com>
Subject: Re: [PATCH v3 24/46] net: Return the load address from parse_args()
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

Rather than updating the global, update the value of a parameter, so the
action of the function is simpler.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
