Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D95D70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B7F89D2B;
	Thu, 28 Nov 2024 17:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZK+1qv0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B5E89D25; Thu, 28 Nov 2024 17:51:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D73489D43
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732812683; x=1733417483; i=xypron.glpk@gmx.de;
 bh=PBkG9utZuGtdcZrV0/4PPdUOUlnv6fagfpD6TlDiETo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZK+1qv0o3ThPxc5QJmYmVoS2NOY9aFxIzX4bnbE1HxnnfA1tBiPHbh7ricNoTYHj
 XIj4kCq3Yw0oApq81ikcB3oNtbVTiiJ+zHGgcPpEmIa3jbT98B6N4sSr3diXqDJuu
 cSZYYeQjdRpNQNQvQXFgcaptgIb729EGXSVGPn6/F9kplXV1EpzdHvlPQ9OrB61gp
 bIwbQFNEzKhPoNRT38Tol66m5nLQJmZkuI8Ui7VXIVnHXjwl2VNfPW5aiMgiTfR3C
 HwrhrF8VRx6ZqopZX9yKB6h8vsXB3hCQhsdfjXDNTMNte1wOTz21w3wrLLY9NWROi
 TwGIE6kLaXOw675OKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1tlizi1JB3-00z3WC; Thu, 28
 Nov 2024 17:51:23 +0100
Message-ID: <5a9ff9a5-e0a8-4e64-a98f-ec7a7d725692@gmx.de>
Date: Thu, 28 Nov 2024 17:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] efi_loader: Fix typos in enum efi_allocate_type
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WT26Sk6MGYtVW1nLpUtyNLKApCZLk/NqlfOMn0Vt4WftXwUHMhS
 bbnlEsT9mp80qeZ0f5NS2oslCRgDA09XWaQZMdEV4WX5lyc16y7x1k//jvX3iUNOW76zfm5
 l3LbygBaBT9l6tj03nEaNYx34nn6mWrQUVws25/G9XKBhGCmtuaZlbTo4WtfC1S+I0tolgg
 1s/TIbogdDMxNJxVrbv0Q==
UI-OutboundReport: notjunk:1;M01:P0:HluTG9p51Is=;Kb1SdBKuTzaZRW7Y75TK1SP/uYD
 ZO5pwzBhKMBN36nOpHMiEhU83EAWiGiSiLGmbEULEYsAn4Hh1fgJppY6NZ9jY50ccj13EqG9W
 y+LCGrjZS6MkcIz3atofg6MRCygEllzV63z9ao6ONZFj9KFEiDEq5pkQnfZvaX99476FjJJ88
 5C5E6HK6/aTJcIJEBM0oPfYfF5QAfMcRZs9Gg+oejdIReuTWmcqY0hNYUm2QpwLARxiUERvGe
 wGvi8UbIO7xrekImrWT92moRknP2C2Z70YMHmmCslLxvo5PaGFLPFK4LeRfVXBVcLv98dA4NP
 imM7j0KBGr9S9Y289Wg3SupEpzqdvQ7ysKgN0V5j09sUJRjDTm1/YrzG0Yex6mw3+4XSrUkIj
 ygu/a/hHDT46By7694UsRjYFTFwsswzkNRBN2mH9cPrfwZ/kLqF7EDW32qH1H65S23CZROBqF
 OINNow03qZQeEXWJ3PvoVJlJ1/MlzvmWByiVy82ZmFwKGRa43iakXP1wpMX/SfIQNnzNZ6ysC
 68Pd5CRESh5TXSI6v7yewURaPv7oi9zIKw31co6lD6/T3suKDN5ynCNLu9J/+3CjRv8eUQO0U
 pHiLU1ogJvSY1+zmTk7gFf1Gvc7JB11G52THCO0ZW74xQt3aFIoKJcmpB00oN2AZlzhP4S5nK
 l28EoLmCGkD5HCozKs5GLubDKePDIMvb8U2FXRn6FCCXKjGvLBoS8CCqHIYh6LihQ0D3TXVLC
 03QI3JJwKXvZAIgWVPrxpXprR3VFIWknmedy5GawtAUgVTPx5xuvWjjPZUUboMVXOvEctu2f3
 rclYSN3dtdNCNijVjCIDh5yijp13WFgdKuQCBvnya7gA5UHO2nMLAmAWEUcrNzSREhBegEoAX
 JNaBaaofJN5Covg5hcLSCPOMoSzTyOJJbWEGcGL4LnAH08JCYVQzn8A0wZTuJW4KxwP+E9qof
 Era56vpq/waqr7I51j8pD/Y6hHtNGLOMCHJ/EysnTZDNV8fieQp0edkiaWpwjqERkdQfPNwpy
 bJkLlN4NLD6XbVoSG2cmaZBvDblSxybl6hSKUv8wWEnHdxgyjCJi+XHlkBs2QQ0OfjrBSNmO4
 /DivejDNOISxrT+EP/VdaSu0532MWO
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

On 28.11.24 16:47, Simon Glass wrote:
> Fix 'indicatged' and 'adress' typos.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   include/efi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index 3fce281233c..95f8020049a 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -175,7 +175,7 @@ enum efi_allocate_type {
>   	EFI_ALLOCATE_MAX_ADDRESS,
>   	/**
>   	 * @EFI_ALLOCATE_ADDRESS:
> -	 * Allocate a memory block starting at the indicatged adress.
> +	 * Allocate a memory block starting at the indicated address.
>   	 */
>   	EFI_ALLOCATE_ADDRESS,
>   	/**

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
