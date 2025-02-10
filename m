Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D4C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941F1807FE;
	Mon, 10 Feb 2025 14:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DIME+ik5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB7580AE3; Mon, 10 Feb 2025 14:08:08 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E299803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso46530695ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192885; x=1739797685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GChx+CdheIBTFB+x+iYMUfDGHuTLRUVxJ0vWGLVn2rY=;
 b=DIME+ik5CzRMDwfW2NkCO0tvyiCbIrQfSx/1L9qP3iNiMqXQoFDMRRWhaTzeZxafAH
 djDpj8BdZQ38aUipK+j1X1CpNl2I9IIaL1+c3Klni7b00tSLqaraYIkcF7S0SUo4tia3
 mo7l9h+TDq1Fyxk+AxleSNvjsz3aZG4HFvwLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192885; x=1739797685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GChx+CdheIBTFB+x+iYMUfDGHuTLRUVxJ0vWGLVn2rY=;
 b=qWkkPQE6FC0SwUz9NuDACbtB2vUs37qZfRueuruchC0t6WbRb2GmHI+/5ff295V0u3
 OaoP6E1cWt5aAtZs2Hfn4rZlzj+fDiWIwzzVVoo1jU5D7wvrGlW3ymLCGrpQ5XHl3VwO
 IlKn8i1ZS76XytQSut0rNZ8flu3bkOxzVXulQ5mBtp4WAKgbmiiUsU5FxKikng9Tq49T
 eaUpkUctJUPFjQPJ0J2KH1EAjZ9XlQiWVitiDsh4SDsUmOT9efH+t1JlP66X9wgzEdir
 cE4tNKSMCDhbCd5assYzs67PVbks4XxVAXP/U+UselSwxm+nNRV8DJHGv8Rh9vBKqLhz
 iOlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU334VPFh3jj3qdYrHEFWRFd+ceP+DzKJqBF1mv0+VdStNkq7AvCH/Jewn5ve94R/h2TB295t4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi2tfCACdxoX4kDt9lfkf2hFxrhII+DkfCtrGT5871/65XkcRA
 M7s/ZVkddawBwvebfptzDKZngIwZk8MRxPXwlKF7Bwrtdoh/XpO26DNAny1W368Ur9rmir2tx8O
 7DZQuNVBa+kz1RcnqYi+2oMA1NNlIbNCRuJcy
X-Gm-Gg: ASbGncs9jRnf9vi+nzVai5zEusKLL418SW3axq4gPEJxjG2Oz6IO8pb9+4sr6OjL1w/
 E9WBTQkEIlTB9IMcFc4NjIah54SYJs3kCWBa379BXtEeQaEiYwrJgNBWOijekAD1RLIOK5bcZaw
 ==
X-Google-Smtp-Source: AGHT+IHJy8ZyKviJbsdq378uGYu1sShnROrtOYy641jh5FnuFS/HSxdjgrascZIKEdtK3nNXXq4mTQxySHXe4Ht06Kw=
X-Received: by 2002:a05:6a00:90a8:b0:730:94e5:1ea2 with SMTP id
 d2e1a72fcca58-73094e5228amr3673695b3a.4.1739192884895; Mon, 10 Feb 2025
 05:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-5-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-5-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:07:07 -0700
X-Gm-Features: AWEUYZnvJsQPAzhesFbZWURrOu3VDsFGDwTb-ON7aUcD0oFJr8jrJopJbCn7UXA
Message-ID: <CAFLszTijjF829OOhyyX4SqXgKqudjb3sXyDOdPSnJXLH-oC6VQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] binman: test: assert optional blobs don't cause
 non-functionality
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
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

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> When external blobs are marked optional, they should not cause a
> build to fail. Extend the test cases for FitTeeOsOptional and
> ExtblobOptional.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
