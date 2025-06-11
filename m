Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383E3C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 10:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6E6828A2;
	Wed, 11 Jun 2025 12:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sm4m7/SE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F29582A4B; Wed, 11 Jun 2025 12:07:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D1F80050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 12:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DDun029236
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pzw6bV+aEqAcL09phPCFbYtLAxgi9UXIozs4/Lpu9aM=; b=Sm4m7/SE39b6xpzz
 4hEqKjggLwDq3ApNnJNjE+YM6plVOmK7B+sCFbs5h9Vj2SgXfQU3QQj9kgs+OBVp
 ftOElZ4xrRB6RxulvfEoQa/EUch3UCchC0ZWgfDvROe+aFer8Krz7xf15cnU0s69
 zScAY8TBbEFY3pAQMm92v0EjFQnrkVH++UpXpPY9o/vG7Grwg3mqAvehMXz8c+j0
 ZF1+DBZgqOFZagwqS9+q2oKOgnop5xY960u437KAUpLsaBCciIqjff46c/u9T9UX
 Cuy43jExEp0qWmRvDCjbjHSj1Rmpahcq0pBda9gBQlOHaOmQsbwj3/SPLbC8eUU1
 wBjS6Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn6cgru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:07:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b115383fcecso3789688a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749636423; x=1750241223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzw6bV+aEqAcL09phPCFbYtLAxgi9UXIozs4/Lpu9aM=;
 b=vGz87DqP6CBBgcntdOg2ljaUvXGAlIhBRwCzSt7Uh6ElbJwepX1N6H5vSIrOAvJoF8
 wQDMqc6HkVaHYfVhbLAmOv6b/bRP6iSUJneWoN9i9/9AHU0Szsw+UUCoO90/cpyj6oVD
 Js0ypy9Wioitoc0N/LDsm8rby/TfqIOvsTPos36sO6xa0X33GwxJebwtWMsfrcPJ689P
 y7dFsEJWyhD8B2E/HTZS42g2KAAUUfMvSQU86DvCzKkxS4/OmhPtYynoYUp/LM54VpLg
 UjfeF02KFmIGgw5C5gDl1QHVGz/7q7a/RAJNR/9sURCrtBWWhlEJ2/vGtt6FekJgeWVc
 Hcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsQD4KG6HlXW062ex1OBQ4iQncu6hMO7BKdfMZltM5VdYMt3BfHcb7okFaHS8EbKMcsEN6+kY=@lists.denx.de
X-Gm-Message-State: AOJu0YxP+JGlyUSlvL4ffXOk0zdDvW+lNJIgVAeeh18QkVbiTLy2SwMS
 ChGfHEjGu3u3Q6TX2p6E+g6E2t+/WahF+Ij6zcXIt0cR/jHBAL2P0sTDxtJXcK+66V2zOYOH96r
 OBxxsi7qpvDa+4RKYop7WsSKP4g2YsDiU+VdM5Foc9ZJ+RxI/9/RS1RJy
X-Gm-Gg: ASbGncs/LIPWEat+fnC28/uAxWVsAZ7k4orzhpWOZROukgy+ceJbwJiKUaL2lH2p+2N
 4yqLr3BHO05286Y7fCr2wft95i2lO7tCVRhKMTVs8/WwzqnBVSjbPcn2t4NiZq/0LgaC4GYvgre
 6Y3n6hfbjJ7qJhwdJcdyF+4bUULBbKRvLniFHfpQrOMD4Gn7x181aFFsXrO7Ib+pA2AqwKOY5rY
 6zZWIMfgdfmpSMZ3C+r4d5T212rEDu/yWkTUgDiI3jQyQ4StNJsGOq8Rn2nFvmOc06Xu4eBfh8E
 M8UDMeTsA1r+mX1MTEle0H8pklWO6XCiryZ+yPfNkrx4cU9HKNmd
X-Received: by 2002:a05:6a20:748b:b0:21f:5adb:52c4 with SMTP id
 adf61e73a8af0-21f8672610dmr5335470637.30.1749636423112; 
 Wed, 11 Jun 2025 03:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4gsNb0/x7vxdR+rDUfwJ5FzVyOjkeebXdxWyQ/b9hS1R3dS+wczvpU+yK8UtxtHBpU+TrwA==
X-Received: by 2002:a05:6a20:748b:b0:21f:5adb:52c4 with SMTP id
 adf61e73a8af0-21f8672610dmr5335433637.30.1749636422700; 
 Wed, 11 Jun 2025 03:07:02 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.97.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c7da0sm9081134b3a.139.2025.06.11.03.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:07:02 -0700 (PDT)
Message-ID: <6b4f3eb9-830c-42b5-ab01-ed715c019dc5@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 15:36:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] board: qualcomm: Add MAINTAINERS entries for
 Dragonwing platforms
To: Casey Connolly <casey.connolly@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com>
 <18193912-d05c-4584-bf45-e9f2f97be7f7@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <18193912-d05c-4584-bf45-e9f2f97be7f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4NiBTYWx0ZWRfXxuVdE7T/I8Qu
 Hht5VKTyQ0mApTDI77d2isEoYNw9KTOV05dJgOdbzDbIEpfEjKISRo3bgwEIzTLnjmUS8mI9ZzW
 uKjIpKEngcwM/C5Px15gEK4LnhtS/AW+edOg65Stu/k4nbefiS2vLtpHTR543u+zNvJFFyuDXBS
 X4laTTVJImFDcEqgnWyHfTzYvCuP4nX57kAEllAECB9N5ehAlb/OiBgYb0DTYL5oAmc0d/GJ54Z
 lDW1EKlr/Fp7A5R61FjZAi1x71lGVnrL2XZqvLw83objr9kSxFH2psI8MMCDvbUPU7aVq6D3PaU
 a4yQirj7lbXG3iSXSQkF+mME4UX+9Unf7vZFq/HjCJEareygw+GcWva6+cOYDGE+dx7Meoo1hpR
 EAsxDnz1SWVe6atRb6wgPSGWQtKai3Qui+rrBwmXgrxAM3kl/9ul2yY71jt4M7VZdIsMeOYo
X-Proofpoint-GUID: LkDtsrzlxrVlGsASB-3bBXqBdRWzWqEo
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=68495548 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e5+WE7zD2x3yJ7amfSdP5w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=C5fs7dUat4WinGpktmsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LkDtsrzlxrVlGsASB-3bBXqBdRWzWqEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=788 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110086
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

Acked-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

On 6/10/2025 8:52 PM, Casey Connolly wrote:
> On 6/10/25 11:37, Aswin Murugan wrote:
>> Added MAINTAINERS entries for the Qualcomm Dragonwing platforms, 
>> following
>> the discussion in the referenced thread.
>> https://lore.kernel.org/u-boot/20250603192206.GK1382132@bill-the-cat/
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> Balaji and Varadarajan can you send Acked-by tags for this? 
