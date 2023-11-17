Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6580EC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 15:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9192C86EC9;
	Fri, 17 Nov 2023 16:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xem2uLZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EDC386EE5; Fri, 17 Nov 2023 16:35:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A18786EB8
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700235323; x=1700840123; i=xypron.glpk@gmx.de;
 bh=el3gziJdVK+hY9zIych34O7dmPxjTAC9qD0D4zKfhGg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Xem2uLZ2/vdU2nK2prNGhvMaG4HDnrMpesdp0ctSZhETahIgdQ/s4L5OlQgBwoEB
 XaJ9rJ1/giMSICEbvP6mBZLce2+JuWkD0u2iAUyBmpzHJrvSwDhu04NqFKnk4RzxG
 VXXmh4MXp+PDCNeWoEyx92/coJprKB/Yg3g2Of1R14CZktnmvnNIDVvbL2p5QJy8U
 YWVN2kkxn120NboDREBhLkrEp+bTOp65/beUkIT4ro5f9KwJ7q0WGokXwLj/NfQFy
 PUOLp5wjdxlcqakDmQAQzZlZjq5W+RuaDTv7a7AwEAg4+2+Smok6ftp5zXnJXd0k3
 F7u3hZLd9Xiz9vkaQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1qsqri2frF-00XHKX; Fri, 17
 Nov 2023 16:35:23 +0100
Message-ID: <c91e201c-e902-4853-b224-d5ba4813cd2e@gmx.de>
Date: Fri, 17 Nov 2023 16:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] fwu-mdata: Make FWU_MDATA_GPT_BLK depend on DFU
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20230817174125.369849-1-trini@konsulko.com>
 <20230817174125.369849-2-trini@konsulko.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230817174125.369849-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rPmQPLB1+BieOwewnuH6qjL7CPzKAw+1cXWnOYVhMe6KAAgQFVo
 NQbR46d33q9Y9ZuwKlHnhxkXxl05qvl5VIumHKJ1kxewpYbtV9GJo4k/vxfHLbkmop43v7b
 gutftD99mas4UKqmw/AX9nXmgEmbyyTjOuMaxNWw2yloxMesYzUlrkN9L+FmEYrBNSBCYau
 AfKyey+auo/TtjyvMdrqg==
UI-OutboundReport: notjunk:1;M01:P0:NN4HdvHp8Gk=;JLDq/haeyWyA7AJdphRx+Ogrp0E
 gXqjMi0veFB9dJq+zbD4UKO24CQ7r5G8vHKBJSdCoh5M5FrOluURm6Q+F1g3Zcgl9GqkKxXHI
 5T3NQCoacxp8wfrJfVF6Rvt2tnAL5xxwtDxDh7AgVbL7UN8cnlpFI4NXNDJ3ft73KJbdJZMDM
 faMcI/jG2J4j0H+qvO0W/pbAIV1aOzOswjMEzdSeUm3+L3ZeMSRkA3c8G9gaBhCMsgsRH35t+
 qt3iU93TRqnq0PespOsd4SmNTKeaTHusWbk/YEvw7+tItbiWKO/sd9MBm76fvuNvLB1CUiW7M
 WYz+uffr/zib6ykzhphtdIlh2lT3ES17qpgKfYYmupeFD7VHMPa/7MlAHAiF1tcEkz44Jzj/r
 UVfgvHr7sKW9y2GcXbpq+QZguuaaKROR2pYUrCVyCR36D7ce4TAYl8508rZ4apTKVmI/h22+2
 CRBB6z1EegfOJ7U4RJjcI4XySUPj5t0H0ZNb4aSNpyNQTPEZxbWhFmQCj532a1fGnpWwnE4nB
 puzfZIbyRCKk/SxeV02z7PDS8gPKNXS/VPWHAEsfIsuIlozNWTAqWuJ7jqnamOdC69MIRc0S1
 E4Wnl+NJr45be2RBqYW9Bv6riD3X7L9586ONyXFbiZXFmw05rJfimN+TlxIEWPpkpzfZjZPG2
 7fasYGLtO2a3gc7+a8MWj8oqcwLcGGjsr4Xn0umv0eJXQX4APkxi5NqBM/V0kLt9LXgmamX46
 CW0Phdf0N2lg74nIlZe/BD98Ggbsv91BLl8RRbm6oHSxMcyqjHZYzVFT4uhxV6w9w+vBri/L2
 hYlHYqxMOaWY2AHu/Ej7ofsycDT3w2fvgu7BvAyAXGodDlJnuEeArXyU55gS62Pgdw+v4GrDx
 /2mgcBUEjtg2Yid6xPYhquzigWP5b9DYXx4HI7fHcShhx/iQOaf8Rf8ODhR2D3w4QT+B4+aJA
 PBLE5twC4kk1cqg0zdRMk1HrgTA=
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

On 8/17/23 19:41, Tom Rini wrote:
> The implementation of this option in lib/fwu_updates/fwu_gpt.c is wholly
> dependent on DFU, so make that a requirement here.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I'm honestly not sure how to best proceed here as
> drivers/fwu-mdata/gpt_blk.c doesn't need DFU, but both files are
> controlled by this single symbol.
>
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   drivers/fwu-mdata/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fwu-mdata/Kconfig b/drivers/fwu-mdata/Kconfig
> index 42736a5e43b0..0bd5fef4abfa 100644
> --- a/drivers/fwu-mdata/Kconfig
> +++ b/drivers/fwu-mdata/Kconfig
> @@ -15,7 +15,7 @@ config FWU_MDATA_GPT_BLK
>   	bool "FWU Metadata access for GPT partitioned Block devices"
>   	select PARTITION_TYPE_GUID
>   	select PARTITION_UUIDS
> -	depends on FWU_MDATA && BLK && EFI_PARTITION
> +	depends on FWU_MDATA && BLK && EFI_PARTITION && DFU

Hello Tom,

This looks like the wrong level of configuration to add a DFU dependency.

EFI_CAPSULE_FIRMWARE_FIT and EFI_CAPSULE_FIRMWARE_RAW select DFU and
EFI_CAPSULE_FIRMWARE.

We probably should let CONFIG_FWU_MDATA depend on EFI_CAPSULE_ON_DISK.

Best regards

Heinrich

>   	help
>   	  Enable support for accessing FWU Metadata on GPT partitioned
>   	  block devices.

