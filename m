Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CDCF43683
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 10:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11BE83EEF;
	Fri, 17 Apr 2026 12:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSRaX7KE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayarP9FJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A22F841C2; Fri, 17 Apr 2026 12:20:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E6380086
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H7v92r1092090
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7nQbksO7yH9xgrzI5wa2r8ryBc+CyB8333BO22rLHdc=; b=PSRaX7KE4cwtFhW9
 UGwejsF0TwkeuG114TmoSWXtKl7aE6m/K3ccDEucVT+EyDZKgCsxj6T5u2w1sF7s
 NDrLZnNrfy2AdmdMVATQ1twtJ+fUtMDHF7ftULehhNZDD02M0P2DnJ1PAcgLQJvG
 TbkSpNBTVl9D5PWtcxZzkPbZoRrVGEMUeEpA8JoJqAUvhpPdSUaRkAJ9fW5Qqds9
 tBzq2Y8LbiBchS674teCAAu5wt2bsayhXfTBD4xKp0eW9cc9YvN+oozlZRhD/+za
 Zegiuon9wmH/ogQGQHOE1oszMBVMc6XiA5e9tfiQ8JEhWNz8NZARQOgEApe1oJL8
 6EvCwg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227ur9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:20:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35da97f6a6dso596109a91.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776421254; x=1777026054; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nQbksO7yH9xgrzI5wa2r8ryBc+CyB8333BO22rLHdc=;
 b=ayarP9FJRhJXkfGHD+bq+4dgbgShC8f058k5fwMOiIN4La8d72OczULdcUZVjk7FcU
 GUmeR+JSdtgDkvafCceo8GwiAqgkNJqOcfFt1uHoGqdZaS3otT9h1h7hOzHzaYHevNci
 9cermkTJZXaMqctNiDy3yXxt4fckT4OoGNhP249VYf6XHkUN1ARSlr/zGjvgk7KwlsYe
 z0X/xc3WbWcjEjUgHdu4p293Maf97lXp2qZw7jZz+J3QEz50pH3faayIgdTDdSuV3x4g
 FIu9ypHTkR7Ne42tNcdo0zJFg5kO/3kOB2/L5ZI7SYHR/1s5UqRCIlB1WSBg6JJmf7cV
 lV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421254; x=1777026054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nQbksO7yH9xgrzI5wa2r8ryBc+CyB8333BO22rLHdc=;
 b=O6mogxgMarhQg/RwH+0q3Krxv0J4BnZI4ETktJY8qMeTRshP2IXMlWugJcN5Ud/B5w
 LK5dpseVpPL5+S1Qqyyos7StIYgryX8uE9j8BybJLAX2Lg8xL75R1ONdlU4Vo8Axodc/
 WoJzYGAVdM1bybN5YDBFZSePWh/U3ZrhYVoqkVe68F4jX8ia7zA0nKByh9s4GwcLkrUR
 pOacNHsh++Hngz9ZVWldilDdiUwGPfgoByolrHiX12ygRlwCjGfv1cUuLdfBVh67ykuy
 HX9WoYHdBEQA54HIXUDw0WPFcFrpXuYBSXAnQqaeYOjCKdpSBt7YUQi+Q/5oz50/Qvjf
 XmRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zKupq0RlJcW0RG9wPzAdZZvJ7sziCedLPc1r9o00AdtWMbVRKMMCv/MU9ixuRmFdWtp+TRFE=@lists.denx.de
X-Gm-Message-State: AOJu0YzPPF7q58plTuZ+I94ESbb5vWQlOpX21Z6ovJ8gURnWdQE5IKnN
 +mWRKQVIQYt7MtedYNASTDZYwSGQ+3Ek64/cYvy4ydBJTBpQkDy39zLjUvUJfW/mpeZ8dQBMTF9
 85bzbIl6PMREO95q3UJ1RZV77Ra51fFjcH2Ioux3mkr/q3ITlnL+N/nRw
X-Gm-Gg: AeBDiesPAKBCEl2tdIesaKLBc1lk4ESqpE2e9gEJ63STOGH4lZb5o23wJ6Jq0z4FW0n
 kMGpVyzThkjLB2sIQB2qL4Aa8NOlMQ0FpGkXefoIMaR1G7jmBe03+Q9pRvvNkP8v/6IA3c63xgv
 d0n+xmG5Re8ujBY7yKLnNHVAwgm3EFbTz33mnguPhlIhocBzvv6i4rjKa8bGrsp5vYPBgWI56y3
 2eo2EzO7ADliCwW3pY9Pf2zQ3yxylzOZZcfEF6ptg/sNTDbg00xB7xCB3K2LJ/PezGyIfq4FbKZ
 CtV4XJtW6Um1Z9dr1ngORV5kkOYs/Ft9uzBchYSZf8AQB8zjMxhqHsqVmDZ3PsBR+QVYTuj8lVw
 QxygNW8reSHigdKPtigI+EI0Q6bUZxjRWaZSY7bv1N8LlwyzQnrUrMk+WRawAGcW1
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-361403d5988mr2528512a91.5.1776421253677; 
 Fri, 17 Apr 2026 03:20:53 -0700 (PDT)
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-361403d5988mr2528480a91.5.1776421253231; 
 Fri, 17 Apr 2026 03:20:53 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bafa9sm1629993a91.15.2026.04.17.03.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 03:20:52 -0700 (PDT)
Message-ID: <ff78baf2-7be6-492c-8a54-1e557cb022ef@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 15:50:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] configs: Rename qcs9100 defconfig to lemans
 defconfig
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
 <20260417093924.3357296-2-aswin.murugan@oss.qualcomm.com>
 <0697f98e-a0c5-4d81-873d-1e545ceeb6d0@gmx.de>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <0697f98e-a0c5-4d81-873d-1e545ceeb6d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEwMyBTYWx0ZWRfX+tiMwOaMnfsM
 xINfBJhFC/pc4ZhMssGjf+o7kIZ4GwRvBEwlwYyvDtD7qHiVZFValWQUvRQDEPbKRvhWpjXTroo
 jnNJJAJ40aDrFb++jfRuuKKBAB0oBErxko0Ajhi2Ggsv0IKRbGdegx8+i8IAE2wkJQAeGOE8wCV
 7V9d1AhL8UXWBmFzJW8fSE8nUG7M/YPeFtvOwP/XC2YRNWpL2rLNtH/88KtLNRhlem+yvkETyLh
 TNi0ckdqoY065sNAISxgfRSpfugNYS+y7eJEXp1lx34+TohyQLP9RZo82AHAEncHLttCBdgEWsp
 3g0AOv8+Qe/eS0Lwd482NHV0+cTJKFRd9+YQJ9W1W4d4nNWthlw6ZuuqsIm9cEo2fFM112PeNK9
 x+eDixyu4NwfOSHsuDlu9QQbxfyMSthRT0Np4OXA3AbYY2RZ1TS+DtWFZ0eSWtF9X79LC13ihqM
 Pb0hdAmQrkFGDqPfp3g==
X-Proofpoint-ORIG-GUID: no1K4wbBDjVrtNcQrfFNdBR5uVPFXVec
X-Proofpoint-GUID: no1K4wbBDjVrtNcQrfFNdBR5uVPFXVec
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e20986 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=dkVJYNKNnmuVNguGpeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170103
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


On 4/17/2026 3:20 PM, Heinrich Schuchardt wrote:
> On 4/17/26 11:39, Aswin Murugan wrote:
>> Rename qcom_qcs9100_defconfig to qcom_lemans_defconfig
>> and update the defconfig to select lemans-evk DTS instead
>> of qcs9100-ride-r3.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Why do you want to delete qcom_qcs9100_defconfig instead of simply 
> creating a new defconfig for the different board?
>
> Best regards
>
> Heinrich
>
>> ---
>>   configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>   rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)
>>
>> diff --git a/configs/qcom_qcs9100_defconfig 
>> b/configs/qcom_lemans_defconfig
>> similarity index 91%
>> rename from configs/qcom_qcs9100_defconfig
>> rename to configs/qcom_lemans_defconfig
>> index 082106157bb..ad40d5206c0 100644
>> --- a/configs/qcom_qcs9100_defconfig
>> +++ b/configs/qcom_lemans_defconfig
>> @@ -9,7 +9,7 @@
>>   CONFIG_TEXT_BASE=0xaf000000
>>   CONFIG_REMAKE_ELF=y
>>   CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
>> -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
>>   CONFIG_ENV_IS_IN_SCSI=y
>> CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>>   # CONFIG_ENV_IS_DEFAULT is not set
>
Hi Heinrich,

Lemans EVK is an open evaluation board based on the QCS9100 SoC and is 
intended to be the default reference platform for the QCS9100 family. 
Renaming the existing defconfig

aligns with the naming of SoC & avoids maintaining two identical 
defconfigs for same SoC.

Regards,

Aswin M

