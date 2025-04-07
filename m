Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F67C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFEB982D0C;
	Mon,  7 Apr 2025 16:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+FzldJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C6C82EAA; Mon,  7 Apr 2025 16:17:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DCC82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378eIWM012218
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 14:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=crf/spmf3U8rl0EBvVba80Kc
 ymtpM5A5RTX8mVX1LAY=; b=B+FzldJCVvtObUhRqPxdJTAJjgDcP65fNHzGjOOg
 Et1cyWvGr94RW8KXvNH5vbezvrhfjWemt2VIVvfxVAqLu8PD0rYXNx4PIcLh20Kx
 cJt8RVyKHX+JLbuksSoc3XWstvjnzYfiq+cfCBMw6ft1jMVSKccOV0sHahFjQZ53
 zBHS4scuenONVycGE3BEAur+hL/SzHq4ip5snlnKwZ4+R3tEZi38py/qIxS/2MlV
 gVZLrkdrBQvHXPugcUH/QtJSUiW5lfwEceO6o+n1zR1Y8OT/Rb4c8Rc6IY6+EXgm
 V0z3MVX09JDfKGs4ErWs4l56GsdHwDfxo8O2V4E3jKiN4A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm4dn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 14:17:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-476900d10caso105855601cf.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035431; x=1744640231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crf/spmf3U8rl0EBvVba80KcymtpM5A5RTX8mVX1LAY=;
 b=o+Q7PKT864YkUK5GxCinrmxxc79hsCpyz4xeLaC3fpv8OzK1sa7YZhN/TBEjlepJhI
 PJIYLBypqWad7xMamzY57UE2vqYaBbPBpRUc2noFrffN8fBjvTZJzBvs9ZE/1fIZ8t8u
 LmDiAqoEcYyXuDddLy17j4PDPkJMc70lWvOt3a7TEh5s3YvEF90u04s9OJ3XJThT9cuj
 jmh/twT5LgmJn8rDAdXoxF7/JTDnJdO3o9r6KUhKX0QoQNiiNexIJoKcZA4fe0+2qkNO
 7DAuZfwttFGmqa3jn1D87Cct0OF9/imuGjlLA/9k5MAMOzyU8mhfXKZ+feZ6pxrS3i0n
 DE1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCbZ1iBJRqmjtJDwUyDOdtcnTwCNQ9vNbtkzJJj1pMr5Xx7DMZ6udMdIZX4bA3R9DcgbLnHHM=@lists.denx.de
X-Gm-Message-State: AOJu0YxuFeZuUJxklzTGS/QHIkRFQndR/m4mrF12+FhiPrFkRMRdOx0e
 pIZ80rGyRJsMQ0sW4yal5dvA1/DqTMiVoOZrsLrDqaxhVlqGzwsTzVLgYNbgOWenfp75pyw8qe/
 KRQLW8juYTt9Pv5kOWzDYGO2EhcyuWM3jupB08hj9gT0qYbCHIS7c
X-Gm-Gg: ASbGncvt3AbrJGDk/rkrMELCJHH6mo53encW31YSneOOMJUchcNfS9AAWW9CuVZeDiZ
 hx8Zi7OH7r0ypY7/wNsCiWisjXVcX2GBvGPZ77DYDdSl4FrsIFjhdWHiFjRd3gwtuPFZIboIHcF
 qrOxJbcMxbwr7MG4/jdeKtEI6FZUyWRBK49g9fwBzC6s/DW7z8R+NiMmbpZ1icROyvObSWfX5Oq
 zt1Y8Vom2ZT7Hcb15mqgmO5jmBfEF8ABAh6ON+WfWnI1qyf1RXAqUYc7KGYO8UDbRdyTj2oIOLn
 OnXq/RVXzNO4aZtyUVDRDk8ebaV5JnKgSj3HkEmowrim9AQfVCY=
X-Received: by 2002:ac8:5fc5:0:b0:476:a967:b247 with SMTP id
 d75a77b69052e-479249d5d9cmr172084131cf.47.1744035431346; 
 Mon, 07 Apr 2025 07:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvq1H8ZLH1h8/U0xB76mT2oTna+3/wxsYP4aEEKXjqhkx1pz6J/pzzMFBh7oxHIvgtjMAzuQ==
X-Received: by 2002:ac8:5fc5:0:b0:476:a967:b247 with SMTP id
 d75a77b69052e-479249d5d9cmr172083631cf.47.1744035430820; 
 Mon, 07 Apr 2025 07:17:10 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ecasm12620695f8f.18.2025.04.07.07.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:17:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 16:17:09 +0200
To: neil.armstrong@linaro.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
Message-ID: <Z/PeZVBhwcNOVRAD@trex>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
 <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org>
X-Proofpoint-GUID: mb0oxVcxRar5ys1snk3dwBqY2iu7_FR8
X-Proofpoint-ORIG-GUID: mb0oxVcxRar5ys1snk3dwBqY2iu7_FR8
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f3de68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=j6XI7r2HB7QKrajkT_wA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070100
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

On 07/04/25 14:36:51, neil.armstrong@linaro.org wrote:
> On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
> > Select the right clock for sdhci.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   drivers/clk/qcom/clock-apq8096.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> > index bc00826a5e8..551f52d5197 100644
> > --- a/drivers/clk/qcom/clock-apq8096.c
> > +++ b/drivers/clk/qcom/clock-apq8096.c
> > @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
> >   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> >   	switch (clk->id) {
> > -	case GCC_SDCC1_APPS_CLK: /* SDC1 */
> > +	case GCC_SDCC2_APPS_CLK: /* SDC2 */
> 
> Should be GCC_SDCC2_AHB_CLK

why? also if I do that, mcc fails to probe

> 
> >   		return clk_init_sdc(priv, rate);
> >   		break;
> >   	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
> 
