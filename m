Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F52EE9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 11:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3807483A47;
	Thu, 19 Feb 2026 12:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fRmSeySW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gT1HZGEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E2883AA9; Thu, 19 Feb 2026 12:24:20 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BFE83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J47m0C422068
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Drf1WU7UhH3YH/q+kEl60Y5tVH6fLlujPap7kZvasEs=; b=fRmSeySW4Lji2H72
 +H4NsIi/XiMEEp1463SZXwm4U/tZ8E+a/ofv6Tiu94PghNg11rI/nom1V1L8uWvf
 Up2qGrcgu5yZaqepzEo2YAWKYFA09E/IExI3oEgBIQX5LD2bakKcJWjvQXr/GZZv
 b/arSh9n4W0GBbyvvF+v4g3kajhm0NvSkjM6satEcRja89/vVFinjeBFFm04RZ7I
 RYgFP6aSN1TGywex0rDYyG+fFW8W0hDAuG+isNzd9jOfAif6gyg7PtpVkyrM8Ozn
 WbFtggahQOc7B1SWLFt2bMctP4FHfxl8rhtHq9Dy2M2IZoazBR/UJiA9If3OFqB5
 ZjtWJA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd76e48sr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:24:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a77040ede0so9941865ad.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771500256; x=1772105056; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Drf1WU7UhH3YH/q+kEl60Y5tVH6fLlujPap7kZvasEs=;
 b=gT1HZGEQgRMYqNsOUiWKTJA0hatlTpyAN2sBN1MXh19F+guEGlUmUW0fCXYp8isicz
 /GjPrtdlpbKl6ITM/jIViq2OwROq+xZAndLzmorRaivEjkbdkHbGw7NZJMdZBesIkNlt
 FPaNv4SUVBsXNBIprDi3oTng1Z55cE+qnm7wwbUVbZfp3qEpWpIC47kHzEAygIenNP/J
 I5yJahX5AsieyTLhZ9hDcO5YbUd8Awh+nRJLz357IKxsag6olZHu2usR6xPbB1Y2Sl+1
 uyKYL6LQULXdzVM/2yCIslOOXgKrbEzN7uIM6S5cWKFYw5PXP+wBcgvXQCzT9eAPt7Ce
 mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771500256; x=1772105056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Drf1WU7UhH3YH/q+kEl60Y5tVH6fLlujPap7kZvasEs=;
 b=JF1SbR3mCHM89c530yQGDqiKjIpHEFVMS9slWAqoO7e8b5Oi6oqmnjNj4LAYibhy6q
 t9R5WluZpk5kZjgOfUPoi/EvELliScAHNJyndP8DIOWTnQ2GcCWBXDt9Drht2P+QMDt2
 3vyKWTapaI9wwxdx95ZQrrt5lzbUEWUOzgaxs/ySBOHThuaKDC4OL5zwgU3oOlf8P0mM
 BJyjRJQHVtrA9nh/xKCbk6IFhDB6Z/iJKitRFwgQ8+gOLch/OBNfNNaa/aZfZI/5m6Ls
 Bfzkd1VvEcytmuGec3t0CVx5WoZ1/rKTjd+DYpMoWwetry2CxpnxmlGPq+KoWkaN0w8P
 4HaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgVJy+GVvxQtZkDReSMqbDlfJ35WGXp4mO3q8rJUaZl0dTHBYmp7T7kjKgkuIu7iuFeprdEKU=@lists.denx.de
X-Gm-Message-State: AOJu0YzJTqzISJTM+vONWO6HjNAZ2R+GW4wAowX6MrK54/P+zIOF/Hf4
 pAUKP2s1WNmB+LQlyG/K/elPGWrad6mQ0lZyidnSN+FzQdf9mroXEWzs0EMc6ueeIwXRoJU0o1k
 7Zo7qPoGuTPtrzD/PyD1/hxZVIGPMdaTgGNtowS976RkebUPn2+852mc7
X-Gm-Gg: AZuq6aKxsLAP5T+hLVPSejyhoxTBAQanso38b79G+StQVchR41cLRUrTA/urY6Sm9UW
 iXvLU1WsB4YHdXayNTgTD/WiB0xXgVwkMAd7YriImdQK///xP4XOBuZKJnFnzWrgK/dO73cIeP2
 YJJWrnlBOpEssA+SZCZQH5GiE7lcDowKIOJZJWX9pYo97xJtgGnh4MmifHkraFr9XMhe05xizcd
 IUS0QqZsaPBHpxRgf0k0ycnfR5MPRPbnh/4SLBCY0VYFBaKzWcQ/8G6VNxRAyiy+vFmzVLHwM2O
 dFy8y6YMhg6tbZxg2yayGmhlr+X8jKPBtTy384Oso/X5fUbiC+kIp9PUVM+Zv/rKrbYNr0eXZId
 tHIp6cKle0d7kh+n5+uBohoUQB7/GHQwZ0JKS+V8BXeDe3qHKU00X5Q==
X-Received: by 2002:a17:902:ebc3:b0:2a9:5ef2:f788 with SMTP id
 d9443c01a7336-2ad50f5f5ccmr53766745ad.37.1771500255551; 
 Thu, 19 Feb 2026 03:24:15 -0800 (PST)
X-Received: by 2002:a17:902:ebc3:b0:2a9:5ef2:f788 with SMTP id
 d9443c01a7336-2ad50f5f5ccmr53766355ad.37.1771500254993; 
 Thu, 19 Feb 2026 03:24:14 -0800 (PST)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadc729sm149797475ad.64.2026.02.19.03.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 03:24:14 -0800 (PST)
Message-ID: <23fa6538-d69b-4f59-9e36-f3cf2c6dd543@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 16:54:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
To: Sean Anderson <seanga2@gmail.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, sumit.garg@kernel.org,
 casey.connolly@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
 <3fe5e11d-7240-c577-64fc-062d5c5e4d6a@gmail.com>
 <497f7e07-3a5c-4a7a-b2bb-9016d6927ba4@oss.qualcomm.com>
 <96a3a5e8-a853-b766-a013-d3db6bfce117@gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <96a3a5e8-a853-b766-a013-d3db6bfce117@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OKsqHCaB c=1 sm=1 tr=0 ts=6996f2e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=3a11mvtZPsPdW_w_N7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwNCBTYWx0ZWRfX6gtt2ctf/ir+
 HL8/yXer/WB9GaZQFSZNRmpwT/nLUm1atL61c2ZjS/AoweNJ2dWtmT8A3K/0Qvyu1O9Lpe2hgF3
 2DAI68k5f8uvd6qXuQh1x4qc51A1NxgKs0D4Z0SHe/vD6iA5TmC5JjUqGm5ZrSnaW8kN07op8xN
 /4/K58C//hAOaGCcxnRabFxlm8OsT61ZA5LCZM10WWqvn+hGxys6KnIMoSqmmKOMtHevN+Zc9hP
 Kyahz4aoVjtvV8iklyn9ZSXRLN2+AWkkDl41QDEtYUQp6X+yq3IuWmWAq3c1kzVUTk+UpMtAIza
 K3VmgBpJnv01mropb7i35quTSw49WBQxf8AhkrTM3lOenVU40h0G4zZQ4ZyQSK2WbKVeiAMdnJi
 zoFTvm3un+RnXF/xs1WcYQEQkvTLn0MzufIeuDaKfcQDVZgfZEM0876EmViJvSk4ZntMgTfjIlK
 evSOGYI4rdh7WRg28FA==
X-Proofpoint-GUID: lCYTD-RmORR7_Ow0CrlA2OiuQbo7w3nC
X-Proofpoint-ORIG-GUID: lCYTD-RmORR7_Ow0CrlA2OiuQbo7w3nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190104
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

Hi Sean,

On 2/18/2026 7:37 AM, Sean Anderson wrote:
> On 2/17/26 14:05, Aswin Murugan wrote:
>> Hi Sean,
>>
>> Thanks for your feedback.
>> To address stack smashing, which occurs when the cell size is larger 
>> than 4 bytes, I will revert the `nvmem_cell_read()` call in 
>> `reboot_mode_get()` to pass `sizeof(*mode)` as the size, consistent 
>> with the original implementation.
>>
>> Inside `nvmem_cell_read()`, will modify the validation check. Instead 
>> of enforcing `size == cell->size`, will check if `cell->size` is 
>> within the passed `size` (i.e., `cell->size <= size`) to correctly 
>> support our 1-byte read case where the buffer is 4 bytes.
>
> Then don't we need to zero out the rest of the buffer?
>
> I would expect the check to be
>
> if ((cell->bit_offset && size > cell->size) || size != cell->size)
>     return -EINVAL;
>
>> Also, i2c_eeprom_read() and misc_read() will continue to request a 
>> read for cell->size instead of the passed buffer size, ensuring we 
>> only read the valid data from the hardware.
>>
>> Regarding the bit field logic, as you suggested will simplify the 
>> bit‑field handling to max u32 size, which significantly reduces the 
>> code complexity. Given this simplification, is it still necessary to 
>> keep this bit‑manipulation logic behind a separate config option?
>
> I think it's likely. You can check the growth with 
> scripts/bloat-o-meter in
> Linux. Since this is mainly for U-Boot proper I'd say a couple hundred 
> bytes
> is reasonable for this feature.
>
>> Kindly confirm if this approach aligns with your expectations. 
>
> Please remember to reply on the bottom :)
>
> --Sean

The suggested check will fail for our case, we always pass size = 
sizeof(u32) = 4 bytes regardless of the actual cell size.

Example: 1-byte cell with 7-bit field

cell->size = 1, bit_offset = 1, nbits = 7, size = 4

With suggested check: if ((cell->bit_offset && size > cell->size) || 
size != cell->size) -> (1 && 4 > 1) || 4 != 1 -> TRUE -> rejects valid case

If we have a check as below:

if (size < cell->size) -> 4 < 1 -> FALSE -> correctly allows

Then if cell has nbits set, bit field bounds can be validated separately 
as follows:

bytes_needed = DIV_ROUND_UP(7+1, 8)

if (bytes_needed > cell->size || bytes_needed > sizeof(u32) || size != 
sizeof(u32))

This validates:

  * bytes_needed > cell->size: Bit field doesn't exceed actual cell size
  * bytes_needed > sizeof(u32): Bit field doesn't exceed maximum
    supported size
  * size != sizeof(u32): Buffer size is correct for bit field operations

Thanks

Aswin



