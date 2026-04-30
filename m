Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212AFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 05:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488958063E;
	Thu, 30 Apr 2026 07:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IcWyHatr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dU5xhrQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90388842D7; Thu, 30 Apr 2026 06:40:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A4B80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TNebFW831724
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 04:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=x7wlDcJxAasvptI84SNE9ZNO
 OXXIpp+KqjC2GCG5rgs=; b=IcWyHatrNTkfWz/AIZEu9mKqZs9bb1ufaXhRgb5j
 TIxk1T9LVgYF7vIfFoajhd12t0ZS4auv6T8edU4zoB9+DKhn3vk11d3A4YH+2E0O
 iQr+FB+g2EeNgcALrP//J++xMiilIEFfx/U7NJ/MZGXYC1OU2J3PAUgfYzgUw2GQ
 ILBy/M0kKqvGzOm4+R70xP70kve3EdR9XizqfGAy9a8Wh9frMA0MKE5mtqCFWVvc
 s++6S109GnDbebl6GO0A/n8D1ZOiYMDXcBlIt1YJrjCpZkcGy+NhFHqqgdhKoAcn
 Fv4RHfBhmGIpj3azY8xN5O0WHlD8mTAVb35hspAsL+uYzw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duuvb0tud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 04:40:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso618176a91.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777524025; x=1778128825; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x7wlDcJxAasvptI84SNE9ZNOOXXIpp+KqjC2GCG5rgs=;
 b=dU5xhrQE0eZ5IVH1k6CIL4KXk1rpQFNHQK7DZpwgewWU3EZExU7dOBt7+003zsumhI
 NsVbv9qZBtVJFOVszm3M6bdLT6ulsL219ljHrNAaMY1MLRvtZuuNAXLAJ/7hQJPfHypG
 UDkWr+41sbFPRqTVGcipbuiAUq4voTnCklm71TVA26vAcnSaoDWX0B/nUvV6P0gSaTPA
 3gd6OWKZS0czxLPjrHTsJJENPBDkB3rIo3o/HKzP+7jZqpTtaNmzN5jwHauy+365/Jn8
 1NQvWWh2ogRDb2CQ03ENO2U7m3dEa0nTcnckjhJP4MHQnJC9mp0B8l/Db/c9akxKrD6i
 P0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524025; x=1778128825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7wlDcJxAasvptI84SNE9ZNOOXXIpp+KqjC2GCG5rgs=;
 b=B4nTSyWrptrmYT1Cwiq9oLQRM69BdY/ygJLNMByoN8X1uQxKpPQJ0kNHaob+14C6RT
 Yo/M9b5Uj0dMpNGn/KsiQXFxejnVgfmQH5dLV5ucHaYK+rAzkcIlTuID1g76E2lCrpxB
 SutOzhLRv/QaleRbV/dUPK398KIa0OP8zK3REKfFejysF0TNMdvjL00OEGGV6Gz9fYLc
 x08ziUwd1/4oxJ0p45vxKo33SPJnylyHbOnaH0XA2nUI3QY5xhqTW/qB14qzhorS7nvS
 2GLiGhvbXedFvn4ygjXY7xr4RMETxthUNVzfkDtAzjXBucvziWSfwPwcpkQtIgIChuiL
 I2ZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+moyrfF0rNU+/8IJnOXWJ/nol1lk+1lvFOw/DzGyK+1lBqxrwLoEuF/poJIjcxIIeeTussa1g=@lists.denx.de
X-Gm-Message-State: AOJu0YwOveQvC04Uwu9nZHwcq9QKd6QosTqiEqGUBJFkjZXxwS3QUcy6
 OEXN/OHNMAE34Y1Ic8sLJyfP03EeZqAZYYjp6MAmRsxSNshIgMPPvLyYlMtyLjxyZmlvPWpJO1X
 O0iB0jogeE+dFu2wOTueGE07TGCiKvTNZPmHxs2FN4ewkf1UnmCCtzaF2
X-Gm-Gg: AeBDieuy6GgqDaOGEdONQIn8iM6RWXJDNZnjDCPSIxiLLLf3VXJcK5upwxdbajeZ2ZD
 nbzuXlZO6N2cIQNGKiWmLk2g/ZIReWBt8J7jpWWMfg1q2kmU93ct4w/h0qWG/MHjxxVPMUHicpE
 6tztC9mF71ug8LHYB1EgVq+bcxrmeQ/5Jgx4pHprcAFCr/wQbwHJW1WMmhMdRrRvWa64JPFHPAx
 ncIyg0O2dAxqh6M6v5H1tyhMeAtomcbNZm2116Wa8rLnUt9Ra2DR0zgfHe/vsCDvT2BuVPLGBMf
 mECveH4O9VjPKQ8Y9EECA67UUNW6axrpyUxNti9vrGOwl1kBOCZxASNQX1H6c5d8Kcrppqi3HPF
 B027FjVOEINsACSvTboSy1vnOtunpPTJckF1dU3aLO3ehg6uXplp2ygphAsN9a46xqDNSafqM5R
 NyQSBhJ+tqJAIWWxBoOnme+Ywzo233TQsTDi4rU78vQymGwy+s9GdHSPRTzFDUyA==
X-Received: by 2002:a17:90b:1643:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-364c2f2301amr1209825a91.5.1777524024617; 
 Wed, 29 Apr 2026 21:40:24 -0700 (PDT)
X-Received: by 2002:a17:90b:1643:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-364c2f2301amr1209795a91.5.1777524024142; 
 Wed, 29 Apr 2026 21:40:24 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364c1ed8676sm430399a91.1.2026.04.29.21.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 21:40:23 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:10:09 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 08/10] mach-snapdragon: Add commands to create wrapper
 ELF
Message-ID: <afLdKXgUwb/OI2Lu@hu-varada-blr.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-9-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThnBSX2vOdH+ieE_DXub0UuJNknq8Y_0X3AjfQSYDoLig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThnBSX2vOdH+ieE_DXub0UuJNknq8Y_0X3AjfQSYDoLig@mail.gmail.com>
X-Proofpoint-GUID: 9M05D8YFXhvDUBz3Q9CxNkyhjYvqXu0P
X-Proofpoint-ORIG-GUID: 9M05D8YFXhvDUBz3Q9CxNkyhjYvqXu0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0MyBTYWx0ZWRfX4P9e4cPURxiY
 F/9NQkEI+dL+Pvi+COstXB296+EUQBsTHyPbrOUDwe8F2OCYM0+hU/JmY5g6jsry56gQ4ERH1tQ
 KZ8jHf//tqE0rl/3GbIsMH8Ma73BL6Ye6iygO1hm2x3nEeL8UcfTmjigKY+CYUuvaDwqhOFTjhJ
 fEerM6GThUzb7I8XlNmPaOcIesXO3LmumaYrJrwa5zAu8jQfNh1pM6VC45O+9H+QX7SniAQ/UMN
 K3zyCbszRUj+df42we3M/vZzk5Xbp/DrQLaco9EMn/ovCfAH9N34hKIpWMSUOqxjgGI7Ry3QpFY
 06tonvlX15Ze3Cnnt/kmyuv7PTvnkTSPTmiekUP5p1IeSOyFZnumzN0q9mbpXZqsgBvB9GM6TGA
 1Zrm+HJWapwGP4JxxvDqLSVDD3KWIBPfIHsds9Sj6SDhbpYYGl8eAOklGhLuB2mU+nZRPfsbTq9
 sOE7MMH1A60CATP3ZEQ==
X-Authority-Analysis: v=2.4 cv=V+JNF+ni c=1 sm=1 tr=0 ts=69f2dd39 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vl_p0DwEg2HlECmP8hwA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300043
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:18:40 +0200
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

On Fri, Apr 17, 2026 at 08:54:23AM +1200, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-04-16T05:39:18, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > mach-snapdragon: Add commands to create wrapper ELF
> >
> > The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> > an ELF along with additional binaries. Hence add the relevant commands
> > and linker script needed to convert u-boot-spl.bin to the expected
> > format.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > arch/arm/mach-snapdragon/Kconfig                  |  7 +++++++
> >  arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds | 18 +++++++++++++++++
> >  scripts/Makefile.xpl                              | 24 +++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
>
> > +ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
> > +INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += spl/u-boot-spl.wrap-elf
> > +endif
>
> Please can you use $(obj)/$(SPL_BIN).wrap-elf here to follow the
> convention used elsewhere in this file. The hardcoded path would break
> out-of-tree builds.

Ok.

>
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0
>
> U-Boot convention for new files is GPL-2.0+ - is that OK, or do you need 2.0 ?

Sorry for the delay. Had to check with our legal team.

The present guidance is to use GPL-2.0 and not GPL-2.0+. If that is not
accpetable to the U-Boot project, then I have to get back to them and
try to find how to proceed.

Please let me know.

Thanks
Varada
