Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E48EC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 15:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4B7800C2;
	Mon, 20 Jan 2025 16:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhWgfPCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C074805CD; Mon, 20 Jan 2025 16:41:06 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE7380077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 16:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4afdf096fc5so1043096137.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737387658; x=1737992458; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA5sQLo9OcQaoQpYAc/7ZsnUirGEIr/9P/knbHAR58k=;
 b=PhWgfPCxKyHKjUYQ6BsCoVZFvZR4UcYDYoTXFW80t4ForYKB6UftahkXGBHflqm5Bk
 v0NJKUx5Vuh4WkUgfl8EC9UvoWxG94MF47tpi+nXpHHx/NIVg43xdW3PZMxfDVMBgKZX
 DXQ3mHS4XUgfdthQILqqm7vDeYsqeHZsAq85Y9U163e2hEpK5LrNgm34bjGFESIBqxcM
 zSTZHYNeGeAO30VneqyggInWG8Q+oebjVG8KSjyIPVPoetkhftZKC1co6vZ7kFZ30PhN
 iXgBJUpVeNLDHtwallOq6VtBgZwvy5AxJZA6fb1ktUf8sLifluMLBOLOiHUMYvxVIQWG
 vcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737387658; x=1737992458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA5sQLo9OcQaoQpYAc/7ZsnUirGEIr/9P/knbHAR58k=;
 b=OW1qlq4TiWgh04youdDcxhZ+Br8RQihEuvp+4fmrvRnObtkat4bgzXeYZaftpWWcHY
 XOsjLdttm3BAXOk16p+Qm5e24dk+tWvcQNEN++qidFWiPMQ+ZsKz0gU6hbgiP4eI+BQ6
 CPVyhXtfkoU2A3CxYTmBTo3/j01uU/bl6ino6BsuckmJsUkTMCm8j1TROjhNlG3q5rSb
 xE8GpVewgx4I8I2Y/nWiUsbd6lbVwKJBTYbKCn4vtMftnrifWCfE8kao9eXQ7oQit8bE
 WByR+RlzFnngRaoneLZZxXanjUwoPW6p3WdiYZibxJrNFbTSuvH1fsa9TyH6/p0EqLT+
 dXKQ==
X-Gm-Message-State: AOJu0Yytxajh9r2G/oSLsf90DNObLZ0k9dqbE0Gqw+bp3E4ylItMsNO6
 kjQakEzwGogANSk+FZXoa+9iVAkRZggbRmN5BKRsZibeBX2GNUl0wY3490tT4wdHqlkiPCYx/8P
 0HPo7jFBtdACTzz52Qb4dRa9wUtsXzZfPVIbCcg==
X-Gm-Gg: ASbGncvPXLRH/dRR2Mz+CsY8PRBwamWwPCtdk51h0i/ypg08ELZ2PdyWU0jm02gcdP2
 7XJHX1QUOpszJZgQQ8fL/EU2/VzsUcaCU8pCDQSRRstZLZEFRHlvY
X-Google-Smtp-Source: AGHT+IHvJg9Ff5Iahrak+eunId/WBScWcvuHMCzH03Fc7ykA+jr1OyMYoIQCsbhZX0rJ/Sr6Xa4pL0SlidyNlDzhY3Y=
X-Received: by 2002:a05:6102:3909:b0:4af:f8b9:bea0 with SMTP id
 ada2fe7eead31-4b690cde772mr10142255137.18.1737387657662; Mon, 20 Jan 2025
 07:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
 <874j1t7dsw.fsf@waldekranz.com>
In-Reply-To: <874j1t7dsw.fsf@waldekranz.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 20 Jan 2025 21:10:46 +0530
X-Gm-Features: AbW1kvZ_9Gw-T3STgSixYkE1wXZkXIPPLpmsvtNP8-sa15wmrJ99xVkX2zCO73E
Message-ID: <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 20 Jan 2025 at 20:06, Tobias Waldekranz <tobias@waldekranz.com> wro=
te:
>
> On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.com>=
 wrote:
> >>
> >> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@linaro.=
org> wrote:
> >> > Add information about the type of blkmap device in the blkmap
> >> > structure. Currently, the blkmap device is used for mapping to eithe=
r
> >> > a memory based block device, or another block device (linear
> >> > mapping). Put information in the blkmap structure to identify if it =
is
> >> > associated with a memory or linear mapped device. Which can then be
> >> > used to take specific action based on the type of blkmap device.
> >>
> >> Is this restriction really necessary? Why should it not be possible to
> >> setup a block map like this:
> >>
> >>  myblkmap:
> >> .--------.      .-----.
> >> | slice0 +------> RAM |
> >> :--------:      '-----'     .-------.
> >> | slice1 +------------------> eMMC0 |
> >> :--------:      .-------.   '-------'
> >> | slice2 +------> eMMC1 |
> >> '........'      '-------'
> >>
> >> Linux's "device mapper", after which blkmaps are modeled, works in thi=
s
> >> way.  I.e. a blkmap is just a collection of slices, and it is up to ea=
ch
> >> slice how its data is provided, meaning that the user is free to compo=
se
> >> their virtual block device in whatever way they need.
> >
> > The blkmap structure, the way it is designed, is pointing to the
> > underlying block device. How can a single blkmap then be associated
>
> The `struct udevice *blk` from `struct blkmap` is a reference to the
> block device which represents the block map itself ("myblkmap" in the
> picture above), not any lower device.

Okay. I got confused with the comment associated with that member,
which says, "Underlying block device". This I interpreted to be the
block device that is associated with the blkmap structure.

>
> > with slices of different types? Would that not contravene with the
> > idea of a block device associating with a blkmap?
>
> For slices which are linear mappings (and are thus backed by some other
> underlying block device), their reference to that lower device ("eMMC0"
> and "eMMC1" above) is stored in the `struct udevice *blk` member of
> `struct blkmap_linear`.

Okay. But then, the computation of the blocksize seems to be happening
at the blkmap device level, which again implies having the same set of
slices associated with the blkmap. Any reason why the blksize is not
taken from the block device associated with that slice? That would
make it clear that the slice mapping type is independent from the
parent blkmap device.

>
> Slices which are backed by memory does not have any reference to a lower
> device, but merely a pointer to the start of the mapping - `void *addr`
> in `struct blkmap_mem`.
>
> The overarching idea is that the block map does not have to know
> anything about the implementation of how any individual slice chooses to
> provide its data.  It only knows about their sizes and offsets.  Based
> on that information, it simply routes incoming read/write requests to
> the correct slice.

Okay. I think, for my solution, I will just need to move type
identification to the slice, instead of the blkmap device.

>
> >>
> >> Looking at the pmem patch that follows this one, I am not able to find
> >> anything that would motivate restricting the functionality either.
> >
> > The subsequent patch is adding the persistent memory node to the
> > device-tree. The pmem node that is to be added is the memory mapped
> > blkmap device. The logic does check for the type of the blkmap device
> > and then proceeds to add the pmem node only for the memory mapped
> > blkmaps.
>
> Sorry I am confused.  Why do you need a block map device to add the pmem
> node to the device tree?

This is needed to include the RAM based block device information in
the device-tree as pmem node. The OS installer then uses this pmem
device as the block device which contains the installation packages,
and proceeds with the OS installation.

-sughosh
