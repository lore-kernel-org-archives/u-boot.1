Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0D105F798
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D70384246;
	Fri, 13 Mar 2026 11:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Njdkpu3D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hw7w04/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FEA084230; Fri, 13 Mar 2026 09:14:59 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D878F83F86
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=krzysztof.kozlowski@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5tdVU4140739
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ziuDQJxvUKyStLMOQ0E0BpVNIHaol6EdHTdMA0u17k=; b=Njdkpu3DOlV6ytdY
 gKe5u9LKTZudba7p5eInWpoClIcYNrKj4UllZbxJZQ68ZelKQ4ABw2t527Kvwllr
 hYjhWxMcCPdeqhxBT2ZYdmQEiMKh2XHLAUnODztTmubX5wxYanznTmqAXYApLPdI
 su5gUkGa2EGR8v9F/1NLIdrx3osdPBJ7t/UaS/PKMaGpw7i74qkUDq3o/UAUlgUl
 wCC+E7v4aw7LPPrDssWRXXJMT0GjMHT8mVCWkm8l+JNfxl1NRYZMXtPDhlQXVNNG
 aM2l2uSlnkhNvdRQMk64I0mTLr5gfU+Q0Gtf6gPCnhT14M4IiGZ7zzwjib2Uspey
 2AqSzQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn28q98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:14:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509181cc6ebso28564191cf.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773389694; x=1773994494; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6ziuDQJxvUKyStLMOQ0E0BpVNIHaol6EdHTdMA0u17k=;
 b=hw7w04/FBCakPQvs2y50k+GxjMH2iUJ1ccKadlamSfWxgoYVllz61Wb3ar7anOg29c
 lagJIKEb8X0g0LUqrhQPewYw30d8sOJKoYczWgbNnVD20p55xgA0zLdynup71Wcozj9d
 wShHLnvk8BeI8pWCB76/cJpJeFzOzyRGHbTsM5ocUI/t4h2MoKWpJxaEmcDWiTx6s9mh
 oYjATtMN2PEGblZF0r3XpKg5DFeEpHLHOtkgl8zRx4AO4mgoDUYF4fRcHg5MBM7CoTw0
 FJEWkDxSgQ2YXKoPzfgu6T4x9FbxZE8xZfSwdWyAXZTIXVXneZBbwIfsIgpZfjZT8VX4
 td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773389694; x=1773994494;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ziuDQJxvUKyStLMOQ0E0BpVNIHaol6EdHTdMA0u17k=;
 b=CePohuHV2/k1tKp0hohyyixcKWLnx1ZXyaf+6Wzr11zTUAkXoggWOAxGNgEi2Rrdub
 /o5PSn1qE55Jka6aphgMxSJjouYNCMkkp2t3gs5edCrgVVPTDBf5M9rOOkP3qpUGPD/m
 ClKG8Z+LRoLzfOeeKkgv7Nq+O5k4gwzRXI8h2AvsohHRNwHV6Bx9IcXbIYWHv4gxfPfW
 iE3cllszOPGJjNewIB/I8o4oOmEWWeOUWZmxFr7Vploe3QPv48SHBF+7uAWfK4MTavjm
 t81eHj/5tUkShqhRW1TCxNZGKxc01SpxX/puIQKya0f41tE+e9Pot6voqMjF1mlcq0eP
 D2Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+I8wqyZVatapBjz8eUzhUBXZDEW6Y7UHflx+pNpdz4oPX5YWsbZIsglE/YhviJpwCX4zGPqM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk/ggGwTsu5lj8mFNpljHBNBI6jlpGekyUfPiLz7vUVEpUmAjr
 kYGnlXUv4SuH8lGmvGux2t2Onxiy73hPkwPukP4QHgPfeY1ZZZGrlLMvVsm1/sas5Yv6adm0L72
 dZMFt1+9uvl9EdQB6afEBQl/hotIorx1EqyfyjQe+DoKx7UGn4rf0LTiSMNBCIU39
X-Gm-Gg: ATEYQzyGHAFob90C4jPcROprky3+641ICOzslqpCxM3t0whagHRKAvOOWmAVh37wOvs
 ea3R9xxVts1vZXjNZr1iM6cS2JVSsrUCwN0EODtNJZ0dFzqq4PadSgpVjuVb2IH06ULDiWEoi1j
 30OwijacSp8r+fbbBc9OJMKnpMVR6xXQc6FLExhCAcAzaWZpo8pZ6Y7y/7aUmbgZ6MNm43A13Oo
 9IlojXOElsZSomgv5eBZDdFcuFOJGZtmGAr/oG9t7ijGk0AK12SnN7rz78cVK5ugjq3U+OMKRp7
 pYZwtkjIja+jgj7v1QwsJav3xSJSN8j/Qwa7FTCfdLq8B+VMejp2fj1RkErzyoKQsmPNxZxydYV
 dR+XWeUTjqOF2ulRmUSktBby+T9UdjsFVkTUo/yzoQ6kIVyXO
X-Received: by 2002:ac8:5dcf:0:b0:509:2e65:1418 with SMTP id
 d75a77b69052e-50957cb5474mr29159481cf.7.1773389693625; 
 Fri, 13 Mar 2026 01:14:53 -0700 (PDT)
X-Received: by 2002:ac8:5dcf:0:b0:509:2e65:1418 with SMTP id
 d75a77b69052e-50957cb5474mr29159211cf.7.1773389693117; 
 Fri, 13 Mar 2026 01:14:53 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854e67ea40sm144430035e9.7.2026.03.13.01.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:14:52 -0700 (PDT)
Message-ID: <02b1e588-1feb-484e-9f3c-f6c9f0b8e00c@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 09:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] pci: imx: Properly support upstream Linux reset-gpios
 property
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org
References: <20260312192605.131132-1-krzysztof.kozlowski@oss.qualcomm.com>
 <9e8aa4e7-72ab-4b1a-b324-4c78b13b9741@ew.tq-group.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <9e8aa4e7-72ab-4b1a-b324-4c78b13b9741@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: z6wui4itTUsQ_GMHCZ7UtZ3O-1PfTfbP
X-Proofpoint-GUID: z6wui4itTUsQ_GMHCZ7UtZ3O-1PfTfbP
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b3c77e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OdcAIBAYDLDBbgzDFZEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MyBTYWx0ZWRfX9RohvPYbyssd
 aWHGSSvYq/cR7lw7q8+1UCV7KPsf3mtnXuK9mfw4Ng8y+xq+mvlpu43+ZooeIJBjGNNUSL3Jojw
 0gAtprgh+0DwESh6SXnQcbMEew2DIf4Om6QhjSuJaqAy5QbBCl12qwXKwCvWanGmaRTg2waBSvb
 5zUUoBEBZ4xzVux1T0ZKi4xnvcUnfO/Cn1BYnMapYW+k/L/ZPX49pyTC6ZOhVD2yaZiHT1BbA1v
 L+x+mzacOgQDxvq3yxLQWJvA2oR0NNAHngUNeM0gkJ4SE5SDduwfmvnE8Cq0qYUozD29dMbyobN
 kQtQZcmv5RJVHjI5V7PDQOYIG6KdEuE+XUvjmY7WEIAalo4vU91Mp7+wJmzMZxm64AndxVjCyKV
 nc6Se/A8z7MhBAxAg4DcPFGmj8JtbEhbC7dKJndnuIqVmeLw9CN0HMtsluLpfw1IFDXDqay4/t8
 0zfUR04pSLxE6gsO9+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130063
X-Mailman-Approved-At: Fri, 13 Mar 2026 11:56:55 +0100
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

On 13/03/2026 09:12, Max Merchel wrote:
> 
> On 3/12/26 20:26, Krzysztof Kozlowski wrote:
>> The driver requests explicitly "reset-gpio" property, not the one with
>> "gpios" suffix but upstream Linux kernel deprecated it in 2021.
>> Existing upstream Linux kernel DTS is being changed to "reset-gpios"
>> property, thus update the driver to read that one too.
>>
>> Note that driver is probably broken already, because it parsed GPIO in
>> standard way respecting the flags and on top of that applied the
>> "reset-gpio-active-high" flag, thus "reset-gpio ACTIVE_LOW" with the
>> "reset-gpio-active-high" property would be double inverted.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> 1. https://lore.kernel.org/linux-devicetree/20260312-dts-snps-reset-gpios-v2-12-0d5040eb4a1e@oss.qualcomm.com/
>> 2. See Linux kernel commit 42694f9f6407 ("dt-bindings: PCI: add snps,dw-pcie.yaml")
>> ---
>>   drivers/pci/pcie_imx.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
>> index 11c4ccbfc555..8d853ecf2c22 100644
>> --- a/drivers/pci/pcie_imx.c
>> +++ b/drivers/pci/pcie_imx.c
>> @@ -728,15 +728,31 @@ static int imx_pcie_dm_write_config(struct udevice *dev, pci_dev_t bdf,
>>   static int imx_pcie_dm_probe(struct udevice *dev)
>>   {
>>   	struct imx_pcie_priv *priv = dev_get_priv(dev);
>> +	int ret;
>>   
>>   #if CONFIG_IS_ENABLED(DM_REGULATOR)
>>   	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
>>   #endif
>>   
>>   	/* if PERST# valid from dt then assert it */
>> -	gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
>> -			     GPIOD_IS_OUT);
>> -	priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");
>> +	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
>> +				   GPIOD_IS_OUT);
>> +	if (!ret) {
>> +		/*
>> +		 * Legacy property, invert assert logic based on
>> +		 * reset-gpio-active-high. This won't work if flags are not
>> +		 * matching the reset-gpio-active-high.
>> +		 */
>> +		priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");
> 
> A warning should also be issued when using the deprecated "reset-gpio" 
> property.
> 
>              dev_warn(dev, "reset-gpio property deprecated, use 
> reset-gpios\n");
> 
Why? What would end user seeing this in their serial console do? The
deprecated property is not a mistake, it's just deprecated.

Best regards,
Krzysztof
