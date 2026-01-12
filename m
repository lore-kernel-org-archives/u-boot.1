Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED4C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252F88393F;
	Mon, 12 Jan 2026 14:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MH36WzG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2200D8397D; Mon, 12 Jan 2026 14:29:01 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235DA8393F
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso9872098a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224538; x=1768829338; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z0/aqoHbio5F1IFiYQRnsrUNNj0aLBFjlxO5KDqAjsA=;
 b=MH36WzG4h2Lit/mgyfTLTcGyumYK4+fZjp7iUkzvXra6PEWC3aR7F1OvGVUwcuo9I2
 +cJYx7J8BM0JTYVEO8iOEP92MSWdGdP6q3x2fznv8JTpRRyAgTt0QPJQX5ze9ySAo4WO
 taPJCkqY9+Oh4jTj23XHXBtmpCgUdZ7qA56P2PirSbsuLT4oCjyzYeYvJ+LTAKh+DZbp
 qCa79uwJHCC+wxVTelVyUWTCb/t5eUA/vuuevHWrFq06EONWpCCQLiq/vN8UVhbHPYgE
 ZrEQNxvsSRsYD4hOZFY6BokGDL7a+dmR6uiv2B4pNySoNoHt1RjUdlWNoooQTlE+aujX
 t1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224538; x=1768829338;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0/aqoHbio5F1IFiYQRnsrUNNj0aLBFjlxO5KDqAjsA=;
 b=bP2qCELanE5+3SMcZy/grLJQd13VlDD9Fwcmu7jFqPrnzGZ+ERfOrbi2DqJ/KvigrB
 2THK63pvxMrMwLHU1qSCfrmlyXowPvIq5dooAVJABJLBiZOz4L+FE61q4kjcbFUt3HqD
 /0N/rm42uV79DaWoYUSZ+7/eZcxNf6xHD4oAWgdWr+ii9hGcuEIAfAs5+p/Q6tzdA+Ba
 uo1CJYCrERJq2gcP5twxgvX0xFTDN++8Nttuses3pu/BOd63U451eGASP1KMUhM3O/cG
 ShDMcwDHD8RtULoOV12FZ7IvUgVuccqLgQlGt2OCIB2N6ogAevmQEGKRT9znLwOcHEXa
 S3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZqFz9mMCaGMICnTSJ4801s2MY9IU5HVhoiJF1QGZZbL5MXrQi4dnQ9okIY7JNArYXsKW5ETI=@lists.denx.de
X-Gm-Message-State: AOJu0YxAX+D5/sUg9RDNFmOC/+SC4gIsMGT7U7P17cfIkTfItInt042b
 xAjzXzUFyG1/nx3rqVRjYYsPQqraLaNyOXLgasFhVWd7LNbRX77BFt6JfrKOCuZwoqg=
X-Gm-Gg: AY/fxX4DBeRot93nuS5f9IKmUPqEeosEXxrNuIQMCEMpHH/UqSXv0f5Sy7bttkp9Px5
 X1G3LuIQi1kKHZPW1Op38diKqivR24dx3GMh6yq6UVPOCu5XT5E3JyQWbwEbSA3zhWPEUN3z+zJ
 YlEnPSLsT7jA9z6p5Ecprxvv7Gwj/yvh0Y8m3QiWrCD6qZYyijO4YraP1HVp3U/c1qjpKFzogXU
 fOi8LA90myJ1sNQLSILXisF69qVXhWohfQ9UfpLkN8xMTAvlXVL9c0RnUV0Mkp3jZ5lflQ+Xu75
 CHavH0MJgRN4DgMMLJ27BPJ296aroVVnQx2b2198Eupay88LnJuL+EqlEgaqvakCO6WDnINfJqy
 YtVXEeQsKh3h9chZBhmyNplrcJMK5ERPNoKEQvhzYhdDbBfdXAeR7D7Vc0blE0IrtgiQh+NcuRm
 MM92qOqPsiuFeLt4TSgBnvDPcpV+N1r3jfpYlDHIQWg86X9p9tGVc=
X-Google-Smtp-Source: AGHT+IHSFrnh7dcYO867GdFEXPo8p7E2tfl9ESXgpnCM1kQ6BNJJWEyCzZSyuw+QqKBTIiIUlCBoiw==
X-Received: by 2002:a05:6402:84e:b0:650:5d7e:8a29 with SMTP id
 4fb4d7f45d1cf-65097e75991mr16296781a12.32.1768224538483; 
 Mon, 12 Jan 2026 05:28:58 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6648fsm17573377a12.28.2026.01.12.05.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:28:57 -0800 (PST)
Message-ID: <af3104e0-6658-4ef0-9a27-ea51d6f9102c@linaro.org>
Date: Mon, 12 Jan 2026 14:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-3-quic_varada@quicinc.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613051957.3159564-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 13/06/2025 07:19, Varadarajan Narayanan wrote:
> Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> to receive arguments given to the 'reset' command. Process the
> request_arg() op before the usual request() op.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> v4: Fix compiler warnings -> s/const char *argv/char * const argv/
> ---
>  drivers/sysreset/sysreset-uclass.c | 32 ++++++++++++++++++++++++++++++
>  include/sysreset.h                 | 18 +++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 536ac727142..6eb090a37aa 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -32,6 +32,16 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return ops->request(dev, type);
>  }
>  
> +int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
> +{
> +	struct sysreset_ops *ops = sysreset_get_ops(dev);
> +
> +	if (!ops->request_arg)
> +		return -ENOSYS;
> +
> +	return ops->request_arg(dev, argc, argv);
> +}
> +
>  int sysreset_get_status(struct udevice *dev, char *buf, int size)
>  {
>  	struct sysreset_ops *ops = sysreset_get_ops(dev);
> @@ -71,6 +81,24 @@ int sysreset_walk(enum sysreset_t type)
>  	return ret;
>  }
>  
> +int sysreset_walk_arg(int argc, char * const argv[])
> +{
> +	struct udevice *dev;
> +	int ret = -ENOSYS;
> +
> +	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
> +		for (uclass_first_device(UCLASS_SYSRESET, &dev);
> +		     dev;
> +		     uclass_next_device(&dev)) {
> +			ret = sysreset_request_arg(dev, argc, argv);
> +			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int sysreset_get_last_walk(void)
>  {
>  	struct udevice *dev;
> @@ -132,6 +160,10 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	printf("resetting ...\n");
>  	mdelay(100);
>  
> +	if (argc > 1)
> +		if (sysreset_walk_arg(argc, argv) == -EINPROGRESS)
> +			return 0;
> +
>  	sysreset_walk_halt(reset_type);
>  
>  	return 0;
> diff --git a/include/sysreset.h b/include/sysreset.h
> index ff20abdeed3..d1cc9ebc542 100644
> --- a/include/sysreset.h
> +++ b/include/sysreset.h
> @@ -43,6 +43,24 @@ struct sysreset_ops {
>  	 * (in which case this method will not actually return)
>  	 */
>  	int (*request)(struct udevice *dev, enum sysreset_t type);
> +
> +	/**
> +	 * @request_arg: Reset handler implementations that might need to process
> +	 *		 arguments given to the 'reset' command.
> +	 *
> +	 * Note that this function may return before the reset takes effect.
> +	 *
> +	 * @dev:	Device to be used for system reset
> +	 * @argc:	No. of items in @argv
> +	 * @argv:	Arguments given to 'reset' command
> +	 * Return:
> +	 * -EINPROGRESS		if the reset has started and will complete soon
> +	 * -EPROTONOSUPPORT	if not supported by this device
> +	 * 0			if the reset has already happened
> +	 * (in which case this method will not actually return)
> +	 */
> +	int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
> +
>  	/**
>  	 * @get_status:	get printable reset status information
>  	 *

-- 
// Casey (she/her)

