Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848BAC7112B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 08:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765B886B5D;
	Fri, 18 Aug 2023 10:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cTlNhuf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECD886C66; Fri, 18 Aug 2023 10:33:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BB5833DB
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692347628; x=1692952428; i=xypron.glpk@gmx.de;
 bh=NfMiD5ZDJZMmnGaqqiSO5kUkqCLsd4tAeY6w9oJHmNU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cTlNhuf5CaRty3eC1MNmPuGDgmUKFO2Q453yrhmBamswaz5270VtbY0FRJbq+m5flT1NUf9
 GkOb0QvWTdBoLoRU21ewucq0d2T9FO7CIvkGIRfYDAPKilIH/dzw1uz5vVqNjFWc//DBhoflE
 zssuyGnSBibXIrzuhUsDJRvLrcYuq/7fP3Lb0LyqmOZEvfrftaM3DVjSn3vL3YbyHqQI5H91d
 14/ZR59yknzHZRYEwJDr8eCxoZecgMGwSjcFTrl9lLpm29DBHqmW1T39vHD1PP86sFSmRDy8q
 vxYoAGA3U1uU/oHOjMqV2tG438JFUKpSAnV57zIFvPtOJ3zNHNfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1qbY151eyF-00Cz2G; Fri, 18
 Aug 2023 10:33:48 +0200
Message-ID: <2936e5c1-d401-e26c-9cea-83315273ddb7@gmx.de>
Date: Fri, 18 Aug 2023 10:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] Documentation extended with specific information for
 VirtualBox
Content-Language: en-US
To: thomas.mittelstaedt@de.bosch.com
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20230817134647.49259-1-thomas.mittelstaedt@de.bosch.com>
 <20230817134647.49259-2-thomas.mittelstaedt@de.bosch.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230817134647.49259-2-thomas.mittelstaedt@de.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KFNeKuTgC3etsns+Le6tfYrEabL0qQLDBx+LBIazRTm1XrwE3AY
 O1ozu7bH/ZoxWloMjcChk0cwxYOUugFqNK1IbtcXicqjgaIgyxUWE6jXx/gqpL9JuzLBvgQ
 VL3LWnymazc8w64yzdyYiMCKou6MDcaVQnFMRVSWaOb8a2JWnApOm40huRhPjCtuwe009Nf
 eim58Nmi2z05sjC5o8+Lw==
UI-OutboundReport: notjunk:1;M01:P0:dq+mmfEjsfE=;+ZF3kHxY7PEDNS9suuOQAVnxUW0
 +GFw1bFXMiqsE40KJwEdDKzq/GZ/OQFviuYlr5BiOciQ85RVkehcuhiW18HQnJaUhH20PruSv
 yqEXkjgFCXfV9jvnIoZgpDQ8hXB716NosmVXeJ96E8k8p3wEc0cq/4XOTp0lx9+aQMau7g7eF
 TST5p/qeQDbZzYldatTZSpPJhQJHgIbUm6PIa74TSz8vw1iNLy7G4XS7JsXanX0yfPg8wyewk
 ng4DEqTqpr6gEi22giGHggM2EMgQMWIvnVkPiataTOzGqes6aIuVH+LQZPTLuPo1+IqzR/DZ7
 S36Pu9uat2XckzH/3IV72qDN1XrKsVtxCB0JUJs+ctEZ9C2n967sPDoc2sxg+Np2CAQMeDA+a
 B+Ksd8HeaZos9jC2F1Bu1Q4ovm4WFUash8Z8NQJhNx5/Yn5VK8CUKdTY7ztpcuv9QnADqCi2k
 R5SNIbBq0kcSO3BRR83gNV3BSc8NpyHBmbLeiTamEODtLuznhJlzTWGei1/E6mZqZTPBBYTCE
 OfScC0IyPy8B8xQ0LKnhpEpA1L3V2oplzT7fD5eKH4VPU+UgmBOwVZEImdZih+KvOVmnrJfo4
 q5VfKtr3O89Fi/zpNDJWXIqSlVi55C+5KpyxqKq9TzYMoOLfc/Nb4fgTwxXDA0tS7UBhVqN1C
 DEHK5ovON7JhAcjQIWrvT7j1FmWXJj5gP3AKHjPDknJpwKSX/3FIRhfkEHvEFkW6K+Jx67LTY
 7DtSeiELpYbJVCFppnjqBiraPU8E6CZPfrLkAaWj2a4/Z4/vKn7bYLv7x7kZSz/2mwMpTVuQI
 J6KyGX059Pl/bTUeqlJg5+qeS6SESRTVce787+jZWNwhiCfdh0wOVAK3fy5mAXQmecS9OKbkG
 xiW8bD9lZvp5uMXEBcNy1ItLMpWcNhlKPdrNCigMp2oHKdtMs/bca9ViHVgip3eBUTvWeG0Ui
 iSwzO5cWaEcGGpXYITVJlJ6CzAY=
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

On 17.08.23 15:46, thomas.mittelstaedt@de.bosch.com wrote:
> From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
>
> Signed-off-by: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
> ---
>   doc/develop/uefi/u-boot_on_efi.rst | 76 ++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
> diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boo=
t_on_efi.rst
> index acad6397e8..927e1dc266 100644
> --- a/doc/develop/uefi/u-boot_on_efi.rst
> +++ b/doc/develop/uefi/u-boot_on_efi.rst
> @@ -254,6 +254,82 @@ This shows running with serial enabled (see `includ=
e/configs/efi-x86_app.h`)::
>
>      =3D> QEMU: Terminated
>
> +Run at VirtualBox (x86)

%s/at/on/

Below you assume a 64bit machine: %s/x86/x86_64/

> +--------------------------

The line length must match the heading.

> +
> +Enable EFI
> +~~~~~~~~~~~~

ditto

> +At settings for virtual machine the flag at **System->Motherboard->Enab=
le EFI (special OSes only)** has to be enabled.

Limit lines to 80 characters.

> +
> +Installation
> +~~~~~~~~~~~~
> +Install the needed system at a VDI disk and connect this to SATA contro=
ller (type AHCI) at settings

Provide the preinstalled Linux system as a Virtual Disk Image (VDI) and
assign it to a SATA controller (type AHCI) using the settings for the
virtual machine at menu item **System->Storage->Controller:SATA**.

> +for virtual machine at **System->Storage->Controller:SATA**.
> +
> +For the following description 3 partitions are assumed:

three GPT partitions

> +
> +- Partition 1: formatted as **vfat**, used for U-Boot and and its envir=
onment filesenvironment, flag **boot** set

formatted as FAT file-system and marked as EFI system partition
(partition type 0xEF00) used for the U-Boot EFI binary.

(If VirtualBox is UEFI compliant, it should recognize the ESP as the
boot partition.)

> +- Partition 2: formatted as **ext2/ext4**, used for Linux image and boo=
t configuration, flag **boot** set

ext2 or ext4


> +- Partition 3: formatted as **ext4**, used for root file system
> +
> +Create an extlinux.conf or a boot script
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Following files are assumed to be located at system for boot configurat=
ion::
> +
> + Partition  File                    Comment
> + 1          EFI/BOOT/BOOTX64.efi    # renamed U-Boot EFI image

EFI/BOOT/BOOTX64.EFI

Please, tell the reader which defconfig to use and which U-Boot file to
copy.

> + 2          Image                   # Linux image

Please, remove the blank space at the end of line.

> + 2          Initrd                  # Initramfs of Linux
> +
> +Boot script
> +~~~~~~~~~~~
> +
> +The boot script **boot.scr** is assumed to be located at::
> +
> + Partition  File        Comment
> + 2          boot.scr    # Boot script, generated with mkimage from temp=
late

Please, remove the blank space at the end of line.

> +
> +Content of **boot.scr**:
> +
> +.. code-block:: bash
> +
> +  ext4load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${p=
refix}Image
> +  setenv kernel_size ${filesize}
> +  ext4load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} ${=
prefix}Initrd
> +  setenv initrd_size ${filesize}
> +  zboot  ${kernel_addr_r} ${kernel_size} ${ramdisk_addr_r} ${initrd_siz=
e}

Doesn't U-Boot need this file on the boot partition i.e. the ESP?

Best regards

Heinrich

> +
> +Extlinux configuration
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Alternatively a configuration **extlinux.conf** can be used. **extlinux=
.conf** is assumed to be located at::
> +
> + Partition  File                        Comment
> + 2          extlinux/extlinux.conf      # Extlinux boot configuration
> +
> +Content of **extlinux.conf**:
> +
> +.. code-block:: bash
> +
> +  default l0
> +  menu title U-Boot menu
> +  prompt 0
> +  timeout 50
> +
> +  label l0
> +    menu label Linux
> +    linux /Image
> +    initrd /Initrd
> +
> +
> +Additionally something like (sda is assumed as disk device):
> +
> +.. code-block:: bash
> +
> +	append  root=3D/dev/sda3 console=3Dtty0 console=3DttyS0,115200n8 rootw=
ait rw
> +
> +
>
>   Future work
>   -----------

