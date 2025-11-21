Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCE7CFA762
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 09:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67BB80433;
	Fri, 21 Nov 2025 10:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HedQMQ7E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bXaULSjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC768051F; Fri, 21 Nov 2025 10:24:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21ED801CF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 10:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AL88ggW1390845
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZtCdjjB67N6OXh1kqG5W3FD7UbEuF62ezuuiUaoOJtk=; b=HedQMQ7EE3kEnsBd
 /goJGibrrJtalpuxm2UYxQFiEiUnkeHXLM/QF6lW3bePzBmsnoUeUwgnpUSFFaq4
 6spZxQlxuVR3v5D6BNpwAKJ3uwZ0LhdwsltqkwrQty/WBKydqQaqKrq1juoAEnPJ
 X6cGonOxRiwsdkH0chpbVnmBmSOoEwyqdKhCwJKhan1BpVDSeBWvhojXupvauac8
 KP0JnI6WLbw/SysXF4K7qPhPU1Cio7F8bkVct5JWLpo6juwk8eJxz/Y5+eCk/Ohs
 MDMelSkGI95xLEz4KtVMJ+o1y6iKbad2bNn3aLCZzihp8uvr2b3+6UGJdKr3KYyX
 QKjmrQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajb531w2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:24:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7be94e1a073so4067955b3a.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 01:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763717074; x=1764321874; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtCdjjB67N6OXh1kqG5W3FD7UbEuF62ezuuiUaoOJtk=;
 b=bXaULSjF5nlYQRAiyY52COXNYDZLkOGtiAjf0Hzw/2Dy3u2EnP9NeSUTJqz+sOKjgh
 EOPoP2SQnaD7jycmsFAZzpRZHXnuPV82yAjIlpEeiimAu8ayuTwzMtvCaneIKW50UtYg
 pWlGwhT3BJrBs0ruMPDMZdLPuNc+Ep2CzYfVdOs8Ltfw0VQtPW9p9y2FxVlsQxXf4U8L
 wvaRTcxcBA9DzSns3GOPgxtXW/jJBye6ijXbh5rHxYalxOSqcPlUn+7ReCOfQ278+Gip
 upOQwwPrY/SuiSnJ9xVwuv6O61oAWLH1Hq5ig0lrn7EKESjmcMEQVL+a6uMFEWv6EUjK
 kbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763717074; x=1764321874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZtCdjjB67N6OXh1kqG5W3FD7UbEuF62ezuuiUaoOJtk=;
 b=OdlwNDQJCGOe9kOsS9jWapBOC5isrg5Q/ZDmU0yXNB6EL6iNiIkrvsV1cI2cstiZao
 kDU4EFwWvdwXXahOU1uTTF8PYYNkfIv5Zj4fZHKxucMWqMV0p0TJJBa/0+0lGIcMKuWh
 SRTS/uaZPdk9pOtXKvXCoSWxcc8zso3wWrP5LeIj1xesN5WUVLViJqpteZeOPf7oesrL
 zOBt/imSeun6zc1mkqGLBaKZpkzVIQGe6zBlMM3df7obqmCB/XUOuzAo2A2IrZTmswXY
 dHxVVlEXN6meNNKbh9JTAuKWA8Pmi4KjlHOLkyxErwWOLoX9KhLaJQgf2x1/VWN6GZ3M
 X+Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURELX16t4eSY7BqCou3Jzl9f/biRjOG7tzHkpkIeLG4u8+gqa1iGt60liSqKsEGZS5abmjIf0=@lists.denx.de
X-Gm-Message-State: AOJu0YxAn8h5WADJN9HEMOeFKcrcCePg6pVtFIj2m878npim1CDkQy8K
 NH0H6UloBAr0MUoDXK+b4tSpfrfanFDWc2KNBNhGoHdUxL9e/GUCM7COIhqFyXcNeOQZ7siuD1H
 fgUsX7KlnDSgCmh36dzwn9cy6+g+DeFXmNngGKp7oMqxg23/G6358vsMs
X-Gm-Gg: ASbGncvRf6i207tLC/oA06um0ogZhPD4ecwKYBfrYkWYkgXZg3lteqBJQSfQPrXIDeF
 /4j1UtUYxIU8/7cEhJk7uD4NNhYvIOnv4+VxSPQDBEtybLiBFQDa1a3jp2io/u9MSyQ+CNPA43q
 Z0CrKhvsPL0oTU02ZH6cG26SclzOO/aSGFkR8qizlLQCkyebxC1V//PNjeDsIh186TIc4D4NGSZ
 ETGB6plcu9Tbzw+hKdFFy6Fk02n5PhmvKxhtYXS6hoTrp0v27RVCfnCw2vpWLCG0UNFOc4kESeG
 XVrFxzkcQGGxpAt4kYkIrVGTAkJgxVZ2ElFxx4u4zhk/IsqB4RsyEV/YcdDgnZIdQgp2oB1k1Lh
 QwL0LCDm2YdeMNCQHv75auq8KmkCowwXpQaRxYGJV+OgZvA==
X-Received: by 2002:a05:6a20:9389:b0:35d:8881:e6c6 with SMTP id
 adf61e73a8af0-3614eb0ff86mr2271010637.19.1763717074268; 
 Fri, 21 Nov 2025 01:24:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdF5Mo83deLTG1HCM92A/DGYOKDwkehwPKK73P4WeAMdE3mKjO23RsrtIvxeFvknIQnAwQTw==
X-Received: by 2002:a05:6a20:9389:b0:35d:8881:e6c6 with SMTP id
 adf61e73a8af0-3614eb0ff86mr2270973637.19.1763717073622; 
 Fri, 21 Nov 2025 01:24:33 -0800 (PST)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3ecf7e08fsm5407632b3a.10.2025.11.21.01.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 01:24:33 -0800 (PST)
Message-ID: <21d94821-a339-49a6-af50-6a93788a4f2d@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 14:54:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
 <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
 <CAC_iWjKTeNTwyQE0KoAApF_qbd1c6ftTnU8jx85sVNBTnYJoRg@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjKTeNTwyQE0KoAApF_qbd1c6ftTnU8jx85sVNBTnYJoRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pAOTJn1Nmqiroo3WY0XeNVU_AVMssWP0
X-Proofpoint-ORIG-GUID: pAOTJn1Nmqiroo3WY0XeNVU_AVMssWP0
X-Authority-Analysis: v=2.4 cv=Wugm8Nfv c=1 sm=1 tr=0 ts=69202fd2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jtQ-uLUPr5uBQXK0gecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3MCBTYWx0ZWRfX23HXWIwZk+pQ
 US9dz22XsoFeQIkIX0o27TkO+0E5kC3mpk5pT0h2zwdPNJQmpZbMYOZJyILXLEOzg5aj6xvOUl3
 un7bo2721o+znUth2kAKrW42V4Q5syOZczmzF/jvHUPPCUKuOUQ3iH2zMRm7xpKqSdAVbPKvbW8
 sovM/lwQLoTqOKFzCFe7+28pWeRgz19WlGbuy7+gJrfzYdfUIsNf1Uy5CzOyP17xPm5oD82ab3h
 FSZRjNtTaGfphyrbeRBuQFmfF7GYFmEusomjATpYf3NbgVOA9h1Jx84htiVN5kQsw6cGv7kZ+mx
 GK3lsQklpIgbCjF7csRCzK6U0WTG7aXQb6tCMI8wwjJXQJUqb4T6+ypgA/E3Clrh8QZoBvTRMJF
 0E73qAglzlI3yQI7l/nj/ZY/L6SnKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210070
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

Hi Ilias,
Sorry for the late reply.

If the boot option generation logic skips partitions, then the boot 
option points to whole disk.

But when capsule update calls device_is_present_and_system_part() → 
efi_dp_find_obj() → find_handle(), it tries to match this boot device 
path against the ESP partition handle which has path longer than boot 
device path.

The find_handle() logic at line 142 rejects the ESP handle because:
if (len_current > len)  // ESP path is longer than boot device path
     continue;           // Skip it!

So capsule update fails to find the ESP partition.
Based on this analysis, I believe the fix I proposed would help address 
this issue, but I'd appreciate your thoughts on whether this approach 
makes sense or if there's a better way to handle it.
Thanks for your guidance!

On 8/28/2025 5:53 PM, Ilias Apalodimas wrote:
> Yes it was. In fact the original patches were adding the file instead
> of the disk [1], but we had concerns on scanning all partitions wrt to
> boot time. I don't remember if anyone tested the boot time though.
