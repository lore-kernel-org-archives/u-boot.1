Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04DC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 15:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F7888361;
	Thu, 20 Jun 2024 17:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r92/uqi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDC888377; Thu, 20 Jun 2024 17:23:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9508813A
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 17:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718896982; x=1719501782; i=xypron.glpk@gmx.de;
 bh=L05Spg/aDnqR8jFbrcd2apcJwHE9qQ+ZQyuXfHG/lh0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r92/uqi5/D1+izpPDsqbfGMLwTaHMGjrt3y7/x0gf1+jOmgTUtaPmHeq6r0qlR5a
 ffkrzwh15waFa0jxGP2Omhf7PDwMPtRN/1DKtv8vjCIqqY/MPWfgrwtAtVVoF1wEU
 AeIjCuqYN82NaQ2wky/KWOTqWFI0JPjwnJ5zhIv74OHFRiKBbimvzaVdNMvdtBd6S
 sDehXZJUYVUdRTHs/MsAxbDJTfhaPggVaSumLyFZq2jlzh+Juc1mqOMl+/ibgiss6
 7EcEP3tFWq0vo1vWTzEbhMcZnQsoNBCmC3Yfh/tnfK0rDGBKUgDMNWzcWkyuWQLoJ
 YQhgfbtcxhTCnLAUSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1sQU360roE-016E5m; Thu, 20
 Jun 2024 17:23:02 +0200
Message-ID: <ccc37e73-4687-4bb6-9515-8a4d8d4c2063@gmx.de>
Date: Thu, 20 Jun 2024 17:22:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jon Humphreys <jhumphreysti@gmail.com>
References: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zF1NSehR+i3qub42fZNx6Z5WPlnxgglfaZq31Bte68XJuc383Xo
 2slj7XMx8RfShfl5CPbepFmRFbCSMa5QA1X7TbVeaDEyMCff+NHek7fUYduMfFc+yjv7wDR
 oyXnVmtXtjQzjhZ1pNur2SlzJPOz6VR0XOWbfoL2N5D9Pa1XvfD28SYYGeooJinamkxC/qE
 vna04/hAd2vQINEAf1zcQ==
UI-OutboundReport: notjunk:1;M01:P0:HZu2cHBBlPg=;XL5Xee49zWFDzfHYRf0GiQ5hBXG
 xzrzWH2Jlr3CigFwK04cPiI4qqU37gWzc8A0bDr+5Ak3s4/vhvo3tLMZJa6j3qQrnkvCIoLwm
 yZVOdp62gutPq6p6vF6uO5ZLV/oQuQ44/1Wda2LMPmITeo/FztuKwa7OUR1vWk0SjnazBD34L
 wr/MnfRFd0QU1BJeH1a9/Z8y/my7BntgcSmJuoRoB9i4O5Hz9cn8gJBunqeuRlELBWy2hQf9u
 K+oOJDRZv9qTvAdH3YE/Y1DZwNa7O3679UPvtTemE3Fxxeu7pCbe0+weEWuUv7hQefh6/AgVV
 K/gnGk1BO8bQnSbwlatiwQYhpJyIN4HpJTu5kWTyOTcqnkvV0IZzr8VoGLJ+u0MWv7vIlYKTi
 hm1J0dy+HCfXBVovXrd8wfOnTYXRLArO3RiKJEyRw4OUlfo8GaRhydUxP/hU/wypohsWAU1Ef
 LkS7ijkw9VGR+iNzX1mHzjxJM+Cw/wJjRA6S8LpsBzGIFpiZ6R+opFgJcbWcoL4+M6tpWBdpJ
 FnYh+nkCJ9kHfuOQ0b21YHFtRMhg3oj7L7NjJbNQNprsNXRQGR3ojKug2tO0pe263MzFz8N0Z
 NrXgpub4QGJzna3Cye34tT5UR866UsDpuD55MGtNKMn6fKm6dswMqGFZ42W0O8ZD48kESxAgm
 CreFYltOUAhOFa7TxAIIBzPdaNA5alUD5Fi21KLGd9GKUOiOHn0u/J9Sy679U0Nu+D9k+keK0
 D8Hp+xKV89t8yKufVYcD/mMH6sV53bb1hq/iTzJcB4Uce96cbSWTxOXuuCZwkW79mOAOYIOj4
 q1vDwCnWz+RqwSry8AQWKGed/FJEopnPzvyh+9GhchAi0=
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

On 18.06.24 17:49, Ilias Apalodimas wrote:
> EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> at runtime is not supported and allow the platform to perform capsule
> updates on disk. With the recent changes boards can conditionally enable
> setvariable at runtime using EFI_RT_VOLATILE_STORE.
>
> So let's make the options depend on each other and clarify their
> functionality. When EFI_RT_VOLATILE_STORE, setvariable at runtime is
> supported and EFI_IGNORE_OSINDICATIONS, which also breaks the EFI spec, =
is
> not needed anymore.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 430bb7f0f7dc..c84064de1366 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -220,6 +220,8 @@ config EFI_CAPSULE_ON_DISK
>   config EFI_IGNORE_OSINDICATIONS
>   	bool "Ignore OsIndications for CapsuleUpdate on-disk"
>   	depends on EFI_CAPSULE_ON_DISK
> +	depends on !EFI_RT_VOLATILE_STORE

EFI_RT_VOLATILE_STORE does not imply that the OS that you are running
supports writing variables to ubootefi.var or eMMC.

How about

default y if !EFI_RT_VOLATILE_STORE

Best regards

Heinrich

> +	default y
>   	help
>   	  There are boards where U-Boot does not support SetVariable at runti=
me.
>   	  Select this option if you want to use the capsule-on-disk feature

