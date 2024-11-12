Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443EAD42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 15:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8708289440;
	Tue, 12 Nov 2024 16:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UnJ5z2bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4599890FD; Tue, 12 Nov 2024 16:05:37 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0DB89440
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ee386ce3dfso5159843a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731423933; x=1732028733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rg9mr1ZuvIKPizw/ZWvqxjYDAsZ8cerD4vo4kesClzU=;
 b=UnJ5z2bwH7aKmVsuEv2kD9jnNfCBy40K960Q9VuafDOyl3zPuEwysQuoQEHI8xOmIa
 coXutNF6QRXectiC86S6a6JQUBdD4K02j9zMNBt3s0RtkJn5YuCZrniV2ovY46Ji+V2t
 U6b2BAAUy2zbexLVPzyP+XkKpT7VOSsbwgY7R2mu3Mdwyi2vO4jrAkMdYwSWsrkHVB+J
 kETDcUYm3TcwXt3EPXMlRltthwSn8QNvNoGJ7hsL+2B1aHHmzk1VYmfYtKacQFy7uA5i
 ETCLqzDdxIQ4QKG4aiM3dBJhZgMrpz+3inCfbvmoGc84PCqUq/ln/tUahIum6W4pODm1
 WNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731423933; x=1732028733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rg9mr1ZuvIKPizw/ZWvqxjYDAsZ8cerD4vo4kesClzU=;
 b=wgaKosVH8JtcPiecMLnPdtZu2UrIDHbu9Y1veRD2xurgX/UKQNYKCsyEU7rTpBRrcs
 9boXeGLl1kv6vSiRz+WHA6b6vo0WZL7jbdV8Tr4ePaiar6ZjCWHIiUXVAbXLNXdo83cK
 /k39/I11xkiVGgTGC5HklTWLTfQXRuGIssqBzXiPeBQbOw/220ctNYSmHNwT9t372BA4
 c/4DcYRjfKqKSAWohGi99vA0tbkDhew4uEKAcKzR1M8ZWd5I1K8HqSxhVAD1+67VSYDV
 INduVBT39/HKla5hfckJ//D+xMWMJM1rsKxPBTzo8DxsLvJ5wKmehK1p6aYfKRUZ+vC0
 r2mw==
X-Gm-Message-State: AOJu0YypKbMvO846O0whoikZttuXSKPOHa7+uWZV8FBwJxT8CS/69rp5
 CSBtSKZFyXhNpN61r/tNB1VIHrbDOOMwI1HqxzreL6wMOvRSK8L+h07YOHPPbm31KINSZ3q/qby
 KIGCA/KckYi/RSgIKG5jRJBl7gWZ9/imwwhG8jQ==
X-Google-Smtp-Source: AGHT+IECGqiQHWiokSwQBiQo2q8LVQ14fh4cuL8ZUbre7sio93ygpQefIVhPRE7DrQ98UUTy9NcSoe0PhWkiLPW9zVg=
X-Received: by 2002:a17:90b:4c06:b0:2da:88b3:cff8 with SMTP id
 98e67ed59e1d1-2e9b1edf2f4mr25839358a91.6.1731423932613; Tue, 12 Nov 2024
 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
 <ZzNkjdHYGXQy_kUa@mt.com>
 <CAC_iWjJEiNj+tCj64TXs5i+oqOMnEvevs1YrwPGQJ_XVkWsgsA@mail.gmail.com>
 <ZzNsZyVFuXAry8qT@mt.com>
In-Reply-To: <ZzNsZyVFuXAry8qT@mt.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 17:04:55 +0200
Message-ID: <CAC_iWj+hqrEPYqD2FvtL4Yh0GEfaREp+Y8bozHJLN+AkajSi_w@mail.gmail.com>
Subject: Re: EFI File renaming
To: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>, 
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Burak Gerz <burak@gerz.io>
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

On Tue, 12 Nov 2024 at 16:55, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> wrote:
>
> > > > > systemd-boot counting logic requires [0] to be implemented.
> > >
> > > > > If not we plan to add the functionality in fs/fs.c and fs/fat - correct?
> > > >
> > > > We don't have plans for it, but explaining any use cases you have might help
> > >
> > > systemd-boot is able to do bootcounting by renaming the UKI image [0]
> > > the code that triggers the not implemented code section is here [1].
> > >
> > > With this it is possible to have watchdog based A/B switching on systems
> > > without a writeable u-boot environment. And therefore it is a nice
> > > method to implement measured boot.
> >
> > The A/B is ok, but I cant understand how that realted to measured
> > boot. The TPM access, UKI infrastucture etc, will work fine without
> > A/B
>
> Yes, TPM, UKI works fine right now :)
>
> systemd-boot is renaming the UKI before it starts it, by increasing
> the bootcounter that is part of the filename. If the system is fully
> booted the file gets renamed again to reset the bootcounter.
>
> If the bootcounter exceeds systemd-boot tries the next UKI.
> The UKIs can be signed and are still valid after rename.
>
> I expect that changes to the u-boot env will change a PCR measurement.

No env changes are not and IIRC it isnt necesarry. We measure what's
described in the PC client spec. So the loaded image PCRs would
change, but that's a user decision (which PCRS to use and seal
secrets)

> At least it should be like this, since it might alter the boot path?
>
> For trusted systems it would be nice to have a meaurement of the EFI
> variables and beside that have no dynamic environment.

We do measure EFI variables and Boot#### variables in PCR7

>
> Hope this explanation is understandable?

Yes thanks

/Ilias
> Manuel
>
> > > [0] https://uapi-group.org/specifications/specs/boot_loader_specification/#boot-counting
> > > [1] https://github.com/systemd/systemd/blob/3304a029b847e87da51f7a8ad8c118111508e009/src/boot/boot.c#L1407
> > >
> > > > >
> > > > > [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/efi_file.c#L971
