Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E11C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1977882A46;
	Tue,  6 May 2025 15:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kc32FhDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A2882A39; Tue,  6 May 2025 15:24:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C7C82998
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5fb7717b02dso1712034a12.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537878; x=1747142678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GeBNcAZA0YctoaXSTdZD1UM5NNpl3dblYINu+FtWKaU=;
 b=kc32FhDk6n87qB3x38HAAojE7iq5QGG6cd4r3ZxCpD9i1gl8DG8QysnuxQvbOef+YZ
 wHLP1T92QssiDy13ZfT7LkBYt6ARp6vvWG0Zge9RP2ghdg26Xj44EtOoSuPH1sim+I00
 w5ZApk3F3zEn8ukbJDTGOZteGXhehbh9BdhgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537878; x=1747142678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GeBNcAZA0YctoaXSTdZD1UM5NNpl3dblYINu+FtWKaU=;
 b=NGtDNBwLphk5tp81sci6yjVtY4cpsNXFdnOYzxRh4uzIMws4M6xt5U9d5nuUbMCIrx
 DPjbRwfnc+XcqZOkYI9sqAAiF8tLAJ3Jb8QAhn7S1LL9YKhXmWEzEQrgcN2KZGYzyZjC
 ddXt6JFB//JIez4YMZldeAYh8orp4TnYWoPY/AQUZX6tOV7RzeAMjhHxvxJIvDxwyI9j
 QeIEx2qqzA1sYe6lmEVQ5VaKgpMnQ6JLRAGxgB64kax17bKLvsw3C6wJCmz8I0ykqvn4
 W8SX2pm/mltEuv4YrWVEK/h6c0r5Hu7texEZLa8NXpcPHN6ddKvke8hUa1um69cGHnIp
 681Q==
X-Gm-Message-State: AOJu0YwjrllAonCNcUaubEV2iZ/LaqfdQ499AiapjxXYWpgZXjchqw1V
 3lydhBHH9MWi/pHSh/AQH6aP+tUj8g4Dun1f4gXjIqzDdsnl4aBnoDGjMkCzMdF/W6wnavxmbD2
 /V9f3SzT1fRVGv8PrFPpPdC1rUG9eP3M2w8NWv4DBELXEImjR62BcebRjXw==
X-Gm-Gg: ASbGncvkSdHa6eeP3KjgmedaObhKfRdtGhE7BZ2J1f0c1Ra3jbxCkPJ7s8lhHPlE49z
 yQnvIx9iKHKCbyUqTYPkZ1to4TaD0ZnHgsue97oRC0uGpEURkUQQhKvh00XERb50VfiqAqy7ZIJ
 +FJW/eYdJBPNxh114ArsNyqpE=
X-Google-Smtp-Source: AGHT+IHRsOrqOm6BRNgJyR3qv81bylUhv1KsmmGNvP2b3uwhNP7gMFjn2y4nNgpCYRSzxwnOJrapHuEsg4CLKuTm1jo=
X-Received: by 2002:a05:6402:1ed0:b0:5fa:abfa:63e4 with SMTP id
 4fb4d7f45d1cf-5fb70b5ef02mr2398875a12.21.1746537878337; Tue, 06 May 2025
 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250505181421.GI5430@bill-the-cat>
In-Reply-To: <20250505181421.GI5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:24:21 +0200
X-Gm-Features: ATxdqUGTs0WJOeTcJUDG6kdt_yG8DJdwUFaxi9Ime4cTRVFzzzk2UplhooJCRZ8
Message-ID: <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Mon, 5 May 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:
>
> > This series restores the original behaviour of extlinux booting linux
> > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > a limit of 10x the compressed size.
> >
> > It also adds RISC-V support, since it uses a similar format to ARM64.
> >
> > Future work should integrate the code in 'booti' into main 'bootm'
> > logic.
>
> I don't like "in the future we'll remove duplicated code".

Small series, fixes a problem, can be made larger but then it isn't a bug-fix.

> I also don't
> like not seeing that what we really need to do, in all cases (not just
> booti) handle decompression like we do for FIT images, and ask LMB to
> give us a space to use.

See bootm_load_os() which does already do this.

> A problem is that CONFIG_SYS_BOOTM_LEN was never
> intended to be the limit on *decompression* as it's the limit on what
> we're loading to memory from disk. That's what getting me unhappy with
> this part of the series.

From what I can tell, that was introduced 11 years ago by this commit:

081cc197472 (HEAD) bootm: Export bootm_decomp_image()

I suppose the idea is that BOOTM is supposed to be a limit on the
image being loaded, so it is compressed, then the limit needs to apply
to the size of the uncompressed image, to maintain parity. Otherwise
there would be no limit at all, since it is pretty easy to devise an
100-byte image which expands to fill all available memory.

Using 10x the uncompressed size doesn't fill me with the joys of spring, TBH.

Regards,
Simon
