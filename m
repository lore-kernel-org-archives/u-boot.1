Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED1FC61DB9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21BCE80B9D;
	Sun, 30 Aug 2026 10:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 148xBKZ4rGy3; Sun, 30 Aug 2026 10:42:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788086525;
	bh=JnuJYaMGWERU8UOJcRTYWS7njvzD8eJ0UZ+v6aTDJmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=085vYEJfrbLX4R7L2uvgGrr3F70oQlHOz27o6h6WHjCQ/iDKMhERozOgBbJImBNc8
	 lu+H1aCtrATrvfwRdntfCkKm73/+nT7vKuLcetuTGVLLdYxU5DfbwrkIi0tUtWrBEa
	 oT/uZgdg8xr1M/M2Rk+FUM+xfPrqU+wc+d/wJOEQpuIyXxtPZUDIB+cOUrZjtCCPt7
	 quROv/HnmIuH63p8Bi607kmD4DKtMkjy/GuubGu/GnZ5vmCpmWl+UOdvcApKVmdpUX
	 W1jx+KLtuTqYNaYZKNefz76N5BHo3N7eZD8loLvy5/7aSoPnFG0zME3i6NHpG/y6+4
	 yBQvuCpQViLDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D7FD80BA3;
	Sun, 30 Aug 2026 10:42:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44CAC1DE
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A4DB80BA3
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEFyD5FyY6_F for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:42:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WDbYIfKp
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 457BD80B9D
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:42:01 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-90cc64f7f86so31007776d6.2
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788086520; cv=none;
 d=google.com; s=arc-20260327;
 b=Tx3dClNGYJ4zGum57qFlDGca6b6z+r4DgNNhcWtxSo9kcGukc07f4/Xs4IdFO1P7bj
 aWu2rW39ilSmZI+BVe5lRaYDVQRtSKxmIn4iRqBb98oyqX/jGLwE4V5b10U+xcvUNRfZ
 2uiNtrb3w5XKYLlg9dLi9bX/fNVH+PcR9f2p6UZXI/3hElq4K2LORrZI8hq3CzchF58d
 1++I+VXcGy8K/f3TZSE7o9oTm4A8MEf4+Y8JLaF8llqalCacjFqw236800nSXHPujtuu
 nSfli2six6//xJqaH9xhtYAXs/j+9cr9cSFb+NiGQrlkVQPhKKeyXB7LyopEUqSV3vJ4
 cbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JnuJYaMGWERU8UOJcRTYWS7njvzD8eJ0UZ+v6aTDJmQ=;
 fh=e0JkGs2omtkuwDtYja7WDaTNcJA2/ErGx3TJSh8Rp+s=;
 b=ZrXymAoaJBz2FHNRRNujIfJX8gqH5hPeZoX7Cs3vvWK2grkX9z9tFsya/04EgpMAtl
 Cg8fVve3JtrfIDUMgjU3M185u8Fnb43BUFB6k3QVB+Z7m8L6r+DtM7Qo1F9MQPhsqTrr
 my215OW0teOkjysy5m/gqwDBIMLcxqIFg9uf4DbmDHmzp2gTQJV3DWbG1dFgObRUUhmX
 ow9/iWVWpcVX+cB8xy/71LC804kMAi8FVR+ocUc/OoLL6u4DBDkwx6F06KZyYDqja4Op
 rYig4GbJjaSNmdKlWXkO1TPoe7jJOUETQ22MVH7XkIUt4xEoiS0oemhuiUt3tCnscwOd
 aOVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788086520; x=1788691320;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JnuJYaMGWERU8UOJcRTYWS7njvzD8eJ0UZ+v6aTDJmQ=;
 b=WDbYIfKpQUx7wk7kzTCUCVSEpwgGcGE1FwS1oehzVKuHHAKxDe/LuxU66zn8Y9dAmD
 9ECgadEiQEY56lVWjbeHyUlIsNwPXm5fBc9HQMcjMUlss9eCmsaB+R0P6sHN0zyGZFK5
 SMgQ2evB5eCaGEondHbFxAkcuJ+GVl87d6RREK/PKL1SxsuaM6thbf0LULU0xTezFuyz
 nzW8xfWmYYciEYn85Q9s7UR6mN0csR8wnBYoKSpYFUfp5KKtZ2Ft4in+YQfZEJhSerWe
 oaKJj2jxCP28Zwmo4ciXPgYqd4GmAeVlBk+OGkjjDqenID3KR/2g3AOJyEV6iOUtOJQc
 WEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788086520; x=1788691320;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JnuJYaMGWERU8UOJcRTYWS7njvzD8eJ0UZ+v6aTDJmQ=;
 b=Srh4J+pE3lHKapH7cmuC4YOgHvezVXhLrvsPdtoV7Na2FCfuUrlvskIABD/s/Rt7eX
 ZAAwZZolvRs2qcJePtcuVBoeW6bQyFijoTxz5n0p78wqtl4O+8Se8QLqqtA3do9aQX4s
 0UgQwGpmuQRxyyVzdwt5v/uNcWSyToN3++BZFCi5uO7dDLmNPPtmkhpBx8C30mWreeSX
 FlCwcNrka0I2tYUp4VvkBRBtxvYCf3rNwoIUtDseVPdT4JAtIRmmoDAPCooHgq2NFHUw
 l6b0sT2mbKGtgV6sVBkeJyD1rLhJ/AZCDlayjCNSlP5SprLv6hq0sOsMQiYyq56QmDd4
 q7HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3s+Y+p+nT/9KqzASXigZcAhMBbrq18cFFBHf7B0GsNdFOGiHq1F4sIFHRnuDNac+Lh3cSzJw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mCBbMG0G9jDoCa+UMuDx0SyItlXO/hON5GUVvechkcqoFTN1Y9
 y4Etn4/CdFPPgtxY1RqY2Ylk9zlcc36+LcaG+yEQL4CW/kMkpRfSCQfuZf92Lh4EIaEQJHifSb/
 E9+riLwAQkPse0Y5S+105sd5YDgcYS3w=
X-Gm-Gg: AYBFou2xgtyWgvr2bGU4159DSr49zMtjjwriohUqkV8LNVtApAGpneX2IRSZRbbWvd+
 3/XKfK3MhCukcJDYbDNDA5manlRFGahUTpOUUxFYonhiTsUZLi7SBZmv8j5O4Ijm4FnRagG7NSc
 1SisIn0nfLrqTlSaN0JSRVeX7yFBaCoGGX41n2zMLpfTgNYtKT7ZKG/G/3A6RDIfTpBgMGZvZ1u
 bsBjkIcfqVVdbPBZdIlwcb3rJ7QEt5eoDOsfTVSNyUwR9Sb1AtKkAeEWuSgctiino+IKGxZ6Up7
 quCWEqh7x7DkLeukbDCRn3swgQdnfWqvyEHqPO0vj0IyxZckgvFpyXNCf1GiBpi9fBeRoNuP6+r
 6xbcHlClamNxIKYpWBPOhnFgZb9KmQ68K7VBNC8ERgg9na2LGr7h6FbJYpX2b+21vimhD5weD17
 PXLgdvS5UrYt17BiVLs4fmbMCNDjk1bxpsTBTSW3fkT5sg5q0LvQ==
X-Received: by 2002:a05:6214:2266:b0:90e:8399:6d2c with SMTP id
 6a1803df08f44-90e83996e3emr34024696d6.6.1788086520369; Sun, 30 Aug 2026
 03:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 30 Aug 2026 11:41:48 +0100
X-Gm-Features: AcwNN1XO1A39lYzoUT3Dw0KeEt-24zlqvSa9TiX9zRRimpSROKtDjySXflJLf-M
Message-ID: <CALeDE9P7UoeyBNfJycD2dUHkEeXiFgi+XaP9hAzKTp+71fvx1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] fs: Add 9P filesystem support over virtio
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Kuan-Wei,

> Add 9P network filesystem support to U-Boot.
>
> It allows U-Boot to directly mount host directories in virtualization
> environments via virtio.

It would be useful to give an overview in the cover letter how/where
you expect to be used. While new features are always welcome they also
come with a maintenance burden so some background is always useful to
provide more information.

From a network stack PoV does this work, been tested, with both the
legacy stack and LWIP stack? I would tend to push this towards working
with the LWIP stack as we're moving towards that being the default for
standard U-Boot (not in SPL) and I wouldn't expect 9P to be supported
in SPL.

Peter

> The functionality has been verified on qemu arm64 by successfully
> loading a Linux kernel image and an initramfs image via 9P, and booting
> to the Linux shell.
>
> To test with QEMU:
>   -fsdev local,id=fsdev0,path=/path/to/host/dir,security_model=none \
>   -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs
>
> U-Boot usage:
>   => virtio scan
>   => ls 9p rootfs /
>   => ls 9p 0 /
>   => ls 9p - /
>   => load 9p rootfs $kernel_addr_r /Image
>   => load 9p rootfs $ramdisk_addr_r /initramfs.cpio
>   => booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr
>
> Changes in v2:
> - Introduce DM UCLASS_9P and dm_p9_ops for transport devices.
> - Support selecting devices by mount tag, sequence index, or default.
> - Integrate 9p into disk/part.c and generic VFS null_dev_desc handling.
> - Consistently use 9P2000.L naming across subjects, code, and Kconfig.
> - Add kerneldoc comments and separate filesystem header.
> - Add timeout handling, feature negotiation, and remove callback.
> - Add 9P documentation.
> - Add automated pytest and enable in qemu_arm64_defconfig.
> - Fix error checking, bounds checks, and memory leaks.
>
> Kuan-Wei Chiu (6):
>   net: 9p: Add 9P2000.L protocol support
>   fs: 9p: Add 9P filesystem support
>   virtio: 9p: Add 9P transport driver
>   doc: 9p: Add 9P filesystem documentation
>   test: 9p: Add test for 9P filesystem
>   MAINTAINERS: Add entry for 9PFS
>
>  MAINTAINERS                    |  11 +
>  configs/qemu_arm64_defconfig   |   3 +
>  disk/part.c                    |  16 ++
>  doc/usage/filesystems/9p.rst   |  55 +++++
>  doc/usage/index.rst            |   1 +
>  drivers/virtio/Kconfig         |   7 +
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_9p.c     | 119 ++++++++++
>  fs/9p/9p.c                     | 185 +++++++++++++++
>  fs/9p/Kconfig                  |   8 +
>  fs/9p/Makefile                 |   5 +
>  fs/Kconfig                     |   2 +
>  fs/Makefile                    |   1 +
>  fs/fs.c                        |  25 ++
>  include/9p.h                   | 203 ++++++++++++++++
>  include/9pfs.h                 |  60 +++++
>  include/dm/uclass-id.h         |   1 +
>  include/fs.h                   |   1 +
>  include/virtio.h               |  12 +-
>  net/9p/Kconfig                 |   5 +
>  net/9p/Makefile                |   5 +
>  net/9p/client.c                | 408 +++++++++++++++++++++++++++++++++
>  net/Kconfig                    |   2 +
>  net/Makefile                   |   1 +
>  test/py/tests/test_9p.py       |  82 +++++++
>  26 files changed, 1219 insertions(+), 1 deletion(-)
>  create mode 100644 doc/usage/filesystems/9p.rst
>  create mode 100644 drivers/virtio/virtio_9p.c
>  create mode 100644 fs/9p/9p.c
>  create mode 100644 fs/9p/Kconfig
>  create mode 100644 fs/9p/Makefile
>  create mode 100644 include/9p.h
>  create mode 100644 include/9pfs.h
>  create mode 100644 net/9p/Kconfig
>  create mode 100644 net/9p/Makefile
>  create mode 100644 net/9p/client.c
>  create mode 100644 test/py/tests/test_9p.py
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
