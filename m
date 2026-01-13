Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D6D0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974D38352B;
	Tue, 13 Jan 2026 11:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXGjMlEf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CnInDCkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3FF83693; Tue, 13 Jan 2026 11:41:25 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D9682B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60DA5ki33798452
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=F9DIA9Kaa0krSTZvYGyqheAe
 0iHSQS28lmJb6d80CSw=; b=SXGjMlEfV8KOulc7z1WZN3MHxPEqMCMwvJfskNoY
 1FaFztJQYG9DitpZiSLkpYLC4bkL0izCRD1FswP6qimmtTF680bXn/uJiCBqmw52
 bhWL9uEMYZ7RelB9DeY3dQQAbyFS++sSdiRX0xyNUL76ztu45okcipBZDgT2OWXH
 3nOArxzS74czvmJjqtWqUAGFb2ni/4GBc2Zn6wdWZe8F6dsmGALWtPupaDmdlxDa
 GIAVH1Db4bGUwN8pKorGcj+BkA7HnC8IWjy1MzzK10LMvuKlzYVnHDpR1U/vgszo
 Hce/BmhE8/v/3GYRlxygN6voXwT32oP8aUzKpGMWfQhgmg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnm0dr3v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:41:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0e952f153so193730125ad.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300881; x=1768905681; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F9DIA9Kaa0krSTZvYGyqheAe0iHSQS28lmJb6d80CSw=;
 b=CnInDCkCynBM8pIbw4re1Dx234cMVRdsU2P1yII24FBbIXj+hlHVzUjqLEFWdL/V+7
 RA1pauHPL9YVUVrGhWrVrelGgRywYEppQ1BBi55RLphzQ+R7kJUbVTpf5F4l2JKt89up
 AHMjbx2vu6I3qwuylmaIQ656fx/Y+aDTDgzKBu0NlJUTTnS/pNYgfh69sx0+lG29Pq26
 mDRY1d1lTrjqrMjIda+K6lgX2p+OoahTFtdTNpmOt2mDWQJkV1zt5A+lmBuKT8ZC3Xo8
 tbCXXaa2iX/32Usabyb8q6GdmcA7cZL6HtuRzbHO5+XfCPLnEIJloanZtStc16k7dPtX
 Tx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300881; x=1768905681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9DIA9Kaa0krSTZvYGyqheAe0iHSQS28lmJb6d80CSw=;
 b=kE+XPLw9Ok4+ljyaTtYY+2tZrIJIaKPgDA6eOl93wSXBg4FGdBL0KdfwL7BJuEl2tG
 I3/x7RKSEwT0QOIKEwGSq6oJcUBz08f+MWkJIvLG+1aqHzjNxdwLmpW4XAwqrIza/rDS
 HcQnvW+7t1/iwbACHsS3VlGkw9fXol2kg45ZxbX3dtmV09JaLJcsDsJKr+PRvoaD/rU1
 M9CIrEcV4eDYopHLWxeh8JDaOg9zy5W3GsYGiG/qUum6XqATevHVbucRh8sJwJaKYW5c
 Vb/XTID1IVT/VVqYcsWZfVRNeOkFH9e88QczAX2100MRwQMgE4i1LOUCQvHgdc1sdsIm
 D5pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2uNZeep8LjXIHubqWm8wn5zZBr4ZFW/1Pmn8DifQTFHGFrtmZLd2koM1kYZWjMKmtQyNWv8I=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu/tdMyC7h6qTnsw9tDxH8L3mGoEsqkm1/8NmLNUuPXfKrGZpJ
 GYUukpGZl6LlxqV0YTnGPs9dyJGQQV8YlHBne5i2QLTWrjdbkFiNC9/kVbg6+su6Ux6uv+vllN6
 Hyz48eLb7AOVYNDbasQTtm0/MMAIOekyi2wzYeRaw1NJlX+O4vXeoOc6MHGJQDzwn
X-Gm-Gg: AY/fxX40gPpi3zFRciPc5C2dRFinKA/ze3KiyAiYErR4Xwvj7/o8yFV+hs5pwPN7uKU
 Z613AIQe+wmN0OeIBH9mkUlK9aAdwEMmXOpvljgKCicSc+V4IlNhsw5mQ52F8RaYtCqTo/jNWrn
 HMHYXToJIlkY5qzuEsYGJr2lY4eN5XnHiRbVjFfjrgmjP/db05ACYRcpIbM3G+6nfJPKmPKOhq8
 RJFyji2BtklZR+SyInEklL8Uhq9UqYJkSD4FbVbzh1xujhO6ifk9HdM6ORS1hErlWPqFVzj46ES
 dQUP5vGn3pe+bWqZzuSePTUSGrL5nttw0j9RLpiz3irnpMBWHrkppnWKDL3HJAf9IDYXCHGSPow
 hc6efwQUPPbveyJy/eiN4+jLXha8cHPRWpp+aRvOHiNRCIm/khmqHtrU+FN0i7W2Kd4GKGIFema
 a7xY18tivZzxFUyvlKLEylodD8j73zG5IBEuKm4m4=
X-Received: by 2002:a05:6a20:3d93:b0:34e:7bef:e820 with SMTP id
 adf61e73a8af0-3898f997696mr20781272637.41.1768300880783; 
 Tue, 13 Jan 2026 02:41:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/NHGgYDsaxsAwFsnE/1cSKHOLkxX6VfqbmBCIkviIjqks/BVNNaK/TLq6LWpS35kSdmjUQA==
X-Received: by 2002:a05:6a20:3d93:b0:34e:7bef:e820 with SMTP id
 adf61e73a8af0-3898f997696mr20781250637.41.1768300880368; 
 Tue, 13 Jan 2026 02:41:20 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28f6cdsm19546158a12.6.2026.01.13.02.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:41:20 -0800 (PST)
Date: Tue, 13 Jan 2026 16:11:13 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 5/5] configs: qcs9100_defconfig: Enable SYSRESET
Message-ID: <aWYhSVw+UaRR/3Sa@hu-varada-blr.qualcomm.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-6-quic_varada@quicinc.com>
 <2170841d-15ab-463d-b5b7-0b2d5b8e79d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2170841d-15ab-463d-b5b7-0b2d5b8e79d3@linaro.org>
X-Authority-Analysis: v=2.4 cv=BYXVE7t2 c=1 sm=1 tr=0 ts=69662151 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=5cJZsUMuq_2pU_X7U1wA:9 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: I2N9Qi1ENR2KTrSmvEU6vlaiQoBhWy31
X-Proofpoint-GUID: I2N9Qi1ENR2KTrSmvEU6vlaiQoBhWy31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MSBTYWx0ZWRfX8BwZK3z2Av+S
 GO1eKBgu9ohNrbXCawnIFcp8ahxVelTn+QBHoEPBbUdyBd7o6966NmEAq+dFzEeoSO+H45CEFz3
 DzOHLjJrVdAG6KjsleHNNrmVzAjxDKfsbxJ6/+AUe1xtKXybeOzv11UCjjE0GO6LdazxIJ4T1Ef
 qZ0NqUDyJp3WgmJlcU4vTOvH3K67eFbGC9GArxl/mkNZPZpHZNONXD/EFPw3fMBSr72kjuQIVxs
 QjD6B6CIFNxZK8ctag7SmSzm8g0WIcT9nsn7VoE3spVCLp7HE0VvpLv61jOJwcptidAIBOFPLlA
 Bitis3CFcJ9BHaDvKUNfEvQ2SGstvJasUHskeb5M3duwadlCJLH/YRX7f6NEJAp2Bmhg+LPknMx
 yloS3qQ66SwvQRmVHxKrLKXG1+gUa2Yl1SUSwQMT7oj8U1kxp1Ct6Ohf9VqEdS9T+klIn2JGLDw
 CQcHVrcIkSpzLJshVOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130091
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

On Mon, Jan 12, 2026 at 02:28:44PM +0100, Casey Connolly wrote:
> Hiya,
>
> Can you respin this as per:
> https://lore.kernel.org/u-boot/4ce7da40-8c8c-4594-a108-15a723006a94@linaro.org/
>
> Then let's get this picked up.

Have posted v5 - https://lore.kernel.org/u-boot/20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com/

Please take a look.

Thanks
Varada
