Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB3C47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A8B8798D;
	Thu, 18 Jan 2024 13:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="itiFAE0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AA6879E5; Thu, 18 Jan 2024 13:59:07 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47608718F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50ed808db11so9994613e87.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705582745; x=1706187545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N6XzjrOGgrjInB6NoJ3kxWXs2BTcJrF95OdCx3HdMbM=;
 b=itiFAE0XhtWBLtGNTSOWT+xW7thm5XBjMyDzhU7JLOtVN37kyFfRl7Qwl24PbGbtsC
 U9wA0xbk7AJIul0n7XFnbUILpxwpbDyHXogzPIvvlWwanaEiglmc3yODZHVKECCXmk4K
 4LSyvdl3+IMsJYypePfdYgZjbPyLL6tZKuoRCKRIXBXiLPO7IQSFJNy8R1dvoBE+Akf5
 4fNKVpl2WMfClICd2sDWwvck06/BfJipq7J88K2UVazMlBf7ki4ZEHxWnpBqTRMQqsx7
 h0g00XzW6XgutFP+j4z5s8XH/59DZYGLNOoMAn305Qq6NC51X0UkoACPjyKuoaozwQit
 AoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705582745; x=1706187545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6XzjrOGgrjInB6NoJ3kxWXs2BTcJrF95OdCx3HdMbM=;
 b=SlTshK34bVTpoiNASlURB27MkhlbMn9ELd+sWyj4YEmaKoXgmBm9M+U/4tS8Mw42xt
 J1TE/ZROl5ujBA4Eas2soHkIHAeruPjgAwsJVMCL2WxUm9gwtsB1+0Cy/aVTuzvvyGsY
 ktjRC+XzYO0/J5i9PUau5hxjGBXm7o94+2+UatWIJq1vLdlNsMWjY8+SWNIO8PdeB7JZ
 oj6pis3CqSaiAhBzdcs2HST5FtXd1PaH5lVU123+rE9tgC6SjXKbUCkSRzvc742bpDp4
 7lin0X+ejr8qJFAgJ3qOpWuRuBTK0AO+P0CmXmwelR5eVGkIjTTvgjrOpU0ifTfdsuhe
 1qPA==
X-Gm-Message-State: AOJu0Yx6T652KeynpVCVa1oaBkejje98W+s9/C2Zc7IV4jBqSHxw2DhN
 rip5L7rBJsp55LBBF9uKPR9D9CvOidXalUPhs6Sdbp0JA9A/G2ZkgbYCrG+srWDelFyB9koOVxN
 0aizK0jqafwcQi7/pFR/DuLDgh6rr+KyrimjqUQ==
X-Google-Smtp-Source: AGHT+IEMr1lCBOC9d5aB/CfpY4X/fm2gIGdmmvQm+dPr58CyHOcEIeTNu33ywNeYAn6UJeA9VJcDB8FOjckXgpV6ML4=
X-Received: by 2002:a19:6446:0:b0:50e:af1a:1dcf with SMTP id
 b6-20020a196446000000b0050eaf1a1dcfmr425975lfj.87.1705582744980; Thu, 18 Jan
 2024 04:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
 <Zakb7ozkAU994FBj@hera> <c7941f3b-177e-4f51-b9b1-602b88229c66@canonical.com>
In-Reply-To: <c7941f3b-177e-4f51-b9b1-602b88229c66@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Jan 2024 14:58:29 +0200
Message-ID: <CAC_iWjLbkfsuu7rXUwNq+qwOuz9fqqjcTB2T8WrwCXpqUR=S+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Thu, 18 Jan 2024 at 14:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/18/24 13:39, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > A few nits below
> >
> > On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
> >> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> >> stage, e.g. QEMU.
> >>
> >> Provide a command to display the SMBIOS information.
> >>
> >> Currently only type 1 and 2 are translated to human readable text.
> >> Other types may be added later. Currently only a hexdump and the list of
> >> strings is provided for these.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >> v2:
> >
> > [...]
> >
> >>      email address updated
> >> +static struct smbios_header *next_table(struct smbios_header *table)
> >> +{
> >> +    const char *str;
> >> +
> >> +    if (table->type == SMBIOS_END_OF_TABLE)
> >> +            return NULL;
> >> +
> >> +    str = smbios_get_string(table, 0);
> >> +    return (struct smbios_header *)(++str);
> >
> > That can lead to unaligned access when we dereference that pointer, do we
> > care?
>
> SMBIOS tables are always byte aligned. This is why struct smbios_header
> is marked as packed. The GCCj documentation has this sentence:
>
> "The packed attribute specifies that a variable or structure field
> should have the smallest possible alignment - one byte for a variable,
> and one bit for a field, unless you specify a larger value with the
> aligned attribute."
>
> So shouldn't the compiler care about non-alignment? If there were a
> problematic usage, GCC would throw -Waddress-of-packed-member.

I don't think we have the strict alignment enabled in our makefiles.
But, that won't be a problem, I missed the packed attribute in the
smbios header.

with or without the change in smbios_print_generic()
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
