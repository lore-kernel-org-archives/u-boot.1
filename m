Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C766BC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB1784857;
	Thu,  2 Jul 2026 13:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZHgzEIm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QUK79tX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B068496E; Thu,  2 Jul 2026 13:25:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE91E847C3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662AFaoW3460377
 for <u-boot@lists.denx.de>; Thu, 2 Jul 2026 11:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J7qxKZZq6kYhHq8zk/STtoXx
 GRtrvXzN9huqn5DGI7c=; b=hZHgzEImuCVW30H0hAiOXYyFlNWqd0rbCHPNMeLM
 8LSkz4AaszYXHX4q8vuFW2VyJKtl99d5BChNjmgiE5gSjmvEXXUJIdG8cTISr1oT
 sHgKSBRtj+34HJ5mTmP3ABpJ2QU/PNVNijPDYmmR3h7/71qZuhe6SG9q0YedsNgN
 mVuUAoW9JvDKKDBk5rLjUY9/ZAiRhLBsP0Aokl+BHyAHa9LiJLXK5yjp5cBmQTRG
 kluZjEI/RfLRgFFZ9zCgAI3tyekm3zI64o41McSRIfPdlaFu9NKxD1GnojU2XYCB
 pfQtHXFPyuShgo/QKyS7nUiqtVWMjTKX0NXGdxZewrTUXQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb1k7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 11:25:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ab059052so647319a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782991508; x=1783596308; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J7qxKZZq6kYhHq8zk/STtoXxGRtrvXzN9huqn5DGI7c=;
 b=QUK79tX8jLyHrKXCzlILkWygT88YHSaAUOB51/rQzcfigyx/3GVtBFePyKGpZOIVi0
 isaJkE04YVc5sgXNH9pEull/rmy5VHhzhVyhbSflVuFwns17XSsdndVEHQfghZvwyLWX
 LxFqz/hGRpW/kzkoYQ4f1e/MPsZdocRG5YQkcgk+nVslNjvRD/EWF28TJn5j3/ZzrfrD
 +tHFarizmhDhL/oeMGn/i/8Wtu0O6J2+vLRrmmdBx4MF+JcmuxKn9lHp7HtjtYsl1sEK
 sgjTxwB4LSfA1kqaRSCyA+whb2bgxqAKzzwWz+Y4PxIVMzxi7NQlo2saL7Evooy30N0R
 yy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991508; x=1783596308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7qxKZZq6kYhHq8zk/STtoXxGRtrvXzN9huqn5DGI7c=;
 b=sRWXpagoW2387NrQvVlQU11lTQFl/ZjO+Y0FRZIqVH8aKuOY7rpl/O+b/F9npbiHNe
 setw4QICHPipV1aLpCRSN4o0g+RUeXVZCcdEUWdtyPlWboOOY7ur3LB/tK2onRk6iuH0
 unxqeX5EWBKZZqiaSPgB7O00ubsfWz+ano3Ac1ju/utL1uMINlnYORJ72R+uYR/rDXYK
 L39sjVq7KT9IxAPrUiYLG3DPK5t63JiP1EnHQYiCNH2BmjNstZPoGb8JGGRJUGXfGGuM
 BaQO7rXt/h2gwFbGFErvnTJBAQmm7BAO9NS/RGAM2aKzkhI2feaoXi0nE01WNEsRv+j0
 QaTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LY5sFCN6Ny7xZXM0zI98LOjUOcuGHzPSICesH/QZovZ6vrEz2sfCfvyspARlLZRYIlOjVk50=@lists.denx.de
X-Gm-Message-State: AOJu0YxdMg0TSyuhv5900MrZeooL3QbShl0QBWUM+Aj7DgdkIQjNIfpP
 bLm9XitV1PMi8mUHKHMbdvlntVeGPVhBqD4p81LyxyfrI3rzEhfA2f1r3TGwT6v4vS2+d4kMG6W
 zdGkElfw5MpYmnCnDPz9Xup2A/ZAwKUMZllOnn7W3FLrlukPHZbBtzuL5
X-Gm-Gg: AfdE7cntZKGOgyhM6YI+E+FWDyGPpAscG7P35da3702+UQAFAT3ycRcphirfhXX0tiv
 fWn7JZG5vljSVPfEMlMNFrhbpxqj6ROo0qzEI3L+NPjR4lZuPz1JRTLGBiGS4hkGwprPXZuAYFg
 0WXmvulHyoj2HkBCzEQue4OTRWYu2BKTqUbmEtKbxkDNnfB1P5RoDAeokBvCRcMCOxWPh/cq8Rn
 S1EbcsF1lYvoIw2cSNf14CFuzH5mRtpWiOETxhHykNYTp0pl7re3mTNCdgzTVKdE1ZlJBQPfaBn
 8qOpAK4sQ+3L32kNIwzSx8vz8lncQWVDTZ4bnn0jf3jyKXiHZeOzoDV334ioRUmYTYGgf2aRbvA
 iK1fuS5JA6115nacn9riqVPGrdjUCr3Gm7ptIS/Gw/8iEiqesI8qS1xq8rtF793aDDR3M9zWEBQ
 IG0fUc/RcU1fOSZyq32fQv3Z7nTNKmWXTeGV4Kq/K6
X-Received: by 2002:a05:6a21:113:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3bfd268760amr8273621637.11.1782991507764; 
 Thu, 02 Jul 2026 04:25:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:113:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3bfd268760amr8273586637.11.1782991507046; 
 Thu, 02 Jul 2026 04:25:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb7fe46sm10393791eec.14.2026.07.02.04.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:25:06 -0700 (PDT)
Date: Thu, 2 Jul 2026 16:55:00 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] dts: qcom: remove hardcoded memory maps
Message-ID: <akZKjDN17s64HA8F@hu-varada-blr.qualcomm.com>
References: <20260701101937.234609-5-casey.connolly@linaro.org>
 <akZJg7fQmXsvFqg3@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZJg7fQmXsvFqg3@hu-varada-blr.qualcomm.com>
X-Proofpoint-GUID: 3f1NXL-UZGxWQipJJrsJY-_eGSwc1vJq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExOSBTYWx0ZWRfX3MZe+JLNxuMT
 F5nj0buKjjzsyIUHy+LH+TioGy1kTbbHLcKfypf2rU/5u5V2q60I7Gk+NbneRsegSstp0h0+jid
 jD+/lOARq3RfvqDCcKlHpvEBRewCySg=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a464a95 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=YfCOm-DyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=Oq91C9130IgHgN6eMCwA:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExOSBTYWx0ZWRfX8K1gCarc/5pI
 iRxLYocpiX7b/8xqP/15NoDqUpx0/bcNBewVgE0cD/026jphkrwdSTVR3JPxiXVmURO8clVaf6u
 VR1WvgjAKo+m7qWnRVErJhlnYD+8P9tiQ3dwu1Rkl4qseXn/8rBv9e1rJHFSN63hRXz5QG+NDYE
 LfabdYjjG3hdylQPHkAPvwiyZFazO9q/Ojb7lyggHsAIirbQFhbvbT54eoRrLgH+aba7m9HIP6I
 qPTh5Y7IYzpULHNb6c/b4Tvmxf4g7wE1OCw5fYQ5LN6VNh1tq9Jn6ObhnMaDK2NbSM9yOUK75/Q
 8FIB4LGio032HxyMoPZaww3CHVvZUXeIJMITkjsxo8rdpq5dMblybJvFqFXH/CEqbxKn3cVYv2R
 mrgef/WeJATgV2h2Bj6FPW+ae4XA/tne1DGsECsfRH3/le0HyQ3uStq/QjYMkIjbF19NpH4R+Kp
 y4mrZWOnhZ/MlJNxIdg==
X-Proofpoint-ORIG-GUID: 3f1NXL-UZGxWQipJJrsJY-_eGSwc1vJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020119
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

On Thu, Jul 02, 2026 at 04:50:46PM +0530, Varadarajan Narayanan wrote:
> On Wed, Jul 01, 2026 at 12:19:33PM +0200, Casey Connolly wrote:
> > Qualcomm boards have traditionally relied on a prior bootloader stage
> > to populate the memory map in devicetree, and when that wasn't available
> > the memory map would instead be hardcoded.
> >
> > With proper support for SMEM in U-Boot the memory map can now
> > dynamically be read out of the SMEM database which is populated on boot
> > by the preloader (sbl1).
> >
> > Switch over all the boards that previously relied on hardcoded memory
> > maps to use SMEM instead. This has been tested on the Rubik Pi 3 and
> > db410c however other platforms still need testing (see below).
> >
> > This affects the following boards:
> >
> > * IPQ5424 RDP466
> > * IPQ9574 RDP433
> > * QCS615 Ride
> > * QCS6490 RB3 Gen 2
> > * QCS8300 Ride
> > * QCS9100 Ride
> >
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> > This patch is based on the qcom-next branch found on the Qualcomm U-Boot
> > Custodian repository [1]. For testing please check out that branch,
> > apply this patch and then build/boot U-Boot. Ensure that you have
> > CONFIG_LOGLEVEL set to >=6 and look for the "Memory map loaded from"
> > message during boot, it should say SMEM.
> >
> > If nothing is broken in U-Boot and Linux then please send your Tested-by
> > indicating which board(s) you tried as a "#" comment after your email.
> >
> > [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
> >
> > Cc: u-boot-qcom@groups.io
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Sumit Garg <sumit.garg@kernel.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> This fails to boot on both IPQ5424 RDP466 and IPQ9574 RDP433.
>
> IPQ SoCs have the following node in their DTs under reserved-memory.
>
> 	$ grep bootloader@ dts/upstream/src/arm64/qcom/*
> 	dts/upstream/src/arm64/qcom/ipq5018.dtsi:	bootloader@4a800000 {
> 	dts/upstream/src/arm64/qcom/ipq5332.dtsi:	bootloader@4a100000 {
> 	dts/upstream/src/arm64/qcom/ipq5424.dtsi:	bootloader@8a200000 {
> 	dts/upstream/src/arm64/qcom/ipq6018.dtsi:	bootloader@4a100000 {
> 	dts/upstream/src/arm64/qcom/ipq8074.dtsi:	bootloader@4a600000 {
> 	dts/upstream/src/arm64/qcom/ipq9574.dtsi:	bootloader@4a100000 {
>
> While booting, initr_caches -> enable_caches -> configure_reserved_memory
> unmaps the above 'bootloader' reserved-memory region. Eventually, when
> U-Boot looks for environment variables via env_get_f(), the 'env' pointer
> points inside the 'bootloader' region. Since it has been unmapped, it
> crashes.

Forgot to mention that it boots with the following change:

> diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
> index f64ec0c674e..d554537fbec 100644
> --- a/arch/arm/mach-snapdragon/mem_map.c
> +++ b/arch/arm/mach-snapdragon/mem_map.c
> @@ -112,6 +112,10 @@ static void configure_reserved_memory(void)
>         fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
>                 const fdt32_t *ptr;
>                 attrs = PTE_TYPE_FAULT;
> +
> +               if (!memcmp("bootloader@", fdt_get_name(gd->fdt_blob, rmem, NULL), 11))
> +                       continue;
> +
>                 /* If the no-map property isn't set then the region is valid */
>                 if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
>                         attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);

Thanks
Varada
