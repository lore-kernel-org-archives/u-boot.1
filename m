Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31338606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qmomsuu/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ogfYn3ZP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05CCD607C2;
	Mon,  9 Nov 2026 18:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hz3XY8l0ymk2; Mon,  9 Nov 2026 18:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B0EA607ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247237;
	b=CMp2T7zQUROMiSYZ3c2Dru8JTKuQwPVWBFGi/251kfCkyR/0M4qpU6kZ1zXBdmHP/UvF
	 sy44EeDxC2OXZuF26ihVjORsO2u0xVLJ0Tbmi9jlGuftmP8iRtB2naBxIMKakbOqvtDmX
	 Us1JLtuCXplnLf2RIC0cBfwK3T8uPpLub9EPV7IPQMlMe3ZMhMyfvS5pA5yk1daYro7Bd
	 d9wRqdk6/51Ob23Wqb6WdQsEQfMe0V8tbOI3Lioyzk6OK1THazD70zrP11+OGO8ZPvqOt
	 LFcw4KZIQUyzGENwGvjnRBBnwREbpT7EGE5TzL/400QDKDuahUXAK9NthGtzmMHxrKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=02uZ7Qq3mKvnAjbDfmeFCiIzzAZ1d1GRjiOIxdxuEEE=;
	b=SIkis0yHIoIptDqEcOoD0/qWp2NLVdc4C0Ya/d1qwjNBfjXOl/cJtggXMqI4p371L1lW
	 AFwfPYEOlootdt8p1STvzZQusUfIrqGjgKGnd8snb3VEHYj7CBwvEocGTRVVtLtTwrJRX
	 +ZIT7HMiWQwJ9svq1NyKEFEnAN5vBtruICxP3kBr6ff7jn/UtaXe9kPdp+ktxvI/r89U4
	 1fMhYA2tFSGAYSF2wfXV6RUIzr3RmA78/pFnY5rKz7hwQHRNCLHD+dyPYFDPipPjZPTqg
	 stGKUhsqW3+JP6dn8HcXzpXMmKBeFbs3wWPOOnibwr2iN62GUk3J9Zzmaka9XSDoXnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794247237;
	bh=02uZ7Qq3mKvnAjbDfmeFCiIzzAZ1d1GRjiOIxdxuEEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qmomsuu/rG6xq/MNU7FxDdxYeKTFuzjA77O1HjCC+WNMHR3EizijUXUullCDVT07U
	 WkQrfHcX4VrvUPfzm6LQVxFWF6XpulhrbqlRW3JhMi5jeEt/rruVpghHrK//xAZkXO
	 wSgukODyuoBeRo8nL6oznru+vv5DmmXQEAA0VHWgmmChY92wFOsHLC4eLc5g2VV+4n
	 9S9oJM2E3NaVpT8QtlPFbNbbxApxs/ecpjt4QRhGn4lz2YmIibmTjlK5kBUt2TtGCO
	 maitD7EcT00O2OybcGAv/AquXVRc/vXCWNjITiy3v59F4yj5HSdcZTTmMVF7DGc0sT
	 gnW3KJnNYE6Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B0EA607ED;
	Mon,  9 Nov 2026 18:00:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73874971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 593608103B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gX4f3K4AC5od for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD60781024
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ogfYn3ZP
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD60781024
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:35 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-46556b9e02cso792080fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794247234; x=1794852034;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=02uZ7Qq3mKvnAjbDfmeFCiIzzAZ1d1GRjiOIxdxuEEE=;
 b=ogfYn3ZPMOubH6nJ0J0luOu0zSOC68VZIHX7K5Na4ugNdcOWJDWH5MdjW2vTe0ne5B
 whyVY2QKHSzRVZFUS5U+WTCgMRf/nByDrtbhxEz6+0SZ1qHwO39LxMjAtEvn4O9x1e9z
 SJO3PXHKHLVPoO6/1QZZClDWawBbpg+XCt+ln+K/nQSzQEXaTq6vTb+Tlp31xrE91bf7
 fZZt28VuLLPCZRb2ve/+cIKa8TQkyrODtQg5yazJFIJsTBDZeGG9UcKwRZ8mOL0A4qCI
 xitiH9KJZrLjTL4qs+/PgrOFsamncdqPeS3jCb6TBDqMzxx5PmYj0wdYTd4e2+f8lwVI
 0cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247234; x=1794852034;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=02uZ7Qq3mKvnAjbDfmeFCiIzzAZ1d1GRjiOIxdxuEEE=;
 b=YgOCcDSbGCA9HHuCvY+lAcAjzHSs1aqXLNRAe9dkJgkqU/R/ecQuuSmptql1rvaKnN
 CO/NWUxyhWyavN0aHRfaD4yfvRncFzMELnI4fiB90hbiTUYSqI8pirRjrR7FplFaWhWN
 e8ZIw+UWjs9Ttu09r6wxgoHvmCvkznLzo0g9TnIhlLWFN24XCrENhKWBoHEEfecd99wz
 vGNAFfggCTlq455aezc2whKzqcrTC6YQHtI10mmwA0OjberjHCpTVmKRy11yoB6e559+
 GvdRD0UmTC9jTVOXeBJL0ppbdGXBmFMeK8eF0WCKvDLYg3N1S0hhP0863d+BYn0YKJha
 9vVg==
X-Forwarded-Encrypted: i=1;
 AL+hErG16nPg2MbXF5oZPnttDAWOE/GCmgPNEldrvpFZIbxnONSSv+bfQ3zCICIxrCz884zlt9PjvMQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8VqIRP3ginYDl7ltRK5O9YlZ49iT+6Xs8vnK5Ag2y5lSvKitUc
 yltvp15g9P1hqmf9F4KnHipPq6rYY8HZN4vSPaqTBgOgJWKCIVu8B7N2VO35JAf9Lps=
X-Gm-Gg: AYBFou2sPf4etqg3fOAGjFkVjTdjI8NC4260VpRUbE2/9fArXmxC1O3zK/ru0cGUq4u
 mwRGy71xlOcgX1ZSCtsVS8Y7ZUibOkQrM+WERyPjA2PALdHT8DGr9SXqLvd1QpbNYW9G38xTTYY
 5O4Nwmxgf5T4XsEgK/KVjkPod/KuEEuFEuD8TaIam7jNzH6QjC80cxL5YUjdiNxoyselNCSjILK
 J94tDY0t8PhgqZT79S5DSf/cwOC6vTjkGP7q+nW14+DpJ33ACBWSf+l6na2/C9oAcz+hMRcJR7M
 6oKBsr5HhO8PcgAvCzMkVMyTH3r61M3SmRHBPxuyWTuXJL5DsgWfPqAHWtiuo5w2RDcw81eV6Lp
 bAlGFx4D9h1K0/CFChJvF8OoRLBaX0u8X648LYjE1raaj+Fy7u1u2yOU3TWcsh1Kd/TbDHJ/Cex
 XQPlpFaMv4Fh7putdrb4v4BqbN1wDUT/mJweBp3/0sk9cA3uLebFvNcWHeyzjwxqlV+wJ5LDNSf
 BlFy1bYdNFseC/tAZHyXctlmhGj1ultX44WcQuewskgR9VbXrCZ/Ir/5dgasJBDWO+5f6IPHwMM
 Q9a4U0vZxM5qdc3GfjYnesBhJP5VxC+VE+NrfiRQrhUJE7GZlbvVOmytG1Zc2mEkY6sqw1SbfPq
 JFw==
X-Received: by 2002:a05:6870:1b05:b0:48f:e0f6:bd4a with SMTP id
 586e51a60fabf-4ae20333e7amr120357fac.31.1794247233195; 
 Mon, 09 Nov 2026 10:00:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ade68ae284sm5864246fac.6.2026.11.09.10.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 10:00:32 -0800 (PST)
Message-ID: <a6533f92-e9cd-4a46-ba75-d57c2e601411@baylibre.com>
Date: Mon, 9 Nov 2026 12:00:31 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] configs: mt8188: enable USB host support
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>, Macpaul Lin
 <Macpaul.Lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
 <20261104-ccaione-upstream-mtk-g700-usb-v2-4-b8dc65b47373@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-4-b8dc65b47373@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 2:50 AM, Carlo Caione wrote:
> The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
> and onboard hub. Enable the required drivers in their shared MT8188
> configuration fragment so both boards can use the USB-C PD host port.
> 
> Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
> PMIC, regulator and onboard-hub support. Enable the USB command and
> mass-storage driver to discover and read removable media using the
> existing USB stack.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8188.config | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index cd5e68dbca3..8355ce56f90 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -13,16 +13,30 @@ CONFIG_BOOTSTD_FULL=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  CONFIG_OF_UPSTREAM=y
>  CONFIG_CLK=y
> +CONFIG_DM_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_MMC_MTK=y
>  CONFIG_PHY=y
> +CONFIG_PHY_MTK_TPHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_MTK_PWRAP=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_MT6359=y
>  CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_MTK=y

We don't use USB_XHCI_MTK here. USB_MTU3 covers it.

> +CONFIG_USB_MTU3=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_ONBOARD_HUB=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_MEDIATEK_HDMI=y
>  # CONFIG_WATCHDOG_AUTOSTART is not set
> 

