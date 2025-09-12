Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB53CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 19:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2C5833E9;
	Fri, 12 Sep 2025 21:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIp3QvU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1041D833BF; Fri, 12 Sep 2025 21:23:10 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A46833E9
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 21:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso4537042a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757704982; x=1758309782; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mEmbnfjchqwchoV8SNQSahGIxe1Frpm7kri+rLv1M0=;
 b=fIp3QvU4e2nB+x35JvgQ24mkBZpor0HURINY5/p9epjt1FIywCPXtIkbbLsjt8jTwX
 QlK1fGsnRwNDxh0VT2DnThRzWNoNBRjSRtRWZnqe7/RnYK8SwFLLJTP6SwBOgHCr9RiE
 prScLkLJLYDm8ZDPEyq7o/nu+9c7ljYXjAP+JhQdVbS7WRNNygKONaKA0lhZWErhbc6B
 jr+FhDAok6lQUEICuyE/ia+pRASDXzg6jLzFKwM/wx0UuXJ40NAOELji2k5IWzqchQFd
 r4EcR8PDPLHJUarEt5zt5WnitMN2O+caY0oq7XPuWGamIsX8LmvEUlVn6FOifbiBynTB
 d9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757704982; x=1758309782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mEmbnfjchqwchoV8SNQSahGIxe1Frpm7kri+rLv1M0=;
 b=qMgDj1LzVO373rrf6UaU775YB54209G/9f8Bs4rmXIQgXjC2GpI58yiGC2fY5nwzTA
 n/kaeTbyDXLVmM7Zmev3N+1xq4ipddz2B0nDKx/zNBc9VUg5pm2ywK77aq+wCxcSfcI8
 XkhHhxhBvOZvzRIO0BsLl8ua5DifSGjKkNhU2H8cRkw0u4tyYYvc6RgJKhTqv1aNzq5s
 agxWOcTj+CrV40eHYebnPGmXDc4RQ+FcnpwgmhHQrCSshzvTZ4M/57ga5j3VZ4HQta7A
 b8irsJyroXmCLIwsNaaCir7DJbR5OynZieRTQ6ByHhKisjkYdpe30ZzscAVIptc3rXEj
 I8XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkLzwKMf6ABBbmHxRN+XcWIBNCKIRd388Tsi+HeFeoW1nFNYfXOobU32g3M9NiUSpxwgr9KsM=@lists.denx.de
X-Gm-Message-State: AOJu0YxaPM4pbo3es5wGFIjmYJDVZP257U+bYGMlXI4nRr+VMPprCzve
 HW7e57WqtrY8kYPDWq5itZJsUDLN1Rq5i40fgkjkCbEVDvx5cyPy0djRgANbRfa4Pux0fd1EYty
 qt4DRIMkE0/KKEnhOLI/yA71h3jFLxgAbLw==
X-Gm-Gg: ASbGncui5WYoCtP3T0BjOmI2lLYAFLbNZWfJlZVkM4niNJL7sQzzssMcaAJ6+v/wdTa
 qOVZCs+sXdfPBd4Lcig+IsC9Po1q9qSYRWH5QgTBRqzarWU3Z/SkIQYLQyniz9grPjrIfzPq8pM
 FLLyINADAcNgcI4VPbs2WXP9YWJ24/tNxXmRMsMLx+7uqcxm2oyG1WB5es2ahMEVxlvsUk4LoIl
 jXN/rVSu/rcAxe/cFQ=
X-Google-Smtp-Source: AGHT+IFE6Ok8v8AnBBy+Y901fASQHW6LR5MD4Ej2I6PTO8m1rT3ur+dqeYlPgQIqVzs5xzs676xjtisN0W9y9ca3/Zc=
X-Received: by 2002:a05:6402:3593:b0:627:5841:7ae1 with SMTP id
 4fb4d7f45d1cf-62ed82b968amr3953439a12.21.1757704982104; Fri, 12 Sep 2025
 12:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250912045352.18856-1-mibodhi@gmail.com>
 <DCQURPCT4OE0.3KPUIUT5R243J@ti.com>
In-Reply-To: <DCQURPCT4OE0.3KPUIUT5R243J@ti.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 12 Sep 2025 12:22:50 -0700
X-Gm-Features: AS18NWDKazBweV5lzyIn4YIkd3yVmVyST6l5fDxG5pEHoHDqyMmKn55NnjX-zUA
Message-ID: <CAJaLiFy6pHjtdYQpR7+aa_CLBknxqKN95F8ahy8U0yojFw326w@mail.gmail.com>
Subject: Re: [PATCH] doc: usage: Add File System section and Ext4 documentation
To: Anshul Dalal <anshuld@ti.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fiona Klute <fiona.klute@gmx.de>, Harsha Vardhan V M <h-vm@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Rasmus Villemoes <ravi@prevas.dk>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Anshul,

On Fri, Sep 12, 2025 at 6:23=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wrote=
:
>
> Hi Tony,
>
> On Fri Sep 12, 2025 at 10:19 AM IST, Tony Dinh wrote:
> > Create doc/usage/filesystems/ section.
> > Convert doc/README.ext4 to rST format and move it to the new section.
> > Update documentation to add configuration instruction for Ext4 Write
> > when using large partitions.
> >
> > Note that this patch depends on this previous patch:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250910215702.15576-1=
-mibodhi@gmail.com/
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  .../filesystems/ext4.rst}                     | 55 +++++++++++++++----
> >  doc/usage/index.rst                           |  8 +++
> >  2 files changed, 53 insertions(+), 10 deletions(-)
> >  rename doc/{README.ext4 =3D> usage/filesystems/ext4.rst} (79%)
> >
> > diff --git a/doc/README.ext4 b/doc/usage/filesystems/ext4.rst
> > similarity index 79%
> > rename from doc/README.ext4
> > rename to doc/usage/filesystems/ext4.rst
> > index ca9f19953d2..18e45045344 100644
> > --- a/doc/README.ext4
> > +++ b/doc/usage/filesystems/ext4.rst
> > @@ -1,9 +1,22 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Ext4 File System
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +--------
> > +
> >  U-Boot supports access of both ext2 and ext4 filesystems, either in re=
ad-only
> >  mode or in read-write mode.
> >
> > +Configuration
> > +-------------
> > +
> >  First, to enable support for both ext4 (and, automatically, ext2 as we=
ll),
> >  but without selecting the corresponding commands, enable one of the fo=
llowing:
> >
> > +::
> > +
> >    CONFIG_FS_EXT4     (for read-only)
> >    CONFIG_EXT4_WRITE  (for read-write)
> >
> > @@ -20,22 +33,28 @@ or ext4-related commands:
> >
> >  use one or both of:
> >
> > -  CONFIG_CMD_EXT2
> > -  CONFIG_CMD_EXT4
> > +::
> > +
> > +     CONFIG_CMD_EXT2
> > +     CONFIG_CMD_EXT4
> >
> >  Selecting either of the above automatically selects CONFIG_FS_EXT4 if =
it
> >  wasn't enabled already.
> >
> >  In addition, to get the write access command "ext4write", enable:
> >
> > -  CONFIG_CMD_EXT4_WRITE
> > +::
> > +
> > +     CONFIG_CMD_EXT4_WRITE
> >
> >  which automatically selects CONFIG_EXT4_WRITE if it wasn't defined
> >  already.
> >
> >  Also relevant are the generic filesystem commands, selected by:
> >
> > -  CONFIG_CMD_FS_GENERIC
> > +::
> > +
> > +     CONFIG_CMD_FS_GENERIC
> >
> >  This does not automatically enable EXT4 support for you, you still nee=
d
> >  to do that yourself.
> > @@ -44,6 +63,8 @@ Lastly, the current u-boot implementation for Ext4 wr=
ite requires a lot
> >  of memory to run successfully. The following enable support for
> >  large Ext4 partitions:
> >
> > +::
> > +
> >       CONFIG_EXT4_MAX_JOURNAL_ENTRIES
> >       CONFIG_SYS_MALLOC_LEN
> >
> > @@ -51,10 +72,15 @@ The number of journal entries and dynamic memory al=
location are proportional
> >  to the partition capacity. For example, an ext4 4TB HDD partition coul=
d
> >  require approximately 500 entries and more than 128 MB heap space.
> >
> > +Examples
> > +--------
> > +
> >  Some sample commands to test ext4 support:
> >
> >  1. Check that the commands can be seen in the output of U-Boot help:
> >
> > +::
> > +
> >       UBOOT #help
> >       ...
> >       ext4load- load binary file from a Ext4 file system
> > @@ -65,6 +91,8 @@ Some sample commands to test ext4 support:
> >
> >  2. To list the files in an ext4-formatted partition, run:
> >
> > +::
> > +
> >       ext4ls <interface> <dev[:part]> [directory]
> >
> >       For example:
> > @@ -72,6 +100,8 @@ Some sample commands to test ext4 support:
> >
> >  3. To read and load a file from an ext4-formatted partition to RAM, ru=
n:
> >
> > +::
> > +
> >       ext4load <interface> <dev[:part]> [addr] [filename] [bytes]
> >
>
> The command usage has updated to:
>
> ext4load <interface> [<dev[:part]> [addr [filename [bytes [pos]]]]]
>
> >       For example:
> > @@ -79,16 +109,21 @@ Some sample commands to test ext4 support:
> >
> >  4. To write a file to an ext4-formatted partition.
> >
> > +::
> > +
> >       a) First load a file to RAM at a particular address for example 0=
x30007fc0.
> >       Now execute ext4write command:
> >       ext4write <interface> <dev[:part]> [filename] [Address] [sizebyte=
s]
> >
>
> This is an outdated format for ext4write, currently it's addr, filename
> and then size.
>
> >       For example:
> > -     UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 6183120
> > -     (here 6183120 is the size of the file to be written)
> > +     UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 0x5E58D0
> > +     (here 0x5E58D0 is the size of the file to be written,
> > +     which was output by the ext4load command)
> >       Note: Absolute path is required for the file to be written
>
> IMO, all the code blocks with U-Boot's console output in the 'Examples'
> should only have text that user should expect during a regular usage,
> all comments should be outside the code block as plain text. Like
> follows:
>
> The ``ext4write`` command can be used to write to an ext4
> partition as follows:
>
> ::
>
>         ext4write <interface> <dev[:part]> <addr> <absolute filename path=
> [sizebytes] [file offset]
>
> For example to write a file loaded at 0x8200000 of size 256 bytes to an
> ext4-formatted partition with the filename ``/boot/sample_file.hex``:
>
> ::
>
>   =3D> ext4write mmc 2:2 0x82000000 /boot/sample_file.hex 0x100
>   256 bytes written in 138 ms (1000 Bytes/s)
>
> Regards,
> Anshul

Thanks! I'll send V2 patch.

All the best,
Tony
