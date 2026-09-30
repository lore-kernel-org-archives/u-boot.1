Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD3DCA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87E414084D;
	Wed, 30 Sep 2026 10:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YobOnc2v_Rbs; Wed, 30 Sep 2026 10:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39966407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790764918;
	b=jyfDWHqyB7L5tjTrzg/3j9DnKp1pB4iglbzK7GJvCfzB7gtvbwhwrkdZaM1+6F0Atf2h
	 I1KcEfBWLAU/r3t2IyxZ6pQRq9zDyIwctJKHBnLtgI8HEyuDfVvnSs+1/BNW4swOkicJ+
	 EuRvOhJBLhnvsnKeCf43i0bq0jgmnblRSTzOz3lORez5ZE8zKHreQyHXN3wtMSEdIL2qA
	 3Th8QBmt+UfxNqIkH2CcMkUS/ctrpzezD3A/X2xcG14wVX7o9zZ8Eyd2OustNROjuEONV
	 X0zYOkDJ4hCP0DVBEKeiKo1EYZdG02kgD2ohRxvCeLwIdBHpMo7HdXICi40iu4ScxRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790764918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kCRhXWIjMsvGsQ054/dzbaLjNm6AOAAlO9JScWW1ofA=;
	b=Ujz/TZfnJPFB3nNwjZ8qaRF8wct9AvxXfZ8SpHlfXeU2DyJhYOH/SI3RynuGPU4h0aiK
	 g843tQStIfOV7zeURx7zJEHOqwtaNHcFRXO4dVLRNNRYu6mtAwQnVmI6pwdW6/g9OCKgc
	 oALj1J/imp17yeI30sPgxiXukP4N0PNh+lGFuMnbyI3UqwDjYFaO3QK7oXoNOE9s7Z6no
	 runlIu5Soei3xsB8nltDk6yCpZUS05qZidMCeWutxzDI2ahvOv3zpO7MOIUOJm9r0zgEV
	 vNkFUZ1x8W2twW3wUvtsm6jRY/WUyHVliVIYzoYtWPDGOoa3Le9bKYneU7VkZZYUshQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790764918;
	bh=kCRhXWIjMsvGsQ054/dzbaLjNm6AOAAlO9JScWW1ofA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hkyuEREslGIXrTV/xwxfodTMet2ezAuWaWFhTZ/97OO5Uh6gWMSWp+LgfCQI29gHj
	 mXfDhVVZBeaV8JZGoMr1OM8N2WzpiiR6e7DOfyNyvLnUnQltXyyXrC0D30BZ2/RA+y
	 nLbgUc24m6eU/Qx4UGg5nESiDu37XKWxvrHrBOrHBrw0ifoFRnicgPGGYgbsHNB606
	 dzfC5y2ghWidqs852D91cy/XCq/bFpA/LCX3P7gr3N+rsOHowLGUQznGnwIJktMi6D
	 iQqGvHrITRDWKAgp4WGj4r9rzsnKht/r7UEvxEjU9fDcsEFVQZpktTTJDtrY1qIzv+
	 VKQMIgmmzqPkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39966407F3;
	Wed, 30 Sep 2026 10:41:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EF6E32A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14F024039B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7MNvfXeN_iRl for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 10:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 09CD840395
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790764912;
 b=d5DUxgsnntsICYozcOURILfeLVXzw1ANLTPLyHtfH/EkSPGWFvNfckysaua2BJRDALKh
 QWvYRmHgdyJ782syddX+6TB+GFuH/sMGk49rAdP8IP1wa0X45XXgQ2s+cOo+QDnezEcCP
 KchwSDGklq/HjOeMBKEOHQyg+nWj+BDK+ylENlWDWVVCd3SuJqad8R28cMR399qCfprYp
 tW+V4DXb0dIXsePqBNp0/qzq6OtgaqrS9EKofpXSAJ27UDOB9Nn6pGvC6WSYaMA1ovX6L
 XIoMuiLGfhzCLnmNvgHPVDAn3yzySWb9b5GsPd8HFoK85JUYGVm8aDXniyHL6zbBMhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790764912;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=kCRhXWIjMsvGsQ054/dzbaLjNm6AOAAlO9JScWW1ofA=;
 b=psJA33sj/cZWDxLscL9O23pT8JSHBViDm3++Msea7rfZOX44p0o2W2a0HslP6Jpi74VD
 pQiwwnQan3aGn997ihoxP8js/MUIvZnUKq7DGUDnQhmTdsLE3lFlJW7Bjvahx6CnfjpNf
 Y3tb4TXXp6iljnb5yUclTlj3aXg9ejqXES+1JAHw4eyAFZzB4Ev4xyd0PMH+wnwdAQFZo
 LwP0o2pyx4DOd1fKp2bHTztrFTVLJdFHQ+6J108X41/0w8iNkAh0u4qBlRhhwWFiZETqA
 mLBOqbAEZ61xgNTDJSq2VRIFm5PXdjFvL6VPKZ1HP0+AsE+cfx8QbXz10IWuaKlY7FQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dQbcrHaq; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dQbcrHaq
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09CD840395
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:51 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso39505135e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790764909; x=1791369709;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kCRhXWIjMsvGsQ054/dzbaLjNm6AOAAlO9JScWW1ofA=;
 b=dQbcrHaqksQTf3iEXBbaEQ35kxhkNgJtiUYMCbmQ5hziEpxSnTwmdRV/26fcmCux8z
 mx+c0NQ7LPb4nXOeqTzF220KYklrMZAX7Hlm7Aydw88gG1hSLVI+9yasRHN2dmd3Yj/z
 oSriPxRgNIvmA88f0UZvxZFHATBestzhZGxyIKnmzSJCly9JLL2fe3PrHi2NXbZCZB6Q
 RAZHrQJXs47TPLnIUpzdL/6+eZPqTwWI3OKw62cMMbOcp1XymkgJLz6Qd5rWROCCZIBK
 dfFdPUmR2JcONQ/ZNtkKyeBxkzNRk7Zcf9NVzd8nXAwfuv0V4VJoZ7j5wjzuiep6KHFZ
 R2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764909; x=1791369709;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kCRhXWIjMsvGsQ054/dzbaLjNm6AOAAlO9JScWW1ofA=;
 b=TvaxiYZ7WSPmuPqmb2ZAcRWacQleAb76sLYNS5Tq6CAqhIb7xfr9TgePhXHqnRCZxI
 Eea/SjsQ9ng+LXkpHzwp3+ErvI9/dOPSTqzl4YqrOXWBRT0Jxoi6thQcfvxg9VTdJLXr
 grQMJWWIRnQN2kHC0g2ykwz1N1L2fspFCV/K+2eGmjKm4MpkTMg9q5YHvmY98EGAJdFv
 8aqDmE5fAi+5F0aMv+i/XPD84/WSVwxiwXRhffa81Q2VwU6breTF406CfRrdVWsvkdZp
 INfBVPhQUuLleCuj/DXix9e2XMN8WNkCrKxEX4JcvTCDSscN9GAp9BCGD2BtiUZHZT1X
 oUlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQeTIeIdhK+5/2vpCW/3tl4qjKu3i484pNQx2h6fFfK6kwj5O7kX2JriHnMGd2Q/WeeDEIpMI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGDYJAhpcrh9lNXNp8QeX7lF1+kZSKjfw8cHKsZrCoWyiS/iaD
 6hiEOFwU6dihSnCseYoGpz6WI4NGiZiXC4Vs/0P4/oeXiMO2mk+71VRJuHud9RzSn9A=
X-Gm-Gg: AYBFou1YqsJxmvvoX72ep7jvFs8sSnVDQkgKWamMFnJsJEYQzRHxmgsN6hM7bYIfznp
 iwj0Lb9x82i6BF0NUavxKDmDzmEQjaSCVJFVV7SRXiz+C/WbHiMYhBXKLcfLOc5ciLbs+mRRlOX
 3DQ4iC8RiD3T7cFd3GY2mNGzIn+xkioiKmuaOP9aYC+V9mqWCsuVFsp7badr00QeoNnYJFhTUKo
 xfUQ1hEod28qFqFNtPnrJypO3EI592z92RpcNMeRixfxbnMQqCxrFZgqlrmnmP8bLfd0qvQ8meq
 ngfMcV8zVCCF+y2cobNWbLERwlKPPx7lNfJuPcQNOPVO5m/QGULmRnqV0z6JJwHTvz6xTnu14Km
 5LrB2zzizEHf9XmQxRVzYpMSPaA57QZgp0Ii3+rIV/qB4uP44TLS2T0ra1tn/twQE/ycG5JRwrr
 FAa9LDI/THw2ZGi4DFJFZrFlvPbeEnW8qTbZbWHztwmhoyCNZwlelXktqIje90hULc16kPNiwDh
 g7NjOrwmR+o93bU0/yoKvMH+WPWf3mUH7mndDLrnGlFeTAaFpDtBeRlrFky3mYP5He8miaPo3fW
 PvTkF2aafsvlwbg5fZ+T6sMEXDfcNdiNI9n0iLf2Z/S3V/bAZ2gJUtv9VcEDqFlG9A==
X-Received: by 2002:a05:600c:4691:b0:49e:799a:8951 with SMTP id
 5b1f17b1804b1-4a01aff4450mr14238965e9.11.1790764909219; 
 Wed, 30 Sep 2026 03:41:49 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e161bsm71190345e9.5.2026.09.30.03.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:41:48 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/4] arm: dts: mediatek: add Genio 360 EVK
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260918-mtk-genio-360-bringup-v5-3-31451a136f96@baylibre.com>
References: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
 <20260918-mtk-genio-360-bringup-v5-3-31451a136f96@baylibre.com>
Date: Wed, 30 Sep 2026 12:44:06 +0200
Message-Id: <179076504678.1985961.8615017660759436894.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790765050; l=14804;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=+j72LUkPuc9T9CAeoCvXqhp9EzsEsBr8TrOLEjZp1Mg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QByxzWjUD6iTiF63LUXBPRrwY7wfYs2/5HiqeJ8ADg2KbWJ0hldAbPrsLvGxWQjjviOQeV1BJG7
 kyyyhE/049Q4=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add a devicetree for the MediaTek Genio 360 Evaluation Kit board.
>
> Upstreaming of this board has not even started yet, so we will have to
> carry a downstream version of this for some time.
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1b533721bb4..bd093e219d9 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1089,6 +1089,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt7988-rfb.dtb \
>  	mt7988-sd-rfb.dtb \
>  	mt8183-pumpkin.dtb \
> +	mt8366-genio-360-evk.dtb \
>  	mt8371-genio-520-evk.dtb \
>  	mt8371-genio-520-evk-ufs.dtb \
>  	mt8391-genio-720-evk.dtb \
> diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
> new file mode 100644
> index 00000000000..b4c0e44e763
> --- /dev/null
> +++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +
> +#include "mt8366.dtsi"
> +#include "mt6366.dtsi"
> +
> +/ {
> +	aliases {
> +		ethernet0 = &eth;

Please add serial0 = &uart0 here (and drop it from mt8366.dtsi).

> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/* 4GB */
> +		reg = <0 0x40000000 0x1 0x00000000>;
> +	};
> +
> +	firmware: firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@54600000 {
> +			no-map;
> +			reg = <0 0x54600000 0x0 0x200000>;
> +		};
> +
> +		/* 12 MiB reserved for OP-TEE (BL32)

Nit: multi-line comment style. Put "/*" on its own line.

> +		 * +-----------------------+ 0x43e0_0000
> +		 * |      SHMEM 2MiB       |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |        | TA_RAM  8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |        | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			no-map;
> +			reg = <0 0x43200000 0 0x00c00000>;
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = &uart0;

Use stdout-path = "serial0:921600n8" (with the serial0 alias), as
upstream Genio boards does.

> +	};
> +
> +	usb_p1_vbus: regulator-usb-p1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb-p1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	/*
> +	 * Panel VDD and IOVCC rails are switched by the same enable GPIO,
> +	 * so both -supply properties on the panel node point at this one
> +	 * regulator instead of duplicating the GPIO across two nodes. This
> +	 * works as long as we don't care what the voltage is. Technically,
> +	 * there are two separate regulators though.
> +	 */
> +	regulator_dsi0_lcm: regulator-dsi0-lcm {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dsi0-lcm";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dsi0_lcm_pins_default>;


> +		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	backlight_lcd0: backlight-lcd0 {
> +		compatible = "pwm-backlight";
> +		pwms = <&disp_pwm0 0 500000>;
> +		brightness-levels = <0 1023>;
> +		num-interpolated-steps = <1023>;
> +		default-brightness-level = <576>;
> +	};
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&snor {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&snor_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <52000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
> +&disp_pwm0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&disp_pwm0_pin_default>;
> +};
> +
> +&dsi0 {


> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	panel@0 {
> +		compatible = "startek,kd070fhfid078", "himax,hx8279";
> +		reg = <0>;
> +		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel0_pins_default>;
> +		backlight = <&backlight_lcd0>;
> +		vdd-supply = <&regulator_dsi0_lcm>;
> +		iovcc-supply = <&regulator_dsi0_lcm>;
> +		status = "okay";
> +
> +		port {
> +			panel0_in: endpoint {
> +				remote-endpoint = <&dsi0_out>;
> +			};
> +		};
> +	};
> +
> +	port {
> +		dsi0_out: endpoint {
> +			remote-endpoint = <&panel0_in>;
> +		};
> +	};
> +};
> +
> +&mipi_tx_config0 {
> +	status = "okay";
> +};
> +
> +&mutex0 {
> +	status = "okay";
> +};
> +
> +&disp_ovl0_4l {
> +	status = "okay";
> +};
> +
> +&disp_rdma0 {
> +	status = "okay";
> +};
> +
> +&smi_larb0 {
> +	status = "okay";
> +};
> +
> +&smi_disp_common {
> +	status = "okay";
> +};
> +
> +&pio {
> +	disp_pwm0_pin_default: disp-pwm0-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO64__FUNC_DISP_PWM0>;
> +			output-high;


> +		};
> +	};
> +
> +	panel0_pins_default: panel0-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO63__FUNC_GPIO63>,
> +				 <PINMUX_GPIO65__FUNC_GPIO65>;
> +			output-high;


> +		};
> +	};
> +
> +	mmc0_pins_default: mmc0-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0-uhs-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc1_pins_default: mmc1-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
> +				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-insert {
> +			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_pins_uhs: mmc1-uhs-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
> +				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	usb0_default_pins: usb0-default-pins {
> +		pins-vbus-valid {
> +			pinmux = <PINMUX_GPIO54__FUNC_VBUSVALID>;
> +		};
> +	};
> +
> +	dsi0_lcm_pins_default: dsi0-lcm-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
> +			output-high;
> +		};
> +	};
> +
> +	snor_pins: snor-pins {
> +		pins-ck-io {
> +			pinmux = <PINMUX_GPIO57__FUNC_SPINOR_CK>,
> +				 <PINMUX_GPIO59__FUNC_SPINOR_IO0>,
> +				 <PINMUX_GPIO60__FUNC_SPINOR_IO1>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down;
> +		};
> +
> +		pins-cs {
> +			pinmux = <PINMUX_GPIO58__FUNC_SPINOR_CS>,
> +				 <PINMUX_GPIO61__FUNC_SPINOR_IO2>,
> +				 <PINMUX_GPIO62__FUNC_SPINOR_IO3>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	eth_default: eth-default-pins {
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
> +				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
> +				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
> +				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
> +				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
> +				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
> +				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
> +				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
> +				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
> +				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
> +				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			input-enable;
> +		};
> +
> +		pins-power {
> +			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
> +				 <PINMUX_GPIO26__FUNC_GPIO26>;
> +			output-high;


> +		};
> +
> +		pins-reset {
> +			pinmux = <PINMUX_GPIO28__FUNC_GPIO28>;
> +		};
> +	};
> +
> +	eth_sleep: eth-sleep-pins {
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
> +				 <PINMUX_GPIO13__FUNC_GPIO13>,
> +				 <PINMUX_GPIO14__FUNC_GPIO14>,
> +				 <PINMUX_GPIO15__FUNC_GPIO15>;
> +		};
> +
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
> +				 <PINMUX_GPIO23__FUNC_GPIO23>,
> +				 <PINMUX_GPIO22__FUNC_GPIO22>,
> +				 <PINMUX_GPIO21__FUNC_GPIO21>;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
> +				 <PINMUX_GPIO17__FUNC_GPIO17>,
> +				 <PINMUX_GPIO18__FUNC_GPIO18>,
> +				 <PINMUX_GPIO19__FUNC_GPIO19>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
> +				 <PINMUX_GPIO25__FUNC_GPIO25>;
> +			input-disable;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +&ssusb {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_default_pins>;
> +	role-switch-default-mode = "peripheral";
> +	wakeup-source;
> +	status = "okay";
> +};
> +
> +&usb_host0 {
> +	status = "okay";
> +};
> +
> +&usb_host1 {
> +	vbus-supply = <&usb_p1_vbus>;
> +	status = "okay";
> +};
> +
> +&usb_host2 {
> +	status = "okay";
> +};
> +
> +&u3phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	mmc-hs400-enhanced-strobe;
> +	hs400-ds-delay = <0x10100>;
> +	cap-mmc-hw-reset;
> +	vmmc-supply = <&mt6366_vemc_reg>;
> +	vqmmc-supply = <&mt6366_vio18_reg>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +};
> +
> +&mmc1 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_pins_default>;
> +	pinctrl-1 = <&mmc1_pins_uhs>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	cd-gpios = <&pio 94 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&mt6366_vmch_reg>;
> +	vqmmc-supply = <&mt6366_vmc_reg>;
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +&eth {
> +	/* The TX clock delay is provided by the board, only RX needs an ID. */
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&phy>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default>;
> +	pinctrl-1 = <&eth_sleep>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-idc0ff.0421";
> +			reg = <0>;
> +			reset-gpios = <&pio 28 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <10000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/mt8366-genio-360-evk.dts b/arch/arm/dts/mt8366-genio-360-evk.dts
> new file mode 100644
> index 00000000000..1bf94e9512c
> --- /dev/null
> +++ b/arch/arm/dts/mt8366-genio-360-evk.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "mt8366-genio-360-evk-common.dtsi"
> +
> +/ {
> +	model = "MediaTek Genio-360 EVK";
> +	compatible = "mediatek,genio-360-evk", "mediatek,mt8366";

Other upstream Genio boards use "mediatek,mt8365-evk",
"mediatek,mt8370-evk", "mediatek,mt8390-evk" and so on. For consistency,
use "mediatek,mt8366-evk", "mediatek,mt8366".

-- 
Julien Stephan <jstephan@baylibre.com>
