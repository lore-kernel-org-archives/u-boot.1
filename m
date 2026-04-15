Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2129F41997
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039468419C;
	Wed, 15 Apr 2026 14:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPNhLHoB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jVBPsAh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4C384119; Wed, 15 Apr 2026 12:11:06 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0792483936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 12:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F7tSq1764284
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mnc5rQpSppA6TP7+KJQqPqFo
 KvdcwdQUAL4YGJHCIEs=; b=EPNhLHoB4xabb29w5EDBND1LjgRJnKyMcZl/HO/4
 0OM5fpzr1snQQX2a1WRCq5NqINke3ifgfFMohpsk/PhyBqZn9vc4jQe82sc/qaS3
 g9KsGM3XNt6glqXlqFHpv5syDq2ONWgeo9yPLYJV26AQk9ARX9zOx2GVzWVlMWds
 OsDoYPaHvj2rCUEdq0q6mUQXVdKh0NPwBgfWLftB175mxqWrYAPZ/i+HlNW+2Z+0
 ukk1Z7W5s8socILMnblaZx2wT9UyA3FGmJk4swIrj/PBfeJPvuUPqLoBHMydFjry
 qx5RXPpS9J/QskLAT9L8wHz4C+cvm0qUjdeH8aUiONNjPQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj6q7rhu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:10:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso6504845a91.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776247856; x=1776852656; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mnc5rQpSppA6TP7+KJQqPqFoKvdcwdQUAL4YGJHCIEs=;
 b=jVBPsAh+038HjGV5h4SXxiNTBOp63GFTeL7zNCRK3Plvhc7NJwAksDl/oP2Y20qfYo
 k/smrhbORI0aovOsRSZWAtFS/O8WgM6L0E+8Ihyv8gZjfwYn3a1gHqzPHnOWYvjN71Am
 agg7fntUcdKvMF3cz34pXmKy1BGsxzYf5E8/NXQT14XVB8eHbvJ09WejIhXvu86RIo5a
 H4SZhIhkC9VKvMmC9PQKuIa05fAWTuVYpMDLCovUZIYHWWR85T5kIchxebczYYIZrGL6
 mbq+pXg6xiWFhsyMN7Htv3f/MCh8IcHRtuTje/MHATMXZpEEeyKuYRAo9nVaHcIGUDUc
 hUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776247856; x=1776852656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnc5rQpSppA6TP7+KJQqPqFoKvdcwdQUAL4YGJHCIEs=;
 b=kkBd8QxE5f6qJoiKrhBE3YCYD9TqZG55DUap906ITN/+entnK5V5o0jA8alQQWSaOB
 AASmuFD9/WHKTtCz/R+Fo6xnzlUyb/s6h/WMYFc4dYP1HlyvS8i0RpyyK0MSQH7E7uW0
 2UwhK58CROqcUlivuHGZZvfDarexpTkRDJfs3iMW3TcEPkP5IVCkpSNnZvt2C/VopJM3
 QB3QjuiKjIUHk4ADufAYeGXrtUTcSGGyWDqUdRPmpQ5JzkP7on8QxzoTcEaj8mbe1ZT+
 E9526x6lhWxxwWc3sUQJWA+FL3Wy/PeLKpP7kIYT0jwRCWJ3z5XMbMvKpGjx9UddJEpL
 AoDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h3cJlwZMJMtsyBq22KvgKP5gRdhGJhvCm9bEuhVMzvbTwPpcnqLqMystObaayWEiqA6PxvxY=@lists.denx.de
X-Gm-Message-State: AOJu0YwdMgT/LGj3Zyix6WXDj4+f6KVHCQyStSLJCHWepb8MmuZZTziD
 rKXNShp1VUFQeXOQaP00pr2iqeelFqmR5L0TM4f5HblONQvQBRTlkGSVlZsyuU/yWlGRvFVCA4U
 G/WaU6VBIf/V0okukdtiXB0LKlkBzyyd9yV1Z54TyxB3ds+V3M5g6WGJD
X-Gm-Gg: AeBDiev1eP9CyVh/dhv23MM5gp7xLoxBiWqsbU+ujvvryG8kgy7ntNNx6pxHxJUcJrA
 v/he+6qj/9+HpMaCclEUXg64vabzcOxXP2z4+HP/uQz9pDlUntVnYqjSzLvnyOaBu15MAA+1bfb
 KjOEqt7TaafsCp0LiVzYjGB3fgjgz/WpUp6p8YMo4kRrWv83JZacSl9wAL4vUYWH+8GJHjTeZGg
 vU3pFSPFuP5N/H+AMPr85MXAhogNWr/HlU1/FLfwdLaJCjgqOu8CFOnYDdnLHBn2NSlvOBtj7KR
 vsr/xyQBDXkvlrKZeGpjbo6og7NFLHB4tDGo8t+j8JG5K6APvjIAjefoTonOWsIllvIKlrzGuxu
 TKvtw9S/jCVIOW57cJew+76BXUU4fpNvSE82w0eP5oQSRH3qZt64MU4bT2sZ/F0Ax0lsT5XlKXK
 EGDUSn9N3tdnCoTpDzDY/2gOZ2phNM07TURVMLVRGhufbUD7iPPtA=
X-Received: by 2002:a17:90b:4c0d:b0:35d:93ff:2854 with SMTP id
 98e67ed59e1d1-35e4276140fmr22859742a91.8.1776247856303; 
 Wed, 15 Apr 2026 03:10:56 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0d:b0:35d:93ff:2854 with SMTP id
 98e67ed59e1d1-35e4276140fmr22859708a91.8.1776247855796; 
 Wed, 15 Apr 2026 03:10:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd21040b1sm1733023a91.16.2026.04.15.03.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 03:10:55 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:40:40 +0530
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
Subject: Re: [PATCH v2 9/9] configs: add qcom_ipq5210_mmc_defconfig
Message-ID: <ad9kIAaiXaIqDm6a@hu-varada-blr.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-10-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTgkdQxRmzfXOW3+RcNO0+aSeYFEq_iA3spWd8nnf2egaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgkdQxRmzfXOW3+RcNO0+aSeYFEq_iA3spWd8nnf2egaA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69df6430 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xDDBMRYjjB0QwaCvmfYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 7GxERLOeXOL76UyPh4Huck8BBTyiQrPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5MyBTYWx0ZWRfX79F1qdj6JLUj
 rY6pZHgFMVBEoWvmg0n3C5rOvbPpOk0Azg0zivMm8wbERfdM4zLlou8kILiDaDXr8yvbX410ig9
 vrCSXlIFDq1zBhvW10cdHzILF749hLluVbbf5lKskKTc6beaJCL1Urv3q51P6ZjZxELyngBLI2e
 O/sGb8kq0jBr2tehv83tqFDwafWrEGfkHC+VaHxU83TGACNQ4anTfNYTaCe5a/mMCOiFAMzXmIo
 lcIoj138ym42l5H1iljcCaB/GBuETc40GbdE9Zky+uZLx37GtmQ0bXxurfJC6TqHltwdCyPID2P
 n9KCicOd9bhuQLzSIshP6hyh9uz4P+s0iBfUHPWPVst4AeIDJ0afxSubhyBuI5tqGQFxEU2C9gs
 1C/egkV7h1qh2ZrahMzFBNX8pRYaNFPeNZNJ1/X1zCwg14cGDWIYLcKVtY947rNC64s+uoHioE3
 9TJ+f0wao3UcHs6Dy/A==
X-Proofpoint-ORIG-GUID: 7GxERLOeXOL76UyPh4Huck8BBTyiQrPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150093
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

On Sat, Apr 11, 2026 at 07:15:46AM -0600, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-04-10T09:11:45, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > configs: add qcom_ipq5210_mmc_defconfig
> >
> > Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
> > Presently supports eMMC.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > configs/qcom_ipq5210_mmc_defconfig | 106 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 106 insertions(+)
>
> > diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
> > @@ -0,0 +1,106 @@
> > +CONFIG_DEBUG_UART_MSM_GENI=y
> > +CONFIG_DEBUG_UART_ANNOUNCE=y
>
> The other IPQ defconfigs (ipq5424, ipq9574) have CONFIG_DEBUG_UART=y
> along with CONFIG_DEBUG_UART_BASE and CONFIG_DEBUG_UART_CLOCK. Without
> these, preloader_console_init() in your SPL likely won't produce early
> debug output. Please can you add these.

The relevant QUP clock is enabled for ipq5424 & ipq9574 by the boot
loaders that ran before U-Boot proper.

In ipq5210, since we have SPL, the relevant qup clock is not enabled
for CONFIG_DEBUG_UART to work. In SPL after the clocks get setup the
serial console works.

> > diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
> > @@ -0,0 +1,106 @@
> > +CONFIG_SPL_TEXT_BASE=0x08c24000
> > +CONFIG_SPL_MAX_SIZE=0x3D000
> > +...
> > +CONFIG_SPL_STACK=0x08c60000
>
> Just to check, the SPL code region ends at 0x08c61000 (SPL_TEXT_BASE +
> SPL_MAX_SIZE) but the stack is at 0x08c60000 which is inside that
> region. If the SPL binary approaches the maximum size the stack will
> collide with code. Is this intentional?

Will change CONFIG_SPL_STACK as appropriate.

Thanks
Varada
