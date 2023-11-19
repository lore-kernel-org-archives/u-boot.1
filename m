Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F71CC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 07:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8E386E95;
	Sun, 19 Nov 2023 08:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iPfTwD7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7FC86FB4; Sun, 19 Nov 2023 08:50:24 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E04786D93
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c876e44157so9615211fa.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700380218; x=1700985018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WR/u0jhwxxBgcKV7mNMzS3JfZRlOS5y92KjrQ2kHXjY=;
 b=iPfTwD7vl62m79k7GBzDPUvgjdJz3yyxhLx698cvzz6uQkIa4Yc9dR6gmdKotfqFN2
 CeHI+vZqdxDkAbdPI48nnuDaUL3IB6VQSz36N/wMiu3q3T155LhX05jCEQgBpaiyb7H7
 ZUK5X3OGJwRl4U9st9CsgDLZqWSU4Go4DHRBEmYRRvJ1e9O1/aHty8DtjwpQW+tZi19J
 mcZpptbH6FacqEOFVPOK2W8QeSMP8daGP3r3GSOJ3msm805EppES0mz5b6ggIfosfWNp
 1hBalM86v1gwwDxAQ8UpZPSZw8xXrnqPNCUwr3QLwf9p/EWn2zfMvqy6hYhVqUHyS+Ez
 bDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700380218; x=1700985018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WR/u0jhwxxBgcKV7mNMzS3JfZRlOS5y92KjrQ2kHXjY=;
 b=f7prHh/pbhGynPTcsQxfVYachc5wLkeZJLBknGXiHp7mzKFtgC1eBw3dzkAS/XlD7D
 nny7g0cplrNsPmdCDk8bHQ0MJR4gB1o6xenBYLBNrqxOqwQZi9XMOxD/yoI3TDwxaou1
 xC/asI3GwjBD1RhxlYf2SeS51tYfpbf0YNVbwqCX9FGOMcr2Nzu/SMISMM2G1yM2bYxi
 V4d5VGNjn+1GFHORYNWw4OHP1O4/FQNxfEmvzKxEgb24ojClNHSY2NLdKuU1r+aA0uHT
 ty/lGffA9oy7X45oUYA5yFDieYcZ0rG/asCsfe2bpb2SEo1EXgn2XWUUn+rPqLv+HgF8
 kY7w==
X-Gm-Message-State: AOJu0YyZYO4z9aIbNn1KWAkbusNIOHHX91j0wNK71Jtsi8SErLaGmugI
 LjkjB5NPhqFnMAlpulyrtaeeynjyEXQ+yLXLfoNoag==
X-Google-Smtp-Source: AGHT+IFmzvco6Rzced580rLtEJyTp1VZkCzI3uXgVzX4kIKxv1rpYA4fZRvQ3/HFpuKZ1Zhz7i7cFZwt33CmnPiXKbI=
X-Received: by 2002:ac2:51b5:0:b0:502:d743:9fc4 with SMTP id
 f21-20020ac251b5000000b00502d7439fc4mr3380662lfk.37.1700380217586; Sat, 18
 Nov 2023 23:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 19 Nov 2023 09:49:41 +0200
Message-ID: <CAC_iWjJapxvTqB1R-9CDMYDeyFDikJiZ=3JXCNArdLQr=FtMTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de, trini@konsulko.com, 
 xypron.glpk@gmx.de
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

Hi Simon,

Thanks for looping me in

On Sat, 18 Nov 2023 at 19:11, Simon Glass <sjg@chromium.org> wrote:
>
> +Ilias too as this involves a design decision
>
> Hi Shantur,
>
> On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
> >
> > efi_set_bootdev is already called as part of tftp while doing dhcp_run()
>
> Is that in tftp_complete() ?
>
> > Doing this again crashes U-boot and we don't need to call again.

Yes, we should fine the root cause here instead of papering over the problem

>
> U-Boot
>
> The problem is that we might scan for 4 bootflows, then later decide
> which one to boot. So we cannot know which one it will be until that
> point.
>
> The hack is needed so that it actually tells EFI about the right one.
>
> The addition of EFI hacks when reading files (i.e. the code in
> tftp_complete()) is a real problem, unfortunately. I understand that
> it was a convenient hack, but with standard boot we really don't want
> it to do that. We end up calling it multiple times for bootflows that
> won't be used.
>
> So I believe the fix is to be able to disable those calls, leaving it
> to bootstd.
>
> I'm not sure of the best way to do that. Perhaps we should have a
> function like bootstd_scanning() which returns a bool indicating that
> bootstd is scanning? If that is true then no efi_set_bootdev() calls
> are made? We could have a flag in 'struct bootstd_priv' which is set
> before bootflow_check() is called and cleared afterwards.
>
> As to how this should be done with standard boot, we should create a
> function like efi_start_app() and pass it the information we need.
> That function should do the equivalent of the 'bootefi' command,
> except programmatically, with no prior state hanging around.
>
> As to when we might be able to do that, we need more refactoring of
> the bootm code. There is a start on this [1] but it likely needs 2-3
> more series before it might be possible.
>
> So for now, I think bootstd_scanning() is the best approach. If you
> are not sure about that, I can send a patch.

I'll have a closer look at the efi bootmeth as well and come back with
suggestions

Thanks
/Ilias
>
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >  boot/bootmeth_efi.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > index 682cf5b23b..5917458dc5 100644
> > --- a/boot/bootmeth_efi.c
> > +++ b/boot/bootmeth_efi.c
> > @@ -360,9 +360,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >                 return log_msg_ret("sz", -EINVAL);
> >         bflow->size = size;
> >
> > -       /* do the hideous EFI hack */
> > -       efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
> > -                       bflow->size);
> >
> >         /* read the DT file also */
> >         fdt_addr_str = env_get("fdt_addr_r");
> > --
> > 2.40.1
> >
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=382423
