Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EBCC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 11:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B180480FDE;
	Thu, 23 Jul 2026 11:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c16j3IY1C1WG; Thu, 23 Jul 2026 11:25:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E21180FAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784805907;
	bh=i/CEs1HyvxRc5qTQWN+gyhBD02zVVrupI9ucafl72dE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQw0qSQzCvdyFnnlW8PTYixCr38irXHpaZtpizg2IO/sAAfgcSguBlHUXJO49N+lG
	 OCOzdpybph1u7MhRB4stEhwaawREUoK0GD5QsFNRjVK8NSaEbM1LbnG734lriCW8H/
	 TaWkrSqSSrlsdK/7pr9rV/H2JXtycfSb3JMCCla6L2VvLTtQ6MfKZbp9kl2NBRGcG7
	 S3reS+MqK1u3ffI18MTxF6FnEHmbT6MppF5sSaNqO/yTf9B7FVaoKf6wskiJ8L2rZr
	 EBAVavEcAW/3/W9vRpxXnZgdLit77bDU/+9Q5JTzTwfPUTOrj3y1blcPQ+kOtiiSjV
	 otnTnNmzu6C0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E21180FAD;
	Thu, 23 Jul 2026 11:25:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B9E9786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3206E40946
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gfS37z5K2WuL for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 11:25:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D688540944
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D688540944
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D688540944
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:25:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829E88493F; Thu, 23 Jul 2026 13:25:01 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452E8803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 13:24:58 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so449713f8f.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 04:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784805897; x=1785410697;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/CEs1HyvxRc5qTQWN+gyhBD02zVVrupI9ucafl72dE=;
 b=oMDoSScBYPeqUxITj3PI6j5c/SyhCQOfP7cN52ByF21jqwapod8j6BTJMhj1XnPJ0z
 nA2PsXf6dmvTyZzJ12rw/7KcjglG8c4pPNROQvde8gx+zvh7vNIO4zstlG8oT1hhx3SE
 eSsQTzhZemDToMgeiK/2GVlBmDPFtOpA/lTonMNxzYgTnDl+gYRUgnqyYhAGCMDxWA2t
 LSiyEBDJ7wyjWzFdTEbdrxnO/YM/NZYSt97pVYwfB8wPhJc2mHlKbc9Zh0nRzcJlRViF
 3uvCgY3wT2lojCRg3DsyuW2aK/Nb5YaVSITVV0gR7t/8aGPUerTQmml7quW5iI+5pdWF
 MEtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPrNt4CxXahZ9B9/3XDuIiYUzxUcajklZmYCuTY8gDvMVaPxqy96swHM46sgVtlmiOJzQZQKw=@lists.denx.de
X-Gm-Message-State: AOJu0YwdHH3I6AQ6M20aZKJNmuRfHsFkOsjFjkJaFBRQANWSaZdDH83j
 /P2nI3YATxT7jGe5lrojP2cHaPLRgp/Fqxk6hdxhj1e5hNFNswjfbFcPvmDs8hUK/vo=
X-Gm-Gg: AR+sD13zVzcrMB873AzU6nEVxLHZwsziM6RMIjjP7GU6BDOh65WSZPzn4xrhjaHMSOu
 EpdAuIDBRI6M6fn0VG+F4tDNokRnLFUJPfesb4MjQnvSd3qCwCQTytPWLcuQj4+P9qTSLN8zxiD
 NQr48kpTbYhbeb4hWP3wIhdaNypyfeM3DHYBl6+bwTsUNlGdIjoLsG9vK2P6ZRaUWu/M2a/xW2C
 4FNKkei+qPiY/s/O6KvApKYhEZuivMvoAqt3CEr9i4U8ucQJ8uOsel6WlGiYvFFyDGOsFW4cZQc
 crQhVrJ/tGd9+eOim+U4/7OoQzwVU3oTxkGDn7rH5Yyl3nqFJosnUIAu43G8aWDkHm1Pqed676c
 9d2qDurrkBEzG7Nwp6eRYtbovRMz0DY0kI+jGcKpeqPAo+/s+QP+1mSaY+hijHjVUec7m/zfFhE
 UxAu/o/f0cO7qgu90Lx3ircNPGjiZRhdTIuG97GPpVBiA9hZmgIDRgl0h2yDJv6lc=
X-Received: by 2002:a05:6000:2484:b0:47f:8c73:aa7c with SMTP id
 ffacd0b85a97d-47f8d76c5a8mr3463700f8f.52.1784805896719; 
 Thu, 23 Jul 2026 04:24:56 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm15908721f8f.7.2026.07.23.04.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 04:24:55 -0700 (PDT)
Message-ID: <0fe5f1c6-d15e-4f7c-9a95-8b87aa7a644c@linaro.org>
Date: Thu, 23 Jul 2026 13:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] configs: add sm8550_defconfig
To: William Bright <william.bright@imd-tec.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
 <20260723-sm8550-hdk-v2-2-78f0ce2adb3c@imd-tec.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260723-sm8550-hdk-v2-2-78f0ce2adb3c@imd-tec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784805897; x=1785410697; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/CEs1HyvxRc5qTQWN+gyhBD02zVVrupI9ucafl72dE=;
 b=tW+iLl4yClg/3exGiqzM8GSErlVOIKoMU5wPvyDXtdoID9mJgHa0EyEGyJn7wSZ8/R
 SlN7GN+NmaFv7daDxsdjS4hZ6e5bDh2qq1EH/1e6Ugx86PSesQ0ttQ7e/sZpBeNgflks
 KZiB/kHptL5tlGFNZGrhrriVt2iUxS06PAbzzPqUdEgvsVyCkcNa9Pl0/olIT5fcQudy
 qHjnhEfHz3iapVRCjAEVG0xMsDgWQiA0Z4v6/qJvTPAOpg3/C8wGamN+GxynDM7Ljr0u
 lGQlHg0Rnj2Er9LZd6MWpmJFxfD4dna+3FToG5nTh9vPQaOQorRwsKyU195fpF//U4Uf
 BUaQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tW+iLl4y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="tW+iLl4y"; 
 dkim-atps=neutral
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

Hi William,

On 23/07/2026 12:30, William Bright wrote:
> Introduce a defconfig for SM8550 based boards.

Thanks for the respin, this is looking good.
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>  configs/qcom_sm8550_defconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
> new file mode 100644
> index 00000000000..5d2fe13df68
> --- /dev/null
> +++ b/configs/qcom_sm8550_defconfig
> @@ -0,0 +1,20 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of SM8550 dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi_a" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xa9c000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0xaf000000
> +CONFIG_QCOM_GENERATE_MBN=y
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
> +CONFIG_OF_EMBED=y

Do we need OF_EMBED here? By default the .mbn is built from
u-boot-dtb.bin so the DTB is appended is already.

Assuming things work ok with that dropped

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> 

-- 
// Casey (she/her)

