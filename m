Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF431FCD0BE
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 07:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD2D8423E;
	Wed, 18 Mar 2026 08:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A1Dj66B3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAC48423E; Wed, 18 Mar 2026 08:09:58 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296D5841D5
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 08:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso843411d50.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773817794; cv=none;
 d=google.com; s=arc-20240605;
 b=PkgIlyV8D9LZIvMx75I4ksZtW1YVpjAST1PTxOV+snjorpuQXDL8WAt5CuynKXllUw
 djKnu/OP2xKL3AX4BAgro5oOMTqJS3yiO/2BqNfRTgLBZ4IRDQyKVq//wWTF70eM2nTY
 yQesN4AjKESE8RdxNfaYb1CVjM5h6uKnHygigCCYdnrCl9U+mfhmCv1qNJkseKcp/N1H
 1VGzB4Jl73C9Z5AfNEfuJTjTdXVy1oINUfj6vhugsWH11BwQcbEXX1SUcp8nsQ0FDqZI
 ioFa3aAQmsWsyJKhGVL13Jj1u9nZzzkhxb453jnNnwY4EUqGeLB7FURP4BoCogt25L8e
 im3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pla8Rg+xcFUjcN3xYXq7UHjTB5AiClMKQoezfAX1n7k=;
 fh=FPXXfZj52/XCoNyVSjKO272r70uqlMEKRFVdv8ufLoM=;
 b=P6RwX03RwVs/vjPfU6J3AXps2IBMAZk5n6fwf6zHD3XKlYPpqYXz0hGB8fw2r9iGeN
 GJhUQqjzDShGvjRTCVR/VbrVlLqkBWN7cR69rmQQphpsY+OlDSG41YU2i7BG9/Er+/k2
 R3Kk7nCPBOFex2xzX7DAyWiX9dsrIQGoRdIy1hMENpsP6ORAjeRdDMQWzG4JD0APak3x
 Eu972Vif2hUFLr9IapDwMfnuPE3qKJj88dY1I7k/EftrBqq7PL1rWfFUVrqcxT0HBymu
 s8t1hExuosah9JlieE2Iy++JTcvh4IDxO/1NYvbQAbJPn6uvJ11mvFtwjrRQXtHHKtsh
 nGYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773817794; x=1774422594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pla8Rg+xcFUjcN3xYXq7UHjTB5AiClMKQoezfAX1n7k=;
 b=A1Dj66B345V7Yk0/tNCCqDz8vsgRFDJoUBu/fPtBjVtLDdZ4ZSDYSm9ydnWEH4azjb
 NkqY+Ors7d5mivTkzo2XcXA9wB82SrB6oKLN4KoURYxxDxFdrPcW6wAw7di6vUSOhIqC
 nd+1UQl/K4FPdd+V2UDppWyOlEcWirpEnvroG8//tmmLZLF0YnF4Fx/6252dDSBWJDme
 KdY8Zp/KfMxd33/a4oMbfjlVZV34SK+IpYAvNBqJahZdUSW0DP69wcRBW2X62t4otyPO
 vifLY1XT2Fc3QQHLOxwM5tbxggH2mSrhnBuQ4zqvH9TnR2x7Sta2/KCyfLa2ndVrbQNs
 XGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773817794; x=1774422594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pla8Rg+xcFUjcN3xYXq7UHjTB5AiClMKQoezfAX1n7k=;
 b=UxymIhXPoiTYlL/WkveAuq/aiJigr4KVz/OKUI/QUApLt2rhMQvDbM8fqKxRMWNDFc
 hV2oqDuCE5UqLih6REp58SFhB8EyJSumGWg/4PYahD6J3vaDv9vSMzfejRia0FQ7YwNk
 ++nADpZKvgY+b0oY+DMWnxYEZPntVFNcON8aBMo6cA9pznmi+j3dN3YaOK2fd2idWiIu
 uv9G7Ebp4S27np2DKl2ayriaHdv0z7qizMXKnuvh/cm837ZAt5pA7EVfzD0jkyByx8iP
 WXqzxiuJ910S/ZeO6/yv3PrG9MVchflXh/Tzp1ucixWsR39o+bLy05tl/6sHJdI1SpPY
 nNsw==
X-Gm-Message-State: AOJu0YzTFeap+waU8wmh/G7wrOq1IyDfMWrR6Yj5xD4DwM85BBJqm7Pl
 M+4rn1DwpqJ9p/SjO0ZISzkirmQTrl/X6NzMPzdP1/RCHS9L2TEKdz0fIUygu8iBVLOQuRLV3zP
 0jYqZ54sqZiNC+lreXy3QW1PWAikuulUEMzDKkAqy+Q==
X-Gm-Gg: ATEYQzyFK47XEdmmgOVo/Mp5VSX0ua3kISj+zVm4gw2aUG4yhZ8CaGtgtOnA1/crcjB
 78O8wMC8EqGgDgNvbtHeHQpP3wVYlVeMT7dfERDNkBLRT5KrewU0SoaW/+JZUXX95vhCOZ8a/W/
 HOXouEVqXZYHBof8/FgmgU8nsguka7E9LKr2NYBcdK/tyoQyVJPqdambFHdlX09nufh+QNF4UwN
 87H1sT6N3gdnOxp6Nu+Ba5MjxyIX5Uqq5UTeENRYRU5gP4qoJ4Y+K/o7e7crWAfkmvTuxe+M2ES
 Vp1Ykbuwx0bKUhuMcOiQhKlCEDMLXNyqalQ2A8ERFXchzKnEOKvcCZQFGA5ithhPEO9idQkuF6g
 mTthhyHuoVEsQ1Hs5+W2md+P//SBAkquh4PgdzuXbOiKqKSgOqb2c4mcj9yJrrfdl+NrAnboiIr
 B2EB9mlEFJ42b2NW3sLoZsCDWs/KoQCP4shlv8VrXi/YG6PA0yDYdxRajbqD6j1gsuFepCqOJ+t
 IOuf6QulJe5y/C+S1y5UtCUCNfBsIcTEqlnoWYl4D96f2Oup06b/QRpNqJJ2wGfhHcwUzQqxH8M
 Y+QWRgio7dHHgrj4OYm/FONgr2FrDrW/A09lOhVJa5l+
X-Received: by 2002:a53:d9d0:0:b0:64c:2590:e454 with SMTP id
 956f58d0204a3-64e9133f858mr1926816d50.14.1773817793855; Wed, 18 Mar 2026
 00:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <20260317134256.GT502704@bill-the-cat>
In-Reply-To: <20260317134256.GT502704@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Mar 2026 09:09:17 +0200
X-Gm-Features: AaiRm51tmltsrBqluiRBKzc5acg2cEdNSETPWLEXFBUGoZJcGkJ8UCVm08w9GmM
Message-ID: <CAC_iWjL+OUcUhZQ9hD9Vsp2zOfxdr3wu2fCX03HshXxrvR_EoQ@mail.gmail.com>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 17 Mar 2026 at 15:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 09:03:47AM +0200, Ilias Apalodimas wrote:
> > Hi Tom,
> >
> > On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > As exposed by "make randconfig", we have an issue with the dependencies
> > > for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
> > > by what it selects) it must depend on CMDLINE as well.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> > In theory, you can configure UEFI with a set of prebuilt boot options.
> > If one of them is http(s) the device will boot even if CMDLINE is not
> > selected. I am not against this patch, but we will remove the
> > possibility to build a firmware without cmdline that just boots to
> > whatever is was preconfigured
> >
> > Cheers
> > /Ilias
> > > ---
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  lib/efi_loader/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index b5f81e0ff530..a9b2f813e1d5 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > >  config EFI_HTTP_BOOT
> > >         bool "EFI HTTP Boot support"
> > >         depends on NET || NET_LWIP
> > > +       depends on CMDLINE
> > >         select CMD_NET
> > >         select CMD_DHCP
> > >         select CMD_DNS
>
> The select lines here mean that you cannot do that, today :)

Fair enough. I was just thinking "lets not limit it more".
Heinrich is right though. This needs an overhaul and depend on the
protocols instead of the commands. Either way I don't mind merging it
now, but maybe add a TODO with fixing it in the future?

Thanks
/Ilias

>
> --
> Tom
