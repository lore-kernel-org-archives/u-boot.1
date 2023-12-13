Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591FDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415618781A;
	Wed, 13 Dec 2023 21:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HBH+Xozi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF8887823; Wed, 13 Dec 2023 21:39:04 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E187F8749F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dbcc4969491so1321961276.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499938; x=1703104738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2YRyBC9xolyIZ/B+Inff0/8G90fZc8EH/szlN2WKsAQ=;
 b=HBH+XozimZGklRK58UctAvLdZGZ1fGfH7ctN4QjA6S62kbWO1uZmquCpvbRY22lbfG
 CrrttyEE8YMsGGAxlEHyIcQom+ZRtADcvCa0+Tww63+ILqOD/Rd2lfZfzc7nYl8bXoW7
 pWLd7cxsJ3RMfUXw3TlD0LP46trrrsI3P+Mdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499938; x=1703104738;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YRyBC9xolyIZ/B+Inff0/8G90fZc8EH/szlN2WKsAQ=;
 b=Ld+RYf6t9uaJJnhkH9gTZ5tuiYYPNi37EFP57n8dIxzJSPjw4T8R5Jb7ngEhIIcZvx
 b6+mOpEfbMdI9FxhipsTvRFhjs4Uzj5NbcKbsNrhm2/DFbimhrlgneaeEBYqWsh65slr
 U/96quIlO5Yh0wonShmUk5LoIcDY3NrKTzQILN8xSVARMragZ2ZtoZ1cdVsrI35Cd0ju
 ndtMJ5nF/AfTxEQjTmkZE2knseC8WC+0l3H3unduPRA4n6jsdnuqXuivBlTnpQaXJ4PL
 bWHW8pcU9ssKs5ujhQpd3EWKcSuk2zFO3/wQRdf1b0oiGxpTnbFscK+UUoNJ67epcimg
 1FWw==
X-Gm-Message-State: AOJu0Yxv1k0qz3b+wjOJQcQYg4HUwtqqbZWptw/78tGoO5ka7VfsoZZb
 9t8WeATTUAGOCqHNoOI40l4L7L/zl8tkc1o0YA1ing==
X-Google-Smtp-Source: AGHT+IE9vXCr0ukpatfs8ioNPtWsrpUz4+kWVAs+lAseCos5VFNU0Pf3/JfAbPKoK/iTPyRsoDOYysHNf5Ti3O/l0f8=
X-Received: by 2002:a25:2e4c:0:b0:dbc:daef:710d with SMTP id
 b12-20020a252e4c000000b00dbcdaef710dmr626051ybn.108.1702499938317; Wed, 13
 Dec 2023 12:38:58 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:52 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <60f3046c-2af9-40b5-aea4-849fc6999d3a@canonical.com>
References: <60f3046c-2af9-40b5-aea4-849fc6999d3a@canonical.com>
 <20231209185031.7275-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0wa=CK5Q5SCpPHZiv7zGLGXnEprzVTTt_P6iiP-zmZfA@mail.gmail.com>
Date: Wed, 13 Dec 2023 14:38:52 -0600
X-Google-Sender-Auth: GRJXjAssx2Wn3wKMqg7y8c2wjDE
Message-ID: <CAPnjgZ04Z0RPWQr803ukETtVih3qJhsZt+OJjn+g-H6XC4L-Rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: elf: Using variable 'old_val' before
 assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On 11.12.23 18:52, Simon Glass wrote:
> On Sat, 9 Dec 2023 at 11:50, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> old_val can only be assumed initialized in the finally block
>> if it is assigned a value before the try statement.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   tools/binman/elf_test.py | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
Applied to u-boot-dm/next, thanks!
