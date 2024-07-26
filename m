Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE58FC3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C451887D3;
	Fri, 26 Jul 2024 14:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q+den+yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C4A87C7E; Fri, 26 Jul 2024 14:59:28 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9ACB88718
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d31ef2c73cso588333eaf.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998763; x=1722603563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YmhYRr5ztGmgrmYOtEqxoneP1/veMrOSYG+azpwZKcY=;
 b=Q+den+ywvKyegU2g1zm0B/kAWNabyIloAywaJKy9zfe/ccGXfvW4Hpqaufm+n6IisU
 /tT5rQLBH1/oi8iEHEL57K/e5VKZBZ18FZQEpfTZxZDU2R2BAw8mdb2afWJpxG7qsWmh
 aZNFR+rPHYBa69E44yZHoxRJpAGqZrkyncsJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998763; x=1722603563;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmhYRr5ztGmgrmYOtEqxoneP1/veMrOSYG+azpwZKcY=;
 b=rel7fkQVbbjE1XB6Sk52iDMrIaO00/Fd9CyL2E7gwWN2lUsmEly+vDxikMdmzaA+cH
 7cQ48KFtKY94gJkHHSe4Texa2xB+Bq8+jIgqvIMbRQ0chosCbQVQkTrDLVmrhchLc9OS
 BqE5v6uIeEVLcQLMwEYW8PVnNz4XcXQYvXS1fAjyercbq12vsU4c2dTsEBwHxwoRjACs
 eeYRCCVoPawEk0HsPJMs2nPgaeOdn6NkHCu88c4d6aqOyAeQrnGl4jdIkrFrR0QSYs03
 NFzg4Mp6iDT5okAvh8TEbpXGtXgfelmO8RiofElsFwM+Sig23+r8ZIRxRZWMzYL6pF8y
 WLmA==
X-Gm-Message-State: AOJu0Yy+fZg/MKeKPm8BR63L7NBjIIE7oVKM1MRkelbEn8PD1GO6BXkK
 fSnPXmuvS8gjggD+U4d8JLFifHiMcJkxnSoShMkTvPe+Qlfh60/M3LIq+0oJafweQZKI5lO6Lxm
 T6zjvJfCw04rwW0ftayUEUsbmKKxglFdAIdX+
X-Google-Smtp-Source: AGHT+IFp6gL1Vi3PDbRrfow7hhfVkNQ8A95f5uFcVWmQpdCKHBrd+SDZ7Z8HhgzpZahXtxeyB/DxRuIbrENJfuKTJpY=
X-Received: by 2002:a05:6358:718e:b0:19e:fa9c:5ec9 with SMTP id
 e5c5f4694b2df-1acfb8b1371mr551053755d.9.1721998763505; Fri, 26 Jul 2024
 05:59:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:22 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThkmy0RG8HBFAsmCVf7h6S1Afa=SmuQ2PvLotxd7C=48Q@mail.gmail.com>
References: <CAFLszThkmy0RG8HBFAsmCVf7h6S1Afa=SmuQ2PvLotxd7C=48Q@mail.gmail.com>
 <20240702170009.484961-1-andrew.goodbody@linaro.org>
Date: Fri, 26 Jul 2024 05:59:22 -0700
X-Google-Sender-Auth: iGe75Zk8_yoXSAa_ookEuue6DCw
Message-ID: <CAFLszTihVjTU51Of29DbDJa3mRVw=tMD3kssixBp7kODMT6FhQ@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Fix LTO to work with STACKPROTECTOR
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 2 Jul 2024 at 18:00, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Add the STACKPROTECTOR symbols to the script that generates the
> symbols that should not be removed by the use of LTO when linking
> a shared object. This prevents a fail to build due to link errors.
>
> https://source.denx.de/u-boot/u-boot/-/issues/35
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v2:
> - Made the new match more specific and added it to the grep run rather
>   than run grep twice
>
>  scripts/gen_ll_addressable_symbols.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
