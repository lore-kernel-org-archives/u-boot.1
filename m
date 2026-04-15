Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7347F41996
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D2183C2B;
	Wed, 15 Apr 2026 14:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3+k0SnN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDPx0M4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10D983D8A; Wed, 15 Apr 2026 09:14:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB80838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F3AZII029994
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k8aOMsBAsvxTPKdy5USGSGkR
 prDaxaZhJOSgIzRl/2E=; b=S3+k0SnNTIHIjA9x+p5R7HDiT5g4pCKNEjF0+LZg
 NGd4RnqUM0n7VeWXtxiFWSX1HP91RATPdDMG0yq7qUbKTRlwJfIDYHZ23sSfNuuq
 KfKwPqeR5ykIviadWZH5UPal5NKUbP+ftHZFEO9N3DaykUOj8aekeRUZAbuidESn
 tCxg16N+DEhF6uay5VCEs2Oyxq9BE7IWnK/lYde9Sk1H1YjLbeQUebt54reP3cTa
 3WwVsubMPH6BIVr9vcFBCIKY2aAV9YZRGe66V/fKkiUJ1RHK0ZExiAaBG1Jm8ULg
 oXdRJ/amegGCK/nDwIpBWuhdJ89GYmqiMODIWbWd50hDUQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmktrw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:14:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2497cc190so32427875ad.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776237263; x=1776842063; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k8aOMsBAsvxTPKdy5USGSGkRprDaxaZhJOSgIzRl/2E=;
 b=DDPx0M4dh5CAr8xKLvhbIsD87noiuVSD++wtT3tjVMEGBQzlfVf9e4yZhOe0jXQ8KI
 J3zr7Aka6MJFxuWeusAWK+v3hWzlauczYOEMNhIdT3pX1GC9RevEPQxdsOSY6TOaIaNh
 p3+gWchVNGk0gX9Vrq03JPR3/2ps7Lzl8AcOSRnBccDCsBQEP9PZBgQ6b/tkgYs2cgbX
 A3v25fn5LNrvam0Q7HVJ1BPQx/FU/JcMBt6iEMHdqICp9modxDhsCXbYYVljSKirXvMQ
 gYjJdII8PQeZ8dAEuRfkI6hy+O3xfpj7zIhRmoPDfIePOR6YzWCUGhXsf1ftLCu467Oh
 qIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776237263; x=1776842063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8aOMsBAsvxTPKdy5USGSGkRprDaxaZhJOSgIzRl/2E=;
 b=U+pMlieuB1sxiLgJg4W9ejzpZPpbnIjSL25RJ1mxymDtLBTAZ7ZxYOhdihsO6rnQne
 9zhPuR0kgtmskhM8iEDnShiNGI7RHDMXF0NnwIY/PvxlFRsd+xCinhzzAThL8R4y4Uz9
 AuPr2ujDmQ415t1zO13GUbsySBL5EU089l0BqGcZmsCYqy+NjQpVwm5FqMyriYWqf8ba
 D3MOg8y34+Afuz/l/B0Nga2mEa3N9WtmBq5vY4DPd9XtZRQBNuqGLh+bqZh0Gy1qP9YX
 N4VSqU8sNVThvAZ90Gvd0YUCtZGDmF7XykhY+X22S2iSN/VakzfA0foQ+FznlmejnXKf
 QF4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9olvbPgbjdHH3nAU3fBGuE3bUtkDIVjRc8hVSghHHji8wYv+yNoifCbtWo6I5J6QyaZyerbLY=@lists.denx.de
X-Gm-Message-State: AOJu0YyweZ4CP56/vT8Pojp9wuluPp25XYjNQG706QnIP05uKua1FkWa
 ldWCDoTmv+OhDHF1TWTR3mhdSjIqYj9WXaPMPPmRCf7RgFlFMEzOCf26PfGXpgMeq9wmpxbmQzm
 kZhMpBdSgvbFdRg7yXDzwKBxAX59BEHUemPOcMr3Olghv45yrERNXtOGl
X-Gm-Gg: AeBDietw1H6j6kZJtQhe3K03tc9OZPr7FWR+LJZSkUzVS8LvpGONj+HryKclQ3gUNkh
 q8o/B0JzZvJHIYG9V+HkAfl/1cEUG8fx8l8wf0ijE3IM2Ia/iIfO3yd0zJ3+lm26IIPzar8AJcW
 LzBEcnNaSDlHoEF8bVhbku14xrn4M9W4/VHqxGHKOJIyfiKnYtRXxGCt9QJwwC/ayXDt4G4YUQS
 /OszcWT2khjuLyoG+lFJTp1TVL82IQwcCasrvzDpuTsZvVqKAcdamL5SgpNK5jhRHW3x+xLnX0P
 +J928sNjsov4Hyf7ecSRSKi8HL/rWrNXwmXfqiOxasE5ePZEPI90xgnsFMOqmZenjP7/Vx1N/ew
 eug9b1b6q2DFrrQhgnoNlwCyqIfuxsprNa3r3efWdMMxkSZzpS15yeAHbYgHKBs0Vu/xGNd+W2Z
 eMJp6KGFoADs4XWaLbPemVhT0ry1yGLK8IKNuyGzlzqHzCkJijIZo=
X-Received: by 2002:a17:903:1b67:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2b2d5c55845mr181254495ad.4.1776237263100; 
 Wed, 15 Apr 2026 00:14:23 -0700 (PDT)
X-Received: by 2002:a17:903:1b67:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2b2d5c55845mr181254005ad.4.1776237262581; 
 Wed, 15 Apr 2026 00:14:22 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm11141755ad.37.2026.04.15.00.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 00:14:21 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:44:07 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 0/9] Qualcomm IPQ5210 SoC bringup
Message-ID: <ad86v66pbdAchTg3@hu-varada-blr.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTi5K5iqeCw9XthrCPALti4Z5sMFaBx6rOE38PsQQx_93g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi5K5iqeCw9XthrCPALti4Z5sMFaBx6rOE38PsQQx_93g@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2NSBTYWx0ZWRfX84dHMixB/I8d
 mKg01/rcmOrdtLhurYtb70bwkxb/QJzWU7mu5EjHjpdS/x2hC+R3e2hDtNMyHsct/+gUUP2geD9
 BBPEYIhbsUo/XXtDByK8tQV6nBQV8antbcLsfJmWudclVWaH4jqKcn5u/VimH0sWAsvfYgrb98P
 QUMKRluae70DSUtdc9Y3P3Kcy6680ryCL6YWDJezczD2o0zxCrcEBJYA/dCBseoy+OF+mYuNaxs
 ePjO/2CWI1IKeeJmkvjJi32qYzu+8kyarX2KgTHIaweXRg/oWbB84M8IJLU5S2UMoerxznsZzuA
 gWHPg6wQtMRwYf7+qvpBkiw7a+qPc2MhmUyA5a0BpPC5FTGHxizNBKcpcfNnRlgkknCTjvUKQdn
 yPe8Cp2V6cc75u4pYANLPxHsIoPMUEZCLAYH6CF1vGEEa2SJho8wk5jTGj8vSTt16syU7E+ulF9
 ZR2qEZIIYZECh+E5hlg==
X-Proofpoint-ORIG-GUID: cX_9JAba7LzXDBlBM1y3RE-s4hL3cfzb
X-Proofpoint-GUID: cX_9JAba7LzXDBlBM1y3RE-s4hL3cfzb
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69df3ad0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=mS_dT4ZAjFHniTCJa0wA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150065
X-Mailman-Approved-At: Wed, 15 Apr 2026 14:09:40 +0200
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

On Sat, Apr 11, 2026 at 07:18:19AM -0600, Simon Glass wrote:
[ . . . ]
> > Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.
>
> Should that be IPQ5210 ?

Will fix.

> How about splitting up patch 7 a bit as it has quite a lot in it.

Ok.

> Is CONFIG_SPL_WRAPPER_ELF intended to be a generic feature or just
> something for this particular SoC?

Generic feature. PBL has moved in that direction.

Thanks
Varada
