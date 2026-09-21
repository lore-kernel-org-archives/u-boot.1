Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F42C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B69CB40A49;
	Mon, 21 Sep 2026 20:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sVWjUDsqWRJF; Mon, 21 Sep 2026 20:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0601040A20
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790024219;
	b=FekHI4kLrZVBR6L72zYTTc6+vHO07+YiuyRgNVZxBXyMEBvp4r058Bp2V+N8EaxC4fbl
	 Lf9UXXQasyknlvVk3EQjgCQGv0ySQj88XJVbiYPl3f6YvGsQviUmOqT9IDXILKQVwGnUq
	 i2VXLB672O7fBRomf1XExP+CCY90lnHQrXBrzXuXaDf5mHXA79Ce1bE4XwytYe13RYNbX
	 5URaCwXBlAT14EI0hPhHE7OkXRxswolnoAOpgDCw7WkorGxAGYc5LCO7AjXuhVLvBDdO1
	 Jmp+ARAdm+arPGwU4mSRqKN9ZReOF7CFAaMThdbnCmGQwcjKnqhMlnS2G+WDH2EboVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790024219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iYxjdYzN97tSPT++7wq3Y4UlHH/SSUJtgrJivN6o+I0=;
	b=m7j7BZITaEdRSe5JMqQCQE+R9Xp0gmPeLvqEY9avOJm0Yo4qhZx6zjULaoiiwIBqQLro
	 xt7LYC/BmT0hlQv5ZBmvGleeWYnf6I6ZmHsPhdvRXoQHvZVLIFGzRie8sCbq6W1UthwZI
	 3DzPnFv5DfUfjsnGOB63DjLigfs601pnop7xFr8hzbQSW7ymaen9jwdtkZwb6dMRe85Us
	 33QalUzXOHTtkrvzwbN87pDkT7QLPVkoRmlwWya56YqFs/DSK0sDiUEiiRGEXJ5gKAKK5
	 fMqJwc3TthHZZ7JdF0/7yeGai0WIeN4BRt+GpT4ImoVae4cB/eiu8VfvT1Hin8sIcnw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790024219;
	bh=iYxjdYzN97tSPT++7wq3Y4UlHH/SSUJtgrJivN6o+I0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AkJ4TOeCxO/obc4IhT4hzq7k7+2a7FmrF3azdC9qdYu2Exou2FeEcmbNug3q+dorP
	 /qcdapcbz/HYyXTymQwJsCh1V0OzWWyLebC6vW78aKR9h9sqq5JF92hp+NwtspWuXz
	 2ThXhk7d3PfV3yPvF83bNfrvUGVUQAYgIy2Ckp60fGjAr1I3kFs73O/oZRolewz8yF
	 x5qOCe4VR5Nf4489YB4BjgqVET/T/4qo8alzuePvYT5zuY+B61jdH4QZaGqEak0t97
	 Prh0NiVzeuNH47ihnlFL3/FvrqFNwz1TbqnbXk/puwXjMf9Q4IydJktOSLFMa/7rOI
	 CZZ06ZbDQc+DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0601040A20;
	Mon, 21 Sep 2026 20:56:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D9C9224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73D194006B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V84WBn-fZAi7 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3F6E84005C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790024217;
 b=Iwzib6mGEC1RIWCbLQDYmBjO/IP0uAssoukxfF4mUYZcCwojreC5g7xaGRiqhOIqssSG
 0kONwCeL6NdXYkepBaE5jtbcO9dzCEc/vERD+ebX6xpy43kXNBzES7GSarsWb+mXBLL+R
 XfOu2b5JbiUB7rC5B+zPK8F1Bnr+Q6x9HPF5Xl91Z6dL18oEIfm9LOl12wZLNxYneDFOJ
 WZpvytFYGgVyLwrWyR8CwzLgrS7iejC7KKVTivEYKCa5WZXye9t0E5dP0D8MzTEkZBusg
 sK4XXRruLf+oxigS/UjAak0Am3cgN4TquA8ssuCN36w0NgWaO4skZqJDud52YQz2tGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790024217;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=iYxjdYzN97tSPT++7wq3Y4UlHH/SSUJtgrJivN6o+I0=;
 b=nggOHco+FlcBQ5oAIKr2qNg4iHF7RznOH8pr7GvhLG4EHz/ksgeNwDgxGYPZZhIOHntS
 G41tYDEwwEjKETflJYFDm+4tu0baQPce/7c0Hd3Ej+E9oq+ust418UK69TC3XsqeieiWg
 JAgbbYIZfmhaQKuLoPUOBurtpGFtaXeMxcDFEXTQ6W3Om6tWFidyHMJfHLB/a6O+leuam
 Dot/JlrFL9Ph3nqRinbYEH5n4fb6E2xzzhaMoKkhq0mg9/ADysCmVgtAqrZCzPYUq1ie6
 iL3nlYaSPzr6+xxa9lfda+ggIgig6T1zIEIv4IgfLxrPP/WsHb9cQchHdJUguDdr+Uw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=J+haT0Js; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::27; helo=mail-oi2-x27.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J+haT0Js
Received: from mail-oi2-x27.google.com (mail-oi2-x27.google.com
 [IPv6:2607:f8b0:4864:32::27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F6E84005C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:56:54 +0000 (UTC)
Received: by mail-oi2-x27.google.com with SMTP id
 46e09a7af769-8055dcba0a5so550380a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790024212; x=1790629012;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iYxjdYzN97tSPT++7wq3Y4UlHH/SSUJtgrJivN6o+I0=;
 b=J+haT0JsATC9EzqGnS2OWwcEkjazI3FZyKowX4cRblsnLPf/oB0pX5/WIlw32HD/8D
 N1MgXqC2Ml4OhALoL3u4kQU3f7oK06SeLbNtrrDcZJpMtraqJHC1WG9DK/YcCTXjN55T
 ywnT68Xxri9CIODxBEDOcrcDva2McowjwyDKyDmewVGURc9K6b3pznCgl8njd1/P4p02
 E10A2ObPlfsbvDwZhSK3Y1qgR0PIrdbqoKra7VqvBfMAwY717Kpwgm216ygbjQMqMLT7
 oGHEqQbmomefRbZKGx7o2ZoA0UqQ0HOIu4rRz8I4IaiHTWZihKO6I7qAXx7FanDlpzPQ
 KPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790024212; x=1790629012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iYxjdYzN97tSPT++7wq3Y4UlHH/SSUJtgrJivN6o+I0=;
 b=bIe0Nd+dl7u1PFoqDORVDmSQCIbGBNZN11yUm1eUa9I2RDDkifZiKZUwx5z1vy3T/y
 7feuZBb2BowZEd+Ig285+d1ZNaLwtcuxfQ+8eBnrC2b4+T5IHpxPzbXfnOMOmWcpmCih
 Xr4jV2mImDmb5Co0P3x5Y71Qe1lqO2EEaQP7GQiHYXE/6qa3MKon+n9YTxcFBqGs4pSO
 KfBq1VFFyqupuuo4cMnqiuiYxXoVui3sHmS3cygypXSh0p7YinD6CDfTfePmV1y5ZJqj
 7eGSsVENbd9Jlr8hhR660Jh0ihPP3tEqn5jWeXFaP0+7tj8sfXxOaoZeMBSp2ssIIMpR
 uLmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByYjYo1geXNG+xF/sFh+mMIXY+f4U+dKFZEAAhvEb8nfeERlrt8YoC+foEjbzIAjxyQg3zSxuc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ktZroVEN0r4VvUd10Fmx/bskqhZSWND62/jb0H0lk6YDhqyjuy
 CPgNKi/sMMp9gHxViBArgfPB/2ENoZu4fTCU2oT3v1Aaik15v7xDgvAdCo7S5E8CShM=
X-Gm-Gg: AYBFou2gQyP63GPnkXQcyRN/RouQWNVccvsECjc+uspH8iY1fKafY3KRu4Pjl+odkNn
 boHrCo2nW6cHH4Wxkf3eVu6PmCjM+4ASgPY47i8zoVPFNB5CQyRXyB0CRqx2a/0eIv6601ohvQD
 Lsmn0+PH8cakq/embpelfvD2UaFFhC8Lx8W0zh6nprjn8Dy8DIfjWZ3/2/dOov1rL8kVi2Xz9HV
 7SMPaS0/sPNJIWbv3Mx+dbGzWupUjVppifYGUNNn7Yz46/RyscYa06yrhtQzxT/xDswXNf7Z+Jx
 RBvZh0L4y/keBrWZfstsHM+pYpCKqVOnHpAfKfnwHBkWuKcUjGZdI/VI3jU0ZpTM/sQ6pvxx0tn
 bPpe8j035lbdfqvYrVL60Kfxz1AW3hd6/HUvE5436NEhj5r9Rt3WchkmlI0KZCqy50JUDl4m4WP
 WfQOM5nHGZ5FxJekzJNOxXQWYYSbu0GREeKT4XSM4985/LYPnfUp6irjw2KWKRUw1cmFHP8uLB6
 fOaOsd0jLlnp36krsRHTwTFdlgO2T/64qgqZEgaDeL02ZqG
X-Received: by 2002:a05:6830:398c:b0:806:24fd:7c10 with SMTP id
 46e09a7af769-81488121daemr878082a34.7.1790024211661; 
 Mon, 21 Sep 2026 13:56:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:48dc:2ff3:bb18:4337?
 ([2600:8803:e7e4:500:48dc:2ff3:bb18:4337])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-814d0d6dc44sm41932a34.6.2026.09.21.13.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 13:56:48 -0700 (PDT)
Message-ID: <21521a50-f712-4475-8bcb-86a945af40bf@baylibre.com>
Date: Mon, 21 Sep 2026 15:56:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: dts: mediatek: mt8189: add the power controller
To: Julien Stephan <jstephan@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Macpaul Lin
 <Macpaul.Lin@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
 <20260904-mtk-power-domain-mt8189-v1-5-ab9d8cd0f01a@baylibre.com>
 <178956836274.657813.2632019744153964279.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <178956836274.657813.2632019744153964279.b4-review@b4>
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

On 9/16/26 9:19 AM, Julien Stephan wrote:
> On Fri, 04 Sep 2026 09:46:32 -0500, David Lechner <dlechner@baylibre.com> wrote:
>> diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
>> index c965b00bb5c..f3a350c51b8 100644
>> --- a/arch/arm/dts/mt8189.dtsi
>> +++ b/arch/arm/dts/mt8189.dtsi
>> @@ -144,6 +145,45 @@
>> [ ... skip 14 lines ... ]
>> +				power-domain@MT8189_POWER_DOMAIN_MM_INFRA {
>> +					reg = <MT8189_POWER_DOMAIN_MM_INFRA>;
>> +					clocks = <&topckgen_clk CLK_TOP_MMINFRA_SEL>,
>> +						 <&mminfra_config_clk CLK_MMINFRA_SMI>;
>> +					clock-names = "mminfra", "ss-mminfra";
>> +					mediatek,infracfg = <&infracfg_ao>;
> 
> Hello David,
> 
> mediatek,infracfg is marked as deprecated in bindings/power/mediatek,power-controller.yaml
> so It will probably not be accepted upstream, it should be replaced with
> access-controllers.
> 
> IMHO the current driver does not support access-controllers, so we
> should add support for it.


Thanks for the heads up. It looks like upstream hasn't actually made the
conversion yet though. We'll wait and see what actually lands upstream for
mt8189.

> 
>> @@ -344,13 +387,18 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		infracfg_ao: syscon@10001000 {
>> +			compatible = "mediatek,mt8189-infra-ao", "syscon";
> 
> not used in the codebase right now, but I think it should be
> mediatek,mt8189-infracfg-ao to stay consistent with other platform
> 

I went ahead and merged this series so that we don't block other power
domain work, but will keep this in mind for the next series.
