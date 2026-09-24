Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2B7C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 11:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2968181C26;
	Thu, 24 Sep 2026 11:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id St143TWCL1gC; Thu, 24 Sep 2026 11:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4DE8481ABA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790250364;
	b=Yf7cGVVOx5XQuf7XV2I1ljj+RcuoaHvV9P/8jmI7VvGZPg6hjLnXio4FQLyKeUuZZfWh
	 wu9Q/2oKyS2pwARmwNRnRLl046z3ZBp73SDnUIjw+fucgs2w1CQyKGmbUII1A+/g+ylv+
	 5yKOv9kn4+Wks4sDU65I0AgMQzDkKpX/VnF3c7umCijtmtR+l3Pv9ddP/iUkyIMA4Rob3
	 DTWw23E1Nmf9rhDhChPzu5AJEIQzrJrov/ran+LI9euIYTszaunFKZfefI7CuJ/mdf3LM
	 RJ+06HhHsiT+DO4ZcWmur4t3DA/usU4uVjxp1ANhXpyKmRI1DE9gjx4tImBe6HerJqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790250364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kzriZ6FOy4e+sAfsnswN71q0sAPA2IC+c1LvMxAboVw=;
	b=RceEbOxeZSmjUP3tapk5sj9pme7Glzu8b/EslhzKLObV9HoMk6JLw8wpGMZA+f/dhgjI
	 CpgEV1CwD44nh/dJA8njxfLGlkpSfb6i2+cKyEw84g9/n1Y+DhwPPnv/wpvY9s+SH/PB5
	 NzNwLpERyG5OAERpZyqktJS7bhsG3G8PVaOQhaAYe4TxDrAFvXRHugG9wG+haNhVF7Pk6
	 RULUuSjPWa+5U4CU2U7N2afopeheXsJ39ZKl8jMbd0br4+kwhGS2/m1k0nNiKP+G2KzDA
	 wWqjgphkVX6tFarpPUaZhJQ+Yd8HLfJJrn/1HvBjmKzzLzcBYJKrz8kpN7UqWtKnMzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790250364;
	bh=kzriZ6FOy4e+sAfsnswN71q0sAPA2IC+c1LvMxAboVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBpDivJiElLB26HO6Lbthkzs9b6ubxyi9AKyglQAWw4XFpxQf8piFYU4ZA3MWFGd1
	 85BE/Pn/+dGhOdlT5BwQ4gnRxT/SN5vAc79HwI6OOS7eEnuwBM6PmOBTQGL5We6fi+
	 LosXwccgj7HdQseBcrxcuzufOx6lJyGM70RkKQC8Yv2Uwj44WbwDwdSyLU6+fSbFLa
	 4jbo6o3yQKX8J36mI33XHagXxLlUoTfJaDdNgEpjKW+PCdRpWQ3PL+23fKl/2HZ69n
	 LZJJ7q8818s9+tahCaDBfdpeX33ty3yian8g9duzv8mT9X37RDIietG2WoIicHjinv
	 NRhgHj5n1b5GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DE8481ABA;
	Thu, 24 Sep 2026 11:46:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 089F61DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E234440C99
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPhWM6x7_aCE for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 11:46:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 92D3940BC0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790250362;
 b=gt/9LB5aANaup7fmRO1kc2XFQ1N5OTLkmMN2Ftn/gm9+sgworAiJW7Ova+tpWH1qNLBh
 4bNGkjP+ezrqIq8rDc9ZZrTxZ5oCABoS13jK3kI84Bqv58YtAM3MZXHy/Jl6WIGgesSVq
 Jb4MLM1sfgg67FX0ldNpYMfLHlbTBDYeiwlOREX7BxKi73JtTkI/YJbGmsmTraHSasOnQ
 8/g8RIMZe1jtKnoCUuGovOj+0LXe30cnreFItB3Vx1shp3ecQbXhxd3H+uSyHV3IXGPeF
 oRXuJH2v6m+eb8RwEEoBDLFysNMdyWA6D2o4l8GyysI0IotyDNzEmXIcy5Gf9Nf7baA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790250362;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=kzriZ6FOy4e+sAfsnswN71q0sAPA2IC+c1LvMxAboVw=;
 b=l3AMs/5N9w6Q19DBWZ/zBqbU8K3wbHKaenxzelWAuTC4lYyrCLe7GOu55quJ5ruIeAtf
 GHfCs2uNEbM4tYR4aABhkqTtA04AmUE7maNmqkLmLpqvNxi0AsssvRmm5ukqTLR0gg8W6
 zH9mTncunvRVW+ldbeIw1AeAzUaaraHfxX9PMTXKkPPH8f9pnumSOpyJl5UDbQwNEoGk4
 YNSmh7yqMze2O5amhP8SCgp/HxOmPp3nxYduECLFYxeCMm5FR5gP966j2NRrvH1LIM+m8
 WzmPaWPyxNTtBdvddWub+bb9YPDHGPjI7fbDKGw2wpUa0N4z36/wK9Gly1y0Sng31iA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qRmkqDep; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qRmkqDep
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92D3940BC0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:46:01 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so1173116f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790250359; x=1790855159;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kzriZ6FOy4e+sAfsnswN71q0sAPA2IC+c1LvMxAboVw=;
 b=qRmkqDephp6FWDN+WlM5ZYG34e6IhuP0bArsmNpGzpVqMIyHOPLFqgHcIlxXbGAV1H
 kTSLZyTmF2RKi7OzmDPf9ugCfl4ewzuI7uDzmOd0Fbv7zGSGet7FU5dOCKQk66TRGJdc
 FzZMUNuhaHCSe9ujA6I8FT0THDidPSnR4tLCyqcL3Xs3VYHe/1AcslkRNm51aNw4gXtL
 Ysvpg6VadYS0SKclXG5H68eV3NobVgYeiUxcZfwtpiPi+RA0c6PtOa6p8OqtJVe0F8OE
 3Ais0sHI95b0uHu0pcd2QoDLeqLgnfW/t670CwN9SQ6XYvITnBgrTFx9MY00lImIvQrw
 RrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250359; x=1790855159;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kzriZ6FOy4e+sAfsnswN71q0sAPA2IC+c1LvMxAboVw=;
 b=EIuhjB4KBh/fN+fK6mIJudMx4O+qf82pSe87ZQr9EOWWrVIUVYxOrPuPQgFBM/Qhux
 07DfE4TwcFw/CzRucXYxg1WTNf1BjGBl//qjtNE0gGe7vaZfDBeMMp6mjoB78GrKo+HG
 Z4m4yY2rAkvZ/OHloS3GXY5gMlWKRtf1SdRxoFkUBOauhVQY3GHA2/ZjIrNgFbQrcIPG
 vJgtBjORW4Ux+9v0G1q+nwHAYzr6ZTrIy9TIH/298nG8R85dSdDHcjxXEQkYdomUWiGE
 oYJ2DocNMV/SWRr1vay3U5YV3MOnP0CAv/czPcMRPlPK+/1dM07rveCgYkPAo0akCrZr
 hHNA==
X-Forwarded-Encrypted: i=1;
 AKwUvByv5/mYg4X69uWTwq2FIN/dY4wXa1qa0SmdxRTbYbYZ2ldxJGqRzKW+w7swA+ve+T6X31LHevY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lzw/GikDK88HuU3RLHrpCx9Pqg1I9118Y0tRcTbG/XALFyl+Oy
 a4c5/HfXPyoST2e0tlwh3BxGG2Jj5R5eEP4KcUW3idr3J+AfGdXNcNqhCSB5pCFbdJg=
X-Gm-Gg: AYBFou3b7wDgSKd3jf6PaWGeQtAoZHbXu4zu3qxb6+p3tfQRu6jav3+1x3Ynd+IO2jP
 ePXEXACvjR0yOEZU8kCg/xHBk5nNoZ91JGUFRLAUMG8oP/sRzwdLCbdClu0AnuE73+rXfVQlLMW
 +oa9qgDg6cV3Vdx+RxQZzbRmjvprYUkhKqWIQDbMjvf101+jyK5Gyx1XrFzvMHUs2nArjYXDyEB
 e7C2S4qcmKFCLOE+zEApJsp7/r6mEU86rY3W9oGEBtLD9WpOTuf+fr48xXx7/qLqUZhLuUFDO9x
 +zjZm9vPVxHk5CIVNxM+GOL0vEqbxN6Lwyg/RIRMyCZiogWzk6dtftmB5jLRDSkLVhnBEsUy22k
 xqcy033IvT0syfoQk/e0bO5dyP3I9TzPKpvDHMPUWNqLb6lKnbSGVpfIuRh3pBVv/VoFRWypejK
 UTyDfafIAaFFahZN4JaUAsFpHIBfF9cQ+jMiEkonVSOTAFfMmhBhCoOPdTjCfge8jP/evJUA4lY
 xpXV7U/PnQ=
X-Received: by 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49fe66fb4a7mr34002135e9.26.1790250359072; 
 Thu, 24 Sep 2026 04:45:59 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4054fsm107336365e9.3.2026.09.24.04.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 04:45:56 -0700 (PDT)
Message-ID: <dac4d9b5-1eb3-4c08-b3c5-dcb55252fccd@linaro.org>
Date: Thu, 24 Sep 2026 13:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] misc: qcom_geni: implement
 fastboot_oem_spi_nor_reinit()
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peter Robinson <pbrobinson@gmail.com>
References: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
 <20260918-series3-oem-spi-nor-init-v1-2-319dfeed6c2c@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260918-series3-oem-spi-nor-init-v1-2-319dfeed6c2c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/18/26 07:22, Vandhiadevan Karunamoorthy wrote:
> qcom_geni_fw_initialise() runs once, at EVT_LAST_STAGE_INIT, and reads
> GENI SE firmware from a dedicated storage partition into memory for
> its children to pick up during their own probe(). If that partition
> does not exist yet at that point (e.g. first boot, before fastboot has
> flashed it), it finds nothing to load and does not retry later. A
> later SPI-NOR probe cannot recover from that on its own, since the
> SPI driver's probe() only re-reads firmware already cached by
> qcom_geni_fw_initialise(); it does not re-read storage itself.
> 
> Override the fastboot_oem_spi_nor_reinit() hook to re-run
> qcom_geni_fw_initialise(), so that "fastboot oem spi-nor-init" can
> pick up firmware that has been flashed since boot before probing
> the SPI-NOR device.

Rather than adding yet another opaque "call a magic function" API, could 
we instead fire an event when a block device appears, passing in it's 
partition info.

Maybe I'm missing something else here, but why don't you just reset the 
board after flashing the qupv3 fw for the first time??

Thanks and regards,
> 
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
>   drivers/misc/qcom_geni.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..d14d74e4216 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -13,6 +13,7 @@
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
>   #include <elf.h>
> +#include <fastboot.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> @@ -565,6 +566,20 @@ static int qcom_geni_fw_initialise(void)
>   
>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
>   
> +/*
> + * qcom_geni_fw_initialise() only runs once, at EVT_LAST_STAGE_INIT. If the
> + * firmware partition does not exist yet at that point (e.g. first boot,
> + * before fastboot has flashed it), it silently finds nothing to load. A
> + * later SPI-NOR probe cannot recover from that on its own, since its
> + * probe() only re-reads firmware already cached by qcom_geni_fw_initialise();
> + * it does not re-read storage. Re-running it here lets the SPI-NOR device
> + * pick up firmware that has since been flashed.
> + */
> +int fastboot_oem_spi_nor_reinit(void)
> +{
> +	return qcom_geni_fw_initialise();
> +}
> +
>   static const struct udevice_id geni_ids[] = {
>   	{ .compatible = "qcom,geni-se-qup" },
>   	{}
> 

