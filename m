Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57525606A32C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rJDgzH4h;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=g3KWEX/X
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7C4D810AF;
	Fri, 27 Nov 2026 11:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87XJpgsD_JxR; Fri, 27 Nov 2026 11:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6454D80AED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795779796;
	b=pgfdLeSY7KTz4WBSebJBJ8JuJZaE/RARk9V3j0e5lPQtzJffqt4Zj466Zgjkz9Rut0O1
	 Kdl3JHVUssGQ9pZPig4yGLHWnKrBX8XY1Q5yIN8R0fBYCiVzTIpFpOnHHr+M6mrbgY0rD
	 3nk8P989uD4DrMAY/J8AVRrlcGdguc+8dnl4NhIDvV/TGMkzx5U7Yz2OsKI2KU7JiMyZe
	 FsfK/EVaHEh6H9MESYRrpmlHKOvcyiy1f0IlhxaR2LfzyLQe9vXSsjL39VXHf7D0Hr0yE
	 yI0X3asAgzZ41frm8UZhhxHVosCaGY5vWLLHmHPoglpnfDidfzYOBurfOQMxlaXCPiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795779796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J2ASC0ZQ7vaSO5MA7L9MPmgD8XkWvkKN1uDx1Go/KEU=;
	b=EkTyYkzNHuAr8LV3avlgmuggpMChdlf1Ljf3YiKH9AWgBwqqFGO7hrwSV0gUDGIqhsLL
	 tjwrMz0E+daLDQn6WkyfpPNj2bgk2yKxzpbfJ9KfN67uhqvUpgZo6vK9B53nF7yG5XeK8
	 uHWLR4YZHxNmwghObT5dS/Cdh3Adm4JQ8ZAPTGJln1ltPLlf9vDoTSq3fOSEPnlgwq3xV
	 LleEXUJyww+6ATecVTr6YIoVXg+wHnYkTl8a+ftyrz5oZdzeIiMPZ2FONa7EKLFJMQ5lA
	 yHEieTIzQzgWAL9oayBK+Cyny2sxWIrYIoOxaFmFhtAm6FMURNC1D5wauTEQ9H29mwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795779796;
	bh=J2ASC0ZQ7vaSO5MA7L9MPmgD8XkWvkKN1uDx1Go/KEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJDgzH4hoLOgorJh8eKBQJiN0leZg6AWFKUtbtdKaS/7FRKYOW8cfbldaxQiydCel
	 gQtq7SKhnqF3ICQcNo0VxPf5gyxj+YslRNcrrTavRNYbqy39uFFtmX1psgEEW4R0UU
	 T0s8WA9GppuAR3TO8TXL3x6vFhfDK8y09eJn9VfdZGwsUdoZipI/tvEvUwyI/WjjBK
	 t3i3RNZUS2+XBi8g4KMgF2nYGP1s+ViWj6NhbyZ5KIK1uRx9jnX+vtZBjpFPGRLKNI
	 AGkiCsBLC/XDlPEIN67mV0MjLSsq1dvQvmEtrKkVRqe5cH7mwXegN1obAfyDHPkAN3
	 9gA54fgh1qvww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6454D80AED;
	Fri, 27 Nov 2026 11:43:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C42311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAC1F40963
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GG1U3E0Ur0jK for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10C0F40934
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=g3KWEX/X
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10C0F40934
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795779769;
 bh=J2ASC0ZQ7vaSO5MA7L9MPmgD8XkWvkKN1uDx1Go/KEU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g3KWEX/Xqy25XuSrAmUX5i4i7tch2zUPTN8S60NWCZG4GeI84uq1mtBiPmXhzO3YM
 d+9ozhlWPYvTqLkqgnOZjph4BazQkGZdHp8o9IB7pctuvgV34JtKrQEUziZsMsYPPI
 7pW3zEqroVRyUabobbwkNacpVoI7fVg7D+RUxZrjJfYFu50pDu6Y31Mcw5E7jIOcvr
 9llKbgRC6ZMZSW5CTrvxhTIpPdcswckLLjCRVZhKFSsOYdgwYOjuCOJH3mmLimMd3m
 AY3tliyMD8asxxHXEg4sdmp8eaDS3tdpica1AKdwFyevlnwZ05cnGmJ0MaFcA07DKn
 4mSdAM2c5KFKQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 58CA9B220213;
 Fri, 27 Nov 2026 12:42:47 +0100 (CET)
Message-ID: <aac260b4-a43c-409d-8977-31b842934416@freeshell.de>
Date: Fri, 27 Nov 2026 03:42:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] pinctrl: spacemit: Add SPL support for K1/K3
 pinctrl driver
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-6-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-6-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 02:30, Anand Moon wrote:
> Add a Kconfig option to enable the SpacemiT K1/K3 pinctrl driver
> in SPL, allowing pin multiplexing and pin configuration during
> early board initialization.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
> index 87cba336923..ad5b458480a 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
>  	  The driver is controlled by a device tree node which contains both
>  	  the GPIO definitions and pin control functions for each available
>  	  multiplex function.
> +
> +config SPL_PINCTRL_SPACEMIT_K1
> +	bool "SpacemiT K1/K3 pinctrl driver in SPL"
> +	depends on SPL_PINCTRL && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
> +	select PINCTRL_SPACEMIT_K1
> +	help
> +	  Enable the SpacemiT K1/K3 pinctrl driver in SPL to configure
> +	  pin multiplexing and pin settings during early initialization.

Reviewed-by: E Shattow <e@freeshell.de>
