Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBD7CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 16:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7428683E63;
	Mon, 24 Nov 2025 17:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4zkaSlP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJYh8O2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA01F83E62; Mon, 24 Nov 2025 17:15:17 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4518683E9A
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 17:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOFuR52601484
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gB0VogrNgBOQ1VPEEJwHOIyqOe/ry+lbNkRkKq3Gw3U=; b=W4zkaSlPkeasg/Oz
 SI4/ZcEualF9TzWfph2lSFocnPNLZshCOP+fvJdZK01hpa1ICdE1HI0z2Dgsz+sT
 bY4NwuVS5l5tMEvDf+uqtpAvkZssmPxiCnv/RY7QI871FwMYzZuX9vgTqrwQKEY3
 r4E5ha9F1ndRsyQiwTeAQmvEv+0wBO8/8Huj2u1C65FTi4gq4fayJu8VJ9lZ7xUb
 S7nS8rM7Bkn13x0M90eMQu6mIMs4ZZj2aYKUCyaXaRse114IszP/LqYAZysATi1Z
 SwbnOJ9oB6Yxw8a4MKN/GhYSmTRwkU5gaM9xVc+LWd9ntOux5Tj36e5u3H4zzFW2
 pG2oRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amqpe0k0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:15:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2982dec5ccbso98995385ad.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764000912; x=1764605712; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gB0VogrNgBOQ1VPEEJwHOIyqOe/ry+lbNkRkKq3Gw3U=;
 b=PJYh8O2kb75BCYbiMpJkn8vsDZK1kcr37pGae2lk+FlKsT8sFJn/DnDbdHD9psNVEO
 V2XWqrXkiSAYqR+oszVBusTYNPAMBYY5NnQoC+/1fEtknMLlVJ3mSsjrM/dwBHbgwZUU
 s91EnOX0vOj0KK4Df7ZR/uHPc584cqJouEw9+aFdSJZh/wtBMIs0sjzSSbzyFRerNJLD
 tidUpN8HGKrTC8t/i9FUo314EOH6KGfUfk26L3XEcGgkLujCwWHgYX+IK6/8lV3kir4L
 KEIsurzB3d2rz4CDT+N9GO/l8XF/cUbt6p+cbLdzUVxjCcD7hhHWGFuOCb1N0HwoAJGl
 IWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764000912; x=1764605712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gB0VogrNgBOQ1VPEEJwHOIyqOe/ry+lbNkRkKq3Gw3U=;
 b=tYEKhqHCP0aNtmlLKiT6vQPzN8fR3DM7lH+xEPWtwaISh7i12iX2/ghMROqsR9TPBy
 v1abyXGaA7ROxqNsDsMug3ZBXDoVTOAP9b9tlAm83UihMlTQFm/gkU/udDD6GrcgMCjW
 ceafFIjbqQ3nhsCNprurKbeegVBoh/R3pTDDJ4DUqo3lWVQD6x9ep3FBS5DmcmijK/mt
 TAJEmiUNJrH8Gk0F0UkzYzAyFMfmIoqBHJ04vys92sqaDtD7PY0VFAFQVKDS9iCisaCc
 T0+Wcpfhy+isqoaWXHWLoPa6k1aP3RMswhbt7JX7lAbdeZ2l+znrXTQDPWsuKoQ56SSH
 /aZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLtJi1HSCfBDTG/ANhhjeBDiEv89ji65sOEmdOqy7gjUBkzbRCcSk7uTfIxlY3YVVT6Uft4lg=@lists.denx.de
X-Gm-Message-State: AOJu0YwPAVCWCGY/Nrh094thrAniT4SljCajgqem/CfXlMCZ1N5xoNnV
 nQEPLBjR0EPmyU22nAx9wcWW3dH99wyZTqSvPdtCIrHy40pbCWd9sS45hxvRUPvbKspd36vCoXi
 QXeayz/t9exw18yHmZl1zbSUEcMQhBpxtpiGzrnwoJsLMitWL3G9r/KOm
X-Gm-Gg: ASbGncu57SPqJEpMqdpQm3gT5c2jc6Y3gEhNmUAy1LCRN3u72X5nBfL8K2xbTqOWoFI
 cE/oa/BS8nIDtwBIpFWx1sCsKiKMooVd8KelWI3T304UgpxHlC1RA0QnhOBBc4dmJ8Cbv2WmVJA
 33M6OgzDYCWpx+4qtIWj1KJfcdjLxM30RvEfgDbRZDKoJr1wP+C60J32LcfRt/A6Banayi5oXWE
 L3/uDwp1Niqckqnpm7fPldR4W+uucl3Z4GXXloKILbn0q7YlLqqdDpuxuyy2vsak6jVsd/LahkN
 bwsZH08bZdCDAT35zza2jt4BjN2P2SPFy26sVNWsiF4evslDae3pg9uP3qIwyrwZlBRKLhfhRFn
 vhYZpudxPAOuPN6ejYqz3WneuSfk9FFGTKnqfvDz1Gc8ulA==
X-Received: by 2002:a17:902:f706:b0:295:7f1d:b02d with SMTP id
 d9443c01a7336-29b6c50eaa9mr129450715ad.22.1764000911525; 
 Mon, 24 Nov 2025 08:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvtfVZruk7QgtLStc/1VFId7uTMhDtKd32MT7RXO79pHaRd//Qz3RD7JnVSf6kgG2OrMaMXQ==
X-Received: by 2002:a17:902:f706:b0:295:7f1d:b02d with SMTP id
 d9443c01a7336-29b6c50eaa9mr129450205ad.22.1764000910743; 
 Mon, 24 Nov 2025 08:15:10 -0800 (PST)
Received: from [192.168.0.3] ([183.82.31.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b25c104sm141193765ad.54.2025.11.24.08.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 08:15:10 -0800 (PST)
Message-ID: <c95cf224-3ed6-426c-a280-ddfc2a79a4d9@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 21:45:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] drivers: usb: dwc3: Add delay after core soft reset
To: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
 <958c0c45-5f82-49ff-8488-ab5abd7c0e3a@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <958c0c45-5f82-49ff-8488-ab5abd7c0e3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE0MiBTYWx0ZWRfX775x091RVozd
 xH7Ir4R9uGaymggC+YTkxuAQjWT3DoeCsGVDKKA13deR+lMiZSu/G5DHI52TL76gPBqsw/nkdTB
 abJ7e3rBIvT6m4QiJpRh5pSbHumN+6kRem0jeiV+ERvtOuMrEeqmQ57Yju16t0ul99cmc+1V483
 SwI1Uim9JaCP2VSHAX8iDyoVeaFL3IMUNITo+FEPYpspDntwnyDaKrKiU53yKB7PBKOutaw94UL
 naSZW15ZE7g2gYj8uk0ugepCLsXq5hsb3FK08s2kJsXH921WlzzTgfTYfu/xwzuVFszZmbMoUSG
 N9ZJ7YeIqi4Af88XOx6dSWrpjEEPSEihrM/xLNYqMePVTfkxXjyiId8SXFNmfz4yz290PiR0FB7
 iOEqSntCFOshipEgrHUlq1/QApxjFg==
X-Authority-Analysis: v=2.4 cv=OYuVzxTY c=1 sm=1 tr=0 ts=69248490 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JdFg733T8uQF556z/T/deA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=rmFG0eYkspPtP8Q8pM4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Y0CEpQHEh1tCGyd46rueh5a3Z_sp5itU
X-Proofpoint-ORIG-GUID: Y0CEpQHEh1tCGyd46rueh5a3Z_sp5itU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240142
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

Hi Neil,

This is the commit thats adds the delay: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0; 
Have updated the same in this respin: 
https://lore.kernel.org/u-boot/20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com/

Thanks,

Balaji

On 11/21/2025 4:17 PM, neil.armstrong@linaro.org wrote:
> Can you explicit which actual commit added that on the Linux driver ?
