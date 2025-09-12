Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07140CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E792833EB;
	Fri, 12 Sep 2025 15:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SHgp6yhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0193833F9; Fri, 12 Sep 2025 15:23:55 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3021783285
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CDNbkr526057;
 Fri, 12 Sep 2025 08:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757683417;
 bh=RNxnfPUgYJxN4w5uGZNHVkV8R29jyBY3wZUCYDXMG0o=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=SHgp6yhl9UUTBtL77LpcFEgJNmjqfcSPtsTcYGt7OG6MCHGHxKF8COnzqgfbRVUNa
 /zY1L8JP30SkTJoNyrt373Qq4B7r1iHdEZqzwe6OvZUZMspzaTzQDlst89mij5RoWO
 WZp+2XJvmXdtwTul4SUwoLjrJ5MNuWtrr4slOs8k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CDNaep1882669
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 08:23:36 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 08:23:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 08:23:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CDNYke3655543;
 Fri, 12 Sep 2025 08:23:35 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Sep 2025 18:53:34 +0530
Message-ID: <DCQURPCT4OE0.3KPUIUT5R243J@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Fiona Klute <fiona.klute@gmx.de>, "Harsha
 Vardhan V M" <h-vm@ti.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, "Rasmus Villemoes" <ravi@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH] doc: usage: Add File System section and Ext4 documentation
From: Anshul Dalal <anshuld@ti.com>
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250912045352.18856-1-mibodhi@gmail.com>
In-Reply-To: <20250912045352.18856-1-mibodhi@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Tony,

On Fri Sep 12, 2025 at 10:19 AM IST, Tony Dinh wrote:
> Create doc/usage/filesystems/ section.
> Convert doc/README.ext4 to rST format and move it to the new section.
> Update documentation to add configuration instruction for Ext4 Write
> when using large partitions.
>
> Note that this patch depends on this previous patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20250910215702.15576-1-m=
ibodhi@gmail.com/
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  .../filesystems/ext4.rst}                     | 55 +++++++++++++++----
>  doc/usage/index.rst                           |  8 +++
>  2 files changed, 53 insertions(+), 10 deletions(-)
>  rename doc/{README.ext4 =3D> usage/filesystems/ext4.rst} (79%)
>
> diff --git a/doc/README.ext4 b/doc/usage/filesystems/ext4.rst
> similarity index 79%
> rename from doc/README.ext4
> rename to doc/usage/filesystems/ext4.rst
> index ca9f19953d2..18e45045344 100644
> --- a/doc/README.ext4
> +++ b/doc/usage/filesystems/ext4.rst
> @@ -1,9 +1,22 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Ext4 File System
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
>  U-Boot supports access of both ext2 and ext4 filesystems, either in read=
-only
>  mode or in read-write mode.
> =20
> +Configuration
> +-------------
> +
>  First, to enable support for both ext4 (and, automatically, ext2 as well=
),
>  but without selecting the corresponding commands, enable one of the foll=
owing:
> =20
> +::
> +
>    CONFIG_FS_EXT4	(for read-only)
>    CONFIG_EXT4_WRITE	(for read-write)
> =20
> @@ -20,22 +33,28 @@ or ext4-related commands:
> =20
>  use one or both of:
> =20
> -  CONFIG_CMD_EXT2
> -  CONFIG_CMD_EXT4
> +::
> +
> +	CONFIG_CMD_EXT2
> +	CONFIG_CMD_EXT4
> =20
>  Selecting either of the above automatically selects CONFIG_FS_EXT4 if it
>  wasn't enabled already.
> =20
>  In addition, to get the write access command "ext4write", enable:
> =20
> -  CONFIG_CMD_EXT4_WRITE
> +::
> +
> +	CONFIG_CMD_EXT4_WRITE
> =20
>  which automatically selects CONFIG_EXT4_WRITE if it wasn't defined
>  already.
> =20
>  Also relevant are the generic filesystem commands, selected by:
> =20
> -  CONFIG_CMD_FS_GENERIC
> +::
> +
> +	CONFIG_CMD_FS_GENERIC
> =20
>  This does not automatically enable EXT4 support for you, you still need
>  to do that yourself.
> @@ -44,6 +63,8 @@ Lastly, the current u-boot implementation for Ext4 writ=
e requires a lot
>  of memory to run successfully. The following enable support for
>  large Ext4 partitions:
> =20
> +::
> +
>  	CONFIG_EXT4_MAX_JOURNAL_ENTRIES
>  	CONFIG_SYS_MALLOC_LEN
> =20
> @@ -51,10 +72,15 @@ The number of journal entries and dynamic memory allo=
cation are proportional
>  to the partition capacity. For example, an ext4 4TB HDD partition could
>  require approximately 500 entries and more than 128 MB heap space.
> =20
> +Examples
> +--------
> +
>  Some sample commands to test ext4 support:
> =20
>  1. Check that the commands can be seen in the output of U-Boot help:
> =20
> +::
> +
>  	UBOOT #help
>  	...
>  	ext4load- load binary file from a Ext4 file system
> @@ -65,6 +91,8 @@ Some sample commands to test ext4 support:
> =20
>  2. To list the files in an ext4-formatted partition, run:
> =20
> +::
> +
>  	ext4ls <interface> <dev[:part]> [directory]
> =20
>  	For example:
> @@ -72,6 +100,8 @@ Some sample commands to test ext4 support:
> =20
>  3. To read and load a file from an ext4-formatted partition to RAM, run:
> =20
> +::
> +
>  	ext4load <interface> <dev[:part]> [addr] [filename] [bytes]
> =20

The command usage has updated to:

ext4load <interface> [<dev[:part]> [addr [filename [bytes [pos]]]]]

>  	For example:
> @@ -79,16 +109,21 @@ Some sample commands to test ext4 support:
> =20
>  4. To write a file to an ext4-formatted partition.
> =20
> +::
> +
>  	a) First load a file to RAM at a particular address for example 0x30007=
fc0.
>  	Now execute ext4write command:
>  	ext4write <interface> <dev[:part]> [filename] [Address] [sizebytes]
> =20

This is an outdated format for ext4write, currently it's addr, filename
and then size.

>  	For example:
> -	UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 6183120
> -	(here 6183120 is the size of the file to be written)
> +	UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 0x5E58D0
> +	(here 0x5E58D0 is the size of the file to be written,
> +	which was output by the ext4load command)
>  	Note: Absolute path is required for the file to be written

IMO, all the code blocks with U-Boot's console output in the 'Examples'
should only have text that user should expect during a regular usage,
all comments should be outside the code block as plain text. Like
follows:

The ``ext4write`` command can be used to write to an ext4
partition as follows:

::

	ext4write <interface> <dev[:part]> <addr> <absolute filename path> [sizeby=
tes] [file offset]

For example to write a file loaded at 0x8200000 of size 256 bytes to an
ext4-formatted partition with the filename ``/boot/sample_file.hex``:

::

  =3D> ext4write mmc 2:2 0x82000000 /boot/sample_file.hex 0x100
  256 bytes written in 138 ms (1000 Bytes/s)

Regards,
Anshul
