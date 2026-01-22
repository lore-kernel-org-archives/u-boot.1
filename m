Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C8AC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCCD83A6A;
	Thu, 22 Jan 2026 09:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="czR/VIzd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dUOieV8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B9D83AEE; Thu, 22 Jan 2026 09:43:07 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF0D839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60LNX7gx647955
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nYvC7rbpLlSVq2kHbHiv4PvblBGrGwxvvutDv1VvEe0=; b=czR/VIzd8+UpiIBR
 gvQV+A8bIAKdoGpjE2AWFZD9JRiDMvI1MXURBia6cf2bQOxbfYMSBrUC+5nlbW2q
 pdMlYgRLcJUNqg+p34jttvMSPzQ8YIflgu/Bjt9lgpgJ0LtwP43Glgtps2z3G0It
 zkSkaL2xSGDhrbfGJah2RUSdUufKc/16eZ5Sl0AP7o/lRPTyWf4KTd6YTcDU/vKw
 f5b/eG44NfKvpj7zjcGkL8BfwlCdW3L2Zgr5BA2d3mx1MryYn6srIIZHsy4gkOjS
 HPaMfw2yFVJJVso5GEOOOOtI2AR5Bebj+lGpmvXYvfoSselSyn1cTDrWAJWScpvd
 T9yVXQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu8j9scsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:43:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-352e195f662so706209a91.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769071380; x=1769676180; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYvC7rbpLlSVq2kHbHiv4PvblBGrGwxvvutDv1VvEe0=;
 b=dUOieV8LAa0fkxjlIB9bzfBg5Zh5IUxKG+lNYy5D456iK7cQZSHlcIRzOp6i0e8vq2
 svzYpQ7baRYV6C4BTEI9/dghu3mfazN84dwFCFx+P+PKzFKgnT+U3FTLx6JnXmtD7ZVE
 bOpqGQXjzQ9rp0Y0V54IdUvQvpw3k6lug8zPNLxD8l5jqECLCEBvckvq9BIqhTW23MZz
 +2V4yybJhZV8NQqLVcRtpI/ByR3LBoZVoYNGrrYlynk3q/icO0fTuJs2OyQyhjjPq3Pq
 hwcRoDpe2eYdtE/XiQzggjCg3fvM1xX5IOVDrv5aAxzFTF+BrS/skOWA2guWk6T0gmUx
 ADKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071380; x=1769676180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYvC7rbpLlSVq2kHbHiv4PvblBGrGwxvvutDv1VvEe0=;
 b=uUkJ+Th0WrWZlnyqzsdrIK5y/a3R+QBKeQWlVIsCrBQx3IFexsUgTcH9tMf/K55eFW
 gl4qW/bRdb8ZxQBT+o3LXB0YtRCMczsTHu1LbfGB3ZIboaBJHGISUtYXGvf6vbtdb1qq
 8jLE9tttL8PLpDbxF9zIKBw0/UPzNHOCqzEfW58emD9qHhj6mHTOnTqeL6suXk/liK3m
 jR5YnT/YB1agzbPGhRmZDb3DGRyWauBpmF1pTSOAGVgkvez6jrs93vMSMqFOn3rJgO1k
 PtJbX4R0HkzTVqr0t9OkdD5Rwv7A0Hnqx0JmQZXthobC9y/fPq6TXz/MOTWwAzp7FHQu
 Gumg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW2jqOc9O2ZiYUex9y7NU9AS9SJcM8jrEl8Qks7ZtDGEsAjbvMtJfiaRjRSd5BAuDpOHLhHro=@lists.denx.de
X-Gm-Message-State: AOJu0YxZn5cXqSBZQrKd66fdx/Q4KJF9M9VA3iS1uQC2ihDlKKfd1iDl
 47E6nWM0SRcqf0e/quKsav38cavxGa+bvvWtAAgPgJU0DeawnqYF9MXWMvml7nzzUaJplG7+qZA
 LxrVOu0NXflb7uZqLMsdIbg48dJp7Dgpiq/7s7FjDAYeHpbtHgPqYOLEw
X-Gm-Gg: AZuq6aKLjXwsHPX2ei26LY0wjQuhp9xKs5wFf2IyGgb8ZTqmbClkxCUL2xd4LoLBRJ5
 lkuMsoqCH4CikmNyAHpQOPL1j2pZ6Z0y9LN2ZsVdugEq0OtBrAYID6Pg1qZRmEeGxIY3BS1aCNF
 Jz3/z4zpKSoIAh8qg9KPLj+4jvqVXO7vTrZ/iC+UqIBqbA9QpacF6RtVxerggUUGwhMu1NrUy7P
 dUsVbT1YnHn6dRCZiPsH5aGMUlOmqVsnEstyJgxCLaof5tWOYfiS/51/l+wc1qgkJI1qmYLnafd
 haJHK3Akvflem23qFx/NZ0zV9/4+MqpcggeCdquvibAYZb3PfxaL0q2DHV3wTqKvGIu4wmWI+C6
 SXslMYBcBMLXdWzuHtP4Ngx11pjOVDOb9YL5usRSoUkacCA==
X-Received: by 2002:a05:6a20:9144:b0:366:14af:9bd0 with SMTP id
 adf61e73a8af0-38e45e84192mr7257596637.70.1769071380392; 
 Thu, 22 Jan 2026 00:43:00 -0800 (PST)
X-Received: by 2002:a05:6a20:9144:b0:366:14af:9bd0 with SMTP id
 adf61e73a8af0-38e45e84192mr7257573637.70.1769071379902; 
 Thu, 22 Jan 2026 00:42:59 -0800 (PST)
Received: from [10.151.40.21] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941dda9sm167734785ad.99.2026.01.22.00.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 00:42:59 -0800 (PST)
Message-ID: <e6323297-32e9-40de-8b65-7aa65638c638@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 14:12:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, quic_varada@quicinc.com, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
 <20260116155735.GA4063961@bill-the-cat>
 <a8d1210c-565b-487d-9262-702980e45949@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <a8d1210c-565b-487d-9262-702980e45949@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sHNKEc5nfDduerS35iJ-jO8NL_lVxBMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1OCBTYWx0ZWRfX7zwhSXUGcy2w
 msGtf+b4TLIrsJKLwCFwREPKYZbo/1mbRSvIdC11WgQDPkHPk3aGZHWyljVPwrJ/vcnp1Ewj5Eb
 ZlnzEA9N/2I03eThRZXTOFhtrJGiAIBA0CFThc6PUO6C2/cZ4HITzgQv+R4yQWYiWmINjhWVoW8
 jgdqiFHxBI2gkYxKxTZdQn8XucEEV6nvQh9XgXW/SK0pyeREJD4v3XktN96oMjIR/srv92gHDTh
 PtyJfcTCDPxU8hZyikFCyXdb9NvTtNosnczgU0vwywaVzSbmaFUX901Nl1PG9F3J780cSjwo9sh
 ihuJ0UJyGTf3JxJVs2mU2fpMOks/EJaawDStDeNj+2lUzf+bx3VM0CgnhvaIZSRWusmyBBaL3Yf
 CNSjoK8XbzdepBgNaWoJeKLRSjT6hO6Uv0I8mIndtv3emWL9lpUE9g+2NG1AYQyB6Peye9ErJtG
 L2BeRai7R07e08e3QoQ==
X-Authority-Analysis: v=2.4 cv=U4CfzOru c=1 sm=1 tr=0 ts=6971e315 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3wQi5OahrvvSbnA_3_UA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: sHNKEc5nfDduerS35iJ-jO8NL_lVxBMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220058
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

Hi Casey, Tom,

On 1/16/2026 11:19 PM, Casey Connolly wrote:
> On 1/16/26 16:57, Tom Rini wrote:
>> On Mon, Jan 05, 2026 at 10:55:26AM +0530, Balaji Selvanathan wrote:
>>
>>> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
>>> ensure writes bypass the device's volatile cache and go directly to
>>> non-volatile storage. This provides write-through behavior without
>>> requiring explicit cache flushes after each write operation.
>>>
>>> Remove the SYNC_CACHE command that was being issued after every
>>> scsi_write() call, as it is redundant when FUA is enabled and was
>>> causing system hangs during large sparse image flashing operations.
>>>
>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>
>> This introduces failure to build on xilinx_zynqmp_virt and others:
>> drivers/scsi/scsi.c:85:13: error: 'scsi_setup_sync_cache' defined but 
>> not used [-Werror=unused-function]
>
> Balaji,
>
> The patch introducing explicit SYNC_CACHE made quite a few more 
> changes, I would recommend including a full revert of that in your 
> patch (and properly referencing the commit in question!).

Did a full revert of the "scsi: sync cache on write" commit and then did 
the FUA bit change in this v2: 
https://lore.kernel.org/u-boot/20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com/

Thanks,

Balaji

>
> Kind regards,
> - Casey
>
>>
>
