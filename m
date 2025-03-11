Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4632FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD25680805;
	Tue, 11 Mar 2025 10:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rPXvyq0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF8780FB9; Tue, 11 Mar 2025 10:52:30 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB90A807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so30843115e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741686747; x=1742291547; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRyxneamp8xTe+PrV6Rhjs4vVcJJs00f8B7oMQ/nQF8=;
 b=rPXvyq0R9ZlrWbsn8/JAGnsKHUx1RBm9E+Qy1o08RGzk411ttVq7xRcNbj5YK1JGy3
 FSk2cDGl7pYwAJCMKV9lwadGmCFXFCJHkIDWiqRPVykA0cjZ2lViV2uwyvnNepxpYmgA
 ge70oHmcWhci7cpSotZuxXjk+XHNtLC6IG5dsa4rgSum2HCnLmURl/p3K2hoSkjeXJ9h
 GJ0sYSm71WmElMCenIonrh8iG516yv8bon56xG/IPlKduazo9DJ1yc9U+htJ839wV38p
 b/HwbvoY4iZwXzwv8GLocSzIA9Fjyj5XbnaPPge2shj/1F7DZm6Wi/4P8BkOLRfd7kfA
 VNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741686747; x=1742291547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRyxneamp8xTe+PrV6Rhjs4vVcJJs00f8B7oMQ/nQF8=;
 b=Nd4FQy1xQ/eWE7TBClj/rbSUvMl/QflAPCU/Vggu0wodJaay+DML10/qgewhB3ELh+
 hU1EtgEUP5epr9O/qHA0aDmzrNHZeuWZH033lGS94ddqBy7Pb+MUFjqa7z2lkalLfhDg
 +U8BZQ5JzU+wv9dMroaWcf4BoVCk7F0hCez/rjqAPf0Lg/ND782AEM6V5YID2BgN3fzm
 3paYXYYCETmK6e4M9fd4xBa7/Ohk8mLnqS0pELYbhkVkDBnHitoSNiWfqH9yYXDVVOTQ
 3olGXxMv9/0q1FTFgGgZVL/nG6vJ856i5CIc7RiX1w9qw+33kNuCR5+zrXH4SCv8XoMx
 x+ww==
X-Gm-Message-State: AOJu0YyiUNpH5YZWdE3DwKjyyHavtjePXJpBY0Z5Qnylpgj592VP80l+
 fxQw614nk4Zqvt2a3QpGZ6kQmO7FSpHSE163zfJlcZ+X2aqf5MVC6U2mMWd+rzD13llGiCilLR4
 6u0QILQ==
X-Gm-Gg: ASbGncvd99GpVrPIlH2wUzWdz0aEQ56lZbQqBlqtDWWeu/9B0ppF/s14RwDnNhr+zR6
 RtEXDqfJhw/Z7bT9gf9TGepf/caVK+z4H2iIGtCb588Gr1w0X7oRsL1n9O21jfwQlnQfcX2ogwV
 dvJph+dBLuJNIjZxT8gTIAk+kyeeEhrkQXQQzNBUp9okDM8qf0p14RVZjIoeKPHXNmo9dHlEpO/
 BqyAVkeSQtIShrvWrrrwoTQHyiLPauYb/sk6djohEUl6NF0jkYReAhYZtGGn5kdUNFwzUdKeA0k
 gVmWdPJ+DCe0pkezWgCyXUVxHC8+41GGV5W9Z84ZV6j/GuTrhbWgdUI/Kg==
X-Google-Smtp-Source: AGHT+IF/dIl+ux6nx0k/hzvr0aax5k1nuBDDW1ChbW3ukhmY132LRQNhuNc69VsT62Kzn31BSsJz7w==
X-Received: by 2002:a05:600c:4f4d:b0:43c:fd1b:d6d6 with SMTP id
 5b1f17b1804b1-43d01c2e299mr38822425e9.31.1741686747212; 
 Tue, 11 Mar 2025 02:52:27 -0700 (PDT)
Received: from [192.168.7.94] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm122466185e9.12.2025.03.11.02.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 02:52:26 -0700 (PDT)
Message-ID: <55f4e35d-dc4c-47c0-9a55-68ba3ae16050@linaro.org>
Date: Tue, 11 Mar 2025 10:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: Kconfig: Fix submenu for network commands
To: Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250307151531.12092-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250307151531.12092-1-paul.barker.ct@bp.renesas.com>
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



On 3/7/25 16:15, Paul Barker wrote:
> The Kconfig parser seems to get confused by the current if conditions
> following CMD_NET and displays all network command options directly in
> the "Command line interface" menu instead of in a "Network commands"
> submenu.
> 
> To help out Kconfig we can simplify the if conditions, so that the
> definition of CMD_NET is followed immediately by an if/endif block that
> contains all network command options. We can also remove nested checks
> for CMD_NET or (NET || NET_LWIP).
> 
> Fixes: 98ad145db61a ("net: lwip: add DHCP support and dhcp commmand")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  cmd/Kconfig | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks for the cleanup!

-- 
Jerome
