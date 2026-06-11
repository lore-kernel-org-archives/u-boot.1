Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE4DCD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 10:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56351839A8;
	Thu, 11 Jun 2026 12:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClGzRC/L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVQSTzue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16500839A8; Thu, 11 Jun 2026 12:41:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAE6838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1ob6271452
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hpdLVasmBAtrEYSteaUBjtkF
 vAyLlNiPI0qM0Lzt7YU=; b=ClGzRC/LawsanRQw160fuVwXkDDrcdBYFBGg8d7P
 L5NI2UJifSRQKDP7FUCfXpPUWron+qXjuIzPEmNCgi8wZhlQv2mSOMi80mBZ6WWr
 Fn/vZRy+uLwzfMQDCu/tCBKlNdDdfd7+KQNad+rsNLRVzLNfCwumUOQGokP+1m0W
 CBUJ+Zs3VeN19l5W3gI2F2OTCfczWPGZ3syptSyI9s4da07BjxfODa+XdJ62ivSh
 ttQkKRgNfxaojW/cEP6GOEkZnNtzPjEt2o2T9walG8QF+ZqJONCiYiEkxQy1abNy
 2x8wwbXMY29Jxtf2nl8yb7WNZ+j3bUkexWqAt3DxTNWILQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71k314-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:41:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36ba98cc003so5520880a91.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781174513; x=1781779313; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hpdLVasmBAtrEYSteaUBjtkFvAyLlNiPI0qM0Lzt7YU=;
 b=fVQSTzueyws5lF6WLWaaKVGv41hPbWiXfTgrq8MXpyC+kG6dc+OVeVnr3XMFKjWCqI
 MP7eZPnNQiySubz+TssiCvhCEby5fbvSKz9DZ9X6ySMsID3ZQSoNRzxtJBWM8jAS/wmr
 PcyZ6W6FaPXPJR435Kb/oQ1rwjo2E//Vhu80X0NQzSvFlhybfnAIn86dc8HrJqMQzTAq
 r3Loy4pXtekXE/JGTE8/dKI09+RsVDN7mqRSiVD4SqxaQAOxXG/rEwA6VPNngInrProh
 RkFPBMAaQhhNUjZ4TsmA3A2xOTungfG6RC5u587lBzf5e9Ac+z3S9j1RHyUiagjyMPuT
 Qb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781174513; x=1781779313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpdLVasmBAtrEYSteaUBjtkFvAyLlNiPI0qM0Lzt7YU=;
 b=kA5z7WLoXjtWpnXSvV/DswS47sUlozvssQYNyT9KgtlXZdokadpkovhu3XzNhl1ofe
 GvTBtuECIDHuL2/YFNrV6iP6zBw707gKJ1xnbmlONrNM6AokjW8ER/QLmgYu5PcT4rSJ
 XNbYu8+C8js/w7b3Mp2ZKnZ1SwCU6uhHWQ+ej0gZqkMVUmf1MwVLuqFkkFrficnBdhHq
 HdXuouqTdwElm1xUYPdPxCNZpyFGU1Au4cdZepdJGfyYkF1IWTZEaXRqIx+UuLwjlP3C
 ywphSxG93xZ2E2MtAoEuwSmMVO1cEtBOu1GPIs6/CTY9P98eOkftXVXF1kSgqZYXfQjH
 nviQ==
X-Gm-Message-State: AOJu0Ywhn4bClWDRerZXSSfnEvFEIn10+uiyn6nE3/UbQ7QSGMOdOeAe
 TnbJnKwhMpRr1XOO1PBknHrnasBPLTRzM7qMOs+4I9Vr+dySbx7B6EfARVKwq6BKvMO7IEst9NE
 c4avyVTrnnlw3GVX599Zbsh88SVRtI2Y9b0EYw1+SM1P+IsPXMHgTe5rh
X-Gm-Gg: Acq92OH1D62wTRYpKczcjQMOZQWljjUzpZCTZwXFtSy4YShghSOM5SsUcOLhOBRWbI4
 u3h/KJTfQKkC7ynGYbcwJYRnWoyy+JQsopdt9MNIpvdL5EBY+OUb2F5hvVkDS0QXI2ijf8JcosH
 B1Mz302xELovUKjcoCaCL1Wx9Hkk4a69Lzv/76BR5PcM0S9MKv7YNXeDYjWealicR57Tkqn9iTq
 Kv4HLp5zp/fUhwVpk7JOAO7+0ZUmBuSMoEp1IN6fNmmNS5H4KvhVO8ciRfJEiSfA+x3YoIopu/i
 6SXQ1EbmpLS7oFrf8T2PYcoi8ccZZgq2LojRMIE7bII/8SCGtOWVyQEog0s/t19WyCKnujnbiPs
 Xh1iXxEM9wDURewkptK6b5y+g7oXABJXsv0yVvbEig0aJj1hCWRktmdyBjs6m+zxHTvQVBby7yR
 m9p2KI5RCArtMQehof3cGNiUwdjCwnUI0FH/HFIpSTsbDWGjMt5SNXcJVg4G8qTA==
X-Received: by 2002:a17:90b:5804:b0:368:3d3e:efa6 with SMTP id
 98e67ed59e1d1-377a6f1827bmr2771294a91.20.1781174512680; 
 Thu, 11 Jun 2026 03:41:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5804:b0:368:3d3e:efa6 with SMTP id
 98e67ed59e1d1-377a6f1827bmr2771263a91.20.1781174512150; 
 Thu, 11 Jun 2026 03:41:52 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37752b5a8ecsm2695793a91.7.2026.06.11.03.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:41:51 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:11:41 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 3/6] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
Message-ID: <aiqQ5fiub3NwDtMp@hu-varada-blr.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
 <20260608-snagboot-v2-3-036bb0343bf7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-snagboot-v2-3-036bb0343bf7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: BdTDyXZ4MdZaJrBZ70C6ODDwQXO2M9hy
X-Proofpoint-GUID: BdTDyXZ4MdZaJrBZ70C6ODDwQXO2M9hy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX47cKKRjRFa6p
 ukc9ShcIHFE+PMjkh6kvE47Gs6WH5V5Ll3MpbbGMd1s2lPZBc4OGtvmNNALnk0wxlvUAd77LCP9
 hXYeMw3ocfTBrLdzZyfVWUy2Ttor94JDdwWWo/cbeglz+z23fR0dT4knnB+ah2rXKeto0DJgTq+
 p6TbFkeZUmGKWfhAtYSMuYIZygQcgDVdf0KYvmLTK5CctJrwmle5YnWoPR+eT7W+AC3+z2oCrYm
 vWXFpogXFPqw+yRwv9xm+RW0zu3D1JPd369rPFOFFaRzYK56npFYFC8NwsWuhceK4EqHndJko4C
 FmVJ0VjUQ7jAtJOW08BwS7qv81B49b9AMRMhVQEK2GeJV0wwJnWvDslfFM6zR8ahRtkEcjq/yXK
 vasKBWAzcoV/A97OmeQyPawwrF50/IIZdBjBkMNjlfmsl9MOhuAxTXkCwVMorBP77z6vFPsFSSy
 OuB86BdvfIE2uD8jXWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX1IPQZjPVde5M
 lWqa2c/zMjU9v5OsRd1bdihLvvDhN57uE64LGJRbY2fCOjyxZZ5/lZRp2XFKSkwmgtPG8hX4lU8
 MxB6JhKJTZ7JjL2USm2DKAujKMpRD2s=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a90f1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q8IFQvCjWL6QJJuOnTYA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110107
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

On Mon, Jun 08, 2026 at 02:36:30PM +0530, Balaji Selvanathan wrote:
> When U-Boot is loaded by XBL in snagboot mode, XBL leaves the MMU
> enabled with its own page tables. This causes stale TLB entries and
> incorrect memory mappings when U-Boot initializes its own MMU.
>
> Disable the MMU and invalidate TLBs at the earliest entry point,
> before branching to the reset vector, handling EL1, EL2, and EL3.
> This ensures a clean MMU state for U-Boot initialization.
>
> The changes in this patch are based on:
> https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
> https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Newly introduced in v2
> ---
>  arch/arm/mach-snapdragon/include/mach/boot0.h | 46 +++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
> index 032a9fbdb12..c31bf6f52c5 100644
> --- a/arch/arm/mach-snapdragon/include/mach/boot0.h
> +++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
> @@ -8,6 +8,52 @@
>  #elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
>  #include "gunyah_exit_boot0.h"
>  #else

Since this is needed only for snagboot, should this be inside some ifdef?

> +	/*
> +	 * Disable MMU at the earliest possible point.
> +	 * This must be done before any other U-Boot code executes.
> +	 * Handle all exception levels (EL1, EL2, EL3).
> +	 *
> +	 * After disabling MMU, invalidate TLB to clear any stale entries
> +	 * that might cause issues when MMU is re-enabled later.
> +	 */
> +	mrs	x0, CurrentEL
> +	cmp	x0, #(3 << 2)	/* EL3? */
> +	b.eq	disable_mmu_el3
> +	cmp	x0, #(2 << 2)	/* EL2? */
> +	b.eq	disable_mmu_el2
> +	/* EL1 */

Not sure if it is better to confirm EL1 and raise error if it is in EL0.

-Varada

> +	mrs	x0, sctlr_el1
> +	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
> +	msr	sctlr_el1, x0
> +	isb
> +	/* Invalidate TLB for EL1 */
> +	tlbi	vmalle1
> +	dsb	sy
> +	isb
> +	b	mmu_disabled

b reset?

> +disable_mmu_el3:
> +	mrs	x0, sctlr_el3
> +	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
> +	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
> +	msr	sctlr_el3, x0
> +	isb
> +	/* Invalidate entire TLB for all ELs */
> +	tlbi	alle3
> +	dsb	sy
> +	isb
> +	b	mmu_disabled

b reset?

-Varada

> +disable_mmu_el2:
> +	mrs	x0, sctlr_el2
> +	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
> +	msr	sctlr_el2, x0
> +	isb
> +	/* Invalidate TLB for EL2 */
> +	tlbi	alle2
> +	dsb	sy
> +	isb
> +mmu_disabled:
> +
>  	b	reset
> +
>  #endif
>  #endif
>
> --
> 2.34.1
>
