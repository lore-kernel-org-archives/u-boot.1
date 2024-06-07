Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE048C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 16:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A5987F41;
	Fri,  7 Jun 2024 18:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TqYyxJCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDEF8839C; Fri,  7 Jun 2024 18:31:40 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9409487E50
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 18:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB15B3F68E
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717777896;
 bh=BO5N6URp+nbbFkLn46aL0jzkOAqvlkia7+dtd6k2lOU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=TqYyxJCeIdKta9rDuLB3MHN1E8MlLAnaJgB8qi4DleKhSMzQ3tOQZBkkWiL0ruR8C
 i7TlMNuppy3TbEC/5l7T69YlbQbluUxYnt5eo+xtgR0DtymurBkdHRnnXV5NMp/wcq
 wLXt0zYdBLIfKuNq0RAzHh8TFA/tTO1URdH6zar5cvaPMiiUQv/1Lt0RmR+BkkKrdU
 AYFFLqKfDrqeVIA+zKel1vjgdgdQ8a5y++oQ4a7X1mhH8MBCKl7bO1LXNCdNPW055t
 LvuE5FVGgiL/ZtKZzaW+FzjyFewDvYWOoKAtourvePGssahoKs2duMtPl9BmHxVWdQ
 vGk1pXDwVv5fA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421292df2adso15923525e9.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 09:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717777896; x=1718382696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BO5N6URp+nbbFkLn46aL0jzkOAqvlkia7+dtd6k2lOU=;
 b=Z68dFTMNdaa/gWXA6a7m89pX4zL7vHgKqwVXPvT2L48MR5KC+Kbl+tqXUgCnGpif/Z
 TiQVX3B/lsvsaeWPONwyNeCTTYUzo60BjzWre1KYp2Y7kjJ6Z59fZ5pPvjpBpqxn7vBj
 pOnGtYBeBHGxdlsse4VBDUY2I377kdQSFgQhny0V5DElmhZWIDdktX19NrIz1j4QRvya
 +VJulzqQkvREKgWhzG/ElhcH75Sl5PavJ1z5qu63xzbSgbl7ZCU7WmRAcn3NtXzbhBgQ
 5Ao22+biQfblSnl4A6ifsxzgSUNqgRPFj4jZ0mpr2OffNJrEkfo/7Cqv60CH2VGr9ddv
 hD4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7GU+qakIE8RdIrwjv9qHT8n4/e2j8ZBKtFN6iP8oJPZvZvn2rbJDRXnEK+IdMauxlzHYHyVbXGCA0H6bnVw1yNaZAfQ==
X-Gm-Message-State: AOJu0YwZjus0PDXwDy/cdcQnSe8ctzTgFfGSjgN2mSMGroU4McwL8GVs
 AJXfW5GJPQSJpVIEgANfZD926sKpIJ9Iajf2cV91UlH+WrMrgsrRCMIAQBGVILfa65en+MqHWvr
 82t9J5JIXisLubTF99+MpxxYh/5owsR5PvtsgaiLBL1dX8uFqtge5vpbzLklVyJaBMQuy5R9co6
 Y=
X-Received: by 2002:a05:600c:3399:b0:421:5f88:47f5 with SMTP id
 5b1f17b1804b1-42164a031b6mr24669925e9.15.1717777896229; 
 Fri, 07 Jun 2024 09:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKbtxlQz83LHAg010D4H0pzCqslMZB0GbS26hNZ/yQn5RKZ7PhbxvJ1QLrsd4co6+xM9sZ+g==
X-Received: by 2002:a05:600c:3399:b0:421:5f88:47f5 with SMTP id
 5b1f17b1804b1-42164a031b6mr24669685e9.15.1717777895739; 
 Fri, 07 Jun 2024 09:31:35 -0700 (PDT)
Received: from ?IPV6:2a00:20:6:1be1:5467:bcef:945:5d8c?
 ([2a00:20:6:1be1:5467:bcef:945:5d8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421739bc28csm5881915e9.1.2024.06.07.09.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 09:31:35 -0700 (PDT)
Message-ID: <a11e1e72-c274-46f1-bedc-092ae0d9c370@canonical.com>
Date: Fri, 7 Jun 2024 18:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: sophgo: milkv_duo: Update Milk-V Duo
 documentation
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>
References: <20240523064025.17602-1-seashell11234455@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240523064025.17602-1-seashell11234455@gmail.com>
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

On 23.05.24 08:40, Kongyang Liu wrote:
> Add detailed steps for compiling U-Boot and OpenSBI, generating the
> firmware package with fiptool, and booting the board.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
>   doc/board/sophgo/milkv_duo.rst | 41 +++++++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
> index cb2ed1ad98..a88db5b903 100644
> --- a/doc/board/sophgo/milkv_duo.rst
> +++ b/doc/board/sophgo/milkv_duo.rst
> @@ -20,31 +20,50 @@ Building
>   .. code-block:: console

There are is a 64 MiB version of the Milk-V Duo with the CF1800B, a 256 
MiB version with the SG2002 and a Milk-V Duo S with the SG2000.

This may confuse U-Boot users. Should we mention explicitly that only 
the CF1800B based board is supported?

>   
>      export CROSS_COMPILE=<riscv64 toolchain prefix>
> +
> +3. Compile U-Boot
> +
> +.. code-block:: console
> +
>      cd <U-Boot-dir>
>      make milkv_duo_defconfig
>      make
>   
> -This will generate u-boot-dtb.bin
> +This will generate u-boot.bin and u-boot.dtb
>   
> -Booting
> -~~~~~~~
> -Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
> -clock and load the u-boot image, then bootup from it.
> +4. Compile OpenSBI
> +
> +.. code-block:: console
>   
> -Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps:
> +   cd <OpenSBI-dir>
> +   make PLATFORM=generic FW_FDT_PATH=<Your U-Boot Path>/u-boot.dtb
>   
> -1. Use the vendor-provided tool to create a unified fip.bin file containing
> -   FSBL, OpenSBI, and U-Boot.
> +This will generate fw_dynamic.bin
>   
> -2. Place the generated fip.bin file into the FAT partition of the SD card.
> +4. Generate firmware image package
>   
> -3. Insert the SD card into the board and power it on.
> +Fiptool(https://github.com/sophgo/fiptool) is used to generate fip file.
> +
> +.. code-block:: console
> +
> +   git clone https://github.com/sophgo/fiptool
> +   cd fiptool
> +   ./fiptool \
> +      --fsbl data/fsbl/cv180x.bin \

Where do we get this file from?

> +      --opensbi <OpenSBI-dir>/fw_dynamic.bin \
> +      --uboot <U-Boot-dir>/u-boot.bin \
> +
> +This will generate fip.bin

Should we let binman do this in future?

> +
> +Booting
> +~~~~~~~
> +1. Place the generated fip.bin file into the FAT partition of the SD card.

This information is insufficient to set up a new SD-card.

Should the SD card be MBR or GPT partitioned?

On an SD card there are typically are multiple partitions. All of these 
may be FAT partioned. Does the boot ROM use a fixed partition number, a 
partition type, or a start sector to identify the relevant partition?

It is left unclear if fip.bin is to be copied by dd to the partition or 
into a FAT file system on the partition.



I just downloaded the vendor milkv-duo-v1.1.1-2024-0528.img.zip file.

Here I found an MBR partition table with the following partitions:

Device                          Boot   Start     End Sectors  Size Id Type
milkv-duo-v1.1.1-2024-0528.img1 *          1  262144  262144  128M  c 
W95 FAT32 (LBA)
milkv-duo-v1.1.1-2024-0528.img2       262145 1835008 1572864  768M 83 Linux
milkv-duo-v1.1.1-2024-0528.img3      1835009 2359296  524288  256M  0 Empty

Partition 1 was FAT16 partitioned and contained file fip.bin in the root 
directory. But I still don't know how the relevant partition is identified.

Best regards

Heinrich

> +2. Insert the SD card into the board and power it on.
>   
>   The board will automatically execute the FSBL from the fip.bin file.
>   Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
>   U-Boot.
>   
> -
>   Sample boot log from Milk-V Duo board
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   .. code-block:: none

