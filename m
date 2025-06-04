Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE9C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 11:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2196082977;
	Wed,  4 Jun 2025 13:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yReUuy14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB7A82B07; Wed,  4 Jun 2025 13:26:42 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33FC81FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 13:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cf2291bbso25556535e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749036399; x=1749641199; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUBONtY6QU1IVj3fkN04Eya+PMwxln2IxTqS8IoYkTM=;
 b=yReUuy1458h8DPChR5EXMwOKhJ4HxHSmtOgC6pljSQtShgRzrk7ApnlCcw04fYkqdL
 AIcg11vyfS9OSs92Yn8WPqdn/8Yzxgg7hclzTxvGDKMoRWlTTvo2Aptx76QOcB8XITtb
 eFM4Q8Cyn7F1Y89xchnZOJsorrx/QTY5oMSeG9qa4l94obTTFegZ1YaKbl33tIc77xiM
 zZIQiKdTaxnQRbsJ2MuJmRR3T7w7uXHfu2ClvhqliGYdoiPvVorRYWCjNXPa9W9bYvyO
 oVKNTpENcM90Kf4Oy5DTzRFfdtXiBNzED+Br7+YTQjyvw3bgC4EAY3er2t40UAiYBHO1
 xGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749036399; x=1749641199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUBONtY6QU1IVj3fkN04Eya+PMwxln2IxTqS8IoYkTM=;
 b=rsE0RXyFtdKG+GcoMDbF2Z+T/jNtbsBijgfwF5JE3fkfcOaxhfzEdoXtt6ToLfIMDW
 p6rTtE8dF8dCPkCUHohB6pJddTpz/1RoAEaseD6tyIFwYM4Rwnr6k1mumHJdkfFR7dyZ
 LT6D7ieBN2i2sme3vf/aIq0kep37qJoyq33JQPaiQeCRDvOuyKWbl6xJ2i8Lce9ccVFd
 U8VgMnqjGLv8zzC7SNQM0CIVjwW+qCjqwQFlff5sEhmv44xHMfbU/bhrj6VNamsw/MtN
 zwJmWyH14otLoZ9i9aGcFEvgkRUdp9lqdUVm50FRGxxIKS3vGh9MYpfN/wpxP+/wFteb
 kzRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUqfGznqpY6ffon+iFBLSrPQJqcj+M3hdN1q8cWNylsB/b0UjA3WXrCcvS3IMil7w9wMncGJc=@lists.denx.de
X-Gm-Message-State: AOJu0YxrMsnkp8FdUqdE+eeh/XGoxOxRlh3kFbq7b8j63vdcIFuuMJcL
 f7vtmkfpBzHSMRoEArzPLKy8Wz/wWl1/hb50g13hkHbnCv6pNbb5tKdQc+jIMG89QCg=
X-Gm-Gg: ASbGnctq7dS6NgfK1Cvsox5oX6o4e4xzRwdopoBcRU2oLFwdB+4B6tlkvH+nmCKScU8
 S6QWvi9U9gFjT/KI0yXhoQw8rodvUWqlLwwBpYS5BtuHKm6y0mGAi8clk0hCwHG/C8ud870Gcga
 2mufKu+nqN24V/RNzeo9qO4dXsZHoCgsxpsrfND5j1SAyDFUnZU0Ea/XGRtpRP8++FFW5kWmmtf
 HBmUM50PSyVf7Czb/cD/ENSdvizBnfP0GLX7BNgK4+TyweEg4v/ptGwZoInzeTAJxte4HY494B5
 u61Sl1MFvove8sBRWdYsAEWL+iZSu1WKqVY+p8+PsEuAxNArMzSIopxiLvmkTRUZkZhAL/yGZnG
 9aCelyKYLcHzMCMAyiXOO/QISCA==
X-Google-Smtp-Source: AGHT+IEWOV3GE7U2vNY8/9ii5qkWYJzoE0Jo/NT50f0Pt375Q4DnJvnBWmwJkWKD4R1xwyRAN5n/JQ==
X-Received: by 2002:a05:600c:4ec6:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-451f0a64cbfmr21357125e9.3.1749036399258; 
 Wed, 04 Jun 2025 04:26:39 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451ef77b467sm27962295e9.36.2025.06.04.04.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:26:38 -0700 (PDT)
Message-ID: <e783bc61-cbf5-447e-b6cc-d35c5f050dfe@linaro.org>
Date: Wed, 4 Jun 2025 13:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Introduce support for QCS615 SoC based Platform
To: Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, sughosh.ganu@linaro.org, sjg@chromium.org,
 lehmanju@devpi.de, bhupesh.linux@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
 <e6bd9135-3ab2-4eef-81c2-f08f1197247b@linaro.org>
 <20250603192206.GK1382132@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250603192206.GK1382132@bill-the-cat>
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



On 6/3/25 21:22, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 06:25:22PM +0200, Casey Connolly wrote:
>> Hi Aswin, Varadaraja,
>>
>> Since we're expecting to do some more cleanup after adding all these
>> dragonwing platforms, would you be up for adding MAINTAINERS entries for
>> them? This way you'll actually get emails when there are changes affecting
>> them.
>>
>> My suggestion would be to add a MAINTAINERS file inside board/qualcomm with
>> something like the following:
>>
>> QUALCOMM DRAGONWING QCS615
>> M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> R:	Varadarajan Narayanan <quic_varada@quicinc.com>
>> S:	Maintained
>> F:	arch/arm/dts/qcs615-ride-u-boot.dtsi
>> F:	configs/qcom_qcs615_defconfig
>> F:	drivers/clk/qcom/clock-qcs615.c
>>
>> And repeat for each platform, set the maintainers and reviewers entries as
>> you see fit.
> 
> Note that if "dragonwing" is also "qcs615" you can do:
> N:	qcs615
> 
> And it will catch all files with qcs615 in the filename.

ah yeah the wildcard probably makes more sense.

Dragonwing is I think the QCS6490, QCS615, QCS8300 and at least one 
other platform...>
-- 
Casey (she/they)

