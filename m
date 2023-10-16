Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258E2CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D201E86B81;
	Mon, 16 Oct 2023 13:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eLHR26XF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35EF5865A2; Mon, 16 Oct 2023 12:39:08 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0356868AE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 12:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cppcoffee@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c888b3a25aso25618015ad.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697452741; x=1698057541; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mkPINW9KVZmaZqeuANTy7mnCEcMJzH4W+xQ0aWgnzKc=;
 b=eLHR26XFjoZZhHLduJoDPBUzu+rdSNyAlljz3mABNvgxjCCZpYDh1qL+3kcpv7UYjd
 mVkUrvJDMxNYXaHGq+LZFpceqF8sXB3sZtYgXMJAS47RvtHmVXtL5xgbjDanMiznze5e
 Is3iFJt2zEett2iTOzwI+0Sn0RDCb/USxNPWZqtBiYRRnPiBiqVMCyf/1BhQiSV5RBhr
 ngPApb8Ja0W2P2+wzBgGzkady4tFSdnkP5ea0XRUDB75CpKrTvd3XYbhTwwx7AO5tplL
 zPP9EhdjibSAZ/ky7Kyxi9KXYpYAjT1+TTzlzurlvUo/OVs9eA/+VXGHCO6xC64qgp9M
 q7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697452741; x=1698057541;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mkPINW9KVZmaZqeuANTy7mnCEcMJzH4W+xQ0aWgnzKc=;
 b=xDhHfz0L+3iMF53Ad6vHzmnER9SSy58rwVd3+JYINkZjKN63qC+TAC1EH/pq273VYw
 OtClD204yDoerhDVQ1BNctGfZ4fBqP2XdrinYaFmr2sFrCVYb+OuUmlnkleSeEH79U9E
 SF2BR/KjR8QGZbbW4aH3vC4oIIbwBWX5Cw/E+1ugByXXPeTTYAkGU1OCPCVE3GIuns4q
 +aMOOn13bvFGm+Ce/Pksxc/A+4A+zxn3apF8JEjYJk4cGBq5nX19CoRCTmEw3XlTVmR4
 5lVxCn7IiF7gD9LNUXqlq4Gj4rs/J0/56jmnfCcYn2tUEvNNI086dQlDDfYda3ScdWEN
 tV1w==
X-Gm-Message-State: AOJu0Yw8fQwK6ecJCRrEz7i2ainQBQCe6OyvvacZfmaKKvV00UAE1Wpi
 bzRxVxhd/JEqjGuDmsP7xNIwQW7r8DXSSKoohfK7iu9USA/hzLFjqMw=
X-Google-Smtp-Source: AGHT+IGEUeDs1tZ8QRRX4UXmO/I2oJGV5K+e1G/ODrOAfc9D6EeZlnt8hzA/uR/6/SgrfjdAehy9cpHOYs/GmXN7MSE=
X-Received: by 2002:a17:902:f944:b0:1c9:dac0:fbb3 with SMTP id
 kx4-20020a170902f94400b001c9dac0fbb3mr9014071plb.31.1697452740888; Mon, 16
 Oct 2023 03:39:00 -0700 (PDT)
MIME-Version: 1.0
From: Xiaobo Liu <cppcoffee@gmail.com>
Date: Mon, 16 Oct 2023 18:38:50 +0800
Message-ID: <CAJeqHvL8xNKOZ=WD3PVjQVGz_S-EU3qDRCV1LwY4auOWxTq1dQ@mail.gmail.com>
Subject: failed to build u-boot mt7621_rfb_defconfig
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 16 Oct 2023 13:49:12 +0200
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

I checkout u-boot tag: v2023.10

https://github.com/u-boot/u-boot/tree/v2023.10

run build:

```shell
export
STAGING_DIR=/home/foo/openwrt-toolchain-22.03.4-ramips-mt7621_gcc-11.2.0_musl.Linux-x86_64/

make mt7621_rfb_defconfig
make
CROSS_COMPILE=/home/foo/openwrt-toolchain-22.03.4-ramips-mt7621_gcc-11.2.0_musl.Linux-x86_64/toolchain-mipsel_24kc_gcc-11.2.0_musl/bin/mipsel-openwrt-linux-musl-
```

build failed:

```shell
  CC      spl/common/spl/spl.o
  AR      spl/common/spl/built-in.o
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
  COPY    spl/u-boot-spl.bin
  SYM     spl/u-boot-spl.sym
  MKIMAGE u-boot.img
  MKIMAGE u-boot-dtb.img
  LZMA    u-boot.bin.lzma
  MKIMAGE u-boot-lzma.img
  BINMAN  .binman_stamp
Image 'u-boot-spl-ddr' is missing external blobs and is non-functional:
stage_bin

/binman/u-boot-spl-ddr/stage_bin (mt7621_stage_sram.bin):
   Missing blob

Some images are invalid
make: *** [Makefile:1115: .binman_stamp] Error 103
```

Is there a step I'm missing that's causing this?
