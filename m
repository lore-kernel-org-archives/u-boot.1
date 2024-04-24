Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1615C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5FE886EB;
	Wed, 24 Apr 2024 11:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="NNS9eihA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86CE886ED; Wed, 24 Apr 2024 11:42:48 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48DB886E9
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34665dd7610so3455897f8f.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713951766; x=1714556566; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQm9s1RnLe6RNiK2QG4Hu6gRP+MqeDPW7udbQiW7n1g=;
 b=NNS9eihASM0yt8vb03z67Z2eoFfbDd1FF4Ki+omnOl2XeuxzP8cItLDPTxof+M29C4
 RJcyRkMM0Xcg12NyEOWpU+SIEg+XLduzmdgB8kDIyr3Sp4QFM3OgR1maGVBnSH6cont1
 fxn2eAxaYjGLxCWQfXV+/mc4L7EDKwBCpFlA/VutIXe61aihbkHjkh6HxSpZ3+W1tCwI
 374vj7sTBoQotOh0dHiD5CGAVEKGHSlUtk+ba5XPUgAfKDfC97VUh3Vu+4625DjSp82C
 KbyyeCI9/DH4FvgNcH7WJ0fxHzBciWr2wKEh/RNv6syMayL/vEUUf9I/aoU3UNAzidqu
 1+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713951766; x=1714556566;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQm9s1RnLe6RNiK2QG4Hu6gRP+MqeDPW7udbQiW7n1g=;
 b=a79pF0/p5YdkrAs+9Jk7S5zYqCK7/EJJZ0Klnhpoka1bMryWSrn0qs5pdZNHKRhPKA
 p66eUhdqWhIEtQSQPsx22kiTFqjsrd/4Vq+Prq8QGrTWpXQzavwNce9hDVKpCCMZvpXq
 rHjxVZcoGyYPR7cdawNI2plLnx7cwzh1Lf7EX/d+LPq+MLu9L3gNBaLlvV8LkZCaX9EZ
 YvZN4l975jCnhxRC4GqfRl0vCQvdBowbXtmHEs2/e8ezDEE7SNUxisaTqj8lG8B7EYdI
 WWlfkPNO8HFQd7xq6MIHaKVDIMWDrozFjh6X6qb4b7MndrgUNOqlfbBEFL5JSbq0kWAb
 A6MA==
X-Gm-Message-State: AOJu0Yxl2lNsX8u+iWEDN6R8CNvFn35dMWtpiz9trDVRi6BjdvWN+KZh
 W4FItGuUo15qd8CEBf1oU4mWKxsHbaIEa9Tgbg9KH6sYEYLYLcHi
X-Google-Smtp-Source: AGHT+IG2HbmhwNtbOVxTI1G4/QEOOCDVYUNye98Limty1HX6ZFwZIfRAJoI4TTiqPTk/ioY6Ik/tMA==
X-Received: by 2002:adf:ed46:0:b0:34a:e884:fd71 with SMTP id
 u6-20020adfed46000000b0034ae884fd71mr1373033wro.29.1713951766042; 
 Wed, 24 Apr 2024 02:42:46 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a5d434b000000b0034a2d0b9a4fsm15541730wrr.17.2024.04.24.02.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:42:45 -0700 (PDT)
Message-ID: <204ca121667e15aa4574d02beb3ff06855d5f31d.camel@googlemail.com>
Subject: Re: rk3399 issue: no DMA in Linux with mainline TF-A and U-Boot SPL
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Liu <net147@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Heiko Stuebner <heiko@sntech.de>, 
 Tony Xie <tony.xie@rock-chips.com>, JuliusWerner <jwerner@chromium.org>,
 DanHandley <dan.handley@arm.com>, Rockchip <op-tee@rock-chips.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
 op-tee@lists.trustedfirmware.org, tf-a@lists.trustedfirmware.org, 
 =?UTF-8?Q?=E5=BC=A0=E5=AD=A6=E5=B9=BF?= <sugar.zhang@rock-chips.com>
Date: Wed, 24 Apr 2024 11:42:43 +0200
In-Reply-To: <CANwerB1VhRichsmiozR3zTu2nWi0SsGg6Td5c8RuUe9rxrjsrA@mail.gmail.com>
References: <ea5147ee8606c47e4d714f8a3e0143d0fd9a1599.camel@googlemail.com>
 <80286c54-c617-d790-b7dc-efd4e52259eb@rock-chips.com>
 <CANwerB1VhRichsmiozR3zTu2nWi0SsGg6Td5c8RuUe9rxrjsrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
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
Reply-To: chf.fritz@googlemail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jonathan and Kevar,

> I also see this issue when switching between Rockchip ATF and Upstream AT=
F.
>=20
> Versions:
> Rockchip DDR Blob - rk3399_ddr_800MHz_v1.30.bin
> Rockchip Miniloader - rk3399_miniloader_v1.30.bin
> Rockchip ATF - rk3399_bl31_v1.36.elf
> Upstream ATF - git://git.trustedfirmware.org/TF-A/trusted-firmware-a.git,
> git tag v2.8.0, with RK3399_BAUDRATE changed from 115200 to 1500000 in
> plat/rockchip/rk3399/rk3399_def.h
> U-Boot - git://git.denx.de/u-boot.git, git tag v2022.01
>=20
> Results:
> Rockchip DDR Blob + Rockchip Miniloader + Rockchip ATF + U-Boot =3D DMA w=
orking
>   dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330 DMAC-241330
>   dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes Num_Chans-6
> Num_Peri-12 Num_Events-12
>   dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330 DMAC-241330
>   dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes
> Num_Chans-8 Num_Peri-20 Num_Events-16
> Rockchip DDR Blob + Rockchip Miniloader + Upstream ATF + U-Boot =3D DMA
> not working
>   OF: amba_device_add() failed (-19) for /bus/dma-controller@ff6d0000
>   OF: amba_device_add() failed (-19) for /bus/dma-controller@ff6e0000
>=20
> I can't check the Rockchip ATF source code as it isn't available.
> Any idea what is different between Rockchip ATF and Upstream ATF for
> DMA to work properly?

@Kevar: It would be really great if you could have a look into it.

I am still having this issue.

Thanks
  -- Christoph

