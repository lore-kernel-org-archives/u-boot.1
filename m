Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9444F8FA72
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4544A83E36;
	Tue, 21 Apr 2026 15:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSFPv/H5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jE/mA36q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEE083E76; Tue, 21 Apr 2026 15:07:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F68283A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LAm4bS1511084
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6IJeLVc27K8/M0aN7u8utDbpeBeBEZ5LjYtl5f5NUNs=; b=dSFPv/H5ae/yPkAa
 y0Crz/Flzxj6p0473hsYyyoI8zh8ssCB84fniDtDmlT7nWjAP5uqwsOZ+XPm/nNU
 oUToxjoemVstanUrRq0/DCsMgp3DMl+RLMD1sJJLFNiMA7r3Eq1JpOJe9kLk0f73
 Wf8z0h8bHWbV7qak///uQtNhve5FAVOMb4EiE+a/OOH3yt57rES0aMXsohKWSMsn
 Zlyr2WDkp0T6nvTIBXgSmu8Tf6c4oQrZaew/96V4w2B7fIYEng+gxbhGVtyc6H2E
 ooN4+uLfJFHuKbJrAHB+ndHDOtrdgzqBurmefqMCeoDN5sSFwLeMEBcvEeOjIzRT
 pKNLcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp2ak1u4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:07:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2ec948174so39855705ad.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776840; x=1777381640; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6IJeLVc27K8/M0aN7u8utDbpeBeBEZ5LjYtl5f5NUNs=;
 b=jE/mA36qg3nRtUNxBLmayCULi3sD1KKXqQlibqDz34uTnoJMk2mS9xjOTIyfu/PvpP
 NKLw8nq8nWqE6OAA++7Ltr/ZkpgG1gUk2qtyDY24LlBI+09PIEW8xpkHKCRIXi76VOld
 5km+LCfn9i2eLEF0i7ekcdo4z+a+prdF8y2BDxHpcGrNaOcgLntmq8ACAe5rys47MunN
 fIrx+o1VoYfZM0moeIOy9JJgA41Izg5x45Fm1xot2+AIPU+j3AJK68TpBPu4VguYWXU9
 VyXa8OtxQ9H3SlaFJyeJQV09dIa2ahjCBV4xtShZQRRM7RUFwmaBttIGdqtJQAXXrPCL
 WsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776840; x=1777381640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IJeLVc27K8/M0aN7u8utDbpeBeBEZ5LjYtl5f5NUNs=;
 b=FG27iC4Jn26xWp3xZYhavmHc7PmvonSQ+uQVWLW+uElpKmYpsXLQ83D86DYWMH3zTT
 MOGQI2DYKRdGOkmjSpZ98WBwVcsbvAxPC7MAl8zGGwkXup9Th0qjzb5+C1Ij26lJ7mKe
 VKq6Wd0NX0J79Aa744JZJPflKzbQlsl0igMGHtFqgW32JmL6zonXeLWBGJDG6F09VS4v
 5oRenHEgIRT5/OxaJHMNtw+77akCdhml7ncY3GHq+oa5vCmUVh7P0xlBAGD7mwm1PkbX
 I3chPiBBxw0DRrvBuBhRjVBHjQan3Mjd81kXIzvGG5mJiGB5xtpLNnwdWUct52iDWqrK
 sJ/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ83WPIBY2fJkrUdDJOH0nHShbzU0ih5m4ZZkPZI8FE8U4vArFywlM911QxKOjAebGPZFaJ9FGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyMUzYr2btGNrV3VGPO6Tn3oUUjGAwHXLAh1Ky9ZaQPHZkeC0vb
 9Not7zRmkd8JpP6J5mYtITUaa+O9jhTl5I8WHUWNUHTieIFxMDKbiVTi31tFD8jWN4A4tpbD5x+
 C+U9ymPnUBfQungDEOwKgStofbAWFPs+Ijqz5uItXxISdxzKTCsEXE/RA
X-Gm-Gg: AeBDiev/6c6q1A/RZss4XSc4SzZGQjQeF8q4qOBN0RIo+9Ty42kc9vV7N02jTvk5nqd
 0Gi/kCF3qHxKzWHpJ1UzWbN1NnzfudN43FOisA4mTMSfQ+IKg098gDRjwiDL14rcjTfh4XjS1gV
 ZwDB+Sy+bWcnorerKhAbhbQfE80W9n7JogAPxuNPuGbmDbYx3eslxNOFwLivKIDEZaDZSA+NsuH
 x4HftaOXR0ymgWLbuZ+k/qkNodazw1sQ7JuCFCOJvaUW6jw/PqXbVKt1sHkk3PKthrZeHa5tD1B
 hawQL7CQeV7H1W6HNzLNj+FqP7wqSRh6twnonl4K0FIQVdVEgm1Sq+YmmUjo5xQYT+A1AGRiFKr
 lOX+3u0z9U7k8fmABaptvxvgKQZ4e75GSXz1ZUpezJVVwEgSEYrDpmWV6pb0ionsxOUPd
X-Received: by 2002:a17:903:1663:b0:2b2:dca5:101b with SMTP id
 d9443c01a7336-2b5f9efc3b7mr201917125ad.12.1776776839732; 
 Tue, 21 Apr 2026 06:07:19 -0700 (PDT)
X-Received: by 2002:a17:903:1663:b0:2b2:dca5:101b with SMTP id
 d9443c01a7336-2b5f9efc3b7mr201916495ad.12.1776776839029; 
 Tue, 21 Apr 2026 06:07:19 -0700 (PDT)
Received: from [192.168.0.7] ([183.82.177.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3bd2bsm142520465ad.74.2026.04.21.06.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 06:07:18 -0700 (PDT)
Message-ID: <533e8a1c-e157-4e5c-837b-32858b44179e@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:37:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: fat: Limit transfer size to prevent SDHCI
 controller timeout
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
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
 <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
 <6b16c87a-ef5d-4c5d-9268-f1c0c3884b05@kwiboo.se>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <6b16c87a-ef5d-4c5d-9268-f1c0c3884b05@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=69e77689 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=wgjzkBLg20+cMgJN0zysmg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qvZ195YzLHTVefmX5ZYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: _spj1XZeD_CFvH4-a-vl2REQc_TCGnMJ
X-Proofpoint-ORIG-GUID: _spj1XZeD_CFvH4-a-vl2REQc_TCGnMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzMCBTYWx0ZWRfX6oceElS4jolS
 KUDmzd0mBrkWnAyuh6fzBuz19UJFjHey6Hj7k4vAxrMc2rSJ35byjURuGykSQnnBvo76LrdsfT3
 BseYhJSpgIfUCMAtzoE5HzOweRrY9iuAx9nt2uuTGyy5Yk5AyNRIis0xie59EgMih36zsPcl8va
 2YBmE2jXAp05bynTTGDuOmerFFa5eGU8UPjrmLZrx9zD/KCLBrvYDe1hfAH6YB/FfCu9L9Z9Ec2
 f/xTU5QFAG0FugUgkRhRJ/I0h+kVQnItZ9kAPLAcWlt5ZJxA6E7RVYearRdYsP1L7CjeiYh2drd
 U6dEhAtbzMsyXTlMcuQSctDAD20/ygmOlK4btDECivDB0fqVVN0OUq8L/Em5kndLLXBnX5SZqOD
 MGgXhw8JCYQYmPGcVrWXsisUjEVnd4qKWEZyT/fKuFP7Vep5VFGhlNfmwSV9AmQTUuYLKXdmkv0
 zQCrBnFnzS0cchjZhLQ==
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


On 3/24/2026 5:32 PM, Jonas Karlman wrote:
> Hi,
>
> On 3/24/2026 6:52 AM, Balaji Selvanathan wrote:
>> Some SDHCI controllers have limitations on maximum transfer sizes
>> and can timeout on large block operations.
>>
>> Break large read and write operations into chunks of 16384 blocks
>> to stay within controller limits. This prevents timeout errors during
>> large file transfers on FAT filesystems while maintaining
>> compatibility with all platforms.
>>
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
> Have you tried to configure SYS_MMC_MAX_BLK_COUNT=16384 for your
> platform, or otherwise set b_max in your mmc driver?
>
> That should cause similar max blocks handling at a the mmc-uclass level.
>
> Regards,
> Jonas

Hi Jonas,

Thanks for the feedback. Addressed this in v2: 
https://lore.kernel.org/u-boot/20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com/.

Thanks,

Balaji

>
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
