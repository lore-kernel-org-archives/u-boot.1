Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07BDC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 19:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B71F806BC;
	Wed, 23 Sep 2026 19:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDzmzuwnygt0; Wed, 23 Sep 2026 19:15:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C97E781E97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790190933;
	b=U9EusYBRzixgatxpAMYHmkbVSBOPi6owcmesTCZUKx2rZDuKfMSqAgKItPyGaoZ3dyGH
	 xV4JXzkjTsb/SR2cUpd+b+XvCpaurlbdPcdRElQjvgpMVRWFXjde9B9ye1xTEROQ4GkoS
	 7H5TV/8hjwMIUZbNwm4yKp43s2KoTh4qqyuiDFFLxdX8eDy2E0yztfCtEgXcRsdszhlQw
	 vecWL0KJJDt2v9ENcRSwS2Zm3BNRAYVifpjnVmBJvau48rSHPEHEtf382B82IoCUssWPw
	 FbCXriDsl425LpHIAjEKKRmJMu/M9Kv4XO9//Yqf17z0rJ1/TSJonQD2LF51dWYWIpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790190933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ijwj4DBqxDS0ZJ1jNk0LjhAlnODlFoYO2X+7XShO+C8=;
	b=Tc6dlpwSwx6RrGj97tJWtRZf8gNP6L7uLFQ+9U+VRKIKg1Tyucwu37fCmsx9owzXqFHE
	 kNrWAI77mjlkIY1RqPVWFiwrEzQfIBoRuwtRiN7S8gp4PV9nQDbC7EXgUpV0DIt3rdNt1
	 emHnYL5KQZQnhT9keXT/P1cv5IzW2/1ScaiaXccX6iPY+HDZjoghBAcsMdaof2AOzgOyw
	 y7eJ5qYcjr1P2Yhid/9DVJepi/6QHWSw5C6/2QOiCeggFnSDIyfIcK2kvvqjN9DESORCm
	 sdjDpqtTDBterhGothFn5iG7uSbCjyeAF5JtS7uD8gPawlipttQK3H1YhYWHWgysvzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790190932;
	bh=ijwj4DBqxDS0ZJ1jNk0LjhAlnODlFoYO2X+7XShO+C8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KvFdF9ZcyyYLICX26Ls24FJASmqmtrAc8AW2RYZxN/67H76rf2jnqIKFSzD3rEUgP
	 wsTQ6WuJardO4ZM1TDR5EckjK2jw1rieQcYLhsnpHEj+zBZlq5nhRY/xY05DzoTgmF
	 QGaxp0NzqirB2Xvv2086dVXzb2Ke4ayP+wbFwhdZ7O1CgKBY0LBJzDdGoaZAmZuUs/
	 xLmfZibgSU7U06wz1WpTPKBiFxfCgvifTW4tudeHiDGhX76TA6bEXIvGQMLJHrET5h
	 cMFMP1GA6dNXl2+wYwrHa7VNHiTgb8zVv5A/M+WOwA8PwTelqrIcVbXNl8Z4C9rhPE
	 DeUW8E9HPQtSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C97E781E97;
	Wed, 23 Sep 2026 19:15:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6463C32F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A48D60BEE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90JQaYYiVxRX for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 19:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 693A360B25
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790190930;
 b=lLq16xiemtTV/wzOoi9ttkunUbzela2qK2bftAC0s9RRJoa0CXdVUCRaSl7R7LzThFEg
 c4VAp7mCY6cD9pGAyjzbvpGVSZkk323050oNVrJ2QyzNgMg7P3O9uJt/mikZQ4pingHJN
 8W8Z1uLz1Cx2em+SI/lqVf0qEwQ8GTSw9931/6GKu1WXJHCZD3D9M342cDxy2fGDa8dX1
 GoAE35BL12Rn/ilNKGC2cT2GnI+7EdQLnFOfbrQmSanBMRfUYGBuy+6EKe1badvpyj/sQ
 X9dX72hk35PI/NNeD3Y8hLXRXfHcHOs1s+04xUm/zgNNS1iwwtjmvmWD4pemgHxnOag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790190930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ijwj4DBqxDS0ZJ1jNk0LjhAlnODlFoYO2X+7XShO+C8=;
 b=jaNWgOl8q8ujyQVceDms/LCOgXxqIl6djCuBDhFbzPXCerHK/djr/KfRsV0E58xtySkf
 npzSSC1GS1FWgtXsHGM/jcucL2EQM9+03BD1bxmm3t8b1khLw1JKLeNbh3PJlAUTM0WKY
 A2thbwnWdrSkU/MAVwUb0swwLjoADBowgkdPcH0duwN4yXLPnj25YsdMDhhMST9ZZFB9Z
 WlzwvA2sBHrFHhPfIcO332FWaiZlU2d3u7LiKDY6h8sToO6ml4pQVaPqP6eeGU7I7bilZ
 9QX86Lc9ytbWtEu26gbirtCdiwzH3R6V5u1Tr46kDJr/MMYtXijb2IKitHBZGDCefKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gt7c0a+s; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gt7c0a+s
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 693A360B25
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:15:29 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae6b200fso839868eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790190929; x=1790795729;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ijwj4DBqxDS0ZJ1jNk0LjhAlnODlFoYO2X+7XShO+C8=;
 b=gt7c0a+sDooxIoHz2j/UQ3xaS8lM1jfkSN0CVlU8wrWw4Hq1xVFdG026R48uxihrFj
 M2yefnrv/rFOST/TxmyKDwKc5apKZ4P7gAXxjeXYDYVSBxYfPQD60njn+jNBIwBCAAZA
 kGmfFWX8MPZ+3aZl6yvQT3dkC6NSS+A5rvzi06+OLPvV2uDP4lNGpckddhAUuxJl0KZS
 yMLT/1ssg+ydTUHtlUP6ExYgADxzgmoOZKQhuyVCV+jzpTuuayYkDKyBMmpliIEVUKFW
 Z6qsTxn247bZtnyxJwdKPSkBdv13CGRtASzneApS9nmFEeulyPohx2/ddIDhACe+UT35
 svUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790190929; x=1790795729;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijwj4DBqxDS0ZJ1jNk0LjhAlnODlFoYO2X+7XShO+C8=;
 b=tLYBmww/p7ewIUAqWXea/15lOQD7bAC5E1T4/Jv/QvZsXwqdeFbmj72gaV3dUjwVtg
 QsE++DkKX/QAdLSyUIPllWSbBNyZ62ymAJ3RgnYffXr2VCmDYSltGMWOzTxKgbB9EkwZ
 MWfsQz9LWo2nlh6CDnJCHAMH3WGg9hpzqMsQyQbCOaT+9GM5/vee8OlO6eWAxbxaLQz6
 kaXdXhhUL1ouJqUl3FmdiizT8wgR56P+DlR4L/NYO+NfFww9u6jBQ7cLoyAegNXey9Kt
 daxk1ARi/EhgImc0vR0yYHHqdRlnnmSaI5XiCSnUcCKcu+be7ItQs8UlGspNCCQQgJIg
 Glaw==
X-Forwarded-Encrypted: i=1;
 AKwUvByeOXaDHZOFrdGDXY9vMatFs2aXJttI/tlW9iBRv0Aji/HnSdUY5EP45twT+KGeLZe3CRaaLz8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhY82soiQsLDaBuS35aeL9TNPhH5aKDHduPQUcj1giiWWEOj2g
 vY6GqFQa0GmjA3JTa8n+y3DWGcBW9tKgQFAytEIM9ceymPBQXsD1hlsKanQRZwcOE7M=
X-Gm-Gg: AYBFou0oW3xyUNsUSA+cKU+LBbKkQ13N89U4bpW7wB7JgrmorS11SJHfXPM3zSUUS3d
 +xKTobZYF8QsezsBnuyhaCoZsVQ+7WSay9ki2FwgBxpzHIaSlOxa89vIh/qS/d/QNKDACBN5MYi
 Hn6Edg8MwehFisqPj2giIbPhHu7vjmE8MlfJCXq/NNcq6AxNd3DAJG0ivJIwvB+twc/61Mp2+14
 WDVKeklD0xvF0eTKzJra7mZtl0uyV0EcQzUr1UW/+cl4hlSFTve5+5LyHu7JBN43wt540KnKsqA
 BZk1JWWzO2xfpo5nLNVBpfjZ/vILtEkTh26kAmnShTZPsmJQj6Y0IolX911+xudWDWJSJzwYlyc
 7HmNv/ssvtx78htxGsmFVCOffMW1t3T1qLxkqmKp94bauZVfzgWEk2V55XOVbVDV97hf3cCTEqV
 1tl0bweUt/oIejT9+cfzSS8Uxh5UB7gECB8CKifoj9uzYRscxZsvi75IEATK7OE+CtWo4uZMwWR
 Kso1VRVuH4sDy5x4DM7e2Ts9Y5BKRZdCUhXAIRgXIMhL9Hc
X-Received: by 2002:a05:6820:1611:b0:6b7:46fa:16a1 with SMTP id
 006d021491bc7-6d43ff69692mr260858eaf.54.1790190928873; 
 Wed, 23 Sep 2026 12:15:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce25c568sm3576364eaf.4.2026.09.23.12.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:15:26 -0700 (PDT)
Message-ID: <e3b57d41-1623-4e32-a509-ec122b26856d@baylibre.com>
Date: Wed, 23 Sep 2026 14:15:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: domain: mediatek: support SMI and infra-nao
 bus protection
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
 <20260916-mt8365-add-power-domain-v1-1-b768d71b895c@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260916-mt8365-add-power-domain-v1-1-b768d71b895c@baylibre.com>
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
> The scpsys bus protection so far only drove the infracfg register block.
> Some SoCs, such as the MT8365, also gate power domains through the SMI
> common space and acknowledge their way-enable protections via the
> read-only infracfg "nao" mirror.
> 
> Extend the bus protection descriptor with a target register block and a
> separate status block, add the inverted (way-enable) set/clear polarity,
> and retrieve the additional "mediatek,smi" and "mediatek,infracfg-nao"
> regmaps per domain. Existing SoC tables are updated to select the
> default infracfg block.
> 
> This mirrors the Linux driver available upstream at commit Fixes:
> 1b78070aaef6 ("Merge tag 'net-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

This reference looks wrong. s/Fixes:// and use the actual commit, not a
merge commit.


> diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
> index 24b4991e469..768ab8bab9c 100644
> --- a/drivers/power/domain/mtk-power-domain.c
> +++ b/drivers/power/domain/mtk-power-domain.c
> @@ -43,32 +43,57 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
>  				  !(val & mask), 100);
>  }
>  
> -static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
> -				      void __iomem *reg)
> +static void __iomem *scpsys_bus_prot_reg(struct mtk_scpsys *scpsys,
> +					 struct mtk_scp_domain *domain, u8 block)
>  {
> +	switch (block) {
> +	case BUS_PROT_BLOCK_INFRA_NAO:
> +		return domain->infracfg_nao;
> +	case BUS_PROT_BLOCK_SMI:
> +		return domain->smi;
> +	case BUS_PROT_BLOCK_INFRA:
> +	default:
> +		return domain->infracfg ? domain->infracfg : scpsys->infracfg;

can just be domain->infracfg ?: scpsys->infracfg;

> +	}
> +}
> +

...

> @@ -396,6 +425,33 @@ static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int paren
>  		domain->infracfg = regmap_get_range(regmap, 0);
>  	}

Probably worth a comment saying these are deprecated but we need to support
devicetrees that contain them (e.g. upstream is still using them in mt8365.dtsi)

Also wondering if we should consider these required instead of optional for
mt8365, otherwise we could end up with null pointer problems. Or go ahead
and implement the replacement, which looks like getting the register address
from the power controller itself.

e.g. if reg-names contains 

>  
> +	if (ofnode_read_bool(node, "mediatek,infracfg-nao")) {
> +		ret = ofnode_parse_phandle_with_args(node, "mediatek,infracfg-nao",
> +						     NULL, 0, 0, &args);
> +		if (ret)
> +			return ret;
> +
> +		regmap = syscon_node_to_regmap(args.node);
> +		if (IS_ERR(regmap))
> +			return PTR_ERR(regmap);
> +
> +		domain->infracfg_nao = regmap_get_range(regmap, 0);

It looks like we aren't acutally using the regmap. Could we just use
ofnode_get_addr() instead? Or do we need the regmap code to do extra setup/
checking for us?

> +	}
> +
> +	if (ofnode_read_bool(node, "mediatek,smi")) {
> +		ret = ofnode_parse_phandle_with_args(node, "mediatek,smi",
> +						     NULL, 0, 0, &args);
> +		if (ret)
> +			return ret;
> +
> +		/* The SMI common node is not a syscon, map its registers directly. */
> +		ret = regmap_init_mem(args.node, &regmap);
> +		if (ret)
> +			return ret;
> +
> +		domain->smi = regmap_get_range(regmap, 0);
> +	}
> +
>  	num_clks = ofnode_read_string_count(node, "clock-names");
>  	for (i = 0; i < num_clks; i++) {
>  		ret = ofnode_read_string_index(node, "clock-names", i, &clk_name);
