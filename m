Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903F8C982DE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9ADC8309A;
	Fri, 16 Jan 2026 18:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BTbd2HdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4092D833C6; Fri, 16 Jan 2026 18:54:08 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16FF82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b876798b97eso387097166b.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586045; x=1769190845; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEtJfG/C2hd2ZLJd+8mQgLjLLyAUmWrjQu/r35Q88dk=;
 b=BTbd2HdT5FMrKrlUomGS1pjRP6PNBbmGEfCn4nCSbugXvewT51KGLgsoHcAKp8Xo45
 TTlge0NKSjGp4GZ/unRtNUqtQyD3pLkT8JxRjepPr7PNOaXWG56U2YQwZGHk+LXIuP7L
 CaLtKtSJ8MmJxQSaViDrMVbRTDF4LdlzFbqNPUgJArFTrRoeWehpY6KBNlcDqFYmtu2E
 qmTRWE0s+iqHAUi5drfa4YU5apcEogITjnBLM4ximOLgGjw1MBzGm/uVLXfzxoDGPm4s
 Nqtj9Lv8QCQrPCxP+9525BIAxTQAl8Xfmp0HtGVcO3WCxTDRJroGT/xqPTeEUn2boQU0
 y/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586045; x=1769190845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEtJfG/C2hd2ZLJd+8mQgLjLLyAUmWrjQu/r35Q88dk=;
 b=xIadEJrn0Rq1ZnxGHTv8yNThtN9PocJAQG2xMGFmbYi/oeswRWC0O0dlRWFSzOScTo
 m0iTuV1EtqPQlpAw2U/LEAg+CJKIM8nccWZZWiWCFqDj8vCTfGLG/Rh4Wz6vHzpv2iq6
 JN5zylKKZKdSP396i3ufc+CcCpSMyWbTDwHr6WE5q87zqz3VR8xZDltwQIdlfoBoepOC
 gRPn414EtC8uXOF84ECtfVL9ySDMHocduesJUS55QdGaU7s6VIUTsXxg8vZEwaOyALpG
 P/A+DG6FLR2J71S4yPWeRtw7SQ3GJ6hpFKRgVrTfztns1JfL8ptQMVVA/bwmhd1khM44
 34gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJKg95CTf/QFt2L4U9PC85y9/G/V4nhyiXlO2kSy4GaWna8YkJBOYKCoTSxpikXLS/0x87YWY=@lists.denx.de
X-Gm-Message-State: AOJu0YzjiQNefU+VTUT+1tQAEvNM/XgVkne9SUw51DdxoKpQafO5GeKF
 6l2T3/TMY+Lwy2bF94bsRbf1Isam+lJ+WGoAuBA8qrAqxNHkrfqa8147yAC8Zw+N2Y0=
X-Gm-Gg: AY/fxX4pcJ1FkYPjiOoUyCoHNBgj4Zv5v0dZLX6SjDZfAi9djONPGm+EV8nYczvHoMi
 BsKTKlgCefL5mhr0SgG800/cCAtuuhcdPrM4+fmmYvjV3dls7jv5lI/S5/agUhzaffoO2aN7wwA
 z+sOQrgLegot2jh+V9TXOsFDBluSuz5wCf123O4aYqE6o0K/45o/yLmBIVc/yiCKm3RzmSOPX0p
 y/j5mxTCtFk5naFBVb+fXke/v2W2azKtccgQYGGILWDrX3y7mWIq58VrGZHlNRUaIqv+T2XepxY
 Z4yrhkeYzAxLTYQHZPVP288A8xSq5RshxNzTbAdD6rIs/4o+JMVeLgHUbF2qqNnQ1pKRgPa3dHE
 85GcsCz7gdewSawLCCDDugn82dKaTNw7PD8Y1LgFqFhrQHCC19GfirZUXIMDTvxQ+ZLkvq2WgIj
 8LISguVmBtwIig0/KaF35ZhjrtAfcKW9YjrnCA31Bj1cOte01zZizt
X-Received: by 2002:a17:907:3f93:b0:b86:ecb2:f4da with SMTP id
 a640c23a62f3a-b8792df1230mr360957566b.21.1768586045261; 
 Fri, 16 Jan 2026 09:54:05 -0800 (PST)
Received: from [192.168.1.160] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169d30sm309646966b.25.2026.01.16.09.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 09:54:04 -0800 (PST)
Message-ID: <2d495261-ddf2-411f-a3af-7e051917da4b@linaro.org>
Date: Fri, 16 Jan 2026 18:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] usb: dwc3-generic: support Qualcomm flattened DT
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
 <873447fcyf.fsf@kernel.org>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <873447fcyf.fsf@kernel.org>
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

Hi Mattijs,

On 1/15/26 10:21, Mattijs Korpershoek wrote:
> Hi Casey,
> 
> Thank you for the patch.
> 
> On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:
> 
>> Qualcomm devicetrees are moving away from having a glue node with dwc3
>> as a subnode and now may just have a single flattened node.
> 
> In the commit message, could you provide a link to an example dt who has
> this single flattened node?

Sorry I just saw this after posting v2... You can grep for the new 
compatible string in upstream DT, sc7280, sm8650 and a few other 
platforms are already switched over, eventually all the used/maintained 
platforms will get switched over I suspect.

> 
>>
>> Rockchip already have a glue_get_ctrl_dev op which returns the node for
>> the glue device itself, commonise this and reuse it for the new Qualcomm
>> node.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 02c02b1d80e4..7044696ced0c 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -6,8 +6,10 @@
>>    *
>>    * Based on dwc3-omap.c.
>>    */
>>   
>> +#define LOG_DEBUG
>> +
> 
> Debug leftover? Please drop for v2.
> 
>>   #include <dm.h>
>>   #include <reset.h>
>>   #include <asm/gpio.h>
>>   #include <dm/device_compat.h>
>> @@ -488,23 +490,29 @@ static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
>>   	if (mode != USB_DR_MODE_HOST)
>>   		dwc3_qcom_vbus_override_enable(qscratch_base, true);
>>   }
>>   
>> -struct dwc3_glue_ops qcom_ops = {
>> -	.glue_configure = dwc3_qcom_glue_configure,
>> -};
>> -
>> -static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>> +/* In cases where there is no dwc3 node and it's flattened into the glue node */
>> +static int dwc3_flat_dt_get_ctrl_dev(struct udevice *dev, ofnode *node)
>>   {
>>   	*node = dev_ofnode(dev);
>>   	if (!ofnode_valid(*node))
>>   		return -EINVAL;
>>   
>>   	return 0;
>>   }
>>   
>> +struct dwc3_glue_ops qcom_ops = {
>> +	.glue_configure = dwc3_qcom_glue_configure,
>> +};
>> +
>> +struct dwc3_glue_ops qcom_flat_dt_ops = {
>> +	.glue_configure = dwc3_qcom_glue_configure,
>> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>> +};
>> +
>>   struct dwc3_glue_ops rk_ops = {
>> -	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>>   };
>>   
>>   static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>   {
>> @@ -711,8 +719,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
>>   	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>>   	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
>>   	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>>   	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>> +	{ .compatible = "qcom,snps-dwc3", .data = (ulong)&qcom_flat_dt_ops },
>>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>>   	{ .compatible = "fsl,imx8mq-dwc3" },
>>   	{ .compatible = "intel,tangier-dwc3" },
>>   	{ .compatible = "samsung,exynos7870-dwusb3" },
>>
>> -- 
>> 2.51.0

