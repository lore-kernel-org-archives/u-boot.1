Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CDCC47BCF
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 09:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2ED83F37;
	Tue,  6 Jan 2026 10:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kz4OnlVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD8883A57; Tue,  6 Jan 2026 10:37:55 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACAA83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 10:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D782344326;
 Tue,  6 Jan 2026 09:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F0C116C6;
 Tue,  6 Jan 2026 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767692270;
 bh=HXGZpzn6VanFxbYsrVUWhYaxN40Sz3GRkivS7hIQd0U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kz4OnlVU214bmLOfbmzdAc0+88xsVJUXplXOEYUHXHR0tEFHpLPGAU08gYvrBUuw4
 RzM4AyEPADFjSMRgCPLtYZOmwHuc/OeEzwdCWK8tJ1d/XoXIUJKQ6cCsXAZIOLmOmB
 cHtY0wFA2iRqG/X3/G/8cTIWtdqwhETpw2WHWEWUwhw71czfM66z577/JpgN7+Snk4
 Db4Ii9f8SgBDuoaaLZKMvCz8nTwj7ZzIMlDU8HLJxZMYFAM9B+ZrUxQq4pbrEwXQci
 7A2cM05G1lMdnON4tj1kIBmbEOr81I7MkmMqZWZrrPaVIOaNJRizSvY1K8ghyCmIrq
 03yVoJwJB7q8g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dmitrii Merkurev <dimorinny@google.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <20260105235813.GB3416603@bill-the-cat>
References: <20260105235813.GB3416603@bill-the-cat>
Date: Tue, 06 Jan 2026 10:37:48 +0100
Message-ID: <87tswzf5eb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Tom,

On Mon, Jan 05, 2026 at 17:58, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> Here's the latest report, now that next has been merged to master. A few
> of these are oddly showing up now, despite being in older code that
> hasn't been touched and was being built before.

For fastboot, some code has been moved from mmc only support to
fb_block.c, which might explain the new errors.

See: https://lore.kernel.org/all/20251121-topic-fastboot-blk-v7-0-9589d902f=
c91@linaro.org/

>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Jan 5, 2026 at 3:24=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 15
>    - 23 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 15 of 15 defect(s)
>
> Defect Details
>
> ** CID 640423:       Control flow issues  (DEADCODE)
> /drivers/fastboot/fb_common.c: 112           in fastboot_set_reboot_flag()
>
>
> _________________________________________________________________________=
____________________
> *** CID 640423:         Control flow issues  (DEADCODE)
> /drivers/fastboot/fb_common.c: 112             in fastboot_set_reboot_fla=
g()
> 106     	}
> 107     	const char *bcb_iface =3D config_opt_enabled(CONFIG_FASTBOOT_FLA=
SH_BLOCK,
> 108     						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> 109     						   "mmc");
> 110
> 111     	if (device =3D=3D -1)
>>>>     CID 640423:         Control flow issues  (DEADCODE)
>>>>     Execution cannot reach this statement: "return -22;".

I believe coverity is wrong here.
we call config_opt_enabled() which by default returns -1 so it's
possible to have device =3D=3D -1

This can happen when both CONFIG_FASTBOOT_FLASH_BLOCK and
CONFIG_FASTBOOT_FLASH_MMC are unset.
(for example when we use CONFIG_FASTBOOT_FLASH_SPI)

> 112     		return -EINVAL;
> 113
> 114     	if (reason >=3D FASTBOOT_REBOOT_REASONS_COUNT)
> 115     		return -EINVAL;
> 116
> 117     	ret =3D bcb_find_partition_and_load(bcb_iface, device, "misc");
>

[...]

>
> ** CID 640421:       Possible Control flow issues  (DEADCODE)
> /drivers/fastboot/fb_block.c: 138           in fastboot_block_get_part_in=
fo()
>
>
> _________________________________________________________________________=
____________________
> *** CID 640421:         Possible Control flow issues  (DEADCODE)
> /drivers/fastboot/fb_block.c: 138             in fastboot_block_get_part_=
info()
> 132     					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> 133
> 134     	if (!part_name || !strcmp(part_name, "")) {
> 135     		fastboot_fail("partition not given", response);
> 136     		return -ENOENT;
> 137     	}
>>>>     CID 640421:         Possible Control flow issues  (DEADCODE)
>>>>     Execution cannot reach the expression "strcmp(interface, "")" insi=
de this statement: "if (!interface || !strcmp(i...".
> 138     	if (!interface || !strcmp(interface, "")) {
> 139     		fastboot_fail("block interface isn't provided", response);
> 140     		return -EINVAL;

I believe coverity is wrong here as well.
we call config_opt_enabled() which by default returns NULL for interface.

And when we enable CONFIG_FASTBOOT_FLASH_BLOCK,
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME will be set to "" by default:

$ rg 'FASTBOOT_FLASH_BLOCK_INTERFACE_NAME' .config
1097:CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME=3D""


> 141     	}
> 142
> 143     	*dev_desc =3D blk_get_dev(interface, device);
>

[...]

>
> ** CID 640419:       Null pointer dereferences  (REVERSE_INULL)
> /drivers/fastboot/fb_block.c: 144           in fastboot_block_get_part_in=
fo()
>
>
> _________________________________________________________________________=
____________________
> *** CID 640419:         Null pointer dereferences  (REVERSE_INULL)
> /drivers/fastboot/fb_block.c: 144             in fastboot_block_get_part_=
info()
> 138     	if (!interface || !strcmp(interface, "")) {
> 139     		fastboot_fail("block interface isn't provided", response);
> 140     		return -EINVAL;
> 141     	}
> 142
> 143     	*dev_desc =3D blk_get_dev(interface, device);
>>>>     CID 640419:         Null pointer dereferences  (REVERSE_INULL)
>>>>     Null-checking "dev_desc" suggests that it may be null, but it has =
already been dereferenced on all paths leading to the check.
> 144     	if (!dev_desc) {
> 145     		fastboot_fail("no such device", response);
> 146     		return -ENODEV;
> 147     	}

Fair enough for this one. We can check that dev_desc is not NULL to make
sure that the caller cannot call fastboot_block_get_part_info() with
NULL as second argument.

I'll submit a patch for this once I've cleared out my review queue.

> 148
> 149     	ret =3D part_get_info_by_name(*dev_desc, part_name, part_info);
>
>

[...]

For the first 2, do you want me to update the coverity database online
with these explanations?
It has been a while but I think I can do that myself.
