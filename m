Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B206C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 12:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6118988A13;
	Thu, 15 Aug 2024 14:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I3p//MlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249D688A39; Thu, 15 Aug 2024 14:20:45 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D2388981
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ef9714673so152475e87.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723724442; x=1724329242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3SGa6goI0F87emSHKgFsOR2tK4JZUcahXclUuqnhTQ=;
 b=I3p//MlWNKe9qW9gNWsT63BzBwZU4UT7RPwT5m6Dn46qYtt7b/UmF+XQX83ln55dTL
 GGnNogju6rs6b3CBsi8oBWRh/rHk5JK79lcAQMtpItHax3HB0oj4bLd1LFNktL+Dbi5y
 xehFK5DUyoUQ0fQZnBV107RS8dcZm647MPlFw6HGLD7SjO2F+6aZih22b+37IJk8rMgP
 J69tFXMloddXM4MriY3HQhc8vV6RpzxIubwTChBAN+ybULEnDW6mCMZFYnDVn/oxOu+Z
 GrKzEEZ4G6xXRQUSJX6cTFgklPmKf+4Todw8aNvOrun4nr+/QMnFRaC9hpfO94XtjpNe
 c3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724442; x=1724329242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3SGa6goI0F87emSHKgFsOR2tK4JZUcahXclUuqnhTQ=;
 b=TyPqXMWM9VB9JPBDWRnawxh/xQH2M9sJIIVLtt/xwCFQTcT4gR924xO3YP14N9nfmm
 r4r0YoHlaxv2z0McCQgHyZHaJuldjHcJ//yK2uHcwRQJb+OOi1u64yxV79n5ZUkUrRL5
 pGRNLx7uSo0dicB8i2wPuBWPAHjQO7nwCzmxRfzbCE1+1e9hYx3cX3IG7IjStnfQZgnv
 59qXMFlT+c4k2mtP2AjqPDKocedTGhcJZZDll/ZJExYdHCoGrFbUeSnjErlZeWI2qaCw
 2zgT9WWuyb4kcQS7cEtUeZhGU+skheO/aSDedhnDXYLPTfKrpWDKCQYsM3t9nr8hNheA
 xeFg==
X-Gm-Message-State: AOJu0Yy8xEd1N4t86Aqs83rY7WFyvFENyweuGLlUKR7UJxG0fnYFUpsd
 l/vGI31flwuyTfQz0BmlPhmdrbd8L9uYyXvCnSyLS7nVyaYhT8Mkf2n1lWDc8C6ZGVgbxoYoDlv
 CNO8ipMwI2zu3JG0DZrnhkQ/Yqws=
X-Google-Smtp-Source: AGHT+IE50WTYb40JF9wTmdyiiJ9uZkph0GM6DMAJWOq2LzG5NWH59P51vutUSleCTRido8wHESGcxe/2/J9BVHGH6eg=
X-Received: by 2002:a05:6512:2243:b0:530:baec:3975 with SMTP id
 2adb3069b0e04-533097c2923mr913356e87.1.1723724441681; Thu, 15 Aug 2024
 05:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
In-Reply-To: <20240808110654.4215b129@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Aug 2024 09:20:30 -0300
Message-ID: <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Lukasz,

On Thu, Aug 8, 2024 at 6:07=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> Dear Community
>
> I'd like to ask about one issue with generation of symbol offsets in
> binman [1].
>
> In my case the CONFIG_FSPI_CONF_HEADER is defined.
>
> Problem is with generated symbols [2] to point into
> ddr-1d-imem-fw/ddr-1d-dmem-fw/ddr-2d-imem-fw/ddr-2d-dmem-fw.
>
> It looks like only symbols have extra offset of 0x1000 (the same as the
> first section introduces) - binaries for training memory are placed
> without this extra offset.
>
> On the other hand - before this change:
> SHA1: 37e50627efacd8dae18b564e9d8886a033e181bc
>
> The u-boot-spl-ddr.bin was a separate binman "entry" (i.e. not section)
> - so e.g. ddr-1d-dmem-fw {} had proper offsets (as this binary was also
>   mangled into spl.bin with mkimage invocation).
>
>
> Now the question - how to properly fix this issue?

I assume you fixed the problem with this change:
https://patchwork.ozlabs.org/project/uboot/patch/20240815080948.457524-1-lu=
kma@denx.de/
