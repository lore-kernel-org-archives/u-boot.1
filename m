Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56EDC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D23A87530;
	Mon, 27 Nov 2023 16:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DpGmGu6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FE987538; Mon, 27 Nov 2023 16:32:11 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC6D87512
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a00a9c6f1e9so626749066b.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701099127; x=1701703927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UMkTpiK5oK1Z+KHS3mADdOfgAiSSXaR7laOfl9be5Ik=;
 b=DpGmGu6QengBYdU1BeJWOVe+7jhviKvj6UnX8/gsYTGcswdsIRmCUWFkG2lAw5JaP8
 ZTnre5SAdB4TZ/STpb3M8XkJZ+5qL1ArP0ZJ8WH7Y63v0ueiILlejCQvAY1OsDBBGeqK
 EYIPIyIwaXvJtIef5NqPWyCSOK4n3GdcZM5NWxBFD7BJM5WWciwCzIORfJzBy3lJDMjT
 zmjjEFQ+gt54pXejNNFwKFzjDTqp7+VJTh92ndF/3fayKnYA8qNMDDXSR9aSbC9uPQV+
 3GL1cdCwRBh+HiuY7UGXAPlLaYhyhcc+vgEFhasAQKx6Pt0/MCTl5kTtghHrrSbiJKxp
 GiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701099127; x=1701703927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UMkTpiK5oK1Z+KHS3mADdOfgAiSSXaR7laOfl9be5Ik=;
 b=lciwyWwv6Oi5LmH+iTimBZJcAMBLXZ4a0wqwApTH5vgLetqscxwZtmHnLkZBQqV6ZR
 dHoUzzYZK+CUOogMoG0KNQqzIGqM0rS8hHMgaIbBzowgREtPctmKA4EdBet51pFAXuHv
 hUnvClJzPakG3QQ20e9mWNZy+ob8bdD1GrrHfKj4dTTaCUh5Zgzaclb8Vwjl5bCHWtF4
 BQDrPU1tfKzw5WHoTE0rrk3iS9ITSfdiB141UnRGsjhF2l+1zcEKzULsgKDG643klp3k
 DHq9oMma7GaTyoSPDzzh/5GD/4PYlWaqPA7Y3OnGhdkOOwDrfqPRyPLpFX/vcI6/5jZh
 ziUA==
X-Gm-Message-State: AOJu0YxoDAyCbK4PClDnHAItvRQv/0YBGQBGuhfVC5e5hp8MFDkmLKKK
 eE0/nXMt2kcd88/itKWKcKjeLJkEB+pUyOLDVEIb95VBxBd/cg3YuMg=
X-Google-Smtp-Source: AGHT+IF67u4aAStrfHFDvhkMvrZQVXWAcH3MYRe8oVHP/ehLtWVf1bDu46u/C5C9MyNmxGawgcNjEdYAk/bTETSBAm0=
X-Received: by 2002:a17:906:b2d4:b0:a10:e7c7:2295 with SMTP id
 cf20-20020a170906b2d400b00a10e7c72295mr1647619ejb.27.1701099127424; Mon, 27
 Nov 2023 07:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
In-Reply-To: <20231127140813.GF2513409@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 27 Nov 2023 21:31:54 +0600
Message-ID: <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> > >
> > > > Increase allowed binary size to fit lwip code.
> > > >
> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > ---
> > > >  configs/am335x_evm_defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/configs/am335x_evm_defconfig
> b/configs/am335x_evm_defconfig
> > > > index f048e60f7f..9fd608bd76 100644
> > > > --- a/configs/am335x_evm_defconfig
> > > > +++ b/configs/am335x_evm_defconfig
> > > > @@ -124,3 +124,4 @@ CONFIG_WDT=y
> > > >  CONFIG_DYNAMIC_CRC_TABLE=y
> > > >  CONFIG_RSA=y
> > > >  CONFIG_LZO=y
> > > > +CONFIG_SPL_MAX_SIZE=0x29000
> > >
> > > As probably a problem for other platforms you made this change on too,
> > > you can't do this. The link limit is here because that's the limit the
> > > hardware (and ROM) imposes.
> > >
> > > You might need to either:
> > > - Figure out how to make lwip even tinier for the SPL case
> > > - Limit the old network stack to just for SPL, and a later task is to
> > >   reduce what's in the old stack to just what's also needed within SPL.
> > >
> > >
> > Thanks Tom. All these size changes need to be reviewed.  Some of them are
> > ok, I think like for x86 or qemu virt, but some of them might not work.
> >
> > Question - Do we need networking inside SPL rather than in the main
> binary?
> > Is it a real use case?
>
> Yes, the device supports loading SPL, and then SPL loading U-Boot both
> over USB RNDIS as well as regular physical ethernet.
>
> --
> Tom
>

That looks like not a production use case. USB + NET + drivers + EXT4 +
NAND + MTD and everything else and trying to fit into SPL.
With enabling LTO I still need 4k (without dropping current code). From one
point it's too synthetic use case here and might be a historical
limitation which we will not see on future boards. From the other point it
will be good to not break it somehow....

BR,
Maxim.
