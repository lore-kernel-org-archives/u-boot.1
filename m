Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E98C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E6E82D39;
	Mon,  7 Apr 2025 12:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDFxBqbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2732982D6C; Mon,  7 Apr 2025 12:36:25 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D875C82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dogc015632
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 10:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IPRfGLu2RQuySUHjBJ101JED
 uWjZ3z8AGWYhOJAe1tE=; b=eDFxBqbpfwufZfGe20okM1z16/1Ki0NDll1gt9fz
 W2DGveuYqKjwKOGyAPDGJPPzwiXgKC0iHnqfuXLjAU7WjoSAeueQ8xsiuBRt6Xxn
 N0SQHla1yGTv4GG2eUYXIgrIgzf5Ih9aoaQ8o4JWkgCO4bN/d+/PE9I6aVOVh3N8
 PAQe0jyINu2kranHp/UD56lwc5CBT02vg/jGvBEbI6316UueVDHnkeAyvY57lOyr
 c06V0B2MINH9AeNVk7I4AXFubaDgPC9GqtzVhzRm1QWS5oo+2Kl/1zWWoMrqRa+a
 Zy5h+G2+Ojacpj5991a4SLKP3GTGfmcXOgtVnxZOpnI+FA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe3y9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:36:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c53e316734so779092785a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022180; x=1744626980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPRfGLu2RQuySUHjBJ101JEDuWjZ3z8AGWYhOJAe1tE=;
 b=CL/pPnbKQT9+FhnoXGlGV0b/4HOeYqLG+ujC+/eEB0fHCxLbPFeZbcxPpBCfeuIVIJ
 eQZzrY9u03VvA3q5xmd7l1K10Y+X9MIVWRbT6UxKozj/jabguBQV6+WK4gL77AweFKyv
 Kp8zxzSVpEvzEMHf9pPrkbZzMha4BQ+tuqA7B7ZNM+S8il/K2NPGvFb3+cKjJ9epWyna
 Q+35506ggDI4V6L+O77dCyqsBzTIw6dA/A0DwfGi1gqXYCIk5CEgREhpRMRho7dakODD
 HCTOVK72qMd1YhOUxUENWlUw+GGSC6DQWoG4WPFU2OhXR/qt8mekeUcv6JciDlG2E/M5
 zlpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqXuL/5i/nhUVglOp84SMy+tkC71kfK2CL7ONOO5FDIncZmwd5xyL+w34euV16ZKeCOmQjliY=@lists.denx.de
X-Gm-Message-State: AOJu0YyJZvZdDzkK/ecIrkhjvc5ffEJARqHwYCkj1zsnjdQaSOgVr1Vj
 YJMWCNZaek0EXs1NW2ObIFqleHI2mXboB0asLJzEnmK2JlVejTB2vODA7XXM5F0gOs8SEfb1XK9
 Yll1vW5WK94hdPwJex+j8F/XuTKAbFdRBEb7R6lGVr2QC4SUZg1kj
X-Gm-Gg: ASbGncsHZrQfnswDK36XaYiJFWkBleSXKS8e+Ak4N9IUNc2WUS306seec7GARqGdTqt
 adz8DkcgkhwKJwLTdik15AMjM50BXZaE7RhEODa+/jaxn/svdwDdFLhTcNEr1/sqmxMnwK+Ukan
 pXCGu+zPU+TcJAKqzznIa/4znjTS8desMnh54ZxkghYZ9vCdimIPJm7eaUw4YXjzUJO7dOPrgO5
 kjNU9uIR2lFogQOf9iaPz8Br6dodw47/c9YvZWjA1OozeHlBAUZ89I1nOPkEg0sqQnF+UXvHXwp
 3fQumC65iIZlDsqblQVI46iW1xdX9xMBm+7U4nHNxt7Fm1f1GDU=
X-Received: by 2002:a05:620a:3908:b0:7c5:3c62:804c with SMTP id
 af79cd13be357-7c775a0fefcmr1763237185a.21.1744022179812; 
 Mon, 07 Apr 2025 03:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6hpD3VxqUPVmPXfNz/VwUdm48EQiXFFL/b6yLgKCxzWfPJZWectw+dn1j+QjCALmUq5JXnw==
X-Received: by 2002:a05:620a:3908:b0:7c5:3c62:804c with SMTP id
 af79cd13be357-7c775a0fefcmr1763234785a.21.1744022179529; 
 Mon, 07 Apr 2025 03:36:19 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096889sm11525080f8f.2.2025.04.07.03.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:36:19 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 12:36:18 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, caleb.connolly@linaro.org, 
 sumit.garg@kernel.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
Message-ID: <Z/OqoqnPb1gfk5iG@trex>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
 <157becc8-34c2-48eb-a65e-55d312e9aa05@linaro.org>
 <6118b3c5-4bf4-4692-8353-bd9a02d5b2df@linaro.org>
 <Z/OdDPn3R7Rojbps@trex>
 <629e3b50-1574-4d24-b638-da898873d1a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629e3b50-1574-4d24-b638-da898873d1a6@linaro.org>
X-Proofpoint-GUID: QtlvhEnqotUuHzHlsQNiR9HOm71yEFgH
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f3aaa5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=ea_ok7-8tL1xAx1NDTMA:9
 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QtlvhEnqotUuHzHlsQNiR9HOm71yEFgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070075
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

On 07/04/25 11:53:06, Neil Armstrong wrote:
> On 07/04/2025 11:38, Jorge Ramirez wrote:
> > On 07/04/25 11:10:45, Neil Armstrong wrote:
> > > On 07/04/2025 11:02, neil.armstrong@linaro.org wrote:
> > > > On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> > > > > Some boards do not require all clocks to be available (i.e:
> > > > > dragonboard820c).
> > > > 
> > > > Can you specify which clock isn't available ? Because we have clk-stub for that
> > 
> > right, either GCC_SDCC2_AHB_CLK or RPM_SMD_XO_CLK_SRC (we have
> > GCC_SDCC2_APPS_CLK which is the one I needed to initialize and work with
> > MMC).
> > 
> > > 
> > > Enable:
> > > CONFIG_CLK_STUB=y

ok, taking this into the db820 defconfig

> > > 
> > > and change this:
> > > diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> > > index 343fa5cd3fe..c14f5b6e1a6 100644
> > > --- a/drivers/clk/clk-stub.c
> > > +++ b/drivers/clk/clk-stub.c
> > > @@ -14,7 +14,7 @@
> > >   static const struct udevice_id nop_parent_ids[] = {
> > >          { .compatible = "qcom,rpm-proc" },
> > >          { .compatible = "qcom,glink-rpm" },
> > > -       { .compatible = "qcom,rpm-sm6115" },
> > > +       { .compatible = "qcom,glink-smd-rpm" },
> > >          { }
> > >   };


so do we need this change to be persistent? are you commiting it?

> > > 
> > > And clk_get_bulk() should work!
> > 
> > ah cool. yes  that did work but something else popped up
> > is it worth looking further into this?
> 
> Yeah look at clk_init_sdc(), it sets SDCC2_AHB & SDCC2_APPS, so you can change next patch to:

perfect. all good now.


> 
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index c77d69128b0..832cda332dc 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> 
>         switch (clk->id) {
> -       case GCC_SDCC1_APPS_CLK: /* SDC1 */
> +       case GCC_SDCC2_AHB_CLK: /* SDC2 */
>                 return clk_init_sdc(priv, rate);
>                 break;
>         case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
> 
> 
> Neil
> 
