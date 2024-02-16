Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC567C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 14:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFAE87E21;
	Fri, 16 Feb 2024 15:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="VEKbQE0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7C987E46; Fri, 16 Feb 2024 15:17:39 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA5D487E1D
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 15:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1bbcb9ab-ccd6-11ee-99a2-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1bbcb9ab-ccd6-11ee-99a2-005056999439;
 Fri, 16 Feb 2024 15:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=0v7KQiq88sgbh4HYY2psRHNk/Hp5VA32nOoZSJqkFZY=;
 b=VEKbQE0vs1BM4CTgG/Ocg3X6QXhTLCby4m9ATN+3mpwNZkSlU+lsYL9OY2Gx1GE4a9dvXRuhs/Ak3
 NpSkYxEhLb7aLT8GMgdepAm8R8cTr681CqosJcvYhtDn4MeuZzTXMX4YYaLgmvIY9y364qLR1xuncA
 vLi6Bk7VMEidfD6mGsAeWI+QOdf7z3L3ffnfkPn83VDvgim4b5rkGnCrfdrbdJ5j1Mq3Lp8RhB6uho
 3m/f9s36ABUIn9TjRngvDf/udBLRPXICCu/Y7UIy3rZVQjBJogz408SLwCqkxehHR8aq2yIlu0hgxk
 vtfTHdS22oCo6G57PNN2dE4TMtFLK8w==
X-KPN-MID: 33|2Zo4CSYPcpkBjYIE91fuQBjIDpsrYciYUrL9slEkj4Ar/cjZXU7/gRYy3+XxVud
 QWxzVm41uxYP4xl7mx1jraNSeWoQX8k0B6Lm+sLMt5rM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CcmANyxIZqi13GCSUDdAMVm3U/NaQ4s8KKRmjlDnukYbQtGvfgjCWsdFCoHvD5i
 icJm4ZGjldJh3cuIgyCHw3A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1fabbc4f-ccd6-11ee-8951-00505699d6e5;
 Fri, 16 Feb 2024 15:17:32 +0100 (CET)
Date: Fri, 16 Feb 2024 15:17:32 +0100
Message-Id: <875xyoo5mr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
In-Reply-To: <E6C02326-1F4B-446E-86F3-93AACE34814E@gmx.de> (message from
 Heinrich Schuchardt on Fri, 16 Feb 2024 00:38:25 +0100)
Subject: Re: [PATCH] efi_loader: Don't carve out memory reservations too early
References: <20240215232534.61854-1-kettenis@openbsd.org>
 <E6C02326-1F4B-446E-86F3-93AACE34814E@gmx.de>
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

> Date: Fri, 16 Feb 2024 00:38:25 +0100
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> Am 16. Februar 2024 00:25:34 MEZ schrieb Mark Kettenis <kettenis@openbsd.org>:
> >Moving the efi_carve_out_dt_rsv() call in commit 1be415b21b2d
> >("efi_loader: create memory reservations in ACPI case")
> >broke boards that create additional memory reservations in
> >ft_board_setup() since it is now called before those additional
> >memory reservations are made.  This is the case for the rk3588
> >boards and breaks booting OpenBSD on those boards.
> >
> >Move the call back to its original location and add a call in
> >the code path used for ACPI.
> >
> >Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI case")
> >Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> >---
> > lib/efi_loader/efi_helper.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >index 5dd9cc876e..58761fae78 100644
> >--- a/lib/efi_loader/efi_helper.c
> >+++ b/lib/efi_loader/efi_helper.c
> >@@ -456,11 +456,11 @@ efi_status_t efi_install_fdt(void *fdt)
> > 		return EFI_LOAD_ERROR;
> > 	}
> > 
> >-	/* Create memory reservations as indicated by the device tree */
> >-	efi_carve_out_dt_rsv(fdt);
> >-
> >-	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
> >+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
> >+		/* Create memory reservations as indicated by the device tree */
> 
> Imagine booting the rk3588 board with ACPI.

I'd rather not, thank you ;)

> Wouldn't we miss creating the ft_board_setup() reservations before
> efi_carve_out_dt_rsv(fdt)?

Yes.  And arguably the these memory reservations should be made way
earlier, at the the time that efi_memory_init() runs.  I think we're
just lucky that efi_allocate_pages() doesn't hand us memory from these
areas in copy_fdt().

Better ideas?


> >+		efi_carve_out_dt_rsv(fdt);
> > 		return EFI_SUCCESS;
> >+	}
> > 
> > 	/* Prepare device tree for payload */
> > 	ret = copy_fdt(&fdt);
> >@@ -474,6 +474,9 @@ efi_status_t efi_install_fdt(void *fdt)
> > 		return EFI_LOAD_ERROR;
> > 	}
> > 
> >+	/* Create memory reservations as indicated by the device tree */
> >+	efi_carve_out_dt_rsv(fdt);
> >+
> > 	efi_try_purge_kaslr_seed(fdt);
> > 
> > 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> 
