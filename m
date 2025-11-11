Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F20CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C3983F6A;
	Tue, 11 Nov 2025 13:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BlqjHukz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37F48334F; Tue, 11 Nov 2025 13:38:24 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9706483F6A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b73161849e1so354727966b.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762864702; x=1763469502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FTikSRjOZWICk6ZcoZpOlCW7j6Sm4FUEIpiUhiqjuS8=;
 b=BlqjHukzzLqD+NEPfZvwsdDhOR4YNTtH8G9xBgZRjoZtvjyZkj0GduZITwy4rFFhjx
 CyNPnIRCspdxDthVVqE7pxvPjErfxoBF7o1sc4dy/hObVMX2si07N5mO+MAsswYXtFOB
 6wcx6rYOsfGNERM/cAPAiK/Fl0hxFxAQeibe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762864702; x=1763469502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTikSRjOZWICk6ZcoZpOlCW7j6Sm4FUEIpiUhiqjuS8=;
 b=TmM70YABGP1RPVb7TqZ+qat9o8Pi01AikLTOhnvyTNHzHyDu55TmjIOv1U+PEuuvd9
 ewNulFMrcDBNLpZ46k0cMKif4VyylOuURVvSfqlA5v7RODMgKBgBAz/OIc2Cn2b2qO49
 +oljTxgGv+78mSfo3nJ75Lo8xRYmCSxGgJfp/Le/cce7Y+oPs56kK/FUuTquFBeVf/g7
 YDKKQbh0u9wjg1CPocp2jGS5EBYAkJySz/DKhJQZqiVs7JUxZ5Knz0UkjGMwwpyJc1cT
 4x3hANiAMXc2e2ZCE6VbmZ90697Ls6Edhr0nL5Oz9fUnplT7zl8ZjENB1ZkcgZwjf2DA
 Kd/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkP6gy1rijuciXJgkAd5chiT6vLNb/RsDInXHIzXMWn2vn5n/rI95ZGJ+UnT3qcwX6tuH64pI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+6yK2Xq1czUmbpuAttFjmFWmsxwqod6WTiRnM5Gw8FOMz60p1
 Vdb+bG+xYZdZZiQ995LyDTqLIElQVvvkfMbuHzDcY9FmZ2/T7XHQGf7PjCsgl84IrMIlW7BU1if
 KooSHSMUuZNvfLd0H4lCYImEVlyrGB+mpX5izYPC8
X-Gm-Gg: ASbGncshyNEl1xc9DVP6Z4u3mie/7OYiGJUD6kzc61E1JyCfHxKLn1xnU4U5Vttkp/c
 X0TL8Lk6nLotHvwmwbG/3qcXD3ArM5d2ZYjB4twLaPQ+jsY4qgWwqfnvTwEGRYKiIb39l+Fj7e8
 Q8SpoKglBbg+f5h5EHNY3fFEaj2JjWbbw0F3cN2bvRF5KniXug9QNh8y9T2qgUhNBYlGRE3MC6R
 Rs54sJ8vCZOdmgJL1dMJP3MrSuue2F0VZM+8g5WhapMLDy40jpICUu/TvApdbC9xwPLtg==
X-Google-Smtp-Source: AGHT+IE4hOrmRPCjZ9enrXiIdH3XAPGVdC+JBZ5NONI/S4FuWSU5CbuKJ00UzpCbHET1KGirAmfwxzOvELQzbNo+eXc=
X-Received: by 2002:a17:907:7246:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b72e02729dfmr1352611466b.4.1762864701973; Tue, 11 Nov 2025
 04:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
 <20251107155650.GE6688@bill-the-cat>
 <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
In-Reply-To: <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Nov 2025 05:38:10 -0700
X-Gm-Features: AWmQ_bnmur2NsyeB1f0tKUlE6IUYEa7HtRJzrb9IZKc1a5LQZaGEKFUo__cubWw
Message-ID: <CAFLszTjjhOj8g63vs_hprykYrWvEM=YuwT4ZNDnuppuJ-8aXZw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
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

Hi Marek,

On Fri, 7 Nov 2025 at 17:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/7/25 4:56 PM, Tom Rini wrote:
> > On Fri, Nov 07, 2025 at 03:06:47PM +0100, Marek Vasut wrote:
> >> On 11/7/25 10:12 AM, Heinrich Schuchardt wrote:
> >>> On 11/6/25 22:08, Marek Vasut wrote:
> >>>> In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
> >>>> DT with U-Boot extras, to show how much does the U-Boot DT differ from
> >>>> the base DT. This is particularly useful together with OF_UPSTREAM, to
> >>>> minimize the diff between upstream DTs and U-Boot DTs.
> >>>>
> >>>> Example usage:
> >>>> $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=1
> >>>> $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff
> >>>>
> >>>> This still has a downside. Even 'dtc -I dts -O dts ...' applied on
> >>>> base DT and U-Boot augmented DT can produce different phandle IDs
> >>>> for the same node in those two DTs, which results in a lot of noise
> >>>> in the resulting diff. The only way I can think of is to patch DTC
> >>>> to emit full paths in those phandles instead, something like a
> >>>> phandle = <&{/full/path/to/remote/end} ...>;
> >>
> >> What bothers me is ^ this part.
> >>
> >> Hello Heinrich,
> >>
> >>> Without documentation developers will not know about the new feature.
> >>> Could you, please, add a doc/build/ change in the next iteration.
> >> Sure, although I am not convinced it should go in in its current form.
> >> Please see my first line of comment.
> >
> > Maybe we put it in the u-boot-extras repo for now as a standalone
> > script, so people can be asked to run it and look at the output?
> I'd say no, because the output is full of noise unless the phandle
> non-resolution gets somehow improved.

Another idea would be to create an fdtdiff tool which does this. We
already have fdtgrep[1]

Regards,
Simon

[1] https://github.com/devicetree-org/fdt-tools
