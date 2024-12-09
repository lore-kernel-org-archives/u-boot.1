Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E87E77181
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD038950F;
	Mon,  9 Dec 2024 16:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RI4jdcLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E04D89367; Mon,  9 Dec 2024 16:04:54 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7D688965
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso887191466b.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733756691; x=1734361491; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhUe74D0PJ5orDGhK87RErd6bsDroR6Wf1xbDRHY2PM=;
 b=RI4jdcLkK43XpRSUDbRX9fhAvUOoHqKaGuDg/dHxu45q5YO3P8EGEduk0/KH3HQ/jn
 1n8eHvFD60hpGOZVyhGaMc9IcYzZfXvO3PnklinAtW4tu3d7hUj9WPF2Kyct1wdPpGvN
 0BpoqClzNcyf/I6ga7myhlV1OmE7mE6p7ZBKOKgjqhU+T98PILeMd5DInvNen4msImHp
 AVpGuXM2yNAE48Ri4Kj95Qe35oq/FtMSvnEjCCEndX5z0bLZTZYzoUSKGup/ON/s1Eh1
 cOzqy5G64EYPTNDNk6eZ7DYNSCQci5USMWNkPp2CU+9XCyESa0q/RLLbSaAD82NgcOU2
 t71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756691; x=1734361491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhUe74D0PJ5orDGhK87RErd6bsDroR6Wf1xbDRHY2PM=;
 b=bsZM33ksUHT7CusxayzhphV/6iYSZz2LZjFGGvw0kmsxheVVYCBqUavUj4IyA6UtPk
 NBkw5QWJ/5FuMq4q27lcw9J9HU5fL8O+XnsED4Hw93g4OY7k8Q2JKupo+6/TLis2zUR0
 Ju9mfXA+1uUdDIdAR5ZgwfSDa6de4ABzuCJT6SPSkcca+zOEyP0lAx6wQ/BW7PLA+2sv
 A+u4YGU+CK4OllPiQ60WIDqeE3d0ktjBVYOTbNsyIKe41wjH6jkRkn1Lxc2Cc/5hy8en
 dAg1QDakptJRK2t57Z/KULScFM3pF0cxbnIhmMljuGbNsoGGgJuxnQau66F/zZMrqep8
 fxEg==
X-Gm-Message-State: AOJu0YwBooqzbOPjiGBoldv0ca/VrCFOC2hz+T2EXGuL4c6zxiXK3Uxg
 IHTlumO/mYBSJp//44J4oy8L4j2zVuhzO7Tc5gRPOvGnOU/Psl+r4L6ZP0aozzQuXePB1oI0JAJ
 bLQE=
X-Gm-Gg: ASbGncsSe4IPmb08Pophd8erUqUNUhpapNwX1DjbN5W+qV/TmLZBaFiiuB1BW/5vfLR
 V7Yhe89LBcQsKLv85fy9n/E1eUahHUnbjqV2e54bABwmmac73ZpYx2luU5cuxYJY4dWEcyCVbxl
 Lb8Rz9mRJpnnZu0pQQvAVPVd/tWW11lLm+e29AukUfEpYpPnInLUiyW1rMSGS0d9SNSHmQzz96q
 b3SAItppLVWQ1e11pK9lfIo622jvRD4IdTCyBPsp3cSYM38xw1qlZbderQIDmF+b9sXNJfGVc5s
 W0tRW9Tibu82rMO8uXqSB10tULUqDmpp
X-Google-Smtp-Source: AGHT+IGVe/9l810u47GjTTGBiqAgdc827bYlmDiR+/Hb+osttkp054YyyfZwhjZ5KLcJCIUsW+4t1Q==
X-Received: by 2002:a17:906:308d:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-aa69ce32f01mr82607966b.54.1733756691167; 
 Mon, 09 Dec 2024 07:04:51 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa69738cc14sm78643766b.105.2024.12.09.07.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 07:04:50 -0800 (PST)
Message-ID: <3367bf91-1715-416b-b6d9-751f385971d4@linaro.org>
Date: Mon, 9 Dec 2024 16:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cmd: Allow building ufetch without CONFIG_BLK
Content-Language: en-US
To: j.ne@posteo.net, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-2-df861318bd49@posteo.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241205-ufetch-v1-2-df861318bd49@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The ufetch command is still quite useful on systems without block
> device support; remove the CONFIG_BLK dependency and make sure the code
> compiles/works with and without CONFIG_BLK.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Small nit below, but with that:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  cmd/Kconfig  |  1 -
>  cmd/ufetch.c | 10 +++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4936a70f3ef16ddb093ceafa12d011ca1b89e95c..547fd2a91f7883e2ae5982897ec93c4483d67852 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -178,7 +178,6 @@ config CMD_CPU
>  
>  config CMD_UFETCH
>  	bool "U-Boot fetch"
> -	depends on BLK
>  	help
>  	  Fetch utility for U-Boot (akin to neofetch). Prints information
>  	  about U-Boot and the board it is running on in a pleasing format.
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 5f3ef847b268dc384271fc6774720e5fd2337157..7aed0b447bda104b837d37c6adcbb21b80237aba 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -92,11 +92,9 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  	int num_lines = max((size_t)LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>  	const char *model, *compatible;
>  	char *ipaddr;
> -	int n_cmds, n_cpus = 0, ret, compatlen;
> +	int n_cmds, n_cpus = 0, compatlen;
>  	size_t size;
>  	ofnode np;
> -	struct udevice *dev;
> -	struct blk_desc *desc;
>  	bool skip_ascii = false;
>  
>  	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> @@ -200,6 +198,11 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  			break;
>  		case STORAGE:
>  		default:
> +#ifdef CONFIG_BLK
> +			struct udevice *dev;

At least without the #ifdef, I see a warning "A label followed by a
declaration is a C23 extension". So to be on the safe side please put
this section in a block:

		default: {

...

		}

Kind regards,

> +			struct blk_desc *desc;
> +			int ret;
> +
>  			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
>  			if (!ret && dev) {
>  				desc = dev_get_uclass_plat(dev);
> @@ -213,6 +216,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  			} else if (ret == -ENODEV && (skip_ascii || line > ARRAY_SIZE(logo_lines))) {
>  				break;
>  			}
> +#endif
>  			printf("\n");
>  		}
>  	}
> 

-- 
// Caleb (they/them)

