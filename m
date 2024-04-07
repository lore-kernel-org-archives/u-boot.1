Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B6CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 16:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAE587CF9;
	Sun,  7 Apr 2024 18:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f76gnWm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D162687CF9; Sun,  7 Apr 2024 18:54:51 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 757E387F64
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 18:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a2bcc0c075so1123054a91.0
 for <u-boot@lists.denx.de>; Sun, 07 Apr 2024 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712508885; x=1713113685; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFQtSxBu/EeKbxPxuN89OsVuAuDv+dROTHazId3mOHM=;
 b=f76gnWm0DU9ll7w8ffzrH+0qKzvtiJUC2JgKUwmY0EOwDCXFTT8Begf/b58PLzAERm
 CXIyvozEg5mCQzS+G8747PALnVUlQ+jNaze/Kkdz1KFL2NUz5xXltPIBWYZe2Y0UYezw
 J9vpbrmcpG7a9bCx0hnfcRtuWDlFqYKSt+Jm4OOpAuMP2HVWoODPPhJbV5RFvos++JJl
 81eH20+98bZeFYBFp9BNKsrb55srF4ZAm3V9DOAc+M2Hy2AI9/Ri71PlopOYDcJajVVK
 btEFWwn1YvXq34k8yX8SSv6JWv7ey5ho+jwPigxXIWrGXp+2NxV+iVm1iT5SZ12fhSu4
 whCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712508885; x=1713113685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFQtSxBu/EeKbxPxuN89OsVuAuDv+dROTHazId3mOHM=;
 b=qes1yUEZ09zfVgtWh7h4zSoqifNRmDxwsMRC48puudrU4qlVh+FG7manG1CI+mbckG
 O7HrquK842r7sAwMn8f8n9HVNiZ3ZP0HOKK1U6rgtW8J+eThTYLSDuc1cgwNu1rT682r
 ahgMhSV9LfwuCP1N1ouGeDarnxp26yMNj5It3XgI9lu5pDBPnE4xPIWF+I2OSIYb4KMs
 dDSN9k2OTbVk+PnybEreUV/kNLsrgRKdxAyE/B6AHRePDVk74954SNAb2raqdmsrDPiR
 XhmzNw7ALgQHgmezZX2tc9VX8D5adFIramcC84aro3Xk7+oihrQ+0KRDxqXvAqsWIzsq
 FNEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFM/TD7ZVF94j/lBM9Ii1hi5NqtQ3VfdPOeTzt0zp5lyBjNXn9s3jrP8hqtaxbB9GAMiVhsesuRtHKIvg8OeElbHQR7Q==
X-Gm-Message-State: AOJu0YwqSuLfoqudwGBQrEmqXanbb/MmADd8aIKXOQyD5L+uWcFJ5ixn
 QDV51F2wEBxiliHFZNrdSJiYbI53E81q5qkE9BwLPPt87AX79WljAcLxE2kzpl89+eL7sTIxk3A
 BCom6tBPuWOfEXIvQ7bo8O4YUvyEa+JHB
X-Google-Smtp-Source: AGHT+IGIFR0fVuhxzosDTO8yMqSfF/Gmn1FvM+TxS+C075bOYyKyYJCLMCYigM2gtAXrqwXsX1JiwC1s8RpOXmZugXk=
X-Received: by 2002:a05:6a21:6da9:b0:1a7:5707:4667 with SMTP id
 wl41-20020a056a216da900b001a757074667mr4377223pzb.0.1712508884919; Sun, 07
 Apr 2024 09:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87v84ta2jj.fsf@gnu.org>
 <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 7 Apr 2024 13:54:32 -0300
Message-ID: <CAOMZO5Codo2sBCugD4cgF72rTqzNN3Zo0i_3HJOwNHdKYhKMZA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
To: Peng Fan <peng.fan@nxp.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peng,

Here are some comments unrelated to the UART issue.

On Sun, Apr 7, 2024 at 7:35=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> SOC: 0xa1009300
> LC: 0x2040010
> M33 prepare ok

Could you remove these three lines?

They are not very helpful and add noise to the boot log.

> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0
> Load image from 0x49800 by ROM_API
> NOTICE:  BL31: v2.8(release):lf-6.6.3-1.0.0-10-gf12d90141
> NOTICE:  BL31: Built : 09:34:44, Mar 27 2024
>
>
> U-Boot 2024.04-rc5-00388-g351988e2dce (Apr 07 2024 - 19:29:56 +0800)
>
> Reset Status: POR
>
> Could not read CPU frequency: -2
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz

Please fix this. I am sure the CPU is not running at 0 MHz :-)

> CPU:   Industrial temperature grade  (-40C to 105C) at 26C
>
> Model: NXP i.MX93 11X11 EVK board
> DRAM:  2 GiB
> Core:  188 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout=
)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from MMC... *** Warning - bad CRC, using default envi=
ronment
>
> In:    serial@44380000
> Out:   serial@44380000
> Err:   serial@44380000
> switch to partitions #0, OK
> mmc1 is current device
> Net:
> Warning: ethernet@428a0000 (eth1) using random MAC address - 6a:c2:96:d2:=
68:a6
> eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000

Aren't the MAC address fuses programmed? Or are they not being read correct=
ly?
