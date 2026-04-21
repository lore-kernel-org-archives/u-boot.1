Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF21F8FA72
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBD883BC8;
	Tue, 21 Apr 2026 15:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7jdVPWk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zpz0PH4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F46383C51; Tue, 21 Apr 2026 15:06:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEE8839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L7LELQ1128592
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IBRbFduo0VKoQ5qzGnmtDz9bzQcfG0kM02th8aKhyng=; b=l7jdVPWk2hPpG1wW
 1m5IL5//ry79rfh1VxwNt9Wcv9iUolkM1nuPoiGcoEMTzfoDIv3xxf3nPIl9cFRZ
 Lvgd5VwQsDqB3mwU0/+6fAPnaQ/W4M2u/22Z4/DjE53qISm2ZoAXlCAMXv2RFC9o
 /xbAAN8AhQJfS2EKV3vRJF4tWFfH69ggvY6FCxaxR1u3jW4ZThsrxebZevRm7fy1
 wymdqK93ZRJRBtGcphg7rxWuJXMnXRRHJKt9saohsCMBSXkiS3hbQ4jqyWxYeFvz
 5B3NzVbMiKG5Y1KWA2EiFHUjsU/OJvs9LlFkVJ6hQKEs+ec8KUvOxAGHIlL3TBSV
 oLWIew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnw68tpnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:06:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35641c14663so5030035a91.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776768; x=1777381568; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBRbFduo0VKoQ5qzGnmtDz9bzQcfG0kM02th8aKhyng=;
 b=Zpz0PH4A+f5twtjo+CLwizSxdh2Mp7t/Jwwlt1LsveaOfFBCQDiLvYvj/upOW2q/py
 txrDnnNRLN0oj4aMoYOZ3vq1q+UKhYPQT58CPkfR/9mQCw2iL0nGPN9psJDQeEgHhrvZ
 Y9IoPx9ohADR22sLt0sd6CXZecbZYPdVKnNMfJJVKj0OMXKG2CTMZtUh5cnK9WBm2heP
 JTYSdPKzq5p61+bX3EFGwYBXl0wmBJY09SLTsQjmo3KebCZz+8KdY6mnXztrA3eilL2y
 YI8Q+ZV4OUgHIcR00r3GTrzh2zjsOxQLyoNlJvP8cbzvNzfky7uKq9xVST0qj+7IE69w
 rStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776768; x=1777381568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBRbFduo0VKoQ5qzGnmtDz9bzQcfG0kM02th8aKhyng=;
 b=q0vb3lVM4o3Q1/6YKug2IpO1dRciL5Y5y6JSYYsJgyiC9qdEMCm1DnFqayzcuv5P5a
 tpUvIZhwzF1vLDTzxnsl7qhNctsDrJfO2aDe9pIQWs36MHzJzK6ZXkwP8zwip3wEDAXL
 /QRSy9Ijb5l0q1+FLXjGaCt9+5HM1itUDUuSaGmaFUU9eo7ZUV55jwWp7xvOhrbUpojR
 Hb2Vq7IXt2TjWYOD/hOp0Is1lxQo+LQgVX0KqgCZZUaE3MUYKj0Qq9ZLPytlAvntJW60
 lZ3DeaLy0NHrR+ISjDr7AQALLA35xoCXRSrtm5DGYic3my56VS/zR3K6Ba21FhzYBpaU
 1BNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88uLynIKWszOWfPC3saBJID9DHUBsOw2AfSFiIxKwV2NXAqEXoyCRHF9a1u1/ld3vnl6tg9ic=@lists.denx.de
X-Gm-Message-State: AOJu0YxKkAENOSXKI+usS/LE1BOHCOJRrEFLpgicnKHlFd11oXw6JIqW
 qK5z7vJoP7zy/pedpRbkQMwVALf/lzic+pMvwMR5z7LlvIMb/AyGCVwSl+vIXRqQkpqnZOtiCBL
 ac75AVKuqe9xXSZ0SNt2P7Tx11qIZpfFzFlcAiGQeXiUGJXZkLJaSRAgQ
X-Gm-Gg: AeBDiev7dMVGeljdBhzUTZ77iVCP0WrKROXQfj2o8jt8KTQuvN00dnom6poGlYq3ZEW
 BWiwN+9Eok136quKxVSpIcl0eyZMHgc51L6v9n/OxPl85sFBK2BOlbB/4s21RhtNzolgK4juJKC
 wnnAbtjVtFrVS21c1VDdNg6mkMtCTHVzTug0ZLj8VWzXfaVnV92Zn5u82RFKs3zq29qor2oZh65
 t5vhTNRVXRPnPvT6QgN3ITDiGPW6kObnpVtCGBCuSdrdXtNkvuwEY2GIVPTRXtNlOFUwbff1Iue
 Zeq+zOdZrcO/9+CmyXBXOC4zO5GYM9L4u52jBKLlE9/mKMA1Z8jh5GsKP0QuPy/I1d7QX1GXy14
 NF9gNVInUInkS2MTB1jy+P5jGJdBjzqFqqzZnDQe2kkydUAla9HPag4v5QwQlqb259mCY
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-361403d5988mr19194877a91.5.1776776768057; 
 Tue, 21 Apr 2026 06:06:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-361403d5988mr19194828a91.5.1776776767437; 
 Tue, 21 Apr 2026 06:06:07 -0700 (PDT)
Received: from [192.168.0.7] ([183.82.177.74])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614195a9fbsm17796266a91.11.2026.04.21.06.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 06:06:07 -0700 (PDT)
Message-ID: <c87bb381-eccd-461c-a912-a84eb1407b6c@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:35:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
 <ady7Q-acflFr07v-@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <ady7Q-acflFr07v-@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CSu4ejbi6LnOL1tM1jyWzeJlAk0lPEaO
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=69e77641 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=wgjzkBLg20+cMgJN0zysmg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=puaEKM2cYFzsJgEGcLwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzMCBTYWx0ZWRfX0BideJUCMCep
 XDMYpNIMui0R6WUQgLWEdiEQ/0hMdMSUpcFzVnzOYa505X1+hRzWOgAbtKQpt7iGhEVBUxkRA+J
 UrbpDfLSFeuzE5bNPPzhTeGHUuPY03rFLpgXS6Y1Fz3GYHz4BqpOzx9+xniJzrnZApktdu1fS12
 OpV+ygnE6/zuoqdrKDvrw7addl+DkBSY7c3AAI5r1TYVO3/2vYKKfFVaNNPLQ42JowKxOXH8SwW
 tFVNDM96xyT6M2WYQaNChK6UwKkA9FH0ZoLfBVQf8ROdzHr5Bv66Thu9cz7wegj2sE1ApbA5I9b
 fQupzN4v8FqV2Gl3o8YhHAsXsZBl6xO4k6ulyz+kqhHgeGXP/Jxn2aK2XSPX83tbRlDTL6qaU+s
 Y6x+OAxZh6NOWw0z8PdvrMSEKfqhi6jZjhtgTa4ZC+AC2t50sVwevYs3tx4ulFQ60DV+pFLLz5Q
 WRZ5gg9hA4j7cJ9ridw==
X-Proofpoint-GUID: CSu4ejbi6LnOL1tM1jyWzeJlAk0lPEaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210130
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


On 4/13/2026 3:15 PM, Sumit Garg wrote:
> On Tue, Mar 24, 2026 at 11:22:35AM +0530, Balaji Selvanathan wrote:
>> The block device removable flag should reflect whether the MMC
>> device is physically removable (SD card) or soldered (eMMC). This
>> information is specified in the device tree via the "non-removable"
>> property and stored in the MMC_CAP_NONREMOVABLE capability flag.
>>
>> Update the removable flag in the block device descriptor after
>> successful MMC initialization to properly reflect the device's
>> removable status. This allows the block layer and upper layers to
>> distinguish between eMMC and SD cards for appropriate handling.
>>
>> The default removable=1 is set in mmc_bind(), and this change
>> overrides it only for non-removable devices after confirming
>> successful initialization.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/mmc/mmc-uclass.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
>> index 698530088fe..b218c69b494 100644
>> --- a/drivers/mmc/mmc-uclass.c
>> +++ b/drivers/mmc/mmc-uclass.c
>> @@ -507,6 +507,7 @@ static int mmc_blk_probe(struct udevice *dev)
>>   	struct udevice *mmc_dev = dev_get_parent(dev);
>>   	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(mmc_dev);
>>   	struct mmc *mmc = upriv->mmc;
>> +	struct blk_desc *bdesc = dev_get_uclass_plat(dev);
>>   	int ret;
>>   
>>   	ret = mmc_init(mmc);
>> @@ -515,6 +516,10 @@ static int mmc_blk_probe(struct udevice *dev)
>>   		return ret;
>>   	}
>>   
>> +	/* Update removable flag based on device capabilities */
>> +	if (mmc->cfg->host_caps & MMC_CAP_NONREMOVABLE)
>> +		bdesc->removable = 0;
> Looking at other MMC drivers, this update happens in platform specific
> driver. Check if this rather belongs to msm_sdhci.c.
>
> -Sumit

Hi Sumit,

Thanks for the feedback, moved the codes to msm specific codes in v2: 
https://lore.kernel.org/u-boot/20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com/

Thanks,

Balaji

