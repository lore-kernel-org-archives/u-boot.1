Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A540C83F0C
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A879286AB1;
	Sat, 26 Aug 2023 03:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="USCuF/yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8C78642D; Sat, 26 Aug 2023 03:57:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFD586AF3
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693015028; x=1693619828; i=xypron.glpk@gmx.de;
 bh=juE87riC7VMhEQDHe/3F0GyDEirpOUYdEpMc/15Vjm8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=USCuF/yvaS2ixX8eLUO609KND41VBw4NfdRb+EPABCqeBDLpwB73C12cmvdiS7WUDj8b6e3
 AE867Fwso+NZJ3DMlk85K9OVIf6eKEX2z1njIFcK5u0IzwY01e/wHgJnnlHJNN0AoucwMK4Ai
 gFdcrgVMSF2IJaaJnIao250USLCPphn/f/+wBg6iP8kEdnTVXUfyr2x30priQa75ziljDTdGc
 PRLQ8MiOQCC90ctqTkZv7OVRUUAmpFGR3RvkyquntAac4GwQUUEZnDGR35UjsQMzQalfeVju/
 7If42d1HPu03CBanod8qyELnwqjD/O3tyDGtnf1A9N3VOtAYOmag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1qPI9G0Hes-00BgBE; Sat, 26
 Aug 2023 03:57:08 +0200
Message-ID: <c8def079-428f-86fe-68a6-f296d1df776f@gmx.de>
Date: Sat, 26 Aug 2023 03:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/8] doc: Add gpt command documentation
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230825193830.2753640-3-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XtkjTpa7vNKzUyWJYwh1E0MzOk28wt+XWwb90fEGYILWbuG36g
 aGcHHwkUdSH5Bd1CbbkmT6BgML6WGFgNFiG4/gEWpb/jM/LHU4ma2pErDXNtmWKkFodlhzb
 QC+sGe00FqlXI5KDSYzIyt/DHkAP64EmxCkxYBvxgGQFm9dQRlyYzln31bdVpDaFNTbhOjn
 nP33Zvf+7Pb3iNpIVAIWw==
UI-OutboundReport: notjunk:1;M01:P0:kTWtmjqM+oQ=;iqdQc/8GsavJhjwYGtxy1D9CHXu
 JQvaL+IxV8vXuSU2Su16s5rIX2ax+FiR23j/PgCkJXv5JZZdSb8Rkq6ktVk5kKvRy/sY4nai4
 rsvKxqIjfYUCxEijXWj0HHiJPEMlUF7Q23mUcw7Pv6dmC14Mre9Kbp/8eCanOwgi3Zx29f/Sp
 aGCQFC7MKIVbAi55J5AP70Xf9QY5KdDnWe4ew2MFZBdbtNA5uY6rQ003XkCj1519eYjxq/oC+
 2WfKRfBGWUAfegT35bsmpAz1wxluJ5ZxPaTyNxoxhEHbN3A7BU/6vLpRhv+dAlwM/FVZy2K6i
 hzCYcRoMFZtDRSh/qRZYVhryDpiL8ddhFSXv0aXCeTGz9DnS62FtS7mgeX+FzUHwp875nL7l8
 oW7jYUBIXzcIPoZ/A4I1LN3Hj3MnvjRbHX1VbEnW9OA7yphylRggftM5tQ2Gdwzt/nU6KI+dJ
 kKc0avrsXQIlxjZmLRzY7GpZYWFiLvj0fiAiBCuGRrxXLwwnCB5WUd5KnWeSRMC49W4dRnpqc
 gywhK9hjz5aS4BKChbbbV+YZEF434BWfH18WwbJiSDIznDfWMUAVrq3+2NZkuIKv15GwXraYn
 uGiRBfG6wsvF+oWgk/aYlhSFZ7TzaF3N8AKzsfRIT9cRYZ2V/yP3azayTQWktb29yOIeOgqIf
 d13ildOoSBAelOXjghfuvgsDCuz6ugcUy+AJ/6i0su95lfwHKG5yB/GrXl5B9ix/nLh/tz2jq
 3XdmNEZXdCqQPetWh/SZayuVDNqCqwhiTCiCuBw9eyKVxcDKHbFoBF9EeyHo9NwaP0VdnV4Oy
 wBSaoz9MadU/5xMaZA1TKr7r3O+adzOUrUIi8GLmRIfnqrHmUZNk1/QxvJrJ+wIRAH8BJ5oZy
 5R1IpFMItBPwutTtlciu7yPUOQF71IW4OzLovllYCQME58EM2T4c+Pj0FeXyGtcLMc6A3UwUm
 R4GjYEpteIQRu5H9p1w4TVCiekY=
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

On 8/25/23 21:38, Joshua Watt wrote:
> Adds initial documentation for the gpt command

Thanks a lot for filling the gap.

>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   doc/usage/cmd/gpt.rst | 141 ++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst   |   1 +
>   2 files changed, 142 insertions(+)
>   create mode 100644 doc/usage/cmd/gpt.rst
>
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> new file mode 100644
> index 0000000000..f6e082fb94
> --- /dev/null
> +++ b/doc/usage/cmd/gpt.rst
> @@ -0,0 +1,141 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +gpt command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    gpt repair <interface> <device no>
> +    gpt write <interface> <device no> <partition string>
> +    gpt verify <interface> <device no> <partition string>

<partition string> is not required. Please, add brackets [].

> +    gpt setenv <interface> <device no> <partition name>

gpt setenv can be called without partition name which leads to a crash.

If that parameter is meant to be optional, this should be indicated
here. Otherwise an argc check is missing.

> +    gpt enumerate <interface> <device no>
> +    gpt guid <interface> <device no> [<varname>]
> +    gpt read <interface> <device no> [<varname>]
> +    gpt swap <interface> <dev> <name1> <name2>
> +    gpt rename <interface> <dev> <part> <name>

Thanks a lot for providing a man-page for this command.

If <device no> and <dev> both relate to the same object type, we should
use the same text. <dev> would be fine.

The sequence looks random. Please, sort the sub-commands either
logically or alphabetically.

> +
> +Description
> +-----------
> +
> +The gpt command lets users read, create, modify, or verify the GPT (GUI=
D
> +Partition Table) partition layout.
> +
> +The syntax of the text description of the partition list is similar to
> +the one used by the 'mbr' command. The string contains one or more part=
ition

Please, link the mbr page:

by the :doc:`mbr command <mbr>`.

> +descriptors, each separated by a ";". Each descriptor contains one or m=
ore
> +fields, with each field separated by a ",". Fields are either of the fo=
rm
> +"key=3Dvalue" to set a specific value, or simple "flag" to set a boolea=
n flag

At this point it remains unclear to the reader what this ;-separated
string format relates to.
Is it an output format?
Is it a format used in variables?
Is it used for the parameter 'partition string'?

Maybe describe it after the parameters and relate it to the 'partition
string' parameter.

Please, describe all parameters (in this indented format):

interface
     interface for accessing the block device (mmc, sata, scsi, usb, ....)

device no
     device number

...

> +
> +The first descriptor can optionally be used to describe parameters for =
the
> +whole disk with the following fields:
> +
> +* uuid_disk=3DUUID - Set the UUID for the disk
> +
> +Partition descriptors can have the following fields:
> +* name=3DNAME - The partition name, required

Maybe better

name=3D<NAME>

This is not rendered as an unordered list but everything is in one line.
Please, add the missing blank lines.

Please, generate the HTML documentation as described in
https://u-boot.readthedocs.io/en/latest/build/documentation.html
and check the output before resubmitting.

> +* start=3DBYTES - The partition start offset in bytes, required
> +* size=3DBYTES - The partition size, in bytes or "-" to expand it to th=
e whole free area
> +* bootable - Set the legacy bootable flag
> +* uuid=3DUUID - Set the partition UUID, optional if CONFIG_RANDOM_UUID=
=3Dy is enabled
> +* type=3DUUID - Set the partition type GUID, requires CONFIG_PARTITION_=
TYPE_GUID=3Dy
> +

The following should be in a separate 'Examples' section to match the
other man-pages.

> +Here is an example how to create a 6 partitions, some of the predefined=
 sizes:
> +
> +::
> +
> +    =3D> setenv gpt_parts 'uuid_disk=3Dbec9fc2a-86c1-483d-8a0e-01097322=
77d7;
> +        name=3Dboot,start=3D4M,size=3D128M,bootable,type=3Debd0a0a2-b9e=
5-4433-87c0-68b6b72699c7,
> +        name=3Drootfs,size=3D3072M,type=3D0fc63daf-8483-4772-8e79-3d69d=
8477de4;
> +        name=3Dsystem-data,size=3D512M,type=3D0fc63daf-8483-4772-8e79-3=
d69d8477de4;
> +        name=3D[ext],size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d8477d=
e4;
> +        name=3Duser,size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d8477de=
4;
> +        name=3Dmodules,size=3D100M,type=3D0fc63daf-8483-4772-8e79-3d69d=
8477de4;
> +        name=3Dramdisk,size=3D8M,type=3D0fc63daf-8483-4772-8e79-3d69d84=
77de4
> +    =3D> gpt write mmc 0 $gpt_parts
> +
> +
> +If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a random=
 UUID
> +will be generated for the partition
> +
> +The 'gpt verify' command returns 0 if the layout matches the one on the=
 storage
> +device or 1 if not. To check if the layout on the MMC #0 storage device
> +matches the provided text description one has to issue following comman=
d:

The command can be used with and without partition parameter. This
should be described here.

I would prefer:

sets the return value $? to 0 (true) if the layout
or 1 (false) if not

> +
> +::
> +
> +    =3D> gpt verify mmc 0 $gpt_parts
> +
> +The verify sub-command is especially useful in the system update script=
s:
> +
> +::
> +
> +    =3D> if gpt verify mmc 0 $gpt_parts; then
> +         echo GPT layout needs to be updated
> +         ...
> +       fi
> +
> +The 'gpt write' command returns 0 on success write or 1 on failure.
> +
> +The 'gpt setenv' command will set a series of environment variables wit=
h
> +information about a particular partition. The variables are:
> +
> +* gpt_partition_addr (the starting offset of the partition, in hexadeci=
mal blocks)
> +* gpt_partition_size (the size of the partition, in hexadecimal blocks)

The blocks that are not hexadecimal, the numbers are.

gpt_partition_addr (first block of the partition as hexadecimal number)
gpt_partition_size (number of blocks as hexadecimal number)

> +* gpt_partition_name (the name of the partition)
> +* gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3,=
 etc.)

This value is currently decimal but this seems to be a bug. We need a
hexadecimal number to use this variable in a command like

     load host 0:$gpt_partition_entry $loadaddr filename

Another bug is that this command assumes that partitions are
continuously numbered.

> +
> +To get the information about the partition named 'rootfs', issue the fo=
llowing
> +command:
> +
> +::
> +    =3D> gpt setenv mmc 0 rootfs
> +    =3D> echo ${gpt_partition_addr}
> +    2000
> +    =3D> echo ${gpt_partition_size}
> +    14a000
> +    =3D> echo ${gpt_partition_name}
> +    rootfs
> +    =3D> echo ${gpt_partition_entry}
> +    2
> +
> +The 'gpt enumerate' command will set the variable 'gpt_partition_list' =
with the
> +list of partition names on the device. For example:
> +
> +::
> +    =3D> gpt enumerate
> +    =3D> echo gpt_partition_list
> +    boot rootfs system-data [ext] user modules ramdisk

As we cannot see from the output if there is a partition 'user' and a
partition 'modules' or only a single partition 'user modules' this
sub-command seems to need some rework.

Best regards

Heinrich

> +
> +The 'gpt guid' command will report the GUID of a disk. If 'varname' is
> +specified, the command will set the variable to the GUID, otherwise it =
will be
> +printed out. For example:
> +
> +::
> +    =3D> gpt guid mmc 0
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> +    =3D> gpt guid mmc gpt_disk_uuid
> +    =3D> echo ${gpt_disk_uuid}
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> +
> +The 'gpt read' command will print out the current state of the GPT part=
ition
> +table. If 'varname' is specified, the variable will be filled with a pa=
rtition
> +string as described above that is suitable for passing to other 'gpt' c=
ommands.
> +If omitted, a human readable description is printed out.
> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> +
> +The 'gpt swap' command changes the names of all partitions that are nam=
ed
> +'name1' to be 'name2', and all partitions named 'name2' to be 'name1'.
> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> +
> +The 'gpt rename' command renames all partitions named 'part' to be 'nam=
e1'.
> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> +
> +Configuration
> +-------------
> +
> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To enable=
 'gpt
> +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_REN=
AME=3Dy.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 3326ec82ff..4bfaabbd16 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -65,6 +65,7 @@ Shell commands
>      cmd/for
>      cmd/fwu_mdata
>      cmd/gpio
> +   cmd/gpt
>      cmd/host
>      cmd/imxtract
>      cmd/load

