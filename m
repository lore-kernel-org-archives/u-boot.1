Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA0C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 19:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A40581F86;
	Wed, 23 Sep 2026 19:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5R0UmxQlG4m; Wed, 23 Sep 2026 19:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72A5781EA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790192544;
	b=OGH+WUuzf/AAuDJEfkQnuzMyP+QpBhAvNe1l+x5sxPNsFzmv8RtOAbX7H8ko691JX0Gt
	 Aa1uYfaVNvTeCAA+W7y32CXcUZ/naj7BfKayS0f/s8A2NriC8OHWaAihGot8MqCh7Ongi
	 rS1pZbWPKdwXmuU9GGATIyGD2gHbt54JeRMed/ktaXfkxBLbeMAcWu/XKX0qxsSnFMAGo
	 AX52JCLbzx0ZNW5tLgLy+DuDHyk6kONRwJppFCoqG/fF24eJgNv6dWkYVwjOheiCjtrii
	 Q5adWu8SgRdlX8Ta5kPMOU7gqJfyMiN3CzaRuzHlmNFPIa7B0NRrCEcyrCKCv8Yx4cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790192544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LsB5PaKudZ/K/i+SoY5llCk1UWfpycKe7xtWM8VujlA=;
	b=i/nKeypQHshoeApEGxoYLrAQsMuBk4JppZlIDz9gfh6qNp4UnUr07AevnXw6wQ7nCif3
	 fJz3WLxIxVKvVAD1ljN1gY3k2Mqd4EGtt2OwYY0IhyyL6KQ2HtMkHFoghd/FxMj5iIATR
	 ViOOh5DPWY4rfUbNMXbddJlLu9LTEafhiAtG9DcFEzErSVtg4a8U/KLZFZ6eZxhr9Djwm
	 Mq9TUhg4aW50v1NPR178/OfJ1MSg3jA6su+Iv/t1FUlKzgIyrG6KbEW//7mkGOj2UymN7
	 NqDOAkcWyur4vpoCQQf+XJzkJkq2tuoBZEZKqIjUEYfwNMDzSvaxYaFRhbNor3S4H1A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jTgNGJTu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790192544;
	bh=LsB5PaKudZ/K/i+SoY5llCk1UWfpycKe7xtWM8VujlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hJhVvrdLX7EMWEj/oz4Y5wLCBArmcMH28ImnJOv4KZFcLTcGpyOBRKSRTGdJGLLDx
	 jPGmOcpQWKeadoRFrIcRKhQQEvTdwNcdaTXZ8RUB5zsl7KK3Ozfs3IQ6rIxdF98gbu
	 ppM2UnPRxeioJMonpfwDMWBZiAq2QcfLl/6qqBCtdlPJRipwQt/1azs/ZDvk9YRhWs
	 xd9TkqQe/yNpxlVWRbLjQHA9HFu1uWwjPLKCCs1OvHohL9VF+GL3xqrHTRQrVLQz6B
	 S5raRj1LET95iZPGhdEu6TsfcoTqA9arqGmseIFwf/gR4DVbpB6vTLmmGuHrAWwc0C
	 YzxoLCWQ4eJKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72A5781EA8;
	Wed, 23 Sep 2026 19:42:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 220383A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13BB081E51
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:42:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWS-arUkv6pc for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 19:42:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C5FE480BE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790192542;
 b=khrclqLU65jw5b++wKxr646o/zEcYoVhIILtvfGmZNYYKa9FI1cM996F/IJWFdD/rMow
 AZQXwajLzuX4XAKMtCKan8KZ6k2xqNaaJhrSMMLUexYLibCdzTi7DU96tkHHiYbuLKX+d
 XrcIJNssnf2GLP6YQyRaGNg9MHHX4XcUO6xQ8NCQSfjwUsbx3Jd69+IJuUZ/E3WpNa8NF
 4WlvToyhWcr5lyIgMLjyPFCiL/BkkHVB8DKH//7Vw86UQORr7+WlYsnpMOtYUF4+bEqTB
 7OA+BOLgc66AHBmpa0zWnbln3xeajL7QpqMDVTarlEv+oVvZrX639nG4b4UgNA4vq9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790192542;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=LsB5PaKudZ/K/i+SoY5llCk1UWfpycKe7xtWM8VujlA=;
 b=J/aMpDQ2nnljimIbeXz2OuzHKq2S5MTnL3x7D8b9NIm5KtEl8AV+ByJjJ1YvBtxac1Yl
 IE6wK9eN08Fz8xxhaqRtQkNWpCUmWa9GZzrFuIthfPdB7Yx7USAP7xXIP95jjiMpmqnzf
 WZqhf2hKIQzxHCb0gBXD31bazhVKUqdzXzCP3VffmyLm5PXvp38Ag2ZNlxFyTEpjM6dps
 Yckw5gctfYdMP0a+dxYxek6MOW9ARF5v8DX/EsFzNmsARrUTPj7sOEHJhyrPNxUv6zE3r
 ugT/beeWw9yNYA5mafLEaF8VkQECZBCRPl+CiPw+ResL6vLElTIoHoeZf2Pvwg9/0tg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jTgNGJTu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jTgNGJTu
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5FE480BE9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:42:21 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-48f0056ef38so988130fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790192540; x=1790797340;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LsB5PaKudZ/K/i+SoY5llCk1UWfpycKe7xtWM8VujlA=;
 b=jTgNGJTu8aAVEaK07b5jBmD1IGJRC8AZvcWbMxxxYGZQQZ9ExWEjWOP2fCsckjfZ1H
 nxjaW/lPRDIua5YErE6hMkNmRAICXx2RnhLP+ai1V5ejnXDm8RhX9zeRrage1RD6wBKO
 MwPuAlqPuQxMnTqZISMCK6wtuvcKK1K3TSxfD1KNBQdXT2K0S7DUfx7ivbxacfbv9s3R
 vry97gvG6QjyBsPf/r0qiGoJ5RguaRHtCUQUyjfcSKtZjf01AjtZGNHubI1LDvDkgElQ
 QPak32Eqq1czgfe1xZAbEElBtmcNUA0hfSTuMagoiY0TEGRIS+GSuFW1xGNWqF4+IG54
 mX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192540; x=1790797340;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LsB5PaKudZ/K/i+SoY5llCk1UWfpycKe7xtWM8VujlA=;
 b=Wj751avVCRHTmcQ23v7BWUqsER0zaYw1MvbirASu+HEkwRWTWkspTG9S0xt2cAgU7E
 uFVh2UXchb/WHGaFjGsTQcQRX8oFXJsc8zg45JHSwbe/EVIi5vNaMcKHFXjcZWuPb12p
 xVYk/8cpjhf0RetQNA7RpxYB7WiFbB3S9dB5/vWCMjzQ7Vo/eJbNBOOsaTtyNxo13J8/
 3A8M1LbXoSYw6pdbm97higngklcKpS1/lf8Cc4PRMheVTsBWd/f1iaT3Pwcsaw6ZyWWp
 D51OdxxIjl/OJN+SmmJ3WoUja0ndQO19LSzj6ruXysBc2aIntXjXqWt7zwSuvBhWAwQh
 FLnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw815wPbVWD8jjwIInVdTDfgkw3xkNT+VqBHykgD+U2ItIEKjVAZySMiNeJ1NkcXs2quloX5gw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lLS0uCkF9M4vKOp1rXC1Ut223nI9bFMni0mZVBLdtH1+oidU3A
 un19eVoO6+17FJ3Nk1jwXZNniEJXsikswkJ6s/dwO7NRkbu+MXrAYrsJNxo441bv94g7/95++W3
 Y8zs2
X-Gm-Gg: AYBFou3bOnPPloEDYwlPY/t30aHXVz8nyhKIsvSi+oMK6zmFB8moD5wKz16jGutmHfG
 Bc2qgU2vee+dPJrhZZ21KmNeBZcxF+FehOTR7Wk6fp71JjuPjIqqfs4MpV0dxGl8KraU2iBXdnU
 y23XA3sc4Zvg+dZzXw73txYU/duL5EACKqNdtTustDfTA2FxA/n/ov4hD7lFn1oDpRUmZc5P+To
 HjKN7s9/wV3Yzh810xxGq6YKZZhLhlCxgGITjFCH/1aY4l9o25YEEv8gnjAwtBa70UFjgaITgxT
 GR46o1APQwlXvv5jyxNcDtAOe9wHO3Dw4ykZYycnT/eqsc17cmxlH/0KwYWQXVLKbg6RT8J3Mov
 ycoSyrZtfwMUjJ1GOCNsRZNpRIjBb7+brd13bp1pDNiMSLXGpfGXQHS8PkFQJeh2N5nL8VdKUIq
 ef+OWx/rQ0SfWhxJqTkqK74aH1yNt6kV73g2pAeri4gCam89S3LKChNOSe0KalzOZ2iEgFo1wAW
 ttmJr9hS/7K5wRNxyVnoMedl3Y+RfCoi7eZtPlBbIdd+vnt
X-Received: by 2002:a05:6820:2226:b0:6b7:83d6:2926 with SMTP id
 006d021491bc7-6d440a0e90bmr313914eaf.41.1790192540017; 
 Wed, 23 Sep 2026 12:42:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491ed1e736csm135071fac.5.2026.09.23.12.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:42:19 -0700 (PDT)
Message-ID: <54b4ddd4-76d7-430f-87a5-3bdfff611de8@baylibre.com>
Date: Wed, 23 Sep 2026 14:42:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] power: domain: mtk: add MT8365 power domain
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
 <20260916-mt8365-add-power-domain-v1-2-b768d71b895c@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260916-mt8365-add-power-domain-v1-2-b768d71b895c@baylibre.com>
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

On 9/16/26 9:58 AM, Julien Stephan wrote:
> Add power domain support for MT8365.
> 
> The domain tables and bus-protection sequences mirror the Linux
> mt8365-pm-domains.h data available at commit  ffeebf7587f5

extra space. 

> ("pmdomain: mediatek: Convert all SoCs to new style regmap retrieval")
> 

...

> +static const struct mtk_scp_domain_data mt8365_scp_domain[] = {
> +	[MT8365_POWER_DOMAIN_MM] = {
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = 0x30c,
> +		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
> +		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_cfg = {
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
> +				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
> +			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
> +					MT8365_INFRA_TOPAXI_SI0_CTL,
> +					MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
> +					MT8365_INFRA_NAO_TOPAXI_SI0_STA),
> +			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
> +					MT8365_INFRA_TOPAXI_SI2_CTL,
> +					MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
> +					MT8365_INFRA_NAO_TOPAXI_SI2_STA),
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
> +		},
> +	},

Do we need a new strict bus protection .caps flag on MT8365_POWER_DOMAIN_MM?

It would need an implementation like [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2567a84520d10b8418cc3b53454e4b6aadaf728

> +	[MT8365_POWER_DOMAIN_CONN] = {
> +		.sta_mask = PWR_STATUS_CONN,
> +		.ctl_offs = 0x032c,
> +		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
> +		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_cfg = {
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_MFG] = {
> +		.sta_mask = PWR_STATUS_MFG,
> +		.ctl_offs = 0x0338,
> +		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
> +		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_cfg = {
> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),

I see this is copied from Linux, but would be nice to have a macro for
BIT(25) to be consistent with surrounding code.

> +			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
> +				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
> +				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
> +		},
> +	},
