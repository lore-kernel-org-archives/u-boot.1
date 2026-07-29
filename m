Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7EBC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD15A80E3D;
	Wed, 29 Jul 2026 20:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lduy2NLUsHpC; Wed, 29 Jul 2026 20:16:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C6FE80DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785356213;
	bh=cdDSLI74Ww4xfUyZFSn/16qJKDvGuNERPDwPS1Hfvmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hn/NkyeFeFWXxO1O+YtTFO5vHGrK9j5y9OeIzpNxrb/pHkNEqv1JrOmkIdMyVc8Lk
	 Ww9xq63Av2BnZJNIhmmzvc91S3s5VvaIaSYPejATKl/u2BAgXFqIkNkx/HQ2aTOTY9
	 +6AsdOwPgX8OTd3CKySYeO7gq0PJfGnBDAX77yLP4YezTot08hqYjeQG6x3RhgOELB
	 KQgye4wTrhkoZG6gNn6KGNl3MvEnLVvWGlgc+xlXSf7nw0IPzLG9DEkYhvLkCPKDXU
	 nq21BAGC0w+gLd8umAC6D8I9w8mx3pILdpIdy1ZgO6Xx96/Alvy/N6PkfyhehIOQ2D
	 x3F/427GVKIuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C6FE80DF7;
	Wed, 29 Jul 2026 20:16:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2566D26E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 170224070C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B_QELeb4Vohy for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:16:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BEA8640705
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEA8640705
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEA8640705
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:16:50 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6aae3e18607so572659eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785356209; x=1785961009;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cdDSLI74Ww4xfUyZFSn/16qJKDvGuNERPDwPS1Hfvmg=;
 b=EJuX+iVMMt57eJu7zdyS5MiEliRvqNROMJCjokTCLtFrj6ZeDhn1BnViIw6JMEYraI
 dF3htAx4P/n6+DI4CZzJadqMlgkzp9Cdss0okPTpDRdsv8z75P6TncfMoHTwEmOcGP//
 b2hO4ZvrK5bEUf6r5dbwWMgBDUWBjd6MUEFICVHMoVnKZvdb5XfRCgspbp2PM224RfCu
 IU0iOoMzUuGOwmwJhlDzRxDYPHN4UScTXdEGTUiHjKcfWOxTeZAxl06A2hFv3STvVAjE
 KIoaVOKc8UVko03GgjVfZkro4/wwiVVBvYlYwzCndMGvmWlcqEZHK4h1Wt/qH/zYMn89
 UP8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RogmwwxCLUMNrLDS2D30PMte7SyEelRHlNrugE07phL94P5N9T7ZEztrDMmyRLAG8nl9wsiJts=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz7TslqS+SuNdKfHwjlNI2+NcNbEMK5xSxuwLbZqnKnVTEC5xgr
 Wd1EDRMWeIYE28U16RTrd8nblIDzFVfjjqeS8L+YKR7G/yS+TRK1Dhi2nYUzhenrbB4=
X-Gm-Gg: AR+sD13IigL+d5ZF/QiSjP9Ib1/cRM7IriLbN2+MwRt/D0XuTivonTGXbOqlZXcbwhs
 l1Dc50uP/wBDfe0x78skOG6+U2g+GrYh7aHXwy2+x91DDNzaxocsAcAoB9nOAAPzFkpBNZrAXAS
 f7Zg82/p+GzKZDXnbFQliAKn5YYfv6+m9INVb1bLYhYtEwS72G73sLv3t+RZzqM+C0FD3Mc7WIL
 WpWSSai4d80k89vwgg1ze3K47BIiUJ2zUxSlg3CFerUGZr4N4AOS2rbE+7dOXVpf6rOEPDElK8K
 1jaN/hU8IKdWkOXDyJ7lbHw8y8I7+OPVbZ4hK0Jab0zDpR2BId0kJLq1HXlAcw9xLwYQnhcSnIp
 DZ1qep4KEaGZ5L+P13/Y+nWEM2tJUHOFxAkxVYaICP+X4rkQ5kFI6QYFZqje/m9mmxAKMAhVdfp
 SXT6L0qjUKC5x+DhhBYgO47N9iZtFhyo3JxVfNX4m0iv8BNLKGbqJJNdIX3ZBQvoOWRpDMChZGJ
 3cU9vNnIpsFUkB37Fp3ZzRCKAyMYleWtyXtGGk=
X-Received: by 2002:a05:6808:f0f:b0:4a3:2bd1:5220 with SMTP id
 5614622812f47-4ad8708ac98mr31957b6e.36.1785356209252; 
 Wed, 29 Jul 2026 13:16:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6ecb8228sm2481512b6e.3.2026.07.29.13.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:16:48 -0700 (PDT)
Message-ID: <b128e207-cae2-4291-9ee5-0d483d30df79@baylibre.com>
Date: Wed, 29 Jul 2026 15:16:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] video: mediatek: add mixer component
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
 <20260728-add-genio-510-and-genio-700-hdmi-v1-2-ac54bd75f960@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-2-ac54bd75f960@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785356209; x=1785961009;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cdDSLI74Ww4xfUyZFSn/16qJKDvGuNERPDwPS1Hfvmg=;
 b=A96RgMMDAIj7L8GoO12kgYiyfuIxAN/5LLNEw7BnmaWr+24O5i1R9+jj/f2Nnt10BS
 lnModPqV2N7LUkSxcOCWfKB66MM33WNOUSRMjzhmNezpCXHyar55/cpPTgYg2OGvNim4
 kOuI69bBO9t7r7qjBc35q3AAJ2Au33uhTMLoLmSugy4JUXdMmBTbbmuVsfsm7jEvJLMI
 iHFa4n1KBfQgXF8jNcj2Ml+XbZhlCAwW7JbW5TKbHlEigps8/fzqY//SB2IZF0MN+nd8
 UwbY+IIme84op43fd0Ew27Me37XSo7s3fACXZBX0zt+zkaflb/D3CRPJarbl2rwnKqNH
 TD2A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A96RgMMD
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 7:29 AM, Julien Stephan wrote:
> The (ETHDR) mixer is one of the components of the video pipeline on
> some MediaTek SoCs, such as the MT8188. Only the mixer sub-block of
> the ethdr is used, which is its first register window.
> 

...

> +U_BOOT_DRIVER(mtk_disp_mixer) = {

If this is specific to mt8188, then the identifier should be
mtk_disp_mixer_mt8188. This way, it won't conflict with future
drivers. U-Boot wants all driver names unique for compile
testing as much as possible in the same config.

Same applies to other patches in this series.

> +	.name	   = "mtk_disp_mixer",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_disp_mixer_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
