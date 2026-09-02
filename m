Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AB1C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15B8D402DE;
	Wed,  2 Sep 2026 17:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8J9q7e-GJl6; Wed,  2 Sep 2026 17:02:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368481;
	bh=3SU+S7MPP0fgamJRJxe2nyWTbufqHejbQ8fDxKKAcDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNGGRcJygHJc29x1XqBI3gXwXF8MvLXxzEvhKXkyCHQAn7MAHeaKkx/4NaXCi+hIT
	 ezYQucD6H6YofjMVtINKdDT1FmWSD/xvS8Qr/mFCNpYgl1SLYP77v5ZW3BGfGAwhTX
	 bZT6X71lUfSfJeTgzaQmlfr0SvpluMem59U2/pT4SEVIFZwam8awWdz4Wr6KR/Zhsr
	 8CRISIcPBfp7iTWyHtPZucURmTA80HYl2qsow7FJ3h+cC/zzLPt20snfeAIVH6spZX
	 XgFLz7Jxt+QJimnZe+CRjYI5DwUjTZU2rAvr8o2GUVbIGeqo8SUbLkaN79kDP2/otd
	 2qYmD0UmWz+VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C8841109;
	Wed,  2 Sep 2026 17:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C581D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E41C84039B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5RQzZwN_3be for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:01:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ORbQSMmj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=goWZmMS1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47E5F406BF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:01:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GfnGA3219933
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3SU+S7MPP0fgamJRJxe2nyWTbufqHejbQ8fDxKKAcDI=; b=ORbQSMmjFj64WnKi
 wkHd/gX3Cz/2rXKNKBFjmpOzrvSrXx0CcYz1zq4mDcJixHChRxreM2R5/jQuRRVC
 4a7mJMSDaIswz0YbbtyGocECh+PxHeMU6ADg/byRxGaCbNUMNm0WHV9SL20PctCk
 Cd2AGXtPzGWo8jwqBjXa9vwavq4GTI2b1ldsTFfHj5BVtlgEPKcJJaI97Wpbj+pG
 LYV2PMI21+hc5lh+UNcca0JsSzK5g2bfLoGoaeVb9vJvJJeParDAcNCCevtq6H2R
 mDj+A3a7XSIfqwff7qP3rtrzGVJULQqXd2WWflPu08cbPiTxondWnHkkyEVg0qBN
 g2MFeQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnghuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:01:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so2118887a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368467; x=1788973267;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3SU+S7MPP0fgamJRJxe2nyWTbufqHejbQ8fDxKKAcDI=;
 b=goWZmMS1Kln5P62cFHK7BhOAkUsz7uXw4nAy6f3SrcIDJbLbwAcMx6g786BB9PN0gJ
 YoXmOBZxNj1VtqNRmvFP/va8twuHmLCof6G0/CnPf5Eqntma0iA2amGKaTKfMHeynhG0
 EPIYsLYY1sCHp5mj/qj825M8zGWGPNBHchGt871LDBxg/4jjUIHyU4skuPCTcgRWzwSE
 /3kRCii5Rammel2ubJQ0gN42Zo48y8JTzrnkXOZIVzjzqd7wmR3xIS5UizKn+iNzu+Nn
 zXuXyKozLUi5d7hRMEaNu01JbKhat9udVoijMXrifheDaQKpH+FSJwpmcUbzUvcAsI1B
 G63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368467; x=1788973267;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SU+S7MPP0fgamJRJxe2nyWTbufqHejbQ8fDxKKAcDI=;
 b=jSxOHbyCttZATSegLn04BFF7UZUXkSDOTn6AEbxCuNEuNsHLMvAY9LeJQIPe8BMzc8
 gN1tFznBwF5MfcuV3DKvoG6P9jryVTbdRiMY5e3rDr8rqOQNfUq7KzFx7J9WVfWT57u1
 l8jjKP+M4Rf02YYRl7K6G1969kZU8FmsJwfWzdTt+/2q7taKXdvzz3Y0Na8RUBSRt3uH
 4vnI+vpaIm/G7t62Nwb0YfES/ifFtWvO5jXgK4L1tX9f//KI+EdGOSV5p8tfZyxQfG6t
 R7OG+eFJkQwuIoEk6wQnbed86pMGOYSCJvyQsyYl5IVN3nxAFA25RCbsEnUtLZXr++g0
 qO2g==
X-Gm-Message-State: AFuF++nd9/XGszVUtSp1Tn5RLxN5LlYHYK1UYNmmtZnh92SNBAqeQNof
 LUsqUO2tdejsltogv7VhwSJLIvu0qVZk+N4kjK8vsID/E/OYh3ICLPiY3AToD5OI9/7nKo6COqm
 zHE3E36Wz4XHW5+eHd9YlaIMBPru3T7owGPas1e0QsNK/ODyV45d7Z5QG8+5K9uNwTK0Dz4Egc7
 T1Rco=
X-Gm-Gg: AYBFou3Lcz9/qHoWVMufwhTqUQaXKQqfuna7yntOXeolBt3WJ5YOvjpp7+yajM/0soA
 QQ5QanNZQUQg1Pwpu+3+k8u1bF9RGDw6tCYJ7BcWn28X1HU8N2qjoyMDU/YmYR99ZR/2bqXWjim
 DsZZLAo5RtxxgQdZvGy+aiblxtVSyKMdVUwv9wDvvcs92/+ZD+MSunwN94HSdDIfveXHtb+fhWF
 fmIAzrB/uUSmZpiSDmvoW0SeDJxlJr71fSE4h0eouELpkWIstsZQY6sgMybh9fu4E1d9S8CGpm2
 +kthzjmQP5EjmNuf0rV693Es02K9vgt0HlwoiLXdPvOU60mDEKZpd7Iu2PEvRBjppTrJa+bLQ6Q
 qiFI0tYAhTFiL/1bH9XDNerfdmTFI/jx7GU8NcQ==
X-Received: by 2002:a17:90b:4d87:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39aedf66692mr8506560a91.2.1788368466792; 
 Wed, 02 Sep 2026 10:01:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4d87:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39aedf66692mr8506406a91.2.1788368466144; 
 Wed, 02 Sep 2026 10:01:06 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.206.202])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3318bc19129sm5591611eec.16.2026.09.02.10.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:01:05 -0700 (PDT)
Message-ID: <8a5d64ce-6e25-4d1b-9d24-f2995f22222a@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 22:31:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] u-boot-config/domain-map: Add Qualcomm domains
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
 <20260902164546.GE1764417@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260902164546.GE1764417@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1WEQWCS-QUUDr-L7tFH78WlHfywL_CTl
X-Proofpoint-ORIG-GUID: 1WEQWCS-QUUDr-L7tFH78WlHfywL_CTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0OSBTYWx0ZWRfXyOqIrB7U7JNX
 v8/73Hq5wlTTaatwrYy/Xk5NYESQTWa5hCDiisWSrVTnjON2JoyL0guj8FrFX/mFIqAGw7/ZKS0
 Pw8hTMYdWkkx4MfoHhBjZvlUC5GoAXecTtN/jkjeIfVV/hnxWsZjknqqpYB1R8YJOzS6e8ugwXk
 2GsLu1/Kp60+IE9HBParEI/4vbj+lgLRnwnwDKiBVHA76I39INqRm3D2A+XDcAuzjRtk9RBRiRW
 XQ9V7EOwnEisI7cPIl268pQ+ErcziL2ZYfrCzwpnd4a2BzEFSPb+D/wu/7XwHD8pcYgsJwihcDH
 DedN0TnkW7IaqFUL7La/vCGaPCAoUNoAD9t6nVRf8Fw2NEN9pfel5b25Z0FIUY04qvd4biMgL9+
 a/P8oSR4r9MrX7btnXwMurJiTEaxWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0OSBTYWx0ZWRfXxtFCnPdLB6Po
 PF+BnpCRygBtMGlUotimjZdHStnZw/cJMI50IukyI1ccIqE5BaB+JM2+AtexXNhVr2ycL209dHp
 GtkIhVFxWMocGbT668KifITkSRWtk40=
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a985653 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=yprIirTdMnYkynrOz0ik/g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fxsupKWpHvEZj3wVn2QA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609020149
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

On 9/2/2026 10:15 PM, Tom Rini wrote:
> On Wed, Sep 02, 2026 at 10:10:06PM +0530, Balaji Selvanathan wrote:
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   u-boot-config/domain-map | 3 +++
>>   1 file changed, 3 insertions(+)
> Thanks for the patch. Do you need me to re-generate any of the old
> statistics pages with this, or just use it moving forward?

Shall we regenerate for v2026.07, if thats okay?

Regards,

Balaji

>
