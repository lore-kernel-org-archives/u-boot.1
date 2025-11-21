Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CF7CFA756
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B166180433;
	Fri, 21 Nov 2025 09:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pNBFBXAg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lyn8OSHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CBE8051F; Fri, 21 Nov 2025 09:52:54 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D8A801CF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AL5TPIO2832145
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 08:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ij19rnTGlSVUpaAqWeFLcG0Y5ieXJ0SpKA1jrkQz6E4=; b=pNBFBXAg63oiLt2c
 cqSO8BH+XlSnospiTLRKHN1AcHwo98XQTuLly9yJ3GsZhPF9i+3WLBfKVuS2sou8
 JHuXadWU0xsGO1+ves2dQmOs4qC1nWZfWZZ2Q19XEPoGA90OwXM3s4kka8hbMQqU
 KGOps2kEqI6wxO7a0LSbc9yfa0/jWBPfdzxLvDIWQeZBBT1AeuHwERHhxsxyR0D/
 VNaDyA6dVdW13aG3VDlKOeGomTroYN7za5tRzf0BzMcDPlntWqlIOPfIqC8oMJTM
 KXqZ4Ajlzyho7taTxAnQN/T+BpBzGSJ/5mNuXRPrnROWxE0743Av4bw6dpv43L92
 ZrRyrQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajhyq0kue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 08:52:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7aa9f595688so3646610b3a.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763715169; x=1764319969; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ij19rnTGlSVUpaAqWeFLcG0Y5ieXJ0SpKA1jrkQz6E4=;
 b=Lyn8OSHk9S3g2ch+pQn3bRR6IplQ5X3onxDfegx1KrooFxLxuk6Rws37AdUEdqVUax
 qu0VtwrqZeswdxOX5OaL3C6IM3So48iTFegu1Py43RWW1THMz+BGvDvoQ3ZJUyccEHfs
 i42Va9T+e/gfIruxvigtcGo7UlhVt9Ens0qqcmPeBBZqYIER3CnLYYZEu8LWoCR8ATNe
 chZWSfZ+mDnz8htY/riCOdWUj0byqU6ncS5XsL9BLQHmTC/VdG2Z4rW9jGMYpruGkWG/
 8B5HgZoQvRg1mSnsOZF0Npg+6eMqU8GBmXZ5DwRcwULnjRODtE1A45+EcFkhk1dE9JHz
 mxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763715169; x=1764319969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ij19rnTGlSVUpaAqWeFLcG0Y5ieXJ0SpKA1jrkQz6E4=;
 b=QI31dC2ZTo5aTZ23wQ17TXyAP0MDuGhH9aAAYQzTJ+ucc7bDJBx8HIW1kpak1mUcOA
 vWbiw//AvF4n6cp3Zs+x4q9B1J6XRQUK5TMfKQCkm+Zvyt2yRwA93GHQ0lay4EEk3KPd
 IE+gfFcbsijC5Jo4vxuyzfdoM4bLjlTPDXKZdThqNvAP5Xh9QpP3gBYR5dAyhUshh5Ph
 8WsiOj8YBiQZAqa6iZtOfnRHxkbW0UmQvUkRMXsRQteCovcO6OcTRaoLutREp5iVkr1+
 kYkW0jq6FGgrxzekuwcUo4HUgrPGzfPI3/RJBPNEIw8u7HbIazFtYyZ63nvv1AtuJnLi
 enyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVxP6L2VttKKw8xptzi5Ir0jrOtamYGCa4FdHjpXm0XW7pV18FPvCvSZU1IAGIhY9o+18Md/o=@lists.denx.de
X-Gm-Message-State: AOJu0YyBlrYCaEI5TNOtwvVHctJrYPPLvE5QPtWz7J6aZcqfPASjAGcT
 PXehwFxcWdhowuRPJA5Sg+U0vBRxh4hh6MLkYUs7wrNVPHdA27GAkCR6n6hdrYwBopoxAbMRaJ8
 14rMm1qe3RG0/bJxNL7tFdRB0RxbHzAQuCtNNtk4xR9tdUDWKMtQGU7nq
X-Gm-Gg: ASbGncucEPm1xki5YhdLcUfUY5KZbNDQ8O6ENODfeQf/fb7oE6L4osFufuHWcAuA3dZ
 8XIWDG2J7ebJeY6cjP0opjcG2Mt4CYSw/A7ptTv/q8EI7rfiDgfyjdqd5/ES+3Dcq1fjjqmRUZk
 u7juWQCM1OX0RwbwLg3LEOioJ9A8MhEzKm0ylzdDHLOWnnpd9+F7cfU5Jel0gRmDfXOYs/mxa6q
 eYRXHFKiTI9tsA6gaYEVZo6TxlOMHQVwuecFCZvewCZzbali13PsFE91tEpv/23lKnhb9BxEeNj
 2zf/9g80yn/0BWa+AdM/1TnBZ9lN+xMFCiG7fe0JRtBhK9inJ2+JuzqpUmyVJkgpKIEMUEfYNS4
 uuhwxwTnXB0JftGKJ/CE45al3nw50boO9W1+13uHdnfIiCQ==
X-Received: by 2002:a05:6a20:7f86:b0:357:78fa:b338 with SMTP id
 adf61e73a8af0-3614eda8501mr2345527637.35.1763715169126; 
 Fri, 21 Nov 2025 00:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNiks0Hkgfy5OWGgCdBLuRH/2mQ9OucA/yiE+wctHIk3suf4xPnF0N4QzZZGnXiN1palSvZQ==
X-Received: by 2002:a05:6a20:7f86:b0:357:78fa:b338 with SMTP id
 adf61e73a8af0-3614eda8501mr2345496637.35.1763715168690; 
 Fri, 21 Nov 2025 00:52:48 -0800 (PST)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f0b63dbcsm5276311b3a.50.2025.11.21.00.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 00:52:48 -0800 (PST)
Message-ID: <924893a7-5cd7-4328-832c-aaa01b9e04be@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 14:22:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
 <20251119155203.GA2125796@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251119155203.GA2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RkQsE-YffYon8DVzeuEZ1MNWxeDRIGIC
X-Proofpoint-ORIG-GUID: RkQsE-YffYon8DVzeuEZ1MNWxeDRIGIC
X-Authority-Analysis: v=2.4 cv=N94k1m9B c=1 sm=1 tr=0 ts=69202861 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=irR6kIv_Zxa5RKBfa20A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA2NiBTYWx0ZWRfX5f5E0/s3A9R2
 xpOZECA2D5oEm39GzhwfDuGWpT19ZKGXsUEUUxOPhs64MGg3vDZutzLGJtuKKzlB1u68A5KY4b4
 Bjwj5Fim3zgebaVS3oATjq6yiYAXv65oxvxyCvluAVtxHXxurJZQblfoSeCjjlhmBZHYS3EtnO3
 KPd/xzRzmOy60dT8sDy/j7S9jWM9u6TgDwrkIodqkJbSF6QBqNRAAKOiWu1HXoNga/JWg6aQUzn
 BVrSMAm9WFhV0X7aF9yyRf6wt1IIq1vWTHqfmqMTTrkVQtrpSVqBbflzBMq6Oce3SIXWANt9nvy
 2o124o29FGjjysZ/WuAGvbi4AZNbUTFutDBTju/Brq1GwXjF/GSiDQz0Yh1pTPcFgTsusqXrE0T
 uIFUIndyzfw83ADPrMjZTxPtUWBpNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210066
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

Hi Tom,

Thanks for the feedback.

Sure, will change to bool.

Should we add "drivers/phy/qualcomm/" to the ARM SNAPDRAGON section
in MAINTAINERS file?

Thanks.

On 11/19/2025 9:22 PM, Tom Rini wrote:
> Tristate is wrong in the U-Boot context, we can only use bool.
>
> Checkpatch also asks if MAINTAINERS needs updating, does it?  And please
> wait for any substantial feedback before doing the next iteration,
> thanks!
