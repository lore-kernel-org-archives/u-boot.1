Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6307D30006
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEFB88FB9;
	Fri, 18 Oct 2024 15:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="qBwXaIZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D0488FBA; Fri, 18 Oct 2024 15:11:28 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB9088D47
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 095D5148AC13; Fri, 18 Oct 2024 15:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729257086; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Jh+pWc88OJbme/PpZal2QO3omVvP9asa+zrWpG4k1Fs=;
 b=qBwXaIZ7PmqE4sEqOyd54dVIErq5to1TCH7WBiO8pmKNvfh+/KMmqNJ4tkarKuYJPqgKMM
 YKxnJk+ccBvUsuiLCKXqvgNgm0uZvuOk3NNTIfopDCMO9ZGD7lbsrvpCkQP8hbiFe6Bd0l
 tD1qkRfi3EenxBlWjgtmNyUPcwlvw/1Q9pzj1rurmziclMH12Fn1FQceyIPiqH6IbshYAY
 tJOZ1v3i1TP+H+jU4dZ9YkAXhdfV0lKi4zf3VBflNZGrRX/QCl9KiuK8LyqG3raCIw/sLD
 KNyyJ8j5p7A9kexSJFyRk176qugcmXlk1JEvsjVbGGwESifVrgMqXjvmTSsAVQ==
Date: Fri, 18 Oct 2024 15:11:20 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
Mail-Followup-To: Benedikt Spranger <b.spranger@linutronix.de>,
 u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Benedikt,

Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt Spranger:
> Hi,
> 
> while porting an ATSAMA5D2 based board (booting from NAND flash with UBI)
> I stumbled over generic, NAND- and UBI related asperity:
> 
> 1. tiny-printf does not handle NULL arguments to '%s' in a proper way
> 2. vtbl_check() has an useless debug output due to a typo
> 3. NAND: An informative output fails badly, if the NAND vendor is unknown
> 4. the nand_atmel driver lacks a vital initialisation
> 
> OK, you might say the nand_atmel NAND driver is obsolete, but it was the
> only solution to get booting from NAND running. The new DM based NAND driver
> refused to do anything usefull, so I dropped it after spending a couple of
> days debugging it:

Strange.  I have at least three different boards with SAMA5D27
successfully booting from NAND flash with the new DM based driver
(unfortunately none of them upstreamed, which also won't change in the
foreseeable future, sorry).

Do you use at91bootstrap as 2nd level bootloader like me or something
else?  For me it was basically getting the dts for U-Boot correct, but
I got that running with all U-Boot releases since 2023.04 up to
2024.10.  Could you share some more detail?

> <RANT>brilliant!</RANT>

Did you talk with Microchip about it?

Greets
Alex

> 
> 
> 
> regards
>     Benedikt Spranger
> 
> Benedikt Spranger (5):
>   tiny-printf: Handle NULL pointer argument to %s
>   drivers/mtd/ubispl/ubispl.c: Fix error message
>   mtd: nand: raw: Fix potential NULL pointer dereference
>   mtd: nand: Update NAND manufacturer Ids
>   mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()
> 
>  drivers/mtd/nand/raw/atmel_nand.c |  4 ++++
>  drivers/mtd/nand/raw/nand_base.c  |  8 ++++----
>  drivers/mtd/nand/raw/nand_ids.c   | 22 ++++++++++++----------
>  drivers/mtd/ubispl/ubispl.c       |  2 +-
>  include/linux/mtd/rawnand.h       | 23 +++++++++++++----------
>  lib/tiny-printf.c                 |  2 +-
>  6 files changed, 35 insertions(+), 26 deletions(-)
> 
> -- 
> 2.45.2
> 
