Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99724C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 13:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A438864C3;
	Tue, 29 Aug 2023 15:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHxqsFrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B30D864D7; Tue, 29 Aug 2023 15:22:23 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2098648F
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 15:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b703a0453fso65367681fa.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693315339; x=1693920139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WE97KyX4WU97x78NGAKkvHE0VJObtnS5Pm+mmMAwezI=;
 b=qHxqsFrqEkBPxKJNe/9qvRk8JkOIt2X9udlOzefVFw8+ot1yS/ydAuFkczu4eNyhaZ
 vaceXWaDdE/uKLCTpcmycqiHqB9MYpTW+pGcNPEP6yKsoGZgvVb/9eiotmEeep/VFCj7
 xL37jSS5d/2d4gxuvDcIBFEI9gzWoGX6aLjl5EJGzEGhu9EyynO3XawFoKjuQ2afRdVi
 ULEy9Cf/9mTKVwMdRylu1ifOkejPYCXgLMX2rMiTEv2K9M4JaJmHnGFRNrjnPV0wxVTy
 2cJ5lhlKVUl4Rf5J4X4lJwKGjKS45xMfPp4Z+AD7BgMXt3WRwngaD5jABETbA4kQUm5T
 p5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315339; x=1693920139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WE97KyX4WU97x78NGAKkvHE0VJObtnS5Pm+mmMAwezI=;
 b=Ply1LtytU1MB4oesVEIX6Dy7LgXNwvDT4Tt6V3gQFN7+I0XBV/riQxsJaGk976kFa5
 BvI+HEjGguejDm2ff0eNpwWWtK9UGr+qnl9KkEZkCCy0lEi92b97GjAXmu2WOAGcRhGk
 OqebBaRbsn85UJH8nWFxrPDoQzhb5Z7YLJGo38XyU5qnyRd8GmA9vxMPOtMSfZnL0/6T
 C6kjYEtlPuFGtO9EVInAtbs30xO6bQfJu71R5PWdaWeb7otGVLiPwOxYL8qFEHxdeX8I
 kSjnnkyUYlPTZpb6weE8a0bjxtXyHCZMH4NVINe79NmjpDNNE0oq8gjsvxXY/7JQuN1h
 U0gA==
X-Gm-Message-State: AOJu0Yz9hNDYKaMZ/1atjD7r+U4t5DEm7R8MKUQq5KRioyAsoQH8TuKt
 oUsDFDrI3cv6q83q0KQG6yWHkLffJ+FSW40KFKA=
X-Google-Smtp-Source: AGHT+IEokcT/hBz42lmlaFz0D9iMP5mdTg1Kw5ISg54jsMH4EMO1907WKtLce48H7yVRFfgRR/Czfte9zIiTrS8pHeg=
X-Received: by 2002:a05:651c:210e:b0:2bc:ffe5:54a1 with SMTP id
 a14-20020a05651c210e00b002bcffe554a1mr8467480ljq.32.1693315338886; Tue, 29
 Aug 2023 06:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-3-JPEWhacker@gmail.com>
 <42cf6878-2bb3-4a58-82cc-96f920cf9e4f@gmx.de>
 <e26582f6-09ba-4c2a-ba84-2e75fec5ee08@gmx.de>
In-Reply-To: <e26582f6-09ba-4c2a-ba84-2e75fec5ee08@gmx.de>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 29 Aug 2023 07:22:06 -0600
Message-ID: <CAJdd5GbNgEdZs+v6g621N99t+cpALO0_66Lt9MMKECkj5rOFJw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] doc: Add gpt command documentation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, Aug 28, 2023, 4:58 PM Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 8/29/23 00:45, Heinrich Schuchardt wrote:
> > /On 8/28/23 23:56, Joshua Watt wrote:
> >> Adds initial documentation for the gpt command
> >>
> >> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> >> ---
> >>   doc/usage/cmd/gpt.rst | 184 ++++++++++++++++++++++++++++++++++++++++++
> >>   doc/usage/index.rst   |   1 +
> >>   2 files changed, 185 insertions(+)
> >>   create mode 100644 doc/usage/cmd/gpt.rst
> >>
> >> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> >> new file mode 100644
> >> index 0000000000..6387c8116f
> >> --- /dev/null
> >> +++ b/doc/usage/cmd/gpt.rst
> >> @@ -0,0 +1,184 @@
> >> +.. SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +gpt command
> >> +===========
> >> +
> >> +Synopsis
> >> +--------
> >> +
> >> +::
> >> +
> >> +    gpt enumerate <interface> <dev>
> >> +    gpt guid <interface> <dev> [<varname>]
> >> +    gpt read <interface> <dev> [<varname>]
> >> +    gpt rename <interface> <dev> <part> <name>
> >> +    gpt repair <interface> <dev>
> >> +    gpt setenv <interface> <dev> <partition name>
> >> +    gpt swap <interface> <dev> <name1> <name2>
> >> +    gpt verify <interface> <dev> [<partition string>]
> >> +    gpt write <interface> <dev> <partition string>
> >> +
> >> +Description
> >> +-----------
> >> +
> >> +The gpt command lets users read, create, modify, or verify the GPT
> (GUID
> >> +Partition Table) partition layout.
> >> +
> >> +Common arguments:
> >> +
> >> +interface
> >> +    interface for accessing the block device (mmc, sata, scsi, usb,
> >> ....)
> >> +
> >> +dev
> >> +    device number
> >> +
> >> +partition string
> >> +    Describes the GPT partition layout for a disk.  The syntax is
> >> similar to
> >> +    the one used by the :doc:`mbr command <mbr>` command. The string
> >> contains
> >> +    one or more partition descriptors, each separated by a ";". Each
> >> descriptor
> >> +    contains one or more fields, with each field separated by a ",".
> >> Fields are
> >> +    either of the form "key=value" to set a specific value, or simple
> >> "flag" to
> >> +    set a boolean flag
> >> +
> >> +    The first descriptor can optionally be used to describe
> >> parameters for the
> >> +    whole disk with the following fields:
> >> +
> >> +    * uuid_disk=UUID - Set the UUID for the disk
> >> +
> >> +    Partition descriptors can have the following fields:
> >> +
> >> +    * name=<NAME> - The partition name, required
> >> +    * start=<BYTES> - The partition start offset in bytes, required
> >
> > The code has this comment: "start address is optional".
> >
> >> +    * size=<BYTES> - The partition size in bytes or "-" to expand it
> >> to the whole free area
> >
> > This filed is mandatory.
> >
> >> +    * bootable - Set the legacy bootable flag
> >
> > This field is optional
> >
> >> +    * uuid=<UUID> - The partition UUID, optional if
> >> CONFIG_RANDOM_UUID=y is enabled
> >> +    * type=<UUID> - The partition type GUID, requires
> >> CONFIG_PARTITION_TYPE_GUID=y
> >
> > This field is optional
> >
> > Thanks for all the updates. Looks much neater now.
> >
> > The sequence expected in set_gpt_info() is:
> >
> > uuid (optional if CONFIG_RANDOM_UUID=y),
> > type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=y),
> > name (mandatory),
> > size (mandatory),
> > start (optional),
> > bootable (optional).
>
> A gross bug in the gpt command is that 'gpt read' creates a different
> sequence than 'gpt write' needs.
>
> Furthermore 'gpt read' does not write all fields needed by 'gpt write'
> to recreate the partition table: bootable and type are missing.
>

This is fixed in later patches in this series


> Best regards
>
> Heinrich
>
> >
> >  From the description above it is not clear that:
> >
> > * semicolons are used to separate partitions
> > * the exact sequence of fields must be kept
> > * commas are used to separate fields
> > * no extra white-space is allowed.
> >
> >> +
> >> +
> >> +    If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a
> >> random UUID
> >> +    will be generated for the partition
> >> +
> >> +gpt enumerate
> >> +~~~~~~~~~~~~~
> >> +
> >> +Sets the variable 'gpt_partition_list' to be a list of all the
> >> partition names
> >> +on the device.
> >> +
> >> +gpt guid
> >> +~~~~~~~~
> >> +
> >> +Report the GUID of a disk. If 'varname' is specified, the command
> >> will set the
> >> +variable to the GUID, otherwise it will be printed out.
> >> +
> >> +gpt read
> >> +~~~~~~~~
> >> +
> >> +Prints the current state of the GPT partition table. If 'varname' is
> >> specified,
> >> +the variable will be filled with a partition string in the same
> >> format as a
> >> +'<partition string>', suitable for passing to other 'gpt' commands.
> >> If the
> >> +argument is omitted, a human readable description is printed out.
> >> +CONFIG_CMD_GPT_RENAME=y is required.
> >> +
> >> +gpt rename
> >> +~~~~~~~~~~
> >> +
> >> +Renames all partitions named 'part' to be 'name'.
> >> CONFIG_CMD_GPT_RENAME=y is
> >> +required.
> >> +
> >> +gpt repair
> >> +~~~~~~~~~~
> >> +
> >> +Repairs the GPT partition tables if it they become corrupted.
> >> +
> >> +gpt setenv
> >> +~~~~~~~~~~
> >> +
> >> +The 'gpt setenv' command will set a series of environment variables
> with
> >> +information about the partition named '<partition name>'. The
> >> variables are:
> >> +
> >> +gpt_partition_addr
> >> +    the starting offset of the partition in blocks as a hexadecimal
> >> number
> >> +
> >> +gpt_partition_size
> >> +    the size of the partition in blocks as a hexadecimal number
> >> +
> >> +gpt_partition_name
> >> +    the name of the partition
> >> +
> >> +gpt_partition_entry
> >> +    the partition number in the table, e.g. 1, 2, 3, etc.
> >
> > Since eeef58401520 ("cmd: let gpt_partition_entry be hexadecimal") this
> > is a hexadecimal number. As partitions are not required to be numbered
> > start at 1:
> >
> > %s/, e.g. 1, 2, 3, etc./as a hexadecimal number/
> >
> >> +
> >> +gpt swap
> >> +~~~~~~~~
> >> +
> >> +Changes the names of all partitions that are named 'name1' to be
> >> 'name2', and
> >> +all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=y is
> >> +required.
> >> +
> >> +gpt verify
> >> +~~~~~~~~~~
> >> +
> >> +Sets return value $? to 0 (true) if the partition layout on the
> >> +specified disk matches the one in the provided partition string, and
> >> 1 (false)
> >> +if it does not match. If no partition string is specified, the
> >> command will
> >> +check if the disk is partitioned or not.
> >> +
> >> +gpt write
> >> +~~~~~~~~~
> >> +
> >> +(Re)writes the partition table on the disk to match the provided
> >> +partition string. It returns 0 on success or 1 on failure.
> >> +
> >> +Configuration
> >> +-------------
> >
> > All other man-pages have Configuration after Examples.
> >
> >> +
> >> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=y. To enable
> >> 'gpt
> >> +read', 'gpt swap' and 'gpt rename', you must specify
> >> CONFIG_CMD_GPT_RENAME=y.
> >> +
> >> +Examples
> >> +~~~~~~~~
> >
> > An example for gpt read would be nice.
> >
> >> +Create 6 partitions on a disk:: > +
> >> +    => setenv gpt_parts
> 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;
> >> +
> >>
> name=boot,start=4M,size=128M,bootable,type=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7,
> >> +
> >> name=rootfs,size=3072M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
> >> +
> >> name=system-data,size=512M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
> >> +        name=[ext],size=-,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
> >> +        name=user,size=-,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
> >> +
> >> name=modules,size=100M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
> >> +        name=ramdisk,size=8M,type=0fc63daf-8483-4772-8e79-3d69d8477de4
> >> +    => gpt write mmc 0 $gpt_parts
> >
> > There is a starting single quotation mark, but I don't see an ending
> > single quotation mark.
> >
> > White-space is not allowed before 'name='. As ugly as it is, please, put
> > the whole setenv command into a single line.
> >
> > You cannot use a comma before name=. It must be a semicolon.
> >
> > Looking at the code the sequence in the partition descriptors seems to
> > be wrong. It should be
> >
> > uuid (optional if CONFIG_RANDOM_UUID=y),
> > type (optional, only usable for CONFIG_PARTITION_TYPE_GUID=y),
> > name (mandatory),
> > size (mandatory),
> > start (optional),
> > bootable (optional).
> > .
> > Please, use a command that you have actually tested and copy it
> > verbatim. sandbox_defconfig has a host bind command to attach a file as
> > drive. That makes testing easy.
> >
> >> +
> >> +
> >> +Verify that the device matches the partition layout described in the
> >> variable
> >> +$gpt_parts::
> >> +
> >> +    => gpt verify mmc 0 $gpt_parts
> >
> > How about adding output here:
> >
> > => gpt verify mmc 0 $gpt_parts; echo $?
> > 0
> >
> > Best regards
> >
> > Heinrich
> >
> >> +
> >> +
> >> +Get the information about the partition named 'rootfs'::
> >> +
> >> +    => gpt setenv mmc 0 rootfs
> >> +    => echo ${gpt_partition_addr}
> >> +    2000
> >> +    => echo ${gpt_partition_size}
> >> +    14a000
> >> +    => echo ${gpt_partition_name}
> >> +    rootfs
> >> +    => echo ${gpt_partition_entry}
> >> +    2
> >> +
> >> +Get the list of partition names on the disk::
> >> +
> >> +    => gpt enumerate
> >> +    => echo gpt_partition_list
> >> +    boot rootfs system-data [ext] user modules ramdisk
> >> +
> >> +
> >> +Get the GUID for a disk::
> >> +
> >> +    => gpt guid mmc 0
> >> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> >> +    => gpt guid mmc gpt_disk_uuid
> >> +    => echo ${gpt_disk_uuid}
> >> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> >> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> >> index f45a7f5502..fa702920fa 100644
> >> --- a/doc/usage/index.rst
> >> +++ b/doc/usage/index.rst
> >> @@ -66,6 +66,7 @@ Shell commands
> >>      cmd/for
> >>      cmd/fwu_mdata
> >>      cmd/gpio
> >> +   cmd/gpt
> >>      cmd/host
> >>      cmd/imxtract
> >>      cmd/load
> >
>
>
