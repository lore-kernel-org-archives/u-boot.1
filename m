Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD5E81DF4
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 13:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5110F86E8A;
	Fri,  6 Oct 2023 15:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZV/KsCNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D22486EAF; Fri,  6 Oct 2023 15:03:31 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E07786E70
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 15:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so3747079a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696597409; x=1697202209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o/JPOr2EqDUQM49u6dbgaPw7+SEsD5mpv/t+LN5fpzs=;
 b=ZV/KsCNtXZMTrXQ4t1J/1StEeJMWC2NZXotLNHchL1qHVEmmTbW9SVU9ANlg5ZyXD+
 IBAAOY1DO/eIeOxhA6nx0CquyUypVlhwr0JRiJCVIkHTglaSZbM3koNwEJbiQUhggmpb
 kCrNzzvnrwiDzDiQtXTB+Al6VCOrQhRAzqfZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696597409; x=1697202209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/JPOr2EqDUQM49u6dbgaPw7+SEsD5mpv/t+LN5fpzs=;
 b=gDYCo4cCzjOwrcVXUDBv4yROS7W3c0aVS8VikHvT06d/lfJvmPqRI2IjgXcmkRkVQY
 IKe/x75qlkkPn1Gn3+xU3a1x6ZYE6EJ+aCg0kiE5tx9vVU1tLSlrIihGLW1qh7hIy/cy
 N/dya48YKhoyZxLdCKPtk8usS6KAXxuGMmtENbAXfEvtsLlFQJ31RN4KUqPCTKav81K2
 p+K7WWBTR0bOMdFbc+zG5fEvxRXiqQTp3KEZrHNp8Uz8sprcW+jUsTzA0cXnVc7xXY2I
 IURPsIkevtmOUVxiD/ENjtuo45i6+s2IF/tWnPjI4yS8HLVdcPZAK802RSkijYLDmoiq
 IFWA==
X-Gm-Message-State: AOJu0YwhXMvOUAZsd0qpwa4O8lSQidv/6RJkfjkye1hCAQVNvL35GiyL
 rfPtq8pZC6RT47aSQ96SPAALBNchhr0QnrfRFjVuIw==
X-Google-Smtp-Source: AGHT+IGtqZu8SDbFEtGE9f1ENtOokt6WHyur7UN84zjr+6kBER+tqboUKjlTTEPU9ZNNdGywO0HwmA3ncOkiVb+YOmo=
X-Received: by 2002:a17:906:2257:b0:9a1:680e:8c54 with SMTP id
 23-20020a170906225700b009a1680e8c54mr7785984ejr.71.1696597408529; Fri, 06 Oct
 2023 06:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
 <20231006021616.GB2227687@bill-the-cat>
In-Reply-To: <20231006021616.GB2227687@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 07:03:17 -0600
Message-ID: <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
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

On Thu, 5 Oct 2023 at 20:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > > > > Declaration of long help should be bracketed by an #ifdef to avoid an
> > > > > > 'unused variable' warning.
> > > > > >
> > > > > > Fix this treewide.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > [snip]
> > > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > > >  }
> > > > > >
> > > > > > -/***************************************************/
> > > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > > >  static char dek_blob_help_text[] =
> > > > > >       "src dst len            - Encapsulate and create blob of data\n"
> > > > > >       "                         $len bits long at address $src and\n"
> > > > > >       "                         store the result at address $dst.\n";
> > > > > > +#endif
> > > > > >
> > > > > >  U_BOOT_CMD(
> > > > > >       dek_blob, 4, 1, do_dek_blob,
> > > > >
> > > > > This really doesn't read nicely.  I would rather (globally and fix
> > > > > existing users) __maybe_unused this instead.  I think there's just one
> > > > > example today that isn't "foo_help_text".
> > > >
> > > > Hmm, what do you think about adding a __longhelp symbol to cause the
> > > > linker to discard it when not needed?
> > >
> > > Well, I don't think we need linker list magic when __maybe_unused will
> > > just have them be discarded normally.
> >
> > Yes, perhaps things are in a better state than they used to be, but
> > there is a linker discard for commands at present.
>
> Yes, but __maybe_unused means we don't get a warning about it, and it's
> literally discarded as part of --gc-sections as it done everywhere with
> maybe 3 exceptions?

Actually with this series we get a lot closer to that. The problem
with the status quo is that disabling CMDLINE doesn't disable most
commands, relying instead on discarding them at link time.

With this series, it looks like we can in fact do that, so I should
remove the discards as well.

The one proviso is that this does drop a lot of things we want...e.g.
BOOTSTD_DEFAULTS cannot be enabled due to its use of 'select', meaning
that common filesystems are dropped. So we'll need more effort after
this, to allow (for example) bootmeths that don't need commands to
work correctly. But I think this series at least provides a better
starting point for teasing things apart.

So OK I'll go with __maybe_unused for the ones that need it, which
isn't too many given that many of the strings are just included
directly in the macro. It is considerably easier than trying to be to
clever about things.

Regards,
Simon
