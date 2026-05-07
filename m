Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0297CD343B
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 07:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6F4848BC;
	Thu,  7 May 2026 09:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X8TvOQbe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sgi4DM8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAFB8490D; Thu,  7 May 2026 06:56:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A03848FD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 06:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646Noeb9442617
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 04:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KaRXyz+QnazDFI5mt4uKMQQi
 Vin0G+ItjU/LFhnviaI=; b=X8TvOQbepx1YnN4dKhH3ifXxZ5v7Rh8Eb+/JlTTe
 /drNOps7bXToXvw8yyVtP3Rm7EOp9VWvfPhGZeF8R7SiFr98x9igIXRAapQ8cKC+
 K+fQN/kXIXZtyIMP1j8QBbyl08o14xciQH3tcMcrFFEo+rJQMTlqm0AJZ4RcaZYZ
 7sOEpjI+phunCLPWaOjEQkp9Lic6raLGUXio2la5HwQ9mSiTU9/6L4r76SCNwcd9
 eBguKn2epNmV3V+SK6Roj1e5XBzhOMLVhkvRZqF/wG8g7HvPL5KMspqTwTVivS3D
 W3UO81DRAuMNwyvX3pPg1g4Uss5/hijjJY1H8PY5pnXAUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0299kxpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 04:56:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa5ecd760so219563b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778129784; x=1778734584; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KaRXyz+QnazDFI5mt4uKMQQiVin0G+ItjU/LFhnviaI=;
 b=Sgi4DM8g5911f1YkkkexoPYxBpP5FhJ+e8yTi3sk4NgoDLauV8bN+kkNae8W7z+8xW
 BWOFfK1XX/pjrkPE3mHx82B2vS7B94Vn7VskLHju0vV7MqM5FhC0dQmyWsVkBh0mXit1
 W93hGakRbFn6YcvXL5zbt++NM0KL+N/LvrxxaqUbS4c6EU+PCa8ZqXI6lHHnK7mVasH+
 igb2U+nt5jXVpUNLmhNH/O/4xU9iRJXR/701YTUoGX6xr/+FQRcNKfLReEeUdKfcEmcW
 9xqjUAwTbHytu2K9NF7RIStRrDMpyzFQKQwAxpmhCQ8tKrecocsI6arAIil7aW5/IAsy
 BlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778129784; x=1778734584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaRXyz+QnazDFI5mt4uKMQQiVin0G+ItjU/LFhnviaI=;
 b=qOsT7RcStkJhnu5opqfyDWdFOs4Fmq9wn5FysQorjodi6A4a3joNXVM4M66cPWKLsg
 Ac+XEe0AJra7dltDDS0s7qsoo8tgYr6rc6eStpwpsptrecqxxAmsvVnyQKmxkNwd0H5L
 YLlKzut0A4k+Anbminxb/EsO37j4bp0GacV6sQaH4VPh7zq/dH4QmzEqWR3ozhwy70J7
 Hnft04mRt+QvsyWxoOo/HebWF/QLkOXeCZGcIjgsMdYO0kaNtR6i2wWfLz+6gZ8ohRA9
 0IybwKUnmeUKEJ52+xuorPgZiV/h10wnlBrENyH3egDkZxzsFtZ1Piv/3hqB0E3ebdMx
 rNqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/z1pQy1h2K5ZafR0XoL5ahQyB8ZNjzD2Bb3/HlrKOUfd50aQe6dvOWuA99f0otMK8Ygx+eIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzRbQYzdus4cTKOa48ll+jOoG+WtUcT/ZMtAkmoiC0tlJrytTZh
 qrQt4WMOZSKU9W+7vKb2WVOLZkHRO+P8YPAl3pTl7BKdTKoRc4iCQPnzMm8mUzWCM5c38AINqTu
 n0oDT7CxbYGmxcfFn1Irns2L+eg79+SrIve52ONRF+fmJ1BWziu6IsOuu
X-Gm-Gg: AeBDieuJdHRFgs0p6jxDiJ+vn8s2uVbvkANNhsRUZ7VbEqRwjrT0sJmMf5FVVAZQSTg
 I0+mk4yAIAvLtRbAZmur1qPdJfCql7JvL6sdN63Du2hqFLRK3hv3fu1dy8MFrzwFJ2H8vbsCHZ9
 3gVMJLhXNniCLBE26a7JlfSuwvpYmmQQmubWrLexK2xESzUOnLn+4MYnGqVcd8PG7AHYUXa150M
 kql1Qg23YhienVsHFDsGywC3k+O4aYSj6arrXkRBMZwndLFurshJw6cxisAxu3Z1rrBAmXUOwcL
 7jD0uOWj+HTlBuqlwFKzFHgEMPkCpXtNx2pDTykCfv63LAylGfX4tPcOJhUFzY5XlThD998xiR7
 TTJL52v8IHc2I/gmq6NAoS5xeWrlZ6NxUiWA2bReFGTttvq09ECrHuvfMbMId/RTZU7XJjHciMd
 PDl1AQYoO5xh/IbGBQEJjdZBwZvGu+xLAKx5e50jjgiMMCWZiPlqSkHE/2amB7Gg==
X-Received: by 2002:a05:6a00:3e14:b0:835:6bdf:c87f with SMTP id
 d2e1a72fcca58-83a5b6c48e7mr6086859b3a.9.1778129783962; 
 Wed, 06 May 2026 21:56:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e14:b0:835:6bdf:c87f with SMTP id
 d2e1a72fcca58-83a5b6c48e7mr6086797b3a.9.1778129783409; 
 Wed, 06 May 2026 21:56:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7073408b3a.13.2026.05.06.21.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:56:22 -0700 (PDT)
Date: Thu, 7 May 2026 10:26:09 +0530
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
Subject: Re: [PATCH v3 06/10] mach-snapdragon: Add initial support for
 IPQ5210 SPL
Message-ID: <afwbaa+Ys253fErW@hu-varada-blr.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-7-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTiwN_YU9SkHATfXCW+AhhDWpsNPudY9wTxC2Q98jjdLow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiwN_YU9SkHATfXCW+AhhDWpsNPudY9wTxC2Q98jjdLow@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=fMMJG5ae c=1 sm=1 tr=0 ts=69fc1b79 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=B8IGObF7S2O4Iy4BeFMA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: kRXLUYoVrGNqaEDIdFj4XdUKBPPYH7SU
X-Proofpoint-GUID: kRXLUYoVrGNqaEDIdFj4XdUKBPPYH7SU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0NSBTYWx0ZWRfX0ICgaTxHIKo8
 IO8XZOICe8zGUX34tbu9vMteHu0t2OZoKya60ElOeMcStZTkARJPKogHTinmnNXd5gE2bDxLR6X
 enQGCwTqMVf2SUXXiqHcTUReQPc77UGrC4mfgcZ344JUu7E1UyVO68Ypyzb/54aAh8C+9F2WLCX
 opgEu+Sov0wL8XiNFbT205GcQcJPnB6A/CU3ladzKu1zfhRUvG2b8t+ZWiVZs04NSmWYsNa2ufC
 Zt2pDc4Q1AEihNAl0Xv15IgZFIbBE9fQmk33l2MxO1P7Z56okbShe1iZEfZSC5cn525PYzLPDbr
 AZW1QZsdvjOKatDjjh0z3nZFQ0ScsS6bj55PuPMHcZWRNxOWwcq3im0+c5o9xYDb9Dy3a715zfZ
 n67oYPOl2QO07vcZ2VmXn7VDMu1Uh8ORZ6KcZ4f2KwYpnOUonE0DPj3bmaaStvN6qUpHmCE61GH
 YhvPR2hls2QmoKO0e7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070045
X-Mailman-Approved-At: Thu, 07 May 2026 09:25:41 +0200
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

On Fri, Apr 17, 2026 at 08:53:54AM +1200, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-04-16T05:39:18, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > mach-snapdragon: Add initial support for IPQ5210 SPL
> >
> > Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
> > console init, identifying the boot media, loading the additional
> > firmware binaries to setup DDR, TFA and eventually jump to U-Boot.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > arch/arm/Kconfig                  |   5 +-
> >  arch/arm/mach-snapdragon/Makefile |   3 +
> >  arch/arm/mach-snapdragon/spl.c    | 640 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 646 insertions(+), 2 deletions(-)
>
> > +static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
> > +                                const char *part_name,
> > +                                struct disk_partition *info)
>
> This function is defined unconditionally but only called within the
> CONFIG_IS_ENABLED(MMC) block - you could use __maybe_unused ?
>
> > +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> > +{
> > +     void *buffer = spl_get_load_buffer(0, sectors * bl_len);
> > +
> > +     if (!buffer) {
> > +             pr_err("Failed to get FIT load buffer\n");
> > +             qcom_spl_error_handler(NULL);
> > +     }
>
> spl_get_load_buffer() always returns a non-null address so this code
> is not needed
>
> > + * @entry_point:Pointer to store the retrieved entry point.
>
> nit: missing space after the colon
>
> > +     if (desc->part_type == PART_TYPE_UNKNOWN) {
> > +             printf("Initializing partition table\n");
> > +             /*
> > +              * Prefer EFI/GPT
> > +              */
> > +             desc->part_type = PART_TYPE_EFI;
> > +     }
>
> Simply setting part_type to PART_TYPE_EFI doesn't actually initialise
> the partition table - it just tells the partition code to assume GPT.
> If the device doesn't have GPT, it will fail - how about calling
> part_init() or letting part_driver_lookup_type() auto-detect?

Since this is on eMMC and GPT is kind of mandatory on eMMC, would prefer
to fail if GPT is not found. And, support for other partition types are
not enabled in the config.

Hope this is ok.

Thanks
Varada
