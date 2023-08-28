Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8AC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5574A86535;
	Mon, 28 Aug 2023 19:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i9Nuw5MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB2C86533; Mon, 28 Aug 2023 19:56:00 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B008864BA
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58d40c2debeso41263847b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+a4GD8wQFAfYovjxD/dlnfa8kvcWf1HGInYH18j4pbs=;
 b=i9Nuw5MBlksD02/exjgSTHGq+M9x39P8TJhQktVopZBCbNXJZGuhui6rYioHc3Ekr/
 6TZVxXkthcEwbscqc3kRuCG+USyLJ6tKSkeAmA3Z7HabBByM2QnTcH49UcdyzsV9dMTf
 XDiM/alCPcMZ4RoM2maUQPhNrf1Giw5A5E0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+a4GD8wQFAfYovjxD/dlnfa8kvcWf1HGInYH18j4pbs=;
 b=Z08ZDYS2oyWP3wOtu8s9CGkSYERvdXO3jqsG86QN4l4zuqNZARez9Tki8CA91lQ4AS
 KrAVhsaI7IVh51lEq+gfbABMNPKzx33AGWC6JO1/exdbfcEg/VDktED89RRF0bh2GQT3
 cffz8VmlUknNmC6LVOBvcL91/1vnqvUXtq8mHotaDwGaPDMsCax5jJ/dow6MLMvSzpAb
 dU6qlMRcwgSJMFJSD82zAgpSUeL1T9iPMGtW9ammHPpahAYbkINLLNJqQ2OEQQeVVB87
 rV8xrpPUOtcvuyfcmetwqa/DL4fldTfMybRTeYxSCzFFok/2kfCZtrlNm7idFkEJExU7
 0kww==
X-Gm-Message-State: AOJu0Ywthqa6tMcCRKL01e/UyYO/SfUvLTiJmT0eAusZd5v82dLyBbfL
 gpuC4Q6bYZvvnhpXFZ7dRwdPXz21OUzzFmEyWk2pTC1idDWHMGNNGo8=
X-Google-Smtp-Source: AGHT+IEj444eSmZDi3yfBIrEdQfW7SukN9rH8/6lusrukgpO61irBzYD8YVFlfoh496qkzSm246m9kuounuZvEYS9Ho=
X-Received: by 2002:a25:689:0:b0:d78:538:8017 with SMTP id
 131-20020a250689000000b00d7805388017mr10814294ybg.61.1693245356091; 
 Mon, 28 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
 <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
 <89ab674dc53557f093d42fe4ca54ca4a14f8a276.camel@iopsys.eu>
In-Reply-To: <89ab674dc53557f093d42fe4ca54ca4a14f8a276.camel@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:48 -0600
Message-ID: <CAPnjgZ0Be-fAjFWNwmuHjEvtDCNypDYtH-8+5Son2_S7LeJe4g@mail.gmail.com>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
To: Roman Azarenko <roman.azarenko@iopsys.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "massimo.pegorer@vimar.com" <massimo.pegorer@vimar.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>
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

Hi Roman,

On Mon, 28 Aug 2023 at 02:00, Roman Azarenko <roman.azarenko@iopsys.eu> wrote:
>
> On Fri, 2023-08-25 at 12:06 -0600, Simon Glass wrote:
> > > @@ -564,9 +564,13 @@ static int fit_extract_data(struct
> > > image_tool_params *params, const char *fname)
> > >          /* Pack the FDT and place the data after it */
> > >          fdt_pack(fdt);
> > >
> > > -       new_size = fdt_totalsize(fdt);
> > > -       new_size = ALIGN(new_size, align_size);
> > > +       unpadded_size = fdt_totalsize(fdt);
> > > +       new_size = ALIGN(unpadded_size, align_size);
> > >          fdt_set_totalsize(fdt, new_size);
> >
> > I didn't know that was allowed...I thought it needed fdt_open_into() ?
>
> The introduction of fdt_set_totalsize() comes from commit ebfe611be91e
> ("mkimage: fit_image: Add option to make fit header align"). The commit
> message doesn't describe the choice of this function vs fdt_open_into().
>
> Personally I'm unable to definitively comment on it. I can only blindly
> guess, that because we're only changing the total length of the fdt
> struct, and keeping all other fields the same, we don't need to allocate
> a new fdt struct with a different size.

I am not sure if it would cause problems. I do understand that you
didn't write the code. You could copy the people who did (and those
that reviewed it) for their input.

But I think it should change to call fdt_open_into()...if you look at
that function it does extra things. Unfortunately, the function has no
comment in libfdt.h.

Could you add another patch before or after this one?

Regards,
Simon
