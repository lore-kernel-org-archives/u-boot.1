Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBB2D232E9
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14BEA84158;
	Fri,  9 Jan 2026 08:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCQQCE/4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRgbEhlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D5984314; Fri,  9 Jan 2026 08:16:29 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CAE8414B
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60950TVh409337
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mcf5qCNBd8qi8SPv9sA7iK7j4//bgtTNAKzM1Sl5Gzg=; b=bCQQCE/4Wqy+4jgH
 kRYAJvvfygyIz2LoIMP0butI4tQDQVQ/XqrPWRbgXDQ+cnJ7l7k0qifeoxrmfuxk
 0yXE2ZwExqRS16nF6HLpXeeERgHVlY9JxWilkHI7Er1ZMfRLKqvC4ry/NRKachvV
 +9H/M55e/GBbAhyhkr733UuQm6iDIpbJ5RGJ/tDLh9qNpcmsqFNNTs1ttbyojDeF
 YRKI8B4M+JtHyhI+K/k51w1IJWVceMulsKSfS8I2qmww98OV3ReQcjuBAjIfDC8y
 F/wa7L65eUWI36BSzku7N4O9W6b6iE1wCu5aMgF6hxBIjYO3zRpIU21YEZV2KUx+
 LmREFA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjb39ua7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:16:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c21341f56so8353621a91.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942984; x=1768547784; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mcf5qCNBd8qi8SPv9sA7iK7j4//bgtTNAKzM1Sl5Gzg=;
 b=LRgbEhlJ1Qs4c6aB4X8Lu/ggc59Jhv6Iyt94KLQIkJ7n/6tP7kyEnXJ5UVIYfMRmd+
 VABlKjYLb7ACEMO6HM6fHk/ekxUI7lYhDt3URfV9SUTveQIKm11LWchr5GtLNkxDKP21
 R6ebBhkrMGoXcTUfFar19oJTuCYCVBKqAdpzfGxhYwlI8002nL2Yy9hrBbdlltdyzAAO
 JQlbaPebkGPDaxiLDTZEpojdw52CJ25jTtVK+htvN34cMVsVBqQfGmb7X1AErO3IJPyF
 2xiIt0/XvxrnuCu/8iur4BGvugoaB7E7YmRcs+TwoXaglOp/xDj1bgceLMRzTYX13Da6
 Ccjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942984; x=1768547784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mcf5qCNBd8qi8SPv9sA7iK7j4//bgtTNAKzM1Sl5Gzg=;
 b=NC5bue0E+x67wVWEcaG0854HlpBtBehcBzwi+VoZYtM4cminKwsqu0LA0grO1i9hqq
 cNO9AwNLx7OFV7rgTT9KUXYhsMCSkh5NbSJneadwUbmX5JEGndovpkp79BslncHlGhev
 TTUYBl8yJanXFGCOfAr6nZBXYGaiT9kWNcz01FAU2S0ZtiyTv3/0BFAscGcYyE+SW6v8
 r6VFEKat8EpIyyjfR8tAEdznU0TgFAly9zDF5ZhcoBeswRUG7gMagTNGUN/+g87XK2Uj
 knmyvXjxgRgqU3HoJFL2NmFkVWft1X5nZsNofKgLb/xGZwe2QDEuquxkN9EpXHXokV5y
 qI+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVZKyqkfCoaE+sT42kKYtmLGUAhw++xzp75tARTmyjBjfS/OlEXk6figzmsqIMwQbzqP2RZrc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw+Xv7NqXADp0YwgtymMYAIjwTz8ZbJFg5xGswGPo7HsPbSa9m
 KtG5a+hd8gfXIhGEqUqSTwVpwmRYWS19z1Goycci5sRvnItsN4o12wbhIbztcqU02pWHFsT9cGN
 lLyowvEh/wGEBz6ZhenU9WK7Mtfx43sVkSyfNQBIY99mHg5Lt5CpQgFeX
X-Gm-Gg: AY/fxX42uW76u0caVGvGEGDypLe7TJ2luPIIZXVUWAVe/Y3dYlF695HhmJG3fvRNK96
 XKYEmixfUgqDClqWdFs+QNwwlg9FRd7hpZ/wo6+c8bvmWnKqWvPf0IHhjWvQ6RNmgTRQaRtko8R
 NmEByltr8K7FfCuTrYuPY/rAJLbe/XmiHxchDWsVTWyFgv0Q0z1T4ExFbM5ITUZr9bdTvbGFQ8W
 ug6Y2X6Mw4T8Nn243YlHv7CcM4pSUe0YvEAm7s/fydbWIjkHouSX57OMKI2+7I8D2SWzP31DtYA
 VdxAAI35kr+ZZuEwiNV6lkehVFYZnBALodw3D+U78AeAOWfx1ilaXpKN5BUo2Hazb/qFZmmQkts
 vf5B4QE4rVmgAHkeJS4pZtmLuUxWuoTmMbbzBiKBx7NpjHbc=
X-Received: by 2002:a17:902:d4cd:b0:2a1:5d2:2e45 with SMTP id
 d9443c01a7336-2a3ee4c42b6mr92820555ad.59.1767942984504; 
 Thu, 08 Jan 2026 23:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXWc5WDrQn7GD3Pf1MRT30naeL3yfzaV797iMBGxEz14cK1LD4oSuOfgoFUpvCJqaK/Thow==
X-Received: by 2002:a17:902:d4cd:b0:2a1:5d2:2e45 with SMTP id
 d9443c01a7336-2a3ee4c42b6mr92820375ad.59.1767942983966; 
 Thu, 08 Jan 2026 23:16:23 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc8ddfsm96402425ad.74.2026.01.08.23.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:16:23 -0800 (PST)
Message-ID: <00bb6161-4665-47b2-b7d5-78e4590c82a0@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:46:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
To: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 joe.hershberger@ni.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
 <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
 <20260108143252.GS3416603@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260108143252.GS3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: anqoHeUJRZ8VK6zGa_VipumuSaw8RqVm
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=6960ab49 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pDgTZgDHYo9fn6xZCxMA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0OSBTYWx0ZWRfXzumIF/J5fgya
 t2EuWHLulBeCffnfxbYjuPuFSCtCeyOHgV1O/0G1tWRMi35bEiXD1XHFEGr0v6Oe2wulpaezWJb
 FsgoNEmktbtZNjARqeqVYj3MZTvhAgGkN46YJtVQW6aRMawmSfhJLHuLYUbE+y8bILlP4W4FEu9
 DvADxp2kTkaOXzy/v0XxCyJ6b6HIG7DvMpxCiusnkvpi1xfIIO25f/L3JMhBby6ALqM5Torn5+j
 YYufFaCuNufVHT/RBJ8erQKfdbRr+hdxSvqIB0AegmfoO7OLs6Nt8xP3BtwxCQN0c7G2K9GVx7u
 3RK38t1LAeHowThFVAvmQY3MVaYNQ6YNPb9FqtdKiSD6/w76qDAJ4z1W8H2OfEjEEHH5dXz03Rr
 W5hXZ9cylcDDYFpsbB8D+v+tk5Y1g9Yqj0+DnLWJ1NaXi7SAcW3UqDrYOe5+Ei4X5Lk5BIanDLL
 VkIy8cIYnKh5u0RfqwQ==
X-Proofpoint-ORIG-GUID: anqoHeUJRZ8VK6zGa_VipumuSaw8RqVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090049
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

On 1/8/2026 8:02 PM, Tom Rini wrote:
> On Thu, Jan 08, 2026 at 03:11:37PM +0530, Varadarajan Narayanan wrote:
>> On Thu, Jan 08, 2026 at 12:19:46PM +0530, Balaji Selvanathan wrote:
>>> Add support for locating SCSI environment partition using GPT type
>>> GUID instead of unique UUID. This enables the saveenv command to
>>> work with partitions identified by their type rather than unique
>>> identifiers, providing flexibility for systems where partition
>>> UUIDs may vary across devices but types remain constant.
>>>
>>> Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
>>> allows specifying a partition type GUID for environment storage.
>>> When enabled, the environment subsystem uses the new type GUID
>>> based lookup method via scsi_get_blk_by_type_guid() to find the
>>> first matching partition.
>>>
>>> This change maintains backward compatibility with the existing
>>> UUID-based approach.
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>   env/Kconfig |  7 +++++++
>>>   env/scsi.c  | 13 +++++++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/env/Kconfig b/env/Kconfig
>>> index b312f9b5324..97cb3d05daf 100644
>>> --- a/env/Kconfig
>>> +++ b/env/Kconfig
>>> @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
>>>   	help
>>>   	  UUID of the SCSI partition that you want to store the environment in.
>>>
>>> +config SCSI_ENV_PART_TYPE_GUID
>>> +	string "SCSI partition type GUID for saving environment"
>>> +	depends on ENV_IS_IN_SCSI
>> Should we add
>>
>> 	depends on ENV_IS_IN_SCSI && !SCSI_ENV_PART_UUID
>>
>> and similarly vice versa in SCSI_ENV_PART_UUID since the code seems to
>> handle them as mutually exclusive...
> If they're mutually exclusive it needs to be handled in a choice
> statement.

Thanks for the feedback. Introduced a choice config as suggested in this 
respin: 
https://lore.kernel.org/u-boot/20260109070912.4106466-4-balaji.selvanathan@oss.qualcomm.com/.

Regards,

Balaji

>
