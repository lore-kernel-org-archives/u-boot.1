Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A09CC88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 19:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 912A0407B5;
	Fri, 11 Sep 2026 19:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wH0fkdObE4IB; Fri, 11 Sep 2026 19:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A1D0B4070F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789156610;
	b=IKp0TMaUJfQnB9drURQ2mJkw7dziYY043L1gL7nGV0AqbHaznfiZQgKJvnOPHKEPedMs
	 5qFWQL1xdvHRSTunePvP95uRDvNxCDOuy3ZDV95qHjmUluTefATYRlrTIROFrXslrxRNy
	 O17xBMrcQe47NLhJjupSIAWvoP26iLH68Smz34/Io8kgoPqru2DPPRV5yv3NvdBsYab0z
	 Drnc4En8OjM8bgL9wLbeHeIG6exnnV0+6m9YV2CsYGzXsGhS+a8vgBBtYcTCX17oYKtzw
	 KkfKVQVZ1uXuVDGGJ3FWZHsYNa5wPDQuO3dWn4OUorSdYzwEjj6fEO/9xVpk2DCiJvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789156610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
	b=mu6qOM1sQ82gLb08K253/y6B00ZOUz26W6ECgWuHNs1d4eP/rI062Cju9YiVSvx/4J+G
	 1/ZacmuEJ8BuaRAgAprHyAveZI3Ff9vZuxW6CEVKdx1RnwidrFmzTgxRDkHwLIpygwYHE
	 lg8S3kIyZxMnh4CtJa34F8oB65Kcr5RNgxvQHIgFtU+9xVhCp01lrerHH8C91okm1FNIi
	 z6uQx4Xw9inVjcuSNUXHhBiZsNOYzX2rpaCdqKWKHwMm80NaN6psaMOOgho7Kfo1mpTcy
	 lWX+mwLy82FASC5GWVVaGRPOQopxS58dIJqPg9C7yZxlCAAPOCmLuHkhlcBelUgLmIg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789156610;
	bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aKaJSaqDb05A6bN6bMUkhga4hto9WaEHDmVmK90/0QX1HG4oTzBhnJaMirGyPFPRH
	 fMXSCw7UeycUJqsTVy+SmM+kcAwf1EZu86PHpkHcziNW/oPY+EjqNaXtRH5RodyygK
	 87pMo7gODDJpbV71PswsKxSuVUZKc07quSW30SBBPtWZqliKZ6U6QQhS4hX0w2dR1Z
	 qf4T4bIj7U1Hb2c6xO7y9EdO+WrTzgDeyJDGVECn9XhX08MvEpi+kXokaYSqwa2Y9U
	 bBhgxXdOmrFYyCVTjUOTh5Hn6r+LdC+79M9YFAQKx1dxe5L1rLG7dK7G/Pw4RPT3Us
	 3niC1aX3IWN7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D0B4070F;
	Fri, 11 Sep 2026 19:56:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59BB4701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B15980EBB
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_Sg93mPWuw0 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 19:56:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 45A0A80EA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789156608;
 b=GlI7QQO/IfiMKjYrOfcksP6qQfAnXkY91GRURTMbWFC4evZNBm0u8ZsAZkBrVicHLk6Z
 6teoWWxHjR6d2zAi5R4cep46mPxGfHOaOKe9RY6xJMeRDs7ITC6F1dNFWNAl2c1P5wwff
 qShaKqFmKuy1LKRDQrPr9aDMcL/Xot8XSrxIM7dBapyFr9ctdZHfJ0ttJcvu/cFTqc6IT
 Zuw0yrdzXfGTlitEbkKuOXlLUQp09fWs/JcbjAtmAbQ/Cy6udwRPUExW/TwjuTUS8cRAm
 BrJKb3M9XdyHX7lA5007U9n2FJmPDD+DtwlB5MSiCKW6ZabD2+0DSiR8cC3I76DvFzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789156608;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
 b=T2QdCGjCwCsXWn7GpsqWAyTusdAJvWGEVDjP/WCzbXTcct7nJ5P3dvXArDQV5GdoPz5o
 7YtupwHZchAht9gKC8XiOG83TDgWdRa0mZPdeVN0qCOhiZnKlLQCS1BSakvzRNy+BaUAk
 7uwyEP5wBrW16CfFzSdsL9essV3qrrzHdJBOPVq+CPNdOcv9kxYjtgC0M56JQShEjy1rG
 uorbZtR8zt1PFAsFfgjb+QqRwwP99qN/tyR8uYJ5xCzqvts8s8qdM3NPH918i2RjmaKq9
 PNub8O7gcjvWIy/7KRwyCORzfwUksahl1rsI16zgnW7qTDgSPw52Kb4NbgFJvE9gqXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W6WgXVxY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W6WgXVxY
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com
 [IPv6:2607:f8b0:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45A0A80EA9
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:56:47 +0000 (UTC)
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-52fb769ca17so3165891cf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789156606; cv=none;
 d=google.com; s=arc-20260327;
 b=na7IIRqRrqDYhVq6HyfPQlb+G9HkT2+oBHcZ4kgI6Iagt1hKUuo1KnWV6bwVCy0XNu
 KQahooN97ni/yFMvcvkTsVbPioKybJ3SPq0131Qc4Fwzkr+m+AXoZpF5LR3xZXcTuMg9
 ft2kULniblZFVTPvWzcROovyFO35Jm7iDD0K2i1AaJi99Nymi+dGbp+Y/EsuWlkiPktz
 7NrHarSzAzENpc+ao1yLdzyiCo+9bpfqCIE6J2kTdOBeSOzvCZ/qIUeVWsdLxC7FL+Xq
 klN4p2WygyHtNOZqmBVc9Gd5TAz6hEBhGYjAjOOeksVH0UgWlabpvKZvdL25q+Tnbbyn
 f9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
 fh=sCPP4Bvj2FgXBt6hsyDPo4pCTcrfALwTOCkwnZmGzAs=;
 b=grqmJImFgihfnMTiqfN0bS2ZcrBFc13CwiMVeAubYK3hodf+o3NbAiCyK6euHdKPyw
 TKUJ619wQn5KB1DmbcgDu7scJPryUOLUCZg5gAluk5dbCKwebzRxe15Y1X1ln/ysIgv9
 pNnzr5Nlc1mbmVI1Wv/mjGO1KZUNMjXEIyovn8LOu+2lJEsvraeRA5X4beGZ1iRyYFvn
 fiSPwn0ng/bzjppCfK3aNaBEabYasYkNRRCXROYRNWgKeLfsgCLzdsv2AFgekrOvQUP6
 I/SpYRGeoMrae1glQadZFBmAhObzRZrJackpfHtO75q592MoKNBpUOkwzOzGC1KzeF8h
 ISeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789156606; x=1789761406;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
 b=W6WgXVxYyh35gD91F8s8dSfrsCxajKnPJvWW2sI+KHttYS13tzN2+I9e73OrEeOHPU
 s4Mi6YKGzp3Oan6/7zk0EhYK2GHb7iLx2UcwhUuR5pIonCYJHLr5dyxEKdycZ47gJH6o
 UjY8R/QL8WmXezOEuSrsUunFRmd2jdOXH38Icw12pXjCk6em6bX8mn1nEhrfO/S48cb8
 7gmQQ8j51hbxoXXY1VetuVch7gCDEHRo5CPU8lN7a1e77gWosTjR9VQaeyxumozIQpaF
 WKDOXBEvdNenY1Gk8d/I0PYhHZ219JR3RiP6yYLMJy0g+Ps+5ulsaHupc4xqWxeUyaCk
 GnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156606; x=1789761406;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NVwmoqT8YuzUKN22jgjFJI3ddCxOkLxFvXKBTPhID+Q=;
 b=DlL+WeLeTC1+XK9Bd6UPO2O/HXCAD222sB8YcNysrHzn/CdYddm328sBunZuAbyYr/
 qaZ1xiow2jYh8TJUu5wiw+QTpO3GNCzeYq7FsInnkx6O4JNMJxbFWmdQnICGZKk087Yq
 x7Q2ZjckSpPma2wGKZFx6P6RdCwktt3lbtM5st2aAjO8yD3Zyw1lMtzxGchgjLPlrJlM
 pQ8setx05VQGhaXPdFfgE8XrlXewVym2BJwq6BpFnGehpJHayqZOHXONwns4LJ7q5he/
 WZbL1gItl9VTda8eGbC6y3V2mu5ASTCeC/IPH8cxJrly1m0Cxf1zUn14R3kciLNkRReJ
 02pA==
X-Gm-Message-State: AFuF++lyHbu65/jg00rSjPpIK9bgbJLbBLPX+DJYDg9x1UlABKThtO+C
 ZipACkE/pMMEz9S5W4a7TJBOKD4oXhDSIZTBlAYfDeVFqk8TU0Xz1HtJSYZmlTtUHSnDl2w0SbV
 h+xULt4BzIOVH3dGJD2f4j37YTZZpuR4=
X-Gm-Gg: AYBFou3av/iaDg85r/GiYzblQjZUJtf4aUr2wK39ZG8Qyyg+X0FoEDsjS4P0dB4W2R9
 4AFzfCZ7E9e2MvS8H8Hhjpybmqubm1EIx8PUaWPEs4GdWKXLRjfDfFzSCJ8ks566rWoP5sLHHVI
 VWw2B1NnfO1K7zB5f2OIerkDjVA925yu61u0ZzIb0qd8R2aJG51zEgS+5CW+nSz7wdkwqK83lmj
 gwtRYIYRFNvqII4FaWv3RuUXr1YQD8E8M8S53O7DQ7HFapLoU2uJm9GCtwcNfkEjIWtKlYPoLkj
 YhIkoev4Tijeh7pN0lAYj8j7vUYFiu198v/ltlfSkGH/Ja6F1sk+/xLHSNsgV1qg/j5t85nNyzI
 JUBeb9MdxnM1lC3zQhbwopLySueaErAAC3hpHJxz85PppoKLQtFbYP6lFBFq4KUy+GV4nE3TT2M
 aQFiNNUSOsxdbSEnmd1UMhLAQyq+R2HYGZ7zM0tPxd7b+yh+vQpQ==
X-Received: by 2002:ac8:7f54:0:b0:52f:9f8d:915 with SMTP id
 d75a77b69052e-530c85ff682mr102280891cf.26.1789156606417; Fri, 11 Sep 2026
 12:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
In-Reply-To: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 11 Sep 2026 20:56:33 +0100
X-Gm-Features: AcwNN1VMljTSQOi47f4-R3N2v2WTMuUTwo82dJAXJIloYXmsCKWtVIEmti-eVqQ
Message-ID: <CALeDE9OkCodeHW1MyT_BYULp+ej00fUdv305SR0+pjR+H5WGtg@mail.gmail.com>
Subject: Re: [PATCH u-boot v2 0/3] lib: qrcodegen: import Nayuki QR Code
 generator
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Alexey Charkov <alchark@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, David Heidelberg <david@ixit.cz>,
 Petr Pavlata <petr@acrux.cz>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Petr,

On Fri, 11 Sept 2026 at 19:25, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>
> Add a small QR code generator library so U-Boot boards can encode
> arbitrary text or binary into a QR symbol. Main use cases include
> displaying URLs, pairing tokens, serial numbers or
> self-diagnostic state from the bootloader (e.g. during porting to a
> new mobile device with no serial console or usb peripheral working).
>
> Optionally apply gzip compression for the QR code payload.

Is there a way to easily test this functionality? systemd has similar
functionality so this is nice.

> Three patches:
>
> 1. Verbatim import of Nayuki's public-domain / MIT-licensed C QR Code
>    generator (qrcodegen.{h,c}) under CONFIG_LIB_QRCODE. No code
>    changes and the only adjustments are SPDX header, swapping <assert.h>
>    for U-Boot's <log.h>.
>
> 2. CONFIG_LIB_QRCODE_MAX_VERSION (int, 1..40, default 40) so callers
>    can cap the maximum QR version. The version trades payload capacity for
>    smaller static scratch buffers.
>
> 3. CONFIG_LIB_QRCODE_GZIP (bool, depends on GZIP_COMPRESSED) and a
>    helper qrcodegen_encodeBinaryCompressed(). Perpends four-byte "QRGZ"
>    magic header so the scanner side can detect and decompress.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Changes in v2:
> - No code or commit changes; correct the cover letter's To: address.
>   v1 was mistakenly sent to the old lists.denx.de address instead of
>   the current u-boot@lists.u-boot-project.org.
>
> ---
> Petr Hodina (3):
>       lib: qrcodegen: Import Nayuki QR Code generator library
>       lib: qrcodegen: configurable maximum QR code version
>       lib: qrcodegen: optional gzip pre-compression of payloads

Could probably do with a entry in the MAINTAINERS file a well?
Presumably this uses the existing gzip support in U-Boot?

>  include/qrcodegen.h  |  407 ++++++++++++++++++++
>  lib/Kconfig          |   44 +++
>  lib/Makefile         |    2 +
>  lib/qrcodegen.c      | 1034 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/qrcodegen_gzip.c |   45 +++
>  5 files changed, 1532 insertions(+)
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20260611-b4-lib-qrcode-a5ce89e68f85
>
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>
>
>
