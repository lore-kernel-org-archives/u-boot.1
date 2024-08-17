Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C65C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F27884AC;
	Sat, 17 Aug 2024 17:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbRF8OnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA62C8852E; Sat, 17 Aug 2024 17:55:42 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC4088498
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f3cb747fafso6968281fa.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723910140; x=1724514940; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXx2sRKYvxfA5mHrLgdqxRHgTQPfM8gN2gKouh0unko=;
 b=fbRF8OnI4R8MM3LQCf7N4r6xiYo9Wi8Oq2uDaDvri2ouE9ZGNPNfmJmKvRdcNpuhCg
 ltFqbO2CkLd9aHddFqfORaav7WgnWGWeHdLNhXOCtcbXdrVghDh9ZehNuxEbXTeY/4di
 2JOtrd7HKj7Ki2zWhjxI1y7pCALbIQVL85x6zVY/ojj/dxzyMNsvvml+VDYpqlmIVr6/
 8NFRVQDNs7DwH/D/So/gg6HGtD/2xnQHUDa2qphPMg5mcHsCQ5uYs7k9hBaGqQs0BpzP
 ASOx6p4zv7ZBzFoJWeRZQAakGSh5qX8IDVmFOlkKnXwY0FQVdfuiXaiuhbnl2pFr9V1e
 /4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910140; x=1724514940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXx2sRKYvxfA5mHrLgdqxRHgTQPfM8gN2gKouh0unko=;
 b=Yt2G5DLIUJHcSqEsaGN7+fY2zef7Ff7Bd49lkufBeQ2WVJIn8rFDDuCp1P7qL5UNj2
 KfSNx8GRpmOauBNtqWlJA4VBxQ+Dp2w0ZvWPrxfN4NZEl8Lli1rV+bHfxZJlz5sNlRCm
 5hwxYL47BDi4fTX3QdW2uPHVK9MD+HaxsgE9OsteV/xXrGVbcN2S7lrUizcnKRDsqHwv
 HlSatOGN7SzLQz40vHOUUXCOOpqwBrsE0lCPgkXbc2PCc/3jcSo91w0FDQ0n/tilhWxF
 lUDzCY+mK54G0jxkocGcmg9fduW1XZICiVCutpw0oW43u5DI9t/U1c6bdtgcNhuQXLdG
 NdNA==
X-Gm-Message-State: AOJu0YzU6J4X4tl2UP3JKCb5cwxiD7u5lLq1TNEOSeNSzrFFFJxDCO1d
 vALGT8BwUdsvwayJt8UzhU8fu8yNPe4L2UXQ17dwh+7FrL0US250kV5J2C0hRyqL8dAtBXYhfUI
 GZ+jOYZfCJJZGZHM7kuhY9Y852VA=
X-Google-Smtp-Source: AGHT+IEw96qx14HTGSROaW48z6UIYAWZqkcIvEdJ45zUYOOKF8f5zlzYH1GNaW+qFXYqWqONio5ySGmOGNBZh9M0SO8=
X-Received: by 2002:a05:651c:1549:b0:2ef:24f3:fb9b with SMTP id
 38308e7fff4ca-2f3be57578emr44896821fa.7.1723910139292; Sat, 17 Aug 2024
 08:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
In-Reply-To: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 17 Aug 2024 16:55:28 +0100
Message-ID: <CALeDE9PO7nR9=tku-gDDBUkDK9LxoKeFbc4WQwAy70v2Qugvkg@mail.gmail.com>
Subject: Re: RPI CM4 - I2C BUS and Device Tree
To: Romain Crausaz <crausaz.romain@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi,

> I am currently facing an issue with U-Boot and a raspberry pi CM4. Here i=
s
> the setup:
>
>
>
> 1. Yocto Scarthgap
>
> 2. U-Boot 2024.01
>
> 3. rpi_arm64_defconfig
>
>
>
> I am trying to access the i2c bus from U-Boot. I have been trying to modi=
fy
> the device tree which is referenced as
> =E2=80=9CCONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b=E2=80=9D=E2=80=9D =
in the defconfig without
> success. I can remove everything, set all nodes to disabled and I see no
> change in U-Boot (I am using dm commands to check the status of the
> peripherals).

What i2c driver are you using in U-Boot?

> It seems that with the rpi, U-Boot will only configure itself against the
> device tree passed by the bootloader of RPI. Could someone confirm this ?

By default, yes that is the case.

> Is there a way to configure / modify U-Boot to use its own devicetree and
> simply pass the device tree generated by the rpi bootloader to the kernel=
 ?

You can do the former, but I believe that DT is then passed to the
kernel, you can't specify differing DTs.

> Because the second issue is that the i2c driver defined in the device tre=
e
> passed to u-boot is not available in u-boot.

Well I think that is the main issue, there's not a driver the RPi i2c
IP in U-Boot, if there was a driver the DT provided by the prior
fimware should then work for what you're trying to do. There's no
driver to date likely because no one has needed to access i2c on the
rpi in U-Boot so it's not been contributed.

Peter
