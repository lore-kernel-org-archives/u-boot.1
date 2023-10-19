Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33671CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 17:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8CA874C5;
	Thu, 19 Oct 2023 19:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BlRW426l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDAB874BF; Thu, 19 Oct 2023 19:56:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375E4871BD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 19:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697737761; x=1698342561; i=xypron.glpk@gmx.de;
 bh=JWoiX8pIQfv3eHCHDVN0/4xHkpc1f3p4mWaVb5+/TLU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=BlRW426l7w5Icqho6pk1DLDQcHf4IGPY5zateB2n69uP6fZFqd6Qn9vGtXlVneLP
 M7lxPXtoy/9rzaT2+EWIMd7jfwtr30cdiiug2pFEBqsjnRqAEK3jlASr+xIoGw3Z8
 qSweL7SB9dCuRiQ5A2sI6H/iwtVGdG6Z8uztPFD1DHkB7Va3hWZ4t1QqMUDsImHwE
 n+xRyX0JSSIgSA/eESrLP5rIbNvQ9DrP0ai0/4g0z299Vn0DqHkleQHJoFLdZoDN0
 3n8i/EnNIyOkas+NTwLCTp1PLXdIkIH8JXnyJ1zmMp5vDjOWdFeTbVwPn0I2M1d7p
 M5DBJZ47m0dIkYXUlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1qgJjF0nMO-00DIRx; Thu, 19
 Oct 2023 19:49:21 +0200
Message-ID: <db4253c8-f5f6-49da-87fc-cd5fbbf0cfe0@gmx.de>
Date: Thu, 19 Oct 2023 19:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/8] efi_loader: fix EFI_ENTRY point on
 get_active_pcr_banks
To: Eddie James <eajames@linux.ibm.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, u-boot@lists.denx.de
References: <20231019162156.80982-1-eajames@linux.ibm.com>
 <20231019162156.80982-8-eajames@linux.ibm.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231019162156.80982-8-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SnPEwxUOMV/PaRPJewczXN9Bal5PmFxDErYHmJHH3CaC6mCjN23
 Llou12jNTM7mIVpiE7esZP33r3TbG9OsqZXFcE8PPk0aJ6T18ZAf4YF6Sk7CLqd75EpFQZR
 goelRniOQlobru4CDjnyhgSNggfKV1GzRUDGf5818y8VAH0wSHeAQfnyWWc1yg30Rf0C+Yd
 gf7Xq4iLsfcKnwb5osjEw==
UI-OutboundReport: notjunk:1;M01:P0:fMqPVi8Rq/0=;EphteCmup5tOnB/KjO8eBFn2mBc
 SfxkSogUkBy2DiUPCA/pIbsDvlNhmfy3pPWZ1s5rz8+zKiO9NKpclqdSUeDmHQp17E2CsGKrb
 racDLxog4Iov+CrhUkmiXCXv4EHizYlETtuWbmRD22K2aoPwBFn/TfWeB0HP3QAZKs+CRK9Ef
 kQhtzVJBi9k4XN7nnD46Nk4gwoAvV6xJU893h4u1iPteXh/YCugvI1j482UJIJtq6somBBiy4
 /+iIpwlBnvJ8BjTE/enY9otvdrXFEyiBxuz/YsI4lPTSCU5+UO0hxL6wDnrWQt2X5MWa+HHrd
 G4FIDVcExjWmwNeeXGyF8YkVbnKioLHoZ+OQqXVBeuFNyNGEPboYSIg+Ptc8dE7LKkzPKPbj0
 eY+EzuulTh++L8r3goZTEBo5VoQjMsSdeUJJ3ZJvMBVHY2YwvXa4zqLvXMjvaPlKRl6MOuCGL
 HoviouSJLl0Iz3j78tyfoMeTOlDk+5gA00mWwAm8kbOoqN+g0pxjLJDjqc4zUBRGwThCC2vFU
 Kmf62pIt0sJbGi52XJ66WGaBqnHtjlPGBlVX4Jhn4tKRkjpQBSw0eKQLjYKbyYgJhBXzN2AH1
 o/9yQKmzlfW+gNdMFBh9LqOE84GLe6o5CWEgHZb/RVNFSUBAxZp6nhf1OKyY2JR8VjRaXQg28
 tSkunHukBVSynf6tdej05GHdydpyDHfgxvP8pi16nKN3n+y0GdDpdAbqCEFl7CvKSjTfl1lfo
 ZH2oEOihf1UxlrP8xejgd3zH88u46DUPl4OnvWGJvczu/j7fcDCS6U3jLIrpx3PtxPG/w1dE3
 z4XSvMgKRAssEyQY2TWUkIOa1kyOl3hotK1wXTlykLyn97UinGcGzM1tdoSGWrW02u07b4qwD
 ccbFtCvNxJGf0bATu0Cbg/FMSWehyrnNdhiS5zBzYH4PWeVa/LIEzwWwoZU+ok71Qdx0rUgsF
 1sUUhwoULvmoYypd+Y50A0ncAWY=
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

On 10/19/23 18:21, Eddie James wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> efi_tcg2_get_active_pcr_banks doesn't immediately call the
> EFI_ENTRY() wrapper once it enters the function. Move the call a
> few lines above to cover the error cases properly as well.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_tcg2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 7ada536568..dae1b166c8 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -949,16 +949,16 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_prot=
ocol *this,
>   	struct udevice *dev;
>   	efi_status_t ret;
>
> +	EFI_ENTRY("%p, %p", this, active_pcr_banks);
> +
>   	if (!this || !active_pcr_banks) {
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> -
>   	ret =3D tcg2_platform_get_tpm2(&dev);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> -	EFI_ENTRY("%p, %p", this, active_pcr_banks);
>   	ret =3D tcg2_get_active_pcr_banks(dev, active_pcr_banks);
>
>   out:

