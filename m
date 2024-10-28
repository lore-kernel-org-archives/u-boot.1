Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A9DD13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E8E89058;
	Mon, 28 Oct 2024 07:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P5cwOTTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7074C8905F; Mon, 28 Oct 2024 07:51:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC6D88FE3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730098302; x=1730703102; i=xypron.glpk@gmx.de;
 bh=Ly9Hpr9xorB1ZZ4qG8fqv4msnKZUnslnAlVrmUTwBgk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=P5cwOTTcQfreK2LmudeN2qzvAmmdLqhgRhN/DdJEJVtXgEfS6GZNo+0RoyYUvE5R
 WHcGNVTwSRHbD7i+wleMmizgpMhWOjKKaN063Ud0yWMDIxa3eYaIR8Etjzx6Jk50a
 Y0ALL40xcByNQHvscqznjGdtYT+F8yDrOhZIIlz3JhP08q/v+5Z2DNS2xYCutrdSI
 WMeTyf0VpxHROACPAEc8yhQrjugzzCpkrlSSpeITO78fWBVHdY3sSaPd4zDnk89+L
 pkM1N3sAciZE7gyZA08ANHlZjfbZyeZY+BnF6ZOZX+BDI/Wz7qOkQSQJ1KXrnzzia
 DjhlZ92wMY7O8dEPVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1tE51h3olE-00Giei; Mon, 28
 Oct 2024 07:51:42 +0100
Message-ID: <fe62eb15-a3a3-40ac-8226-b1837a2f355d@gmx.de>
Date: Mon, 28 Oct 2024 07:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add pmem node for preserving distro ISO's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241025111411.165904-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kO4y11zX3iOfqZStRB7f0xydsBRWnxbPOKsW4CglN8B8YGd8eGS
 VZSm4A1zc8LF9JWEsx+B7AZcBMwe9TB5gKf42aOrcpCBk0qec48LRk/pUbRtk04hmviNPXe
 wOpHj+sWxXcd9WQOUdBzndDbf7ixO+eQNKtX61VxR4HCxpWNgR9gweGybTeSKFsIWzD0EDJ
 61SHdYT5j29zssw6VdBnQ==
UI-OutboundReport: notjunk:1;M01:P0:OrYuC05iEig=;ATIVvNRJj+HJe6mquyPrC7bFn3h
 Ufe1iTMu8RKRXBWsCEUWkiDej6dWtoTe3/bt0ngsntU8T8ibyL7A1wPMSCkhvhz4WABDRYGS7
 qQ0l5Rv638c7iqAhX9wpvuLCu7yjtVBtYAo8lb1LZF40FICPGdLBeNFQT4okj7aAmy9yuPGIg
 XuDzqMSNPzeSOEn0ahepoqyyHQlFRnMck8gMuwUZjxPBksj0Vs/0DaQxiSkmrVsJcegsmSMu/
 R/x1iMwvldG64rRhfDnxLmYjwa28ivlrUsTMUCrG3FjbOwkB0Ahi81hrI10vz+98RTvShwTV+
 /dCQGTgostRQlUaPhWlUEvJOf8JfHPbKF6W9eHXi7vcAWQ6C5UXF3iM9oDTbfJg2DO45ymv8c
 WUoWcHSh6pQ5f2UuPWC1FaoleocAZ8ePi9RlBpowJwDk9StjQTblRHn1aDunPva3bBJ9hBUWo
 s7BK6jsLj5mWlRNWCnoRbk/kagC58xTZOBcPXug3zhTAfmpqJbvgzk+L5YFfn1zvlKG4pVw8a
 6TKTap7hrPVk18DNJknZdoM86fPYnSFK7/rB4u5dZzvWSPDYyN1aOFVDmKX8XKcutxu+jcN9W
 CFUyokjglVEN+MRYSIPDM0dsOxRdKk4fj+j4WFFDtE9t9HTar36y5aGNkUGgqVRJxb/houKcL
 smJxhuTtbABP4ZpTom+dZqqY1w8uejqXC9swT8fuNYMkaB2A6oejragCGHD51INr5zH4bYiVa
 gNOG6YGyQSOOuaXDtyTQhKxJNBBXa/M5s8VQck/buyRZpIyY0B1eo7pICm/lafCsCUi8BhW8/
 KPbyjauwzn9GFCteoqcIiX+A==
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

On 10/25/24 13:14, Sughosh Ganu wrote:
> When installing a distro via EFI HTTP boot some OS installers expect
> the .iso image to be preserved and treat it as a "CDROM" to install
> packages.
>
> This is problematic in EFI, since U-Boot mounts the image, starts the
> installer, and eventually calls ExitBootServices. At that point the
> image U-Boot mounted disappears. Some distros don't care and download
> the missing packages from a web archive, while others halt the
> installation complaining they can't find certain packages.
>
> If the firmware uses ACPI, this is supported by using NFIT which
> provides NVDIMM ramdisks to the OS and preserves the image.
> We don't have anything in place for Device Trees though. Since DT
> supports persistent memory nodes (pmem) use those and preserve the
> .iso for installers.

Are you planning to provide the missing ACPI code for U-Boot?
QEMU provides ACPI tables which U-Boot passes through.
The x86 boards also need ACPI support.

Best regards

Heinrich

>
> The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
> live server ISO, or a Rocky Linux ISO. The installation would fail
> with the failure to locate certain packages.
>
>
>
> Ilias Apalodimas (2):
>    efi_loader: add a function to remove memory from the EFI map
>    efi_loader: preserve installer images in pmem
>
> Masahisa Kojima (1):
>    fdt: add support for adding pmem nodes
>
> Sughosh Ganu (1):
>    efi: add helper functions to insert pmem node for DT fixup
>
>   boot/fdt_support.c           | 41 +++++++++++++++++++++++++++--
>   boot/image-fdt.c             |  9 +++++++
>   include/efi_loader.h         | 28 +++++++++++++++++---
>   include/fdt_support.h        | 13 +++++++++
>   lib/efi_loader/efi_bootmgr.c | 43 ++++++++++++++++++++++++++----
>   lib/efi_loader/efi_helper.c  | 12 +++++++++
>   lib/efi_loader/efi_memory.c  | 51 +++++++++++++++++++++++++++---------
>   lib/lmb.c                    |  4 +--
>   8 files changed, 175 insertions(+), 26 deletions(-)
>

