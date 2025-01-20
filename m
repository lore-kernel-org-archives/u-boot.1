Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5141C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 16:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93B3801CF;
	Mon, 20 Jan 2025 17:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="m+RqrEr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC55B801F5; Mon, 20 Jan 2025 17:20:43 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41713800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 17:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53e389d8dc7so4681492e87.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1737390040; x=1737994840;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z9KCsggMp6wuxS5z4HdjZ+kmIn4QK3LRIpeSaIioNLM=;
 b=m+RqrEr7THI8SbPxY3OqTffAqdc4at4zc0eerpfZWuu5oy1bMcEa1WeF8xgIhCildo
 e9n7V38Ff6fA/ghN1Qy6hAEXxNrO0ni5KnJohYotBAZleZlZz1Km6+bhMZGjnDbhMa1+
 KAVAmYfy4Qvaq6MPsKD0oC8cu9/7D9anMP0m0jL+jTQRUzmvhLPmndcahNsXLV2I9koV
 RN4QdOPRT44Wo1+OFYQBbLZ0wGsFvtmeILR5YFWoARcVg09lTJU18LF5RA300A/p3FRi
 BCVV4wY2G8SusVHEyoJz/rFjk5o+xtaXGB8s+YREStaVrTZWZnEdkjILaVQHeIlfbGBM
 mBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737390040; x=1737994840;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9KCsggMp6wuxS5z4HdjZ+kmIn4QK3LRIpeSaIioNLM=;
 b=Tl0L28lUa4EJITpiu/Zoo6HPCy08D1fkObDf5bStPE9CWBc2SGXO00sagNhPZlxzgH
 wtQBylwxaWxfrOniL9EjMw1zNg3NQ1lGTuOH1aFbEk0q5p79JL3jAgsrpfWUxmybYtlD
 a5c6WjGj6qt1PhO/rYr6co070yD9XuF3FUXEyWNRvTNy6aPqBIZtjnCbJHp9i6kZsngu
 93erHfocE7XYlCu3KgzkaR3lNfElyaEj6WDbFF9rKRo75vJg6zKJG/opQ5jKw77Wodkx
 AzhdMB5Rqu5VgLFN8iZ+aiTy4lf70lZ4QvPXGMY7Fxh81dQVdV3/YGVf1hPX8yi4PPe5
 yVZQ==
X-Gm-Message-State: AOJu0YwmUJ7UrLlstD9YTcouH4t4QSnjXtSc98nmpWLqBBxDw0qmwd0J
 khj3Ywl3I9Z+nAgotNAODQxpQVPvwoujxxwiPKnv9ytjNPqsP0vJJC8U9yLrKe4=
X-Gm-Gg: ASbGncuixwky7EU5Wl4K/Mm/WJyYUa+tIiav2QDBCyA3+GRag/Pz/0VHhqTGCCh7siG
 Pht8ffUSC7Dj7Z7zy8FsmLPlMVl17jWVn2tRHtOgH5nxaHisoVMBLGSwETPee9Uy8aH+KVpmSt9
 fZX59UpTH4LW2Z03wXYJ6fMjN6uscPDT4bY5BdQs331ggyjffeDlKHsNKL+LFJFJAxWdUEiGFxH
 PBooIrJ7bg760Jb4oSjaGp6d9L27E+uQ1tdgYX27FxIjco6w2SbuSJ0rnwcitVfH8gM0inATrF6
 dUN6PmI4b/LO/zQwB3/30tEN
X-Google-Smtp-Source: AGHT+IHkPnnp27RAuQVXWw9LJjr9UDKH9M0hdjNcC1i6YLBg8ICqQzcPD2uqu1bsJXjZBlpcsFNGPA==
X-Received: by 2002:a05:6512:3989:b0:541:3182:4578 with SMTP id
 2adb3069b0e04-5439c224b0amr4905069e87.15.1737390040384; 
 Mon, 20 Jan 2025 08:20:40 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5439af60ac3sm1418555e87.157.2025.01.20.08.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 08:20:38 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, Bin
 Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
In-Reply-To: <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
 <874j1t7dsw.fsf@waldekranz.com>
 <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
Date: Mon, 20 Jan 2025 17:20:36 +0100
Message-ID: <871pwx78yz.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On m=C3=A5n, jan 20, 2025 at 21:10, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> On Mon, 20 Jan 2025 at 20:06, Tobias Waldekranz <tobias@waldekranz.com> w=
rote:
>>
>> On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>> > On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.com=
> wrote:
>> >>
>> >> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@linaro=
.org> wrote:
>> >> > Add information about the type of blkmap device in the blkmap
>> >> > structure. Currently, the blkmap device is used for mapping to eith=
er
>> >> > a memory based block device, or another block device (linear
>> >> > mapping). Put information in the blkmap structure to identify if it=
 is
>> >> > associated with a memory or linear mapped device. Which can then be
>> >> > used to take specific action based on the type of blkmap device.
>> >>
>> >> Is this restriction really necessary? Why should it not be possible to
>> >> setup a block map like this:
>> >>
>> >>  myblkmap:
>> >> .--------.      .-----.
>> >> | slice0 +------> RAM |
>> >> :--------:      '-----'     .-------.
>> >> | slice1 +------------------> eMMC0 |
>> >> :--------:      .-------.   '-------'
>> >> | slice2 +------> eMMC1 |
>> >> '........'      '-------'
>> >>
>> >> Linux's "device mapper", after which blkmaps are modeled, works in th=
is
>> >> way.  I.e. a blkmap is just a collection of slices, and it is up to e=
ach
>> >> slice how its data is provided, meaning that the user is free to comp=
ose
>> >> their virtual block device in whatever way they need.
>> >
>> > The blkmap structure, the way it is designed, is pointing to the
>> > underlying block device. How can a single blkmap then be associated
>>
>> The `struct udevice *blk` from `struct blkmap` is a reference to the
>> block device which represents the block map itself ("myblkmap" in the
>> picture above), not any lower device.
>
> Okay. I got confused with the comment associated with that member,
> which says, "Underlying block device". This I interpreted to be the
> block device that is associated with the blkmap structure.

Yeah I agree that it could be made clearer :)

>>
>> > with slices of different types? Would that not contravene with the
>> > idea of a block device associating with a blkmap?
>>
>> For slices which are linear mappings (and are thus backed by some other
>> underlying block device), their reference to that lower device ("eMMC0"
>> and "eMMC1" above) is stored in the `struct udevice *blk` member of
>> `struct blkmap_linear`.
>
> Okay. But then, the computation of the blocksize seems to be happening
> at the blkmap device level, which again implies having the same set of
> slices associated with the blkmap. Any reason why the blksize is not
> taken from the block device associated with that slice? That would
> make it clear that the slice mapping type is independent from the
> parent blkmap device.

In the original series, only linear mappings to devices which used block
sizes of 512 was supported, precisely because otherwise you need to do
proper translation to work in all cases.

I tried to argue this point on the list back then:
https://lore.kernel.org/u-boot/875y3wohrt.fsf@waldekranz.com/
but I did not get my point across and the restriction was lifted anyway.

>>
>> Slices which are backed by memory does not have any reference to a lower
>> device, but merely a pointer to the start of the mapping - `void *addr`
>> in `struct blkmap_mem`.
>>
>> The overarching idea is that the block map does not have to know
>> anything about the implementation of how any individual slice chooses to
>> provide its data.  It only knows about their sizes and offsets.  Based
>> on that information, it simply routes incoming read/write requests to
>> the correct slice.
>
> Okay. I think, for my solution, I will just need to move type
> identification to the slice, instead of the blkmap device.
>
>>
>> >>
>> >> Looking at the pmem patch that follows this one, I am not able to find
>> >> anything that would motivate restricting the functionality either.
>> >
>> > The subsequent patch is adding the persistent memory node to the
>> > device-tree. The pmem node that is to be added is the memory mapped
>> > blkmap device. The logic does check for the type of the blkmap device
>> > and then proceeds to add the pmem node only for the memory mapped
>> > blkmaps.
>>
>> Sorry I am confused.  Why do you need a block map device to add the pmem
>> node to the device tree?
>
> This is needed to include the RAM based block device information in
> the device-tree as pmem node. The OS installer then uses this pmem
> device as the block device which contains the installation packages,
> and proceeds with the OS installation.

But even if the user has not setup a blkmap, don't you want to inject
the pmem node in the DT anyway?  All you need is the size and offset of
the blob right?  Is that not available from `image_setup_libfdt()`?
