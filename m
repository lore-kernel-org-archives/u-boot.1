Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F47C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FEB9876DE;
	Sat,  2 Dec 2023 19:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJggzP2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FE5876CC; Sat,  2 Dec 2023 19:23:59 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF2D87642
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d6b9143782so14593447b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541435; x=1702146235; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qaqAxW0q8iAcFYqVKRXSVX6XQsMfAsJLOVId/5Nl7sU=;
 b=CJggzP2qtDX14uk9SQOBubDbfRbiwAyHMIvqb0OUXDZVAHE7GFFFNFGlp019GoefOj
 i/lGdqYHVZoTN+4qq0rcHSA+P/a5nzXgrlkiSGXpn0wQiInfGQsm5h7AWqLEueZ72EmD
 /trP4q5FgTzAlqvkhc49PB1SUNu6aWCEeNMUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541435; x=1702146235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qaqAxW0q8iAcFYqVKRXSVX6XQsMfAsJLOVId/5Nl7sU=;
 b=MZUe02YMBuGSi1Y2E3+2h7TB5I8hd/cIqjcfuoDrF37IPdyvGGXIz8b4KmG1N9jx+l
 +CUG+fVyl6g4LAWiJoPigcK1ornG0XeS3AdSmOfQ1JF7m+nak7cuZtz+DStYmm+aC9gX
 Mcn67zFjlVividEL7pPypd9CwKdO8Ec73odBqYRavhhWKSRxi7v+7yhNOYQKJpeddcoz
 Jw6i8m7DPhMNfZMWTFskOS8lazJqpzt87l5xi9wOIEo4cHfeKsQ18/IxXPHlsFnw7euq
 s/Lc+KrC7/e0hvHGTYEqQLt2UrpSvWVwZqx0YNAZDUNUqv9/CTKufhwruKSN46Ek6BfR
 5vmg==
X-Gm-Message-State: AOJu0YxUze++LvqTWAQPg1HP5hdmLZuxvnafbj4I2d5bOuPOl4HPrqZx
 mffWOwFHG0cLPJHceKuW6uDTayICp8dR0dgt5xLkjEVdlTrMUiEgIbaB2g==
X-Google-Smtp-Source: AGHT+IFv4QLDLfUG7Y6eBnL9DMbux3tPnwQevz4bbMnzbu47txE6Jt4zZCjevaDYt5mKRUVjzJD3UoPrDy4TJn8rtWo=
X-Received: by 2002:a05:690c:368d:b0:5d7:1940:7d7e with SMTP id
 fu13-20020a05690c368d00b005d719407d7emr1281986ywb.85.1701541435491; Sat, 02
 Dec 2023 10:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-10-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-10-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:14 -0700
Message-ID: <CAPnjgZ3cLXjUx2te9vZ5pJSZOCMG5YriSf9Nf2UBRfAcpr9-Hw@mail.gmail.com>
Subject: Re: [PATCH 10/11] include: Further cleanup includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 22 Nov 2023 at 06:13, Tom Rini <trini@konsulko.com> wrote:
>
> Add some missing headers such as <linux/errno.h> or <linux/types.h> or
> <linux/kernel.h> to header files that make direct usage of things
> provided by these headers.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/atmel_lcd.h | 2 ++
>  include/getopt.h    | 2 ++
>  include/mapmem.h    | 2 ++
>  include/memalign.h  | 1 +
>  include/net6.h      | 1 +
>  include/rtc.h       | 1 +
>  6 files changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
