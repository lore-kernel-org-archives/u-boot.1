Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7092AE67495
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 04:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F6583C28;
	Mon, 22 Dec 2025 05:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="koM/R5om";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="et0JUld9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B735283E16; Mon, 22 Dec 2025 05:31:53 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C2683BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BLLarwk2997395
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y8X1uETkOeWdTITLk5hbyhhtPDnzbkEt/mUxMGpi8+U=; b=koM/R5om2en7xPH9
 jNkspG5jrQHFy8Vh07uU5edLBEc+l6/cnpzhYWDlvXItJOQhfppY316DMcB7uRfj
 Mqwr1GqHCKfDMtAzl62CG3aHPkUgVd3YQvODD0veicWbXF31Os809U4cMSrs9Lfe
 iX3euldw9OHVIie56hEF+N069SvslBa0ZGeKcQcCNsQJI5XWTLfWogVWZuifvTzb
 GwUhs56UGkDLIKMWEGlKJJ8FPSKNfW6jbtg1g4Of2A8w9DS9QlrHgMNtto0lg4+u
 Kd2tqcN8SPUm5w6eISBi8DOazAf5fe6grEx8gmFKYU8ZFBSZurIKTheE7v1lNk7U
 0Qc+5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5n36kn2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:31:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34e5a9de94bso7710218a91.0
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 20:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766377909; x=1766982709; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8X1uETkOeWdTITLk5hbyhhtPDnzbkEt/mUxMGpi8+U=;
 b=et0JUld92wctH7Umk4KIKUKphZag1CNpUoI9xbm6sXwU1tUaibtxeqPJUD+6sKO5iS
 3adwtj3VYdB2x5mAdCMYYoSj8O8C8mqzX67qahEwLXCCxYIcJYt1Blxmp7j7hrQQE6rD
 T+puj5oR/KSIaUsY2p75WV1JhLpv9zQw45Mg0uz8230c5x2Q70dOWg691hYpswBW/uZE
 RPC5SPITUGBzPPCL5ms0OqLvBzp0PsNb9J/zHGCSyJMfPOj/9MJqo1vSRXTGWZLPjjiK
 SK1c5AFma7J4F3tURSOPsuH/5w0+Zs+wLpkAqLvqFFFo51xcgDEFNhCyYowu4QK1gL/T
 BKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766377909; x=1766982709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8X1uETkOeWdTITLk5hbyhhtPDnzbkEt/mUxMGpi8+U=;
 b=AoDHQekKHWzj73P3cAVF2xEfeN3LbUFiw1v44duekIYueYa4wjscZuWlO/fgalt7ot
 Y3DYN71k1tKdN0hlP1Da0nH90F2Ll1Y5NNCklWX6pRAvb8T8ILrBuStpCkxGujL/ko5Y
 gIDyw56MD+DBR76sgRMw++gAaYjcRT33EOjfcVv5+K1SbxuoW6kncyBYH0EX9cjJWnMB
 oRZ1v+uLB9NJclolcCeFAyg0aY+BKb66eieR4HkUe8jzCYlW6A2d69Nt0K0U5eS3P6+A
 LkL5yE8XJ62vJNjjASZaijBEvPBSTlZwYShjEFa/243GaWuGx0IkZhuVbJrZoFB2Pm33
 y2KA==
X-Gm-Message-State: AOJu0YxCiTYVrRst5eKj8VtRG0AnLRawDBwyH6MupxV+++yEeGIpDcCF
 mvWCE2/04g4UnmIp2sQHIfsHNZrw8zNkIMPSp76W99SszoAxM0FM22uf6pDJt/0eSzQu1zinOpR
 3tvYcnQqMzUU4PzNYq+2UAdgX3Qz/mBQJCuaXJuHD79OBdm6jC/idL+VdhZVcz2BzQEc=
X-Gm-Gg: AY/fxX4JflPlLeutmSdh4dJ1/TG7eg19ER3xHttFV3SXiDBDG2RZdThKgnTDpyt/LDu
 OKZ+n+e8E4AX7Z8Ix5oztk9Xf+xumMhyYs4k2WjsXdFXt5tlAWUaBYAUQaXi2dB5/HOZyWQAy1H
 WHzIXIS+5/SA1QDL0OdUo1t9Axza/k7L+meAxLO+TAknKxQ1oRpHnxLxibUXy7LaIz8mg4GEMC8
 XpaPrWB6hOG5+1HvHrSfiH8gAE1lbTVLSYsZbcPZCnM5yrU7OVBMiRPwxCnCxK25zO3N1k/js/Z
 aD7cZarLsXMg62lfwVXSi4yMEr8kFRZMhX4lQZU2+zIHEbzkIOalUquOzIIk7VF+VxBZUaWMwfi
 FxlJcsdmpd4Z9ord3EZv/AHtJJtMWoxgqGCf4TuCp4LXHbgs=
X-Received: by 2002:a05:6a21:99a4:b0:334:a180:b7ac with SMTP id
 adf61e73a8af0-376aa4fc458mr9254098637.39.1766377908639; 
 Sun, 21 Dec 2025 20:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTnxnN8i2GRSINvby5OZD+9xQQvQJqtocWwmC7sc1UmXCjBLa3oYBQ+eGG/9uu2/TEyikueg==
X-Received: by 2002:a05:6a21:99a4:b0:334:a180:b7ac with SMTP id
 adf61e73a8af0-376aa4fc458mr9254081637.39.1766377908156; 
 Sun, 21 Dec 2025 20:31:48 -0800 (PST)
Received: from [10.151.41.129] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7ca0baf3sm8118132a12.34.2025.12.21.20.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 20:31:47 -0800 (PST)
Message-ID: <8fde0106-ee25-47ba-8551-8f203c9305d9@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 10:01:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat> <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
 <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
 <CAJaLiFwyGy9aXD-6m8=Zj5ecdhuaKMtHDnhyz4YqzVHNW=ZDTw@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAJaLiFwyGy9aXD-6m8=Zj5ecdhuaKMtHDnhyz4YqzVHNW=ZDTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAzNyBTYWx0ZWRfXzwUyJgzXo6Vx
 RG7ooVTR/f8mJktL3Z+SdF6STlIh1Jzf/Tt5ZnSime8G9qOWPBj+hOUeV5N+sEXSWGlpJI5Xpk4
 F8pq1iDZRbhGBk3WJSs2i+MFM7KTnYZqHZcJsGKbPk9Jy8iYAADlunzXTgrbxRtv3LyMgiHQv5o
 PPp4SjrUo+A4k4Sy7TMDGnvnhkwxKRXMuqy0C2iSrKUAFkea+JfJnllSrMLEFVlvLNVHUGaWtn7
 wX8RRd+fBSQ3o4ifIqwPs0TRhcgxoBFl4w8SsK2rd8BazbHTV4rsKSoO+Knv0bQeCL1ziVCp4Qq
 lbNIt5yo050xqyfBBhIdMjdoklbVgu3cgLL80HqEXH4ks5gVua+Sr08SI7ijo9O9HePspPz4wic
 pLbRc+so2IKbroN3HZ55eufFdpP6ZR1i8+5NjHuexMpiUikHNDbmOMaMSE++AT0kW/uCPcuKQYV
 lhBrI9Kkes7svDuyYaQ==
X-Proofpoint-GUID: LuZ-6sG47PR5kpqz2fYiCpQ3ZTnhGrQN
X-Proofpoint-ORIG-GUID: LuZ-6sG47PR5kpqz2fYiCpQ3ZTnhGrQN
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=6948c9b5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8
 a=3de7Tn7RJ6-CeAIfmwgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220037
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


On 12/20/2025 4:03 AM, Tony Dinh wrote:
> Hi Balaji,
>
> On Fri, Dec 19, 2025 at 1:17 PM Tony Dinh <mibodhi@gmail.com> wrote:
>> Hi Balaji,
>>
>> On Fri, Dec 19, 2025 at 8:29 AM Tom Rini <trini@konsulko.com> wrote:
>>> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
>>>> Hi Tom,
>>>>
>>>> Apologies for late reply. Somehow missed the mail.
>>>>
>>>> Upon analysis, it seems the most likely root cause is Tony's 238GB disk
>>>> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any read
>>>> beyond block 268,435,455 blocks enters this path.
>>>>
>>>> 'blks' is decremented both inside the 64-bit LBA block AND after successful
>>>> scsi_exec(), causing incorrect block count tracking and (most likely) the
>>>> data abort observed.
>>>>
>>>> The fix is to remove 'blks -= blocks;' from inside the CONFIG_SYS_64BIT_LBA
>>>> block in scsi_read() function.
>>>>
>>>> Hi Tony, can you please check with this change?
> Confirmed that the above fix works fine! I was able to boot the Linux
> kernel from the 238GB HDD.
>
> All the best,
> Tony
Thanks Tony for testing.
>
>>>> Tom, shall I raise a new patch for this now?
>>> Thanks for looking in to this now. Yes, please post a proper patch for
>>> it so Tony can test and add a Tested-by if it works, that'll make
>>> pulling to master before release easiest.
>> FYI, I will be traveling a week from now. So it would be best if you
>> can send the patch in the next couple days. Otherwise, someone else
>> needs to do the test in time for the Jan 05 release.
>>
>> All the best,
>> Tony
>>
>>> --
>>> Tom
