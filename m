Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF2C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1981B86423;
	Mon, 28 Aug 2023 23:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5wmYrXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C128645F; Mon, 28 Aug 2023 23:02:15 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B53586403
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b962535808so56434401fa.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693256531; x=1693861331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCyZdPKHSgQ03MN6yx+eo+P5zLX2badd9NLFSTPa4FY=;
 b=S5wmYrXy9UVGkK/8JB+tDacpJcllC0jQXo+3/9V9XxwECipguSUPmi8+ONK8YEnP10
 Y9GQZdBU+to6Rzoh/ayQUKsaElxcRE3onuiZi8gdENMBWuKebys8BMu5UmdMmlFCa9rt
 8bkiYRylDYmWtptSEkRwTQp1Du2UCnXzduxymEixFgCrlueG+s/YeVX01tG9u8oje95W
 i/+QMzhVMBLdaxvhVJzL+KHEe9FilfcUtTY01b/k2ZcmPZWbMPjRKIquBczli89ooy/i
 TJpgfM17TMIgLhrOvMTa0a40KtjvXF8C5CH2vDCkoqQcCbLQ8rvnko28mZhJXTjQtfKw
 HgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693256531; x=1693861331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCyZdPKHSgQ03MN6yx+eo+P5zLX2badd9NLFSTPa4FY=;
 b=l6UvLaIwUWyC6iaC1fffCCuwkALc3zJFnNO1uD635XrBWr+wROVd5CSOEAaPGyXt8e
 eVnPBIKKxTgmkyLgGeMP1tygN4/0C1Wz8WXoxbj8uF6NoRvg6lTe7bLaOOneCXzuRZUl
 QRpFLAbmfvDOgVpCcVt3po9L1acG9nKM0Xc/a+6kY1TROlJ8VjKxzjRjiIO1OzhG/GQq
 XpwP9NuiXeCsM0QzEqs4gfTIsgUeu8Lqb1j/Yq1ID7vYdR1+aisqyRgaXfVnNuuYOoUe
 Pm5dEVyx6KBXlyZCiLnLaKkD/CjG625XkYXFz3q+LFkz3b1ck1M/yWBDP/5PQ2P9emIL
 cTuw==
X-Gm-Message-State: AOJu0YxW7xtNutUO+ntXl2kKMtosVPVupojWlCnRA/BZeb6o6O9btU4i
 Cs9PB9ltI1qdqVijmdKbSd0XslS8FXrm/aIjPM4=
X-Google-Smtp-Source: AGHT+IFKZ6mzDLiX0UOW35KO1gcMyi4cO1gKW9KLxXvhoxRpQ/eH0TMXUmBJ95V57eefCKnIhnptrs1ZPNPmCCuuYxM=
X-Received: by 2002:a2e:3c13:0:b0:2bc:d582:e724 with SMTP id
 j19-20020a2e3c13000000b002bcd582e724mr14333580lja.31.1693256531214; Mon, 28
 Aug 2023 14:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
 <c8def079-428f-86fe-68a6-f296d1df776f@gmx.de>
 <CAJdd5GaiDQ6erN4T16HzV3q8Kr+vMs9rWWCTaCr6axWfhxvqUg@mail.gmail.com>
 <55c0a798-77d2-4172-b30e-1ab04aa25e1a@gmx.de>
In-Reply-To: <55c0a798-77d2-4172-b30e-1ab04aa25e1a@gmx.de>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 28 Aug 2023 15:01:58 -0600
Message-ID: <CAJdd5GbnFzvam+SuUXsMRpX=Ga8rdfBSsEL8T6FL_83EqGUP8A@mail.gmail.com>
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

On Mon, Aug 28, 2023 at 2:00=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 8/28/23 21:29, Joshua Watt wrote:
> > On Fri, Aug 25, 2023 at 7:57=E2=80=AFPM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> On 8/25/23 21:38, Joshua Watt wrote:
> >>> Adds initial documentation for the gpt command
> >>
> >> Thanks a lot for filling the gap.
> >>
> >>>
> >>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> >>> ---
> >>>    doc/usage/cmd/gpt.rst | 141 ++++++++++++++++++++++++++++++++++++++=
++++
> >>>    doc/usage/index.rst   |   1 +
> >>>    2 files changed, 142 insertions(+)
> >>>    create mode 100644 doc/usage/cmd/gpt.rst
> >>>
> >>> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> >>> new file mode 100644
> >>> index 0000000000..f6e082fb94
> >>> --- /dev/null
> >>> +++ b/doc/usage/cmd/gpt.rst
> >>> @@ -0,0 +1,141 @@
> >>> +.. SPDX-License-Identifier: GPL-2.0+
> >>> +
> >>> +gpt command
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +Synopsis
> >>> +--------
> >>> +
> >>> +::
> >>> +
> >>> +    gpt repair <interface> <device no>
> >>> +    gpt write <interface> <device no> <partition string>
> >>> +    gpt verify <interface> <device no> <partition string>
> >>
> >> <partition string> is not required. Please, add brackets [].
> >
> > It's not optional; there is no standardized string for the list of GPT
> > partitions like there is for MBR
>
> You can use the command without partition string. It will tell you if
> the device is partitioned or not.

Ah, right. I missed that

>
> >
> >>
> >>> +    gpt setenv <interface> <device no> <partition name>
> >>
> >> gpt setenv can be called without partition name which leads to a crash=
.
> >>
> >> If that parameter is meant to be optional, this should be indicated
> >> here. Otherwise an argc check is missing.
> >
> > I don't believe the argument is optional, but either way it can be
> > fixed in a subsequent patch series. I'd rather not hold up the
> > documentation to fix bugs
> >
> >>
> >>> +    gpt enumerate <interface> <device no>
> >>> +    gpt guid <interface> <device no> [<varname>]
> >>> +    gpt read <interface> <device no> [<varname>]
> >>> +    gpt swap <interface> <dev> <name1> <name2>
> >>> +    gpt rename <interface> <dev> <part> <name>
> >>
> >> Thanks a lot for providing a man-page for this command.
> >>
> >> If <device no> and <dev> both relate to the same object type, we shoul=
d
> >> use the same text. <dev> would be fine.
> >>
> >> The sequence looks random. Please, sort the sub-commands either
> >> logically or alphabetically.
> >
> > They are sorted to match the gpt command help text. Reordering of both
> > can be done later if desired.
>
> There is no requirement to follow the gpt help =3Dsequence here.
>
> We should not reproduce what is not helpful.
>
> Best regards
>
> Heinrich
>
> >
> >>
> >>> +
> >>> +Description
> >>> +-----------
> >>> +
> >>> +The gpt command lets users read, create, modify, or verify the GPT (=
GUID
> >>> +Partition Table) partition layout.
> >>> +
> >>> +The syntax of the text description of the partition list is similar =
to
> >>> +the one used by the 'mbr' command. The string contains one or more p=
artition
> >>
> >> Please, link the mbr page:
> >>
> >> by the :doc:`mbr command <mbr>`.
> >>
> >>> +descriptors, each separated by a ";". Each descriptor contains one o=
r more
> >>> +fields, with each field separated by a ",". Fields are either of the=
 form
> >>> +"key=3Dvalue" to set a specific value, or simple "flag" to set a boo=
lean flag
> >>
> >> At this point it remains unclear to the reader what this ;-separated
> >> string format relates to.
> >> Is it an output format?
> >> Is it a format used in variables?
> >> Is it used for the parameter 'partition string'?
> >>
> >> Maybe describe it after the parameters and relate it to the 'partition
> >> string' parameter.
> >>
> >> Please, describe all parameters (in this indented format):
> >>
> >> interface
> >>       interface for accessing the block device (mmc, sata, scsi, usb, =
....)
> >>
> >> device no
> >>       device number
> >>
> >> ...
> >>
> >>> +
> >>> +The first descriptor can optionally be used to describe parameters f=
or the
> >>> +whole disk with the following fields:
> >>> +
> >>> +* uuid_disk=3DUUID - Set the UUID for the disk
> >>> +
> >>> +Partition descriptors can have the following fields:
> >>> +* name=3DNAME - The partition name, required
> >>
> >> Maybe better
> >>
> >> name=3D<NAME>
> >>
> >> This is not rendered as an unordered list but everything is in one lin=
e.
> >> Please, add the missing blank lines.
> >>
> >> Please, generate the HTML documentation as described in
> >> https://u-boot.readthedocs.io/en/latest/build/documentation.html
> >> and check the output before resubmitting.
> >>
> >>> +* start=3DBYTES - The partition start offset in bytes, required
> >>> +* size=3DBYTES - The partition size, in bytes or "-" to expand it to=
 the whole free area
> >>> +* bootable - Set the legacy bootable flag
> >>> +* uuid=3DUUID - Set the partition UUID, optional if CONFIG_RANDOM_UU=
ID=3Dy is enabled
> >>> +* type=3DUUID - Set the partition type GUID, requires CONFIG_PARTITI=
ON_TYPE_GUID=3Dy
> >>> +
> >>
> >> The following should be in a separate 'Examples' section to match the
> >> other man-pages.
> >>
> >>> +Here is an example how to create a 6 partitions, some of the predefi=
ned sizes:
> >>> +
> >>> +::
> >>> +
> >>> +    =3D> setenv gpt_parts 'uuid_disk=3Dbec9fc2a-86c1-483d-8a0e-01097=
32277d7;
> >>> +        name=3Dboot,start=3D4M,size=3D128M,bootable,type=3Debd0a0a2-=
b9e5-4433-87c0-68b6b72699c7,
> >>> +        name=3Drootfs,size=3D3072M,type=3D0fc63daf-8483-4772-8e79-3d=
69d8477de4;
> >>> +        name=3Dsystem-data,size=3D512M,type=3D0fc63daf-8483-4772-8e7=
9-3d69d8477de4;
> >>> +        name=3D[ext],size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d84=
77de4;
> >>> +        name=3Duser,size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d847=
7de4;
> >>> +        name=3Dmodules,size=3D100M,type=3D0fc63daf-8483-4772-8e79-3d=
69d8477de4;
> >>> +        name=3Dramdisk,size=3D8M,type=3D0fc63daf-8483-4772-8e79-3d69=
d8477de4
> >>> +    =3D> gpt write mmc 0 $gpt_parts
> >>> +
> >>> +
> >>> +If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a ran=
dom UUID
> >>> +will be generated for the partition
> >>> +
> >>> +The 'gpt verify' command returns 0 if the layout matches the one on =
the storage
> >>> +device or 1 if not. To check if the layout on the MMC #0 storage dev=
ice
> >>> +matches the provided text description one has to issue following com=
mand:
> >>
> >> The command can be used with and without partition parameter. This
> >> should be described here.
> >>
> >> I would prefer:
> >>
> >> sets the return value $? to 0 (true) if the layout
> >> or 1 (false) if not
> >>
> >>> +
> >>> +::
> >>> +
> >>> +    =3D> gpt verify mmc 0 $gpt_parts
> >>> +
> >>> +The verify sub-command is especially useful in the system update scr=
ipts:
> >>> +
> >>> +::
> >>> +
> >>> +    =3D> if gpt verify mmc 0 $gpt_parts; then
> >>> +         echo GPT layout needs to be updated
> >>> +         ...
> >>> +       fi
> >>> +
> >>> +The 'gpt write' command returns 0 on success write or 1 on failure.
> >>> +
> >>> +The 'gpt setenv' command will set a series of environment variables =
with
> >>> +information about a particular partition. The variables are:
> >>> +
> >>> +* gpt_partition_addr (the starting offset of the partition, in hexad=
ecimal blocks)
> >>> +* gpt_partition_size (the size of the partition, in hexadecimal bloc=
ks)
> >>
> >> The blocks that are not hexadecimal, the numbers are.
> >>
> >> gpt_partition_addr (first block of the partition as hexadecimal number=
)
> >> gpt_partition_size (number of blocks as hexadecimal number)
> >>
> >>> +* gpt_partition_name (the name of the partition)
> >>> +* gpt_partition_entry (the partition number in the table, e.g. 1, 2,=
 3, etc.)
> >>
> >> This value is currently decimal but this seems to be a bug. We need a
> >> hexadecimal number to use this variable in a command like
> >>
> >>       load host 0:$gpt_partition_entry $loadaddr filename
> >>
> >> Another bug is that this command assumes that partitions are
> >> continuously numbered.
> >>
> >>> +
> >>> +To get the information about the partition named 'rootfs', issue the=
 following
> >>> +command:
> >>> +
> >>> +::
> >>> +    =3D> gpt setenv mmc 0 rootfs
> >>> +    =3D> echo ${gpt_partition_addr}
> >>> +    2000
> >>> +    =3D> echo ${gpt_partition_size}
> >>> +    14a000
> >>> +    =3D> echo ${gpt_partition_name}
> >>> +    rootfs
> >>> +    =3D> echo ${gpt_partition_entry}
> >>> +    2
> >>> +
> >>> +The 'gpt enumerate' command will set the variable 'gpt_partition_lis=
t' with the
> >>> +list of partition names on the device. For example:
> >>> +
> >>> +::
> >>> +    =3D> gpt enumerate
> >>> +    =3D> echo gpt_partition_list
> >>> +    boot rootfs system-data [ext] user modules ramdisk
> >>
> >> As we cannot see from the output if there is a partition 'user' and a
> >> partition 'modules' or only a single partition 'user modules' this
> >> sub-command seems to need some rework.
> >
> > Can be fixed later.
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> +
> >>> +The 'gpt guid' command will report the GUID of a disk. If 'varname' =
is
> >>> +specified, the command will set the variable to the GUID, otherwise =
it will be
> >>> +printed out. For example:
> >>> +
> >>> +::
> >>> +    =3D> gpt guid mmc 0
> >>> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> >>> +    =3D> gpt guid mmc gpt_disk_uuid
> >>> +    =3D> echo ${gpt_disk_uuid}
> >>> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> >>> +
> >>> +The 'gpt read' command will print out the current state of the GPT p=
artition
> >>> +table. If 'varname' is specified, the variable will be filled with a=
 partition
> >>> +string as described above that is suitable for passing to other 'gpt=
' commands.
> >>> +If omitted, a human readable description is printed out.
> >>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> >>> +
> >>> +The 'gpt swap' command changes the names of all partitions that are =
named
> >>> +'name1' to be 'name2', and all partitions named 'name2' to be 'name1=
'.
> >>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> >>> +
> >>> +The 'gpt rename' command renames all partitions named 'part' to be '=
name1'.
> >>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> >>> +
> >>> +Configuration
> >>> +-------------
> >>> +
> >>> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To ena=
ble 'gpt
> >>> +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_=
RENAME=3Dy.
> >>> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> >>> index 3326ec82ff..4bfaabbd16 100644
> >>> --- a/doc/usage/index.rst
> >>> +++ b/doc/usage/index.rst
> >>> @@ -65,6 +65,7 @@ Shell commands
> >>>       cmd/for
> >>>       cmd/fwu_mdata
> >>>       cmd/gpio
> >>> +   cmd/gpt
> >>>       cmd/host
> >>>       cmd/imxtract
> >>>       cmd/load
> >>
>
