Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC96C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCF6864A0;
	Tue, 29 Aug 2023 00:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hAyZNu1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7721C8644E; Tue, 29 Aug 2023 00:44:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47168648B
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693262656; x=1693867456; i=xypron.glpk@gmx.de;
 bh=AGbkuAsV3P57AD5PdVdwQW5mmXrTBurpthP3Htk0mts=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hAyZNu1W19UDXQ7iaxn83zBV0z3JmdZxg/GU1B/pZzScekt4iBeoWJKZVJNkMfNpn5VY467
 wWAjVmPKQwtpbyHHibAfhO7Kv4727h3ZnbUn5mFD3VrGsOPfNq2JueBbHtpS3hvuD6XrlolWo
 ZbwWCY0tNLQx1ke9OHCSKHZSGfwcq01me6d+oqitA7+EVVpzB/n1kK2IJGv/BY+PoPtuG2GvP
 GRS6Gqt9ZVbtuAS39J6IbNxkgC3BBn9coKCcXTQm6qqiD3oszE6N052TmiQ4Z6NyzmKtg0EOK
 B6pK5XpsWXvkvws2J0rZ+8F/IX91SPvbNELyuSHo+Rzf6sNH07bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1q2FEI0u2c-00ZyWV; Tue, 29
 Aug 2023 00:44:16 +0200
Message-ID: <42cf6878-2bb3-4a58-82cc-96f920cf9e4f@gmx.de>
Date: Tue, 29 Aug 2023 00:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] doc: Add gpt command documentation
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-3-JPEWhacker@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230828215623.3727536-3-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SOmcXVWpuXHtMS7SpKDh036K9pVQbiR0AJsoDwvHlBTWg3tTsQr
 xl4atySjKhPj5UWpbJee4WYoy4mpHM5Pfq7ZGHClD5gGZOccvUL0fVaZQ816/W5ISwocK1m
 0mt7Ci0dgfxvnBCnO6vFM2nE/wTk68LusAScBjSuQ9HDGSIbnPxR0C7d1vctrXGVU1n7I6f
 NZzoj0AR2uTSYkLlzm/Gw==
UI-OutboundReport: notjunk:1;M01:P0:i5WJsQ3SNds=;ot4WrItfLvGLcE5o/7EUgim9XM6
 6XAkMnqrtNENq6/zp0zqaZFztlfR8DlnBUw0NLlV3SjRqYIT3EJmc5BO8auKXGFXoO0S67Xpl
 pZ8es4Vrw/GNEX2AYxbf1Kwur2x5nnB0qnqPn0arBhoUGN2l7fS1QNrPPYLeqkxeLQrVj+hjF
 74RcLx2P3m+6SmCUBxU9qXLj8Jn0ZZkbqX6WIs9sMp79Vm/vD7UKokT8dPHoRBO8D91WfFv6B
 XG5VWUZrMwI64bEtQamwA8UklBPC8PjsDGcJz7GaKj2MM1XKGHiCFjJHHh+7yW0KmwwJ35Lez
 0Hj6tQZFhaxifocFxX/ET2bg6cghtKE5Ysiz8xQRCtF7ur3YDTYXmEDlpo1DLevGk5qxgRJ3E
 y47gYT4iFbehIjlGxQHybWbNslF1z2zwG4/zCnUJVjoGL7id4YZymw/1toAchlokSHf2jkbV/
 /3vFNFCmiyAk5twji/buhPZAGKNb4KKXjuna5vz4EBay9LyTujAearYLlp1T5B/TegnrUp140
 2iEQcGzw7yjwrSnsYvsncuqTuOibtyi9u2W68egrpk5SIcju9I173YiKOIEun1TMyDBwmEsH/
 dCSnEiYNDzb5UcfPQ8+9rFYBVaw6ojozExHrlGI62ioeTREdJhVE2+B9myNsx1MpSl4CHNmMY
 E4Xjq/fGFARQnaLCIneNmoL1ImVqTN7YDImBRa7nP69OBWXwFVbXXD+ewZsXN/Qtr3UKwn0qv
 ctgM9NlLxLB0WX08aU24JIIRy7WvDz7glP/ahHxmrC4jWwPpIci0iN6fkXzfovp5ST+jJDkx7
 G007QT+bPnwmARVaBUiicuxEi1Fn/sJ7RcUkuw8WAHwZpxL0+/FLQlL7u/ggs29S3UOgFV+wT
 RwQ15YdsC1mFjLo5LuiI/Og5GPPjj1y+PxiIeRO+WeJ2W3yTAaUSzo1hYRc0zkdEDd254BPmF
 sMbHQUmXQxAdjJ3wtN4p3oPG+x0=
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

/On 8/28/23 23:56, Joshua Watt wrote:
> Adds initial documentation for the gpt command
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   doc/usage/cmd/gpt.rst | 184 ++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst   |   1 +
>   2 files changed, 185 insertions(+)
>   create mode 100644 doc/usage/cmd/gpt.rst
>
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> new file mode 100644
> index 0000000000..6387c8116f
> --- /dev/null
> +++ b/doc/usage/cmd/gpt.rst
> @@ -0,0 +1,184 @@
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
> +    gpt enumerate <interface> <dev>
> +    gpt guid <interface> <dev> [<varname>]
> +    gpt read <interface> <dev> [<varname>]
> +    gpt rename <interface> <dev> <part> <name>
> +    gpt repair <interface> <dev>
> +    gpt setenv <interface> <dev> <partition name>
> +    gpt swap <interface> <dev> <name1> <name2>
> +    gpt verify <interface> <dev> [<partition string>]
> +    gpt write <interface> <dev> <partition string>
> +
> +Description
> +-----------
> +
> +The gpt command lets users read, create, modify, or verify the GPT (GUI=
D
> +Partition Table) partition layout.
> +
> +Common arguments:
> +
> +interface
> +    interface for accessing the block device (mmc, sata, scsi, usb, ...=
.)
> +
> +dev
> +    device number
> +
> +partition string
> +    Describes the GPT partition layout for a disk.  The syntax is simil=
ar to
> +    the one used by the :doc:`mbr command <mbr>` command. The string co=
ntains
> +    one or more partition descriptors, each separated by a ";". Each de=
scriptor
> +    contains one or more fields, with each field separated by a ",". Fi=
elds are
> +    either of the form "key=3Dvalue" to set a specific value, or simple=
 "flag" to
> +    set a boolean flag
> +
> +    The first descriptor can optionally be used to describe parameters =
for the
> +    whole disk with the following fields:
> +
> +    * uuid_disk=3DUUID - Set the UUID for the disk
> +
> +    Partition descriptors can have the following fields:
> +
> +    * name=3D<NAME> - The partition name, required
> +    * start=3D<BYTES> - The partition start offset in bytes, required

The code has this comment: "start address is optional".

> +    * size=3D<BYTES> - The partition size in bytes or "-" to expand it =
to the whole free area

This filed is mandatory.

> +    * bootable - Set the legacy bootable flag

This field is optional

> +    * uuid=3D<UUID> - The partition UUID, optional if CONFIG_RANDOM_UUI=
D=3Dy is enabled
> +    * type=3D<UUID> - The partition type GUID, requires CONFIG_PARTITIO=
N_TYPE_GUID=3Dy

This field is optional

Thanks for all the updates. Looks much neater now.

The sequence expected in set_gpt_info() is:

uuid (optional if CONFIG_RANDOM_UUID=3Dy),
type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=3Dy),
name (mandatory),
size (mandatory),
start (optional),
bootable (optional).

 From the description above it is not clear that:

* semicolons are used to separate partitions
* the exact sequence of fields must be kept
* commas are used to separate fields
* no extra white-space is allowed.

> +
> +
> +    If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a ra=
ndom UUID
> +    will be generated for the partition
> +
> +gpt enumerate
> +~~~~~~~~~~~~~
> +
> +Sets the variable 'gpt_partition_list' to be a list of all the partitio=
n names
> +on the device.
> +
> +gpt guid
> +~~~~~~~~
> +
> +Report the GUID of a disk. If 'varname' is specified, the command will =
set the
> +variable to the GUID, otherwise it will be printed out.
> +
> +gpt read
> +~~~~~~~~
> +
> +Prints the current state of the GPT partition table. If 'varname' is sp=
ecified,
> +the variable will be filled with a partition string in the same format =
as a
> +'<partition string>', suitable for passing to other 'gpt' commands.  If=
 the
> +argument is omitted, a human readable description is printed out.
> +CONFIG_CMD_GPT_RENAME=3Dy is required.
> +
> +gpt rename
> +~~~~~~~~~~
> +
> +Renames all partitions named 'part' to be 'name'. CONFIG_CMD_GPT_RENAME=
=3Dy is
> +required.
> +
> +gpt repair
> +~~~~~~~~~~
> +
> +Repairs the GPT partition tables if it they become corrupted.
> +
> +gpt setenv
> +~~~~~~~~~~
> +
> +The 'gpt setenv' command will set a series of environment variables wit=
h
> +information about the partition named '<partition name>'. The variables=
 are:
> +
> +gpt_partition_addr
> +    the starting offset of the partition in blocks as a hexadecimal num=
ber
> +
> +gpt_partition_size
> +    the size of the partition in blocks as a hexadecimal number
> +
> +gpt_partition_name
> +    the name of the partition
> +
> +gpt_partition_entry
> +    the partition number in the table, e.g. 1, 2, 3, etc.

Since eeef58401520 ("cmd: let gpt_partition_entry be hexadecimal") this
is a hexadecimal number. As partitions are not required to be numbered
start at 1:

%s/, e.g. 1, 2, 3, etc./as a hexadecimal number/

> +
> +gpt swap
> +~~~~~~~~
> +
> +Changes the names of all partitions that are named 'name1' to be 'name2=
', and
> +all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=3Dy i=
s
> +required.
> +
> +gpt verify
> +~~~~~~~~~~
> +
> +Sets return value $? to 0 (true) if the partition layout on the
> +specified disk matches the one in the provided partition string, and 1 =
(false)
> +if it does not match. If no partition string is specified, the command =
will
> +check if the disk is partitioned or not.
> +
> +gpt write
> +~~~~~~~~~
> +
> +(Re)writes the partition table on the disk to match the provided
> +partition string. It returns 0 on success or 1 on failure.
> +
> +Configuration
> +-------------

All other man-pages have Configuration after Examples.

> +
> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To enable=
 'gpt
> +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_REN=
AME=3Dy.
> +
> +Examples
> +~~~~~~~~

An example for gpt read would be nice.

> +Create 6 partitions on a disk:: > +
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

There is a starting single quotation mark, but I don't see an ending
single quotation mark.

White-space is not allowed before 'name=3D'. As ugly as it is, please, put
the whole setenv command into a single line.

You cannot use a comma before name=3D. It must be a semicolon.

Looking at the code the sequence in the partition descriptors seems to
be wrong. It should be

uuid (optional if CONFIG_RANDOM_UUID=3Dy),
type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=3Dy),
name (mandatory),
size (mandatory),
start (optional),
bootable (optional).
.
Please, use a command that you have actually tested and copy it
verbatim. sandbox_defconfig has a host bind command to attach a file as
drive. That makes testing easy.

> +
> +
> +Verify that the device matches the partition layout described in the va=
riable
> +$gpt_parts::
> +
> +    =3D> gpt verify mmc 0 $gpt_parts

How about adding output here:

=3D> gpt verify mmc 0 $gpt_parts; echo $?
0

Best regards

Heinrich

> +
> +
> +Get the information about the partition named 'rootfs'::
> +
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
> +Get the list of partition names on the disk::
> +
> +    =3D> gpt enumerate
> +    =3D> echo gpt_partition_list
> +    boot rootfs system-data [ext] user modules ramdisk
> +
> +
> +Get the GUID for a disk::
> +
> +    =3D> gpt guid mmc 0
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> +    =3D> gpt guid mmc gpt_disk_uuid
> +    =3D> echo ${gpt_disk_uuid}
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index f45a7f5502..fa702920fa 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -66,6 +66,7 @@ Shell commands
>      cmd/for
>      cmd/fwu_mdata
>      cmd/gpio
> +   cmd/gpt
>      cmd/host
>      cmd/imxtract
>      cmd/load

