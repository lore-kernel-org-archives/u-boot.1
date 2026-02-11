Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9992E9E31B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2335483DBF;
	Wed, 11 Feb 2026 16:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LYyEYJfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D1A83D9C; Wed, 11 Feb 2026 16:33:54 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7325A8388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-790b7b3e594so76080257b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:33:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770824031; cv=none;
 d=google.com; s=arc-20240605;
 b=ieB5JODG2YElQ8dazRuB5jesQm6bQdH3UhdFyv3HI7eEb9Y8Fd/RiNGVukLdZksN8B
 FcPq9aFkR0zXyaGhFvkaRuoF43Sta/Heh1IV7Sl0k/w8TEOCKCbd39VGo+oEBFhyig9I
 Y4oxBJ7+/weAF5YcijbXMtrFWzlEINvPK25kyGgRWSidtgZ7hZrhaqnqsjUXl8WxNAj9
 7QwdV05TiJpV1fKsiwV5y7NKHGZE5MVvefbJ8GHCpZyZTKSAqpz4VtHC5bDzwGWL4jL0
 a0IL8G+XSrW/kCrbzB/NWNpYcjuDrJcAuyKyc4m6fLlE5ON7jfZVJKcUI7X0Y3+YPYXC
 LKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dtOAWC/F9HOP02OcYfJxdATFDW5JrG743cyJNtfI6Bs=;
 fh=wrhZen22MtbkREBrqvGymwuHbf+JYQB1yPUxtoA5vm8=;
 b=XJwkDrvHfhvfoOjWIdDQW8vQlSZ1j8TRHBhJXBdz/GAZEA5gtCqGPMGB5SQkYeIrlQ
 eR2UeWK1FManB2jSn10DQevrOrLxEru/iYGRmDyJyY5oNzd17n1UwnXJfrSQfZ4sCnBX
 F9H/ia6Sz+p6vsb1/ijhe2dMuIXewNW+sqWsymC/HFASHYbZnZxm0chdiza4tiWuoV88
 0ojW1T7fZW4i7exCDuWjVg55EOXoDkmtqkooAL4gPTWI8AUL5d8FDwyF0FxzEsaV+SvP
 YF1oCHQ2dpqG+omuBcxn4YeNEzi/9S1TS87sjon3Pe6j/tY3mZXdJBIMPHXMY0YDA7HE
 JHOg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770824031; x=1771428831; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dtOAWC/F9HOP02OcYfJxdATFDW5JrG743cyJNtfI6Bs=;
 b=LYyEYJfbhw3DNZSqOqMg41KSn7g4bsRp24Hl6v4ru/YpsRJZE2QEeoquKquA2IrpH0
 12urC/OvQmNIS5Toqt9pOvumLsqDBIzq7TePG4iBJQPalH/rmkJWsdF92rhOSPU2NHB9
 sl+sIGdyPSb4FEvVnNUue+zyiDTp6TBhTHKdGN9P9Y0Dd/EuxVbXb/MrHlapNijaSXfx
 gIUwYA63STdt3lU4rib8Jc8YKW/DAbb3cMDE/uQEcEbjfghkvj++0IX6Wi90yrXY3br2
 mE5huzN4noDgC+Bsy9zsZBi0Ffip6F2JoMXHpypLI9ZeaxKoQ/PKxGd0b+FGkDpssBfK
 dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770824031; x=1771428831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtOAWC/F9HOP02OcYfJxdATFDW5JrG743cyJNtfI6Bs=;
 b=t2d55U8v8DeXrLHjFgNCakiP0p3/dhAZDYTYQT36Bw7AYr8YpnwFjy4qym2Dm35A+I
 1/vfUBDxhEuO8VFihss6NG+M77cpKCRDDR7XgzoIoDOb8M6g4ABkJJwaYz9B1IyE3pVT
 m+3uDWwLyMq/OHvjjHsFVC/MVVsxSJ5hi+eoMWCWl59Y4zOarE45OyhuSYyLT2HGZDW9
 8kb6TKWhFv7IPkuHMWQj0RewxM70pNkP8LagPvSrc9i9bBFNXHO1pbx6ZFkuD12CcxDL
 JY7ZkQOoeN1t7ChvLoKQKCD1gfqAnvNUm3RVoCa8HZM19UIhIFb9MePdCab1+jWrxEmi
 jkVg==
X-Gm-Message-State: AOJu0YwHDtDmPYZJYpu2CyeLjYsQPzejf5laL2CsExv4Qjxh3P9I+qyS
 Jl4ccJTvc7Q8PpIMRIrdVpLPfN64C1KBTtIBUyCYgGY6F8j3JdwvdKZ3eJT6NmnoksmMTUVRH2s
 OB0TglU63YXdICWd4T+p6apI/XmNqB/hotUzY0eh8uQ==
X-Gm-Gg: AZuq6aIsAnGq/gR85o+J+HM0/EBdNyQLSQdE8cJzH1X1Gsv1Hp3YFf2mRvnCuDuwgGi
 X9kcpTo4aLtPYgkmGnPJB/cosMhmrWYgMiCMxhdEi4/M86rNJ5CCfeII14FSjp2YS1JNNhqHua4
 j7lqkJwjh7gaMDNooGEJXWKCtFMFTnoQ1TNJw473AJ6/E61oocaotGW+mUltYe/aDroU/k/t/h8
 BJsTis64ZIJ3ACOuQ8O7kvbksTkEd87vgOkQAh2ZpZDWM5J3PDZJ0/YgwwZ9Aep9tLjEU//2L1D
 ZNH81mdQV/yofj80wuGN4SkW/BVa1R+nTT2d1mKSAKWwhVpk3RmwcaGA5rhs1EzJDrMzOXh4CnW
 PIFZfCVXIxXOuAApo6iP89o3oDk6jVZyT8prRUrTQoRUY3jd/kODfPg5HgqWr3VDjI8N58YUN5B
 /S8DDsO1VZ+kJCkbzgfYYRptUBdXI1EbwkFzvByn9jE4Xs5uRpoctMW0BXeQAWPf5KanzNdEqqp
 Zepv4hZ9nxyRV6Q+2e/+4zuFgNIVZJb2qfh5hiDfMw3vEDS/WJEQaS6D7JTYCZRczm1tKBTcxhC
 xhZfegXxn1D19pFEKcHT1aoxTEYhSURS0RWh+uQEXV9B
X-Received: by 2002:a05:690c:d95:b0:794:7ad3:8788 with SMTP id
 00721157ae682-7965f046c04mr53459047b3.48.1770824030972; Wed, 11 Feb 2026
 07:33:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <f56553cd519b768f8febba0b8d807de3cad14739.1770119483.git.michal.simek@amd.com>
 <CAC_iWjLHCPVDTTqV9F8NiaLGkV_PP3M9OPC3dDzozSEk6FRFTQ@mail.gmail.com>
 <e14baf37-a610-42f8-b155-315e0f4f35d7@amd.com>
In-Reply-To: <e14baf37-a610-42f8-b155-315e0f4f35d7@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:33:15 +0200
X-Gm-Features: AZwV_QgIYBJ5Z2S5Ur9ky2Ssrjj2Tb5BU4s9k8kTno79NQScpF0ls8xWg6HJqw0
Message-ID: <CAC_iWj+ATpyLhJdKtSuZqSVbztp51MYqbWyCKH2=O6Xo7pKWAg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] efi_var: Unify read/write access helper function
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 11 Feb 2026 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 2/11/26 16:06, Ilias Apalodimas wrote:
> > Hi Michal
> >
> > Since you'll have to send a v8 a few nits.
> >
> >
> > [...]
> >
> >
> >>   }
> >>
> >>   /**
> >> - * efi_var_to_file() - save non-volatile variables as file
> >> + * efi_var_to_storage() - save non-volatile variables as file
> >
> > it's not 'as file' anymore right?
> >
> >>    *
> >>    * File ubootefi.var is created on the EFI system partion.
> >
> > And this needs an update "If they are stored to file..." etc
> >
> >>    *
> >>    * Return:     status code
> >>    */
> >> -efi_status_t efi_var_to_file(void)
> >> +efi_status_t efi_var_to_storage(void)
> >>   {
> >>          efi_status_t ret;
> >>          struct efi_var_file *buf;
> >> @@ -85,7 +85,7 @@ out:
> >>   }
> >>
> >>   /**
> >> - * efi_var_from_file() - read variables from file
> >> + * efi_var_from_storage() - read variables from file
> >
> > same here
> >
> >>    *
> >>    * File ubootefi.var is read from the EFI system partitions and the variables
> >>    * stored in the file are created.
> >
> > and here
> >
> > [...]
> >
> > You can keep the r-b tags, as it's just comment updates
>
> This is actually correct. Because this code is used only for storing variables
> as file on filesystem.
>
> I updated include/efi_variable.h which is generic and shared between fs/sf but
> lib/efi_loader/efi_var_file.c is only for saving/reading file on FS.

Ah yes, you are right. Ignore the comments above then

Thanks
/Ilias
>
> M
>
