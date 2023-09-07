Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA585EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A1B86A28;
	Thu,  7 Sep 2023 17:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kVTcvcXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4909986A40; Thu,  7 Sep 2023 17:57:56 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1542286A28
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a603159f33so141212366b.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102271; x=1694707071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QFVKbbwbv9fbZQyiOaCaEdI2h+M2IVP3xRIJuN2skxo=;
 b=kVTcvcXB13Y/0wykDZt/7vtr293lCZ/VCs7Raaum24sU7nx1RmLStJFteHesV7rtD1
 Lkv1C6OwFDmJ+cPD8ZW5u7bd5WnA0Dgr5QCeHHzY7ARb6Jt+N8/ro7IlK62osGUZGTjg
 4DkmvdZF/NC4zEnxLOzFt+Yq/jzBEfF1Vj1b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102271; x=1694707071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFVKbbwbv9fbZQyiOaCaEdI2h+M2IVP3xRIJuN2skxo=;
 b=Mt0Av7YcMbiOyF5z+In5Vr9jMNSlkw/xpWiSYXsSVTQLFJadDZtIzPP7CpJLydNjdW
 w56lJeJKTaF1+xlAmzIsYTzAuV+KeZg5aVM00aI6vOaItCqMQ3RwBj+iVu0p3KHNoRCV
 KjJlgffYxZMPBDl//iej5qRHA3hgjOtnkuk0OvvHaS4BxIit4BjQ89/5XsywosLm4LZ2
 AVeEQ3JVajp2CS9KCqfpZ8VFM7IAGoJ/s7+v7YtHdYekCYIgf/coxOXZDQsJyp7O/cnB
 02/93fDqduQRDlfgBz0pPIgdx3sA4729J1KR/atQ4Cw58J8rRK+I1SmfvxFutPHLGhJ1
 qtMg==
X-Gm-Message-State: AOJu0YxDQy5u9pK1rs5e2u4xlQ0fDHCA1ZpWasvWumfdCFGo/pFqV4KL
 Wzbc83EGsT9uF2C02JjjK5OiOtehVIBePzxbWDS8DZj0UCJrL//6KUU=
X-Google-Smtp-Source: AGHT+IGo3eO1k9nWes30dIRKrc19hmmKZdG2U7Iz5c0AJ87wE3AA+1OdGB+HCRkGDlT9QO3B0zHYOwAnk43HI/pwSbM=
X-Received: by 2002:a17:906:76cb:b0:9a9:ee3d:48e3 with SMTP id
 q11-20020a17090676cb00b009a9ee3d48e3mr1004433ejn.12.1694102271424; Thu, 07
 Sep 2023 08:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-4-seanedmond@linux.microsoft.com>
 <CAPnjgZ1EK5pe+z2V1LNN0xs254v_4ciKRQPN2H=eZPAEY6g9ag@mail.gmail.com>
 <SN6PR06MB534261328C12EDFB9E697205A5EEA@SN6PR06MB5342.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB534261328C12EDFB9E697205A5EEA@SN6PR06MB5342.namprd06.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 09:57:39 -0600
Message-ID: <CAPnjgZ3O00K1+Me3Kci+qV7LrKOfEaRYXpnOjrSBszQyWNco4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cmd: kaslrseed: Use common API to fixup FDT
To: Chris Morgan <macromorgan@hotmail.com>
Cc: seanedmond@linux.microsoft.com, u-boot@lists.denx.de, 
 dphadke@linux.microsoft.com
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

Hi Chris,

On Thu, 7 Sept 2023 at 09:45, Chris Morgan <macromorgan@hotmail.com> wrote:
>
> On Thu, Aug 31, 2023 at 01:02:02PM -0600, Simon Glass wrote:
> > Hi Sean,
> >
> > On Tue, 29 Aug 2023 at 14:37, <seanedmond@linux.microsoft.com> wrote:
> > >
> > > From: Sean Edmond <seanedmond@microsoft.com>
> > >
> > > Use the newly introduced common API fdt_fixup_kaslr_seed() in the
> > > kaslrseed command.
> > >
> > > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > > ---
> > >  cmd/kaslrseed.c | 22 ++++++++--------------
> > >  1 file changed, 8 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > > index 8a1d8120cd..c65607619b 100644
> > > --- a/cmd/kaslrseed.c
> > > +++ b/cmd/kaslrseed.c
> > > @@ -19,7 +19,7 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> > >         size_t n = 0x8;
> > >         struct udevice *dev;
> > >         u64 *buf;
> > > -       int nodeoffset;
> > > +       ofnode root;
> > >         int ret = CMD_RET_SUCCESS;
> > >
> > >         if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > > @@ -45,21 +45,15 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> > >                 return CMD_RET_FAILURE;
> > >         }
> > >
> > > -       ret = fdt_check_header(working_fdt);
> > > -       if (ret < 0) {
> > > -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > -
> > > -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > > -       if (nodeoffset < 0) {
> > > -               printf("Reading chosen node failed\n");
> > > -               return CMD_RET_FAILURE;
> > > +       ret = root_ofnode_from_fdt(working_fdt, &root);
> > > +       if (ret) {
> > > +               printf("ERROR: Unable to get root ofnode\n");
> > > +               goto CMD_RET_FAILURE;
> > >         }
> > >
> > > -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> > > -       if (ret < 0) {
> > > -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> > > +       ret = fdt_fixup_kaslr_seed(root, buf, sizeof(buf));
> > > +       if (ret) {
> > > +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> > >                 return CMD_RET_FAILURE;
> > >         }
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > So this command is intended to be used in a script? I am just trying
> > to understand why we have the fixup code as well as this.
> >
> > Regards,
> > Simon
>
> This command is intended to be used in a script, I wrote it as a
> command a while ago and thought it might be useful for others so I
> pushed it upstream. Since then I've started applying a kaslrseed value
> with a fixup (basically copying what the rng-seed fixup does) so I
> don't have to do anything special with my boot.scr files.
>
> I'm perfectly fine with either eliminating this command all together,
> or making it use a software RNG (again I can't speak to the security
> implications of this, as I'm not a security guy). I can just start
> adding the kaslr-seed in the board files anyway.

The command seems fine to me.

Regards,
Simon
