Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A797C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 20:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8185A87F47;
	Mon, 26 Feb 2024 21:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Q57MLIBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E4D87F49; Mon, 26 Feb 2024 21:36:36 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBAB87F3B
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 21:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a29b6e55-d4e6-11ee-b64d-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a29b6e55-d4e6-11ee-b64d-005056994fde;
 Mon, 26 Feb 2024 21:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=Jp3gqJOWOXyvFUptR25rsuAzd7h5QOpHDW9ZOQEIQJY=;
 b=Q57MLIBjil5csf+/etTn0XOHooTRQ0k+Fa15+bi4XqBwVJVt181DDnnmVApOM1dbaJ0BWpiN2qWO6
 R1oDasUlkQGMfs1D8XdWjc5rtv8yGfKxTcvcUA+WsYy5iK9Li59bOvs6aWBhAmdPG6W9Tegdpz4KfW
 FB+fjnYBPDnu8DigbiQ6VL/u2C0IA9tZST9Tc+z/UYRJXFClR9hIj815xcz+Z+3jD121FiseSTGlei
 CnNxpcucdsmdFJWgywfew5HihjspNSx+h26SdSwyt4x4xYVU8EiHE7g/ETj9L3jFnlKBw6mBrEIZw1
 A/6mP3RaQYlzy1A7H6EMVlc0oAAIwrg==
X-KPN-MID: 33|iqGSaUVgZBPhELbfjIGcvJfqhw/ADanXozyhsEOtzi0YxpOHrLHFFmyesYPOKXF
 zbU1x/hDAjafi8EMnxfPanw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|m6/x+ra6+icjPPYPsPqEsDXXypfG9fv+/AzlpQna33dwGVWKOo8FLhB8JREKdA8
 31zyceNUTEdHFztLj7A4vRA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id bab09096-d4e6-11ee-9e84-00505699772e;
 Mon, 26 Feb 2024 21:36:34 +0100 (CET)
Date: Mon, 26 Feb 2024 21:36:33 +0100
Message-Id: <877cirj73i.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
In-Reply-To: <d0a7c8f9-70ed-496c-9905-53e300dc65c7@gmx.de> (message from
 Heinrich Schuchardt on Sat, 17 Feb 2024 12:02:56 +0100)
Subject: Re: [PATCH] efi_loader: Don't carve out memory reservations too early
References: <20240215232534.61854-1-kettenis@openbsd.org>
 <E6C02326-1F4B-446E-86F3-93AACE34814E@gmx.de>
 <875xyoo5mr.fsf@bloch.sibelius.xs4all.nl>
 <d0a7c8f9-70ed-496c-9905-53e300dc65c7@gmx.de>
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

> Date: Sat, 17 Feb 2024 12:02:56 +0100
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Hi Heinrich,

> On 2/16/24 3:17 PM, Mark Kettenis wrote:
> >> Date: Fri, 16 Feb 2024 00:38:25 +0100
> >> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>
> >> Am 16. Februar 2024 00:25:34 MEZ schrieb Mark Kettenis <kettenis@openbsd.org>:
> >>> Moving the efi_carve_out_dt_rsv() call in commit 1be415b21b2d
> >>> ("efi_loader: create memory reservations in ACPI case")
> >>> broke boards that create additional memory reservations in
> >>> ft_board_setup() since it is now called before those additional
> >>> memory reservations are made.  This is the case for the rk3588
> >>> boards and breaks booting OpenBSD on those boards.
> >>>
> >>> Move the call back to its original location and add a call in
> >>> the code path used for ACPI.
> >>>
> >>> Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI case")
> >>> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> >>> ---
> >>> lib/efi_loader/efi_helper.c | 11 +++++++----
> >>> 1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >>> index 5dd9cc876e..58761fae78 100644
> >>> --- a/lib/efi_loader/efi_helper.c
> >>> +++ b/lib/efi_loader/efi_helper.c
> >>> @@ -456,11 +456,11 @@ efi_status_t efi_install_fdt(void *fdt)
> >>> 		return EFI_LOAD_ERROR;
> >>> 	}
> >>>
> >>> -	/* Create memory reservations as indicated by the device tree */
> >>> -	efi_carve_out_dt_rsv(fdt);
> >>> -
> >>> -	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
> >>> +	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
> >>> +		/* Create memory reservations as indicated by the device tree */
> >>
> >> Imagine booting the rk3588 board with ACPI.
> >
> > I'd rather not, thank you ;)
> >
> >> Wouldn't we miss creating the ft_board_setup() reservations before
> >> efi_carve_out_dt_rsv(fdt)?
> >
> > Yes.  And arguably the these memory reservations should be made way
> > earlier, at the the time that efi_memory_init() runs.  I think we're
> > just lucky that efi_allocate_pages() doesn't hand us memory from these
> > areas in copy_fdt().
> >
> > Better ideas?
> >
> 
> image_setup_libfdt(&img, fdt, NULL) must be called before
> efi_carve_out_dt_rsv().
> 
> Could you, please, add this call in this path, too. Otherwise the patch
> looks correct.

Yes I can.  Just sent out v2.

Thanks,

Mark


> >
> >>> +		efi_carve_out_dt_rsv(fdt);
> >>> 		return EFI_SUCCESS;
> >>> +	}
> >>>
> >>> 	/* Prepare device tree for payload */
> >>> 	ret = copy_fdt(&fdt);
> >>> @@ -474,6 +474,9 @@ efi_status_t efi_install_fdt(void *fdt)
> >>> 		return EFI_LOAD_ERROR;
> >>> 	}
> >>>
> >>> +	/* Create memory reservations as indicated by the device tree */
> >>> +	efi_carve_out_dt_rsv(fdt);
> >>> +
> >>> 	efi_try_purge_kaslr_seed(fdt);
> >>>
> >>> 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> >>
> >
> 
> 
