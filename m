Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04837F8FA72
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C62683E36;
	Tue, 21 Apr 2026 15:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bu0eETE9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q0gzWuk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0EA840A9; Tue, 21 Apr 2026 15:08:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F324F83A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LAirlc1510952
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Cfx9sly2ZQUDmIlQhklXlUG6HusSyFy68f5HqAbgRQ=; b=Bu0eETE9Ozik/10/
 4UEumV/tqwB6XBayjltHPmQDAvxNpgzp8UPQbhjPg3xZkmUREhsgjm62mCcRGYK1
 tTaZIJmJs9ifQfT0THCDV1hAlm750mlXr+Cyc54ssLt1QNr2YX30vjds8nCRPaUc
 i+gWUN4KMcj0UegJTakZr1YkBDe3cbpEm1dvZAv3GSSIh1EA97EuYQVfxZRunC82
 8vTfh9rxJ6LbGm7otyLW1d0WvJoSS2xNju9rdBYn+lM5fA6TPO13oyAO9P00Z8hl
 PUj5Kq1lPfiL1Noq5JjaFae5+8BFPl3FrSzDPvB4cW2k90dAEJfR98KPmcKJeVTo
 VsnDFg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp2ak1ugp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:08:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35d9467e85aso4409310a91.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776887; x=1777381687; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Cfx9sly2ZQUDmIlQhklXlUG6HusSyFy68f5HqAbgRQ=;
 b=Q0gzWuk752P3DyIzcMf/9Y9efayTBW45lb82Co1FYOyA8qA2n59p4sfX5b99bJduqd
 0umpMtGvVQk5v0CMWF5hr6hE+a3ZPHSqMZoGMMoR6EHTQ0PBY+R4I/MXlRzj2GAuxgFF
 xA+BT+4Y1lN+jElRLxjldf97f22nrzaM5zTGJgjLH/3YCvTPeIMktpK2R5+6vOcx44Hv
 8pwI1E40YJSRUwNUw38HTcDLNLf6toi/pgZjQNu65vNYUYg7S8rJtYwRvZyyP3kfi5Ym
 NxbcxQwIi1fb+Oxe7G4yBbamLqOLqgo3No1mFl0DJQn8cH3rBLY2XYrWgRD6SFcJ2rwZ
 d/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776887; x=1777381687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Cfx9sly2ZQUDmIlQhklXlUG6HusSyFy68f5HqAbgRQ=;
 b=sUgC5pJq0PLNb3ySxZPuVaZnHuGkk0i2Oj/J65+cnK52L5efBDnw033P5bKQNMsMrw
 LNs72kdwq/Kv+IfFlmt13yJgVy6XK5WSIiFj1P9OxKcDyoqkOh6NAYsNm16Bo8sZ+BDn
 N5QSSQ25GiEdUU8tAJ3CYdIFiccidlUGX51648JqblIjDgqPv4y6YcFfjD+rLghXlZUl
 TYL99xqPLvUChurSMEUoj+ajmGJRZVsTsMT/+ekr6xMKfnoNNUT7q1tN8dx3zC56VPp3
 e8Qy4RB9f1WP9M+t+2/eFD8mJHPs37jwfRPHQFzHenBveFUGAXoS8UPAQErjq1BA/fGt
 AUbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+tu1YG5/FlXyjgeWUf3L/QbhIP/Ei21GG2CkEJGGc5Q4Z9hqp27wvRddapR7n0JYZUvbwXsg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb6pD3Oe45gw2s1XD6KgIzktugr2siY6rvkXo86dRf25QTUpd8
 SVIiYKxstXpaMPrlUTwXRrQYDVPR4/UqrayZyGUkKAikcOD5wg3qG/4xm7wzb6eCn3ZrxbenqLt
 YD4YYsaVnziaWfvKVMRZGIc9SHzEgABi2Cxio0HhO50T/XVsWSsPdujj3
X-Gm-Gg: AeBDievRxRIPBHWjGbmZvFlq0EhZ0AkwC+Cz59xORM36ozQg4itxwmt7IQGAr7Zo+QD
 npa65XHcA1azYj470ddOFLCJPJDC9OhYRITUD4DRI/vs9ZLAvme6V/J61N8i9yRiwhvnlzLCAZa
 fZ0sZrk8QFM1QzSaIf78T2Ib6EJutnpB5Gnny9F8w0dJePJAWkuF7Rvk4FWhj7QrvSjDEUilS5Q
 bZBZkivpGPBYsHgIwmwd6ctEpCUorem9431hQyWUuSVzCcqVs+0tRTdgzUnNxPOxH7CSenhQ508
 juOw3ohXTts0BpBaoZPMja9K9auBifgMwl6l1O+KWmRrXNxaJ1vaGUBF7rCZfTOC7QoB17Z30X4
 OiPSDP7F/tbpqvymHSN4vFcXph0H/zEEB9x+Q6yl+Cw1nl0Nq85MdUNGdunHyQLaJUmcF
X-Received: by 2002:a17:90b:278f:b0:35b:e4f8:7cc5 with SMTP id
 98e67ed59e1d1-361404a5988mr15704381a91.25.1776776887244; 
 Tue, 21 Apr 2026 06:08:07 -0700 (PDT)
X-Received: by 2002:a17:90b:278f:b0:35b:e4f8:7cc5 with SMTP id
 98e67ed59e1d1-361404a5988mr15704332a91.25.1776776886713; 
 Tue, 21 Apr 2026 06:08:06 -0700 (PDT)
Received: from [192.168.0.7] ([183.82.177.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa92c428sm157616225ad.0.2026.04.21.06.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 06:08:06 -0700 (PDT)
Message-ID: <8a98b441-b765-494c-ab53-c6cb2dd663f1@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:37:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: fat: Limit transfer size to prevent SDHCI
 controller timeout
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
 <a8c8f3f7-15ca-49b2-872e-aded2a424ff0@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <a8c8f3f7-15ca-49b2-872e-aded2a424ff0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=69e776b8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=wgjzkBLg20+cMgJN0zysmg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=H_SXT-ECsLmEC2VvKS0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3_MylelLDHIOReLD-DaoZ4-RxgxUMEfa
X-Proofpoint-ORIG-GUID: 3_MylelLDHIOReLD-DaoZ4-RxgxUMEfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzMCBTYWx0ZWRfX+UedGy0NLZnv
 B1Qo2AqmPE52LrOEbvU679nT/98PhaO8E1jITq3h/8gaFhAI3YNy64wQ7dawjgyOGQeJLiBxb/V
 R06tmdlW4fS0X+mRjFRy/LPp3pzLPNh7tfNA9NwNY2vIMKhvE48UhOOUOyDC7hCBX8hPLeFCwlp
 sOePJvKZAJOuvDdQzpA92jGiqYPJmMHVqtMArV+BIJDysXTYwrIccfbIKODxKfsswq9RXF0Ohpk
 YB70vUIhabQFbenaILAQypL9+GEaDnDS2s4n6on7TTTxUKZC/mfEqSitWD/+7ybXWClP5kzJbBt
 2zoM6+WdAOe2CQBvL8J7Mlw2TJN47kbcvYVO4+kEh/nmSG+fBWlepdIqhkZ6/BjAELZDsw8Htzx
 IHFbx4w4mNOgiCjAjm19SZ9O98Aaj5pV9mVLuV2CJjuCiV4/N1Og0pjwAZ4eD4HBJtN6l18zo+4
 Kasi3oWMCVneqcXQVig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210130
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


On 3/24/2026 5:26 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 24/03/2026 06:52, Balaji Selvanathan wrote:
>> Some SDHCI controllers have limitations on maximum transfer sizes
>> and can timeout on large block operations.
>>
>> Break large read and write operations into chunks of 16384 blocks
>> to stay within controller limits. This prevents timeout errors during
>> large file transfers on FAT filesystems while maintaining
>> compatibility with all platforms.
> Shouldn't this be split into two transfers at the MMC layer? Perhaps
> with a quirk flag?
>
> In fact this seems to be already totally supported, just change
> CONFIG_SYS_MMC_MAX_BLK_COUNT to 16384 (see mmc_get_b_max() in mmc_bread()).

Hi  Casey,

Thanks for the feedback. Addressed this in v2: 
https://lore.kernel.org/u-boot/20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com/

Regards,

Balaji

>
> Kind regards,
>
>> This patch builds on top of the work from:
>> https://lore.kernel.org/u-boot/20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com/
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   fs/fat/fat.c | 29 ++++++++++++++++++++---------
>>   1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
>> index 85b511f75af..6ec241af584 100644
>> --- a/fs/fat/fat.c
>> +++ b/fs/fat/fat.c
>> @@ -30,6 +30,9 @@
>>   /* maximum number of clusters for FAT12 */
>>   #define MAX_FAT12	0xFF4
>>   
>> +/* maximum blocks per read/write to avoid SDHCI timeout */
>> +#define MAX_BLOCKS_PER_TRANSFER 16384
>> +
>>   /*
>>    * Convert a string to lowercase.  Converts at most 'len' characters,
>>    * 'len' may be larger than the length of 'str' if 'str' is NULL
>> @@ -136,18 +139,26 @@ static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
>>   	if (rem > blksz) {
>>   		n = rem / blksz;
>>   
>> -		if (read)
>> -			ret = blk_dread(cur_dev, start + s, n, buf);
>> -		else
>> -			ret = blk_dwrite(cur_dev, start + s, n, buf);
>> +		/* Break large reads/writes into chunks */
>> +		while (n > 0) {
>> +			__u32 transfer_count = (n > MAX_BLOCKS_PER_TRANSFER) ? MAX_BLOCKS_PER_TRANSFER : n;
>>   
>> -		if (ret != n) {
>> -			ret = -1;
>> -			goto exit;
>> +			if (read)
>> +				ret = blk_dread(cur_dev, start + s, transfer_count, buf);
>> +			else
>> +				ret = blk_dwrite(cur_dev, start + s, transfer_count, buf);
>> +
>> +			if (ret != transfer_count) {
>> +				ret = -1;
>> +				goto exit;
>> +			}
>> +
>> +			buf += transfer_count * blksz;
>> +			s += transfer_count;
>> +			n -= transfer_count;
>>   		}
>> -		buf += n * blksz;
>> +
>>   		rem = rem % blksz;
>> -		s += n;
>>   	}
>>   
>>   	/* Do part 3, read a block and copy the trailing sectors */
>>
