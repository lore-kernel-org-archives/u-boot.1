Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F88E936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 01:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3F8875FA;
	Thu,  5 Oct 2023 03:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3gMixCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6900875F0; Thu,  5 Oct 2023 03:24:02 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E0A875C8
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 03:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso84060566b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 18:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696469039; x=1697073839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnnHXM7Awuy64i4+I1dYkI770aSe3ytZwGuQhG55xQ0=;
 b=m3gMixCA6eOT617/nIZ9XEl/na9czz00umEgFS6VpakW1navUx3105k/UJRXF59V6f
 50vHtJag8otLmdQiNRrBk7qe1XUmKV1j/D6AdNLqbtk6Judm1OI7RD7n6bDECdBaGR0n
 zgQSY8PPkLeK6Q2lyFIRa2HWNCvrnB5BDmuNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696469039; x=1697073839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnnHXM7Awuy64i4+I1dYkI770aSe3ytZwGuQhG55xQ0=;
 b=tEBCYaxOp6X3XIMRyhqMp5TEvV4wRXeIBPed9g2hDan9+cBRJdz+9ohlPzgpDwHNii
 INkDf0FDxn7wQhlJND9RihkbNxbDA2q9cMpagP1We/Keq2i5UM/cgS++imKmzbFKDLgs
 nQpIEW6hOTrUF0Y/XWquneCT6RRtkQ2EtSa/VIn07ZfftpQni/aNUVcFbGIvgtPYl0d2
 fXu5If9Iw5TWv1KtVyYpdqAxCAL1evGt0JPLaSKqNFx2ELCIHwsfrlxLMiKPHksv7HN5
 7YDu/BZ/OzqK206oLlD/cd+9Ke01RN1wXEQUleO7nBOK0ihHvbUenBno+57EcciITyLs
 f5dQ==
X-Gm-Message-State: AOJu0YzXjDBwgobsrkwfOFUJ8DkXstqjiZwBUEOotZpb+yeRX/+w2rPD
 LFF9ZH/9fvebm6amlyO20l+vdGgXxsGC02CWfMal2CTfkOhBqs/k9u8=
X-Google-Smtp-Source: AGHT+IGoOwC1jRqFdk9WVE4WCg9TtHYIncidYVAYe1lAIP+OroFzZT9HAjl8/HjKVreDWxMENplQK+oR/Z4oBH34Jeo=
X-Received: by 2002:a17:906:2253:b0:9a1:debe:6b9b with SMTP id
 19-20020a170906225300b009a1debe6b9bmr3312300ejr.35.1696469039101; Wed, 04 Oct
 2023 18:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
In-Reply-To: <20230924232658.GM305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 19:23:47 -0600
Message-ID: <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
Subject: Re: [PATCH 05/25] treewide: Correct use of long help
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, 
 Leo <ycliang@andestech.com>, Michael Walle <michael@walle.cc>, 
 Michal Suchanek <msuchanek@suse.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Rick Chen <rick@andestech.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, uboot-stm32@st-md-mailman.stormreply.com
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

On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > Declaration of long help should be bracketed by an #ifdef to avoid an
> > 'unused variable' warning.
> >
> > Fix this treewide.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > index 6fa5b41fcd38..25ea7d3b37da 100644
> > --- a/arch/arm/mach-imx/cmd_dek.c
> > +++ b/arch/arm/mach-imx/cmd_dek.c
> > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
> >       return blob_encap_dek(src_addr, dst_addr, len);
> >  }
> >
> > -/***************************************************/
> > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> >  static char dek_blob_help_text[] =
> >       "src dst len            - Encapsulate and create blob of data\n"
> >       "                         $len bits long at address $src and\n"
> >       "                         store the result at address $dst.\n";
> > +#endif
> >
> >  U_BOOT_CMD(
> >       dek_blob, 4, 1, do_dek_blob,
>
> This really doesn't read nicely.  I would rather (globally and fix
> existing users) __maybe_unused this instead.  I think there's just one
> example today that isn't "foo_help_text".

Hmm, what do you think about adding a __longhelp symbol to cause the
linker to discard it when not needed?

Regards,
Simon
