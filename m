Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE234C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2598880EB6;
	Thu,  6 Feb 2025 22:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nwxRVKQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47FA80C6E; Thu,  6 Feb 2025 22:27:47 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94ED180C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso262102366b.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877265; x=1739482065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SdbKtfcYD48Juwpv62R6jowgjvBYojQTzuJnsBYaKus=;
 b=nwxRVKQtMhodlzqkVeMFOtRfj1w+V1oL9Qz8arXC6AmSVPT5QyHnRXxmySSQS1nV1q
 IerkDRX3OngZ7Iy/0qUSm1de5DgBujJ3WTQQwbOr9ZZlIWML+djfEzGf8ABg7XM6pU9p
 VnqBNm0QGWiid8GCKIsHj3R3Hq0xi2p874wSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877265; x=1739482065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdbKtfcYD48Juwpv62R6jowgjvBYojQTzuJnsBYaKus=;
 b=Qs2odJzBMEuRQjP8qIk17pT8rsgI0QkfwFCIa5s7VNxkKq7hFMdNi4bKI7/ffaYQZA
 iF5u/DgElqcN68mISJlomXZ31+5KvUtz/LgcWrkaLvJjIyxiq+7cfxb9WtVRPpFgmXbY
 r9sdh3KCi7MQg+NumTqGhKR7zYbl95SMdWPsT2gWBz/I7ATNU9oIl2np6s5dJukpk25Y
 J5G3VxK034mE+q9Fbv5NFw8B8K8JWmQkGT4aO7YSvsywFuzxkecyNfgSz9r0tOcR7X8t
 uQir0GgFoZCN15Q7XRFL+ZPpLJrPybg23n8GYb2ugtIP5TcT2qS928qjD/igvjzy5Kv0
 dgmg==
X-Gm-Message-State: AOJu0Yyzg5Bq4ogKGZfjBd1rq0c2n+Ieey72OihnxpRm4MNnxexh68l2
 Jfk73z16d6NKpil8jBqbroWeVPFS4kwygZsJLaKhJhJQgIsQaJQtaRiMBVXmuuez9C8ufy8N1AU
 quQbUZ6x2LGY9TXrkoF4b+7HyvvBl/P7tThXpaLzZP5OSpw0=
X-Gm-Gg: ASbGncv7K1o892e05JzSE94zsiXEaNwO/Eq40Xcp56R0ppXO50fZb3gW5O8RuFifqMb
 GWQ0wyrwCIvMutDuJDH9T1TYFuFAkxBFS2L/lEgxoIdb1cCMeBY+I9CvvgL3o+ZO9NJ7ZwoZsTg
 ==
X-Google-Smtp-Source: AGHT+IGn/ojO3huC1emEa2Yz73Vhk9UYU6fxO3MpyCYBDancd9fHMGqVvMuIQqzFxehxZhbkVnK9xZu5DyJa0MQmvVo=
X-Received: by 2002:a17:907:9611:b0:ab3:30c5:f6d3 with SMTP id
 a640c23a62f3a-ab789aed768mr46850366b.9.1738877265057; Thu, 06 Feb 2025
 13:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-15-sjg@chromium.org>
 <20250203200902.GH1233568@bill-the-cat>
In-Reply-To: <20250203200902.GH1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:30 -0700
X-Gm-Features: AWEUYZn39wihWTGbN7Yd6xalLZxMThxAuqg4QFIAiWJIQhYQnXDDlfVR6fSjp2E
Message-ID: <CAFLszTgR==OvRFb-FBF4OHfr9zAjM8mz9G6ts8Md7vNuv7oqkw@mail.gmail.com>
Subject: Re: [PATCH 14/32] efi: Rename ImageBase to image_base
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
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

On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:07AM -0700, Simon Glass wrote:
>
> > It is confusing to have a camel-case indentifier in the link scripts.
> > Rename it to fit with U-Boot's snake-case style.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This isn't the linker script, it's the crt0 file.

Yes, it's referred to in the x86 linker scripts. Probably we should
rationalise some of these names.

> Given that this is intended to match up with
> https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (which I
> got from looking at the commit message on commit 216459d2cf36
> ("efi_loader: correct SizeOfCode, SizeOfInitializedData") and
> include/pe.h I don't think this is a good change. Heinrich?

Well, pe.h is a file format so I don't believe we need to use the same
code style. We had that discussion when the EFI code was coming in,
and decided that it wasn't a good idea (as I recall).

Regards,
Simon
