Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A56E7E637
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D5986CBC;
	Tue, 26 Sep 2023 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnIrmuxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E9286B93; Tue, 26 Sep 2023 16:11:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E3986D90
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso1495160a12.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695737491; x=1696342291; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FllAq6xerH8N17+hgJuMEbpVOEn5MFpwP7sclAC39Ms=;
 b=lnIrmuxZIJ6dJjYk1V0LRl/gWrDx2RcQ2T/Y6IJ0MoWw/Qa4EORV/aFVpFSIKeI0O7
 UOO3ZOqVCujY0QvNF2zE0W7fjJfkFJV0Wsx2ttHgy6YAABzHKoCP4TTFXp1eNWwhyBTx
 ZpupGvg6aSAb97+ozUFs7wR/2ivLZHE6t2jZE61K6tdcMhAKwFuTOTcFTj9MEyr3umoG
 WDSIFEzn3Kx0WAVzsruwC11nQ7VZzNDDo9dp8w7iLb3vV4V9jvfS+qTjEZ8BdoT1f7No
 tuNUyYx+fsqnK2IVVGrZjbkw2Cac/M8W8rAwuYFm8/VRR2+JZYqsO/5/Y4zNmFQ9UeB4
 x/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737491; x=1696342291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FllAq6xerH8N17+hgJuMEbpVOEn5MFpwP7sclAC39Ms=;
 b=lzDmS65QHNSgeGighW6hKnhedyaqQKgpPzOH0pNXWHJpB6dYbwom279l/gcnwCBZl0
 TC9edtIK9fNfSi/0yQ/FUaCAiMSY21jNbbB/M692ba78WX+rpvssCXiKhyx3cvRYR+M6
 GhiWSJBIlzpMJ0FGPA0rfikGN8CGDbAo8TvI35DICYhEDLcZjhUyeFHbKS/1/KMepV5j
 C0Dg9Kp4DPWzI9z3P8crfhIm9cMhIkM4VpNcECoeC68AEQzxjpT1UeM6blvwWa5PYwFI
 H40dwp8+v6cJpHvND0WTiULoY9Xt62pv3W1X/Fw8vaA+yBh4PKX0o3HMEhED14AFV3wJ
 ljzg==
X-Gm-Message-State: AOJu0YyBQLrIayYcOBMfNT4kpg+dI0Ewmn6Lx/W/Bdd6pSb3Wh0gOQnc
 uE8L7bRkro8om2yqc/Kyw8f9GMolh8ukb9IT320=
X-Google-Smtp-Source: AGHT+IF8hSdDAc0bjVLbMA6bRASuCMRnvXq8bKpxMJaDkukdmLpdkKrOZD0Y3Cj973PMHjCAKxLETxByjCRRqvC+i1A=
X-Received: by 2002:aa7:d0c2:0:b0:51d:f5bd:5a88 with SMTP id
 u2-20020aa7d0c2000000b0051df5bd5a88mr9807284edo.38.1695737491366; Tue, 26 Sep
 2023 07:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <2487902a-1b98-42be-9d7c-16c98fd56815@gmx.de>
In-Reply-To: <2487902a-1b98-42be-9d7c-16c98fd56815@gmx.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 26 Sep 2023 22:11:19 +0800
Message-ID: <CAEUhbmWGQ9F5XineJa-gM1yof0bf2rGZBgX+7=1R4s5=BCQ+3g@mail.gmail.com>
Subject: Re: [PATCH 00/15] blk: sandbox: Support binding a device with a given
 logical block size
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, 
 Peng Fan <peng.fan@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, Sep 26, 2023 at 4:58=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 9/26/23 10:43, Bin Meng wrote:
> > At present on Sandbox when binding to a host backing file, the host
> > block device is created with a hard-coded 512 bytes block size.
> >
> > Such assumption works for most cases, but for situation that with a raw
> > image file dump from a pre-formatted GPT partitioned disk image from a
> > 4KiB block size device, when binding this file to a host device and map=
ping
> > this device to a blkmap, "blkmap" command like "blkmap part" won't work
> > correctly, due to block size mismatch during parsing the partition tabl=
e.
> >
> > This series updates Sandbox block driver, as well as the blkmap driver,
> > to get rid of the hard-coded 512 bytes block size assumption.
> >
> > This series is available at u-boot-x86/blk for testing.
>
> It is really good to have an easy way to test other block sizes.
>
> We can also use QEMU for alternative block sizes:
>
> $ qemu-system-riscv64 -device nvme,help
> logical_block_size=3D<size>
> physical_block_size=3D<size>

Yeah, please report any issue you find.

>
> In the commit messages, please, make it clear that you refer to logical
> block sizes and not to the physical block size.

For drivers we rarely care about physical_block_size as they always
operate on LBA. But I can write it down clearly that logical block
size is used.

Regards,
Bin
