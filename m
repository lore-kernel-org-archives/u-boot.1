Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6908DC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 05:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C005688486;
	Wed, 22 May 2024 07:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z7dyYJw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57CC88488; Wed, 22 May 2024 07:57:29 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E2E881C3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e72b8931caso31965351fa.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 22:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716357447; x=1716962247; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oYI2aMN8R9uU5/6yWQIwX4a0ilibNW7NIX8cBsU7vEs=;
 b=z7dyYJw+ihKDD672Qr2WKtHPsEpQFb6LXNOPEUh8wNmk66W1nQ7irRNZU9kXR1OKS4
 DyJS6LjEMl3oQwkTvx0AjL/qE7I4thK60Q3JtqsCQlX+P8AIiEKqknh261sYCkeJfMdm
 +/W4MkKXLhsZAzVBlBFAcX1dU7rG0EVqDWTLViiGoicjNjJSViW5L5/MIaOJhNwlPTzo
 RdKG3xywcC7+KaMQmk8a3oj0nsU1lCfsLxjymL7dgrrykmZPJFZn2mZSMeVfOXsyx9Bj
 ACcfqQ9rzW4aDxUHq1bcKXHqw810C2APkBV+t37BnDHeEGw8d2Vt4OSTrQJ+c7jd4pmw
 Ax8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716357447; x=1716962247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYI2aMN8R9uU5/6yWQIwX4a0ilibNW7NIX8cBsU7vEs=;
 b=ceOLPvFq9FvKVXatpSuRuPEinkpiUIpLQX5GWMsQwd9PY8FEcNs5CQmc70QmS6961c
 mnjr15u+EptGowHsd5ZEk0KjhkQF0atEU6IOvwFC6BvT/NXHhpZCGFoyCOPitP7W11C3
 rT70rck90kLmMeSsjLLvoKB3sFWw2lz8fDOnbFZnY/5H2eIAuAL8rBuOBEbkCuXpYi3T
 XFj6cPEdImkbdBsIrJ0fosQ2g1vzS/ULwtTHKAqO0rEeBcU242ph+bXWijUR0K/lokyz
 i8lA4ommhydlbb/CfqGBvx0YWjFL7mn3OGsdqDLHhunUjFsrkhTnckPDPiOfPIl3Ox98
 1Tmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbh1bzwC4AaWF/529pLIGda6e3zFvLQOKG/8f87mhTR5wpXau3oxMdKZfeFYNfv4G0z5BkTYetDh/yN33HMf2Ho3Yh5g==
X-Gm-Message-State: AOJu0Yy6QFksWFYw/KiqQNg32FIZupg/HMGKtxAaZX2lRcUOimurnzti
 da7YSHCEx50jrayZ6GLj9eq43DPQU2GpBbaeHgdyLvYxuGj3RfGf0GY91EXjvL+9/sfbocNwn7g
 M
X-Google-Smtp-Source: AGHT+IGkunnxXyU/YMzUEJtkzG4XFEb2VhDvm0MkaIQLOL6KUNMNCnrmJRzNIsDUw3bG7gocIv4pcg==
X-Received: by 2002:a05:600c:c2:b0:419:f9ae:e50 with SMTP id
 5b1f17b1804b1-420fd375f0dmr6570515e9.37.1716357426134; 
 Tue, 21 May 2024 22:57:06 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe518a8fasm460687415e9.33.2024.05.21.22.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 22:57:05 -0700 (PDT)
Date: Wed, 22 May 2024 08:57:03 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
Message-ID: <Zk2JL2bqBLbe6tSk@hera>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
 <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
 <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
 <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com>
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

On Tue, May 14, 2024 at 02:49:47PM +0200, Heinrich Schuchardt wrote:
> On 4/26/24 17:47, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Fri, 26 Apr 2024 at 17:53, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > On 26.04.24 16:30, Ilias Apalodimas wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >
> > > > > Provide a function to append a device_path to a list of device paths
> > > > > that is separated by final end nodes.
> > > > >
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > ---
> > > > >    include/efi_loader.h             |  3 +++
> > > > >    lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
> > > > >    2 files changed, 34 insertions(+)
> > > > >
> > > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > > index 9600941aa32..a7d7b8324f1 100644
> > > > > --- a/include/efi_loader.h
> > > > > +++ b/include/efi_loader.h
> > > > > @@ -944,6 +944,9 @@ struct efi_load_option {
> > > > >
> > > > >    struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> > > > >                                          const efi_guid_t *guid);
> > > > > +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> > > > > +                                    efi_uintn_t *size,
> > > > > +                                    const struct efi_device_path *dp2);
> > > > >    struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> > > > >                                         const struct efi_device_path *dp2,
> > > > >                                         bool split_end_node);
> > > > > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > > > > index 46aa59b9e40..16cbe41d32f 100644
> > > > > --- a/lib/efi_loader/efi_device_path.c
> > > > > +++ b/lib/efi_loader/efi_device_path.c
> > > > > @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
> > > > >           return ndp;
> > > > >    }
> > > > >
> > > > > +/**
> > > > > + * efi_dp_merge() - Concatenate two device paths separated by final end node
> > > > > + *
> > > > > + * @dp1:       first device path
> > > > > + * @size:      pointer to length of @dp1, total size on return
> > > > > + * @dp2:       second device path
> > > > > + *
> > > > > + * Return:     concatenated device path or NULL
> > > > > + */
> > > > > +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> > > > > +                                    efi_uintn_t *size,
> > > > > +                                    const struct efi_device_path *dp2)
> > > > > +{
> > > > > +       efi_uintn_t len, len1, len2;
> > > > > +       struct efi_device_path *dp;
> > > > > +       u8 *p;
> > > > > +
> > > > > +       len1 = *size;
> > > > > +       len2 = efi_dp_size(dp2) + sizeof(END);
> > > > > +       len = len1 + len2;
> > > > > +       dp = efi_alloc(len);
> > > > > +       if (!dp)
> > > > > +               return NULL;
> > > > > +       memcpy(dp, dp1, len1);
> > > > > +       p = (u8 *)dp + len1;
> > > > > +       memcpy(p, dp2, len2);
> > > > > +       *size = len;
> > > >
> > > > Can't we just use efi_dp_concat()?
> > >
> > > efi_dp_concat cannot be used to put a device-path end-node in between
> > > two device-paths that are concatenated. We need that separator in the
> > > load options.
> >
> > I am not sure I am following you. It's been a few years so please bear
> > with me until I manage to re-read that code and page it back to
> > memory.
> >
> > What I remember though is that the format of the DP looks like this:
> >
> > Loaded image DP - end node - initrd GUID DP (without and end node) -
> > initrd - end of device path.
> > So to jump from the special initrd GUID to the actual DP that contains
> > the initrd you need to do an efi_dp_next(). Also, efi_dp_concat() will
> > inject an end node with a DEVICE_PATH_SUB_TYPE_END type if the third
> > argument is 'true'.
> >
> > What am I missing?
>
> Let us assume
>
> dp1 = /vmlinux/endnode/initrd/endnode
> dp2 = /dtb/endnode
>
> and we invoke dp_concat(dp1, dp2, true):
>
> sz1 is calculated via the efi_dp_size() function which looks for the *first*
> device-path end node.
>
> sz1 = efi_dp_size(dp1) = sizeof(/vmlinux)
>
> sz1 will not include initrd and its endnode.
>
> So dp_concat(/vmlinux/endnode/initrd/endnode, /dtb/endnode, true)
> will return:
>
> /vmlinux/endnode/dtb/endnode
>
> but in our boot option we want
>
> /vmlinux/endnode/initrd/endnode/dtb/endnode

Correct,

> I introduced an new function efi_dp_merge().
> Instead we could change the arguments to:
>
>
> * @sz1:
> * * 0 to concatenate
> * * 1 to concatenate with end node added as separator
> * * size of dp1 excluding last end node to concatenate with end node as
> *   separator in case dp1 contains an end node
> struct
> efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>                                const struct efi_device_path *dp2,
>                                size_t sz1)
>
> and replace
>
> sz1 = efi_dp_size(dp1);
>
> by
>
> if (sz1 < sizeof(struct efi_device_path)
> 	sz1 = efi_dp_size(dp1);
>
> Best regards

Yes please, I like this more.  we already have enough efi_dp_xxx

Thanks
/Ilias
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > > +
> > > > > +       return dp;
> > > > > +}
> > > > > +
> > > > >    /**
> > > > >     * efi_dp_concat() - Concatenate two device paths and add and terminate them
> > > > >     *                   with an end node.
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
>
