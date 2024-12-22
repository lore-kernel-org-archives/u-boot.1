Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF30E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 12:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C2980562;
	Sun, 22 Dec 2024 13:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="l0yQ62oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F08C8056A; Sun, 22 Dec 2024 13:54:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A5480435
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 13:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734872072; x=1735476872; i=xypron.glpk@gmx.de;
 bh=ae/EJPeCnEhoeOKGIeJn5eIQ9n05W6U8LaINbepsL08=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l0yQ62oawMrAIf/S6au2tl1o1p2Vb61pOGtgoPPLpdEKlvPfzzt7+n97iNfXkzor
 5Pc6u++i6HRTS57Y+zcPq8Umm+PibHM7IxvcqW54sEOcunSOyQH0Keh8bZVcn78O8
 4j5pvv/Xg8BpOZv8LZOd07fRlLiI2YaP5f6GCkwl2pnSCmrKrJYcRC81P7hPByFns
 bMbOtCRJ+oBTeUWT+CYPA/O5083yD6SDq/du7QGW6VRxQ42snwjR4ghXufOlVPgUv
 yy5vcbstgOrA5p7kOXyYEPH/Xbs9qiMex37Fa0Ywt9dexQeNlkP2ftQWWB1VpViWG
 e7w5gZ4xN+NRS6JVgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GQy-1tcnrz3tTc-015YmB; Sun, 22
 Dec 2024 13:54:32 +0100
Message-ID: <75414697-7f13-4f6c-b640-b2b4fad333e3@gmx.de>
Date: Sun, 22 Dec 2024 13:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] efi: Start to chip away at the EFI workaround
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241219023832.1098689-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241219023832.1098689-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jN/ooBEhGl8rbw6B6tb5CpGJXLfqOY8F15MqG4PcevB1X8SHd7v
 Ze1YA/kH8p5u2wBh+F69h5DSJo46I30t4bFVujUlUXdBkIhWG/Jz/e193O4toSWBAqSssrJ
 +ByNhktIid6lS/0QA0kQQrvf18Z/fcecZTXzSxROWx5i4QTkBHUldOXyeZKorBRaeQDToNz
 YMWqpz1p1WSyvREsN+D0g==
UI-OutboundReport: notjunk:1;M01:P0:Cf2T5s8jZU0=;Sd0auFGAv2RjwubKyX0bKXuomI+
 299ePaBEgMUMlBeiLODZzyyMfLo6eI+fMpdaq/1msJhhmQXKueAG4dyrGY+VGRfDjh3YAXp+/
 VxAS+pz9s9pheEgZzOWZaRhPXCThHh7vkb40RPiOhlC8nuOg6mAJdTXoOtaeqlEd+OGh+8dbb
 CGS+mfzEWGIb5dvz246zlna5G1dJ/pBUXvAH4sJyhrA2XQ6+GZbAG+qbGzMO7sRRJJTd5WrSj
 hxRWQpVINgc8Mo9kZtOfSDNxBzr2Ambb1keDiatbWlcP8sq2+xFwBf00Zy8jxNbgxuvmcOvt1
 d6hFdaktmBZs+7SRBCIabckEur8fK+Kh89XKCznvPCAiEZ1QDQ7t9YliI+LyPA0Uyzqcu8A8e
 9YaEoZQ6NgnMqo75ieq/EfrX1O4vU/TQ3WeWjiGbyBrUD9KkN0MsUVZfWrBLTz/989iPWRWco
 R3peXA5kUYK7wW4dmCPOITlI8bcod7Ks02OL+HrY68kD+b3qkFm99p+SbNO8XmmxI+ULWXZLE
 LkosxZglRXuDLZRdrb3rVbuPMDSDMaorQQP++5/iynDI/+vsvjjB7ScpIwRPva0j59gVrfi6K
 LplwtOGP4I1KxZwf5/1WUQaYKiK6fFraIP7Aws4Ozhccwimx47WJis89iwT610IBbdPTlpiD+
 dbUyk9/945HY/E+Z7VwvTsDxszvMg7Pt+MpFwVYztZhdvr+dhMaNY+zeKp/v9x776hpEj1p3A
 K8cMmf/2mJLjxaeC2TNTOtYW3Hyx5EcGMR/D3IPkyKQ/K+/PosvRbKQXatwB4IVzH91HjRiB+
 sAW8DX0Pa9IPwOQQDZ2OGeonb859OqBct375HZYjmU3vtaDmONfmh6Fhg8OMLutZ38EpIjyZn
 rWb1eAyzqqbELDtt8HFZbXxuqDaCeCMsTHjcRJKX99/J2q3fzkJwY7GFj9YmHPKJHuqSCNsKX
 WgmAmYK06BHZr73jhv0qklUY68x5VJwTE53ybI/TFMmzoA5zk3ogHq7cvv9JGiuj571dPcSYD
 aMjp4A4TqcplMpZ/CeXWCTWLc4mlC/3q0NBrJRlSC1aW8MmrafuYHJyVssTBl7wNGR5zo7yvi
 SkRGXRnvzSjBfW0FFEmNTXLImB/WIW
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

On 12/19/24 03:38, Simon Glass wrote:
> At present there is a function, efi_set_bootdev(), which is used in
> various places to tell the EFI loader which device a file came from.

As long as we have a command line to download images we won't be able to
avoid remembering the boot device in a global.

>
> With bootstd, this information is available in the bootflow.
>
> This little series provides a way for bootstd to provide the bootflow to
> the EFI loader, so that it is able to select the correct paths.
>
> For now only the EFI bootmeth is updated.

This seems to be the wrong focus. The EFI boot method should be removed.
It just duplicates the parts of the EFI boot manager boot method.

Best regards

Heinrich

>
> Changes in v3:
> - Make calculate_paths() static and add a comment
> - Add new patch to support PXE booting
> - Rebase on Tom's tree (i.e. without the pointers/addresses series)
>    https://patchwork.ozlabs.org/project/uboot/list/?series=3D436241
>
> Changes in v2:
> - Adjust argument ordering for efi_run_image()
> - Use efi_loader tag instead of efi
> - Drop unnecessary path removal
> - Fix 'require' typo
> - Move calculation of dev-name into a separate function
>
> Simon Glass (7):
>    efi_loader: Refactor device and image paths into a function
>    efi_loader: Make efi_run_image() static
>    efi_loader: Update efi_run_image() to accept image and device path
>    efi_loader: Add a version of efi_binary_run() with more parameters
>    efi_loader: Move the fallback code from efi_run_image()
>    efi_loader: Pass in the required parameters from EFI bootmeth
>    bootmeth_efi: Support PXE booting
>
>   boot/bootmeth_efi.c          |  64 +-------
>   include/efi_loader.h         |  10 ++
>   lib/efi_loader/efi_bootbin.c | 276 ++++++++++++++++++++++++++---------
>   3 files changed, 218 insertions(+), 132 deletions(-)
>

