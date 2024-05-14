Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1702AC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E9F88311;
	Tue, 14 May 2024 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="OUen3qHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14CE8830F; Tue, 14 May 2024 14:58:57 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B8D880F8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: aef25b41-11f1-11ef-9240-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id aef25b41-11f1-11ef-9240-005056999439;
 Tue, 14 May 2024 14:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=DeUdXgUuQ78mDoW0QfZablKbKTPzwruLofjuDNsHUtw=;
 b=OUen3qHoQepA6POvvTYf5EHo02/k3zjmvv+EEmWwhHk9tVd0V7vy7UOuCbFbjkokVAMC5hvzyZb1x
 wsE5xUAkhjWJl8KjYW1mpuxQ5ZnehvUaqbA+vqrjsXz73ocDaQymfq+OE5Ga/y/gNAdUd8Sl0gaP5w
 IKM+v96VSD5KYxGCDyCkGMa5EywZpMbHUaCNeaxej4kABksk7rKo+UWZKRGR0etB5yCcXVreBVIx/3
 qCeSlYQGtl9OZJ2+JjijW/ix+4LIduea0iVuOgBmr0kbQ7lDILNawCBlYXFiGyNa4ooYj4G/FNqUBn
 Focdat9GKkD3jx8dHG8G7NHe6LYrrOQ==
X-KPN-MID: 33|dALZithOjIF7udN01vM7rb2bzeyVlr/7JkhepmJYDeetlYeapPabOPmBZ8ytpqY
 POD1+dlAxVX/TgHSfTGFaDdqv1b0bxORh23NVhRW+l2Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jMcrPsBcdVjqx2kwJSNerSXBA/871f2dE4suAAJpL0ScIrdH5MWfRHDHwShBh6B
 mK5x/Yo6/qTqQaD7wtk1z2g==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b74b3a80-11f1-11ef-9bde-00505699772e;
 Tue, 14 May 2024 14:58:54 +0200 (CEST)
Date: Tue, 14 May 2024 14:58:53 +0200
Message-Id: <87ikzgft2q.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 i@shantur.com, bmeng@tinylab.org, akashi.tkhro@gmail.com,
 kojima.masahisa@socionext.com, raymond.mao@linaro.org,
 kettenis@openbsd.org, jmcosta944@gmail.com, u-boot@lists.denx.de
In-Reply-To: <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com> (message
 from Heinrich Schuchardt on Tue, 14 May 2024 14:49:47 +0200)
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
 <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
 <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
 <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com>
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

> Date: Tue, 14 May 2024 14:49:47 +0200
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hi Heinrich,

> On 4/26/24 17:47, Ilias Apalodimas wrote:
> > Hi Heinrich
> > 
> > On Fri, 26 Apr 2024 at 17:53, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 26.04.24 16:30, Ilias Apalodimas wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> Provide a function to append a device_path to a list of device paths
> >>>> that is separated by final end nodes.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>>    include/efi_loader.h             |  3 +++
> >>>>    lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
> >>>>    2 files changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >>>> index 9600941aa32..a7d7b8324f1 100644
> >>>> --- a/include/efi_loader.h
> >>>> +++ b/include/efi_loader.h
> >>>> @@ -944,6 +944,9 @@ struct efi_load_option {
> >>>>
> >>>>    struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> >>>>                                          const efi_guid_t *guid);
> >>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> >>>> +                                    efi_uintn_t *size,
> >>>> +                                    const struct efi_device_path *dp2);
> >>>>    struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> >>>>                                         const struct efi_device_path *dp2,
> >>>>                                         bool split_end_node);
> >>>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> >>>> index 46aa59b9e40..16cbe41d32f 100644
> >>>> --- a/lib/efi_loader/efi_device_path.c
> >>>> +++ b/lib/efi_loader/efi_device_path.c
> >>>> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
> >>>>           return ndp;
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * efi_dp_merge() - Concatenate two device paths separated by final end node
> >>>> + *
> >>>> + * @dp1:       first device path
> >>>> + * @size:      pointer to length of @dp1, total size on return
> >>>> + * @dp2:       second device path
> >>>> + *
> >>>> + * Return:     concatenated device path or NULL
> >>>> + */
> >>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> >>>> +                                    efi_uintn_t *size,
> >>>> +                                    const struct efi_device_path *dp2)
> >>>> +{
> >>>> +       efi_uintn_t len, len1, len2;
> >>>> +       struct efi_device_path *dp;
> >>>> +       u8 *p;
> >>>> +
> >>>> +       len1 = *size;
> >>>> +       len2 = efi_dp_size(dp2) + sizeof(END);
> >>>> +       len = len1 + len2;
> >>>> +       dp = efi_alloc(len);
> >>>> +       if (!dp)
> >>>> +               return NULL;
> >>>> +       memcpy(dp, dp1, len1);
> >>>> +       p = (u8 *)dp + len1;
> >>>> +       memcpy(p, dp2, len2);
> >>>> +       *size = len;
> >>>
> >>> Can't we just use efi_dp_concat()?
> >>
> >> efi_dp_concat cannot be used to put a device-path end-node in between
> >> two device-paths that are concatenated. We need that separator in the
> >> load options.
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
> sz1 is calculated via the efi_dp_size() function which looks for the 
> *first* device-path end node.
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

That makes me realize a potential flaw with the design of this boot
option.  The concept of an initrd is Linux-specific, but the concept
of loading a DTB to pass along to an EFI image far less so.  So how
would this work if I want to only pass the DTB?  Would that be:

/vmlinux/endnode/endnode/dtb/endnode

?
