Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3E9D3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E63893B7;
	Tue, 26 Nov 2024 10:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="l5AR/z1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748C9893BF; Tue, 26 Nov 2024 10:10:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093C288FB4
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732612244; x=1733217044; i=xypron.glpk@gmx.de;
 bh=ROEoyN5vHyr/hs2yz8nD60AW4y0aqA7T1JIPKm1bzxs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l5AR/z1kwoekOfCThQ6pH1B5G7+fvnp2213Yc4EAt2szw/GrE4XOpV1iqhU6K93y
 EFqFVnHypFMeZARp4a+VfEhEMzf6lC2qeW3DsNjtafDKrMRLIpk7ePR8jRUC+X2c1
 QlIN7zmPxS7x7BjAJ/YIXlu1bDgPTWOCdR4Z+pGsscXHPKYE/+MhAl3ryViHlyZIs
 i1j0npZ8El/mt2flBKz6lxMhWXPAVZdLBnaccd5M+yTKxIY/+mS2mRHgax47UxDnK
 FtPvrIfFFXa49ohRPG+CMC2cPd/vdu+IxRpoKtGg9AoTTkxUAmURqQXNwSGYDhEra
 dIj8ZxW9uKBi1CCPeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1tILlf1Aex-00CvbB; Tue, 26
 Nov 2024 10:10:44 +0100
Message-ID: <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
Date: Tue, 26 Nov 2024 10:10:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FUueF/afxCQ3xqDDlrIqc6lJPolpq2wdv77ytOgIKl/WfGCJ5Sa
 i5QcIF0qguEMa2fpc0zc+a4xHPAuWs3t9IO4V9ALE/WOKCkqF0msNq577S6xMroJsFVDiru
 qa1QYpinEYqv0oASyd3yeU4Deh5PQ29uPRcNtkOYJsxPpHqZ76vD66lKs6EQWOy8OAmy9Qa
 ZN4ieJoRX3xknGNw43x1Q==
UI-OutboundReport: notjunk:1;M01:P0:qOyj1mgBoMI=;eYeVbttCGXoyns9//4cC2zflwaC
 VsoEJzDD9Qpvh2nceUiXA5xh09DByB7CVjoPyMDxEIC+oDQe1hzuew5gp5FUTUbEt34sf98FG
 bq4XnTZh6mdP/3M8e1HzpOggLX9LeKVyy7xp3tCpseYomb9nXDV+gMGvazudnZz403PbPe84D
 EpeBVqhf0RJ8wI3sT3nhapkjBM8RRcp/YfbKQVWaSxI1BJsgRPxRsYv5ZK5JvAJzcn5hRWbVf
 Jjmzq7SZwcV8FGBnd/2+HIlZnDeYkFB417uHK/bhQVSQL36vYc3BSo8f0MWI0pyKimpvH6uG9
 46AxrUX2frvFCZGhgPFTdD6p+p959ScSnAp4DVOL49wSyyJq3WwFJvPkvVVX0vOZjWNhUR1kg
 VPrxdjJwyBtsmvW7CnLshytAQ0xVPgGtSI1AtJUXS8CLd3o2TrCgrUBlFaBS9B9Hs8qMr33OC
 y/3fVz8JOxZrgJ9zaW++7FTsSm6hKH/cikxwSG72JrHEV75lhPYnNwxDfgeNECJfwTxR53cNm
 Rbd7+Oc8nG9Ck9KPeVEp3lZcBL4vDEoIEw2sHtykuk3I3QcxEPRjIMerOX4rDtlVC0XZvmb+p
 0dTHQXDOrAZe/76vhhU6Kqm9JnycZ3wKJwu9FS2x9htueQ3v1HZZ1OOc7ZZ/ibf73J+zU+LXH
 xOusw/j08HujRZqwyuuqGBtMDct1Fp+hsRVpThktOoMUeSsryBFl7WdK487iWGszo+mL6CjI3
 3XIdgHIz1GAlsXOV+wMCeb4Rsw5u+WWokV+NJ53o/ErllMD9riOuGk6zxR2x1ewCits1drU+l
 96q71zHSW6otm5TKgSFOsGquq4GSqf6JX+GyVNId8MppFFpsNlC4Tiod5C0qJ+RXQ6il7OPJD
 2YvNN46QHGVin/n9FJ/RNnq3PfCPtSkVQb+r4xzflwONl3MHGoElhnWZa
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

On 25.11.24 21:44, Simon Glass wrote:
> The EFI-loader implementation converts things back and forth between
> addresses and pointers, with not much consistency in how this is done.
>
> Within most of U-Boot a pointer is a void * and an address is a ulong

No. It is phys_addr_t that was introduced to handle the sandbox's
virtual addresses.

And we should keep this sandbox stuff out of the EFI code. They are only
needed for the command line interface.

>
> This convention is very helpful, since it is obvious in common code as
> to whether you need to call map_sysmem() and friends, or not.
>
> As part of cleaning up the EFI memory-management, I found it almost
> impossible to know in some cases whether something is an address or a
> pointer. I decided to give up on that and come back to it when this is
> resolved.
>
> This series starts applying the normal ulong/void * convention to the
> EFI_loader code, so making things easier to follow.

According to the C specification size of long may be different to the
size of void *. uintptr_t is the type that is guaranteed to match the
size of void *.

There is no benefit in spreading the ulong abuse any further.

Best regards

Heinrich

>
> Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromi=
um.org/
>
>
> Simon Glass (13):
>    efi: Define fields in struct efi_mem_desc
>    efi_loader: Convert efi_get_memory_map() to return pointers
>    efi_loader: Show the resulting memory address from an alloc
>    efi_loader: Update startimage_exit self-test to check error
>    efi_loader: Move some memory-function comments to header
>    efi_loader: Use the enum for memory type
>    efi_loader: Make more use of ulong
>    efi_loader: Tidy up use of addresses
>    lmb: Reduce mapmem contortions in lmb_map_update_notify()
>    efi_loader: Simplify efi_dp_from_mem()
>    efi_loader: Tidy up efi_reserve_memory()
>    efi_loader: Drop extra brackets in efi_mem_carve_out()
>    efi_loader: Don't try to add sandbox runtime code
>
>   include/efi.h                                 |  15 ++
>   include/efi_api.h                             |   6 +-
>   include/efi_loader.h                          | 100 +++++--
>   lib/efi_loader/efi_bootbin.c                  |   3 +-
>   lib/efi_loader/efi_bootmgr.c                  |  11 +-
>   lib/efi_loader/efi_boottime.c                 |  51 ++--
>   lib/efi_loader/efi_device_path.c              |  18 +-
>   lib/efi_loader/efi_dt_fixup.c                 |   8 +-
>   lib/efi_loader/efi_helper.c                   |   7 +-
>   lib/efi_loader/efi_image_loader.c             |   2 +-
>   lib/efi_loader/efi_memory.c                   | 246 +++++++-----------
>   lib/efi_loader/efi_var_mem.c                  |   6 +-
>   .../efi_selftest_startimage_exit.c            |   6 +-
>   lib/lmb.c                                     |  10 +-
>   14 files changed, 251 insertions(+), 238 deletions(-)
>

