Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0DCE8E7A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB4388DFE;
	Thu, 24 Oct 2024 16:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qcc4HWws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA2A88DFE; Thu, 24 Oct 2024 16:16:08 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017F788D47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so954339e87.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729779352; x=1730384152; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D/mCx4ExRY/PZlJolypvwZtz0H4FP4KgHVe+vEYpAw=;
 b=Qcc4HWwspA5owgp45BLkT1Q60vojzy1yDtV8+6MNzejgdy844DQQXQ9ZqUH8nCfZmd
 HcObcfaH4gG8DVXw1Z29UysoUSpCTzj7s+FXvpGqWdBCeGY73byD/BwjJZROOV1NdU4Z
 WNb7oyI/tetIhvbaRPqSFpA/pGWbhoG+UWTJWY4xj/mYz58R7VNhdwI1/abNlwdnm9z4
 F3ogZEQf3rWmMXzZ9KHj8egEm5iuUKKL7mo+2isVB5fKF5mmiy3bX/QZww+JwpGPGibs
 wBnnIllPQnMI+8nqlOyRJzWGZD0ZTAOnFn6WZ/vY5f0/IIf8Hzb5WmJwqm/4PpYE2Imt
 762Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779352; x=1730384152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9D/mCx4ExRY/PZlJolypvwZtz0H4FP4KgHVe+vEYpAw=;
 b=wuJ4yFvlgsLQfNQo1cQukhZ8ddZMwZt+etY/vp7TgKzTzn/3qf4JWRBir0ZgILEYWl
 7N0PyuTqOgJkhvhllBx7Up2Py3JFmGubr1Hlj6BQMlaO6P19sClPZNS32FfV02xN6kPW
 Aaf9UzlLGZ/u8TqAJ3AybNxdKBbZ27oN6W8rqYoKytAn895KPCdyLlufR5lOsuUbhr2L
 97PTlwLdtblMd8YuaAtoRTQxHFQBCVoiNQPUSdwR2ysF/6o78ttzn4XcW+4G/Gx8vuV4
 v1KNCRfT62ulvI3ToMqpnkOG0KeArLMd38dOPJFk9zY/9R6Z0N0ItRFgmKzdb713Rc6z
 u2rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgOGg1ybxwxbO/r/HoStE7yQPpWEpi8CMQ+PwwafRPnDsPtED8ys6Y3Dc5cxSE5OpCssko+T4=@lists.denx.de
X-Gm-Message-State: AOJu0YydxiVUIuN0CbatncOHXg5IQyTS6Enkgfh3fmnojuqKgAX1oBdL
 PDEjO5cNPkJG2Z+5MEAa4nsE+8fR2PJtFNuFqm3ozMyjDSCfyVb+JF4tOq9zjfeGT8voilexVYc
 Fjor04q3FHcVIgrYjeavnfFYLzEK3hA==
X-Google-Smtp-Source: AGHT+IHTCNCeZW8J3k/4++MxLVEKiMIGU7twzDtINn84QuKdlG7QwLmXPrUK6zlsVUSUT6hcPQVbuCL1JT3PIpNZPEw=
X-Received: by 2002:a05:6512:68d:b0:539:e9b4:7ff6 with SMTP id
 2adb3069b0e04-53b23e8f1b5mr1534961e87.45.1729779351800; Thu, 24 Oct 2024
 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de>
In-Reply-To: <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Oct 2024 11:15:39 -0300
Message-ID: <CAOMZO5AgsjBLTK7g6r1-u87Nvr1s_DgqW7ik7p3Zh9+Zoa8WHA@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Heiko Schocher <hs@denx.de>, 
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
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

Adding Simon.

On Thu, Oct 24, 2024 at 11:14=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
> > Loading flash.bin using uuu fails when flash.bin does not have the
> > right size.
> >
> > When flash.bin is loaded from some storage medium (sd card/emmc), SPL
> > just loads some random garbage bytes from beyond what has been
> > populated when flash.bin was written, but when loaded via uuu, SPL
> > hangs waiting for the host to send the expected number of bytes. Which
> > is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
> > alignment to 0x1000 is already done and is necessary in all cases
> > because that's the exact expected location of the 32 byte IVT
> > header. But the IVT+CSF blob tacked onto the end must be a total of
> > CONFIG_CSF_SIZE.
> >
> > This is exactly the same fix as 89f19f45d650, except that this time
> > around I don't know how to cleanly get CONFIG_CSF_SIZE.
> >
> > Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M flash.bi=
n signing)
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > ---
> > Heiko, can you check if this works for you?
> >
> > And if somebody wants to pick this up and knows how to get at CONFIG_
> > values, feel free to fix up and take authorship. But perhaps it's not
> > really configurable at all; imx8mimage.c has the value 0x2000
> > hard-coded, so I don't think anything good could ever come from
> > modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
> > make that knob non-settable.
> >
> >   tools/binman/etype/nxp_imx8mcst.py | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nx=
p_imx8mcst.py
> > index 8221517b0c4..9a1974cc522 100644
> > --- a/tools/binman/etype/nxp_imx8mcst.py
> > +++ b/tools/binman/etype/nxp_imx8mcst.py
> > @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> >           args =3D ['-i', cfg_fname, '-o', output_fname]
> >           if self.cst.run_cmd(*args) is not None:
> >               outdata =3D tools.read_file(output_fname)
> > +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
> > +            outdata +=3D tools.get_bytes(0, 0x2000 - 0x20 - len(outdat=
a))
> >               return data + outdata
> >           else:
> >               # Bintool is missing; just use the input data as the outp=
ut
>
> I have to admit, I never really figured out this binman stuff, but
> shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ? And
> ... shouldn't it somehow use SetImagePos() ?
