Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF2606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ldnn/djN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzP5XJiK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F9BD80E52;
	Sat,  7 Nov 2026 23:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRQ1CjWqsGjP; Sat,  7 Nov 2026 23:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 592EF80CA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794093564;
	b=ATqvIPMfZ+nBxGi71HOdTn839AB8tgsVOEB5RERuguvAiUhDJprWhXYX2GsXE4V3YqOe
	 +rvVHXql0slMxVkVCCys/QaT3jX4ekdqPpQn3jkzb0xDiA1885jEEmidC1zenn1eeFqzp
	 nb2VB32Ngj74DMHAfzX3vLSlC/XnmYd3zDC3NPp60hkQCCMyECouHF9/z+RXb2R4Un8wQ
	 OK5y7lNHGkUr4lUti9uW+/40ehI9/2WkW+FBVotLLn4gCPL6omS+y/cSwFirrBpHdPFk0
	 //qjtQ1ZDmGajL3wLWkts6vRadkd2U2ORvZz15nqrelWdKRdCMr411Fmu1os/ZbiZ9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794093564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GCIZUGaNbvsGfoNzxEfOc2Qs3vaWH9mE6Z8jpCMMQ1M=;
	b=WrMvsgEWerAqeifNep2eVHbVZrXl6KKTmcrOZlkuoZhsG9R0GBW4JJmV0wGrJTUQe8Bh
	 5QR3hGfblTdoG8Jo5pHOX+qlzvo+da2KYXBpUzz3ziJVjQ8pZBtuzN++ihAYc8urP18vO
	 DRWkXjtpnlmL7Nw+/E1ruRhKU7JmmOiQjxUiSj+kU9xdtUSKcwDNbLGY0InFytWkkaBYR
	 fPwrlMUNwbSIXfhK+WIcDJcvYW4p+oGPRcP8vpEjC9b0gtPeLb0qObN5kF/TDjohwib6v
	 b0zk4/vgivnZ8KUuznRCC0aaEQCxmdzmTpLTQDQQPouQUMsyFumI8Nx/QFB3Udg5E1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794093564;
	bh=GCIZUGaNbvsGfoNzxEfOc2Qs3vaWH9mE6Z8jpCMMQ1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ldnn/djN2eAtoSElups+VCXI9967ah1dgHl9NEpo+fSHrO1OL/jXvowrWpuUHZUth
	 vTmsdJcEfCO7Am3ePynlcl/zG4PWnRn5e5FBptOOBPEO1vIedixpfbLQZr4xzbtbot
	 NXOjz5IRF0Ocl2uTeScHIi+B4tusPz9YCMjsVhjZrQwXNihfo6nJRfW8jJUpG4zDQD
	 Gks/wIDmT55ibURnfhUpSrCQ9azzV3uKkizpj0PI/daM0GyU+ctdB4ovgYDietDPpy
	 B0oBa00Sl2b5FsLtPTnv9jfvhapXLoO7bscCyNcU07l8fyKRFeNN3AdE+U8fh3Junt
	 me0ROiuzIPRuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 592EF80CA6;
	Sat,  7 Nov 2026 23:19:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C42E431F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9BBF40665
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHSzFw75AzmO for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 23:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D37884065E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EzP5XJiK
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D37884065E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:19:21 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1931ff67a29so108986c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794093560; x=1794698360;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GCIZUGaNbvsGfoNzxEfOc2Qs3vaWH9mE6Z8jpCMMQ1M=;
 b=EzP5XJiKqZLnV2SZk/AC/xB57zK+eVdsDFDsYxxhOohDZ4WjN7Azs1LnS7SgCB+sZd
 SNGqA09uYgEMr/thHDYGf9rXGso6JPUks/1hi3xoaq3D8G7JwgTb2YGTSoRqrHWuwEKc
 HqWqx/uZeT4kALHlX7BqQ2rv/Je1mAWw6uEXhZdkDianxkTFu2HfQqrdZJ8dB+Q/pPqq
 38FJ0oof0NWdtHYK6DAYzEGaHHT/p3rL6iPkFyx3xwdyvvQQ9ETzJbCGL/mXs8A4A5X9
 FIkfiMRq6fKHrlWUs1CKHjzPYQK2/nsw/CneLAKzZickmme2ZJEo5a0tM+np2zjvN6QE
 Fg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794093560; x=1794698360;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GCIZUGaNbvsGfoNzxEfOc2Qs3vaWH9mE6Z8jpCMMQ1M=;
 b=aOcKhaosTKb/Fs5RJBOvt9vxxAE3lNyLpbKk6ZHdPgHTmH3zFjcbas1EGfS7+hYMRh
 GhPPZlgLFHP9Z9nRZ47t+5O7Ew6csStQCCbisi1qNdBlZQhYp3++/jZsfEpw+fbjxWpg
 nvqD2IR9+W/sDg/6OMYmW5JJORIKeXPXwmFhSyBGqU5sw5p0M5WEqHi7xnldtXJ2P8mx
 RLgbhhaZBsRMwgKbNm/BEm0E4x9NYz70QMlsl8HzeQTxeXuwp9L11JcF2he6NlR5USPp
 pU4+sgUK9SyVXjb9mWTuLCnpYLYrm9YT0RjjlKoCmZ7N2oOIezYDmdfkSU8UUaKd8Wae
 2mzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwI2GI0rdd9OzU6Gl8VjTsAWWQeFokGbasJqEUvwv0km3jPT10RAQStjmN6i3IPRWjGc4S/+g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+hLd3EpfMvFSY+3jWoP2dW/BS4/vuJ2BRxaroEHVaX7e7vpRqY
 GIjbUnByjGLKYdYeXGrS6OyWrnSUKuhgvrO123lnAir8DZVnmMuoWW3f6AtYf25l+pn/+tEObk1
 pXFExtZQnMXhlCvA7u2CVLBSqktlxCg==
X-Gm-Gg: AYBFou01v2SKyCyv67OI4SS1hS+7J9PMS7SigPV1886FVrmjWbnISB4Gh0O7yrRLJRv
 UQ6eNRXdaJQDIl63dlsx+EbQums9ulbn8DtCd5EwArl6mgZpAMJ/GSK/XbbsNG3RyLg4IFGc02B
 lohcf1ifm32rdlzdcMvMFVIv9uHF+0z5dzVMJkvH89A9h4GpE9EfFMM4gVCV+vECWsNTgRiq5xk
 7Zd18/M2bE6jpFQ87uosRIYG8YdTb+UFTCB2APba21yKMMk6ghljwpDIlW8qvtePfEAcRKgnQNA
 TeMVkzkHG5LFDaLJt+y8qCa12F5OBzrgs3ISSf0zy0OjxXYNQPyD9qw+qGDDphC5V514Cjgrdut
 jjWNQbUKdvBfQK7tkR4S9kTBIo7TjU9gIkGSz+CNourbon058xh61NdIXw6Ekh0WKsf970K7uPM
 HjBSmUzVaHU1RNag==
X-Received: by 2002:a05:7022:f211:b0:1ab:fe29:5081 with SMTP id
 a92af1059eb24-1b39feda1a6mr28144c88.20.1794093560293; Sat, 07 Nov 2026
 15:19:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106194621.510146-3-oss.patchbox@gmail.com>
In-Reply-To: <20261106194621.510146-3-oss.patchbox@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sat, 7 Nov 2026 18:18:57 -0500
X-Gm-Features: AclHuK-qfReAZ5yqqKCNOPnDr83op98UI78RC1Sy2xo7tXEAP8csGGMNtO7WrdM
Message-ID: <CABdDSeVYBMhFXb0gL6LeSysr56is2e4+jhkeVdimwZNgy9Y4Pg@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: musb-new: sc5xx: Free the controller if the host
 probe fails
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yuho,

On Fri, Nov 6, 2026 at 2:46=E2=80=AFPM Yuho Choi <oss.patchbox@gmail.com> w=
rote:
>
> In host mode, musb_usb_probe() allocates the struct musb with
> musb_init_controller() and returns the error when musb_lowlevel_init()
> fails, for example when no device is connected. The struct musb is not
> freed on this path, and the driver core then frees the private data that
> holds the only pointer to it. Each 'usb reset', or 'usb start' after
> 'usb stop', probes the controller again and leaks another one.
>
> Free the struct musb when musb_lowlevel_init() fails.
>
> Fixes: 2f6a86a61256 ("usb: musb-new: Add support for Analog Devices SC5xx=
 SoCs")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Build-tested only, with sc584-ezkit_defconfig.
>
> musb_usb_remove() does not free the struct musb either; that is not
> changed here.
>
>  drivers/usb/musb-new/sc5xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
> index b1765abe827..c14ba821a2e 100644
> --- a/drivers/usb/musb-new/sc5xx.c
> +++ b/drivers/usb/musb-new/sc5xx.c
> @@ -165,6 +165,8 @@ static int musb_usb_probe(struct udevice *dev)
>                         return -EIO;
>
>                 ret =3D musb_lowlevel_init(mdata);
> +               if (ret)
> +                       free(mdata->host);
>         } else {
>                 sc5xx_musb_plat.mode =3D MUSB_PERIPHERAL;
>                 mdata->host =3D musb_register(&sc5xx_musb_plat, &pdata->d=
ev, mregs);
> --
> 2.43.0
>

Is freeing mdata->host the appropriate cleanup action?
musb_init_controller registers the pointed-to struct with the pm
subsystem, potentially allocates a dma controller to store in ->c, and
does many other things I haven't traced through yet. I would need to
review in more detail but it seems a more appropriate action would be
to use musb_free() which is currently a static function inside
musb_core.c.

Taking an even further step back, musb_lowlevel_init fails under two
circumstances: host->host is not set (impossible due to the earlier
check) or musb_start fails which only happens when the
musb_usb_ops->enable() function is present and fails (via
musb_platform_enable) which is not part of the default musb_ops that
we are using. It is therefore impossible for musb_lowlevel_init to set
ret to a nonzero value in a way that leaks resources on this platform.
I have not checked the other drivers referenced in this series, but I
honestly assume we all copied the same driver and behave in basically
the same way, including default musb_ops.

I don't think we should make this change for now.

Thanks,
Greg
