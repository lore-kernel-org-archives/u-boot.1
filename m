Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E3C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7482882B6;
	Tue, 16 Jul 2024 01:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="he5X3VAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C73188927; Tue, 16 Jul 2024 01:11:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2835D87F9F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721085086; x=1721689886; i=xypron.glpk@gmx.de;
 bh=M9TQKQhkq0bBkYbHAu1PbCr91fbqyNpNw61hKLRBSUg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=he5X3VAh2YFbk5fpGrFg5t7iKdkEM7c+sLOYDKhCAN8C3gY/S1hojZQhZblG2/L8
 7HujiDMqkt3QmgoKw9n+vFolDxLTEcjOBVRuWdtI+XxOA1x4JnTk4W4Y0fbNZAcK7
 xC8Rsj8p5hAstXUsRKd6si6ZoEMIJkkqR3zMnjdmN3l6fQ7RKzeL5fPJxztlRlhBT
 0PcYgi7b11dQahBU0v4riFk+2ulxIuovwQXneuEPeu8lmgODPKGJug6bqkuql9ChZ
 ga4MDDhdh/cigUb8E2MzHVMjL3XUcl1i73aQr1f7usyiMC6oUmrw0TJTd35871yeL
 atnEFgGfqSBHQFIF5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1rzd9G2576-00hIrn; Tue, 16
 Jul 2024 01:11:26 +0200
Message-ID: <a75b0151-14ad-4822-89c7-bd5a7ecb5c46@gmx.de>
Date: Tue, 16 Jul 2024 01:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] bootstd: Tidy up comments on the boothmeth drivers
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria
 <ion@agorria.com>, John Clark <inindev@gmail.com>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hqHxXUgUN4CDJAWv4fFXAZWeEk6Awr75YU9hVZUMBzwMGULPEyk
 WGhgu5Odh7MC77Y/VRl4MpfjBsqORaJjT0kJ7jkyULIgvEVMXIQF1C/RRCpbKf94CAu0f4D
 oXysGPp8y7iKhPmCOBDD3HNTWaL/OvIqatHddOZjmuC5SheuAdIAG8FdA9dRpxrky01EBFf
 ywVIElyl6JV1+3xn8NI4A==
UI-OutboundReport: notjunk:1;M01:P0:n5borR9kegE=;Z0jnsdfV3V/x/NCuaJzfL0xJEip
 PxVBMoEsupD8qafJ+B3Gdnh+ePsGbk2rQDRL8I5JU3ERvdxRUw8e4Q8ywKSLGW2vfz1xuJBh+
 c4tIBSwn7ulAcgML0a92esf+Lj8dUyJH/BN84FU/TvyBIrp9Enirgt0frvBb071MMK2VBVH3N
 eF092ZfxzhiAkCMxSDsVcWwDVD74wgu1C/kdahC8vu+DoyrZvsaImCTn5NsKLk7jRPxEgvT3C
 QT8ACUOpksbFUtLcx7ci0jgcgo75OrzMPot+z3PWdsTEtGYcScCerFl3dSEj9/RM9wDjEdZQr
 kIBfa6nfSTPxpH4F2URTX3fZhOujbevf0Rbu3hN63E53NUdqLCZLsq3cdNdIFznGshEuexZwA
 t8FcpVzdjxJG2ZomJeXL76IDwmzQnxcmn85bujXHH4ZYHwR2Rl3X43JDfTR/YLtVQrYFG14Zy
 sj2e6VhJNbkR6MuOCz76wQkeS78qMq/s6zVoVf00lS4ktfplw+MOOfPbM/sGqFUSPbbJksoQE
 5v0eSfeRvzYEfVDCaRENSvl6iKFnL/hVmm/0iMmFzk2d4HV8+emrGpw5dBJgu9qzpnQYIJdrC
 c+wCrTbfXhclcGDifiSBb9W/S8mT21zZ9JXrFCCltcoG/nm2jH0I3HySLX4l4sPqeban0hJu0
 jNB6kKjOaj66yh6ynb6Gs8acrNfVbFWTjIOxWazIprteYHiT6bELMs4L4bC0vZ9PEYL9BQsRp
 vp0p8wfJdK/OuUp+6TISrla8BbSbKKu/1nx94ezKYgR4HlZuSJnz6eF3JUA49Pttn9hN5giJD
 7lY81CRIxkEmVOZCP9TxTlOA==
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

On 7/15/24 12:13, Simon Glass wrote:
> Fix a typo in the comment and add one to the EFI driver too.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   boot/bootmeth_efi.c      | 1 +
>   boot/bootmeth_extlinux.c | 2 +-
>   boot/bootmeth_script.c   | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 5a4c125835a..56a6e47f5b2 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -394,6 +394,7 @@ static const struct udevice_id distro_efi_bootmeth_i=
ds[] =3D {
>   	{ }
>   };
>
> +/* Put a number before 'efi' to provide a default ordering */
>   U_BOOT_DRIVER(bootmeth_4efi) =3D {
>   	.name		=3D "bootmeth_efi",
>   	.id		=3D UCLASS_BOOTMETH,
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index 9b55686948f..fbb05ef928e 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -183,7 +183,7 @@ static const struct udevice_id extlinux_bootmeth_ids=
[] =3D {
>   	{ }
>   };
>
> -/* Put an number before 'extlinux' to provide a default ordering */
> +/* Put a number before 'extlinux' to provide a default ordering */
>   U_BOOT_DRIVER(bootmeth_1extlinux) =3D {
>   	.name		=3D "bootmeth_extlinux",
>   	.id		=3D UCLASS_BOOTMETH,
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 0e05d28d4d9..24da47c7259 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -250,7 +250,7 @@ static const struct udevice_id script_bootmeth_ids[]=
 =3D {
>   	{ }
>   };
>
> -/* Put an number before 'script' to provide a default ordering */
> +/* Put a number before 'script' to provide a default ordering */
>   U_BOOT_DRIVER(bootmeth_2script) =3D {
>   	.name		=3D "bootmeth_script",
>   	.id		=3D UCLASS_BOOTMETH,

