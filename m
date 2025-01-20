Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B7C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 14:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC93080077;
	Mon, 20 Jan 2025 15:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OzDjYY6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C2A800C2; Mon, 20 Jan 2025 15:36:22 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11DCE80017
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 15:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso5015987e87.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 06:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1737383779; x=1737988579;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tAmBa1F2ZvYDGAc+H35KzH6GMMuuyjmdsp5VHUuK8Ew=;
 b=OzDjYY6BhS4uU8n6Ln98a1z8joHMe0uR17elHENpB6ucWULnX5EgpZX0vgPKW5/vZF
 04KAWz7zF+l7Jb2KVdnFmqOHtUbfAwV7mfw86D611g5mlJJ4tN2pHayNGMukqBK7TO18
 oELe/HB2ZQQLPFqKkIezU3Mk+xGkoVdRmTCtTYqxyrrkV898X6DZVXR/vbrHYZgE04Un
 f0C6XjSAMagcpB+D4oTM1iEyTEGhf4s0uw3CQ0u/jNSySiGUXnNZtDsL2bghE5hY+YnE
 /aSqLxp8LtDNV8zy7hnwVBQhmjrGUR8fctnfmFENLaXqKdvLKoZQTa0T3/OhMvWg+VgM
 xDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737383779; x=1737988579;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAmBa1F2ZvYDGAc+H35KzH6GMMuuyjmdsp5VHUuK8Ew=;
 b=uao6LyDahdXnUdtm6jxBRKzQAf97jAyrOyj7c8DyTW0qRxM07ZoCyMqEHTKdlQSdov
 KLunYo1T0nUg8EdW6dzVeoSZNWg5oS/xMeiceH+FsySvsxlDaFZ7Fmsj4MjPocSMG3X4
 vPAd9xUxdc6TOj2o2Zo3UWtB6ek4xMe7gkEa+lOPPc54n68Y9dmKJPi4HTRMfKYNaA+J
 20er/nBUrnbE1vJK2pnDz3UtxxEZoXPNS7I4THJv2ZoxAA5jtGr43I+PfsLXhQqGUz6U
 mRaSHoM8+GqGP0k0vVpOArnUSyTNw6bZ0liL7Wn9uKBRJjzzroXlvBDfQ32m3FFv3wuU
 pHrg==
X-Gm-Message-State: AOJu0YwqGLmehSf+AKYBAeEqdGkujJhxRXhSscV64lzNmoW91PNVhcUx
 K5GjF53ZKP4Kq+gZcuzM5KCel19y+wnitKyxLSxXtShwjQGzojg7IT+TFLI03vk=
X-Gm-Gg: ASbGncvcMCsgxI0lqOOtAEUt3ufwyB6VjkCzV0E7qZ/eab3/j93iNpZspZKdFSH2Pc2
 kAIUI9vdOL96PZV2nNm00X65s3xh+zKGmK9lZlS+N15YsKJWMOx3cpxCibpWGzLZc2KsDH0rCkc
 JdzqIkColSgGLxIfeGesYxoXB/uNQX8Vs8RHRZUHEx9ob3jVjU9zzPazO3hBgb+ZwVxcWTjqg5D
 bOxHRwn5AU/YbHfpYeFl/dedIamQxKy6defHmzbVpfh65MKoKr2jd4xbzQ9LfQCL61Ce2CPlqNN
 353QnQXtHPxu5m3SAjGzpAwb
X-Google-Smtp-Source: AGHT+IHbxCtuDsmKtPxeXRROxbdbCTDNB3nM6h7NLAy/ZW1Qf2yPpxs/pbfjTnQ/lem2RT3UM4nU1g==
X-Received: by 2002:ac2:5dce:0:b0:543:9a5c:1914 with SMTP id
 2adb3069b0e04-5439c22d87amr3955722e87.4.1737383779118; 
 Mon, 20 Jan 2025 06:36:19 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5439af790cbsm1341695e87.250.2025.01.20.06.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 06:36:17 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, Bin
 Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
In-Reply-To: <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
Date: Mon, 20 Jan 2025 15:36:15 +0100
Message-ID: <874j1t7dsw.fsf@waldekranz.com>
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

On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.com> w=
rote:
>>
>> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>> > Add information about the type of blkmap device in the blkmap
>> > structure. Currently, the blkmap device is used for mapping to either
>> > a memory based block device, or another block device (linear
>> > mapping). Put information in the blkmap structure to identify if it is
>> > associated with a memory or linear mapped device. Which can then be
>> > used to take specific action based on the type of blkmap device.
>>
>> Is this restriction really necessary? Why should it not be possible to
>> setup a block map like this:
>>
>>  myblkmap:
>> .--------.      .-----.
>> | slice0 +------> RAM |
>> :--------:      '-----'     .-------.
>> | slice1 +------------------> eMMC0 |
>> :--------:      .-------.   '-------'
>> | slice2 +------> eMMC1 |
>> '........'      '-------'
>>
>> Linux's "device mapper", after which blkmaps are modeled, works in this
>> way.  I.e. a blkmap is just a collection of slices, and it is up to each
>> slice how its data is provided, meaning that the user is free to compose
>> their virtual block device in whatever way they need.
>
> The blkmap structure, the way it is designed, is pointing to the
> underlying block device. How can a single blkmap then be associated

The `struct udevice *blk` from `struct blkmap` is a reference to the
block device which represents the block map itself ("myblkmap" in the
picture above), not any lower device.

> with slices of different types? Would that not contravene with the
> idea of a block device associating with a blkmap?

For slices which are linear mappings (and are thus backed by some other
underlying block device), their reference to that lower device ("eMMC0"
and "eMMC1" above) is stored in the `struct udevice *blk` member of
`struct blkmap_linear`.

Slices which are backed by memory does not have any reference to a lower
device, but merely a pointer to the start of the mapping - `void *addr`
in `struct blkmap_mem`.

The overarching idea is that the block map does not have to know
anything about the implementation of how any individual slice chooses to
provide its data.  It only knows about their sizes and offsets.  Based
on that information, it simply routes incoming read/write requests to
the correct slice.

>>
>> Looking at the pmem patch that follows this one, I am not able to find
>> anything that would motivate restricting the functionality either.
>
> The subsequent patch is adding the persistent memory node to the
> device-tree. The pmem node that is to be added is the memory mapped
> blkmap device. The logic does check for the type of the blkmap device
> and then proceeds to add the pmem node only for the memory mapped
> blkmaps.

Sorry I am confused.  Why do you need a block map device to add the pmem
node to the device tree?
