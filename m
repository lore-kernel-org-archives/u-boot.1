Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970EACA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63B0D80BCD;
	Mon, 28 Sep 2026 22:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMgXZk4eiLMv; Mon, 28 Sep 2026 22:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E971E80A50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635411;
	b=MqVAt5y4Ms0iiiFFXVUb2ROgLQNmxZNEkMe7+CAH3BrfB+01ShR//7C6GG2QTVEsk2uJ
	 6GgKT89P6cSuIFZG5XVGdcvJFVhcKr7R/6ZNoMdppX3n6jybnLkTM/ZePKpW8aVEOTvGG
	 lFCw1QGM5B0IAbh2odaGkFLrtlteMTRenlLOrxKgRJ1ACxsI/CHDhTYtwq5auiPFkp1kn
	 O5rDcy9PjNAz5B7Qm2xBrbACX7vEQPa7ETljuI60JAaFVMQq9JHsUnIyXPKG2iY3C+rdP
	 NWZeB8m4tJFptJiJt/bkEfK8KEzdBRBhXdPKsqJGODj1EJrlPdwXBW0MSzQAIwEDqMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eL1B2Sjmx4imK2h5sCj010PvA/p7QuoZbvOkEYm2F04=;
	b=qqP58cEdRFRzCD/h4a1CGuCgtIFa8dY4buPo+r8qg/FhkJ8LxiH8LjJPZS93/2Y6QZ32
	 T5gM5nI6nNARKH7y3gesA9y7ig+vuEhQm4yJ/bqc1KDikH+6Ds6M4EEbnO/cYOb1P7kf6
	 glepCc38zdLO2R8NnUH6/CemitNBuM5ICYwn+TMsCcbMTBRq3PpO+lOhF2edwE03dK2PY
	 oOHvXc4gVngq2yAUVtSTtAMgcsMc9Kw0vUm818pgdPWDwN2ljvKnKyXBdpMdqoz10NtlL
	 1rFZSX0RBlRqjQp+vTqoa9LArGDuXMtJT2QAfmse1wO4LpOQ3Fowjfx7KnR0BLEBT/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635411;
	bh=eL1B2Sjmx4imK2h5sCj010PvA/p7QuoZbvOkEYm2F04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajkOYnpw+F41zPHrbFH/vtSO0dL78JcYg8gffrqN34ux0mRpRfkot7ejnfZi+5EIZ
	 GSRPlODM77wZwn4fNPVoG5aVLx8iaPxOb/gK8VOJkGbFevIwtAty0qrYTzQzBKs2lc
	 sqaUydLc6Ci6Al/c50J1XrQ2Z/nrjIyGxRe8xPRlkvoGVGJc5hVrjfe5US7rQoU6r9
	 FTPEWrZREN/C4/ylEe8UXampUg38ZRJAVGtxLUF76XVJaQS6vpqs0XI5bdyeUouKHR
	 k9sCSgWa701JS/Ix1LDhsFFGv5f7YxwLAof0Q+plCrpvo1/ikytYZ6FuKqN91WjOn9
	 kcwNHp8sdmxag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E971E80A50;
	Mon, 28 Sep 2026 22:43:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1F861
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1EC460625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiczX5RK7KuK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 25BDD60614
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790635407;
 b=Z87yemEEuH0gj0A5NJs5+f9qQrJ3VQiDAMbNzkGEsY/L2A+ndS/9HU3JqUn6xP09UfU+
 GtPVVidS+MAwlrMImIFMuYQOlZUnwMWTzuok+T7Dry+PwpZrSJmAtbLUlKq3SeB1cxnoW
 4aE69stFITGxDCnU3Xdk331iyWUYBxQIKwyIAz5gqMuuTOnj0OunSuljTGs0ti+itk37g
 IOVllbUeZjEFxc/OwrjNUwtgAbrtktAEkuYhO+BFoR8VLqLBX/iLII/sZm5UzSpCAElm5
 Rb/mClBHYKE3p/toOuMqhdD9HiOydz4uGqd41/LufYcsvTf7MYdPKvhUqwd932u9ryg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=eL1B2Sjmx4imK2h5sCj010PvA/p7QuoZbvOkEYm2F04=;
 b=Cjp5UXFTv3F02v3u5l3QoDY0sWURSQJN3SqAhiylnTLvO6u9OzLMsaI+n1ebjprygGfY
 uC5lu7UfybXkmSuJeSaJD/bOy+B2f2YetMoHvFURZsz++bbq8qzdJNtYbbE810esj6i9z
 RvAfIcCOus5PYd31Gfs/3aDpP8/dVuNimn55sV/Cqt0f7svylo4afxOMtiMDRnBikyu/l
 MTRQq3HEtD2vef7ZzQeW60sZweuIFeBCJUnltarUgi7U3DYY8/Xez5qhZBaAG6TSUsaO1
 xc1nphLQH6as8Rpklt+cZEjqzGgbyujmpP0BTA+ZnFN6zS2D74OIr94zRaIrU3duTRQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kyrSDkoj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kyrSDkoj
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25BDD60614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:26 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-8137b129131so2356440a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790635405; x=1791240205;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eL1B2Sjmx4imK2h5sCj010PvA/p7QuoZbvOkEYm2F04=;
 b=kyrSDkoj9h9/nZ5m1XNWdkCsWqpt4nfl2RlTDGXHWzXGyX7i8wwUGvxqGLMKpxy/x2
 uhnr2aQcdXyNn61iFnXSu/29OmTPYE9ty2u3ayS5stJ7XW996Uk37C4YxzV/bxy8V/Dw
 D2pnJbFI2ROuXbYRaBM9aiiIQm51OOu3n22FyTF4Eb+QZgdjxrRDttGRYp3ewOCdxcMZ
 xqhoFFQ6ky3BaADFKYjWivCdQs3GNUNlnMJGR74MeR/LXtOUNSlYNwkCGvxt54L4mQWL
 ma9TTwLJoMUQmgxdpmHAwO+CubSfrldjPhMLvYAg7VS8UV/tqyLQ3BUtYgeCj7WtezW4
 tR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635405; x=1791240205;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eL1B2Sjmx4imK2h5sCj010PvA/p7QuoZbvOkEYm2F04=;
 b=I4zQc0Q4z/axSnOtX0el9Ob3rSLFPP2GjERRmrEPi9ZuX66coNXN4+TbO+QXETxP6/
 HTeGQYpM0XedR09KZAHAWaPie6zDILZoBadA4HLOimY+SehkBqQVojuVaXBUr5UnvEUH
 bFoJWujsLJJvTaKQXsSZij/QMMT3ecuVe0HH2CefgsaQ6C5vbWiDByOh8ODOOubwPAOk
 G7rO3hkcvTR1wHHd9qz8dByActI+RMhhKvvlnli9P+Tky+vL9m9IoeosBtD+7fZ9taGC
 DSjuHnBF0cIdJvMEpbAp0AkIjF51awwNjzQF2NSL/Ctvs9qDfP5vnem80uTP2KFHaIbj
 tmOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzE5vOoJQUDAt7hze2qwH7MvxpPpk4Il8NSR+jVeb8t/ZJ0L/7iEKI8YlGq6bKChgrAHY2IaoI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n798y8Na7IMIIu5XP06ajy5H6vQ82p1dB3677V3G0lOvJMgEmT
 7FtJ0wP3VhywlAK09+caVd3w9PakFatioTCaTyDaQZrO1WU498BFBctNr/9CrYX0p0drVOdBQre
 NegEO
X-Gm-Gg: AYBFou1ukiw0F8aemoYJmlrJOiYxaigyqrTPYUwl5daU4IESiVqSzKO9zQkpWFXnOzU
 MtzPqWsYeuV4sdzHMmBV00vZ7w7Pj7JaZzURCbB+GtU1llJlUmzt60Z7b1QnlUXFr4TN/Q93OTr
 gRtSsltpkUZJpPwGqtj2TIf558X6S6yCWVNeSu1DKaFyfUfjvU8Ss9RBENFRNtpQf4xIEUZsIvt
 Zh6F11vTVTUakKQfh1ZNFS5dy9hbJOc0hr6h9VWcW/0OYpK/y3RFB4WGb6kkdVj2cmaBJY6QFK3
 vSz/wseoCnqjyYrCfl59O/2l0pWzvct+c2U0OHbIIhaxAwPxDzFD+V90mG/VeFt8Lmqz0lVwbF0
 u278cMcDVG9h7cLnVTY4hQRtD2pnZyQ3hQEwOxBU3kM+kA8KULeA4UEuXWh4NpsXFmFeOYeaRBt
 epJEIcc83vgKJXpeYP7qh/rs5hTvSNJLFOL+/N+eiEQoGRAFIIRTbtOZOtdzKyLYzN2hON+Ondd
 yOeNgmxmSyzV9ECFHBzZ3bdKc9fFdsW7LHOCTcn8rltsLJp0W4dzfuWLqA=
X-Received: by 2002:a05:6820:629:b0:6d7:a13d:fd7b with SMTP id
 006d021491bc7-6d7a13dfff1mr5217834eaf.28.1790635405336; 
 Mon, 28 Sep 2026 15:43:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9b16:2a1a:ef3f:3700?
 ([2600:8803:e7e4:500:9b16:2a1a:ef3f:3700])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d882bd143asm6950454eaf.8.2026.09.28.15.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 15:43:23 -0700 (PDT)
Message-ID: <5a9f1311-09ad-4c8d-8df6-09c26106d3b4@baylibre.com>
Date: Mon, 28 Sep 2026 17:43:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: mediatek: enable SPL fastboot DAs on Genio
 510 and 700
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
 <20260923-ccaione-upstream-mt8390-da-v2-1-8f264678ac29@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260923-ccaione-upstream-mt8390-da-v2-1-8f264678ac29@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/23/26 4:17 PM, Carlo Caione wrote:
> From: Julien Masson <jmasson@baylibre.com>
> 
> Genio 510 and 700 need a way to provision blank eMMC and recover from
> unusable boot firmware without relying on the installed bootloader.
> Add a BootROM-loaded fastboot agent that also prepares the eMMC boot
> settings so newly flashed firmware can boot.
> 
> U-Boot proper is preferred when the complete agent fits BootROM's SRAM
> download area before DRAM initialization. Provide the SPL alternative
> for tighter payload budgets, avoiding the space required by BL31 and
> U-Boot proper. An external DDR loader is still required.

This is a bit short on details of why certain tecnical descisions are made
in this patch.

> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
>  arch/arm/dts/mt8370-genio-da-u-boot.dtsi           | 61 +++++++++++++++++++
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
>  arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 17 ++++++
>  .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  2 +-
>  arch/arm/mach-mediatek/Kconfig                     | 28 +++++++++
>  arch/arm/mach-mediatek/Makefile                    |  3 +
>  arch/arm/mach-mediatek/spl_fastboot.c              | 68 ++++++++++++++++++++++
>  board/mediatek/MAINTAINERS                         |  5 ++
>  common/spl/Kconfig                                 |  2 +-
>  configs/mt8370-genio-da-spl-fastboot.config        | 21 +++++++
>  configs/mt8370-genio-da.config                     | 12 ++++
>  configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
>  configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
>  drivers/usb/mtu3/mtu3_core.c                       |  5 +-
>  15 files changed, 233 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> index 10b9a142f37..2ee7fb1f40c 100644
> --- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> @@ -14,3 +14,7 @@
>  #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
>  #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
>  #endif
> +
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
> +#include "mt8370-genio-da-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> new file mode 100644
> index 00000000000..9d0d057cfc9
> --- /dev/null
> +++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +/*
> + * Download agents (DAs) run from RAM to provision or recover eMMC.
> + * Both variants expose USB0 as a peripheral and leave unused USB
> + * controllers disabled, independently of the normal boot USB setup.
> + */
> +
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-da-binman-u-boot.dtsi"
> +
> +&ssusb0 {
> +	dr_mode = "peripheral";
> +};
> +
> +&ssusb1 {
> +	status = "disabled";
> +};
> +
> +&ssusb2 {
> +	status = "disabled";
> +};
> +
> +/* Only the SPL fastboot variant needs these USB dependencies in SPL. */
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
> +&pericfg_ao {
> +	bootph-pre-ram;
> +};
> +
> +&ssusb0 {
> +	bootph-pre-ram;
> +};
> +
> +&u3phy0 {
> +	bootph-pre-ram;
> +};
> +
> +&u2port0 {
> +	bootph-pre-ram;
> +};
> +
> +&usb_default_pins {
> +	bootph-pre-ram;
> +
> +	pins-iddig {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-valid {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-vbus {
> +		bootph-pre-ram;
> +	};
> +};
> +#endif
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> index 6230b016ca0..4fedbda9b3f 100644
> --- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -14,3 +14,7 @@
>  #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
>  #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
>  #endif
> +
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
> +#include "mt8370-genio-da-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..9627785cc56
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +&binman {
> +	da: da {
> +		filename = "da.bin";
> +		pad-byte = <0>;
> +
> +/* DA authentication is handled by the BootROM download tooling. */
> +#define MTK_GENIO_SPL_NO_FIT_KEYS
> +#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
> +#undef MTK_GENIO_SPL_NO_FIT_KEYS
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> index 2dd13d261a0..6c99d0926c4 100644
> --- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> +++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> @@ -12,7 +12,7 @@ ddr-loader {
>  	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
>  };
>  
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#if defined(CONFIG_SPL_FIT_SIGNATURE) && !defined(MTK_GENIO_SPL_NO_FIT_KEYS)
>  u-boot-spl {
>  	type = "section";
>  	size = <CONFIG_SPL_MAX_SIZE>;
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index e572cfe8571..eece6456e43 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -249,6 +249,34 @@ config MTK_GENIO_BL31_LOAD_ADDR
>  
>  endif
>  
> +config MTK_BROM_DOWNLOAD_AGENT
> +	bool
> +	depends on TARGET_MT8188 && SPL
> +	select BINMAN
> +	select MTK_GENIO_IMAGE_CONTRACT
> +
> +choice
> +	prompt "MediaTek BootROM download agent"
> +	optional
> +	depends on TARGET_MT8188 && SPL && SUPPORT_EMMC_BOOT
> +	depends on !MTK_GENIO_BOOT_IMAGES
> +	help
> +	  Select where to run fastboot after the BootROM downloads the agent
> +	  into RAM. Leave this disabled for normal storage boot.
> +	  Download agents cannot also build the normal storage-boot images.
> +
> +config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
> +	bool "Run download-agent fastboot from SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC
> +	select MTK_BROM_DOWNLOAD_AGENT
> +	select SPL_BOARD_INIT
> +	help
> +	  Build an SPL which enters USB fastboot after the MediaTek BootROM
> +	  downloads it into RAM. The download agent also configures the eMMC
> +	  boot partition so that a newly flashed board can boot normally.
> +
> +endchoice
> +
>  config MTK_TZ_MOVABLE
>  	select ARCH_MISC_INIT
>  	select OF_SYSTEM_SETUP
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 35f748a70d6..2a371664d1d 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
>  obj-y	+= cpu.o
>  obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
> +ifdef CONFIG_XPL_BUILD
> +obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
> +endif
>  
>  obj-$(CONFIG_TARGET_MT7622) += mt7622/
>  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> diff --git a/arch/arm/mach-mediatek/spl_fastboot.c b/arch/arm/mach-mediatek/spl_fastboot.c
> new file mode 100644
> index 00000000000..73744946314
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/spl_fastboot.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Masson <jmasson@baylibre.com>
> + */
> +
> +#include <dm/uclass.h>
> +#include <fastboot.h>
> +#include <mmc.h>
> +#include <stdio.h>
> +#include <linux/errno.h>
> +
> +static int mtk_mmc_boot_prepare(void)
> +{
> +	struct udevice *dev;
> +	struct mmc *mmc;
> +	int ret;
> +
> +	/* No storage loader has run yet, so probe the device here. */
> +	ret = uclass_get_device_by_seq(UCLASS_MMC,
> +				       CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV), &dev);
> +	if (ret) {
> +		printf("Cannot load MMC device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mmc = mmc_get_mmc_dev(dev);
> +	if (!mmc)
> +		return -ENODEV;
> +
> +	ret = mmc_init(mmc);
> +	if (ret) {
> +		printf("MMC init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable BOOT1 and boot acknowledgment for normal BootROM startup. */
> +	ret = mmc_set_part_conf(mmc, 1, 1, 0);
> +	if (ret)
> +		printf("Cannot configure the eMMC boot partition: %d\n", ret);
> +
> +	/* Reset to x1 SDR, backward-compatible timing for each boot. */
> +	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
> +	if (ret)
> +		printf("Cannot configure the eMMC boot bus: %d\n", ret);
> +
> +	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
> +		ret = mmc_set_rst_n_function(mmc, 1);

If I understand correctly, this makes a permanant change to the eMMC hardware.
It is documented in patch 3, but I wonder if we should add a comment here too.
And I wonder if anyone would not want that setting.

> +		if (ret)
> +			printf("Cannot enable the eMMC reset function: %d\n", ret);
> +	}
> +
> +	return 0;
> +}
> +
> +void spl_board_init(void)
> +{
> +	int ret;
> +
> +	ret = mtk_mmc_boot_prepare();
> +	if (ret)
> +		printf("MMC boot preparation failed: %d\n", ret);
> +
> +	puts("Waiting for fastboot commands...\n");
> +	ret = fastboot_usb_run(0, NULL, 0);
> +	if (ret)
> +		printf("Fastboot failed: %d\n", ret);
> +}
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 20befdba0e2..61fefcf9a34 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -18,13 +18,18 @@ MT8188/MT8370/MT8390
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  M:	Julien Stephan <jstephan@baylibre.com>
>  S:	Maintained
> +F:	arch/arm/dts/mt8370-genio-da-u-boot.dtsi
>  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
>  F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
>  F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
> +F:	configs/mt8370-genio-da-spl-fastboot.config
> +F:	configs/mt8370-genio-da.config

These are not sorted in order.

>  F:	configs/mt8188.config
> +F:	configs/mt8370_genio_510_evk_da_spl_defconfig
>  F:	configs/mt8370_genio_510_evk_defconfig
> +F:	configs/mt8390_genio_700_evk_da_spl_defconfig
>  F:	configs/mt8390_genio_700_evk_defconfig
>  F:	doc/board/mediatek/mt8188-genio-evk.rst
>  
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 9bce4ab3955..c6fa647670b 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
>  config SPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in SPL"
>  	depends on SPL_FRAMEWORK && BINMAN
> -	default n if MTK_GENIO_BOOT_IMAGES
> +	default n if MTK_GENIO_IMAGE_CONTRACT
>  	default y
>  	help
>  	  This enables use of symbols in SPL which refer to other entries in
> diff --git a/configs/mt8370-genio-da-spl-fastboot.config b/configs/mt8370-genio-da-spl-fastboot.config
> new file mode 100644
> index 00000000000..6ba12f7d282
> --- /dev/null
> +++ b/configs/mt8370-genio-da-spl-fastboot.config
> @@ -0,0 +1,21 @@
> +#include <configs/mt8370-genio-da.config>
> +
> +CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
> +# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
> +# dlmalloc also caps individual SPL allocations at SYS_MALLOC_LEN.
> +CONFIG_SYS_MALLOC_LEN=0x1000000
> +# Resume from the user-area FIT after fastboot continue.
> +CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
> +CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_PHY=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_USB_MTU3=y
> +CONFIG_SPL_FASTBOOT=y
> +CONFIG_SPL_FASTBOOT_REBOOT=y
> +CONFIG_SPL_FASTBOOT_FLASH_MMC=y
> +CONFIG_SPL_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
> diff --git a/configs/mt8370-genio-da.config b/configs/mt8370-genio-da.config
> new file mode 100644
> index 00000000000..46cb42b37ba
> --- /dev/null
> +++ b/configs/mt8370-genio-da.config
> @@ -0,0 +1,12 @@
> +# USB identity and transfer buffer shared by both download-agent modes.
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_PHY=y
> +CONFIG_PHY_MTK_TPHY=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_MTU3=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
> +CONFIG_FASTBOOT_BUF_ADDR=0x65000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x15000000
> diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
> new file mode 100644
> index 00000000000..bb537616b53
> --- /dev/null
> +++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
> @@ -0,0 +1,2 @@
> +#include <configs/mt8370_genio_510_evk_defconfig>
> +#include <configs/mt8370-genio-da-spl-fastboot.config>
> diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
> new file mode 100644
> index 00000000000..7f1ba02c6e7
> --- /dev/null
> +++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
> @@ -0,0 +1,2 @@
> +#include <configs/mt8390_genio_700_evk_defconfig>
> +#include <configs/mt8370-genio-da-spl-fastboot.config>
> diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
> index f296a72cf18..d8ef6e6afba 100644
> --- a/drivers/usb/mtu3/mtu3_core.c
> +++ b/drivers/usb/mtu3/mtu3_core.c
> @@ -843,7 +843,10 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
>  	mtu->mac_base = ssusb->mac_base;
>  	mtu->ssusb = ssusb;
>  	mtu->max_speed = usb_get_maximum_speed(dev_ofnode(ssusb->dev));
> -	mtu->force_vbus = dev_read_bool(ssusb->dev, "mediatek,force-vbus");
> +	/* Fixed peripheral mode must not depend on OTG session detection. */

Why not? From what I am seeing in the Linux driver it doesn't do this.
And I'm not sure why mt8183 has "mediatek,force-vbus" here in the U-boot
devicetree. Maybe lack of proper pinmux for that target in U-boot?

I feel like we should not be doing this for new boards. I would only expect
to need to force vbus on a board where vbus wasn't wired up properly. That
isn't the case here.

Is fastboot broken without this change?

> +	mtu->force_vbus =
> +		usb_get_dr_mode(dev_ofnode(ssusb->dev)) == USB_DR_MODE_PERIPHERAL ||
> +		dev_read_bool(ssusb->dev, "mediatek,force-vbus");
>  
>  	ret = mtu3_hw_init(mtu);
>  	if (ret) {
> 

