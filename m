Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE41FE8385F
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 07:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E397583981;
	Tue, 17 Feb 2026 08:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z2X7wZkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9295F83AA9; Tue, 17 Feb 2026 08:15:14 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529B38063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 08:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-649e97f1e1eso3110465d50.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 23:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771312510; cv=none;
 d=google.com; s=arc-20240605;
 b=aLh/yTwIiRlmz3y+9va45/6QSaGHRvrRlGDCgPAsRg6RrzfPS76fieCkwWCoTteSjb
 xZ1CnD/4wnDhOP5qaRluETB0qSCK5XJrfKGOrQCyO85IvU/WCGPn6ZvzGr3X/eXinMMa
 B1ofVAw5f4XtyXT8lYLK8fNOkzEewqKRckchqqrsxQIt17XBn3KAT5IG+vl+sXV8Qywk
 p0vjiO6V681MF1MiBAx6OqRbR8UVzzbJ/SBvL6Mphzr/w9IqIQznkcXTgbY7CqA0iJMc
 d8mX4DvmbigszhVMfXjKhFw6WF4PPJRjevfnlIoG5PzgGI0CbFAGy6rv171yqHWbRRiz
 SSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fxa6oW7M3eo3QGS8dNUzK19VyXqM/uZ3TRrJr62EUJg=;
 fh=rN28YA54lzqiGq96LttaGmOTBOSy4Tx/FAOR3EpJLu0=;
 b=FzgzoHyC3wM09VTNzwQL9R2nz83CYBUs/oknNiAMYOpN6zQ7zpWMXJY/XuxdqQKCtY
 ej95DelHrIqGtqASmzbPErglkEfrcFwwzzDMIhcefbsr+0dYkwZ+0EZTBt8naMwRZX9t
 UROr5nWJuylORaX10TXfOHxXezuS3DQTRwHDFQh47j37cWEKNSqWarnxo9D4hm1mhph4
 MbQ5nnXQvwc8zs7O2/FeeN35UjG//J87svzO0Pr9AS5m/lXlpC41w/gUTMjualWZs/Cj
 Or0sDxz3o8y8WzZYlNUu/gz0Gl76gFIVlvoOZhXGs2cVvg9fmqIYbSYv5D4n6+SUFNjb
 bi3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771312510; x=1771917310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fxa6oW7M3eo3QGS8dNUzK19VyXqM/uZ3TRrJr62EUJg=;
 b=z2X7wZkf1IguJdL50QhkUlFWAwRxmydNjHS0FflLnZG8p25xOHerFovNFHWNq71Gzh
 mUE74TFPdkgRMnjOEGNO5ot8A+QqXhUSqiITZ3fqpJYYvlmq+QPOTw9pjRhDyzZfm/FG
 aKqsbXRb1y4uF9E2woICIuH2Ke1FWvA6X7wkZSxwSKjoeZOVNIiZKS6xQZ+yw8IPbO41
 KkmB5mDvAhDAGOdtV0UOKOKLo6IA8TAdyAgb89XUxkE5Pw9PwBsx4WpQUgk9SRDH226W
 /5saiXwIW5Ewy6C/H4Mg0hQMhxDgvgwj9f/yOWdrhJif+NkZv06tP77eGxQ60oKWLOrt
 2NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771312510; x=1771917310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxa6oW7M3eo3QGS8dNUzK19VyXqM/uZ3TRrJr62EUJg=;
 b=oi/gRZ3xwLSgx2CVsQtgNm7sYmRuoB+1lHoDpCzEyh6sOydM3HLNQeMCbjXj1R+maV
 cmgk9UR9VT18MAXVeOXHkMKCS002B3odSFDvns7i3spiMq9SSYyIGRUE5vHtFWRlZNYc
 Y4xbGtXiz/moCVsth2X2ziHGHSU75bKWB2VXIRxFgl7Nq0IrowMGuDhitnurSzsFyQlT
 W+q1q5i61QQN7BJWHIgC5xBunqUhdrLoeXPC9jxu5YO37ZHpk5ux/s+uusyEWFZ8Jlb+
 tNQBzi6aoBjwigTtP6XaPoZ5Sp7+z3XCMkvLUxa8+XLPO4zrzxzrcqLYmB3FNZsRAQ/2
 Dhyg==
X-Gm-Message-State: AOJu0YxRjSoAfLkXiTsZhf3mJA5WXjLhI0fs2ftv5VoAo+JgCgyHZ9/i
 IiwEzaHEJB7DZ10lSmtwmRvd6AoXJqAdurOtPch2qrEnLzJxpyBXstoFly0VCole03yixP2V6In
 7tjlLBia52VgIURMfag3z5LXj5nIAKfPA0AOBrXV6zg==
X-Gm-Gg: AZuq6aKaaXKtYydUZzQ8cKQJT2n3jBRvLPEhnyLDOYoMFXsp1XbyNw/0cffemKZSdvX
 RMgYN1fBQi1RmTTNLfe2i1zqoDM1nO8J2O1cV1goZMrMUMlJqhyxhxO9bVCJO8aNLaHYL5eURtw
 ufOCWMer6ZAwy3HPnWHrwL6lUBORtoIpTcShIW2AUbSKjtTygn26WDvfi4Ld5ZdL0VMeHym/hT6
 qQ5yRM8iH/HUPNqZH6dBChDvtfjU+sIwBkbugQ+Uyxjyu6uiHW8jRuwsaO4c/vEFXAo4ic+1ROd
 DfOTx1lL+lz3uxhzCIh9sYvIi0ILln0p1f3Pz11ApFiFn11m7BIqKss/ku+59ulz6a51P40F0D3
 C0tynXWBRO2JS2OBukRODD51ZcIDx1/nfLJ1+e6mtzhjbpdy4EoCf28wFOL2td533iBWUz6PCJ5
 q3idTPocUb2BoVP6IQvvCSMC63dVxC+YbBb0eSluh53JJQuVszwQmr/N/0qOvTawfhSOpshQ8ZZ
 Mi22S9mcMcpzWPHk3qUISv5CQKGUPMUNjefaXdVmlpDnU8v88pYJDW+2xQeFlKcDI+9S6r9KW7L
 hJLSNdZNVTsLE0QOm4UGHJCgHpkzanEzlQRGfCdZTDna7gzsUE6Oufk=
X-Received: by 2002:a05:690e:689:b0:649:c7dd:d2fb with SMTP id
 956f58d0204a3-64c14d99826mr7752080d50.75.1771312509988; Mon, 16 Feb 2026
 23:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20260213225254.2544596-1-raymondmaoca@gmail.com>
In-Reply-To: <20260213225254.2544596-1-raymondmaoca@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Feb 2026 09:14:34 +0200
X-Gm-Features: AZwV_QhUL6YlCCsduws3IUcmajilzW5MqKvykFQ0sz40N7UGZvGrFeM5BTZuD4E
Message-ID: <CAC_iWjLaWYndgvrCFGer-8mgW+t1usawjy+QroW+H92NmY3WZg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@riscstar.com>, 
 Mark Kettenis <kettenis@openbsd.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Samuel Holland <samuel.holland@sifive.com>
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

Tom, Raymond

I tested the patches and they now work properly in linux.
Unfortunately I don't have time to review them depth, but I think we
can pull them in since they improve the SMBIOS reporting overall


For the series
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Sat, 14 Feb 2026 at 00:53, Raymond Mao <raymondmaoca@gmail.com> wrote:
>
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> This series finish the last missing puzzle of required SMBIOS types by:
> 1) Fixing duplicated handles when multiple instances exist in one type;
> 2) Implementing the rest of required types 9/16/17/19;
> 3) Adding version control when printing properties for all types.
>
> Type 9/16/17/19 are generally DT-based, the idea is to write these tables
> using a hybrid approach:
> Explicit DT definitions under existing '/smbios/smbios' take precedence,
> with fallback to scan and interpret values from the entire DT.
>
> Moreover, all below APIs:
> smbios_get_val_si()
> smbios_get_u64_si()
> smbios_add_prop_si()
> are on top of sysinfo, thus allow vendors to get values from other
> subsystems by implementing their own sysinfo driver if needed.
>
> Raymond Mao (6):
>   smbios: Fix duplicated smbios handles
>   smbios: add support for dynamic generation of Type 9 system slot
>     tables
>   smbios: add support for dynamic generation of Type 16 table
>   smbios: add support for dynamic generation of Type 17 table
>   smbios: add support for dynamic generation of Type 19 table
>   smbios: print the properties only when they exist in a specified
>     version of spec
>
>  arch/arm/dts/smbios_generic.dtsi |   12 +
>  cmd/smbios.c                     |  365 +++++++++-
>  drivers/sysinfo/smbios.c         |    5 +
>  include/smbios.h                 |  151 ++++
>  include/smbios_def.h             |  250 +++++++
>  include/sysinfo.h                |    4 +
>  lib/smbios.c                     | 1151 +++++++++++++++++++++++++++++-
>  7 files changed, 1905 insertions(+), 33 deletions(-)
>
> --
> 2.25.1
>
