Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B338C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 14:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4628B6062C;
	Wed, 23 Sep 2026 14:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ydu7BsZDxRE; Wed, 23 Sep 2026 14:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4336060766
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790172917;
	b=nM7V/KGpw+O62VP8VnyQoRFZaOS+EbCEpJ/anwHp9Uq+bPuVOMKyJu26f4dZLv+V79wa
	 FXUUZygbW75Bnx8whhln5IB19/c+F8+YRhKCCEDksb/m1Piaqr0aEioIF/4nPXaMrvHZZ
	 37mqDQoatcxls48dax3od66U4qOu0UVP8z6WDXVbGTtP0TRg+tZuRDR79yEvZd8SXfESP
	 fQWqF8lnAJH7mqRMrcv7VULkUzIjQ7yfJVRN/Qrjmk2niFSyGuc9XA169E03+QXnwSDiW
	 KtIwP+qpnWkfdHpPZroHf3p0SVoJaTJhbodWMdEDrLhLRfLGH3OvxNfVvRYQram4NPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790172917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=orJ4geoh1YrYDgCOLIvO1SDe2B38Ej0wAI9fHlPnG+U=;
	b=m92Kc32NoxuGCU1kcTL5xKv/wuajq9N/QgLswmelAcYfSj77ikXAQCb3k91chXS4hW7z
	 9iama1Uyu7MBGLpqxZD177Pv/t1lvBeJOoaUcTw5UgJcFJHU/XDwb1m5cNXJ6Wh7C078/
	 OjOMVzMjLmkWIPIE+q9PhvrUwDadF4eWFDItAv4HH+d5PvV4vNK+yi6ogRj11nqXeJtn8
	 Al79kL0/dqJ4BnNb8t8De+epu6sNsWyZbgJHvl34K6n0cyJNPPMfD1bfmXu6IYvK8uH3m
	 wO2rDO+shGjQGdhEhy0AZPLTHrU49eEacmo4PxkePTHYCF89Ual3icRU8FEA4jYRQAw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790172917;
	bh=orJ4geoh1YrYDgCOLIvO1SDe2B38Ej0wAI9fHlPnG+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fq792E7Bw2OkrrUucEuyHLpHLZzz0ir4b/mmLPH7uN8cwdYacL7Rg6Wabe97rKG15
	 ahgHHtbCuSJ1uR1+K+7vBusVgDU/o/p9RZZCzf7fhdkBSzsmIbBH1rcv8OF9xDmGbq
	 9nI2qNV+dH7g5geQE8Wtr1GGFw0eTJZXUm6zCsjOtGNsvqFN+9te67YwPV2hxXwHEd
	 uH/+IvUVrg9GujjC9PFL+aXpB2NSv0d3daTq2IuYNefjTUrrskFI3yBfRozHP7D0nF
	 vpji2aFWoHlpPj6y0d04I+5WF40kJxzXp52mUxp7rM2kDNlHRARMV+9Mspkm6yPJy5
	 kXp5sNwElaxGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4336060766;
	Wed, 23 Sep 2026 14:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F08FEA29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D655C4054E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgw8MhpmSPzT for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 14:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 203A94054B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790172915;
 b=Y401uTUZDV+Pr3vPKF3D1ZmLgfecGH2VcxD+emu4gyzdXp7LOb5NOE8h8FTNOb45CI+/
 wZC0hAPCoy9fTmgaFL5iC9xsETDshWipwtPpY8g59z1BBMGzTX+aedxvkSPsufPSbcKVz
 vHI7u8vkzMGWG1IxpUxytpid21h63rB8Vq5VQ3yMZN/LcaWAv//PZBOFhc5IhVeSZRrbX
 JlBogu1ZWk/KGn5IN+V4ak0XJWYkToe4Ah5cRNySSrIsbVd4uMze5jzSisSmQBlvO9QfQ
 AgAw1gE1EIpzOnozDkpr1Xi6pOHhEwIr3/OljBNaGTo0BdSMFmVEDAcyOs2zvYAd+XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790172915;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=orJ4geoh1YrYDgCOLIvO1SDe2B38Ej0wAI9fHlPnG+U=;
 b=E/ymdooNEIgGZUwHvJIq1n+V+smIDwcPFUyIY/Y9aBTRgKxkSencl/4PBg3JJP6nU4kf
 v0kuiAZCKc5rcHyUxnaXQaaaoaVlQepNCvYeqq+7dT7H9lEMX+y69AxK+lDZRzqOebxl2
 bFtBdZVYWE4C/FzZJw5eR6lhW3z5D8UXF5xFQ4cjYGXDVdPwZ69qo8mCsk7tw6J1Nd0YV
 Vsct5zwWVNwArW05wbAOhXOZ7ucpPlwquQYlu7eonimPcV4Zj+2c/18y+pYd7+HtuIvdz
 SHrq9BeBHVTu8JDVAslPOetA4mfo93KPmFmt80KOND2gGMmmoLf2bEiaUduWxdGvX9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UFNmKqlR; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UFNmKqlR
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 203A94054B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:15:12 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso7494985e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790172911; x=1790777711;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=orJ4geoh1YrYDgCOLIvO1SDe2B38Ej0wAI9fHlPnG+U=;
 b=UFNmKqlRliIvLph0p8zlYE6tOwv3yN/xakUV126F9ho1CZypfa1l9Hk393mPQkItMW
 HtRnLVni60cgks0Z8n2MuiFOErGutyBmybx8lpg8g+acNMiScZvI1Ri7Rt/rrW+EQSVd
 YA9L/obSanhIQx4JS8zmUl6x98CaMoUAIMvbe8z16PmxPcr2TkHyaNbTvuzAopSUNjXj
 2/6w4EgNCJARVwgszQgblVyVd29v/C1oTxuQsD1KRYSBI99kBGeITW1zOzhJLD5rUrU3
 2gOiSE/VIspSk5HFtNgtU/eRJM4ddj8i1omgf9PHhZDZMmUeaNlFz+RcxYM4kUSxtHYK
 IDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790172911; x=1790777711;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=orJ4geoh1YrYDgCOLIvO1SDe2B38Ej0wAI9fHlPnG+U=;
 b=DkRuYilrhI0jkAze51cnLBC6hnLn3bbpWKnbJ0wwJDtE3tGgFzf9VlrfgAsdJNx36X
 4Htr0Sh2DULT1pjYc0FeuI0GYQHIQOl81mDTjkIYKjx514j/vn/xOVQZ9TEfMJCQIcHH
 hBwjip3vWVt2/AidHX9H49+XHAWJ0UoxFxJZgxceQ9vhhK5AKbp7RfBEOK3s3ykcJT5W
 VFrtf18bTLPExPMftRbSF3hcwi6irE2pg37WN5CPCnkvUn1gIDHWaia2Mwwqj9A+coKu
 iDRn/ci7wl5fbp56c/oxwhxjjimFuZcPmqm/ju2usN6ZCcy/ucUsYpI+d46+rqmkUDnA
 LT+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKzEJHDsnVs6yZ31j8plBv/jaUUxfw8t7uLNsZSJ1AVIFuzOegJlWHsgaBohVlsuXcLpkPOMg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mZM2EjtO1+027lcGYE9EiweapnnMUmCdyEt9lc7uJFlQcAWVDj
 X0gAPr5BTCJFRDpxhNM+ASqNmByELD5sS2SX5rbgSU0RQkhdZMY/wK7q7pR3JhBseyI=
X-Gm-Gg: AYBFou3S+0i6Cma/kBN4j7BEhtmnAIncKmk8pUAYyM6u28rrl91SE4BA5orxJpHRpQ6
 OVmQShZrIuKpP+rKqbl6N5S5TZN4+UlSybAoIL2Hc/T9Jh2tkqecAmhrYHVQtRfQaDsWs/7DL9v
 2a6YflfvMfFeb8hL9NKeTBfA3FR8zzAGGws2wNI+q1uvTnHGN5myHjiNMJP+ukyAQfzv640P8dC
 neLRyEYjqcepd5YfkRWbD7N5ymQx0Zq6HO4hELT83quxopK2GzpH2Psd3mRAd9W3AGPxUryTaR2
 XU/5B29K4kWG/WYZgtMENeVy+addl9/D0GexZ88QjRXBLIwIbVX9YjQGv3ngtGxsWHNL8LTXfAI
 ygiyINTIG6mGX/XSyW/qNBDQ4QnOUtbL99pJ0vRe7f0eIz5nBi/3xqECK2g2Eez2kv+DzyxoYdC
 ybTStKretyn+uzeUqYB/yR6Iv99SqjVQvNbw/h/uhr2rotttWjWk6EWzDcTzADiUHBKmYnWVT1O
 b7uYGyYEkqujByDyo6Gujg2ujQLNX6GhdnGh5psoOMAJuNwFTYpIVTPKw==
X-Received: by 2002:a05:600c:1992:b0:49f:bcce:13f5 with SMTP id
 5b1f17b1804b1-49fdf13e14emr34910825e9.24.1790172910904; 
 Wed, 23 Sep 2026 07:15:10 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18af34sm75141915e9.6.2026.09.23.07.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:15:09 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:15:07 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
Subject: Re: [PATCH 1/3] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
Message-ID: <arPV4uDU7S-SbPKs@macbook>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-1-b76f9e30ac38@baylibre.com>
 <81b22e9a-5522-42e8-b9f8-a8cd509f23bc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b22e9a-5522-42e8-b9f8-a8cd509f23bc@baylibre.com>
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

On Tue, Sep 22, 2026 at 11:27:32 +0100, David Lechner wrote:
> On 9/14/26 8:35 AM, Carlo Caione wrote:
> > From: Julien Masson <jmasson@baylibre.com>
> > 
> > Genio 510 and 700 need a provisioning and recovery path that remains
> > usable when eMMC is blank or its boot firmware is unusable. Add a RAM-
> > based fastboot download agent so boards can be flashed through the
> > MediaTek BootROM download protocol without a working on-device
> > bootloader.
> > 
> > Running the agent in SPL avoids a dependency on BL31 and U-Boot proper
> > during provisioning.
> 
> It would be helpful to have some more explanation here about why the
> different parts of this patch are doing what they are doing.

Yeah, I agree. I'll add the explanation of the why in the commit
message.
 
> > 
> > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > ---
> >  arch/arm/dts/mt8188-genio-da-u-boot.dtsi           | 55 ++++++++++++++++++
> >  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
> >  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
> >  arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 16 ++++++
> >  .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  6 ++
> >  arch/arm/mach-mediatek/Kconfig                     | 26 +++++++++
> >  arch/arm/mach-mediatek/Makefile                    |  1 +
> >  arch/arm/mach-mediatek/spl_fastboot.c              | 65 ++++++++++++++++++++++
> >  board/mediatek/MAINTAINERS                         |  5 ++
> >  common/spl/Kconfig                                 |  2 +-
> >  configs/mt8188-genio-da-spl-fastboot.config        | 15 +++++
> >  configs/mt8188-genio-da.config                     | 19 +++++++
> 
> I think these should use mt8370 prefix like the other common genio 510/700
> stuff. mt8188 is for chromebooks, so I don't think it would make sense to
> use that number with genio-specific configs.

:( yup, makes sense.

> >  configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
> >  configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
> >  14 files changed, 221 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/dts/mt8188-genio-da-u-boot.dtsi b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..e9078f37157
> > --- /dev/null
> > +++ b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +/*
> > + * Copyright (c) 2026 BayLibre, SAS.
> > + * Author: Carlo Caione <ccaione@baylibre.com>
> > + */
> 
> I would add a comment here explaining that da is download agent and why we
> have this special devicetree that is different from the normal one.

I'll add a comment.

> > +
> > +#include "mtk-genio-binman-u-boot.dtsi"
> > +#include "mtk-genio-da-binman-u-boot.dtsi"
> > +
> > +&ssusb0 {
> > +	dr_mode = "peripheral";
> 
> > +	mediatek,force-vbus;
> 
> This is not an upstream DT property.
> 
> It seems like dr_mode = "peripheral" should already imply this anyway. So
> hopefully we can just modify the USB driver and leave this property out.

Good point. I'll make the change to the MTU3 driver.

> > +};
> > +
> > +&ssusb1 {
> > +	status = "disabled";
> > +};
> > +
> > +&ssusb2 {
> > +	status = "disabled";
> > +};
> > +
> > +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
> 
> Why do these matter for fastboot but not the ones above?

Because only the fastboot-in-SPL variant uses USB during SPL execution,
in the fastboot-in-U-Boot-proper case these nodes are already in the
regular U-Boot DT (no need for 'bootph-pre-ram').

> > +&pericfg_ao {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&ssusb0 {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&u3phy0 {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&u2port0 {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&usb_default_pins {
> > +	bootph-pre-ram;
> > +
> > +	pins-iddig {
> > +		bootph-pre-ram;
> > +	};
> > +
> > +	pins-valid {
> > +		bootph-pre-ram;
> > +	};
> > +
> > +	pins-vbus {
> > +		bootph-pre-ram;
> > +	};
> > +};
> > +#endif

[...]
> > --- /dev/null
> > +++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +/*
> > + * Copyright (c) 2026 BayLibre, SAS.
> > + * Author: Carlo Caione <ccaione@baylibre.com>
> > + */
> > +
> > +&binman {
> > +	da: da {
> > +		filename = "da.bin";
> > +		pad-byte = <0>;
> > +
> > +#define MTK_GENIO_SIMPLE_SPL
> 
> Could we pick a name that describe more precicly what this does? SIMPLE
> is vague.

Fair enough.

[...]
> >  obj-$(CONFIG_TARGET_MT7622) += mt7622/
> >  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> > diff --git a/arch/arm/mach-mediatek/spl_fastboot.c b/arch/arm/mach-mediatek/spl_fastboot.c
> > new file mode 100644
> > index 00000000000..0ba76d47dfb
> > --- /dev/null
> > +++ b/arch/arm/mach-mediatek/spl_fastboot.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 BayLibre, SAS.
> 
> 2026

uh, time flies.

> > + * Author: Julien Masson <jmasson@baylibre.com>
> > + */
> > +
> > +#include <dm/uclass.h>
> > +#include <fastboot.h>
> > +#include <mmc.h>
> 
> Suggest also <stdio.h> for printf and <linux/errno.h> for ENODEV.

Ok

> > +
> > +static int mtk_mmc_boot_prepare(void)
> > +{
> > +	struct udevice *dev;
> > +	struct mmc *mmc;
> > +	int ret;
> > +
> > +	ret = uclass_get_device_by_seq(UCLASS_MMC,
> > +				       CONFIG_FASTBOOT_FLASH_MMC_DEV, &dev);
> 
> Should this be find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV))?

No, we need this because we need to actually probe the device.

[...]
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index f9b453df766..77da2f4c8aa 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
> >  config SPL_BINMAN_SYMBOLS
> >  	bool "Declare binman symbols in SPL"
> >  	depends on SPL_FRAMEWORK && BINMAN
> > -	default n if MTK_GENIO_BOOT_IMAGES
> > +	default n if MTK_GENIO_IMAGE_CONTRACT
> 
> Should we do something to make sure we don't select MTK_GENIO_BOOT_IMAGES
> and MTK_BROM_DOWNLOAD_AGENT at the same time?

I'll add a depends on !MTK_GENIO_BOOT_IMAGES

> >  	default y
> >  	help
> >  	  This enables use of symbols in SPL which refer to other entries in
> > diff --git a/configs/mt8188-genio-da-spl-fastboot.config b/configs/mt8188-genio-da-spl-fastboot.config
> > new file mode 100644
> > index 00000000000..01b35f1144e
> > --- /dev/null
> > +++ b/configs/mt8188-genio-da-spl-fastboot.config
> > @@ -0,0 +1,15 @@
> > +#include <configs/mt8188-genio-da.config>
> > +
> > +CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
> > +# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
> > +CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
> > +CONFIG_SPL_MMC_WRITE=y
> > +CONFIG_SPL_PHY=y
> > +CONFIG_SPL_DM_USB_GADGET=y
> > +CONFIG_SPL_USB_GADGET=y
> > +CONFIG_SPL_USB_MTU3=y
> > +CONFIG_SPL_FASTBOOT=y
> > +CONFIG_SPL_FASTBOOT_REBOOT=y
> > +CONFIG_SPL_FASTBOOT_FLASH_MMC=y
> > +CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
> > +CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
> > diff --git a/configs/mt8188-genio-da.config b/configs/mt8188-genio-da.config
> 
> Do these really need to be two separate files? As mentioned above, there
> isn't really such thing as a mt8188-genio seprate from a mt8370-genio-common.
> mt8188.config already contains things that really are genio-specific that
> would be more "correct" to move to a separate file. But that is a bigger
> cleanup that affects all MediaTek Genio boards that we can look at later.

ok, I can slightly make this better by splitting:

- mt8370-genio-da.config: settings shared by both DA variants
- mt8370-genio-da-spl-fastboot.config: SPL fastboot settings
- mt8370-genio-da-uboot-fastboot.config: U-Boot-proper fastboot settings

Thanks!

--
Carlo Caione
