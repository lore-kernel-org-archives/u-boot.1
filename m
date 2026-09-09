Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02924C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 21:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BB660801;
	Wed,  9 Sep 2026 21:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_83ej6dW4fQ; Wed,  9 Sep 2026 21:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D6F6060802
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788988584;
	b=MeKw/TYwT3vK75E9w3RxcVYrDanovDTEaXAzGUWLz5jLFqzwzOsX3LD01koFc9TZbwym
	 MtrxlUtMalUFSh9JkJ8nQ5tt9V/8EbhKt9J193f6EZ1pdZFpb7ma8w0oGIQDXffwnZXnl
	 ffMTy2EqgRlCmmchuhEXkT253rEqNrGbSmF8IhnFH0RgHW/4vjiy/RO3Ojh7OJjlemb8i
	 m+1vkkR6poM6wsZ1XmIZuHTpFHJGGFcxbUl63c04DI0MlLQmqtayIdw16/YyN8v8psEiW
	 5iK1ZynesVJ1lZD6fqjUpAWjFflyShmgncw5ECO1MbJXEpFh81xTUc6wU+f8jY3Pfsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788988584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YDpFN1/isKamABxCV3EgfAyaQ/J8k9/bEzPsZad2xRU=;
	b=Pvlw51397B/S9Hmr3IQ1Et+OTAOks7Vfq7xesKgBLWrCaNUepPPBB7C6DYI5yhmvxeVA
	 3KGHc35gx6BhoxYEWaaVcg7EQBQ9MXCWjxFZ7maZUZJFFn1+wYCSKd2lrYVpJNhDf2gDP
	 DDS1DvuWYrmvKieVhRj3WmlRTOy2kXOimgCDIK1g1s9F4hS/uxZkuwyB9mo0TR437inrX
	 85uHel1g2oYCU2+B2PXS71uv2jWhToFt047CMmJjoMMutR07KSQ3v5Yayyq5KrDQii39X
	 tWO2AC2APcSph0242TYDn77/mi5xddqzToOH2hM647nfz0wHx76Gp+LUIAQP5HhnRcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788988584;
	bh=YDpFN1/isKamABxCV3EgfAyaQ/J8k9/bEzPsZad2xRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aisCssclvr8nobRTHhKOjDStYrKxNUYCJZwH4wAlQGeMPXZwtN5LkVx3umsx3tbfZ
	 KzFHPB7r9P4XYHulvAiI7EE9DrpjIDdh7BbfL0EtpWPFj89ai+TXRe4UNlOVWIyq+0
	 285WcRh8EvIOHdSQ9OsTfLGR6AEZJEs/gA5sAK73q3gCJ0CzV7Dauh8GFQQIVBbDtK
	 dC3bNeLyrdVVW5MJ3wkQkiyyUkjFrnFKuHQbMO7rZFT+uB39aKkOuA0hW2Z795iLwK
	 fWioMFY+96ZYC5rhHgte8Jv1Og8zUEasZ5GqjTP6uuIMcNmvpyRQhaFU76yVQkjjsJ
	 0jZdUQNiQy64A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6F6060802;
	Wed,  9 Sep 2026 21:16:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F05C696A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5CC040AE3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id awo0JXLx9iIf for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 21:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B92B40AE2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788988582;
 b=ExGda71y2fjgZBMIu4fH2QzVba20irP586ep3iTmjDT6hzTEpQp1Q/wbdFTA6d/In0sh
 F28BJ1mXfOVlhdnU/r8h3AA3080RNZfs/kxMABr4n+OcQeSRepGBfAieUoR3oaR/IERRi
 mWcJeQOBS3wlNMXuAjOMfEn1WT1p6UhguEXs048eMtWX3Bgnc6Pz/hr/HTysN2oEFIGTx
 GpMk9kzZgb3vh9P9hfsdm/gvKO7MO+xbsDzsfnuFP7Vp0trzvOgmYeIKapKnbwndnj6K8
 TpSd4s7uXndXD4v6RDLxbp/jzlyt0F0do0Ia4r7XImz/HD/bzU4XNaNpb6iWetz6B4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788988582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=YDpFN1/isKamABxCV3EgfAyaQ/J8k9/bEzPsZad2xRU=;
 b=FhYswN9KfpVhawrG3aGi1GijOafJjxyFpHI5zi9KUPllSFuKSQjtGchtPAaSJC10bed0
 HYZinNCXwFulOW/q0b/WiTywtdfkeOpWVocdxpyC16WuajlbYsTtbNhwaaMCN8nKLDuwf
 JWXeUG63jtXz5Q4aAzqeZWMa+lv+/TVwkVhvioZpVQPn6mG/+PPpuyz4W0CEodEmlwH3P
 36Uz1xSXKrJ1cZYR7tj5afFc+Qr7/jgEjenRSr6/wKvgm5JMRrSP84CDEK6XOsPtYSGaA
 Wu7IgT51TsIIVv8dZyAPHCqfpxZM7wWgZPMgwtFe/yI+M0Dl8Fd66Un+7p3MmNLNXJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="mVr/oDmx"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mVr/oDmx
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B92B40AE2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:16:20 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so796435fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788988579; x=1789593379;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YDpFN1/isKamABxCV3EgfAyaQ/J8k9/bEzPsZad2xRU=;
 b=mVr/oDmxunkPq+3VH5Iz+XR8fsL8FUIN2rPGEOlfUw5qVXyJVrrARCltxrM6ekTkoq
 llI6rVmK6YbSv+yIvBnPnvnNO9ikMQqGrO0hwAJTDUIOGLvum0lhCzW9tfFbi6ml3HdW
 6gU1FLpfmqFY0wvD+x+kmzK+1mETIJINitnT71GGrA8raxXsFzmzZKbuHiN1Qs+zWXCw
 0gferxrmT1cRgTrhz4blTpNKcW7+VEhqi2hrWU6YllAxaSSchU7CPeXPc0Caet7uWy5m
 p8H2XBxcMAeayYa1RzTwFE6XzAvQY7//O+Ft+fn5GdJnFpG3/7XGciKKMXMb9ai0Q4c6
 1kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988579; x=1789593379;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YDpFN1/isKamABxCV3EgfAyaQ/J8k9/bEzPsZad2xRU=;
 b=ap4mkHfW9vbagSDXdbGvM6WxAeZWVP5r9eT4l1CehkrBuROWFDVC2zI06KXIMuBCt6
 qmNQ2k/nzt+wqPdfORgEFfAPAkkZEWIJj51LYJiILfJaW9w0r7+FfJAvxzcrFwhPxWyg
 Zc5Pp0vEaxigzaXtyvRf5HZQw7aBTPT5SQMx7Mu2ZOf/CSmtSRGv7Cw6EtY3e7aProrn
 64dFWS2dSMdm2nAUqdFIhjsqr1Mvh1Gd2sT8taQ246EMu36Z5jowsy72vt6abgEhXLeY
 LBRrgy34fAl0/j8LlpY7MJUlRRgiQYZ75Lfrp5axBKWR/6qbi3XwVVWGoGN7uDFkGkOC
 2kIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2RwmoW4x14IVTBCmZRRh7JXLYT/mkLmM4JXh3IbNLiViVdWTAphdIoyOL8GqfQq20T1rdWzs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m1VyZbTFyc9XYRX7eWp+HnSoW8y2O/7eXPIPD2saoCAy9FVK/W
 5/vVEGJ0ZZ0s2XWkYIlAa2cr2uToIS1F/gWQ/RLBM6rUWZA5/iiwb/+YQLVKFhX88EY=
X-Gm-Gg: AYBFou0th05HV4j2NX5KdQdZ7Aym+7WAUJmDncEIit/zwUc2ShwYnjVUW/HJhQbzDI6
 NneTA9+nSbwUn+U/IwfhxdwbheiEzSsbsfYV5Jt/yHGgRRkVzpSJRSiGOk72Js4oZdGD0HsP+zy
 h7XkvgduGNJ8++gmvXGBhGxyUFTRW6btGNv2LNcGJWqhL+ugE0j7rqS1RiveQXcGSv+2iQuYzFd
 jizXD/lPQ+4g2be2njUJbTpQzTqHuObgLTrA7+Z3NyqQ+vNy6w0mXbc/0ZtkGz1oo/XI1wTrNuN
 lBV4NhcmpvwPjDQw8SngV4VCmk0tW8MPz/WBOCq5+NHBXjrAFe6foLAcnGEqEPx00yP2yi5Ho4O
 XjX7SfhDFydcj+cmdaigNb0pFgmVcWmWlf30xRGKr2mvp5Y0KUSxpLa6lXPv8TAvAR0Ds7EFZJV
 axsyvagn5Okgg2s7kJkvCEVu95La+8DAiHU8dEN2zxdCWzUcqy8qMQyTEvJGz+lGMANLrSvw3mE
 pKOl1DSY9jZRoq44uYipO8M928hGvBWgRE3p4ljJEd6ILM=
X-Received: by 2002:a05:6820:4c85:b0:6b7:46fa:16ad with SMTP id
 006d021491bc7-6bee85ed759mr2262448eaf.66.1788988578756; 
 Wed, 09 Sep 2026 14:16:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dea11aeasm20495235eaf.14.2026.09.09.14.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 14:16:18 -0700 (PDT)
Message-ID: <7b98b6c4-078e-48f1-98d1-1b65fc19b611@baylibre.com>
Date: Wed, 9 Sep 2026 16:16:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fastboot: add SPL support
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
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

On 9/6/26 3:02 PM, Carlo Caione wrote:
> Some recovery and initial-provisioning flows run before usable firmware
> is available in persistent storage. In these flows the SoC ROM loads a
> small first stage, but that stage must still provide a standard protocol
> with which the host can provision the device.
> 

...

> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 111516fd1b3..a2a89fc04f8 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -48,10 +48,59 @@ static void oem_board(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
>  
> -static const struct {
> +struct fastboot_command {
>  	const char *command;
>  	void (*dispatch)(char *cmd_parameter, char *response);
> -} commands[FASTBOOT_COMMAND_COUNT] = {
> +};
> +
> +#ifdef CONFIG_XPL_BUILD
> +static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
> +	[FASTBOOT_COMMAND_GETVAR] = {
> +		.command = "getvar",
> +		.dispatch = getvar
> +	},
> +	[FASTBOOT_COMMAND_DOWNLOAD] = {
> +		.command = "download",
> +		.dispatch = download
> +	},
> +	[FASTBOOT_COMMAND_FLASH] =  {
> +		.command = "flash",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_ERASE] =  {
> +		.command = "erase",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_CONTINUE] =  {
> +		.command = "continue",
> +		.dispatch = okay
> +	},
> +	[FASTBOOT_COMMAND_REBOOT] =  {
> +		.command = "reboot",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
> +		.command = "reboot-bootloader",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_bootloader), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
> +		.command = "reboot-fastboot",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_fastbootd), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
> +		.command = "reboot-recovery",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_recovery), (NULL))
> +	},
> +	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
> +		.command = "set_active",
> +		.dispatch = okay
> +	},
> +};

Do we really need to make a complete second table or can we just #ifndef
the indivdual commands in the existing table?

> +#else
> +static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
>  	[FASTBOOT_COMMAND_GETVAR] = {
>  		.command = "getvar",
>  		.dispatch = getvar
