Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA82C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E7C86452;
	Mon, 28 Aug 2023 22:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lfikDy2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6A8647D; Mon, 28 Aug 2023 22:00:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9162486430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693252812; x=1693857612; i=xypron.glpk@gmx.de;
 bh=DIcRfxY7mR6CpcjYLn/JrSMrKumxbPL9siPV0BLCXxU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lfikDy2pGQwC0Ay2WDf0iSGjoNSdTVZ/JO/10SpSX0yRGPJmiEQUX0FnIZOUgoCybaLYzL3
 I9xIIle2tSnOEF5NpRI2F9RB0dNlTB33rp3hb0fS1Z5W6CmnKKac9R1h/s1qjIsp+weHr3Ep6
 RhyJ1pvlEilr2r73KmgCGzIoix7ix9HxI3dbDqMuCiGytu2IaYXHN1Ikdm8pJIZVIP3LYN8s6
 2RNwpYvpP4kDZohc7orYZkE6twmpPF4WLDIj/4uJCqqEyG6vSfr0mIiUzgR7FGrH7lLAuVqx9
 U3teXu1LA5vgnthirXqLzoAktivgjDKU6/rnZNfWMvf3fcobBugg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1qUsrI3jyN-00GKvR; Mon, 28
 Aug 2023 22:00:11 +0200
Message-ID: <55c0a798-77d2-4172-b30e-1ab04aa25e1a@gmx.de>
Date: Mon, 28 Aug 2023 22:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] doc: Add gpt command documentation
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
 <c8def079-428f-86fe-68a6-f296d1df776f@gmx.de>
 <CAJdd5GaiDQ6erN4T16HzV3q8Kr+vMs9rWWCTaCr6axWfhxvqUg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAJdd5GaiDQ6erN4T16HzV3q8Kr+vMs9rWWCTaCr6axWfhxvqUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1w1KqgIDaubBBMeoXOQWSWqGpLLe3KJGlmNE/oVXE0DSfFTSPy/
 1i7vB79XMIzjAfnmEUoaDvA6j1ZJmTlDDR9JCiE3V8UAw7XHSEtMDnZje2RlXcChR5V9ugB
 d/T85VBGbxZSBMcrfGpgiZjaCy1+2h01DM09p80Tj3v/hzTAYZi1aWNm4uSMSAUGUOzuEcW
 xW2OU8r57864LBPDHWeoA==
UI-OutboundReport: notjunk:1;M01:P0:X5rE7b40c18=;4MFd0T/ulIWHjMG9BO07sKBNZIf
 aMhi9H/nPOFfHsj72zC4QtXFZu8ZXUvR/7wJw3j/Aq58M8UvA/aa+M5/kXBrOyMwZkzDnkDOu
 q826RWNM91ZJo3hMcB0dRd3NXk+flTgkOc2yKhssBRB5tCZ6XYRdoeMQ8HvGWhTRtPfOalzXN
 Kqiiy5QRtqA6mjLGXadsSSQFoatuQHW0miq3DLnNTQ/9Dkj6Fl9PrONwMc8ZS0XQS1CxrTjwq
 PFQM6mIpWcDqnw7DYS4GdK3o9XR6c18yhYhODsK9tqLi95CV4CyE4dpOvrXAc+OqYRWzW2fRE
 c3F8yL+xyfrpAl59GfeVxPxeKrdpVJS7jgsbBYSlNH0DZEgKvN3Y4LlC9FfaE1VIlMgCN4Q+e
 E0TbqxoTJvE/j9U9t/GUdF4Q4dPMF6IAOUBzjNc3VLAEstVzlB2Wq36ox4RXu8EJyQG1jq8eT
 ZrpH98Hv53ZeorYS1Qld/2cAc+xf6BqpScR8u6RMjVvk1aSTJFHhcmSk04XL5ObDcFaSQe/sr
 02Dx3yeeM8N2XpfksQqL9Wgo/L5cDAkxaAlWwnGYeHzbTImMQdLC5v7c5Uxl6DI3ClYcR8Ui3
 ANgAC3l5+UycRkxF9kbVfH3OkVm0vISrP3aYwcq7z8Rlc8t3I318V+KpYKFF+tSIKEYpL2GOA
 r1eTzZNpWvnDcIjuDM5kRn8p1vejl6M5Pc0aMtTy26+h/vL9/C8s38jiwFNWehJXZGGT3Kcwz
 VrJBOnxbBbB11F290eHvux+XtZVfxLN/UwRv7vV3YAM42AwxA8wz5fwfFqPOrsINTjo6weNSD
 Fa+PVKDjQDfgEnt3UI13X1UmWVN04eHIv/AlJsNX4+AX5TLHZEV11LsNF72lfsCZFF3uJbHWf
 SeibjWXuPS3LRnGml2NwfeyiBY6bL3qFL7bvE51DMqY+KR6VIUnXvYSWciSeDkNRRl48gBCHL
 oZ52+GN5pHc2r1jfkh5jPQxbEgo=
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

On 8/28/23 21:29, Joshua Watt wrote:
> On Fri, Aug 25, 2023 at 7:57=E2=80=AFPM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> On 8/25/23 21:38, Joshua Watt wrote:
>>> Adds initial documentation for the gpt command
>>
>> Thanks a lot for filling the gap.
>>
>>>
>>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>>> ---
>>>    doc/usage/cmd/gpt.rst | 141 +++++++++++++++++++++++++++++++++++++++=
+++
>>>    doc/usage/index.rst   |   1 +
>>>    2 files changed, 142 insertions(+)
>>>    create mode 100644 doc/usage/cmd/gpt.rst
>>>
>>> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
>>> new file mode 100644
>>> index 0000000000..f6e082fb94
>>> --- /dev/null
>>> +++ b/doc/usage/cmd/gpt.rst
>>> @@ -0,0 +1,141 @@
>>> +.. SPDX-License-Identifier: GPL-2.0+
>>> +
>>> +gpt command
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +Synopsis
>>> +--------
>>> +
>>> +::
>>> +
>>> +    gpt repair <interface> <device no>
>>> +    gpt write <interface> <device no> <partition string>
>>> +    gpt verify <interface> <device no> <partition string>
>>
>> <partition string> is not required. Please, add brackets [].
>
> It's not optional; there is no standardized string for the list of GPT
> partitions like there is for MBR

You can use the command without partition string. It will tell you if
the device is partitioned or not.

>
>>
>>> +    gpt setenv <interface> <device no> <partition name>
>>
>> gpt setenv can be called without partition name which leads to a crash.
>>
>> If that parameter is meant to be optional, this should be indicated
>> here. Otherwise an argc check is missing.
>
> I don't believe the argument is optional, but either way it can be
> fixed in a subsequent patch series. I'd rather not hold up the
> documentation to fix bugs
>
>>
>>> +    gpt enumerate <interface> <device no>
>>> +    gpt guid <interface> <device no> [<varname>]
>>> +    gpt read <interface> <device no> [<varname>]
>>> +    gpt swap <interface> <dev> <name1> <name2>
>>> +    gpt rename <interface> <dev> <part> <name>
>>
>> Thanks a lot for providing a man-page for this command.
>>
>> If <device no> and <dev> both relate to the same object type, we should
>> use the same text. <dev> would be fine.
>>
>> The sequence looks random. Please, sort the sub-commands either
>> logically or alphabetically.
>
> They are sorted to match the gpt command help text. Reordering of both
> can be done later if desired.

There is no requirement to follow the gpt help =3Dsequence here.

We should not reproduce what is not helpful.

Best regards

Heinrich

>
>>
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +The gpt command lets users read, create, modify, or verify the GPT (G=
UID
>>> +Partition Table) partition layout.
>>> +
>>> +The syntax of the text description of the partition list is similar t=
o
>>> +the one used by the 'mbr' command. The string contains one or more pa=
rtition
>>
>> Please, link the mbr page:
>>
>> by the :doc:`mbr command <mbr>`.
>>
>>> +descriptors, each separated by a ";". Each descriptor contains one or=
 more
>>> +fields, with each field separated by a ",". Fields are either of the =
form
>>> +"key=3Dvalue" to set a specific value, or simple "flag" to set a bool=
ean flag
>>
>> At this point it remains unclear to the reader what this ;-separated
>> string format relates to.
>> Is it an output format?
>> Is it a format used in variables?
>> Is it used for the parameter 'partition string'?
>>
>> Maybe describe it after the parameters and relate it to the 'partition
>> string' parameter.
>>
>> Please, describe all parameters (in this indented format):
>>
>> interface
>>       interface for accessing the block device (mmc, sata, scsi, usb, .=
...)
>>
>> device no
>>       device number
>>
>> ...
>>
>>> +
>>> +The first descriptor can optionally be used to describe parameters fo=
r the
>>> +whole disk with the following fields:
>>> +
>>> +* uuid_disk=3DUUID - Set the UUID for the disk
>>> +
>>> +Partition descriptors can have the following fields:
>>> +* name=3DNAME - The partition name, required
>>
>> Maybe better
>>
>> name=3D<NAME>
>>
>> This is not rendered as an unordered list but everything is in one line=
.
>> Please, add the missing blank lines.
>>
>> Please, generate the HTML documentation as described in
>> https://u-boot.readthedocs.io/en/latest/build/documentation.html
>> and check the output before resubmitting.
>>
>>> +* start=3DBYTES - The partition start offset in bytes, required
>>> +* size=3DBYTES - The partition size, in bytes or "-" to expand it to =
the whole free area
>>> +* bootable - Set the legacy bootable flag
>>> +* uuid=3DUUID - Set the partition UUID, optional if CONFIG_RANDOM_UUI=
D=3Dy is enabled
>>> +* type=3DUUID - Set the partition type GUID, requires CONFIG_PARTITIO=
N_TYPE_GUID=3Dy
>>> +
>>
>> The following should be in a separate 'Examples' section to match the
>> other man-pages.
>>
>>> +Here is an example how to create a 6 partitions, some of the predefin=
ed sizes:
>>> +
>>> +::
>>> +
>>> +    =3D> setenv gpt_parts 'uuid_disk=3Dbec9fc2a-86c1-483d-8a0e-010973=
2277d7;
>>> +        name=3Dboot,start=3D4M,size=3D128M,bootable,type=3Debd0a0a2-b=
9e5-4433-87c0-68b6b72699c7,
>>> +        name=3Drootfs,size=3D3072M,type=3D0fc63daf-8483-4772-8e79-3d6=
9d8477de4;
>>> +        name=3Dsystem-data,size=3D512M,type=3D0fc63daf-8483-4772-8e79=
-3d69d8477de4;
>>> +        name=3D[ext],size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d847=
7de4;
>>> +        name=3Duser,size=3D-,type=3D0fc63daf-8483-4772-8e79-3d69d8477=
de4;
>>> +        name=3Dmodules,size=3D100M,type=3D0fc63daf-8483-4772-8e79-3d6=
9d8477de4;
>>> +        name=3Dramdisk,size=3D8M,type=3D0fc63daf-8483-4772-8e79-3d69d=
8477de4
>>> +    =3D> gpt write mmc 0 $gpt_parts
>>> +
>>> +
>>> +If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a rand=
om UUID
>>> +will be generated for the partition
>>> +
>>> +The 'gpt verify' command returns 0 if the layout matches the one on t=
he storage
>>> +device or 1 if not. To check if the layout on the MMC #0 storage devi=
ce
>>> +matches the provided text description one has to issue following comm=
and:
>>
>> The command can be used with and without partition parameter. This
>> should be described here.
>>
>> I would prefer:
>>
>> sets the return value $? to 0 (true) if the layout
>> or 1 (false) if not
>>
>>> +
>>> +::
>>> +
>>> +    =3D> gpt verify mmc 0 $gpt_parts
>>> +
>>> +The verify sub-command is especially useful in the system update scri=
pts:
>>> +
>>> +::
>>> +
>>> +    =3D> if gpt verify mmc 0 $gpt_parts; then
>>> +         echo GPT layout needs to be updated
>>> +         ...
>>> +       fi
>>> +
>>> +The 'gpt write' command returns 0 on success write or 1 on failure.
>>> +
>>> +The 'gpt setenv' command will set a series of environment variables w=
ith
>>> +information about a particular partition. The variables are:
>>> +
>>> +* gpt_partition_addr (the starting offset of the partition, in hexade=
cimal blocks)
>>> +* gpt_partition_size (the size of the partition, in hexadecimal block=
s)
>>
>> The blocks that are not hexadecimal, the numbers are.
>>
>> gpt_partition_addr (first block of the partition as hexadecimal number)
>> gpt_partition_size (number of blocks as hexadecimal number)
>>
>>> +* gpt_partition_name (the name of the partition)
>>> +* gpt_partition_entry (the partition number in the table, e.g. 1, 2, =
3, etc.)
>>
>> This value is currently decimal but this seems to be a bug. We need a
>> hexadecimal number to use this variable in a command like
>>
>>       load host 0:$gpt_partition_entry $loadaddr filename
>>
>> Another bug is that this command assumes that partitions are
>> continuously numbered.
>>
>>> +
>>> +To get the information about the partition named 'rootfs', issue the =
following
>>> +command:
>>> +
>>> +::
>>> +    =3D> gpt setenv mmc 0 rootfs
>>> +    =3D> echo ${gpt_partition_addr}
>>> +    2000
>>> +    =3D> echo ${gpt_partition_size}
>>> +    14a000
>>> +    =3D> echo ${gpt_partition_name}
>>> +    rootfs
>>> +    =3D> echo ${gpt_partition_entry}
>>> +    2
>>> +
>>> +The 'gpt enumerate' command will set the variable 'gpt_partition_list=
' with the
>>> +list of partition names on the device. For example:
>>> +
>>> +::
>>> +    =3D> gpt enumerate
>>> +    =3D> echo gpt_partition_list
>>> +    boot rootfs system-data [ext] user modules ramdisk
>>
>> As we cannot see from the output if there is a partition 'user' and a
>> partition 'modules' or only a single partition 'user modules' this
>> sub-command seems to need some rework.
>
> Can be fixed later.
>
>>
>> Best regards
>>
>> Heinrich
>>
>>> +
>>> +The 'gpt guid' command will report the GUID of a disk. If 'varname' i=
s
>>> +specified, the command will set the variable to the GUID, otherwise i=
t will be
>>> +printed out. For example:
>>> +
>>> +::
>>> +    =3D> gpt guid mmc 0
>>> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
>>> +    =3D> gpt guid mmc gpt_disk_uuid
>>> +    =3D> echo ${gpt_disk_uuid}
>>> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
>>> +
>>> +The 'gpt read' command will print out the current state of the GPT pa=
rtition
>>> +table. If 'varname' is specified, the variable will be filled with a =
partition
>>> +string as described above that is suitable for passing to other 'gpt'=
 commands.
>>> +If omitted, a human readable description is printed out.
>>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
>>> +
>>> +The 'gpt swap' command changes the names of all partitions that are n=
amed
>>> +'name1' to be 'name2', and all partitions named 'name2' to be 'name1'=
.
>>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
>>> +
>>> +The 'gpt rename' command renames all partitions named 'part' to be 'n=
ame1'.
>>> +CONFIG_CMD_GPT_RENAME=3Dy is required.
>>> +
>>> +Configuration
>>> +-------------
>>> +
>>> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=3Dy. To enab=
le 'gpt
>>> +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_R=
ENAME=3Dy.
>>> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
>>> index 3326ec82ff..4bfaabbd16 100644
>>> --- a/doc/usage/index.rst
>>> +++ b/doc/usage/index.rst
>>> @@ -65,6 +65,7 @@ Shell commands
>>>       cmd/for
>>>       cmd/fwu_mdata
>>>       cmd/gpio
>>> +   cmd/gpt
>>>       cmd/host
>>>       cmd/imxtract
>>>       cmd/load
>>

