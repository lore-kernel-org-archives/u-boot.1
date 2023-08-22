Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAEAEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 13:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2D9864D4;
	Tue, 22 Aug 2023 15:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wg1lXIqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF670864BA; Tue, 22 Aug 2023 15:27:21 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AA1864D9
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-500760b296aso3253921e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692710833; x=1693315633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2atq8xQ1ocvOZX/e1gjac1idNFLyOCBPBEVXz9pu5v8=;
 b=wg1lXIqwBpeYaMF48Qinmaj87+XYxuQId0BuJinCL8D/XFdF1t2xSSbznQHmZ9s63s
 h5a0r1s9PBNreUn/rNVgyAtHnxnjNU4Tz/45SUTxJlYAElbRhzMWfcokNmIekGrpUoXd
 VJSPrlPTVvfYClg3QKAkh1uxoQdWCqynrEr8AIy/F7IGLgaxevE477X/mWnLauLRgv5D
 TiQjfndLYrr5QhLVEPBltCeSkSp1zo5lwS8LQpr0YzfLHM9Y8n3Y7TNGL1Y84Bupe/lg
 5VWCLJ5ByyAlw3Iqad9+h63VMFu3/zzKPkB2LcJ5hPGJdmJqzNvqf5GBNErRwne69Eal
 eM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710833; x=1693315633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2atq8xQ1ocvOZX/e1gjac1idNFLyOCBPBEVXz9pu5v8=;
 b=kJU3EjNIE5q2ISHvz/5xT2ZqtQYdh2dyZyrLOgBNUgOvhKkNbcbWgsHSBiHQNp6qNm
 dV7El1AskpNSE+cwGCCdS5j0gbKBdlbt1lNlra968dGq8Nt0gkHje26r6VReF5I9Scp/
 +KprehjjMolJaC7UvbuyMeFESZeEhVKoGtu6qhfkk7FTlkVqb9Mjh1aMD9vjPHeeSk6a
 yvtk1t8n60nchiOH8CNcOrLRqDutkL+NI52E6u7u+F+Di2CWgHCWdJ/ddZE/b3PJPs4i
 EN2oyEhB7xMbknITIbeM9WKMul72cD9wrpL4edQD0iM6NZ4VTWH2QSl+JuHn35w6S7Z4
 d4pA==
X-Gm-Message-State: AOJu0YzMX8OhMh5PXR8woUBUQsa3Kwjb9y/5EcN0FpGKwc420meGB7yA
 02wwpDITObrcQ6JBgrd4nVhmPua9A8DLFtKawTEMRaZ8Schd/0mhXQE=
X-Google-Smtp-Source: AGHT+IHmBz4yPT9UWLxaLU9K3nstrip/iYe382N9blovOfveDqV4YjeFIroN90ml0u0BsZV1ZHjaymf6uvRYNh5um1Q=
X-Received: by 2002:a05:6512:114d:b0:4fd:f6db:a7d9 with SMTP id
 m13-20020a056512114d00b004fdf6dba7d9mr4215441lfg.32.1692710832549; Tue, 22
 Aug 2023 06:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
 <20230822125858.8018-3-thomas.mittelstaedt@de.bosch.com>
In-Reply-To: <20230822125858.8018-3-thomas.mittelstaedt@de.bosch.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 22 Aug 2023 16:26:36 +0300
Message-ID: <CAC_iWjJRih=5BCQJNZ2Mvp-m1QDt_+D61VLS5HSNh-8dNXu-2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation extended with specific information
 for VirtualBox
To: thomas.mittelstaedt@de.bosch.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Thomas

On Tue, 22 Aug 2023 at 15:59, <thomas.mittelstaedt@de.bosch.com> wrote:
>
> From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
>

You need a reasonable commit message explaining why you want to change
those files

> Signed-off-by: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
> ---
>  doc/develop/uefi/u-boot_on_efi.rst | 84 ++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
> index acad6397e8..0d4927807c 100644
> --- a/doc/develop/uefi/u-boot_on_efi.rst
> +++ b/doc/develop/uefi/u-boot_on_efi.rst
> @@ -254,6 +254,90 @@ This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
>
>     => QEMU: Terminated
>
> +Run on VirtualBox (x86_64)
> +--------------------------
> +
> +Enable EFI
> +~~~~~~~~~~
> +At settings for virtual machine the flag at **System->Motherboard->Enable EFI
> +(special OSes only)** has to be enabled.
> +
> +Installation
> +~~~~~~~~~~~~
> +Provide the preinstalled Linux system as a Virtual Disk Image (VDI) and assign
> +it to a SATA controller (type AHCI) using the settings for the virtual machine
> +at menu item **System->Storage->Controller:SATA**.
> +
> +For the following description three GPT partitions are assumed:
> +
> +- Partition 1: formatted as FAT file-system and marked as EFI system partition
> +  (partition type 0xEF00) used for the U-Boot EFI binary. (If VirtualBox is UEFI
> +  compliant, it should recognize the ESP as the boot partition.)
> +
> +- Partition 2: formatted as **ext4**, used for root file system
> +
> +Create an extlinux.conf or a boot script
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Following files are assumed to be located at system for boot configuration::
> +
> + Partition  File                    Comment
> + 1          EFI/BOOT/BOOTX64.efi    # renamed U-Boot EFI image
> + 1          Image                   # Linux image
> + 1          Initrd                  # Initramfs of Linux
> +
> +**EFI/BOOT/BOOTX64.efi** is a renamed build result **u-boot-payload.efi**, built with
> +**efi-x86_payload64_defconfig** configuration.
> +
> +Boot script
> +~~~~~~~~~~~
> +
> +The boot script **boot.scr** is assumed to be located at::
> +
> + Partition  File        Comment
> + 1          boot.scr    # Boot script, generated with mkimage from template
> +
> +Content of **boot.scr**:
> +
> +.. code-block:: bash
> +
> +  ext4load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${prefix}Image
> +  setenv kernel_size ${filesize}
> +  ext4load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} ${prefix}Initrd
> +  setenv initrd_size ${filesize}
> +  zboot  ${kernel_addr_r} ${kernel_size} ${ramdisk_addr_r} ${initrd_size}
> +
> +Extlinux configuration
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Alternatively a configuration **extlinux.conf** can be used. **extlinux.conf**
> +is assumed to be located at::
> +
> + Partition  File                        Comment
> + 1          extlinux/extlinux.conf      # Extlinux boot configuration
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
> +       append  root=/dev/sda2 console=tty0 console=ttyS0,115200n8 rootwait rw
> +
> +
>
>  Future work
>  -----------
> --
> 2.30.2
>

Thanks
/Ilias
