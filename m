Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B315C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E127D86459;
	Mon, 28 Aug 2023 21:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mTMlKCci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E59F8647D; Mon, 28 Aug 2023 21:29:36 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A4986456
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 21:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bcda0aaf47so52327221fa.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693250972; x=1693855772; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bczUXi3zrG9l0drddK6QhfAK1L6qdWzpGGQ1WRiTeOg=;
 b=mTMlKCci3525qt50uFPUX4xMX8G+PFZcTTX+bpQ9Tl+vcaMZIRCtEvo4lNuGFFs2Q6
 gr1O3nNL1zAfYlqeAV19fp8Jk+Wk1+Com/zBvMisHTC4OyoScrCRDeAOueBx0GkSB4rP
 zBhbTHFT7AvdpF6kJyi16X5jCig2UxmbzQo9TryUINSQ6N0XC1JJd87sMHZsoSJovidA
 beD1usbI9ChPFwVCltbMXYyBmn5I/1FlQOuJVvUJ/oTLgmyg0kFCLjBneHraJjk5TEUr
 +uSh+FjYQVFN1oAOalGEnlcowf6Ni83A2v27i/8nFCnLH2S1e2puOgbzrE7IOYZJ6kBn
 wLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693250972; x=1693855772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bczUXi3zrG9l0drddK6QhfAK1L6qdWzpGGQ1WRiTeOg=;
 b=HP0H63bgfPGxzHs3gAxQ/MrHbAstLvN3/uWJaJYYfy1miZ+izrCM1RAn6meoF6a/ZJ
 uSFtUWp+5XJkKGzAOdk/NC73MdfA3cHZJ/WwAjd1ZXHkY6LdSlkgpU0q+/UYHa56fihl
 W5SMm5zsRG1aUpMWs08wTlG8AdeYx3/m3mo9fP779V3UY2+yZeFdiLmQFbHWd/yHb2ow
 nnz68zRshliXJgMoup6/BCfGT/Owoym28jYMYe44XOF+gk/YYz2HFA6ypcZ18goUNTQU
 3mMX9cJHcJOwCWAiro9cv0aTrnNtP0AFyZ9ToWSKZYZQkI4wqk3Jfw/6sKosDIrRnVpd
 bnZA==
X-Gm-Message-State: AOJu0YwctPhr4Dd5RT4zbAUVZnFjGXq8GnDTmeN7uGIepxOHoZY3gOgM
 8Ho4LC3CgHXQZHgt9oOXXxhldkp3cy29XMWJzH8=
X-Google-Smtp-Source: AGHT+IEJFs2wzjQQO7aQFIdM/8tmdvkPJe2qZxb+GC7QAKr2/0Xn6EeeADlIvnPaX1veFFBitBDpRGghLnbLLAyC0zU=
X-Received: by 2002:a2e:a26e:0:b0:2bc:b63c:e823 with SMTP id
 k14-20020a2ea26e000000b002bcb63ce823mr206700ljm.22.1693250972228; Mon, 28 Aug
 2023 12:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
 <c8def079-428f-86fe-68a6-f296d1df776f@gmx.de>
In-Reply-To: <c8def079-428f-86fe-68a6-f296d1df776f@gmx.de>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 28 Aug 2023 13:29:19 -0600
Message-ID: <CAJdd5GaiDQ6erN4T16HzV3q8Kr+vMs9rWWCTaCr6axWfhxvqUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] doc: Add gpt command documentation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, Aug 25, 2023 at 7:57=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 8/25/23 21:38, Joshua Watt wrote:
> > Adds initial documentation for the gpt command
>
> Thanks a lot for filling the gap.
>
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   doc/usage/cmd/gpt.rst | 141 +++++++++++++++++++++++++++++++++++++++++=
+
> >   doc/usage/index.rst   |   1 +
> >   2 files changed, 142 insertions(+)
> >   create mode 100644 doc/usage/cmd/gpt.rst
> >
> > diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> > new file mode 100644
> > index 0000000000..f6e082fb94
> > --- /dev/null
> > +++ b/doc/usage/cmd/gpt.rst
> > @@ -0,0 +1,141 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +gpt command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Synopsis
> > +--------
> > +
> > +::
> > +
> > +    gpt repair <interface> <device no>
> > +    gpt write <interface> <device no> <partition string>
> > +    gpt verify <interface> <device no> <partition string>
>
> <partition string> is not required. Please, add brackets [].

It's not optional; there is no standardized string for the list of GPT
partitions like there is for MBR

>
> > +    gpt setenv <interface> <device no> <partition name>
>
> gpt setenv can be called without partition name which leads to a crash.
>
> If that parameter is meant to be optional, this should be indicated
> here. Otherwise an argc check is missing.

I don't believe the argument is optional, but either way it can be
fixed in a subsequent patch series. I'd rather not hold up the
documentation to fix bugs

>
> > +    gpt enumerate <interface> <device no>
> > +    gpt guid <interface> <device no> [<varname>]
> > +    gpt read <interface> <device no> [<varname>]
> > +    gpt swap <interface> <dev> <name1> <name2>
> > +    gpt rename <interface> <dev> <part> <name>
>
> Thanks a lot for providing a man-page for this command.
>
> If <device no> and <dev> both relate to the same object type, we should
> use the same text. <dev> would be fine.
>
> The sequence looks random. Please, sort the sub-commands either
> logically or alphabetically.

They are sorted to match the gpt command help text. Reordering of both
can be done later if desired.

>
> > +
> > +Description
> > +-----------
> > +
> > +The gpt command lets users read, create, modify, or verify the GPT (GU=
ID
> > +Partition Table) partition layout.
> > +
> > +The syntax of the text description of the partition list is similar to
> > +the one used by the 'mbr' command. The string contains one or more par=
tition
>
> Please, link the mbr page:
>
> by the :doc:`mbr command <mbr>`.
>
> > +descriptors, each separated by a ";". Each descriptor contains one or =
more
> > +fields, with each field separated by a ",". Fields are either of the f=
orm
> > +"key=3Dvalue" to set a specific value, or simple "flag" to set a boole=
an flag
>
> At this point it remains unclear to the reader what this ;-separated
> string format relates to.
> Is it an output format?
> Is it a format used in variables?
> Is it used for the parameter 'partition string'?
>
> Maybe describe it after the parameters and relate it to the 'partition
> string' parameter.
>
> Please, describe all parameters (in this indented format):
>
> interface
>      interface for accessing the block device (mmc, sata, scsi, usb, ....=
)
>
> device no
>      device number
>
> ...
>
> > +
> > +The first descriptor can optionally be used to describe parameters for=
 the
> > +whole disk with the following fields:
> > +
> > +* uuid_disk=3DUUID - Set the UUID for the disk
> > +
> > +Partition descriptors can have the following fields:
> > +* name=3DNAME - The partition name, required
>
> Maybe better
>
> name=3D<NAME>
>
> This is not rendered as an unordered list but everything is in one line.
> Please, add the missing blank lines.
>
> Please, generate the HTML documentation as described in
> https://u-boot.readthedocs.io/en/latest/build/documentation.html
> and check the output before resubmitting.
>
> > +* start=3DBYTES - The partition start offset in bytes, required
> > +* size=3DBYTES - The partition size, in bytes or "-" to expand it to t=
he whole free area
> > +* bootable - Set the legacy bootable flag
> > +* uuid=3DUUID - Set the partition UUID, optional if CONFIG_RANDOM_UUID=
=3Dy is enabled
> > +* type=3DUUID - Set the partition type GUID, requires CONFIG_PARTITION=
_TYPE_GUID=3Dy
> > +
>
> The following should be in a separate 'Examples' section to match the
> other man-pages.
>
> > +Here is an example how to create a 6 partitions, some of the predefine=
d sizes:
> > +
> > +::
> > +
> > +    =3D> setenv gpt_parts 'uuid_disk=3Dbec9fc2a-86c1-483d-8a0e-0109732=
277d7;
> > +        name=3Dboot,start=3D4M,size=3D128M,bootable,type=3Debd0a0a2-b9=
e5-4433-87c0-68b6b72699c7,
> > +        name=3Drootfs,size=3D3072M,type=3D0fc63daf-8483-4772-8e79-3d69=
d8477de4;
> > +        name=3Dsystem-data,size=3D512M,type=3D0fc63daf-8483-4772-8e79-=
3d69d8477de4;
> > +        name=3D[ext],size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d8477=
de4;
> > +        name=3Duser,size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d8477d=
e4;
> > +        name=3Dmodules,size=3D100M,type=3D0fc63daf-8483-4772-8e79-3d69=
d8477de4;
> > +        name=3Dramdisk,size=3D8M,type=3D0fc63daf-8483-4772-8e79-3d69d8=
477de4
> > +    =3D> gpt write mmc 0 $gpt_parts
> > +
> > +
> > +If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a rando=
m UUID
> > +will be generated for the partition
> > +
> > +The 'gpt verify' command returns 0 if the layout matches the one on th=
e storage
> > +device or 1 if not. To check if the layout on the MMC #0 storage devic=
e
> > +matches the provided text description one has to issue following comma=
nd:
>
> The command can be used with and without partition parameter. This
> should be described here.
>
> I would prefer:
>
> sets the return value $? to 0 (true) if the layout
> or 1 (false) if not
>
> > +
> > +::
> > +
> > +    =3D> gpt verify mmc 0 $gpt_parts
> > +
> > +The verify sub-command is especially useful in the system update scrip=
ts:
> > +
> > +::
> > +
> > +    =3D> if gpt verify mmc 0 $gpt_parts; then
> > +         echo GPT layout needs to be updated
> > +         ...
> > +       fi
> > +
> > +The 'gpt write' command returns 0 on success write or 1 on failure.
> > +
> > +The 'gpt setenv' command will set a series of environment variables wi=
th
> > +information about a particular partition. The variables are:
> > +
> > +* gpt_partition_addr (the starting offset of the partition, in hexadec=
imal blocks)
> > +* gpt_partition_size (the size of the partition, in hexadecimal blocks=
)
>
> The blocks that are not hexadecimal, the numbers are.
>
> gpt_partition_addr (first block of the partition as hexadecimal number)
> gpt_partition_size (number of blocks as hexadecimal number)
>
> > +* gpt_partition_name (the name of the partition)
> > +* gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3=
, etc.)
>
> This value is currently decimal but this seems to be a bug. We need a
> hexadecimal number to use this variable in a command like
>
>      load host 0:$gpt_partition_entry $loadaddr filename
>
> Another bug is that this command assumes that partitions are
> continuously numbered.
>
> > +
> > +To get the information about the partition named 'rootfs', issue the f=
ollowing
> > +command:
> > +
> > +::
> > +    =3D> gpt setenv mmc 0 rootfs
> > +    =3D> echo ${gpt_partition_addr}
> > +    2000
> > +    =3D> echo ${gpt_partition_size}
> > +    14a000
> > +    =3D> echo ${gpt_partition_name}
> > +    rootfs
> > +    =3D> echo ${gpt_partition_entry}
> > +    2
> > +
> > +The 'gpt enumerate' command will set the variable 'gpt_partition_list'=
 with the
> > +list of partition names on the device. For example:
> > +
> > +::
> > +    =3D> gpt enumerate
> > +    =3D> echo gpt_partition_list
> > +    boot rootfs system-data [ext] user modules ramdisk
>
> As we cannot see from the output if there is a partition 'user' and a
> partition 'modules' or only a single partition 'user modules' this
> sub-command seems to need some rework.

Can be fixed later.

>
> Best regards
>
> Heinrich
>
> > +
> > +The 'gpt guid' command will report the GUID of a disk. If 'varname' is
> > +specified, the command will set the variable to the GUID, otherwise it=
 will be
> > +printed out. For example:
> > +
> > +::
> > +    =3D> gpt guid mmc 0
> > +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> > +    =3D> gpt guid mmc gpt_disk_uuid
> > +    =3D> echo ${gpt_disk_uuid}
> > +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> > +
> > +The 'gpt read' command will print out the current state of the GPT par=
tition
> > +table. If 'varname' is specified, the variable will be filled with a p=
artition
> > +string as described above that is suitable for passing to other 'gpt' =
commands.
> > +If omitted, a human readable description is printed out.
> > +CONFIG_CMD_GPT_RENAME=3Dy is required.
> > +
> > +The 'gpt swap' command changes the names of all partitions that are na=
med
> > +'name1' to be 'name2', and all partitions named 'name2' to be 'name1'.
> > +CONFIG_CMD_GPT_RENAME=3Dy is required.
> > +
> > +The 'gpt rename' command renames all partitions named 'part' to be 'na=
me1'.
> > +CONFIG_CMD_GPT_RENAME=3Dy is required.
> > +
> > +Configuration
> > +-------------
> > +
> > +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To enabl=
e 'gpt
> > +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_RE=
NAME=3Dy.
> > diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> > index 3326ec82ff..4bfaabbd16 100644
> > --- a/doc/usage/index.rst
> > +++ b/doc/usage/index.rst
> > @@ -65,6 +65,7 @@ Shell commands
> >      cmd/for
> >      cmd/fwu_mdata
> >      cmd/gpio
> > +   cmd/gpt
> >      cmd/host
> >      cmd/imxtract
> >      cmd/load
>
