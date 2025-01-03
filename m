Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD4E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 16:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B60680295;
	Fri,  3 Jan 2025 17:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gvX9GcYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F40802EF; Fri,  3 Jan 2025 17:16:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F5E801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 17:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735920997; x=1736525797; i=xypron.glpk@gmx.de;
 bh=MIOd2gI8MquwF1nKNELTe6tORiGb615KCXt9JbcaaPE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gvX9GcYjLhu31wJ+WtB0wMK/9dp0eRIxrQutWkZzXeQ9eAAcbShA5isJ5N6XrBuC
 ZCMX4RBg9uGQlhg3BCRhmqlL0nXRhrjLMRKmfeDqB5KqoIhCwl95JlahesVxkBjYc
 QD/gf78LBhTpBSHFD9V6gL/6Is+5GrBnQ7lKLZzDbAOgbP1F9VX9TBpOxiHS1XIhH
 CVagAl0TBatHKf7bK4z1GBWIj8stAH6LjsEe/N6YrUgdcoRMAi3lFcUOzd0mSxM6m
 /yC0ncoGNFxHZkDA12HAp5Sny1c8TqHmiEzOjPGh7JFpgJxpUvPj1Zk65wIVEgXw/
 IaqTUZ626gcw2nrB+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1t6S2o1Gjz-00OK8o; Fri, 03
 Jan 2025 17:16:37 +0100
Message-ID: <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
Date: Fri, 3 Jan 2025 17:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jJLc8DazsvQQ1yqkO+5JgMl9jXNPZEdSSDiXsRYNphjDEop7/C
 WMtuNR0Gwa01R61pbY5oTh65xQURZX431ZH5RlUaPE2s/yJXh1hS0dyI4LjauO8F0AjrjeF
 iR+WEUm9vGjuYc3wHquMsL7ZWHIiczfmKgyDHFJj/7zUv5YRR4FGv/H1TkHWyZZajT4V8FR
 GLSMgK4g/Lk/O28SaqW6w==
UI-OutboundReport: notjunk:1;M01:P0:DJccdCEf1I8=;Ih+3IUwfqVxAbjHLYxWySIZRiXs
 IAlkmFE40p96wO8uVwzlNmVBlsn+Dk/F0YnCm0x4p0T6fWH22MTYiHVNvHMpt/ziABZOtY870
 3G3qnoscZPoTLG5zPohETX4cPASdQvnHidSOIO35Fdxi3peHrQNUY94eijL9wH9ErJLv7BtKg
 TxpDV+l5EpcPMrBmhu5fGUpJETnnwGY95Vtah7rxTo9Ohm5RuZ4m0jAn2bab7RxelxtFE+yki
 YXGLcztzfWL/H2vrLWU7RH8zmBvEYoTZoNqZf7xUINe28ec0ZfWVVjpAGxcTGx6ffTnF9o+ty
 N7LzpqzWUms5HBd0nad57glWHuVoURxwiminf3f47wq2gQD1PtGt4mbz1bT0diCZ3+MEi0M2N
 beFb8rvTaxEF/j2z7tchgr4mxIihwMaLJGcJfPtjZFnWsKYw+pYQXWFJNmzo6WapOTfkBRLqE
 1jEwh9px50ZSoN8RVFCbuMV2Dh2ei2LzFzbhkz8mP7GXa8oOhZNndq+0DE1jmfk2prX2c7yAd
 Yt1y+cF0v/dYMmiYKg3sImLfcWCUGVBz2q/iXdTzHWxUSHghziZMDuRVy6+CqayxtuCcd0IRx
 D8k0zFvSKuO9iAAnH/nbH4VjY4iVRWPE3wVDh9xj+EcLXvytbIwsVIo6pkxJsgdFrrSlLfC5T
 3tLtx1kk7wnUDZw3lN8fXpHLi65NNKWb1WI+xg/GW+TiHTCRAaUHp+2LBiNHJbrH4Oy/jyMZx
 tGzzamz5DzJSL6WHk9mO1nILR2/K/Kp9Eo0jpH4PE23euba9i6pDrmRgwQxpeOXVvI7uoiPhO
 BUSyDvtwKC1vRH3lnY4QcNhhz+4fvBVf/CuwXt/uVUG+hYKUA2NqAWOoMVb7gQwbDg0uk8ePU
 k2gyFpBx5f4fvkX5l3Rivtevbmg0MG/hKM9QhtDANbTEWCUGQGpGfF4FSF5msBhulvc9kRWrs
 f77q+YFK8HzKPq6GgLsAJzgmWjuk0zyY1qFTkUw2kF79rwXJJaFoEuc5d9FLFUlgi0isM6OIB
 8nUQh8U6Zl6b9xL8/DkFIF6xyeuAci5D/+NFJeAc9ADAx1Z12SmHfYm5su3/5ujXwc7+87gOC
 AvlZAyzFTKJSbvImmc874HyIuT/vZG
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

On 28.11.24 04:47, Kever Yang wrote:
> The efi_stub is useing DEBUG_UART interface by default, Enable it.

As Simon already wrote in a code comment the implementation of the EFI
stub is broken as it is not hardware agnostic.

In the EFI stub we should never directly access hardware. Please, use
SimpleTextOutputProtocol.OutputString() for printing.

>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>   configs/efi-x86_payload32_defconfig | 1 +
>   configs/efi-x86_payload64_defconfig | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_paylo=
ad32_defconfig
> index 071ddb8e36d..f0b9acc358d 100644
> --- a/configs/efi-x86_payload32_defconfig
> +++ b/configs/efi-x86_payload32_defconfig
> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>   CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>   CONFIG_VENDOR_EFI=3Dy
>   CONFIG_TARGET_EFI_PAYLOAD=3Dy
> +CONFIG_DEBUG_UART=3Dy

On x86 this uses the NS16550 UART driver. This is fine as long as we
don't use the debug UART in the EFI stub. But correcting this is for a
separate patch.

Having a debug UART available after the EFI stub makes sense.

I will update the commit message when merging.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   CONFIG_EFI=3Dy
>   CONFIG_EFI_STUB=3Dy
>   CONFIG_FIT=3Dy
> diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_paylo=
ad64_defconfig
> index 71612d7fb19..b02a861e59c 100644
> --- a/configs/efi-x86_payload64_defconfig
> +++ b/configs/efi-x86_payload64_defconfig
> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>   CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>   CONFIG_VENDOR_EFI=3Dy
>   CONFIG_TARGET_EFI_PAYLOAD=3Dy
> +CONFIG_DEBUG_UART=3Dy
>   CONFIG_EFI=3Dy
>   CONFIG_EFI_STUB=3Dy
>   CONFIG_EFI_STUB_64BIT=3Dy

