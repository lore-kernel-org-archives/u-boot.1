Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6505DC44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 17:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD5E84D6D;
	Fri, 17 Jul 2026 19:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a20qfOvY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQokssT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337D484E14; Fri, 17 Jul 2026 19:16:38 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9543584D66
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 19:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo2wi2177506
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bwEKynmILqW+zwBGVoyhz7/sSX56mCL+TBsZ9XtTDmQ=; b=a20qfOvY0Z5Biq4S
 s1eTQAi+o9zok8Mef6Y09RO+YFj4l368xy4rsmOT4Sm47Q6J4/XLTfHFwbekeG4A
 ZshkVQvLlcbwQR3l7SHLxqmJrlskm8L8xyQnAylU5eQvOJoHAutQwcpvHs/wVTZj
 FJenCzv269kMmBsjvRRbSKkTELbxPKf9RxNF3oeNXT4DZgjL/ecggenRSd2CsjJX
 1drl2OYJQSc8jKs3MsGKzKde78WW78nljO9iUeFSSu8nwEq/fELNADi5u+Pu6Joy
 TrjQwnwdsvKtSfPmg36QBFX5BISBP3tCsv6KQCgZgkkx96EPt7cb1AzGN5m1OYcv
 DZTcjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8mwav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:16:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso10268364a91.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784308593; x=1784913393; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bwEKynmILqW+zwBGVoyhz7/sSX56mCL+TBsZ9XtTDmQ=;
 b=XQokssT4Lo/QEJne+udlQnPq+YStP7mpf225tABAketWGaaeIDodZjOMyJ8WJQTXPz
 Owi+6zjEVydKH8AdWmKzdQGqwr2fgBwngyHNSKFUD4bJimNGSVHbaqdIZAJixtpakdIe
 d9OJZHHEpQIc8OTSQdnWSUZ1hY/tS2wo6UQyiimWfUR9IzDLGMuDGNOXq/W3+dlj8eim
 QZz/pbrqtUAQkVlVGxAzbMDTHl/E2fwQ1ZcuhVQgPp9BPCbh4h0wy1XeB2CLV74oKkI1
 sMlTYHlkC0WMQleh/tVpxKpFqVCH9aFSgkHBnKQrTvwsJlQIUTdtnu6QDHNU+/LGakP9
 iByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784308593; x=1784913393;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwEKynmILqW+zwBGVoyhz7/sSX56mCL+TBsZ9XtTDmQ=;
 b=sahIp9e06UPSBP/BpZcwlciIqZUu93cFBAa9TSA8PIU22AxQmShJyQBT4D8W0vPr2w
 jIOb/cUHvqTM2GYF3dA/AopIXe/NSG8h6giQKlMz+IeJYPt7QUHwd9Js96va73zTjP0x
 mF5yiEMw+4eoCqmZzJS9V5B99bW+QOnBN7Wq6/ahKOlrduxa09HcSzxybrE4Emw1xHcn
 gRw0PyhIMPhuFr/CAySIDENnNUyHlO3964i1beeYIj7brG9ZahI29/Mo33RpXzBhzvFk
 8LsWsFcf0G/kIRyeqaUfMsAQFk3qpms3LADz6XlX9cbGsOE30ihEOPAHcA0ZNVilYldl
 EWVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3fBeh+OxtLKTgLWkqxFk4Tj70vJl5weMf38fJBq/2LR1t/tA6uE5yTcvLT7/R4k+0Trd+6Hw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo3wa/H99FpWQTuz0mOGCiw9v13++mu68mO8Basdwv6v6WB8Nc
 jFE+swek8vmwzFreE9GObK9Aui+s07VxTaRTO35/kPwy4u4IGeDpNBsj3PnnlVcIhfqTtnQqDT5
 azZwDbNEpWz9X6GbfLU4VOblT75Cnbff74xJP1JGdv9cbVdP3O5y5ON/e
X-Gm-Gg: AfdE7clO7HnMzMcw+DldjrrPH8CRRHOYgmK3bjNyHrLwwrnmamw1rHC9VQ1t7Ld/RYh
 hHCQLobFPjk8PsIiinIS9zuDHtNPLUGkdm7yeK05Qjx89lbrBZgmj+mOIdQKxyJm0fhfSYLhQvm
 1YPlD2ewmmQm7wjq58s01y2pLlLA2ve6IW2FqT8xbIL12EUnn406fCq3dVt0kDDbqNUsaNfp8lz
 /djY2Ipg7gvnzfwbmr2MVUwAa4SJrZfuKq5mqdMCkHoGA4TNuDK1qN9tfWtd3r0qx1YGGHABeVj
 Z7KPJqKwU/PtVQTWk1ElUe3glMMVRm/AAlx3lNSqSDQbN6FQBiPfG1tC49eACOaUk1iJdXF5ve/
 m0mjEja7O4Otw/4XopKauF++l+keZHQY8emjjrA==
X-Received: by 2002:a17:90b:2e90:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-38e4b418439mr3610313a91.6.1784308592878; 
 Fri, 17 Jul 2026 10:16:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2e90:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-38e4b418439mr3610247a91.6.1784308592289; 
 Fri, 17 Jul 2026 10:16:32 -0700 (PDT)
Received: from [192.168.0.3] ([183.82.204.212])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fdcaefsm9162463eec.10.2026.07.17.10.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 10:16:31 -0700 (PDT)
Message-ID: <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 22:46:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Yim9fJ9U6_ZIverj1E5CbDEfSZOgNZ_n
X-Proofpoint-ORIG-GUID: Yim9fJ9U6_ZIverj1E5CbDEfSZOgNZ_n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE3NiBTYWx0ZWRfXw1HWBfa7ijrx
 t9sqit/xW/T+2EWioM21G3HxNUk4yvM4U9n9UPpoR0BIVNBmG8WxjK5gV7Xb26FAAyM28fsWdNI
 /bwRlHz1SujMkFqqGkLwkpBmRVl5wGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE3NiBTYWx0ZWRfX/yHgeAVKb9Rk
 sFNIqGyYC90opazP7B3AFcese2XniA6T04py7+RLEUutreKG6UkdFZSHAlqM2ikpelu+vbOsodX
 eETBlKPCxoBGLXufYB8iudsWhh5xb9PiMW1w7IES1wlTmnpNh1rehUNqhb6Z2DAsVFbyeKTM5Yt
 EDIcJMIgg6laPZ4J4CERmV9CJGXOONfPlf5zG09XsrVYQAPJ+1E59hHhzQNBSyKnsrXlMNvjDmq
 lbIQPhkqi5gEThln/LCUwRwV8/nNEIb4oBx7f6ahLydVr5UTOy0XX6uTJk2VOYQZBgopuFc3kEc
 ZIkETL33JoF/XSj/taI4jQdG6OyMjcD+AqOIxYDPYVmrIJj0HvWOJM4JlOm4Nr2aP9TfgSvzGNn
 7AdBFv3nHEo+hharUv6i2Szt/9uIK5PRzXfDLazqNyxDolu8mmQhUVrUsVZQCcrugzXu6k5Ir9G
 dVat/+oO9yR43PhZseA==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a6371 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=1Cp8u7+63qhYKYanSvoPGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=bdoZ49hh9dAbC0RmrQUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170176
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

Hi Casey, Ilias, Simon,

On 5/26/2026 7:05 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>> Hi Ilias,
>>
>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>> [...]
>>>
>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>
>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>> but need some minor tweaks to merge them
>>>> Can you please point me those patches? I did a search myself, but
>>>> couldnt find those patches.
>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>> sughosh.ganu@linaro.org/
>> This patch you mentioned here can create capsule with only one payload;
>> means for multiple binaries we need to create multiple capsules. I have
>> also asked the person who made this series to respin, but havent heard
>> back from him.
>  From a quick look it seems like it would be fairly straightforward to
> extend mkeficapsule to support multiple images, the capsule header has
> an item_offset_list[] array with offsets to each image, today we just
> write 1 but it shouldn't be too much of a challenge to put a loop in
> here and extend the argument parsing.
>
> Given that we a) already use raw capsules and b) they are part of the
> EFI spec, I'm gonna try and save us all some time and just put my foot
> down here. A single raw EFI capsule file can already support updating
> multiple images, U-Boot already has all of the machinery for it with the
> exception of mkeficapsule but I expect that's something you can tackle.
>
> The upside to this is that you will be able to build capsule files for
> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
Thanks for the detailed feedback.

We agree — we'll drop the FIT capsule approach and move forward with RAW 
capsules.

Here's the plan:

1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series [1] 
to support generating multi-image capsules from a config
   file, so we can build a single capsule covering all the partitions we 
need to update.
2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only 
supports a single firmware image (U-Boot itself) via a
   single-entry fw_images[] array. We'll move to a SoC-specific, 
multi-entry fw_images[] array (defined per board, e.g.
   board/qualcomm/<board>/fw_images.c), so a single capsule update flow 
can cover multiple firmware components — each with its own
   ESRT entry and FMP image_index — instead of just U-Boot.

Will send an updated series once the mkeficapsule and qcom capsule 
update changes are in shape.

[1] 
https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/

Regards,
Balaji
>
> Kind regards,
