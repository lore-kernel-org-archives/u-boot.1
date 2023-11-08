Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94145C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECC387450;
	Wed,  8 Nov 2023 17:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mA5NrOAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCCF87572; Wed,  8 Nov 2023 17:59:34 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9247874BD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77774120c6eso450071285a.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462769; x=1700067569; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cMmYg75P5dlUq1+l87xMHYcn2m6Zjceco9n88HPllCE=;
 b=mA5NrOAuZSnhmLSkSC+rcwurfuVmQzMVNi98E3VVwpsSRxKvhzXZNIauxa8vdrbhbY
 INmLmyHP6//X2GwdIgPqTRNoWA4a4laNEnxCfC/DWkEa7bIkQaXbuFjgxBQW04Cx9K0+
 jOODoKCwTBNrFYpVx1L4GCLcUOsarD5hCdLoO/jaeneZbGtZHY0T7M2LcmFNN+7I40Ue
 3XskXUcvJg020Y/ox4po40cjWjsYov0odKJ6VwDW0tLZz0iBSt1+hnB0GAADjsjE5FL1
 jrYo9UivvrRX2q5ukcwmuaFknsVPPCme0Ad94l4XKxjW6aRh/p8kCzybUBbjv8VFb1XX
 B4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462769; x=1700067569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMmYg75P5dlUq1+l87xMHYcn2m6Zjceco9n88HPllCE=;
 b=dAPkShAeqBK/gTVvET9zJ1JswDIhzeB9z01sxXF+w/HghFRH3wC2Y/MT8282RO22kv
 AKTYKa4+YffumJ8OwNVp0igZC0IkH6Rbvx/fjidMWSajm8SNi64zNo8/fY5K/GV2LJ29
 oobUcCYQ/fUgqAUjCSG5y6GigocEHvMUUtfhvE8HGso06/G3EdMHy7ImVWljVgEFib4G
 kWERVjwe5ZC2lCE/GqiwSYBKLDFQIoAPVK3OmcNY4Vc/nZOPRTT1QfAI4eXIeTFAhUo0
 D3vMNxBstGdFEF+S1musD1SJYEY37TkSpx2kvxhAR+xORpHKA2nxglEuz8CTtLp2kxaH
 yF6Q==
X-Gm-Message-State: AOJu0YwtYskyGuzSKMBN6GN1uWwGj0+inHCpEj/+SrTtqyj3WoWoNSSY
 qUv89BWPYCt26Jq5aJmZRGM=
X-Google-Smtp-Source: AGHT+IGEmCpG0eYtdQIN4nV9wfwL4Bx0wCLKI0R8JSwGLGqES1vqiXY9WmplMzSKKwk3wLcU1PdQPw==
X-Received: by 2002:a05:620a:2886:b0:775:93aa:cb91 with SMTP id
 j6-20020a05620a288600b0077593aacb91mr2147427qkp.35.1699462769617; 
 Wed, 08 Nov 2023 08:59:29 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05620a125300b007676f3859fasm1233774qkl.30.2023.11.08.08.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:59:29 -0800 (PST)
Message-ID: <0f971f33-79ce-a957-dd7d-e1151364e034@gmail.com>
Date: Wed, 8 Nov 2023 11:59:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 6/8] cmd: clk: Use dump function from clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
 <20231105083809.3293-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231105083809.3293-7-ivprusov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/5/23 03:38, Igor Prusov wrote:
> Add another loop to dump additional info from clock providers that
> implement dump operation.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index c7c379d7a6..4b9709d3ff 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   int __weak soc_clk_dump(void)
>   {
>   	struct udevice *dev;
> +	const struct clk_ops *ops;
>   
>   	printf(" Rate               Usecnt      Name\n");
>   	printf("------------------------------------------\n");
> @@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
>   	uclass_foreach_dev_probe(UCLASS_CLK, dev)
>   		show_clks(dev, -1, 0);
>   
> +	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
> +		ops = dev_get_driver_ops(dev);
> +		if (ops && ops->dump) {
> +			printf("\n%s %s:\n", dev->driver->name, dev->name);
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

Reviewed-by: Sean Anderson <seanga2@gmail.com>
