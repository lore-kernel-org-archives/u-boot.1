Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D06C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6718F888C6;
	Mon, 29 Jul 2024 18:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QI1UKKFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C657C88842; Mon, 29 Jul 2024 18:19:30 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D81288837
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e0885b4f1d5so2147158276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269966; x=1722874766; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Inz9H+92AWJVtXhptaKDxxEbsugGZuPHee9rJoBoYG8=;
 b=QI1UKKFYQUN+jHz4bS81qydCvJ/qbufwz8U+1WbGDXnELg6Qez43fsAVPCYAjMwlo1
 1BWW7T1lOogWyGT5UL1D1pmWVkyNPssdoLuGfZQagbEx3RiN5HvhyBQn5ftWQPePeYSQ
 xpAbctN+be2jSDswovCU5ufoiLd4l1idUwpYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269966; x=1722874766;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Inz9H+92AWJVtXhptaKDxxEbsugGZuPHee9rJoBoYG8=;
 b=MPPIxkLOxMXa+Wt+Q+aw0X1SsmyXBQVSPqIbxMVLiMQGUVfPPUT5yMhLPIojpARvDG
 EAA6M9nhtL1mBru7EHpDAyEOxBd7QgA5fDheOFzqSpAiApjeiBch/ILlE+tJlusZzA4K
 Qyn0go3cX9PIH69edQkNxDMZ2o11YHfFdkPx+lJY2cBluYk1cPh/c9q3CcMkkaQprq28
 p/AO9Qu3uB3gOuS+PAsUAWIzLtIkc4orwMA9qegy4fenDOcPxfyuwYJ9YLkuTCcn7KVo
 Iij3iOUY3CvMi3iuZtF34rM0ix78csb+wSn3YmN3Hr/QG+zCjyQ4YBpOD0PWSjey/Ld9
 hbYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBj32UwUmEjfiJE4c77Wk5YpMMqfi/b0CqbtpFKw0H7EiV9UAAt2zUWat4l25p+qeBVp/ksOb4FE3nExi9Vb6SSiw1qw==
X-Gm-Message-State: AOJu0YydmZlyiyp3zYJjAeu1LdMzXltmHHrhAAAtYse/FIqJVnU7yT24
 ATb807FzQnTYbD113h8bSPvWbKeQlRYOEgo7iLb2tAGcfyf3PYhUznfRgV8J5kDiAAI1SmAL4dm
 7sGJVxg/RF9cIFCMsTrfeG71icnsqo8NCtdl6mHH0qExYP14=
X-Google-Smtp-Source: AGHT+IGkuJS6YeCQ7aciVnoYmZjFVlFoA7+CW67Ap1t+m1Xv6TZWdP61s/bF+B2vB6tBzX8tduuDBVZ8ozwb8jNvXhk=
X-Received: by 2002:a05:6902:124e:b0:e0b:97c4:77cb with SMTP id
 3f1490d57ef6-e0b97c4831fmr538293276.27.1722269965935; Mon, 29 Jul 2024
 09:19:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:25 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-14-sjg@chromium.org>
References: <20240720104950.2730773-14-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:25 -0700
X-Google-Sender-Auth: _AOo_QAX-VAdvBkwG7iqmm07kOc
Message-ID: <CAFLszTj0=EWiGSDzWDFU-WHbf5ZjatTc91C=rTOBAV1OnwMDeg@mail.gmail.com>
Subject: Re: [PATCH 13/20] binman: Remove dependency on pylibfdt for entry-docs
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Allow the entry-docs command to operate even if pylibfdt is not present
in the systemn.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/image.py | 7 +++++++
 1 file changed, 7 insertions(+)

Applied to u-boot-dm, thanks!
