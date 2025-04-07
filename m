Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E4C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F2882F65;
	Mon,  7 Apr 2025 17:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3+hTZOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7CD82F6F; Mon,  7 Apr 2025 17:27:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F2F82F42
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqiU013367
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gDtxZNRbExzwW1S4WUTl6FdI
 dWVL4n9sgZqyRc3ZJMs=; b=L3+hTZOy8yY5iw9PcKTeAOxx2+cLrVOsCW7VcNWB
 eYNHa93Vcv/HgudtcqoIfumXHHvct8lhtHG3Gyant9BnLrfEWSvNPqxaveDxWvgp
 d9vdjCstzM7/PxaWsIYkP2990927iW8T4pY34+e2tvDtGwzvYQyzaeUeRxEyaYdL
 f3ROeu4vSLuvo+0WhFVNYYsuzdVPJqR2WVrBjKlZ3w/gDiAPQRQUud+k3TiF+bSx
 qVUvfxq2kim646odwWB7TfTgs+yvqx4/niMcyqdE1LI3MITs5gTrJ5xKuidHnCgE
 unC5Y01cW+fDUgpNEzyU2NK54hePr2UOOlbAzk9Bts/+Ag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1cmbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 15:27:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c548e16909so411462585a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039635; x=1744644435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDtxZNRbExzwW1S4WUTl6FdIdWVL4n9sgZqyRc3ZJMs=;
 b=DOlnds8ICbwb24nqw+RwiDd5eoYaOVsCXI1U4h2Kd2ckxCBH0O6ijO3lLoiWMqc4yV
 zoXR2a9jE/WEhUBPTlJEDvJev7G5Dl5WceAMtCx4fn5obGvQNlajFUFl0eU8+XL/QJrR
 BABSQFk4h8TM1Dwnj/9QmxM+B5ixWhVWokTqK0TP9KbH1YkclcvW7lPgex0L+gFIq8JF
 Y9FEyhS/HumoVYNULdSvt/ox6Ymm9qUAN/Ul4Y7+TiYVUS4TnCsJ8GoJHjb5Q9FcgdhT
 f8/DpeeGXByeRe+nBSwOsAS9hPL5mTdBVHa/o243cpWZBsSp+Z4VOx0kJ8fphr4D9yj5
 f6XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcI9tT73ZDXzk5HgbkaK81ZgtkmTbOxwtZmKqjZIoelgZmC+2GOaEhwvxevQWN1sSl67s4KDE=@lists.denx.de
X-Gm-Message-State: AOJu0YzCo0mO+Nc3GLvy8eHuWQeE4Qk1JrjqW7hesA5IvUnoDeVjcdFi
 0WMbC79gtXH6zDqlBuxPEhZ8kfofOpjh73d5ai/iBXmHSyFQ15T/UkcoRccJNK7NH/FhafJEUSq
 t+6y22H28I5qCgIVbVReN24JUtXu//luxnZtYhns0JempJSrAqnmC56MO7zD/
X-Gm-Gg: ASbGncsCVsh9n483oVCjXOaZrq7QOOEl0EEN0bo6OWPjHzaer5fJ0+JtyTtJMy3wnWc
 RalWSiScS+xHtfcKvu1Dftx3NL4FXqJP8h+9QjN4a1uM76yptnyS4bxlXVVqvSMfAX/4bPTLKiW
 3mXPuniBdGD36j991ciXIfKAhd2+HQ/Y+72WuHjkbnKs87a9yF4lcmBt46K7iUsOYE1BinVvIry
 V6k0580Ger2UF5IjgqWXTJbnS6ZPhfDtWRJ+5sDrBko3NdUhpwtlMAc/aoDif3L1JF6eWJmwJ+6
 OSM6zuVuKV62Jff1BvKNlqqcVL0vYIcbnOZt/1dowgInl/C9B5A=
X-Received: by 2002:a05:620a:390b:b0:7c5:b909:fde1 with SMTP id
 af79cd13be357-7c775a2dc17mr2230397185a.25.1744039634810; 
 Mon, 07 Apr 2025 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHldJNovGJ6tUMEFNdhFa2Kuz7zJndL59HK3s7gzWtdH/Hc4+APMqzvt+hYfaQDuWGzF9NKTw==
X-Received: by 2002:a05:620a:390b:b0:7c5:b909:fde1 with SMTP id
 af79cd13be357-7c775a2dc17mr2230391085a.25.1744039634344; 
 Mon, 07 Apr 2025 08:27:14 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795db7sm140038905e9.25.2025.04.07.08.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:27:13 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 17:27:12 +0200
To: neil.armstrong@linaro.org
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, caleb.connolly@linaro.org, 
 sumit.garg@kernel.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
Message-ID: <Z/Pu0IhrhsuUBgez@trex>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
 <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org>
 <Z/PeZVBhwcNOVRAD@trex>
 <c834224a-a69d-42d5-ae2a-b6b363d9d2ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c834224a-a69d-42d5-ae2a-b6b363d9d2ee@linaro.org>
X-Proofpoint-ORIG-GUID: MMSXNWqfionR3WCBesRIAIA1Ain9Iu9H
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f3eed3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=xUTvVhGfsdnD6KsvS_EA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MMSXNWqfionR3WCBesRIAIA1Ain9Iu9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070108
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

On 07/04/25 17:12:45, neil.armstrong@linaro.org wrote:
> On 07/04/2025 16:17, Jorge Ramirez wrote:
> > On 07/04/25 14:36:51, neil.armstrong@linaro.org wrote:
> > > On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
> > > > Select the right clock for sdhci.
> > > > 
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > ---
> > > >    drivers/clk/qcom/clock-apq8096.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> > > > index bc00826a5e8..551f52d5197 100644
> > > > --- a/drivers/clk/qcom/clock-apq8096.c
> > > > +++ b/drivers/clk/qcom/clock-apq8096.c
> > > > @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
> > > >    	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> > > >    	switch (clk->id) {
> > > > -	case GCC_SDCC1_APPS_CLK: /* SDC1 */
> > > > +	case GCC_SDCC2_APPS_CLK: /* SDC2 */
> > > 
> > > Should be GCC_SDCC2_AHB_CLK
> > 
> > why? also if I do that, mcc fails to probe
> 
> The discussion at https://lore.kernel.org/all/Z/OqoqnPb1gfk5iG@trex/ made me thought using GCC_SDCC2_AHB_CLK fixed the sdhci set_rate, but I maybe did misread.
> 
> Neil

can I add your review/acked?

> 
> > 
> > > 
> > > >    		return clk_init_sdc(priv, rate);
> > > >    		break;
> > > >    	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
> > > 
> 
