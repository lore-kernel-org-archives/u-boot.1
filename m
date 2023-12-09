Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0668C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB0E8766D;
	Sat,  9 Dec 2023 15:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NGG2PV26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601178767F; Sat,  9 Dec 2023 15:51:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5F887660
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702133474; x=1702738274; i=xypron.glpk@gmx.de;
 bh=mm85iekLqDmXzXrlSEpNK41gDhqvYeZ0/5mnurPGAN4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NGG2PV26N2XeCtLfC/L0OFf6js5MauJzXXCAStxUiDHRrBZApQ64Ng3rKpFCHohW
 URCax1mv5Ofrzd/x1eFf+M3KtcqQc8ZKexL5MOMvb11lJ9BA3B+4F7G7z3U/axah3
 wvYDZ07cZqtZPlotD1zQgqOk61H8QLtYFVU5C1i/4sULSgqrurrZxBCQ4P/rm0UiA
 Nr8mXipYwgvDZC2LXHvJ6WTi9gsG0FrKqxBD0Aa3XLmZ9nF9GKxnSkKE/RMbdmQKl
 Zbwf1me1LC1m+pmTGuZsLkWSpcl6ckjmCWIK259mQas+/h0kD3fEspo4Fq+BPrXa1
 m5zltKQNJcB2G1gjNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1quaNU45U9-00HxOP; Sat, 09
 Dec 2023 15:51:14 +0100
Message-ID: <f97c5b43-7e71-41d4-a22e-a347e3c91ca4@gmx.de>
Date: Sat, 9 Dec 2023 15:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: use original image_index for FMP
 versioning
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, u-boot@lists.denx.de
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
 <20231114092508.3955838-2-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231114092508.3955838-2-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:guc5FfJQq+ciWgYkj0rWfwxntqX7RUHNFDgXStp/2PvDHSsQToo
 dh8LvlUr6H0MeIDFPYZZ2YawQjBdlsDUaBzEviRzTpRbDNFFNdlbZkUFXwUS8pNgqv9ziU4
 iiZZhAMBa8QWzoYYOiFFgtZOu7o/JYlwTbD2F8pV7K/MUfNwN00KimzJlaJncRTylcwxaGk
 ZeCJJ/bV8M+3eLSjAKN5g==
UI-OutboundReport: notjunk:1;M01:P0:N+YGX2cq5hM=;or2uCixJ41qhAfPq16JLQbleeDf
 aF2crfrkfQzKUA1l3nyzQ6Pgd8k35353V5mVxMZ5bnQRZsgr6nAEzF08HI1rxfqqyQpPic7lS
 BTO811B3XcMvgqYxKKQYHbckVu4L/6nj/3jL11/asXykWKIQjLsbKk0EcrcqULvzZ1jQonsN9
 q5fcsuPqDq2B6ppKq9j7kobXuocvc6KDYDqxF5owuuWNHrQUPOHvE4D0NV3+qDua7APhR0WPR
 a+sqxsigl0f0B2Pvg7IP8+mmICwO+7+XwuZcg6tkuLNcIjyAUNF21jMkgEQjOJhezUwUBPp3M
 8y9ZrcWyAxbhSwcHmcQ6M/lb+zIRVJWQfbbe2mWGNfBTKkvi44LPqrGbuwRS+63GlWACtcZWI
 tlpX6owetGDwn9Kh1XEDeRI6Vow+0TnLBbhWuB0NAI4biMPiKvLY0XPVmubZL31pQZhcTOCFW
 TGxDFH1JsIpKOVMr5Q5p+Lpus1+SBpJQZQGOwGyhpFex2E7WHDx+FsoROxTrYyqUEDeVlz7tv
 PDdDbbR5HGB5LcYm0vyK1Qe4qMHS9gd1pq6t+ULDSGD3DOAd0KXBRLT46SO91CroUj3EY9s5X
 3/ruueU9Soge1tU2PcHEDlRbk+tOFVL3NSgUS9fpyJ47tbH+Il5xsxXzS2/sQksFteRxhGQSF
 XJCjQoZpO4f6Ps+rfr7gxxZltQ0dzUKDAND8qrAKJL5IbBj4N7RUfFT4Z/H4QyAQR9CcfGNOe
 nMjw+n/p9Ti+ddZsTk8MxGJ7QatmuqSq8mJ8LMSprXFJngvtO7+eYOmaOpK/hcNwi0QKWhzsQ
 BuidJn8GPOvRlD1RgSVpc1HbAwbUwqROOiuDsptW9WCxeZWTryZk6iKlh646c+ETg1AcRJJzP
 bxw9y9sAj0h0rMnZ4GCcgHKGvELBeKaTjjCg48bEAcX19wjI8gdzI3ROJ+PwEXecO7UpNl9f1
 eUMFtz/LqZfvHsgqanR87HPtbWk=
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

On 11/14/23 10:25, Masahisa Kojima wrote:
> FMP versioning uses the image_index argument of
> EFI_FIRMWARE_MANAGEMENT_PROTOCOL.SetImage() service.
> When CONFIG_FWU_MULTI_BANK_UPDATE is enabled, image_index
> is updated by fwu_get_image_index() function. This commit
> saves the original image_index argument and use it for
> FMP versioning.

Why should we call fwu_get_image_index() here if we don't use the new
value? Maybe the call should be placed somewhere else?

Should the call really be needed here, please add a new local variable
inside the if block and add a comment describing why the call is needed.

Best regards

Heinrich

>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_firmware.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index 9abb29f1df..9c1a273926 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -612,6 +612,8 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>   {
>   	int ret;
>   	efi_status_t status;
> +	u8 original_image_index =3D image_index;
> +
>   	struct fmp_state state =3D { 0 };
>
>   	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
> @@ -641,7 +643,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>   			     NULL, NULL))
>   		return EFI_EXIT(EFI_DEVICE_ERROR);
>
> -	efi_firmware_set_fmp_state_var(&state, image_index);
> +	efi_firmware_set_fmp_state_var(&state, original_image_index);
>
>   	return EFI_EXIT(EFI_SUCCESS);
>   }

