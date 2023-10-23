Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26A3CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 14:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149AE87552;
	Mon, 23 Oct 2023 16:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NWxrfbl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3650287733; Mon, 23 Oct 2023 16:08:09 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB8886FA8
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C1B36606F51;
 Mon, 23 Oct 2023 15:08:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1698070084;
 bh=zRgFZ8qXUlTWVcGVIb29HwLwyEbCSt+ujHkdybinFW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NWxrfbl2yD3Yon1XVCB39oOl+wFU4KZywaraG+sVT//DwSgDmckplURD7I2Vh/KPR
 aMImPDHYTuywvCrArKp6n4ZyI39qPNjGIlv8XsMB48OMsIqlHD3XVsFZXGS38X8qFX
 XJauIWCExPuW575rfRlWIgBFD0OVLnx8NTiOOSJS1Wu2ZlWKpU0T4CtEH80r0rQ1cX
 symI01Q+IMOBYm6Qe/rppEOQMfueGc6VJFcDsx2vJKU+PHacNoC+K0PozK0fNA8DmU
 fGxUBi6jy15vSmz5VZxZt3jDOvOupwj8XcWiuMk/KlhFRGxfvchRLHJJMGAkftNfc4
 iqeuRCweTNO9A==
Message-ID: <e950f705-855d-4b51-a58e-c8aed4a152dc@collabora.com>
Date: Mon, 23 Oct 2023 17:08:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Conclusive KSTR-SAMA5D27 support
Content-Language: en-US
To: Artur Rojek <artur@conclusive.pl>, Simon Glass <sjg@chromium.org>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de
References: <20231018140059.161169-1-artur@conclusive.pl>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231018140059.161169-1-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/18/23 17:00, Artur Rojek wrote:
> Hi all,
> 
> this is v5 of the Conclusive KSTR-SAMA5D27 support series.
> 
> Patches [1/4], [2/4] and [3/4] remain unchanged.
> 
> In patch [4/4], a new dtsi file has been added in order to keep U-Boot
> specific properties separate from the main dts. As such, MAINTAINERS has
> been modified to feature the new file.
> 
> An alias to the i2c node holding the EEPROM has also been explicitly
> added, so that it always enumerates at bus 2.
> 
> Artur Rojek (4):
>    common: add prototype & rename populate_serial_number()
>    event: add new EVT_SETTINGS_R event
>    arm: dts: at91: sama5: Add flexcom4 node
>    board: Add support for Conclusive KSTR-SAMA5D27
> 
>   arch/arm/dts/Makefile                         |   3 +
>   arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi   |  42 +++
>   arch/arm/dts/at91-kstr-sama5d27.dts           | 127 ++++++++++
>   arch/arm/dts/sama5d2.dtsi                     |  20 ++
>   arch/arm/mach-at91/Kconfig                    |  12 +
>   board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
>   board/conclusive/kstr-sama5d27/MAINTAINERS    |   9 +
>   board/conclusive/kstr-sama5d27/Makefile       |   5 +
>   .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 239 ++++++++++++++++++
>   cmd/tlv_eeprom.c                              |  14 +-
>   common/board_r.c                              |   1 +
>   common/event.c                                |   1 +
>   configs/kstr_sama5d27_defconfig               |  73 ++++++
>   include/configs/kstr-sama5d27.h               |  15 ++
>   include/event.h                               |   9 +
>   include/init.h                                |  14 +
>   16 files changed, 586 insertions(+), 13 deletions(-)
>   create mode 100644 arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi
>   create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
>   create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
>   create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
>   create mode 100644 board/conclusive/kstr-sama5d27/Makefile
>   create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
>   create mode 100644 configs/kstr_sama5d27_defconfig
>   create mode 100644 include/configs/kstr-sama5d27.h
> 


Applied series to u-boot-at91 / master, thanks !
