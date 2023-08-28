Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF58AC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3FF86479;
	Tue, 29 Aug 2023 00:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P0GGQCyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755098647F; Tue, 29 Aug 2023 00:59:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC416863E8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693263538; x=1693868338; i=xypron.glpk@gmx.de;
 bh=sEQOaf1nAvBimReTmzDn+7NxahCHqha8Ju1crgrtjiU=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=P0GGQCyDA3Nbzrmc88JPoXnpWklCpt4Czx3Gb2yMd8M1abPXGxKHkTY7Jt6oU8/M0n6LnlC
 4hv6o0vTv4ZKJfZfHROUp/0+xL+R2JCU2YIWVTyc92+4Y+VflPlwePxiykpV1+prdUuTRzWtx
 r9OgmiFEB5otUiTaZTmrOjJcicGI7P/cbpzI4t/v5jfpp7+/5iHgyMHffUDTZzpuciIZ4sJ+1
 QW0mMKSbHksxh+KRLH2Ekrb5glObt3cXXAcpjB4xBhILr2T21hxsDgO+acH9Q92h/DtvtgBEm
 F35We1ROH1WU0ua8D808r+uJo43o6wp2mCm6XBEZE+h/sv9eCrUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1piWgS0zBi-00tk6V; Tue, 29
 Aug 2023 00:58:58 +0200
Message-ID: <e26582f6-09ba-4c2a-ba84-2e75fec5ee08@gmx.de>
Date: Tue, 29 Aug 2023 00:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] doc: Add gpt command documentation
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-3-JPEWhacker@gmail.com>
 <42cf6878-2bb3-4a58-82cc-96f920cf9e4f@gmx.de>
In-Reply-To: <42cf6878-2bb3-4a58-82cc-96f920cf9e4f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ej2HZGjnr0gmCPWoeCom+UYq8XqJ6rWTl4aJTUJ1rmQM8whF2lW
 0wMIKWQ8K0w5viePZHTtl2QRsb4RW9CGNWA5WZ/H744rNZyEhMZXveEj+vqSJHGr+u0QJ9/
 UJoxfp4YaAbZgwpGLG3xbjr4SayB22ku+V0GTTfAhgtnMB7U3UyVTV/jU5bGWhEl44buRCN
 TOaSeryfxTW7EZHyC3+OA==
UI-OutboundReport: notjunk:1;M01:P0:9HSIokRfryc=;TRN7etuqM0Qxj4e98a603c15Ea/
 K0uLkDuVSQ3ftDU5juL43bezDMbLSf8L3b2UO0/0DYy0LW1i7+Sui/TdJ+QU/N6TRZGuggCx/
 vcx++B1MSSrAiNCxoJdKmbONk7HYba5PLmCg56bMbkIF8/6H/xn6mLuEJKAY5qnIhr0ACPUsv
 5bz2M8fod7KTIwJw7HoBjKmphpcBzmIHfvLf8zM5uX3aIvYSLxeTkye0mYqIs9dVbtb9dVJS0
 VeQAh+Lou3L7XgEn/xvuvNnWzNt6kKdX6Vgq4E5BpuGxszbLN62jH8LjymK1PxNner4YAfkAz
 PFEazHqZ7mmGdxsRJQKuZS9GyzhO5wtbNaBy7MJJZq8pxEtvC5LEO/wVDytEKEdBlF0Bsk4OU
 L1p46Gt9Cz7UuQzK1GlcITBaXE4eAsLaY/QXRVH6uId7sKy7IM1rePsv/Higk5dxVdlv5U5Ex
 y9Yw0eMsgxUe6gnDYO5htDA5sPrP9IVSEawqvoYUhrJmUEeyk/rHL9Kos6DXHG10fn+x+RtHI
 JrjVgU0zwwCKfSIhzA9opTiIXv1zUChF7r2ww1vBXjVume8ksPfE60E7Ks/TbekG2V3L/Dsy7
 6kk9tEui+22QzD4dmDYbx8guaAQzhSH9NFQwd4R9ngLD5a8UMv4QBQCP+kpCqNWtRRw2bQus1
 qWWCIs2GoDAzeAzFjPn89cW4jnTcdJbpNj2LX2vA90tJcWo1csav+bAGiVVLnyXEUNUqC+mFW
 3MGLAqRcYQFtL4RYy42VjuQBNbnOTBUgbRSMN4Y+ySViRamL5MDR78N8U/t+JU2Eg+ac080FO
 ebSfH6y2ynzeRIo8FyxxkSYz18jWfuR8qozOzejJ7p/Xf9AHbf47BhABkm/U8qH64FI5BZClZ
 xtpCEotL89+uPCPMbE9r+B2aP7JKnnbgLYh9H0JRon/r7g2wDe2iek8xXZStT1igFgZxkRMqN
 QiicOQ7gTzOO+8go8gPKThIwt0c=
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

On 8/29/23 00:45, Heinrich Schuchardt wrote:
> /On 8/28/23 23:56, Joshua Watt wrote:
>> Adds initial documentation for the gpt command
>>
>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>> ---
>> =C2=A0 doc/usage/cmd/gpt.rst | 184 ++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 doc/usage/index.rst=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 2 files changed, 185 insertions(+)
>> =C2=A0 create mode 100644 doc/usage/cmd/gpt.rst
>>
>> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
>> new file mode 100644
>> index 0000000000..6387c8116f
>> --- /dev/null
>> +++ b/doc/usage/cmd/gpt.rst
>> @@ -0,0 +1,184 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +gpt command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Synopsis
>> +--------
>> +
>> +::
>> +
>> +=C2=A0=C2=A0=C2=A0 gpt enumerate <interface> <dev>
>> +=C2=A0=C2=A0=C2=A0 gpt guid <interface> <dev> [<varname>]
>> +=C2=A0=C2=A0=C2=A0 gpt read <interface> <dev> [<varname>]
>> +=C2=A0=C2=A0=C2=A0 gpt rename <interface> <dev> <part> <name>
>> +=C2=A0=C2=A0=C2=A0 gpt repair <interface> <dev>
>> +=C2=A0=C2=A0=C2=A0 gpt setenv <interface> <dev> <partition name>
>> +=C2=A0=C2=A0=C2=A0 gpt swap <interface> <dev> <name1> <name2>
>> +=C2=A0=C2=A0=C2=A0 gpt verify <interface> <dev> [<partition string>]
>> +=C2=A0=C2=A0=C2=A0 gpt write <interface> <dev> <partition string>
>> +
>> +Description
>> +-----------
>> +
>> +The gpt command lets users read, create, modify, or verify the GPT (GU=
ID
>> +Partition Table) partition layout.
>> +
>> +Common arguments:
>> +
>> +interface
>> +=C2=A0=C2=A0=C2=A0 interface for accessing the block device (mmc, sata=
, scsi, usb,
>> ....)
>> +
>> +dev
>> +=C2=A0=C2=A0=C2=A0 device number
>> +
>> +partition string
>> +=C2=A0=C2=A0=C2=A0 Describes the GPT partition layout for a disk.=C2=
=A0 The syntax is
>> similar to
>> +=C2=A0=C2=A0=C2=A0 the one used by the :doc:`mbr command <mbr>` comman=
d. The string
>> contains
>> +=C2=A0=C2=A0=C2=A0 one or more partition descriptors, each separated b=
y a ";". Each
>> descriptor
>> +=C2=A0=C2=A0=C2=A0 contains one or more fields, with each field separa=
ted by a ",".
>> Fields are
>> +=C2=A0=C2=A0=C2=A0 either of the form "key=3Dvalue" to set a specific =
value, or simple
>> "flag" to
>> +=C2=A0=C2=A0=C2=A0 set a boolean flag
>> +
>> +=C2=A0=C2=A0=C2=A0 The first descriptor can optionally be used to desc=
ribe
>> parameters for the
>> +=C2=A0=C2=A0=C2=A0 whole disk with the following fields:
>> +
>> +=C2=A0=C2=A0=C2=A0 * uuid_disk=3DUUID - Set the UUID for the disk
>> +
>> +=C2=A0=C2=A0=C2=A0 Partition descriptors can have the following fields=
:
>> +
>> +=C2=A0=C2=A0=C2=A0 * name=3D<NAME> - The partition name, required
>> +=C2=A0=C2=A0=C2=A0 * start=3D<BYTES> - The partition start offset in b=
ytes, required
>
> The code has this comment: "start address is optional".
>
>> +=C2=A0=C2=A0=C2=A0 * size=3D<BYTES> - The partition size in bytes or "=
-" to expand it
>> to the whole free area
>
> This filed is mandatory.
>
>> +=C2=A0=C2=A0=C2=A0 * bootable - Set the legacy bootable flag
>
> This field is optional
>
>> +=C2=A0=C2=A0=C2=A0 * uuid=3D<UUID> - The partition UUID, optional if
>> CONFIG_RANDOM_UUID=3Dy is enabled
>> +=C2=A0=C2=A0=C2=A0 * type=3D<UUID> - The partition type GUID, requires
>> CONFIG_PARTITION_TYPE_GUID=3Dy
>
> This field is optional
>
> Thanks for all the updates. Looks much neater now.
>
> The sequence expected in set_gpt_info() is:
>
> uuid (optional if CONFIG_RANDOM_UUID=3Dy),
> type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=3Dy),
> name (mandatory),
> size (mandatory),
> start (optional),
> bootable (optional).

A gross bug in the gpt command is that 'gpt read' creates a different
sequence than 'gpt write' needs.

Furthermore 'gpt read' does not write all fields needed by 'gpt write'
to recreate the partition table: bootable and type are missing.

Best regards

Heinrich

>
>  From the description above it is not clear that:
>
> * semicolons are used to separate partitions
> * the exact sequence of fields must be kept
> * commas are used to separate fields
> * no extra white-space is allowed.
>
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0 If 'uuid' is not specified, but CONFIG_RANDOM_UUID =
is enabled, a
>> random UUID
>> +=C2=A0=C2=A0=C2=A0 will be generated for the partition
>> +
>> +gpt enumerate
>> +~~~~~~~~~~~~~
>> +
>> +Sets the variable 'gpt_partition_list' to be a list of all the
>> partition names
>> +on the device.
>> +
>> +gpt guid
>> +~~~~~~~~
>> +
>> +Report the GUID of a disk. If 'varname' is specified, the command
>> will set the
>> +variable to the GUID, otherwise it will be printed out.
>> +
>> +gpt read
>> +~~~~~~~~
>> +
>> +Prints the current state of the GPT partition table. If 'varname' is
>> specified,
>> +the variable will be filled with a partition string in the same
>> format as a
>> +'<partition string>', suitable for passing to other 'gpt' commands.
>> If the
>> +argument is omitted, a human readable description is printed out.
>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
>> +
>> +gpt rename
>> +~~~~~~~~~~
>> +
>> +Renames all partitions named 'part' to be 'name'.
>> CONFIG_CMD_GPT_RENAME=3Dy is
>> +required.
>> +
>> +gpt repair
>> +~~~~~~~~~~
>> +
>> +Repairs the GPT partition tables if it they become corrupted.
>> +
>> +gpt setenv
>> +~~~~~~~~~~
>> +
>> +The 'gpt setenv' command will set a series of environment variables wi=
th
>> +information about the partition named '<partition name>'. The
>> variables are:
>> +
>> +gpt_partition_addr
>> +=C2=A0=C2=A0=C2=A0 the starting offset of the partition in blocks as a=
 hexadecimal
>> number
>> +
>> +gpt_partition_size
>> +=C2=A0=C2=A0=C2=A0 the size of the partition in blocks as a hexadecima=
l number
>> +
>> +gpt_partition_name
>> +=C2=A0=C2=A0=C2=A0 the name of the partition
>> +
>> +gpt_partition_entry
>> +=C2=A0=C2=A0=C2=A0 the partition number in the table, e.g. 1, 2, 3, et=
c.
>
> Since eeef58401520 ("cmd: let gpt_partition_entry be hexadecimal") this
> is a hexadecimal number. As partitions are not required to be numbered
> start at 1:
>
> %s/, e.g. 1, 2, 3, etc./as a hexadecimal number/
>
>> +
>> +gpt swap
>> +~~~~~~~~
>> +
>> +Changes the names of all partitions that are named 'name1' to be
>> 'name2', and
>> +all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=3Dy =
is
>> +required.
>> +
>> +gpt verify
>> +~~~~~~~~~~
>> +
>> +Sets return value $? to 0 (true) if the partition layout on the
>> +specified disk matches the one in the provided partition string, and
>> 1 (false)
>> +if it does not match. If no partition string is specified, the
>> command will
>> +check if the disk is partitioned or not.
>> +
>> +gpt write
>> +~~~~~~~~~
>> +
>> +(Re)writes the partition table on the disk to match the provided
>> +partition string. It returns 0 on success or 1 on failure.
>> +
>> +Configuration
>> +-------------
>
> All other man-pages have Configuration after Examples.
>
>> +
>> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To enabl=
e
>> 'gpt
>> +read', 'gpt swap' and 'gpt rename', you must specify
>> CONFIG_CMD_GPT_RENAME=3Dy.
>> +
>> +Examples
>> +~~~~~~~~
>
> An example for gpt read would be nice.
>
>> +Create 6 partitions on a disk:: > +
>> +=C2=A0=C2=A0=C2=A0 =3D> setenv gpt_parts 'uuid_disk=3Dbec9fc2a-86c1-48=
3d-8a0e-0109732277d7;
>> +
>> name=3Dboot,start=3D4M,size=3D128M,bootable,type=3Debd0a0a2-b9e5-4433-8=
7c0-68b6b72699c7,
>> +
>> name=3Drootfs,size=3D3072M,type=3D0fc63daf-8483-4772-8e79-3d69d8477de4;
>> +
>> name=3Dsystem-data,size=3D512M,type=3D0fc63daf-8483-4772-8e79-3d69d8477=
de4;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D[ext],size=3D-,type=
=3D0fc63daf-8483-4772-8e79-3d69d8477de4;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3Duser,size=3D-,type=
=3D0fc63daf-8483-4772-8e79-3d69d8477de4;
>> +
>> name=3Dmodules,size=3D100M,type=3D0fc63daf-8483-4772-8e79-3d69d8477de4;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3Dramdisk,size=3D8M,ty=
pe=3D0fc63daf-8483-4772-8e79-3d69d8477de4
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt write mmc 0 $gpt_parts
>
> There is a starting single quotation mark, but I don't see an ending
> single quotation mark.
>
> White-space is not allowed before 'name=3D'. As ugly as it is, please, p=
ut
> the whole setenv command into a single line.
>
> You cannot use a comma before name=3D. It must be a semicolon.
>
> Looking at the code the sequence in the partition descriptors seems to
> be wrong. It should be
>
> uuid (optional if CONFIG_RANDOM_UUID=3Dy),
> type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=3Dy),
> name (mandatory),
> size (mandatory),
> start (optional),
> bootable (optional).
> .
> Please, use a command that you have actually tested and copy it
> verbatim. sandbox_defconfig has a host bind command to attach a file as
> drive. That makes testing easy.
>
>> +
>> +
>> +Verify that the device matches the partition layout described in the
>> variable
>> +$gpt_parts::
>> +
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt verify mmc 0 $gpt_parts
>
> How about adding output here:
>
> =3D> gpt verify mmc 0 $gpt_parts; echo $?
> 0
>
> Best regards
>
> Heinrich
>
>> +
>> +
>> +Get the information about the partition named 'rootfs'::
>> +
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt setenv mmc 0 rootfs
>> +=C2=A0=C2=A0=C2=A0 =3D> echo ${gpt_partition_addr}
>> +=C2=A0=C2=A0=C2=A0 2000
>> +=C2=A0=C2=A0=C2=A0 =3D> echo ${gpt_partition_size}
>> +=C2=A0=C2=A0=C2=A0 14a000
>> +=C2=A0=C2=A0=C2=A0 =3D> echo ${gpt_partition_name}
>> +=C2=A0=C2=A0=C2=A0 rootfs
>> +=C2=A0=C2=A0=C2=A0 =3D> echo ${gpt_partition_entry}
>> +=C2=A0=C2=A0=C2=A0 2
>> +
>> +Get the list of partition names on the disk::
>> +
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt enumerate
>> +=C2=A0=C2=A0=C2=A0 =3D> echo gpt_partition_list
>> +=C2=A0=C2=A0=C2=A0 boot rootfs system-data [ext] user modules ramdisk
>> +
>> +
>> +Get the GUID for a disk::
>> +
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt guid mmc 0
>> +=C2=A0=C2=A0=C2=A0 bec9fc2a-86c1-483d-8a0e-0109732277d7
>> +=C2=A0=C2=A0=C2=A0 =3D> gpt guid mmc gpt_disk_uuid
>> +=C2=A0=C2=A0=C2=A0 =3D> echo ${gpt_disk_uuid}
>> +=C2=A0=C2=A0=C2=A0 bec9fc2a-86c1-483d-8a0e-0109732277d7
>> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
>> index f45a7f5502..fa702920fa 100644
>> --- a/doc/usage/index.rst
>> +++ b/doc/usage/index.rst
>> @@ -66,6 +66,7 @@ Shell commands
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/for
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/fwu_mdata
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/gpio
>> +=C2=A0=C2=A0 cmd/gpt
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/host
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/imxtract
>> =C2=A0=C2=A0=C2=A0=C2=A0 cmd/load
>

