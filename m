Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E9BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F5A88A6B;
	Thu,  8 Aug 2024 16:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gaUwSQmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6C588AE3; Thu,  8 Aug 2024 16:28:17 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A449A88B63
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7a36f26f3so18282856d6.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723127293; x=1723732093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xXBjAqgmTEKBtlaXuCcqqw1uOlaAaYDxsj2BCmd5AcY=;
 b=gaUwSQmt9XvBo6xkT0X+1Dr67bXUo5Dz2mhTwXi8f02svIrRJrujGyosZwzugcd4ht
 R/lir50VOwEMMiGMgpeSFhp+r9TbpAwkVIlO+22d0ovGUXliKpz21QkrvR3SGiWZs+H+
 ZRDxC2N1CTOvqdAwY/EWET/YQTl/5msYpdKU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127293; x=1723732093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXBjAqgmTEKBtlaXuCcqqw1uOlaAaYDxsj2BCmd5AcY=;
 b=GrUSJwMZlV3hmif8b2AqhpLrhrK3K3pyybjz0R48RqD+cY0NRC3mTMS3mkhLjcy7NV
 TL018CSQumVScQLB2vTr/Fj8dao15f2aUaTjCDVm9SNR3H6rBd7dLgF95yhDofDYAtCr
 uDB584oAoV8b0nHVLwmotpPHIQjpZ74oWdizvWH8lwgsb7453zx1q4jzWRIjAtwLyEy5
 WujxPdXeiU6DmyLPfwtHnpnlv6PF2Yq1CEbsmUKYec35gMKHlrrK5bR9XYe/NKmZdSoC
 oJsD/TafZsZ6C5wbmj7knU0vEoRcNdyipYzPKTYiQivSZQF98SC4iV+hMNZF/y+6sS9A
 5HFA==
X-Gm-Message-State: AOJu0YyMykh0LrCTtTvjsHf5FluuNKBFKos1/8Liy2JoywYeSKZPvYN9
 vl6a67ce5ZrUbJ6oQvXk9CHf5cV7QR99se2ulWl9DRWZ/30m1D/eisDWI2h2HIHQfNkDHGRBD5x
 A9FKlS3IivpACM6HxMFKIz7FziCOcYunBrfy+0JlqqpXLxy0=
X-Google-Smtp-Source: AGHT+IEh+WHEKBN7LfgpCwvWu/JzZg+5Z5z8srV3cRCLyPkU9FhjzPdqy1+TtSyFV+jHcV6EhkmwdOMTieQ5NoEzYGo=
X-Received: by 2002:ad4:5ba7:0:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6bd6caf94bfmr34016066d6.8.1723127293029; Thu, 08 Aug 2024
 07:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
In-Reply-To: <20240808110654.4215b129@wsk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Aug 2024 08:28:02 -0600
Message-ID: <CAFLszThwMEoiXTQnogYd19j82vAeqFao=c2ZnWuUr-BiAPcadQ@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
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

Hi Lukasz,

On Thu, 8 Aug 2024 at 03:06, Lukasz Majewski <lukma@denx.de> wrote:
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
>
> I've tried to add pad-before = <0x1000>; to ddr-1d-imem-fw property
> hoping to "move" this binary itself by 0x1000. However with it the
> symbol of ddr-1d-dmem-fw is moved up as well.
>
> Another option was to try alignment 'align-size' set to 0x1000 - effect
> is the same as described above.
>
> In the documentation [3] - I've found that I could use
> "ProcessEntryContents()" for tweaking, but this seems to be not
> eligible (as all imx8mX boards, which are going to boot from fspi) are
> affected.
>
> Maybe falling-back to 'multiple-images' [4] and generate the
> u-boot-spl-ddr.bin in that way is a proper solution?
>
>
> Last but not least - this problem is not present when one boots from
> SD/eMMC as in this case the "fspi_conf_block" property is not present
> and everything starts with 0x0 offset.
>
> Thanks in advance for your help.

BTW we are waiting for tests for this etype...when those are in place
it should provide a way to test the behaviour.

I see that Entry_nxp_imx8mimage.SetImagePos() adjusts the image-pos.
Is that the symbol you are writing? Are you saying that the image_pos
symbol that is written is incorrect?

Or are you using u-boot-spl-mkimage.signed.bin (i.e. without the 4KB
header) in the first section.

The image_pos is an absolute image position, so it doesn't matter what
sections are written out as files. The image_pos will be the same
regardless.

Why are u-boot-spl-mkimage.signed.bin and u-boot-fit.signed.bin
written out? Aren't they just intermediate images, not useful for
flashing to the board? If not, why is the FSPI conf block before them?

There is a 'skip-at-start' property which might be useful here, so
long as I understand the above correctly.

Regards,
Simon


>
>
> Links:
>
> [1] -
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8mm-u-boot.dtsi?ref_type=heads#L49
>
> [2] -
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/ddr/imx/phy/helper.c#L27
>
> [3] -
> https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#L526
>
> [4] -
> https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#L371
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
