Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F849C98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D20BD8087C;
	Tue, 22 Sep 2026 16:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIadSyvpzh4e; Tue, 22 Sep 2026 16:27:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 760F98075A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094459;
	b=mhD2kVLJPB68WfwK8sVpKNoWhRvQgkzX0w20Gvz+yK7un2Cdl5FpcVLFNUmyE42YtedH
	 m9weygObs7OaAUgJrD1p9s6D+8NKYWDblJtLeUAWpKYLCcvzuBTOMNDzPqEpUPqOwEKVQ
	 hbMjzbJlJvqAN/lfHEz8rmyjv74INdziPccGd1ARABPZko9jKYyxA4qS5ixdE1ZxBeTnI
	 4j5jZK4QJeuaLVzrr9KpY6VMWI5M8scdYneTJiAui7ATWyYWkrH0PSatiOMKWuF/0zism
	 3hMyuWzupKCeWx1jDecaRZPVxgYWtk6vy2h30tC6RXoHIteHgAat+HB1qzcOQScAKVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790094459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nw+XKszgQCUcFxupU8HZWMNlMBll/3U3SFTnNkcYV0s=;
	b=MjTnh7Ialw8dQt5emUTJbxJA5DJfhpLvGTQKhs96xyRCxOiva5AS+f8ybwYoBn+wgoJg
	 GWJ43qLwv4xKt+/u7fkvUDqslDvQwzcb8r5ygCeHZdDuyQiYE9yrWidN/hRxoW6Xd8C92
	 dFfgX5geWuIJ6LuTEdgY94CtSQXM5mJ7L2AfuQldYFkCcGWvYWF4eVHfVNWevdzDUEBjL
	 9tUp7W1CaTV2Qj/SGW+v5wODUa4h2nRcbixHNv+8wNEinfCax921FHdBN2MkBw3aKrm6v
	 bf+3RG9uTltain0KX9HTYSam6R4UDL7n07EmqarAEDFBgH/jTDDqW6j5DZk2m2oBrFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790094459;
	bh=nw+XKszgQCUcFxupU8HZWMNlMBll/3U3SFTnNkcYV0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N3rtrnGMf6ys9jONxSnLA/cvAJ+6dYsutzwotfplUG0qcH8uurpgLJKxIiUAAUlt+
	 s4AaP16pbbAu4XPVRuBUJUKIjjoCKTGM+kotiBiJ/7UgRc1aEd6/aw5EiPvX2Jj1si
	 l7D85PvOEjZeQ0HsjCghKfc9FtTzFtISpMFgkzw0uKOIjZJH9sDwBMiJVRW9X3JHNu
	 ELGVxa/aGvYY1GxG0ntk432LGJgER/aEkbuWY9kyQjF2alpn4uTg+Ad8sCQxSwc30O
	 jvfvGK9wPvfGoyBDidFHEMSHABiDiIs3Sli4FwVJVOEiMj9aOSrzUagqvy6hLMCuv9
	 8SJcv73gYHGfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 760F98075A;
	Tue, 22 Sep 2026 16:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 065763A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB04B402A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id do5kL1PEgjTq for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:27:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 434D34007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790094457;
 b=CyvhYwhupaJKR4sLClCMrV+kTq6L2yz7l6iojN62ccdLkmmkiS08zt4X4csK9GEncoje
 e710lNsRXRHdXiuL1Xj0kxJFkdJznymYXnSwPZhQ/DwhiC9LaRZry8l9eg9YS/BGoUrx2
 RggWrdd1nQs4kuThHCvCqi7E1uvPwJZJgTxu//c8FItWwTr18aiyTyO598HSN8B+S2mip
 9v2A5G80KOY+3yO/R6hdGj5/T+lAc6kmER1WgCnyrLcM2jza7ep3lp6N4HskUiJdzyqz/
 /6jT8y2WtKZG5gi/CzX2sGhChfu3mdC4e4qy/fJ33PgbcDdancvn5Ho2lLc7OVJaQ9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=nw+XKszgQCUcFxupU8HZWMNlMBll/3U3SFTnNkcYV0s=;
 b=ZoRTvHCyRxXC4PJtLdJuX+jVnSXB9kONVGOOGfromU88qE0fsg2mQ2hH2wQhs1uFhlSK
 Loi7ov2gYPAdeSxLHLzGbzIDfCzo4fqbfqym4HMgWX4PPoR0v5H89tjhR2ERZXJ8SpPAz
 eaGbOuR5Ipbc+r502t0adfVZHtb8SdT/4Y/abIPAhXtqLrAs7PNgYQfpgHrA2HL4uokwb
 k+FGx0Rr5s7+irXMOHx4b5hxdJsjV9KPGZN5PpCSvwPYia4um4mN465Ft95IwQyPl3yJM
 wulsjWplJve6Hy53kTplcuHzxZG2Qt8FmWkPA4NXejRQiTBIEj/AB7Dz9Pt7ItKQOPQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=P0buqRnC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=P0buqRnC
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 434D34007D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:35 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae721872so10004eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790094454; x=1790699254;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nw+XKszgQCUcFxupU8HZWMNlMBll/3U3SFTnNkcYV0s=;
 b=P0buqRnCs6yGgWPTim2SOauGqOiqyKFzJ/xQ+vyQYh9Ec7TV/2Csp3+AaPQkiphCAy
 bQ/L/vNllat5yevjd8lQotYj20vuqnntTokBBU7b7rTYeCHbf2T4AGkccxZSRBAoY8Py
 URhzFGw2lsTcPgZnQSRREM0aRsguFby5piENVsPn4PTbW0d1wrRcOSWTvb1+Yp46g7dP
 CQU3D2hkJYwHyH0W0E7jTi81eey1hPNo6/9DMbKEuEy/lSnSxDiZgFV1UKO59ZWeMvC6
 VkC+MAU3boX+2v3ewpQNu4DdgfPrz6IiKMOZZ1+RBWr9c/9KHJDapOfcjn88jFu5m7Y8
 NsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790094454; x=1790699254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nw+XKszgQCUcFxupU8HZWMNlMBll/3U3SFTnNkcYV0s=;
 b=R396rj5MdyUMeR/IMUWEyRAXycKeLcShsPnC8yo9foZHHszrbM6fLMuTTvxGI4I6w0
 9g0EKn9cdZm6HaFl7pZKHVDdu1aGbS/FJCieyn9s6CgsA0xSLsmB9F3uEAMgu4J9nrfI
 jtqE4ePSMZmOsKIISJujMoMHCQC2SfqE3PdWzcw+LLJlTtnhckb20q5KLfi97miU4HW9
 2JScuScwqVFNWZk6Y1YsKqkLCgJ2trvekii/D7y0E22Gl5vXYjJcIUo+1s8XFgqo/2zp
 kCg4yhpewYnHWRfJD2WAYUEN9dboJ8/kfHWqwL6x3wi8reYWj6TGZtCnL5Wce3r+hbS5
 7n8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCq6wQ/5+wY4BHbuS7tdo6+wcZWZ1muPfPq+fNqY/wEUXSp7CEaRS6IWLJ5P9szX2kf97B76o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++miIUGz1l66tStr4ROJVqq4eKZeSKE36nkwv8/KiQrVp9O5guiB
 jDleY51uZaSgnc5TkCVip2XGBMRWhUHo4wwcELr5gTP77EMVmEAw8vtMicn/PWZx8z8=
X-Gm-Gg: AYBFou25lZ8RRW55fefsW9ChKSdpPZ5iZXYVfLLq+G35YzZqMHtetDu69UDIaMn2eqZ
 BD8Gaez3YhJwzNjPWy5CeOHZg2MwFYf8m3B+L66ncUskCuoNpRAeMzKRuSNtk4OPDQUiK6M4LKw
 fsSrZw7FWlB5ChQ6t7cNkhlvNPgl+ATPZH5avTKYbioU9tkmox5aGV1wVO94ZD3FSn8CzRlwNp6
 6Gsv+aOwlRBFntj1u6317GQd7fwfxs2qho1I16WiliwmFJATTtN0nnY6ivICcy3IPter7krDami
 W1umvTFiKxmoyx5YM/HaJ9WxjG6QHQEYgMFSmVf1+p7yaEd+No/z3xSQ3wah+l1WLe1l5sje9ZZ
 3ZR6kArW8z3T0VXH/g16b/1Iq0T5cIsrWPx8PDownvPCv4o4mD/qLDQRvEl8/WcSxsuyu+WXDV4
 gTkYTjY6GPsFXahZy5/SkiBF3r//oYsCwLUl0o9+DMXHQWknlpA8hAYqjf8K7q0VBXaaOfW9kBU
 RzLHvr+yHCBFnj5r0cgmRP60uMe6dfG5m1HxpK+lkZwcRk7
X-Received: by 2002:a05:6820:88b:b0:6cd:3fbd:1d5e with SMTP id
 006d021491bc7-6cd3fbd29b6mr10578742eaf.72.1790094454401; 
 Tue, 22 Sep 2026 09:27:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e?
 ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d1de9e140csm1817821eaf.10.2026.09.22.09.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 09:27:33 -0700 (PDT)
Message-ID: <81b22e9a-5522-42e8-b9f8-a8cd509f23bc@baylibre.com>
Date: Tue, 22 Sep 2026 11:27:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
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
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-1-b76f9e30ac38@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-mt8390-da-v1-1-b76f9e30ac38@baylibre.com>
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

On 9/14/26 8:35 AM, Carlo Caione wrote:
> From: Julien Masson <jmasson@baylibre.com>
> 
> Genio 510 and 700 need a provisioning and recovery path that remains
> usable when eMMC is blank or its boot firmware is unusable. Add a RAM-
> based fastboot download agent so boards can be flashed through the
> MediaTek BootROM download protocol without a working on-device
> bootloader.
> 
> Running the agent in SPL avoids a dependency on BL31 and U-Boot proper
> during provisioning.

It would be helpful to have some more explanation here about why the
different parts of this patch are doing what they are doing.

> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8188-genio-da-u-boot.dtsi           | 55 ++++++++++++++++++
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
>  arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 16 ++++++
>  .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  6 ++
>  arch/arm/mach-mediatek/Kconfig                     | 26 +++++++++
>  arch/arm/mach-mediatek/Makefile                    |  1 +
>  arch/arm/mach-mediatek/spl_fastboot.c              | 65 ++++++++++++++++++++++
>  board/mediatek/MAINTAINERS                         |  5 ++
>  common/spl/Kconfig                                 |  2 +-
>  configs/mt8188-genio-da-spl-fastboot.config        | 15 +++++
>  configs/mt8188-genio-da.config                     | 19 +++++++

I think these should use mt8370 prefix like the other common genio 510/700
stuff. mt8188 is for chromebooks, so I don't think it would make sense to
use that number with genio-specific configs.

>  configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
>  configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
>  14 files changed, 221 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/mt8188-genio-da-u-boot.dtsi b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
> new file mode 100644
> index 00000000000..e9078f37157
> --- /dev/null
> +++ b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */

I would add a comment here explaining that da is download agent and why we
have this special devicetree that is different from the normal one.

> +
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-da-binman-u-boot.dtsi"
> +
> +&ssusb0 {
> +	dr_mode = "peripheral";

> +	mediatek,force-vbus;

This is not an upstream DT property.

It seems like dr_mode = "peripheral" should already imply this anyway. So
hopefully we can just modify the USB driver and leave this property out.

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
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT

Why do these matter for fastboot but not the ones above?

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
> diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> index 10b9a142f37..608987ca6d7 100644
> --- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> @@ -14,3 +14,7 @@
>  #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
>  #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
>  #endif
> +
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
> +#include "mt8188-genio-da-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> index 6230b016ca0..6c6c85e8767 100644
> --- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -14,3 +14,7 @@
>  #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
>  #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
>  #endif
> +
> +#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
> +#include "mt8188-genio-da-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..ad337bf1784
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> @@ -0,0 +1,16 @@
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
> +#define MTK_GENIO_SIMPLE_SPL

Could we pick a name that describe more precicly what this does? SIMPLE
is vague.

> +#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
> +#undef MTK_GENIO_SIMPLE_SPL
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> index 2dd13d261a0..503ae06da34 100644
> --- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> +++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> @@ -12,6 +12,11 @@ ddr-loader {
>  	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
>  };
>  
> +#ifdef MTK_GENIO_SIMPLE_SPL
> +u-boot-spl {
> +	size = <CONFIG_SPL_MAX_SIZE>;
> +};
> +#else
>  #ifdef CONFIG_SPL_FIT_SIGNATURE
>  u-boot-spl {
>  	type = "section";
> @@ -31,3 +36,4 @@ u-boot-spl {
>  	size = <CONFIG_SPL_MAX_SIZE>;
>  };
>  #endif
> +#endif
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index e572cfe8571..59489c0fe65 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -249,6 +249,32 @@ config MTK_GENIO_BL31_LOAD_ADDR
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
> +	help
> +	  Select where to run fastboot after the BootROM downloads the agent
> +	  into RAM. Leave this disabled for normal storage boot.
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
> index 35f748a70d6..42b83b82f77 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
>  obj-y	+= cpu.o
>  obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
> +obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
>  
>  obj-$(CONFIG_TARGET_MT7622) += mt7622/
>  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> diff --git a/arch/arm/mach-mediatek/spl_fastboot.c b/arch/arm/mach-mediatek/spl_fastboot.c
> new file mode 100644
> index 00000000000..0ba76d47dfb
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/spl_fastboot.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 BayLibre, SAS.

2026

> + * Author: Julien Masson <jmasson@baylibre.com>
> + */
> +
> +#include <dm/uclass.h>
> +#include <fastboot.h>
> +#include <mmc.h>

Suggest also <stdio.h> for printf and <linux/errno.h> for ENODEV.

> +
> +static int mtk_mmc_boot_prepare(void)
> +{
> +	struct udevice *dev;
> +	struct mmc *mmc;
> +	int ret;
> +
> +	ret = uclass_get_device_by_seq(UCLASS_MMC,
> +				       CONFIG_FASTBOOT_FLASH_MMC_DEV, &dev);

Should this be find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV))?

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
> +	ret = fastboot_usb_run(CONFIG_FASTBOOT_USB_DEV, NULL, 0);
> +	if (ret)
> +		printf("Fastboot failed: %d\n", ret);
> +}
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 5b0d79320bd..27aeb4dff07 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -21,14 +21,19 @@ MT8188/MT8370/MT8390
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  M:	Julien Stephan <jstephan@baylibre.com>
>  S:	Maintained
> +F:	arch/arm/dts/mt8188-genio-da-u-boot.dtsi
>  F:	arch/arm/dts/mt8188-u-boot.dtsi
>  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
>  F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
>  F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
> +F:	configs/mt8188-genio-da-spl-fastboot.config
> +F:	configs/mt8188-genio-da.config
>  F:	configs/mt8188.config
> +F:	configs/mt8370_genio_510_evk_da_spl_defconfig
>  F:	configs/mt8370_genio_510_evk_defconfig
> +F:	configs/mt8390_genio_700_evk_da_spl_defconfig
>  F:	configs/mt8390_genio_700_evk_defconfig
>  F:	doc/board/mediatek/mt8188-genio-evk.rst
>  
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index f9b453df766..77da2f4c8aa 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
>  config SPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in SPL"
>  	depends on SPL_FRAMEWORK && BINMAN
> -	default n if MTK_GENIO_BOOT_IMAGES
> +	default n if MTK_GENIO_IMAGE_CONTRACT

Should we do something to make sure we don't select MTK_GENIO_BOOT_IMAGES
and MTK_BROM_DOWNLOAD_AGENT at the same time?

>  	default y
>  	help
>  	  This enables use of symbols in SPL which refer to other entries in
> diff --git a/configs/mt8188-genio-da-spl-fastboot.config b/configs/mt8188-genio-da-spl-fastboot.config
> new file mode 100644
> index 00000000000..01b35f1144e
> --- /dev/null
> +++ b/configs/mt8188-genio-da-spl-fastboot.config
> @@ -0,0 +1,15 @@
> +#include <configs/mt8188-genio-da.config>
> +
> +CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
> +# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_PHY=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_USB_MTU3=y
> +CONFIG_SPL_FASTBOOT=y
> +CONFIG_SPL_FASTBOOT_REBOOT=y
> +CONFIG_SPL_FASTBOOT_FLASH_MMC=y
> +CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
> diff --git a/configs/mt8188-genio-da.config b/configs/mt8188-genio-da.config

Do these really need to be two separate files? As mentioned above, there
isn't really such thing as a mt8188-genio seprate from a mt8370-genio-common.
mt8188.config already contains things that really are genio-specific that
would be more "correct" to move to a separate file. But that is a bigger
cleanup that affects all MediaTek Genio boards that we can look at later.

> new file mode 100644
> index 00000000000..d47bce044a7
> --- /dev/null
> +++ b/configs/mt8188-genio-da.config
> @@ -0,0 +1,19 @@
> +CONFIG_SYS_MALLOC_LEN=0x9000000
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_PHY=y
> +CONFIG_PHY_MTK_TPHY=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_MTU3=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
> +CONFIG_CMD_FASTBOOT=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x65000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x15000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
> diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
> new file mode 100644
> index 00000000000..42ca29dfe1c
> --- /dev/null
> +++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
> @@ -0,0 +1,2 @@
> +#include <configs/mt8370_genio_510_evk_defconfig>
> +#include <configs/mt8188-genio-da-spl-fastboot.config>
> diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
> new file mode 100644
> index 00000000000..ca58b131ed6
> --- /dev/null
> +++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
> @@ -0,0 +1,2 @@
> +#include <configs/mt8390_genio_700_evk_defconfig>
> +#include <configs/mt8188-genio-da-spl-fastboot.config>
> 

