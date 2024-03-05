Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1498C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 19:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93C98809D;
	Tue,  5 Mar 2024 20:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HTBvD1AR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B871880DE; Tue,  5 Mar 2024 20:52:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD2A87FE3
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 20:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709668360; x=1710273160; i=xypron.glpk@gmx.de;
 bh=0yyIbRxm5/UMaRyrdyStzd58q5/E9Yh32I+WzrdUWx4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=HTBvD1ARZppU3H+Co1GeRbGx8YYrT79lT1qjymUDAPRJ3JFNz26+s7fAmJbFdbdy
 2/88AVSNoosRBBzTB6jtw4ecMeWapdex1ay7+cepPM5Nbw5i8TJ7W9epncZZGPYmt
 vn5Nn0VegaZ+oQOPOyVPbfSyr4fyvFqbamV79ENmvNY0Om/EHrSv1FJen+UKEPDOi
 ANAbNZM/m8N/RkPXP6osLKcaHfls1v+mQjmDjFDPG1EIFNo4+yghNMoEhFkBKj0iE
 Xnolv54Uj8mK1LejTNHuEPz+yQglccAcjecxvfldwPfWDXUuAuwK7DBXMUqNBmYr9
 pA3SnXJVB+/PxMZMMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.176.242]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1rn4UO1VNM-007oGf; Tue, 05
 Mar 2024 20:52:40 +0100
Message-ID: <5d6b9fa0-bdac-47e6-8b2d-62ee3702227c@gmx.de>
Date: Tue, 5 Mar 2024 20:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: Fix paths in the bash block
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, yanhong.wang@starfivetech.com
References: <20240304221532.368453-1-ivan.orlov0322@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240304221532.368453-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cngpRs+mzRRxbvDiSWJkXy6e69zgcuIdFsUxxQOliJ405oC+Gep
 Az1gadlIdQtHGUPB7xFgFr658WmeAhOL40COaArLQPVdPezZS962HOaPCtelz+bMrPQw1Jf
 I2B1CAm147kcHEX844YhamiWex+0YLSpZydzcQ2k2ApXl/7KEMg5JRVmTpBUwKDtRxN18fI
 nVogXU5XuCTq4dA82+6Ew==
UI-OutboundReport: notjunk:1;M01:P0:UWWS7UYdz2A=;PqRvwO/32/mKA3pfMiEt6Vk8syM
 g0aD1mPQTmouMEJiGBBg/2XQM6OJSesTRP+sm5HGxFyVKtoKO3XHWvfYvMfRMvQLyrCX8XxWh
 rJ+bsW8OHRP0bCtFWRwxnupj95iahKFEGgXcbo0TwohWqrjFWBNHF6eAn7NHwzDwP4nRXtA+q
 WUmiRFanf0WRR1LyCFJ3SI0svDqe7XTt1BgCGENnJCUU/YA4wm3s0loZ+yid8B0ygHNvK0w0p
 0wKKHgelE/chdR489yPqw48OkcwKhqFRld1ZjZWFxA1eu52zEMYHarvvqBigqixNgdRJtsxxN
 bAuTMmig8cCKs1cKt3C6sKoqYnnVCBOt9QYav5RasNdFxmM+EwjjZuWxehNRldNnfLb8XgZaY
 BcSEhR9V3Age7YHV1xwM607FV5inh5y0yEVzv+kG4QuZO6voUmSuTL9lNUNDRZbt0jss8HeYU
 cujY9HnvgzDypsu/saj4PEzc4LPVuPE4jh8r7onRwKcg7CLMsMieqm8NRUbhWc185lV4QVb1Q
 8RnnpfeOW1MSR0+e5ZvN5XWazWc5fNND38yksaDPm8dc6lEbUMGrl1UvKbfL1Zk54lIYt0qSA
 iy5FnRpods84xRpJ8mR1oTWNZ2BVaNEKxjPOai/hW3GUpUbnnUrhhL7u4N5tm58G+xP2J9uZD
 j6QQzrYH7nJ5aNOnnthwugJTnHe2VjwO3ZKyzmSPJEUn136F7/hpQq7oL68lAnJj9tphSVFCy
 F5O0uNVpjIiMfB5DhLY8ac2xio3iEzg4JSQqsxEPvEr04m0Zdch6eg0J7qa8uCmwhEZ3f7Qth
 d+Xh2sQ5X/C0tPoVpGlamwQYxuKf/JqH5WRkc50F36obI=
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

On 3/4/24 23:15, Ivan Orlov wrote:
>  From the current documentation it is not entirely obvious where to take
> some of the u-boot build artifacts in order to flash them to the sd
> card. Extend the "Program the SD card" block by providing relative paths
> to the jh7110-starfive-visionfive-2.dtb and u-boot-spl.bin.normal.out
> files.
>
> Add "$(linux_image_dir)/" prefix to the Image.gz and initramfs.cpio.gz
> files in order to provide some information about where they could be
> taken from.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   doc/board/starfive/visionfive2.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/vis=
ionfive2.rst
> index abda8ac21b..031d66fbfb 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -103,15 +103,15 @@ Program the SD card
>

>   .. code-block:: bash
>
> -	sudo dd if=3Du-boot-spl.bin.normal.out of=3D/dev/sdb1
> +	sudo dd if=3Dspl/u-boot-spl.bin.normal.out of=3D/dev/sdb1
>   	sudo dd if=3Du-boot.itb of=3D/dev/sdb2
>
>   	sudo mount /dev/sdb3 /mnt/

Following the instructions the partition in not formatted.
You won't be able to mount it anywhere.

Looking at the boot log the author FAT formatted the drive which is not
recommendable.

> -	sudo cp u-boot-spl.bin.normal.out /mnt/
> +	sudo cp spl/u-boot-spl.bin.normal.out /mnt/
>   	sudo cp u-boot.itb /mnt/
> -	sudo cp Image.gz /mnt/
> -	sudo cp initramfs.cpio.gz /mnt/
> -	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
> +	sudo cp $(linux_image_dir)/Image.gz /mnt/
> +	sudo cp $(linux_image_dir)/initramfs.cpio.gz /mnt/

I have no clue why all users should copy the kernel to the root
partition on the SD card.

If you have a Linux installation on the SD-card, you want the kernel in
boot/. But this board boots fine without any SD-card from NVMe, USB, or
eMMC.

> +	sudo cp arch/riscv/dts/jh7110-starfive-visionfive-2.dtb /mnt/

Copying the U-Boot device-tree makes no sense it is already available at
$fdtcontroladdr. If you ever wanted to copy a device-tree, it should be
the one provided with the kernel.

This whole section is rather misleading for inexperienced users who just
want to boot a Linux distro on the board.

Best regards

Heinrich

>   	sudo umount /mnt
>
>   Booting

