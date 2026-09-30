Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D97CA5FBA
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 11:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B6FB40792;
	Wed, 30 Sep 2026 11:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zk6T6YKRKuIC; Wed, 30 Sep 2026 11:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 89BE840847
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790767292;
	b=q7M+r7Pli2qGgAQvFLbgrls72Q2X6e5odNPhcvHfYNm16zHfC1/e7GszRSJ2rVFEWwfr
	 PwFIWYcbDPZ5haDmb1Dr8dwopfk/z938oPBcPmNNjtY4BfPL+Ot5gsieDW9ijFjDh/nma
	 unZAsIIj4gthwhwkma2sbzNHgL1NO4SRwkqCEqGyOM18B0FcklalEbNogf6cgFsiH7cOM
	 m1PjxOZLczmgOdx/wzn8fP/XxvR0UsY0jvEYTCLo+/I9BQJXi6RuxjyI6S1a7864Dohwo
	 Fmp4a4BAidzKuFCGRLquzKZoUm21hOEZed4xK+Iek+7s8bvxn9Sn9cCCbGYklzdvZ+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790767292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+Bj1BELdHORpbKjFXynB7FNvNX7TxCXGdSnl7BmdPPs=;
	b=oIVfKpzGGpX7JZLV5PqvAj3zar5kSeGDIcObijLVr5us6P5fll4RzBKyOXxY4IgtU/9p
	 C38pmdWpktf3OXljyJ+PomQ2im445w+WZRzbm84XkonENrSlK+a/jzhQtKbmR8Pc4wp+r
	 nxDMGXskq6cqAJgAAmi+lBGJjux78Pt6qfu4lNi92MIDfryQsGuWFyjW5eAB+psVxrA9R
	 TGtOK9su4HVpvVVgA39W10BBDk/gU+sdE7Xj05SDMXkC24+60y3Qs40fSUWVYBk5JJvt1
	 1rdqs965NZBSkncCW24Ir4NutNfeBwtFlUB7hEA+D6kjQYJXEHzlKvRicMql81637PA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790767292;
	bh=+Bj1BELdHORpbKjFXynB7FNvNX7TxCXGdSnl7BmdPPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xNca8CaIcN+MEAperN51cWBMffBM5u0v6dM3rlCJgt6gIJXvejQY58H/VNHdpWU/2
	 AT3HqvyBiUns9+rMp1mvxJ4Hq6MKLEsH+L9ioDDpw5+3M91/MdAqAOz8jTeJAYoSue
	 /2UMxPOYOaEvZaphuLu0gJwwcwgi4Dh2WH+273ocQE6SSN+o+xSIOAP6s/jkWWXOC9
	 3v7rWEfiOANPFcx7d5HD2lCLFLxrF+8I79pptLyMW64dNqmBwTO2BHKNXe+Y0iQIsG
	 hdYHEqtW2+GOQOP9lV4cgCWDnw66uaYyEGbzrzrMgi4IiDCPYbwEV6WWrf5kj6zu+o
	 bjk1Gd15XmuAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89BE840847;
	Wed, 30 Sep 2026 11:21:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 606C424E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 11:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D879607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 11:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuA7tjjCAC9d for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 11:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 340AC60678
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790767290;
 b=EpYd7sz4ocIjnjeOQGQT/ZyzVr/UQFFCj3kze6KTj+a8SkIyMuqP9hQ4iW5tdv1Qzu6v
 tRbottZH4qIQxU11hKEC/myBlp7UYBX1wHNNv3Hp6v2MqLoxjh03Dn1q63Ni0sxNW8+XI
 3+mZVfXaMPnq/HsFOdigadN4THytO1pqtff9ll4mnz9JptIB22pld5L8drAX7HcWgf+ed
 yiCiUfRDOYju0hwGjNf8FUZs62BveomZA8sH1W+OjHg6pHWLCH2USZ8RXqjY3vxM3f6OA
 cfwGfgI3TmA/zhyRFvgXbXDAXBk2dmZ2agI54+e879yX/uqsMPcONahskehQ46Jnx4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790767290;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=+Bj1BELdHORpbKjFXynB7FNvNX7TxCXGdSnl7BmdPPs=;
 b=iIBzxOIzBvIZZVetiG42yR3FpHVbXA4e3UO8aw/z9ofa+F/dshWEOZYRAx6luLBd22OP
 O/FV+MSa8SPsIvKXO0WAGQCPPqyMxq1Tke9IBMue0ozcXmKHhvYE/gjiqklRvcAhyyKu5
 O+KQyjn0y8L+kdrOP/zRrGmu9/lbwJvoSp96yvtN2X7FbN4eL+ebgAMEwScGtOYEGiSUN
 6upJtOlkelTjcZgZZKTrD9Llpgif5EYkZucwsgLnKkn5+m9uX4t7nV3P4J9ndDFd9vNkC
 EcXv9i5dDSa/2iyEvoG86/FaCT1dmT8HECzsuTJrQ2lRRBSMh7uPWiQAlKHObFs4VvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qxiI5zLx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qxiI5zLx
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 340AC60678
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 11:21:29 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so28859235e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790767287; x=1791372087;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+Bj1BELdHORpbKjFXynB7FNvNX7TxCXGdSnl7BmdPPs=;
 b=qxiI5zLxnh42ZY0Mg/w8EEDZtJ1ETV4AHz1a072FL5C/1nvvhg1Kb7awMjMKwebeny
 sWH/zkxtITCMUB4/ZU5l/IAdR4k2Kxcu8tMq8yYNsg++ahTO77s/v1QFGNVXBDd6c7dK
 kZlgEiaLgTtHHWTwz+N4kyXfdfuCCe9NLnJRHD+qQj+3Yjw8heVDfIT4s4MzH1dXbLx0
 EOcfXKCk5mzkb4ekOMslHrbOnio0UGUy4uKOnQ2pYHPTb7raAwMticw0F5Sk4YlF1vW+
 269hqE3Z9VX/XlWRsjdfLQxbniXNdXFrOovURSRchhv/5yy1gaFMIe07oED6vT0N6kWT
 TMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790767287; x=1791372087;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Bj1BELdHORpbKjFXynB7FNvNX7TxCXGdSnl7BmdPPs=;
 b=DVWSA2wFJ4axPWKX6a6pmDgJU9mi14N2MAmH3j4VkOg+oKvlBbS1pf1r/Ba2e688RA
 W11a6iiSSYkNpPNJmQ266QM4JtPCNdsECmLN00X2w1zW14XOgONct0e5QPgkbsteoYII
 QIMme+s0tVcnQcmkPsJ5g8sL/uNrY+zEcE8n4K87vtagzbpMguqojjjGZuSm6QbSMI23
 /2b2pwlhpc+3vpeq2gKKQXGwJHmKy1biZ3IVCfvo1GdrBwG/DXtdNbsSTKLSdG4xf0MN
 EfTvjo43bAn709TfqwNMsNqFjK4cq7h/fmA+RZdFVytZq1Kgt1EkUelbxsaOfXcusyC+
 oikA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydUUGjKd/eaIUCJCvIllOKYGuzsHADTHFdylg56wQuScDFDznMF0UlWQfJO6Rx2jbkapVJivk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kPlHjgkdXSWpXFCvnlZhPruiLHdSPmNVO/Pefo09BQqU/0g2fe
 F4gyWgRGIrKNjdrf4CVXobZPt+dhFZb9YqfJWRj3+jGdyjlKcwkmWbgvXj8jbFrRv0Q=
X-Gm-Gg: AYBFou3btWyWvi2mfp2jTstp3cz4iq6Boi23Qqm3HlIzKChxW0SpjaPGoTzS5Zq3ZkK
 sMW/hMcHBDFBSe6FBcdguC4VXtTlny6IyglzInpMVdDD4em6eLJH+EIvo5LI4DoZvpOHBETvxbi
 xoLVR9/90IEAJ7WU9kf+LQFeXiJCuU99k/meaO8Kg6oC6Jrk+rp9YW3k01qY4DdY16LKiP8e5eF
 RjxswpsgpdT1r8cLJMBuHIcLj/XqZ3yvU4jh4+J9saBv5IOE8kMfwl5cuKvvajB+EMGHl3Hnft9
 dGsLxr0Znjjk7q66pzPRaI2CI/PUCDe6UKuxTpPfnlaOGrXotU3kchW4AmZQXQ/hVgXiq8F0KIi
 cdUrvGp8Q1D7J1MOv/x+dR5JT40ghVVwOpGhkbxdsV+lNmFpBbVhpZMD8tn2zGVKuYpSyWI53EC
 8uAGEmnvxf2T06+SwTI15TyEX9kHgkWH14WVTreDZ3W3TpRPyzg5EL0ibntEApw2xu4nxhshHJ/
 UUJ+CwKQyxA5JbqgYf322E=
X-Received: by 2002:a05:600c:1c08:b0:4a0:321:6ddd with SMTP id
 5b1f17b1804b1-4a01b138d8fmr20663035e9.34.1790767287146; 
 Wed, 30 Sep 2026 04:21:27 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174d5191sm50146175e9.3.2026.09.30.04.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 04:21:26 -0700 (PDT)
Message-ID: <9d0c4eb2-3ddd-4d8d-8574-69629bf69b10@linaro.org>
Date: Wed, 30 Sep 2026 13:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Balaji,

Apologies this patch slipped through my inbox.

On 7/24/26 12:18, Balaji Selvanathan wrote:
> Read the USB-C cable orientation from the orientation-gpios
> property on the qcom,pmic-glink node and use it when programming
> the TypeC port-select mux.
> 
> Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> 
> Previously the driver always set SW_PORTSELECT_MUX without
> accounting for cable orientation, so the SuperSpeed/DP lanes could
> be routed to the wrong side of the connector on boards where the
> cable was flipped. Now orientation is read once during DT parsing
> and SW_PORTSELECT_VAL is added to the mux value when a reversed
> orientation is detected.

You should read this when the phy is enabled so I can like... plug in a 
cable after getting to u-boot without it randomly breaking.

please also rewrite this commit message, explain it rather than 
summarising the patch.

Thanks,
// Casey

> 
> Tested on QCS6490 RB3 Gen2 board.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-combo.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> index 0d63e482ee4..615d481513f 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> @@ -7,10 +7,12 @@
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> +#include <dm/ofnode.h>
>   #include <generic-phy.h>
>   #include <reset.h>
>   #include <power/regulator.h>
>   #include <asm/io.h>
> +#include <asm-generic/gpio.h>
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
>   #include <linux/delay.h>
> @@ -39,6 +41,7 @@
>   #define DP_MODE                                 BIT(1) /* enables DP mode */
>   
>   /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
> +#define SW_PORTSELECT_VAL                       BIT(0)
>   #define SW_PORTSELECT_MUX                       BIT(1)
>   
>   /* PHY slot identifiers for device tree phandle arguments */
> @@ -238,6 +241,7 @@ struct qmp_combo {
>   	struct udevice **vregs;
>   	int num_vregs;
>   	const struct qmp_phy_cfg *cfg;
> +	bool orientation_reversed;
>   };
>   
>   static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> @@ -333,6 +337,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>   		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>   
>   	val = SW_PORTSELECT_MUX;
> +	if (qmp->orientation_reversed)
> +		val |= SW_PORTSELECT_VAL;
>   	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
>   
>   	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> @@ -521,6 +527,33 @@ static int qmp_combo_vreg_init(struct qmp_combo *qmp)
>   	return 0;
>   }
>   
> +/*
> + * The orientation of the USB-C connector on this platform is reported by a
> + * single GPIO exposed on the "qcom,pmic-glink" node ("orientation-gpios").
> + * Read it once here so the port-select mux can be programmed to
> + * match physical cable orientation.
> + */
> +static bool qmp_combo_read_orientation(void)
> +{
> +	ofnode node;
> +	struct gpio_desc desc;
> +	int ret, val;
> +
> +	node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
> +	if (!ofnode_valid(node))
> +		return false;
> +
> +	ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
> +					 &desc, GPIOD_IS_IN);
> +	if (ret)
> +		return false;
> +
> +	val = dm_gpio_get_value(&desc);
> +	dm_gpio_free(desc.dev, &desc);
> +
> +	return val > 0;
> +}
> +
>   static int qmp_combo_parse_dt(struct qmp_combo *qmp)
>   {
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -536,6 +569,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> +	qmp->orientation_reversed = qmp_combo_read_orientation();
> +
>   	qmp->com = base + offs->com;
>   	qmp->serdes = base + offs->usb3_serdes;
>   	qmp->tx = base + offs->txa;
> 
> ---
> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
> change-id: 20260724-kodiak_ss_orientation-b171351c78b7
> 
> Best regards,

