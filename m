Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BEAC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B1C87032;
	Tue, 19 Dec 2023 17:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BgtfNdpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB1F8700D; Tue, 19 Dec 2023 17:16:31 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554838743A
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a235eb41251so304435866b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703002588; x=1703607388; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Rbw0qiH29KhuJH/5Ij75WrRnuxQU+FAbyKVmQAvsW4w=;
 b=BgtfNdpdy2c3DbJ5tD3CKUdajQVI7eIfzCKlMLYeseBFCymORz5hxKEePVcKLtVgZi
 Y2PeIR66ax17GuV3R53Iy9KJpju0/OE9G9TyM7Qx7tftY3NlbhJHHlrB/mwrqgTDUrnQ
 thvB9yqxFgNPW1IyIy3mmrmlt6kE3h44nb/3MmwqhhdID4kjK/cPqzxKugbOyZNqEtXP
 SziUgaLNb8nkbhF5JCiB7+qdXPb71ZsdNgrShBd5q3lEGg11rXnwcjL6/T06Z1f7d+ZC
 X/wrXtg4jn+KYvIWUR8bimFv8pGasQAl293ND0hNIUulXE6qFVvrZuAL74i9nXy/QBhi
 6jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703002588; x=1703607388;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rbw0qiH29KhuJH/5Ij75WrRnuxQU+FAbyKVmQAvsW4w=;
 b=twon7ZAYuBSG2ZH3sOuplL6vfs4T+3SIzWmb8tv668U2/w8cyvF7n4WrPMJPxttYn3
 Cl6D2MgZtM/vdWVov1Y01kKfs6OuEiFtmUudUhDlg08TfEYCfDc9AF5yVuWfzjPLD0c2
 6Ix3THZn2l++0ze3olYIso7XfP/gtMB2grMVSSu98GYxJlOlBoBzUiCAmCIAI+3Ohtwo
 uYCIIR9OQrrKDGGhzijQP2u2Mmk7mEXuHdVJsGJSzFpQbdr83u5qXClTRBTf8siFKnPh
 E88VQsB+oWXEH+19ZS1eWnhm6hYmk3WOcE0si0Tt2ipurWkjiy7gjHc0EqVO/ByeNA1o
 8Tlg==
X-Gm-Message-State: AOJu0YzsDm9XUqLVAeN7+LIi4dDw3+AilMmpLjGS+uQt3SxxHmmmb3sQ
 JnvELNZILtHvRP80v1BF+nn7WIV5/lVTDi7OMl3b4/SBykU=
X-Google-Smtp-Source: AGHT+IF66F8Igpv9IXomkwtJ5CavJONb4AGTdXxIK6745Kk5Rr6KMiYsDmW3Z7aaSCSu5q+yNlmi8mTJH06lCEt3xws=
X-Received: by 2002:a17:906:fd85:b0:a23:329c:3435 with SMTP id
 xa5-20020a170906fd8500b00a23329c3435mr1986712ejb.68.1703002588055; Tue, 19
 Dec 2023 08:16:28 -0800 (PST)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Tue, 19 Dec 2023 17:15:51 +0100
Message-ID: <CA+1FSii-TywZeob9tHirWYE7vNMC=LPK76LAgRopKVQUzSeYzA@mail.gmail.com>
Subject: How to boot FreeBSD as a domU using u-boot.bin as a kernel bootloader
 on my ARM Chromebook
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello.

I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook.
Basically there are two ways to accomplish this task :

1) to write a patch that allows the FreeBSD kernel to boot as a zImage
file. This could be accomplished applying this patch to a specific file
that's on the source code of FreeBSD :


https://xenbits.xen.org/gitweb/?p=p...8;hb=0782e25d98cc1391472717035f986c979edef0c9
<https://xenbits.xen.org/gitweb/?p=people/julieng/freebsd.git;a=blob_plain;f=sys/arm/conf/XENVIRT;h=ff6433392e6fc2d5fa7c1ad1f7c40155003af9a8;hb=0782e25d98cc1391472717035f986c979edef0c9>


This patch was written by Julien Grall a lot of time ago and now it does
not work anymore. This is the reason :

It appears FreeBSD-CURRENT removed the last step converting the kernel file
to kernel.bin. The patch can be readily rebased, but without kernel.bin
that doesn't do too much.


So,without a rebase of that patch the first option is not applicable. And
I'm not able to fix it.

2) booting FreeBSD using U-Boot,as explained to me by a xen developer :

I was trying to explain why and how Julien's patch works so that you could
be the one to re-do something similar or fix the patch on the FreeBSD
kernel that you are working with. I am happy to help review and write
patches but I don't work with the FreeBSD kernel so I wouldn't be able to
help you quickly. However, I might have a suggestion. Do you know if
FreeBSD can be booted by U-Boot ? Because U-Boot definitely boots as Xen on
ARM guest firmware/bootloader. You should be able to build U-Boot and use
the U-Boot binary as Xen guest kernel, then U-Boot could load FreeBSD from
disk or network and start it. For instance as domU config file:

kernel="/home/petalinux/u-boot.bin"
disk = [ '/home/petalinux/test.img,raw,xvda' ]

I know it is important to build u-boot with the following config to make it
work on Xen.

CONFIG_CMO_BY_VA_ONLY=y


According with these suggestions (and with the suggestions of a FreeBSD
developer) I have compiled the needed u-boot.bin from scratch using this
procedure :

# git clone https://github.com/u-boot/u-boot.git

# cd u-boot

# ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make snow_defconfig : this
line generates the file .config

# nano .config and I've added these parameters :

CONFIG_ARMV7_NONSEC=n
CONFIG_EFI_GRUB_ARM32_WORKAROUND=y

suggested to me by a FreeBSD developer in relation to the FreeBSD fragment :

https://github.com/freebsd/freebsd-ports/blob/main/sysutils/u-boot-master/files/FreeBSD_Fragment

but I haven't added this parameter :

CONFIG_CMO_BY_VA_ONLY=y

according with what he said,instead :

"I took a brief look at your post and it seems to me that the option
CONFIG_CMO_BY_VA_ONLY is irrelevant to your target armv7 32 bit platform :

https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/cpu/armv8/Kconfig?ref_type=heads#L3

Finally,the uboot-bin file is generated with this command :

# ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make

At this point,I took a look inside the .config file and I saw that the
parameter "CONFIG_ARMV7_NONSEC=n" has been removed. So,for some reason,it
is not accepted and this could be a problem....

These are the xen config files that I've used :

nano freebsd.cfg

name="test"
kernel="u-boot.bin"
extra = "console=hvc0"
memory=256
vcpus=1
disk = [ 'FreeBSD-13.2-RELEASE-armv7.img,raw,xvda' ]

nano start-freebsd

xl create freebsd.cfg
xl console freebsd

This is what happens when I launch the vm :

# ./start-freebsd

Parsing config from freebsd.cfg
xc: error: panic: xg_dom_core.c:689: xc_dom_find_loader: no loader found:
Invalid kernel
libxl: error: libxl_dom.c:571:libxl__build_dom: xc_dom_parse_image failed
libxl: error: libxl_create.c:1640:domcreate_rebuild_done: Domain 1:cannot
(re-)build domain: -3
libxl: error: libxl_domain.c:1183:libxl__destroy_domid: Domain
1:Non-existent domain
libxl: error: libxl_domain.c:1137:domain_destroy_callback: Domain 1:Unable
to destroy guest
libxl: error: libxl_domain.c:1064:domain_destroy_cb: Domain 1:Destruction
of domain failed
freebsd is an invalid domain identifier (rc=-6)

-- 
Mario.
