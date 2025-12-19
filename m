Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7782D711D3
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 01:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA59780077;
	Fri, 19 Dec 2025 02:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BW+gPtHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0957800AB; Fri, 19 Dec 2025 02:51:25 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E18A80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 02:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso92695a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766109083; x=1766713883; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQQQ/NO6hJAQKi3OZI5WtoDAH1W4Lm/UswBK3Ra1n+M=;
 b=BW+gPtHhoSjEL0Q/mSu88kupqdcpHlrT2fFXmgXoDN+bAMKihDyF9y9bKpLmnyd9Oz
 MHlUAIcmZ911/0R7rJq3rW2qKHyGfTaD6rpyyELYa2ViI1nBldbhbdBAc1vptzCmNR8n
 9XDvMpMI0TfjiGfG0CADcb6K+SAWC6s6jPPpdntd/MQ6VvuUMuedgo0JNfYD0FesFo+Y
 SmYX71e3vRvLjIuo6N//PcXZjFJj89aG7a1vvsV+dsioZmC0rY3t7oxyVPtZRPQ8g63N
 H5uGsgSLlpiVqZCWMpDULXX5lAnseJMV5KlPRq+IoJaznk3nw9lK1NHg60cY0998to1L
 McEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766109083; x=1766713883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQQQ/NO6hJAQKi3OZI5WtoDAH1W4Lm/UswBK3Ra1n+M=;
 b=Ncc6yIX5ETfKNiq4co8k5oqXbYgslH5aunlDDorPH/U9dqZQrlmjyr9QNCfgTssxaw
 pOE0IvZSxmm/FTe9O8YSYfusGEYw7sXp7RR3UIR8poq4/Muv/iNrmO7xO9FsTqZFN6ga
 vNaybY1wYojNQDfDNGle31AQ5Y2++D0TBaoSe7ec4Hc+M+NkuJJEmNAXCFshulLNYu6Z
 leCx0w4Xli76dbvVAhxxJh9jf1EKewThPVeOOi/whP/5I+116injecaCwBalFSlIL/8B
 8NiVddT+XcZQhS57sbIJ4bX+e0dxTGMXuIUaHMc/f7M94ShqKkNT2FWCdtzWNJPcwWML
 pI2g==
X-Gm-Message-State: AOJu0Yzbr7reOr4GnTPFuNFJ42RZG0yYLxisgLQt7LcVR26+h60EfoTc
 Y7YrnilLyobTbT8EGrKdzHPCaPwEesoP6QMz0bLyRoi48dT0FgmUFaCm9lw0BxogTXCkvfmY93Z
 kax/XyiG9sBpm0YStrCEQ0YKG4CgRJW8=
X-Gm-Gg: AY/fxX4QkpnS587zxqwODcEwrkdRydaE6fCG7Hv2Q9YV03TTeSr/7MYO5wjrl6PcoDh
 X8ChqGLznrYNW75/cl2GweTFsXc5TLjPTq6X5WM0gm+dElLYqZ7/PlDDW5i/6WgLsPrHx6RZPNl
 bQRqkRzMhBo/HJQlsuCJkA5Ai8QG9X6fY4c600BPFhud2c+rqW2hfVTwl/5Ht497xcTZJr2WQWG
 rJucKJxBaNRFYRui0ykJB3v3SrhkZ9lWVd6DHBUq3jfeyvhxy/T26NdB+7INPCfrSJxLBzCTz8V
 5LTLfzhSpxHz0OyMEZenVc1be7wgsJVmFuimUi97MS1u3UmI2NqjSFVTiH5xfPfiH1xfXqOVzS6
 OXZw62umIfbQ4d/EBXxViKGOv6YZ7in+0Z6cfig==
X-Google-Smtp-Source: AGHT+IGWDalrcRZfR6n/ND9gsD0JxyDraEPmWbEvBzsWTWBtGBK8S5uxLOLl7EpOy7K1CjGBXYox81/fBKOSv5pVU6g=
X-Received: by 2002:a05:6402:1467:b0:64b:5851:5e7b with SMTP id
 4fb4d7f45d1cf-64b8d34f12dmr1525624a12.14.1766109082835; Thu, 18 Dec 2025
 17:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20251218232255.3934258-1-trini@konsulko.com>
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 19 Dec 2025 01:51:11 +0000
X-Gm-Features: AQt7F2r1xMETn4vOxSL8QDi7k6CgvJNqH-UecPCIXQpvWHAVHVn7cdOLwLxBTyo
Message-ID: <CALeDE9OaXG5FYCBDmDCP6EDw9CSHsic+EDfiSjsAu_BOryk_+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Update lzma to current version of LZMA SDK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Darek <x64x6a@gmail.com>
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

On Thu, 18 Dec 2025 at 23:29, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> A long while ago, Darek reported that our copy of the LZMA SDK library
> is quite old and so vulnerable to at least one possible security issue
> he found that was fixed upstream.
>
> This RFC series does a few things. First, we introduce a Kconfig option
> to enable LZMA's size reduction option, and enable it on
> gardena-smart-gateway-mt7688. This is not critical at the start, but is
> as we move forward. Next, we remove some files from our initial import
> of the library that do not make sense to keep in-tree. After that, the
> next 5 patches update us from the imported version to the current
> release of 25.01. This is split up such that few have the very few
> places where the update requires some slight changes to our code be more
> visible. This in turn is mainly that the file that says the license has
> changed, and that we need to guard around some unused upstream code that
> also conflicts with our own code. Finally, we restore the spacing
> changes that our copy of the code had, and then improve things by adding
> SPDX tags to the LZMA code so the license is more visible overall.

Does it make sense to try and get the SPDX bits back upstream so we
have less delta the next time we rebase?

> I've marked this as RFC in part because I plan to follow-up with v1
> shortly where patches 2 through 8 are squashed together as they're
> mainly separate right now for ease of review, but the split doesn't make
> sense I believe to preserve in git as our changes are so isolated.
>
> Link: https://lore.kernel.org/u-boot/CAC7rXdTb5u5pzP-mr_+pddCxzfcO8Vm_t-=_+5wxRitMjy6-JA@mail.gmail.com/
> --
> Tom
>
