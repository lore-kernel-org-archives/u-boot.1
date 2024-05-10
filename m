Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72E6C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 14:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BF288149;
	Fri, 10 May 2024 16:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VUldzUmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8A788119; Fri, 10 May 2024 16:19:52 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B28488149
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2b360096cc4so573130a91.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350788; x=1715955588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8LQdmgiNEZrOkfZqpgO+jypq/+hjRbWSKokCJVpk5Iw=;
 b=VUldzUmj9dooc0p6BSrZdGJxZ/EylGOcmoeu6Vx6j7xT1IeBO4rFka4CSAFN/x5fPC
 9thwGdmVzfRfYY9Gu4E1k+sAVaNdrCp5g6KipzVo+wTVc1BXWoF7xpBfcZgCb+mettR2
 HnjsiU2ouE6npK/xsoiqQNR+UlxaO0BIRv5YmowVfKZ3eJdRB6VjRY/SkrqJBTArn4s7
 I6iDYuxR9LGxa7HQ2l+ThMV/jswo0G4N7YcQC248fO8F7IB/MoqiNchK7BAOer69Bja+
 ouXm8XLAOxzF81eXtqhP0jrvY5FU30xaExWpAs52uyJDSU82gLYvr+WH8YRYFWDRjZz7
 0aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350788; x=1715955588;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8LQdmgiNEZrOkfZqpgO+jypq/+hjRbWSKokCJVpk5Iw=;
 b=RjmCLX7LnfwCRywIyE2TpLIP6tvbWk/ZBZeldfmrC1ipK86FhifEE/VmY3J75IShPQ
 BjjEX5ykQUfdfHsN8PhhUZa9km76ICH0+2/2iDaAhCTTDhWQc3H9O7XGrZds25OznURR
 Qr3bDxlSE3l4an9txiUn4maCkaVduoIK/bR3uwTOcfqPnDRKMHxn8Bcm3OUgqYdGliGq
 zgfkSVdaL3geOOQXvBOdL1Bn61Kkb56FUFRxG3Fa0THlyeK00aJT9Jqaauk36DQhyY6Z
 UZeTWxmMpqXyd0zAEAyXnOgFnGkia5iqPWGrW637U4xN+JjYaAVw2lZigKK/UvsSaaHT
 zLiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTHpCo5W4XR35yPLeaPNunnvnqWuPCPCvtx+1rcdtoN5ydFx5ZzgdZzFddvwMNgvOA5EXVcnZ5sC1s42uE4qUKkcsprg==
X-Gm-Message-State: AOJu0YxxD4RaEV+A6qgxvy84Xdbr9e5czUgoLH0lmGx2wpiVJWtAjrOR
 2fxiW/vUlE38K5FBlblC1d4KInUmNSdT2tZKpOhk7JNStBsvZduldJlJVvQ8Wn144TIWdUSANMF
 VGcn1IZ5PL/mmbLrMnUf3f2X8GzM=
X-Google-Smtp-Source: AGHT+IHfR0/R5wa1uPYwFgVyUYTL0mk1+8eK07e5lOIsXMzCb1J9EIr6iRu8ySuy6mBnbGvmb7DHFbS2+zVtcyHx//M=
X-Received: by 2002:a17:90a:bd0f:b0:2b2:4bff:67b7 with SMTP id
 98e67ed59e1d1-2b6ccef5a6emr2563348a91.3.1715350786484; Fri, 10 May 2024
 07:19:46 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 May 2024 11:19:35 -0300
Message-ID: <CAOMZO5AnweEsKk_LXVLRmC5=6L2x-Oo+rdngsAs_hcrSHFH91Q@mail.gmail.com>
Subject: imx8mp: Flashing U-Boot into eMMC hardware partition via UUU
To: Frank Li <frank.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Adam Ford <aford173@gmail.com>, Heiko Schocher <hs@denx.de>
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

Hi,

I am using an imx8mp-evk board and I can flash the U-Boot into the
eMMC hardware partition 0 by running:

   => tftpboot $loadaddr flash.bin
   => setexpr blkcnt $filesize + 0x1ff && setexpr blkcnt $blkcnt / 0x200
   => mmc dev 2 1
   => mmc write $loadaddr 0 $blkcnt

Now I want to do the same via UUU.

I tried to create a script called emmc_flash:

uuu_version 1.5.21

SDPS: boot -f flash.bin
SDPS: done
FB: ucmd setenv fastboot_dev mmc
FB: ucmd mmc dev 2 1
FB: flash bootloader flash.bin
FB: Done

Then on the PC: uuu emmc_flash

U-Boot is loaded to RAM, but the eMMC hardware partition is not programmed.

What is the correct script for doing this?

Any suggestions?

Thanks
