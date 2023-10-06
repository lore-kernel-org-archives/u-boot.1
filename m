Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3FE92FC5
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 01:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E33686CE5;
	Fri,  6 Oct 2023 03:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNVw3GKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B753B86C2F; Fri,  6 Oct 2023 03:42:10 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF36D86C37
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 03:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso2729313a12.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696556528; x=1697161328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X1sUoMumseEtkE3EjAfLloBfRgOle4lFU37Z3Jp+xck=;
 b=FNVw3GKWrAGE39A1DMt8p6JQwDsH9pMJ2lncn+bqmln53sjkr5Gju1RKOYnsS5IjCd
 cJjgWlUpRQ30z7ETO5yRaWszhWw1rLy5L3VK8RdAq5dkfIzi7tnZZfUMah3JvmWGoGKg
 kjon9ip0OM7hWdt46fPHnx4uTTCD80Vm/JgHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696556528; x=1697161328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1sUoMumseEtkE3EjAfLloBfRgOle4lFU37Z3Jp+xck=;
 b=ixnZYcNyfCP3NWKKd2Wg3lVVCLPxM8bEpXsg7GRYqPC90PI0FUNgogXVjV0zODZEsn
 7srv0M0vejtP3SoDKWCSOvcHjPGN8ophcjpSlKKSpaHNP3VU2WA9veV1Wx9OQsGDj0Iu
 4z86ak+S9F78/mGLGqEIWgihmRnEDSRWQ5EKErdS1AzJgTReGHM8FHUVgnialIjrO0TH
 WOdlkApb9mpUF48L+lKMhMbCOEPF3QIOhTGE+lU/66AC2IAv5FBmgJhsnmiExDBOygFh
 EtCPDbfhW034cz1RByZ9gHKBg9N7wBzdAUFRRD1U7vGh9EKldkAprpirRU09pSF/3Q5S
 aUlQ==
X-Gm-Message-State: AOJu0Yy/bPgYoIcF2eiRpUP0rO3b4KTbh3e9lhRnrnXFRU5RahMroiBF
 9MuRbcdto6812r6bWEkhFIs9+xMK9hBsVM8kL6LtSg==
X-Google-Smtp-Source: AGHT+IGa7Z8H1wkSldewzIjU31JO29AoHZO9XuRkVnWqZG4Twq/98I2ddlwY1nm7+Od4HcI5YrUxPN4g+A97qIwd9yU=
X-Received: by 2002:a17:907:75f4:b0:9ae:6d0:84ec with SMTP id
 jz20-20020a17090775f400b009ae06d084ecmr5975730ejc.25.1696556528056; Thu, 05
 Oct 2023 18:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
In-Reply-To: <20231005145350.GQ8465@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Oct 2023 19:41:49 -0600
Message-ID: <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
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

On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > > Declaration of long help should be bracketed by an #ifdef to avoid an
> > > > 'unused variable' warning.
> > > >
> > > > Fix this treewide.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > >  }
> > > >
> > > > -/***************************************************/
> > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > >  static char dek_blob_help_text[] =
> > > >       "src dst len            - Encapsulate and create blob of data\n"
> > > >       "                         $len bits long at address $src and\n"
> > > >       "                         store the result at address $dst.\n";
> > > > +#endif
> > > >
> > > >  U_BOOT_CMD(
> > > >       dek_blob, 4, 1, do_dek_blob,
> > >
> > > This really doesn't read nicely.  I would rather (globally and fix
> > > existing users) __maybe_unused this instead.  I think there's just one
> > > example today that isn't "foo_help_text".
> >
> > Hmm, what do you think about adding a __longhelp symbol to cause the
> > linker to discard it when not needed?
>
> Well, I don't think we need linker list magic when __maybe_unused will
> just have them be discarded normally.

Yes, perhaps things are in a better state than they used to be, but
there is a linker discard for commands at present.

SECTIONS
{
#ifndef CONFIG_CMDLINE
        /DISCARD/ : { *(__u_boot_list_2_cmd_*) }
#endif
...

from:

c1352119fd0 arm: x86: Drop command-line code when CONFIG_CMDLINE is disabled

I wonder if we can remove it? I suppose once this series is sorted out
we could have a test to make sure no command is making it into the
image when ~CMDLINE

Regards,
Simon
