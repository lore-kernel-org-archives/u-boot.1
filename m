Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F9CCD1292
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 21:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9CE87F2E;
	Sun,  7 Apr 2024 23:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="aTBA4o1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C439A87A80; Sun,  7 Apr 2024 23:53:55 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7DC87A80
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 23:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2ee5da9d-f529-11ee-99a6-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2ee5da9d-f529-11ee-99a6-005056999439;
 Sun, 07 Apr 2024 23:52:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=qdnuk1j+wcb690f8se+2KjM92f/1n0MNfY8czFI5mfQ=;
 b=aTBA4o1ckGBUvyl8Eb0e462IBIQiEyIEQWQdg0uGNAV6zNxUkPWuqhcAeF+ghFKTzIH1QBatJDwrp
 2t/yzv1cHhSSTtUJTgsO7fpn7qxHLjVNIxHYdG32UhUikbEDZMLdft0fTvLxrJ8nCwNQ+/SJbPwHDQ
 S6uRZTTYLczlLQRo3XASaih5ZR5NjnlJZJzYqwIB/P58KAOMkcAP9jPBXFiyjGspQ43HvU6ZqkMYrO
 FXvbE+Cdn+G/Mg3UUwHg84dHxIjK2sY3ZhFszBKHuKvk0b+nGV920vCy6vrpiK7sS+8jaOT00PU9O4
 VXYk3OuAVQ1iLV19WAMXTvLc/eu77Kg==
X-KPN-MID: 33|JUYAbns4UA3p0B3Uf2AERWyXiwcp2sQeSK4LwsDSP6jKfq8D8U0BgVW7qOyfeUt
 Bgv9AaaTeJdjJALeKlpwxGzeSSrsdTYon3ukUZWcFwS8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|olPtkSYT88jo5ywA8vD4a/tvlcG3lXQMhUVG7mGHVeoNcquRmcbFwzHJF+N7Xvl
 O+GUrrnMo4HmetQ8/GZXVZw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5209244a-f529-11ee-9b3c-005056998788;
 Sun, 07 Apr 2024 23:53:52 +0200 (CEST)
Date: Sun, 07 Apr 2024 23:53:51 +0200
Message-Id: <87bk6kj0uo.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, kettenis@openbsd.org,
 caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org,
 pbrobinson@gmail.com, pjones@redhat.com,
 ilias.apalodimas@linaro.org, trini@konsulko.com,
 kojima.masahisa@socionext.com, takahiro.akashi@linaro.org,
 bmeng@tinylab.org, raymond.mao@linaro.org, sjg@chromium.org,
 abdellatif.elkhlifi@arm.com, eajames@linux.ibm.com,
 alpernebiyasak@gmail.com, sughosh.ganu@linaro.org,
 o451686892@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20240406140203.248211-1-ilias.apalodimas@linaro.org> (message
 from Ilias Apalodimas on Sat, 6 Apr 2024 17:01:51 +0300)
Subject: Re: [PATCH v1 0/4] Enable SetvariableRT
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Hi all,
> 
> This is an updated version of [0].
> 
> When EFI variables are stored on file we don't allow SetVariableRT,
> since the OS doesn't know how to access or write that file.  At the same
> time keeping the U-Boot drivers alive in runtime sections and performing
> writes from the firmware is dangerous -- if at all possible.
> 
> For GetVariableRT  we copy runtime variables in RAM and expose them to
> the OS. Add a Kconfig option and provide SetVariableRT using the same
> memory back end. The OS will be responsible for syncing the RAM contents
> to the file, otherwise any changes made during runtime won't persist
> reboots.
> 
> It's worth noting that the variable store format is defined in EBBR [1]
> and authenticated variables are explicitly prohibited, since they have
> to be stored on a medium that's tamper and rollback protected.
> 
> The original RFC was just enabling the memory back end. This is a more
> complete version and we should be able, with small adjustments of
> userspace tools, fix SetVariableRT. If enabled the firmware will add two
> new RO EFI variables after ExitBootServices.
> 
> RTStorageVolatile -- contains the filename, relative to the ESP
> VarToFile -- an EFI variable that holds all the BS,RT, NV variables and can
> be copied to the file defined by RTStorageVolatile.
> 
> If any errors occur during the variable init, the firmware will delete them
> and adjust the RT_PROP table accordingly, disabling SetvarRT.
> 
> - pre-patch
> $~ mount | grep efiva
> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> 
> $~ efibootmgr -n 0001
> Could not set BootNext: Read-only file system
> 
> - post-patch
> $~ mount | grep efiva
> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> , disabling SetvarRT.
> $~ efibootmgr -n 0001
> BootNext: 0001
> BootCurrent: 0000
> BootOrder: 0000,0001
> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}
> 
> $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> Name: "BootNext"
> Attributes:
>         Non-Volatile
>         Boot Service Access
>         Runtime Service Access
> Value:
> 00000000  01 00
> 
> [0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalodimas@linaro.org/
> [1] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> 
> Changes since the RFC:
> - Return EFI_INVALID_PARAM if attributes are not volatile
> - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
> - Add 2 EFI variables and allow userspace to write the file
> - Add selftests
> 
> Ilias Apalodimas (4):
>   efi_loader: conditionally enable SetvariableRT
>   efi_loader: Add OS notifications for SetVariableRT in RAM
>   efi_loader: add an EFI variable with the variable file contents
>   efi_selftest: add tests for setvariableRT
> 
>  include/efi_loader.h                          |   4 +
>  include/efi_variable.h                        |  15 +-
>  lib/efi_loader/Kconfig                        |  16 ++
>  lib/efi_loader/efi_boottime.c                 |   2 +
>  lib/efi_loader/efi_runtime.c                  |   1 +
>  lib/efi_loader/efi_var_common.c               |  43 ++--
>  lib/efi_loader/efi_var_file.c                 |   1 -
>  lib/efi_loader/efi_var_mem.c                  |  90 +++-----
>  lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++-
>  lib/efi_loader/efi_variable_tee.c             |   1 -
>  .../efi_selftest_variables_runtime.c          | 116 +++++++++-
>  11 files changed, 401 insertions(+), 98 deletions(-)

I can't get patch 0003 from this series to apply on master or next.

