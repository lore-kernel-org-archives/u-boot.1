Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB15C43602
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD3B84979;
	Wed,  8 Jul 2026 14:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIDEWHWN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSk3oHaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0966384979; Wed,  8 Jul 2026 14:32:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45286843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 14:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3EeZ2751574
 for <u-boot@lists.denx.de>; Wed, 8 Jul 2026 12:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZzYyaIkbecaSIhHsDv6eQoynOpX+hmTWqNHd2JxVq7k=; b=SIDEWHWN5wQCkm90
 WyaJpKhV1fa55XW9SiGqNlNsocM6jjTV2SFw3o3JC+TA8Ng7wE6EtLlB047q8oq6
 Lf2npBWJyVFsxn5VMe11Ikvev7gkuLdZoZDFmAzdZDW1m3Lq6knsIy4FI1PVeQgd
 +Mj1sy0OD4shso0lnZyPh7DfOe/lzcbCgToYLryhJGbBzuLcvsIXjCnES90n9PCG
 mt2Ci0gVdo3yF7ZVuKPQsKCQULlvemFuZ3DLbtuVLMtjRJ849x2tUyxaEtFTiGij
 enDCOmH8DKUX8HsvRUopvQwakomSa2yD5ORvLDFpY8UnTbYsApo/qqPSwUsEkUPF
 QAJiog==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hhmek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 12:32:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so1292420a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783513922; x=1784118722; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzYyaIkbecaSIhHsDv6eQoynOpX+hmTWqNHd2JxVq7k=;
 b=OSk3oHaPnNz0SRa5welFZRlt2by+0Q4TtUGDKK3FcomVS2jooLpRXZYfifEUDtaTXn
 UkzEPLII+II04PKy7Q8FsaMY/PEGu0jQNZRrdNdtLg4LeiojjpoC4C+LfB5Yi5jjg//1
 3sjXWEwqgy4fZqjTXRrbhMKZydw/LLWnoPSSHO0X1iN08HolDzBnBQ3FJJ0gnrNnAfwF
 fJQPIaNupda9vCAJqq/ST9XBCCf/qQDj6EptOHJ5F8u6rnHy7SwTTGbpCTanIip34/28
 UtrQvfS/4zn99QcVC/t2QxDreHcF12mEn95zY5ykhmBHBO4NLy3yR2E93SsTvqaFULLG
 HECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783513922; x=1784118722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzYyaIkbecaSIhHsDv6eQoynOpX+hmTWqNHd2JxVq7k=;
 b=ROA3ARHBI7RrE9B7GSh0zlxXmORggvsyoghEw0TgzmCz4v2qovczxR4NJUzXB/7jbM
 Zc9nJGkFjg4NgdrDi0mxBYW68Wn8DaTs36NOsIRMeXeFtOsUV0Uo9PtI91DMdrnZauXo
 ntjcRbPEea7QELYkIvpBRoir2chCyvNuLJ2UAeW90Tam5u3tqDUZtHg923HfMeH+7YAB
 QTrQ6Oz0ml1L7BdR0QOZ1qoQiX3zzuklTJC6+/HRXcfhkeJ8AzYeCqo738hHw5nptXSz
 KgAYeDOboryi08TRwPyg7iPUcPw3EPDkyeQ5ceBY6CdMQ8O4RJxmE4oM4mAQS8ZokkQb
 /pGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoutMrfPEO0pztk/iiBsKUIgi6ippqlx2odpPLX3kHnKu84svi4ItCGSnL+8yrZ0TrH7UVKLaY=@lists.denx.de
X-Gm-Message-State: AOJu0YxNsN0ZeKGz8g1V73ifvsH05pGdpjkdln2YDuyFkDwxSxkcWnsD
 ujKq8hthebd2erezpvy1pDYaPabKqZWs9nK36e3XCbN53gUOW2+9lM/7Xi4dttt9NEjDymp0vVF
 jOwwolYaar/b1PgHA7b0qph8pdYIORRp8536ygKYPg/y8ZpnImaPFpyXG
X-Gm-Gg: AfdE7cldwRpu/W7JEJ5iiBYjJor2KKgZ56kq/aWMss8cbbzS/oKMPOWwc6MU4bTuqQN
 1QTFIAql0zhUsvZw9oAxtSRODOizsUWRGfWr8vGWoaafH3ymSjNnbIi+E2aQfD8k16e0rAA5PJB
 sQharySTcZfv0O6AUi1b1cW5Jz/fcd/RyqXKVYpMOrrPTswyxqvGPYIRyIp55XFj7TlV4MDWkK/
 p8TfQbw3KVq1qh0vVrqp1ES4kQCaJaByoDAL8rBYJR/F0+O5qSAnYOBsIK3yH+XjgABabcbmw3z
 PkQvaYkyGEqttYHS3z4chCDhiLxI82teVQ/ZVel7fwf4I76/waC/1TDnTkPY8zAQ2d6ycka6ltL
 2mLyldFT9QzzNfvC7LHcf9e22Dtg1SfGarkAOfq2WmCJwy2U=
X-Received: by 2002:a05:6a20:a105:b0:3c0:9c19:6584 with SMTP id
 adf61e73a8af0-3c0bcf97aecmr2993036637.62.1783513922076; 
 Wed, 08 Jul 2026 05:32:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:a105:b0:3c0:9c19:6584 with SMTP id
 adf61e73a8af0-3c0bcf97aecmr2992996637.62.1783513921537; 
 Wed, 08 Jul 2026 05:32:01 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8572sm19958349c88.9.2026.07.08.05.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 05:32:01 -0700 (PDT)
Message-ID: <77178f9e-5839-4ea3-83cb-36763c89a018@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
Content-Language: en-US
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
 <7f365f1e-75fb-4cc4-838c-d6e2f91f21ea@linaro.org>
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <7f365f1e-75fb-4cc4-838c-d6e2f91f21ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMSBTYWx0ZWRfX7h7VaGrbt0YJ
 hUBEpyFO/nHs/+YxImIBqziSd858NMdFYbQy3WWkF4KTiKqaDP29/MQ3EwjrSzd7ijOe29vf5ab
 O428Bx8Q51EG0NyXLltTmYO1AjCI48/nSCHi4OEjOBtitb4lDB26kRPlnv5ZRvdhvKgB66u7WB0
 XveCjRisNZ9FqXzdG/9HHLnq1dLY/s3CRhnhWKvjIKircddMQkJaBxpM7EUoDIgddx+tQZAfZPf
 2pouNvLu4RYjFoUQxx7Ze24Pka60rpyTKiH0ail0m+bhByEL8L3JamK3VD4VamB//y1k6n8zpQs
 jQbqJw3xaHDX9qGEzSpQq3iJHZQtIa7PkDQRc4x7eKZWFPgvHJYJohugh9MgrDs1VocHoLDtk9H
 GoWzPTZeHpqH0jeVWW2i6dE3CBoA4K5a+XVFI8MyAk+aRPoqrl96VGtIjTUAF+1RxAMQ4T6LUn8
 lqg9kiD7hDjlbUw4Jcw==
X-Proofpoint-GUID: t7yHG4m69XXU2gAS8Hs33a9L4D0krfIb
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e4342 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=V7br-Tu9_rX51x9jHnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMSBTYWx0ZWRfX1IDs9g5UWpBH
 XBSlRxx3+w9mT3cSsLrazaYDNPaD9pskIR9Xg8BeJDQwdo85sSkYA6LdasKMCI8PhV0jFH3nEOq
 Yw2Yw62+GDIF/pTKCXdlQ+QyOGPIzKA=
X-Proofpoint-ORIG-GUID: t7yHG4m69XXU2gAS8Hs33a9L4D0krfIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080121
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

Hi Casey,

On 7/8/2026 5:54 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 7/7/26 11:52, Balaji Selvanathan wrote:
>> Add IRQ status validation to distinguish legitimate UART data from
>> electrical noise in the RX FIFO.
>>
>> When the UART cable is disconnected, the floating RX line can pick up
>> noise that the GENI hardware interprets as valid data and places in
>> the FIFO. So, check the RX IRQ status register for RX watermark or last
>> flags before reporting pending data.
>
> Thanks for respinning this series. Is this patch still necessary with 
> the first one? Since we should no longer be in this state with noise 
> in the FIFO after resetting it correctly iiuc?

Even after fixing init sequence, still it stops at U-Boot CLI when the 
UART cable is disconnected on QCS615-EVK, so seems SE_GENI_S_IRQ_STATUS 
register has to be checked to make sure data is valid.

Thanks,

Balaji

>
> Thanks,
> // Casey
>
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - No changes
>> ---
>>   drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/serial/serial_msm_geni.c 
>> b/drivers/serial/serial_msm_geni.c
>> index a580dee8c8a..07d38178759 100644
>> --- a/drivers/serial/serial_msm_geni.c
>> +++ b/drivers/serial/serial_msm_geni.c
>> @@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
>>   static int msm_serial_pending(struct udevice *dev, bool input)
>>   {
>>       struct msm_serial_data *priv = dev_get_priv(dev);
>> +    u32 fifo_status;
>> +    u32 s_irq_status;
>> +    int word_count;
>>   -    if (input)
>> -        return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
>> -               RX_FIFO_WC_MSK;
>> -    else
>> -        return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>> -               TX_FIFO_WC_MSK;
>> +    if (input) {
>> +        fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
>> +        word_count = fifo_status & RX_FIFO_WC_MSK;
>>   -    return 0;
>> +        if (word_count > 0) {
>> +            /* Validate RX FIFO data with IRQ status */
>> +            s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
>> +
>> +            if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | 
>> S_RX_FIFO_LAST_EN)))
>> +                return 0;
>> +        }
>> +
>> +        return word_count;
>> +    } else {
>> +        fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
>> +        word_count = fifo_status & TX_FIFO_WC_MSK;
>> +
>> +        return word_count;
>> +    }
>>   }
>>     static const struct dm_serial_ops msm_serial_ops = {
>>
>
