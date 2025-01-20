Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CAC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7067C807A8;
	Mon, 20 Jan 2025 22:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="NnF+lW4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50803807B4; Mon, 20 Jan 2025 22:36:45 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2738077F
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so4663435e87.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1737409002; x=1738013802;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTGO1ui+dsOTej7Vp+Y6fjOBDaIUW15hHKjm2y01UP8=;
 b=NnF+lW4qmXYHBp0BrBKYpkw98JhdOcKHDX9U6XkJRV/RxnOMrWB8LqyyAJA51KzMR2
 g2/Sg0fiL7Y8b6hXSBOmD7gBqZelKxtaqApQFARHmJuc1PRGus3a79oJhNGpuzZPWxIZ
 SrhoFCSswjW9qbc0G0EhFSnY4u6vBb6vysPkjRUYFFag+rxBDLlUalwcKSaAtmobUvRj
 1Mye/x7mi4crEukSxBsyYmSDBZ76dq+Kn09cGTMIjghxTWTX2BiatebApKP+Jgb5/3US
 iWfwMZ/Q0gM6OHUp2ZLbQh7ulsTHUBJdnZzA8IQOd+apaFrvBjdQaP9V6KLH6YrF7DyA
 o8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737409002; x=1738013802;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTGO1ui+dsOTej7Vp+Y6fjOBDaIUW15hHKjm2y01UP8=;
 b=IeozDD6qrYFjXDCXdW0RF1vMluCNE7WS8zzvKRVtVG7hipL9CuM4UmN8Gy2Xhxhk3T
 JMQuKvLyJQ57LN0lF0Szs3q2HFjeknn9do7qD8wm/KRlYU9Mop2lYTic0znIcSeKLWNN
 eJnCTlR/g4QMlBPornSHdGBb7ceAGbcEksOgKETEMD57ywRaMGKo2Gh5a8gEeeyow/os
 rK0CeWHNd4yrXEQXGksG6biIZkRwYe1nC32ckV9Hm6JUupPVVTnw/52hIKK+i9n0Dxr7
 MkRh7CKnGHXiEWyyphDH4VXYGseOEzGk9ayKOSohe3bX5N9jICsSNNqe30VcTiwCPZPK
 DvMw==
X-Gm-Message-State: AOJu0YxTgCTdWZwCRzZudfXyG0Iswx9Fnx5Ve1spFTf338FlAOrJxVP0
 aGJPqJS9JNogZTjxu0wdBKKlxOCSII3ecGYrlvcUOz94z70KFCo71JHeTZzo/5s=
X-Gm-Gg: ASbGncsauoCjd5p67I65JUaKyGMNTHXpw6KLFsAKLv7eZVIEKFwDMs3VtjU6tShuOOh
 Jp6LUzsusE4isNfkGzW5DzEY52KgRsFVGwBFJw4WyYekrpetX+fnSSJYCmnA/H6Dx0TnlksyGms
 ad6S2j+7ELqoLI+/xwj1xh5wGj3zFSAevQSnGV1Oug0KX2/8Dst/+VGkpXcjqYwYspYmbEN7WMI
 eR5w9eMvWrs+Q2b41H/pJzWEt+ixxl+s2+ViFOs4XKfySiCyeYNeGYCMvoh4IeMLzN0NXtdWgLB
 FaGQi9+EZEmn7csaGwqvc2P2cIs=
X-Google-Smtp-Source: AGHT+IH48yauQulWiFDa5WpbzxrkVx47f+LyyQ+k0kKUJd2dlywTMDMqgeBd5RD45moatKW/w5LwKw==
X-Received: by 2002:a05:6512:3e03:b0:53d:e5c0:b9bc with SMTP id
 2adb3069b0e04-5439c28743bmr5274771e87.50.1737409001580; 
 Mon, 20 Jan 2025 13:36:41 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5439af07437sm1517414e87.25.2025.01.20.13.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:36:39 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, Bin
 Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
In-Reply-To: <CADg8p95HGYytdP+_PrZThW_g56GJWA=UXW5yUmaO9NWXDmHoUA@mail.gmail.com>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
 <874j1t7dsw.fsf@waldekranz.com>
 <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
 <871pwx78yz.fsf@waldekranz.com>
 <CADg8p95HGYytdP+_PrZThW_g56GJWA=UXW5yUmaO9NWXDmHoUA@mail.gmail.com>
Date: Mon, 20 Jan 2025 22:36:39 +0100
Message-ID: <87y0z55frs.fsf@waldekranz.com>
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

On tis, jan 21, 2025 at 00:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> On Mon, 20 Jan 2025 at 21:50, Tobias Waldekranz <tobias@waldekranz.com> w=
rote:
>>
>> On m=C3=A5n, jan 20, 2025 at 21:10, Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>> > On Mon, 20 Jan 2025 at 20:06, Tobias Waldekranz <tobias@waldekranz.com=
> wrote:
>> >>
>> >> On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro=
.org> wrote:
>> >> > On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.=
com> wrote:
>> >> >>
>> >> >> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@lin=
aro.org> wrote:
>> >> >> > Add information about the type of blkmap device in the blkmap
>> >> >> > structure. Currently, the blkmap device is used for mapping to e=
ither
>> >> >> > a memory based block device, or another block device (linear
>> >> >> > mapping). Put information in the blkmap structure to identify if=
 it is
>> >> >> > associated with a memory or linear mapped device. Which can then=
 be
>> >> >> > used to take specific action based on the type of blkmap device.
>> >> >>
>> >> >> Is this restriction really necessary? Why should it not be possibl=
e to
>> >> >> setup a block map like this:
>> >> >>
>> >> >>  myblkmap:
>> >> >> .--------.      .-----.
>> >> >> | slice0 +------> RAM |
>> >> >> :--------:      '-----'     .-------.
>> >> >> | slice1 +------------------> eMMC0 |
>> >> >> :--------:      .-------.   '-------'
>> >> >> | slice2 +------> eMMC1 |
>> >> >> '........'      '-------'
>> >> >>
>> >> >> Linux's "device mapper", after which blkmaps are modeled, works in=
 this
>> >> >> way.  I.e. a blkmap is just a collection of slices, and it is up t=
o each
>> >> >> slice how its data is provided, meaning that the user is free to c=
ompose
>> >> >> their virtual block device in whatever way they need.
>> >> >
>> >> > The blkmap structure, the way it is designed, is pointing to the
>> >> > underlying block device. How can a single blkmap then be associated
>> >>
>> >> The `struct udevice *blk` from `struct blkmap` is a reference to the
>> >> block device which represents the block map itself ("myblkmap" in the
>> >> picture above), not any lower device.
>> >
>> > Okay. I got confused with the comment associated with that member,
>> > which says, "Underlying block device". This I interpreted to be the
>> > block device that is associated with the blkmap structure.
>>
>> Yeah I agree that it could be made clearer :)
>>
>> >>
>> >> > with slices of different types? Would that not contravene with the
>> >> > idea of a block device associating with a blkmap?
>> >>
>> >> For slices which are linear mappings (and are thus backed by some oth=
er
>> >> underlying block device), their reference to that lower device ("eMMC=
0"
>> >> and "eMMC1" above) is stored in the `struct udevice *blk` member of
>> >> `struct blkmap_linear`.
>> >
>> > Okay. But then, the computation of the blocksize seems to be happening
>> > at the blkmap device level, which again implies having the same set of
>> > slices associated with the blkmap. Any reason why the blksize is not
>> > taken from the block device associated with that slice? That would
>> > make it clear that the slice mapping type is independent from the
>> > parent blkmap device.
>>
>> In the original series, only linear mappings to devices which used block
>> sizes of 512 was supported, precisely because otherwise you need to do
>> proper translation to work in all cases.
>>
>> I tried to argue this point on the list back then:
>> https://lore.kernel.org/u-boot/875y3wohrt.fsf@waldekranz.com/
>> but I did not get my point across and the restriction was lifted anyway.
>>
>> >>
>> >> Slices which are backed by memory does not have any reference to a lo=
wer
>> >> device, but merely a pointer to the start of the mapping - `void *add=
r`
>> >> in `struct blkmap_mem`.
>> >>
>> >> The overarching idea is that the block map does not have to know
>> >> anything about the implementation of how any individual slice chooses=
 to
>> >> provide its data.  It only knows about their sizes and offsets.  Based
>> >> on that information, it simply routes incoming read/write requests to
>> >> the correct slice.
>> >
>> > Okay. I think, for my solution, I will just need to move type
>> > identification to the slice, instead of the blkmap device.
>> >
>> >>
>> >> >>
>> >> >> Looking at the pmem patch that follows this one, I am not able to =
find
>> >> >> anything that would motivate restricting the functionality either.
>> >> >
>> >> > The subsequent patch is adding the persistent memory node to the
>> >> > device-tree. The pmem node that is to be added is the memory mapped
>> >> > blkmap device. The logic does check for the type of the blkmap devi=
ce
>> >> > and then proceeds to add the pmem node only for the memory mapped
>> >> > blkmaps.
>> >>
>> >> Sorry I am confused.  Why do you need a block map device to add the p=
mem
>> >> node to the device tree?
>> >
>> > This is needed to include the RAM based block device information in
>> > the device-tree as pmem node. The OS installer then uses this pmem
>> > device as the block device which contains the installation packages,
>> > and proceeds with the OS installation.
>>
>> But even if the user has not setup a blkmap, don't you want to inject
>> the pmem node in the DT anyway?  All you need is the size and offset of
>> the blob right?  Is that not available from `image_setup_libfdt()`?
>
> Not sure if I am getting your point. The image_setup_libfdt() function
> is fixing up the devicetree before it gets passed on to the OS. In my
> subsequent patch, the image_setup_libfdt() is calling the blkmap
> helper function (added in that patch) to check for any memory mapped
> blkmap devices, and add corresponding pmem nodes for those. The
> current case where this is happening in U-Boot is as part of
> EFI_HTTP_BOOT, where if an ISO or an img file has been obtained over
> the network, it gets mounted as a blkmap device, and that gets
> notified to the OS. So, if this happens to be an install image, the
> kernel knows about it through the pmem node in the DT.

Alright, but then it seems like the implementation of EFI_HTTP_BOOT is
the one with enough context to known when to add the pmem node, no?
Could it not use the event subsystem to register a fixup?  I.e. when it
creates the block map, it also ought to know that the image must be
protected.  I imagine something like (pseudo code, but you get the
idea):

+struct efi_pmem {
+    void *base;
+    size_t size;
+}
+
+efi_add_pmem(void *_pmem, struct event *event)
+{
+    const struct event_ft_fixup *fixup =3D &event->data.ft_fixup;
+    struct efi_pmem pmem =3D _pmem;
+
+    fdt_fixup_pmem_region(fixup->tree, pmem->addr, pmem->size);
+    free(pmem);
+}

 efi_http_boot()
 {
     ...
     bm =3D blkmap_ramdisk_create(imgbase, imgsize);
+    if (needs_protection) {
+        struct efi_pmem *pmem =3D xmalloc(sizeof(*pmem));
+        pmem->base =3D imgbase;
+        pmem->size =3D imgsize;
+        event_register("efi_add_pmem", EVT_FT_FIXUP, efi_add_pmem, pmem);
+    }
    ...
 }


> If you are referring to a scenario where the memory based block device
> does not get set up as a blkmap device, that will anyways require
> explicit intervention of the user to add the pmem node, because
> otherwise there is no way to find out existence of such a device. This
> can then be done through an explicit command. But the EFI_HTTP_BOOT
> use-case does require scanning for the memory base blkmap devices.

With the approach above, I think we could get out of marking every
configured blkmap as reserved (which might not be what the user wants),
and instead let the creator of the device decide on whether this is
needed or not.
