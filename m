Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FFAC7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8C686550;
	Thu, 24 Aug 2023 01:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jp+sDMZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D9F86504; Thu, 24 Aug 2023 01:59:30 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7B886520
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-79d8edd6d99so2250751241.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdooUZFun+f7WCEFESxAwNCN+B3d3Q3/y6fSX/NPQvI=;
 b=jp+sDMZ+GhCyVHrl37wE8B4m00FCUqTSCp/cfPElBvEPuyr42nbKB7Z7E4ywoBr+jI
 0Ox2268oE+nVov9imrK9ZeENAz0fz0LqkSqnJxEj0RWlcfGJWhM6NVZ1AMsa+64RzOB+
 Q4QD86rulmIGLfpCVgzjolgSvVmBUon8ffZPEslPRSEDs5ItbRj9MylJ4juHP0wN0yNp
 yKxYNzeXvE5l12WOmJ2rIZykpnzpzI7W8+ROp5TOxLwGIqclZfns8cynHIOT2eZBcwSG
 EAy8VjBLMyDfSGL5EkpI2RMU4GBFLvfWY+ClxIv7ryeRlTwbNmdAx3XN4R6aFV5t6emT
 NAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdooUZFun+f7WCEFESxAwNCN+B3d3Q3/y6fSX/NPQvI=;
 b=O9TrPnkZmHHzwRvpuL3Wu7mZv8BX47bXoVk07KqhVaY8E6mT/DTXKOoUNCZ4Rt+wqi
 35elO/JQtG9T10j4rijxLu4JocJL1KSMhaaMrUGDzJgWYYXrg0jhNHMABYU1oqRh7M4H
 uHh3gANzoHC+gE7W4Ozk4JvT8LpvMRdu5xzNQScyd/7z2C5h34hLe237+V7MfpfCx66J
 /yIK6EKLqpiGr4CoYEEVGK9ycqoCM5XvrPoVe76Iv0yrsCDWwJ1p9SCTrY89ZVRzHVKx
 EvqUyFmGMpFzXmYcpA1GMm/5rCpoS55M6t6uEK4q8TRF1zK5oNvyrqR9S87wGiwpDUvp
 gJQg==
X-Gm-Message-State: AOJu0YyFGlTH2niGvu2E3/8sN+XJyL1hb0mHrxP2Kl/9YhvWam6oxcdi
 mY2Kwt7+mlbb/sW1Qno1nxb+xwVtDD/5C6Yf93g6Yg==
X-Google-Smtp-Source: AGHT+IGpi8whwUnJHr8GJkuCuOCGm6TNnk4lceuV6fCq9flV8ebqLfyJJr+K+LHVe6x4276bWFwufuK82Rb3+vGv39s=
X-Received: by 2002:a67:fb15:0:b0:443:f93f:4698 with SMTP id
 d21-20020a67fb15000000b00443f93f4698mr12558004vsr.22.1692835156426; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-3-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-3-JPEWhacker@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 17:57:40 -0600
Message-ID: <CAPnjgZ1Pptf97JeVDaUA=QFgqWtyG6L-Zkiu8+LLgHYVT-wBBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] doc: Add gpt command documentation
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Joshua,

On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds initial documentation for the gpt command
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  doc/usage/cmd/gpt.rst | 139 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 doc/usage/cmd/gpt.rst
>
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> new file mode 100644
> index 0000000000..ea2cf73a60
> --- /dev/null
> +++ b/doc/usage/cmd/gpt.rst
> @@ -0,0 +1,139 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +gpt command
> +===========
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    gpt repair <interface> <device no>
> +    gpt write <interface> <device no> <partition string>
> +    gpt verify <interface> <device no> <partition string>
> +    gpt setenv <interface> <device no> <partition name>
> +    gpt enumerate <interface> <device no>
> +    gpt guid <interface> <device no> [<varname>]
> +    gpt read <interface> <device no> [<varname>]
> +    gpt swap <interface> <dev> <name1> <name2>
> +    gpt rename <interface> <dev> <part> <name>
> +
> +Description
> +-----------
> +
> +The gpt command lets users read, create, modify, or verify the GPT (GUID
> +Partition Table) partition layout.
> +
> +The syntax of the text description of the partition list is similar to

By 'text description' do you mean '<partition string>' ?

> +the one used by the 'mbr' command.

OK, but I think you need to show the string  as a list of
semicolon-separated components (or whatever) and then describe them.
As written, this is quite confusing.

> +
> +The partition list may start with a set of parameters for the whole disk:
> +
> +* uuid_disk (the UUID of the disk)
> +
> +Following the disk parameters, partitions are specified separated by a ';'.
> +Supported partition parameters are:
> +
> +* name (required)
> +* start (required, partition start offset in bytes)
> +* size (in bytes or '-' to expand it to the whole free area)
> +* bootable (boolean flag)
> +* uuid (partition UUID, optional if CONFIG_RANDOM_UUID=y is enabled)
> +* type (partition type GUID, requires CONFIG_PARTITION_TYPE_GUID=y)
> +
> +Here is an example how to create a 6 partitions, some of the predefined sizes:
> +
> +::
> +
> +    => setenv gpt_parts 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;
> +        name=boot,start=4M,size=128M,bootable,type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7,
> +        name=rootfs,size=3072M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
> +        name=system-data,size=512M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
> +        name=[ext],size=-,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
> +        name=user,size=-,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
> +        name=modules,size=100M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
> +        name=ramdisk,size=8M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +    => gpt write mmc 0 $gpt_parts

Please use lower-case hex

> +
> +
> +If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a random UUID
> +will be generated for the partition
> +
> +The 'gpt verify' command returns 0 if the layout matches the one on the storage
> +device or 1 if not. To check if the layout on the MMC #0 storage device
> +matches the provided text description one has to issue following command:
> +
> +::
> +
> +    => gpt verify mmc 0 $gpt_parts
> +
> +The verify sub-command is especially useful in the system update scripts:
> +
> +::
> +
> +    => if gpt verify mmc 0 $gpt_parts; then
> +         echo GPT layout needs to be updated
> +         ...
> +       fi
> +
> +The 'gpt write' command returns 0 on success write or 1 on failure.
> +
> +The 'gpt setenv' command will set a series of environment variables with
> +information about a particular partition. The variables are:
> +
> +* gpt_partition_addr (the starting offset of the partition, in hexadecimal blocks)
> +* gpt_partition_size (the size of the partition, in hexadecimal blocks)
> +* gpt_partition_name (the name of the partition)
> +* gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3, etc.)
> +
> +To get the information about the partition named 'rootfs', issue the following
> +command:
> +
> +::
> +    => gpt setenv mmc 0 rootfs
> +    => echo ${gpt_partition_addr}
> +    2000
> +    => echo ${gpt_partition_size}
> +    14a000
> +    => echo ${gpt_partition_name}
> +    rootfs
> +    => echo ${gpt_partition_entry}
> +    2
> +
> +The 'gpt enumerate' command will set the variable 'gpt_partition_list' with the
> +list of partition names on the device. For example:
> +
> +::
> +    => gpt enumerate
> +    => echo gpt_partition_list
> +    boot rootfs system-data [ext] user modules ramdisk
> +
> +The 'gpt guid' command will report the GUID of a disk. If 'varname' is
> +specified, the command will set the variable to the GUID, otherwise it will be
> +printed out. For example:
> +
> +::
> +    => gpt guid mmc 0
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> +    => gpt guid mmc gpt_disk_uuid
> +    => echo ${gpt_disk_uuid}
> +    bec9fc2a-86c1-483d-8a0e-0109732277d7
> +
> +The 'gpt read' command will print out the current state of the GPT partition
> +table. If 'varname' is specified, the variable will be filled with a partition
> +string as described above that is suitable for passing to other 'gpt' commands.
> +If omitted, a human readable description is printed out.
> +CONFIG_CMD_GPT_RENAME=y is required.
> +
> +The 'gpt swap' command changes the names of all partitions that are named
> +'name1' to be 'name2', and all partitions named 'name2' to be 'name1'.
> +CONFIG_CMD_GPT_RENAME=y is required.
> +
> +The 'gpt rename' command renames all partitions named 'part' to be 'name1'.
> +CONFIG_CMD_GPT_RENAME=y is required.
> +
> +Configuration
> +-------------
> +
> +To use the 'gpt' command you must specify CONFIG_CMD_GPT=y. To enable 'gpt
> +read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_RENAME=y.
> --
> 2.33.0
>

Great docs thank you!


- Simon
