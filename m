Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E97CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 03:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625AC84B02;
	Fri,  8 May 2026 05:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDrWGE83";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZF+sJEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C222384B0E; Fri,  8 May 2026 05:47:25 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725FD84A75
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 05:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647Hof681971771
 for <u-boot@lists.denx.de>; Fri, 8 May 2026 03:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2LHmi4ze9mzGPoBuLFs6CyKbDQ5MCFa4Bvj87YHcVIw=; b=WDrWGE83eFN2+2B+
 dcKBsDV//NNlmIXGQ4COVwdIlo34FHqP4afQq2kzDWk04i9RklXWd90oLMLVfbye
 bTysnTTeeH/Y3X8XdelqksvW+gmXHRUvkBrX+hRGKG0CxDeADxmQz+p1MJRRBMQz
 SxMBrZb6QbMw9iaKZDKqxm3EUR/RTXFKl5pivwf6/90R59265SgzV79jF/kv0sNS
 zRKbjT+/8VaYLt7zv9FmFZETwJoC1HsRnfJvl5sqcTd/q+qlDaQObSGwFC9+L7Gu
 hgr+Btvhmp7xgr3HfM9cURoeaSTqN1UUb+vi+TPHkKbDD6xbUMQX+9Z9eZyU56RD
 AYNVkw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tejb6x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 03:47:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2ecc96a9aso17391505ad.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778212041; x=1778816841; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2LHmi4ze9mzGPoBuLFs6CyKbDQ5MCFa4Bvj87YHcVIw=;
 b=UZF+sJEFGMeR5m+L/HdHygdFsdAwsUp7Jt+xP3KsFD2AkcJBOnfOksGOu3AYliY3fX
 SvSpS8H9lkRLRxP5B39lBcm0XS5rTb0e2VnZa+mhag9l5w+pxlXVwSZ2L94jb50OgcaI
 Yiz/KF+/KKry4JfNCfyrAX1SX9uTs67zYvHsDuoduKsygvGqDFgmYrme2QEYVgU7o9TB
 /rk2cxt7yf25A/qFxDLSjUefn82jZdRUZlcoC+FPppXCKySuvo/pieKMtjSTDdT1Q15D
 uzrMQ2CWUxTpVnLCwSiR7F2Dmk7AxupNVRXA2m4GXgrdwlkHa7SkSqSFzBPfMVUX2syN
 wQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778212041; x=1778816841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LHmi4ze9mzGPoBuLFs6CyKbDQ5MCFa4Bvj87YHcVIw=;
 b=LL7joepBgidrsWvSWzUXKU5AfT7dPWafFIBwHpfyuDVGQlt1ZqunCqOF3xOojqJ93Y
 hHD2YweS54wv5yotQQkFOg1pIU1djeFUQtNvBZ4qpY50olC2xw2yftfY2Y8UIkZTJEx0
 ZY1chiUCRRQ9hEtdulEDzWkYAqowXBePOHez1Ioahtze15EUPMYnHszSyZJRPKkVeITW
 AqyVOy2ehmZDnXh8CiAK4n0XwFYLB1TgFrh8L7HtFhR82BBXPlgzqoUjlJGtaK34/e6L
 nZaUcMdTr6ewFtIzxJbLKNr4dfnNmWSFvVllPBLM4DsB7JkpZkD0zitgtHshhTxDPq1/
 RZPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UY3IuwR+pesPw9RsHl5UhriB5dWhIaZwettO4U66p3JN3YBCON8TzvXMLpmEVsFHEfP2uZvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwPqgNLYd8fFUGC/hKp58d26SJG493pyM5nCt4b6Odvetw1Ok0p
 E1KhLtjXi3gxkDSECFxgvO8SvwoPXyj/ls5ZtlsKQsyHQ7wjVe5Ucsfb8p6xYGOHSlYGa3MKZ9K
 1mm1TQCqp8/p+7+u2R1xzfSEFjYIkoXN5YI6bWuk1PRRss6mdKcwADqx1
X-Gm-Gg: Acq92OF0fw6k4+M9Ue6sJgfH080y7mdU3Zam4egu8L+6DM0cCQSqTH2KVvivA1gV2UC
 VQKGeY3nU3tl7qsPVyvKgkUe1NPxC4J2SUFMga0AxtEqTzDhBdWNd0yG1D3Li8cIDqaX3Pn5MVu
 nqn27QZSpjTO+vsa7qpLubmf0pkAxfTANHefqMXPapUN03hBOFDT+gvdrQUfdusuWA+v1AXyx27
 XwaiVivwDQQmtb91CTLC+ydpEB95L8eoinQviy5US8wp6ebEXRTyTQrimP7QlRb1S4sMHd1UBBt
 YlxcIGOl6tSTsR0bqn3UNPnhcyaDsWEfmVsP01TxRwCgzd3KJYJtThNCTHSP0W5IHMdMcDbIrP8
 MUllbQNzKo/biDyuQe6+y3pf+nrUpYn+QLx5hGiVFRyvn6V4eWwsmBYm77ks=
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2ba79285966mr103891245ad.5.1778212040671; 
 Thu, 07 May 2026 20:47:20 -0700 (PDT)
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2ba79285966mr103890975ad.5.1778212040193; 
 Thu, 07 May 2026 20:47:20 -0700 (PDT)
Received: from [192.168.0.4] ([183.82.176.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d409eesm4084655ad.32.2026.05.07.20.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 20:47:19 -0700 (PDT)
Message-ID: <403bb698-be10-4b4f-9a30-df70847b61fb@oss.qualcomm.com>
Date: Fri, 8 May 2026 09:17:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Marek Vasut <marek.vasut@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
 <fa4a37d3-1eaf-4fbb-adf3-034d2556d2db@mailbox.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <fa4a37d3-1eaf-4fbb-adf3-034d2556d2db@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDAzMyBTYWx0ZWRfX0Gsrie4Iq7cR
 SlKfAHmZ3bzjp+Qc+6tsM2tIwKTV6sAXn4YfgGTRlUtdhl7utvUHSTcyRgjmSwvcr1nHY4s5d22
 R4hfbdBHW/kn6jjbqGPla9Gjn8jz/QFnBTYoXjpQMo5hKP14WydcbC0DmkDBHMAw7p19TCTQScB
 ozV8T5Kf9PebsoH32lDe7WzJWEg76AHZkFuXk5WE5wRMi9JcmTXnzfItYozWp45l8/tzCz8s8mY
 5UGc0i6I9t17vrHl3iMyprxNXSMSYcL2vxk6XlF4GT0XezoGB5B8LWW4s1Yzfwd+iyJJV7c/7Hm
 JMp+IBgJwy+OWVx2L/pIGaOOmycNjc0MlaQjyYYQrZmYohcKVuogI0CB5zt5lbkKpEnjnUXuy34
 Fa5CHrhW4v8redTB2iT1V2jGRUNU7gQlB2yd119E9UCWXufZMdYA+aTQXqrvCSV95o3yj6StRv2
 MVzZ8jTsO0wLhWZ1MOQ==
X-Proofpoint-GUID: 49ZzPwdIMjQbKM_k0aDmBzeMHgNXNmk5
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fd5cc9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=V7M7jId0lmLiNndmADAccw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=b3CbU_ItAAAA:8 a=AA8jMNCaXOnQbGR9nw8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: 49ZzPwdIMjQbKM_k0aDmBzeMHgNXNmk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080033
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


On 5/7/2026 10:55 PM, Marek Vasut wrote:
> On 5/7/26 5:20 PM, Balaji Selvanathan wrote:
>> The dwc3_free_one_event_buffer() function incorrectly called free()
>> on event buffer structures allocated with devm_kzalloc(). This
>> caused heap corruption and a synchronous abort when exiting
>> fastboot mode via "fastboot continue".
>>
>> Device-managed memory is automatically freed when the device is
>> removed, so manual deallocation causes the heap allocator to access
>> corrupted metadata.
>>
>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event 
>> buffer cleanup")
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
> Did Mattijs RB got dropped ?

Hi,

Thought Mattijs will give reviewed-by after placing "Fixes:" tag in 
commit footer.

Thanks

