Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF6C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0714C88A74;
	Thu,  8 Aug 2024 15:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xNUh7s1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718A688A74; Thu,  8 Aug 2024 15:01:16 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF9888413
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so123529966b.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723122073; x=1723726873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3qga7jxlVCdCA1cuE85fVLOFQK1W8CyeOQnKmV65Mo=;
 b=xNUh7s1Vylb+PWgu7A3ySE9z/FVul6yRTYI+rM+8F2jtsMOnD2CO66LgLw3UxIA/9X
 tUpg1vOc3yLWIFR8drQW+QlY4l5vklwFwccF0XaAA3g+7BTIbQO4KJA2BGc8TanvTYzb
 6AtOZeiwtFYTV+JDbNTAB6ELHiigEr2m2BEF6xyklMpYmFN7IIpogBF2Cv4xPMD9XTwD
 aEFgJ2SXQvX+4+M4zE/ar4IJZOG5syEt/4APytdmrRQGWyYLuIdB5np88OF+MtikVvZr
 c54cYYw4+3qInOeX6jobC1lbx0PBSb8VSQxIzEuuvquENO1tReM9XkhNCKQkO/d+3f0x
 JlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723122073; x=1723726873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3qga7jxlVCdCA1cuE85fVLOFQK1W8CyeOQnKmV65Mo=;
 b=GO16pBdR1m4YMdeQHuG2CupfRy8JK/GvBPZivxx0qaqJUstzEEf40SGkYQ52Mf3SGj
 5563vqtJKztbK11sHGZQjFBaMUxCSPmqd6zn7Yzq+cEzegHHPnGINaKT7yBbAx3rm2QZ
 xRy48WObYvxmhIK6QumzL83Ub8Ur/VrLgcF3Eubsh1vqxPIrfzT+TXbb0vxXsAZeI5WA
 yQdGsIREoRRchuHkLTLFs+LFjJ+GrBg43rR0F8r7AtFhZm5hXuGnd9vuoKgPQgbNlJRZ
 XyYT+EogUIYdvAzyki39eMrhtzQRdcriqQftaLBiw8N1bDepAzOdIN0KO9I8ajlxruM3
 9ClQ==
X-Gm-Message-State: AOJu0YwBxh2HMpIYuQwZGetCP7ySmfJLcF7rUD73Fsll5unCsVfA7K5h
 Pr7xyz8FHyOzDWj8YQRKJ6aeXXpwtn4bcBi7vM8RKDMVHT8Ii6uVI7LfrI48gj0=
X-Google-Smtp-Source: AGHT+IFBFkTjEv2dNW3hMc64ESCndrmRkHQTBN2TAySOBvTb7LB6mUQl6Ct5uew0zVubiQVjbEtzrw==
X-Received: by 2002:a17:907:94d6:b0:a7d:a2cc:5d9 with SMTP id
 a640c23a62f3a-a8090f0c49amr127417066b.65.1723122073365; 
 Thu, 08 Aug 2024 06:01:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0cb9esm736924266b.78.2024.08.08.06.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 06:01:12 -0700 (PDT)
Message-ID: <f94ee165-105e-4959-9cfa-b6baac3d5064@linaro.org>
Date: Thu, 8 Aug 2024 15:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/23] net: fec_mxc_init(): do not ignore return status
 of fec_open()
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <38486335f3ec7990124f0224108a967641f7dca7.1723050310.git.jerome.forissier@linaro.org>
 <CAOMZO5AM6Mteg+c8MgT4u9mboef=FdqTjTxhVDn7_QWVg2=WWw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAOMZO5AM6Mteg+c8MgT4u9mboef=FdqTjTxhVDn7_QWVg2=WWw@mail.gmail.com>
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

On 8/7/24 20:05, Fabio Estevam wrote:
> On Wed, Aug 7, 2024 at 2:51 PM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> The fec_mxc_init() function currently always returns 0. This does not
>> allow the callers to detect when for instance the PHY initialization
>> failed due to the port being unconnected. Fix that by returning the
>> status of fec_open().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
