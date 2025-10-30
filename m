Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E06CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 18:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBE1836D1;
	Thu, 30 Oct 2025 19:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6Q5xFs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7E483849; Thu, 30 Oct 2025 19:12:18 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BDD83677
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 19:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-290cd62acc3so17822605ad.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761847935; x=1762452735; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KiFlgW0IFNO+kY/ot260Ki4NzPW1UN2qVXlRnUyRri0=;
 b=C6Q5xFs60emHFCy3zljv1S0PXz1ZQpE4u4ufVgXSGc1rCS0GU8Ouk8WKSsFsPUa62q
 IKA8R3m+l26IaMKLC+dPZoyyqJMKDnt0omCU8EqAPq7FNoQMSAl+/9/tVSY8FGHx2BDq
 dRKpLoGK3T92ZJP5Ol+I+vlfQDsVrT2Vg5Egm5W6OkHtEN1tO4P1LbhUvpoRe9mGSXHm
 gstdQhId0BDRXwRJIubI9R33+qIRDJH/mJGOk4JpwjdtZ2tVHu+x3OAVGv6g2uqlFVVw
 hcNuOr0l8SpTrvbgNvu8vjXDY/o4BkU3eZjlLSd0JfX+dxtOBD/ekMeEaRbD0QNitaFO
 ZEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761847935; x=1762452735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KiFlgW0IFNO+kY/ot260Ki4NzPW1UN2qVXlRnUyRri0=;
 b=OMsLy9JgMTnloMZWaNDTVewyWYNFy2ls3waaE30coWgLNqSFehQCGevplH0ruciVmU
 v9v+q190AmGOQNshxXeVFtp92tVKIjSrjKj2kR9SgHRqZy62Tag7YgAnMrNj925yHwy6
 MNWGofkxBlrpqu6dpi4OS3Dlzat/E+6DsLjROz08HEFmhxIvs/nYRN+zwf2tiPzZJ3fe
 BrgVSYHYnrUI0LxlGzFSt/5y5smPrT/vOotj+U6Nf6TYoxYBZ4GipabIkXfxmfo6E0Bu
 A/R26f9DoCWsqmnNSvOx0EtAsKpH9TeY6xMek0GbylMt3S/BQXUmiUA4b2wfTm8x7AAt
 rNzQ==
X-Gm-Message-State: AOJu0Yyy9tQsEgw/QZwoQcTFB2KEIftgiJ+zZTlJSU9jQWQ4+iIlJ2r3
 doeeltjePp3HDn2wDx5p0949pjsHCpAy8wRrWF+iFjP1eAUgCJ8QDZV4
X-Gm-Gg: ASbGnctfL/bpTCdtgRAwva9OMwXbJeyqsp5nVModcRsYZcbd2+d03eCesG2KzdkKGca
 W/TFSEn6KZmy+Yu5fweQOd1+cERSVmTpev9DBNRvA2t4a9DqhnIiC71v4gJmdCTYpQHbpZpIxzA
 RdD0Ds/y7HqwyU7tQkyBZjiCJgZnRuooSODiIdcyTNQF/dg1xe/nr8qDWVz9ueW2TjXihrnxgWT
 rn7UPk9Kw23BTjN0dt4Klajeqn4Z1ioqQx6+LO//mog8mca68Z4BuyjVSLT4JtgwlZKzlPcrPpt
 JGtzvVP5kuUi5qtwdtyciEu3JHdMdUHANPCJW5EiZhtK5rsmk+aXRp9EErOdLOmAdgMc3JBkNoR
 wbcn01E3s+lso0JV4OlFDkXi1r5IExG5Ky/KSa6Z59za90/1d3eq3
X-Google-Smtp-Source: AGHT+IGW6VRIdctGieoP73CpLeOhoudnlN+Cajn4BExjA/ZGj3pmuS1FppylAo4/oHZN+0G80KPv6g==
X-Received: by 2002:a17:902:ec88:b0:290:9a31:26de with SMTP id
 d9443c01a7336-2951a496200mr9776595ad.33.1761847934062; 
 Thu, 30 Oct 2025 11:12:14 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d273a2sm193068285ad.60.2025.10.30.11.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 11:12:13 -0700 (PDT)
Message-ID: <6ae3eab1-3208-4317-8ae2-5f5cac1e2dfe@gmail.com>
Date: Fri, 31 Oct 2025 02:12:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250613224343.3521820-1-jonas@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <20250613224343.3521820-1-jonas@kwiboo.se>
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

Hi Jonas,

On 2025/6/14 6:43, Jonas Karlman wrote:
> Writing to eMMC on RK3528 is affected with the same or a similar issue
> as on RK3588, where eMMC must init to HS200 at least once to fully work.
> 
> Trying to write u-boot-rockchip.bin to eMMC fails with:
> 
>    => mmc write $fileaddr 40 5000
>    MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>    0 blocks written: ERROR
> 
> For U-Boot to enable HS200 mode the mmc-hs200-1_8v prop must be defined
> in the device tree. Linux does not seem to be affected and is able to
> detect and use HS200 without this prop.
> 
> Enable use of HS200 and fix eMMC write on RK3528 by adding the missing
> mmc-hs200-1_8v prop for affected boards:
> 
>    => mmc write $fileaddr 40 5000
>    MMC write: dev # 0, block # 64, count 20480 ... 20480 blocks written: OK
> 

Sorry for the noise.

I recently got an E20C board, and I ran into a very stange issue, the 
U-Boot throw errors with any mmc r/w operation, like `boot` or `mmc erase`:

```
=> boot
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------ 
----------------
Scanning global bootmeth 'efi_mgr':
  ** fs_devread read error - block
  ** fs_devread read error - block
Card did not respond to voltage select! : -110
Cannot persist EFI variables without system partition
   0  efi_mgr      ready   (none)       0  <NULL>
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
Scanning bootdev 'mmc@ffc30000.bootdev':
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
Scanning bootdev 'mmc@ffbf0000.bootdev':
  ** fs_devread read error - block
  ** fs_devread read error - block
  ** fs_devread read error - block
Unknown uclass 'nvme' in label
Unknown uclass 'scsi' in label
No USB controllers found
Scanning bootdev 'ethernet@ffbe0000.bootdev':
ethernet@ffbe0000 Waiting for PHY auto negotiation to complete..user 
interrupt!
phy_startup() failed: -4
FAILED: -4
BOOTP broadcast 1

=> mmc read $loadaddr 0x40 0x4000
MMC read: dev # 0, block # 64, count 16384 ... 0 blocks read: ERROR

=> mmc erase 0x40 0x4000
MMC erase: dev # 0, block # 64, count 16384 ... mmc erase failed
0 blocks erased: ERROR

=> mmc part

Partition Map for mmc device 0  --   Partition Type: DOS

Part	Start Sector	Num Sectors	UUID		Type
** Can't read partition table on 0:0 **
```

By checking the mmc information:
```
=> mmc info
Device: mmc@ffbf0000
Manufacturer ID: ef
OEM: 0
Name: TLi16G
Bus Speed: 200000000
Mode: HS200 (200MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 14.7 GiB
Bus Width: 4-bit
Erase Group Size: 512 KiB
HC WP Group Size: 128 MiB
User Capacity: 14.7 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
```

I found the bus width is not corrent, and no "Boot area X is not write 
protected" tip.

This is the working `mmc info` output:
```
Device: mmc@ffbf0000
Manufacturer ID: ef
OEM: 0
Name: TLi16G
Bus Speed: 200000000
Mode: HS200 (200MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 14.7 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 128 MiB
User Capacity: 14.7 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected
```

I tried to use the generic-rk3528 configuration, and it seems to work.
After making some tests (about 50 times reboot/reset), I found the eMMC 
works fine if `CONFIG_REGULATOR_PWM=y` is disabled.
This is a bit weird. Maybe disabling this option just hides the real issue?

Here's the build information:
U-Boot commit: 4cad9faf8d28 ("MAINTAINERS: update my email address")
rkbin commit: 74213af1e952 ("rv1126b: bl31: update version to v1.07")
Build command:
make CROSS_COMPILE=aarch64-linux-musl- 
BL31=../rkbin/bin/rk35/rk3528_bl31_v1.20.elf 
ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.11.bin

Any help will be greatly appreciated!

Thanks,
Tianling.

> Fixes: b112a44531cb ("board: rockchip: Add minimal generic RK3528 board")
> Fixes: ccbddf645310 ("board: rockchip: Add Radxa E20C")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Kever, Tom: Please consider this for the v2025.07 release as support for
> RK3528 was added in v2025.07-rc1.
> ---
>   arch/arm/dts/rk3528-generic.dts            | 1 +
>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
> index 792d3e04a4cb..3f6f0bed108d 100644
> --- a/arch/arm/dts/rk3528-generic.dts
> +++ b/arch/arm/dts/rk3528-generic.dts
> @@ -18,6 +18,7 @@
>   &sdhci {
>   	bus-width = <8>;
>   	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
>   	no-sd;
>   	no-sdio;
>   	non-removable;
> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> index 9c2f03a786cf..1372d8f1e38a 100644
> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> @@ -2,6 +2,10 @@
>   
>   #include "rk3528-u-boot.dtsi"
>   
> +&sdhci {
> +	mmc-hs200-1_8v;
> +};
> +
>   &sdmmc {
>   	bus-width = <4>;
>   	cap-mmc-highspeed;

