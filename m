Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D9BC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 07:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1151080B1E;
	Wed, 26 Aug 2026 07:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQpiLZju2kdc; Wed, 26 Aug 2026 07:04:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787727856;
	bh=Ejd909cK8DFxroImo1iVOYeOasQPm3JQJlb1KG68fZw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cuYeX2znYmloDU0J2KmBj76GIqfL+pJ6FsruayaM9S+es7VZHYVNHMJe/EHBDADi8
	 //sInnbpWiTDmTrrlgU5Wn7Av9/QmeigGepjkPLx4TGJo2ig2+qolW5qO7Xk4SM54o
	 tA734VR+XEWI1jnjdryDZsGPWXKDgKWLFbOzWyQHnlEe3EqoQ0E63LV6q7AbbX5/e8
	 yAIiAYaFh3MGLSFMUtquOec6nGqhdvMjnCl5IiVdqIs1utGoKCvOKG9Pd4313axSiB
	 YaiMtRs+W+OGstS0C8xVkR6il4V0MXiWYNnzJmdHFYgolhU40sNAnm2soVYzh6D632
	 A36bpss6QMQtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C5D980A76;
	Wed, 26 Aug 2026 07:04:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93F03105
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A046605F4
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZIHRhTFstEB for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 07:04:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=l5/Q8D3s
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6693D605FC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:04:12 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c252c7270faso9603366b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787727851; x=1788332651;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ejd909cK8DFxroImo1iVOYeOasQPm3JQJlb1KG68fZw=;
 b=l5/Q8D3s7901yi2O0tkRVJOtzOOfURAE02GwbmdwIT7x3BA3+sf5/QXeWoV5LNTF5S
 N8rytLDX86fOEOCL22cTUfwoxJau5SyfmSmcjXEbWsLRDLMqM4ia8K6sE3+Xihfx4ipY
 XzlPOKAtNP7iLYJxbs5MH3REZIWMuGELfQhD8IRDCU2ORGOIsYYRPrN8jivzH+N54jXz
 CRM3g92zCfYDf+boh1O88Va62RXr5QjegsC9WFJ++2Bc+zjQPodzsgFgtGTI3woICjGD
 rtIqsY7gppXyh2AKvEqKxb7hqT6BGTKe+gMOWsmUJxCWvvoe9T5naxhcTPyGHWg+/SGj
 uzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787727851; x=1788332651;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ejd909cK8DFxroImo1iVOYeOasQPm3JQJlb1KG68fZw=;
 b=nC0OLBICIP8ZUYZDrP+KCRyhYOPa5Dl0TnLfhJSyDMlhEBHfZaO9Z1wEbYFVUH7Vvo
 FGJN61oK1vjS8NGkb4TyiqCySdRmkyzuvE+TucMxc64r5khA6WGE2xlNyQba0BUhVSX0
 cYeKPfHRDIHnNqsoCX8gkWw21jdijP/hiRGFqTHBPjTe5EPY9e9hHYbuz//BvHDgSGzk
 /6+KC+LXGfkW+pa5tfjbF63d01iiNGcT3qxa8Bi5KhQYTWvQUdVj34fo5MC+KvzFM0Ls
 ncjybXs9Ir5gAibP1Z0+5cwyADb/gsfs4UFNqmJVK24lHXdMnz/m1UA1P9HJghDJRb9p
 2oyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rru5jpILLMZ0sWrkUKnQkJ0G3hFhMEibFrHxhwp5+fRy3mcN44aLRgVvJ033iPCRD1vvyWsY3Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kA/9NMaKffAOB878jIjan5ECPgpPwJbXdhGakDe23HvgvUWkkY
 yl16r69HmsrZbuQaEPqOmnGbk2ueLDvDCCn+eQdcJIY2SwNDCRtSCjdEeV0MNdKwMFQ=
X-Gm-Gg: AR+sD12P6/YFmMg9S3K4YGLdgxMLkARAzLcy/hf8QcYbIPoA6dnewAd1Mm4GvQrg/+7
 qwCwXrDWIjeyX01dvW+CbHfeEW/VrQaFkOCOz7RrN0tjrXRHn9kCndz2N7v5U/R4tEVvhwv7fEt
 7mYE3b3uLTjyZWZ32BQLTw674v6VwjutJSQG5n7aBM2z3ClgIssforIPAHxpAaRF0jhdCwDpKCn
 fzjjhlMNZxDHFfUtX96ffu3Ll/+qxC4/kO0SB2HOPEuKLWMqwGkUyNWGTCqSM5l0ajTx8Gc9fkL
 bEwHgcrfw5+JIfE2vdF7vMtpHbYfdLl5A/JBjgG90Z2tNEIn3aWETJlD+PZbJ0DRpsxyyLiUEgR
 n/kT/Sv1IIiQQPUeLS4xY2+bzOMuE5rVMzO4/lQJFL08+YBxMms4XLifM+P9OF8emLv2NBwXAvj
 0M+CnhVcFuL9lp8U52LUsH0mvZlLuJA5lJcrFWJpmtod5cHmlABvGW0T2YBlZk66vFySY5MmEtZ
 tfRD28XQIKgX4y4mfX81pC8V6LD8XQsgJtd5z7z52m+ZBi26l4RReMvxsUU
X-Received: by 2002:a17:907:9615:b0:c25:4a9:ab95 with SMTP id
 a640c23a62f3a-c250bbd440cmr424640366b.14.1787727850700; 
 Wed, 26 Aug 2026 00:04:10 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab59sm291751166b.41.2026.08.26.00.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:04:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 09:04:09 +0200
Message-Id: <DKYOMS3JJBW0.1HEH8S3BL167T@baylibre.com>
Subject: Re: [PATCH v4 3/6] arm: mediatek: build Genio 510 and 700 boot
 images with binman
Cc: "Julien Masson" <jmasson@baylibre.com>, "Quentin Schulz"
 <u-boot@0leil.net>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Ryder
 Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediatek.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom
 Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>, "Johan Jonker" <jbx6244@gmail.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Alexey Charkov" <alchark@gmail.com>, "Suhrid
 Subramaniam" <Suhrid.Subramaniam@mediatek.com>, "Arnaud Ferraris"
 <arnaud.ferraris@collabora.com>, =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
 <20260814-ccaione-upstream-mt8390-spl-v4-3-f4f92978a79e@baylibre.com>
 <f5a976eb-6e5b-4210-9f3e-8068961a1fa5@baylibre.com>
In-Reply-To: <f5a976eb-6e5b-4210-9f3e-8068961a1fa5@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue Aug 25, 2026 at 10:38 PM CEST, David Lechner wrote:
> On 8/14/26 9:47 AM, Carlo Caione wrote:

[...]
>> +#include "mtk-genio-binman.dtsi"
>> +#include "mtk-genio-mtk-boot-binman.dtsi"
>> +#include "mtk-genio-bootloaders-binman.dtsi"
>
> Would be nice if the commit message explained why we need 3 separate file=
s
> if we always include them all.

We do not need 3 separate files, I just decided to split them because
each file is actually generating a different binary, so it was better to
separate them.

[...]
>> +
>> +					atf-bl31 {
>> +					};
>> +
>> +					hash {
>> +						algo =3D "sha256";
>> +					};
>> +				};
>> +
>> +				optee {
>
> Can we use `fit,operation =3D "split-elf";` here instead of requiring con=
fig
> options for the load and entry address?

Uh, I was not ware of that, thanks for suggesting this.

[...]
>> +		mkimage {
>> +			args =3D "-T", "mtk_image",
>> +			       "-a", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
>> +			       "-e", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
>> +			       "-n", "media=3Demmc;arm64=3D1";
>
> Should this be coming from CONFIG_MTK_BROM_HEADER_INFO?
>
> We will probably eventually be adding ufs and nor boot support too.

Yes, indeed. I'll fix this.

[...]
>>  F:	arch/arm/dts/mt8188-u-boot.dtsi
>>  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
>>  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
>> +F:	arch/arm/dts/mtk-genio-*-binman.dtsi
>> +F:	arch/arm/dts/mtk-genio-binman.dtsi
>
> Should these be -u-boot.dtsi? I know the won't actually match anything
> but makes it clear that the are u-boot-specific additions rather than
> something that hasn't been upstreamed yet.

Yes, makes sense.

>>  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>>  F:	configs/mt8188.config
>>  F:	configs/mt8370_genio_510_evk_defconfig
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 0618f42c941..e5d0aade7fc 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
>>  config SPL_BINMAN_SYMBOLS
>>  	bool "Declare binman symbols in SPL"
>>  	depends on SPL_FRAMEWORK && BINMAN
>> +	default n if TARGET_MT8188
>
> I think it is unusual to add board/chip-specific things in this file as t=
he
> lists could grow very long. Maybe we can make a MTK_GENIO symbol so that =
we
> don't have to keep adding more TARGETs here?

Agreed.

Thanks!

--
Carlo Caione

