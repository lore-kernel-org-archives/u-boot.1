Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBC606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UN2+GuPG;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Fa2hT4Jf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B929A810AC;
	Tue, 20 Oct 2026 23:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVSveMXqUNAS; Tue, 20 Oct 2026 23:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5BE98102D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792537689;
	b=QiuEJ3nvwuUB1mkBs7DclrJa/Vh15iXYkMLKQ18ekcWHHXxOf2sBIozU73XW2ZsWif0H
	 3irv/zzPpmV1TQyvbJ0D6YYWimz+FE8wIcgfCmGLVJrV8OZaWueQeZsisXW2sdxbIWm3A
	 p34Io8pWMWSCBrJC3J+zdjwpZtCYKS9Ejujx26ot5Q1HwKSNBt04MGqfPZfYt70YZ/0n9
	 bULbg0Ek+QwY7QOQGwA9mMQgepC8Eyb5PMWGb1veAxh0hpxgJffvWWL+CEomahJ0LT9An
	 n+X4kP/M+BRqbJsYwLzeOe9QgeDPbklG+5enc4ya3Za5xUFvSxjrrQpXU/M2yx6PUMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792537689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2MHrdrrRmUmcznoPRDKb+oc/ufTloFTkksZR6lIWlA0=;
	b=YlDXSR40RnudM00t/TptFDFZTzMrHzDl7SD9dQP36cla8lV9eIUkaAFLcDX2BJMkQTh6
	 96No9r0Q5be7YS771a/cENq7posxHP4nxLIafN0QS2u/0cUQzWgLG28K/BKYsxwGz3Oc/
	 7NQQj3qNm/MhAP28xzyaANTOwaKEB/hUCINRxcCDLgvdcOVpiGXQl0+cdd3hkFhmfgoFf
	 Ioe3CYPhn5+Uzihp/lzGkvN3dLcg1vfdscN5CnzjNnnbkha4Hg6d0qq3jll8vdsC0Tcnm
	 UW2Rse1Fhyz3Aa9arRDGy05TUNgnhtUZqgColPfweY1GVkUgCuT3V31vOmUSKtiL/Xw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792537689;
	bh=2MHrdrrRmUmcznoPRDKb+oc/ufTloFTkksZR6lIWlA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UN2+GuPGlYdpLga5PMhL3Sh4FCXE5Ve6We/1rznKpzKyITqdpiixQme4o+J6i39p/
	 KyHO6ySw8fAyMFt0YCy/lnoFeDowh0QWdl5HXtZVM/4fWmJ/ZgmDCkQnqXDWMVZsjO
	 r/nlSInP2kbRSx2XSDcBYSBCewGj4cjRa3zzD337tyGNZLTmiaRSw/ZIdbpWIjHP/i
	 XAeU1lFn0oXEKf25QUEpoy5Ovy+5UIhJy/P82ViMqCgX9LcMaBBHYuGfbObMyQ2q4p
	 UExL30u8aNsz/oD7ZKebvWse2a65wAia4UBvRgQEvXus0c+Yc047rcf1+O6oMwfFwa
	 sOs6p9U95e1MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5BE98102D;
	Tue, 20 Oct 2026 23:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71DB81AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63978606DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJZumdowQONe for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 23:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F5CD6060C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792537686;
 b=eUKM2g2Yp11D8nLsAV8mq6jZf6TxOmd5iqC5n+iXNp3fGWWkaCbQ+m9M5k08dHCdlmN7
 i7JqLzEm62emnrfC9XzgCxAoPCCMx9hv9gcIPRTW4NLu5XK7Ypzn6CFwM7Y6xuKv1Vum3
 +HcJ8/rNJ38MjzW8wGJrKEh3QgM/Szpa9RLdUd64OJoKt/wZHKrcZzodWu73jUYIroBw1
 czZmRudRrxrnDLzni1imoYpEq+/MPedNL4MaxhUi3fOIzlrunfZRO1TcPlOfTvC8GGKbr
 oHDCMNZb0xj7o4gfnlaqPjRx+I0joWrRMvKcWL10c59xlFfD1VmukO9DycEZYrIbVnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792537686;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=2MHrdrrRmUmcznoPRDKb+oc/ufTloFTkksZR6lIWlA0=;
 b=q94nZhhujU38xqec9vzYSV5xbMhQy+WuLVZdReRJAbncKa/XCSRjxECYsALJco3PkcRK
 +nPj+ChCTiQamlNq7d0vyUFy43ODULMLmjCs1Y5Lq5nasR2ucrcQXwdSS0Mqg2gBP5hV5
 jFztFvNndXgqHSEb6PvJAh8pXDti0whx8YutuMnh8Dl19va7g0I7rP1efWdcp9kYa+/j4
 ZJMRzQ4zkctla1SCEQcFoA+34wDp128RtzfABDbOkG91A3JIL4hyc7kmF0/q15hDmdbGG
 57tB8pusb71KxhQZGamDrS0HyMGLCrCPJ2WQaXOqZlG72oe8aerSsAKa3hcDBdXev3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Fa2hT4Jf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Fa2hT4Jf
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F5CD6060C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:08:06 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8256106635eso87339a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792537685; x=1793142485;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2MHrdrrRmUmcznoPRDKb+oc/ufTloFTkksZR6lIWlA0=;
 b=Fa2hT4Jf6l39OrK7pEMY3Schtz9FPQr0bDSIzboeIQFP5CHKeYVpVpAvlhrKu6rdU3
 9p9ZabFPwWZ7Ge6IOAvoTN4dCfmgFPHAZhlAatrqip30nFO7tcn/EnA+hNQT90l8Ykwu
 h3IjEOEibcSGut9UH6w9tF76OUJaYsqdB2hYgbMANIEc1XyzVQMvLPDh6IJKUqU3+Cyg
 46DT0kD/2DBGrGRvTRVi1igbaVLjwTMJqzXR173jNEeJBWxRkmbK8ePRDRUqV7qlVSiT
 ZXaSNuF3RliTWyCp8HSqSU1Jca38CSU5svZH/m1GCAm9jrTBWEXhINGKrV1enA8B+rOm
 iy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792537685; x=1793142485;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2MHrdrrRmUmcznoPRDKb+oc/ufTloFTkksZR6lIWlA0=;
 b=Lgc/ZIoUt0qLFLqzqstiQMIoxWHkYTbgthCxOvV7/oNmA7uPacEBPh+HpsrnfynKfu
 luT0UdCs1gd1VuZzQk+/RtBoW3d68608d1xJzGPBJ7sUUD+soUzpJPFhdRSYeV4kOsW7
 pb2w+B2iB3coYN9V0CHm2rx9phg111utDbVMG5DWx48wO3PoRhgRdI0QRhaJaNU7Vspo
 PInm4MvtSkWSAxfze/oG6VbSwCXGgjxJrRwIpSL4/6rPuv9o7G1dHTuDRZcQdvcr8zXW
 TbGttMRLNU5LNhPww7qsoMUolVWZjqxuS4PjTGU4tgMFyhQFos9ByeEcIbbCBZuTk7rA
 br8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeqVpYAkGm8CFdQRExEEuAGce6572R68ewXny0nUTY9gX6k0uyf3ovW15RrbUSA1LPHFyw5sg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQx/Ywo0ccixGDzx7vMzdme5SZMkfsqiD1pby99F7su6OglslJ
 EdhE2OAiJJH/rpcINLCvd8v+CRoFtKygJpM+dOzdk24DxiDIiFIuXTDccfjM9t4a8U0=
X-Gm-Gg: AYBFou0V8b8wYtexb6Eo+WLjfkbBOZLCuVMHjLjOHOEx7D7NFx9KeQJJ4OJKwuxBEHx
 YkRUu3wvLcMlAfL7jJW6Yu7hRD3fhnq9HeCoQNEPdTg2+kRlY+PNmM9kt4CilvmhooC7nShTEtv
 FJDi46oced7JSwey61MXySMntJHDsAdZ/XDPha/FR0//y3sLNC36kLmnM2RsdAChlebKd1p7EbV
 FOO01qzsWAWpgtW4T22wayZZBRTcxInOKXcv72htazo2Eye9yq4ZGk2ydgI5Tribi6Z3Z6Zrkre
 /Vmydo1w5mmQH1VchWTQuSSVe9/JXCTP1Rw+RtSb8eDPhx4oxqSEpEq6taSk66RcfwPBRUxmiVq
 EeND0VLGYUjikz6btLvo+/4RgsCOVc4XUVaat5H5RTZNE5vnaOlNGACu2CZ4XXJkebS5vJQ6Csg
 2OIWrtzetpMbIQ2W/6Un1Hcd0n840u5ppbv/DD9+OVkcEMqwz9VrrTZpmq/aO0P8BdbSGyA81fo
 Ge+6EMNwdgbzDChIAuIPTVNT+ERYuUHWjlvv2omRQTkmsaZ
X-Received: by 2002:a05:6830:3748:b0:826:b94f:8144 with SMTP id
 46e09a7af769-84d0950af88mr177528a34.31.1792537685176; 
 Tue, 20 Oct 2026 16:08:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2d29sm800642a34.15.2026.10.20.16.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 16:08:04 -0700 (PDT)
Message-ID: <9e656c6c-d877-4a85-9f13-0a7ee85aa800@baylibre.com>
Date: Tue, 20 Oct 2026 18:08:02 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: domain: mtk: add MT8365 power domain
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
 <20261014-mt8365-add-power-domain-v2-2-dfc3e6eadfd5@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261014-mt8365-add-power-domain-v2-2-dfc3e6eadfd5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:16 AM, Julien Stephan wrote:
> Add power domain support for MT8365.
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

Undefined symbol. Assuming it should be:

				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1 |

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
> +		.caps = MTK_SCPD_STRICT_BUS_PROTECTION,
> +	},
