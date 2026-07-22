Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D42C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 11:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D30040819;
	Wed, 22 Jul 2026 11:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiFsB2Geq3wi; Wed, 22 Jul 2026 11:43:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76A9440756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784720603;
	bh=I0vZRfp1oWMDv/VUW4voo8GOhdzpnPa18DRkZatzQtY=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tG8q9hXGfWs/OOEUzkQ42rN+wQ+Ma0YXqFR0vfM6fg7+LYcsZPkCHRD6YggrTBfws
	 5OgtIBfzJ35mi3d9KHSAAZgS/4t0lwkFfBYKAyAcj7NEtuLkon/6CDen+Slttca2IJ
	 g3vBzjL4qvbSdVAaDU3CNTqzBmuzQ+ujGSTy5dVjI0MoqqqqzIeqGa+xhcIqD7AGL/
	 cXsdlxn/FQIU+cED7QdKegtcwPW1r1hbhD+xT9SNIVBYVe3uhuqBdSiCbPWKib3zQz
	 4ELW2mUe3+9I2p6SQ0QIQ9TaAp0E//BtyJUWfl9fyAAcp/SFCisN3mNcZvBmq6Udn2
	 +aHASCjW7lKfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76A9440756;
	Wed, 22 Jul 2026 11:43:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E9E1109C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A97E40756
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4AWPlV_8xVpX for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 11:43:21 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F3BDB40743
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3BDB40743
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3BDB40743
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:43:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8256848BA; Wed, 22 Jul 2026 13:43:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B57803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:43:16 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xG4w401471
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:43:14 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt798u7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:43:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc8bde6318so220167725ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 04:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720593; x=1785325393;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I0vZRfp1oWMDv/VUW4voo8GOhdzpnPa18DRkZatzQtY=;
 b=Cq+TmeXv5TbzMTnN5TN59iajNxtX4jRxUAzGPWnGPlJunH/Q+5143/uqh+kK0g7B9A
 g7f741cUJNJjc+rCY0X0Z4qiYUp2xp3uBwba8mMMR/pLO0vXnUV09cLhhN/0Zs+MFwzD
 BkhvTapkyk9y3q3dmBBpJ/KtHJh81ldARSv0R0eaVmThe6Bwm45SBrAJP7wwccMPISO/
 Mdx5z5FdYRCiiHt7oZdxfwuL7WYkXl6lbI2tMdy3WVBZILYF3fjqXp5n+fpShJjVg5Rt
 dkuwodeDxXB1TU1E4mZMoIS60zLOttD4W2GDsuVExH/8DyVQjzt5AM4UMerGh9pHqiWT
 KLpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZOtgwpOzUkrySGTXYdYy09KSR1lGriSCjcrpUvBZzuK4PN4Won2mPWhvIY6Xr/mhjKa2nyUA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8SJst3j4XYt2Y8QNZTeK70w3NesMRAfSxKTl2S16btoml6vrF
 Dv1VQQqutJRDeTlTCgbtoDK8p3DqdHUMAxB8ivDq5RJ3xephue9AKXpveDnKxTfNSc3ubEgnlgq
 cyZTxaWcVW7p9PqvO4NkXeMiCd4C9j2MZTmE96qL0qSx4C00CmBDySTy+
X-Gm-Gg: AR+sD11eTyCAgQp6DSHZ59k7vy0KSIMPpBtxkvuafyLb5cBwU89jELHz29TH/zjVYSk
 7UzX/1VvDufJXug6H037zmxpX10N9hq9lwme65jWWsSSWf3gsw3/S1mH6y8DIUjJIDkdegB3CKS
 YmUZ7MhsNv6+ezmyTGzI1C+hyb19yN0xeBx8ksOejZb28QFU61ag5Jea5/TSHZGT7hVXRA4HjCD
 87Pg+lMZN7TIPpFUweSrMqNAcuj0ipzUSItiVs+CM44sq9f3c07oimcn2Dns54uNQdSqBDeLnwl
 2j3ox02BilVekxEk0PCDxj06ODajtZW3iOZI71quelEMlIbRnm9Lt5Gwm5bCE4Jvchs1CPqYCrD
 sUDcTbJ5mFlHgkDSBaIhxgenJT1WzBuliROvmur01aOTCOiYG7k/COzFXOO2H8Fjh8smei7NkXx
 BfniRNKb/TdqEa1lyCnNLx+x7z6HCwAw==
X-Received: by 2002:a17:902:e88c:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2cf348c2e97mr238625435ad.13.1784720592842; 
 Wed, 22 Jul 2026 04:43:12 -0700 (PDT)
X-Received: by 2002:a17:902:e88c:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2cf348c2e97mr238624965ad.13.1784720592417; 
 Wed, 22 Jul 2026 04:43:12 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6162csm8935430eec.7.2026.07.22.04.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:43:12 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:13:04 +0530
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, michal.simek@amd.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 3/4] arm: dts: ipq9650: Add override dtsi
Message-ID: <amCsyMWorP4Qyr+I@hu-varada-blr.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
 <20260722104624.3842833-4-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104624.3842833-4-badhrinath.s@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a60acd2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=YfCOm-DyAAAA:8 a=EUspDBNiAAAA:8 a=EOQRiUhS9ktaf4ABqqMA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: VyqKR8wKj9vlMWuoQqYDgWC8lt-W0HFH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExNCBTYWx0ZWRfX/RVVB5v432uu
 t49lgvjNMZXDJHULLR68VJB0wZHnndT5Hy59NzXY/pMOT5AM+tKFo1aRHjIv/p/IlT8Gs/nr1m6
 oM76seD25z3JyM5KX0p4wga/plLgnqwZx8+ibuU9xalaE0E9Y8wHaG+7b6Go2L8J7uvNT5O0TEo
 GQGgJe4OePjUSyuid2UwElXmgUj3abUPYkYK8w+fPWQyms7pnDyjPLfGoz/y40dmZcJd2W13JBS
 jpdz8vTbdHC1GAmsWxxf6vF+e13rlNgx1IX3i+f3mA7UZ+D5wiTr5/Sqw8CCratsPUEB1XY7c60
 1dXP7mQqJbXizOR54Y2bxmtR822pZTRTnAbMXMRSvhL0IbH0ii2DxRRVNmvSS2kRmX+ZuwofnQE
 fJvKqY6VFJolKgrdzw8GPEKwL5ya4/qwVLmZuwIp8TbaSI6JPDA+1tSAoY4LXIop67cVOjo4jJS
 zEaS7Gv7gsusasN337Q==
X-Proofpoint-GUID: VyqKR8wKj9vlMWuoQqYDgWC8lt-W0HFH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExNCBTYWx0ZWRfXyrN+ccukH78R
 QcoZGHCd8FwBOIo8CbpzXiLI06mvGrNzFIbhZwW1bMtHcPmwTjT4+tWtpAincilQr4D7y+mAojK
 nO4aEC7jnQ6S2QIfFwn21xdhiRqPUDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220114
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=I0vZRfp1oWMDv/VUW4voo8GO
 hdzpnPa18DRkZatzQtY=; b=lr7FLEI6ZSACJneoJpjAxQvZddnGqMXeflOoaa3Z
 Zrq4Ih2h4hGx+4PLaYNoF3k6ey4mSy52wpdfdn9VQdlFw867/ZEfVmvd+cyODMe8
 5HTxcVESbo0p5BjpCodgJDVDlLGLhrnAD3/agO5A6GHUhLdEDaY5DujBoc3kPtw2
 voZncD+QAg+MkGYM/4DOGCs3sTfBkWzoUUD1frDxOANxu0ObQfN2bmwin2TyUFfX
 81j/nx/HvabMAGkclA0Ph1TNiG+GBIha163DeL2Fp8jFU1k86W5H94Bd+XYdY4+m
 aHuho4MnjoE6gNE9Q4Is1cJ7iKLmr31RbWJ3mrwvITyFJg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784720593; x=1785325393; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I0vZRfp1oWMDv/VUW4voo8GOhdzpnPa18DRkZatzQtY=;
 b=ECMDd/T6qKB45Gdc/EY73gF01VXbS0NEd9xopHsrkyC6f2q9m6A3FrSL59/Tqu45BN
 I0W27Ry1nUF3RB9d58wA8x7iN83mBy5S8Hnb7LurCMtUuUfK66p69AxvbL+6B4s8avus
 cltQH/A/0V9plcqnuzLLuFBWuEWkepP5mTOFxt/Jfs16p4p0OXigIgfSZthNutYFYZFd
 ZNezZO9OrEHTxg8FoJa9nwpYrioKSYl6Schszt9ciVFWXatT3culLIngZuU+YaeJsUZ3
 diyPtI22DiK1Tw3dixHKIrXEjKrbu4gSCpLm/4OtouAZHvR7uvGkKIJRJLMEJEHNwMpV
 hLfw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lr7FLEI6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ECMDd/T6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lr7FLEI6";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="ECMDd/T6"; 
 dkim-atps=neutral
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 22, 2026 at 04:16:23PM +0530, Badhrinath S via U-Boot wrote:
> Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
> This includes memory configuration and SDHCI reset configuration.
>
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> ---
>  arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>
> diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
> new file mode 100644
> index 000000000000..dd03de98b921
> --- /dev/null
> +++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IPQ9650 RDP488 board device tree source
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/ {
> +	/* Will be removed when SMEM parsing is updated */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x20000000>;
> +	};
> +
> +};
> --
> 2.34.1
>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

But not sure if Casey would prefer you to rebase on to the custodian tree [1] and
remove this file itself.

1 - https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
