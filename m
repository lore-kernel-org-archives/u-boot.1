Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B6C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B8B86FDE;
	Wed, 25 Oct 2023 15:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XG66uzCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF59874A2; Wed, 25 Oct 2023 15:03:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9370686FA8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698239004; x=1698843804; i=xypron.glpk@gmx.de;
 bh=7piYi18/yYifOkJFANnerlPWpfwYFapalr/DvsiCRpo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=XG66uzCvs5eTyO0JDCEZ40IpNIG7yHHZ79yqASsLW3rE4fJRufJxVhBXijh/YE6B
 xdnFe4n9nUdgbX72H9FwlEebZGnNWS1PvSOjHQ2uMoe/XuMZ9UAvIANCyOKNScqbh
 8nvetcik62I2fm4zYGw0hidSVDnSN2jTthOhPwmod+Pvoq9dGa8ftsMMgeFTZtZZc
 R6ZrGf6rfAuU6vM3H6BpxOqytigF6jgMCPN9/F2YL1EfK5bPY3uiRkhIFLy+j+y+b
 43zpZ0fOiHVzfo15XM1Jjt/f0P2BiPUJvsJf5DIZV1v2icchy+fS0b0p5zXqo2AQ6
 ai/NNqcBRh0O8MC5iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1rItXk0uWK-00nebN; Wed, 25
 Oct 2023 15:03:24 +0200
Message-ID: <0459b591-1f22-427d-9b7f-5422dbe789b8@gmx.de>
Date: Wed, 25 Oct 2023 15:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
Content-Language: en-US
To: Eddie James <eajames@linux.ibm.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, u-boot@lists.denx.de
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231024154354.197524-5-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RYnR4P7a14m/5/Ubm2cZ+pf39J4ZOI2yIkkOr4pAfXQmUyxkkjx
 cmhsMOCGtNgeCYBNYIXwwkqdVuhsWQxD0+3d58qdSOvWBcNT4e9t5YUgsvIfGVaVbkDAYMe
 3eIt+wVf3EU2Z1K3PD+naMAwQPLfQFBbfXaGDaHkgF4r1ZW0tMZwIg5nHqAhLIqrSfHi3Vu
 k4FzU7A3t37r8rMEzGycQ==
UI-OutboundReport: notjunk:1;M01:P0:xdHGKzCa7OM=;qVkKJS9ZLxZol0xz3nxemmxkxsU
 BsuM4Y0i9suSk4eNpMf+ycRpUf8uoFD32oGseUO9Au9zFqq/4fVC5LS4hjyRGI84wdza2ZJna
 HCHhSVnuZv8OZVjaHNCrC2Yc0uLANol2BCe/INUhBtTs2StJ0x86oLXSMIwQ6dgwmtC2uZoXr
 qCK3JdcYCutfx+Nh+GEYXOWj44aW1kJ+6HCSf5l14jt7tmre6xKTa5mM2wlmhf/yEqd2odfge
 ZcgrtResZ3b7p/tjHCeLM+jMa5vQ0BAuz3TUyX+btHBJ78Mj2AA8QFnLJhPXD1DCKKIFaTgqY
 pW2YBhRTwwQnWM/wPUYkhxa8LieHr/AgZOY5vq+Fr8wNPJ5sqJl8/g/TydvgQIXar1VzIvr+n
 H85rMG9kue5XsRIbN4+TtoJn79RPyRShtm+N4oTHStAdeB9pZ5WI3j5gh0xZ696eIVqS+Q8A/
 HyLPQrnZS5HyObZgISLpvUX6ljvCd6TRSpsqg+ETY3z4YjAZoIzMr38R4SwHmrtYGaFB/SCeo
 dxHl4pY9FM5poVSQFwCeQKvPD1r+Up7tpWe04LTv+1Hx7SAT9NnR+YbmqZCKm5yWeFumoew0Y
 qndgsOJdj//JIv/sfusE8dnmMKQwEWDkzvJep3k0L4KZAiIv6FWbbhc0XtIvqhYKsM7Zs3VBF
 EEFaJvQOkPdt9a4GoqiHKb63st5c2ei6/pio0uiX59jREua3XRZiCkp5DafGS4cVJ4UCjaQbD
 zjQVfVC/hzVy2stA+oSCLWJANsZMUZYEGcE6QAZg2pazdF06F9OvHm7UpLsKNSWs7gVCVrxTB
 eA1NwcilJUBQ63QBE5BGBPVy7nAecEEmFdYo3ypwvveaRqRvlHOFoH4X6jgR0Jtux2lP1izwn
 qWhDLjPC8B/usZx4ObYDj4jhqAqAksCoP6T8t6JCAf0ap8tuwRRAGxRJ4k1MlcpRc4AN3pDac
 yVYZra91i9B0y5nMibmEKPd4EUo=
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

On 24.10.23 17:43, Eddie James wrote:
> Add a configuration option to measure the boot through the bootm
> function. Add the measurement state to the booti and bootz paths
> as well.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since v8:
>   - Added a configuration option to select to ignore any existing
>     event log. This would only be selected for systems that know
>     that U-Boot is the first stage bootloader. This is necessary
>     because the reserved memory region may persist through resets
>     and so U-Boot attempts to append to the previous boot's log.
>
> Changes since v6:
>   - Added comment for bootm_measure
>   - Fixed line length in bootm_measure
>
>   boot/Kconfig    | 32 +++++++++++++++++++++
>   boot/bootm.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
>   cmd/booti.c     |  1 +
>   cmd/bootm.c     |  2 ++
>   cmd/bootz.c     |  1 +
>   include/bootm.h | 11 ++++++++
>   include/image.h |  1 +
>   7 files changed, 122 insertions(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index a01e6cb8aa..abbc72f4cf 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
>   	  loaded. If a board needs the legacy image format support in this
>   	  case, enable it here.
>
> +config MEASURED_BOOT
> +	bool "Measure boot images and configuration to TPM and event log"
> +	depends on HASH && TPM_V2
> +	help
> +	  This option enables measurement of the boot process. Measurement
> +	  involves creating cryptographic hashes of the binary images that
> +	  are booting and storing them in the TPM. In addition, a log of
> +	  these hashes is stored in memory for the OS to verify the booted
> +	  images and configuration. Enable this if the OS has configured
> +	  some memory area for the event log and you intend to use some
> +	  attestation tools on your system.
> +
> +if MEASURED_BOOT
> +	config MEASURE_DEVICETREE
> +	bool "Measure the devicetree image"
> +	default y if MEASURED_BOOT
> +	help
> +	  On some platforms, the devicetree is not static as it may contain
> +	  random MAC addresses or other such data that changes each boot.
> +	  Therefore, it should not be measured into the TPM. In that case,
> +	  disable the measurement here.

I guess the device-tree should be measured before fix-ups.

A main source of randomness is the KASLR seed.

@Ilias: How are we handling this in the EFI case?

Best regards

Heinrich
