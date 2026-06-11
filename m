Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75FCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 10:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A865839A8;
	Thu, 11 Jun 2026 12:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hP0je7li";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XRW/d2Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C2483FEC; Thu, 11 Jun 2026 12:23:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87765838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xHU5284107
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/nu+bz5hVOnjiGWHI0ZxdzHM
 4IXQ4omOrGqeqsqr8w4=; b=hP0je7liq46TwttsBFxOZ22JPjPbb3PnATMldR1n
 sfDWwMTCv0geAbPvnev6S8xorLF7DJfVC3Yu6sE3JxqneJpQyWVYblyuW1OrIdVB
 rUUI/aj8fUyNhruHSWGv4CnTDBVjTd+BmjkSzFP/KUnLe9X9DNoN5CG/qLyvUk9i
 v3Lf58cbV4SjL692XzdTWUadc/IUumETaCXbaM317EhTOL+zo4CQrIx4eTXCWqdS
 4zsarojZSXHHYScSBDDuOJa7lOu1ximUMhWUQFntfcDcrzTRZLFM+mmG9GmvT+cq
 8TKelVm2ehH5SwXdHDJ4lMezNdllQUzyTp0AIsN4bqdUXw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tjxtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:22:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d6389bbf4so7711604a91.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781173376; x=1781778176; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/nu+bz5hVOnjiGWHI0ZxdzHM4IXQ4omOrGqeqsqr8w4=;
 b=XRW/d2EsdjJBw4LgAzSYAh+CUlInpmQsioqC50/iKtJUlZbiSiavH+bmwygiYds2Ri
 k3zI4yD1/j2jtmera98xWQcAGtQdwaOS9vrho0SpkO2edMHqmNG4GUBW75Wdp8NF+nvv
 XWEAJtniP22BWmGpi4TuPxzlQJU3VGREv6A4clj7dvtBXe0Dad2TJC7PqK79Xy4im+pw
 8Py8xXdHMrgooCxjIvZ755jFBDgFcw+M4ImRtvzbKtL9RV0Mp8TdD3Scysl5oohNId8a
 r7yLbYIFys9MfSvb8R34OhQkXRXpo1uorWudDQnASznMn6AAPYoqthEnmlLBkh/vE+55
 dWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173376; x=1781778176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nu+bz5hVOnjiGWHI0ZxdzHM4IXQ4omOrGqeqsqr8w4=;
 b=NulBLFQcc2+r8JdcS8YtOCV43aGzPZ0oju8v4hAmpJHDKoZPDcUwr9UiDPOwcQaTTf
 ygjFg27A6bugS7myLDmjOpekGDHZy6r0uDKnNYNWvEf72Obs1s+Q0Z/sO1CKh0vy+HYT
 U43uWk5ObuBa/kYJWPseai4lFuQCak8gIUztYxFCcd+PUbm6Pp7BfI4Ws7TrAmgAhIVH
 8/dxFN4BVrNyMAGESfoEK4XeXAKdO7x1GBd4hwxGO2sDUTAutjDY6dk8x6eyd8bz7zl2
 /gQnk7X6p7SkvIvunpvHhWJeDQSmSi1EvDXIOekIs8bo5kqdF/dK2R9m26v1EydoBL0R
 dRpQ==
X-Gm-Message-State: AOJu0Ywg7MJIB4H29bvpO2Ae2uMNF7QaAIA6IEDkfUUfJrgth+/AJ28q
 N4HJgd0Of7rmYbY5j+k43m0i4FM3HmGwrddXqEsetvw60Yp5uZPYYO9PLTGHJ1jK4raLTPb8dXI
 UhiBESDg/yqt1o/o0tHr6jqhmmjQxx2G972Fn3z579GBfnoA0Jl0MMSqE
X-Gm-Gg: Acq92OEdOhhcj/LZ/m1z9h+TwKRIV82xsucjpEIgvrltGiZOvoYN0BH27hbNMPgFLs5
 VysAIF6SEfbDnjWeaTIEFF9lQHGr3rjtJ0fDbd+f7OtiPAl+7+fbzqaDZr0F3/Hhy6kH7MKbMl0
 IqNSGwDj3SD4gDAIm4gZsf33maaiSyal7vCH8dCB/b8Z/ZBmbfwNu6Pf2XHNTc6DIXZNUpglWxL
 gRxalJJ1TBpCEV6jSCV37BsFwAF1wk9yNkrNu06eW/fN/sup5j4TgQ+S3QrY2IlHRuJ128JlvNQ
 moeKBY33y74yPycpIWU9xZLiVw+eofSa13j0KCaUcqET/mMukYN3caxCjOoaSj4uzyj+5081L+L
 cfJ38+oSbHqUBFEzcU5SYxqoujuMVswhBOOGwHEVkqd2EshIbQcKdf5K/g0a9cd2mzo2IP5IF0/
 ki6rl4Ho49LAORgBlVXyPTuLLfYNCKg+NbeV/thlDZYKg+relhUSshJJ6m5H65zw==
X-Received: by 2002:a17:90b:1c09:b0:36b:7ad1:df70 with SMTP id
 98e67ed59e1d1-3779beb2ba4mr2463304a91.2.1781173375908; 
 Thu, 11 Jun 2026 03:22:55 -0700 (PDT)
X-Received: by 2002:a17:90b:1c09:b0:36b:7ad1:df70 with SMTP id
 98e67ed59e1d1-3779beb2ba4mr2463257a91.2.1781173375456; 
 Thu, 11 Jun 2026 03:22:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-377540fb80csm2607003a91.16.2026.06.11.03.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:22:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:52:44 +0530
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
Subject: Re: [PATCH v2 1/6] arm: snapdragon: Make SYSRESET_PSCI optional
Message-ID: <aiqMdNYOjpN1U25z@hu-varada-blr.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
 <20260608-snagboot-v2-1-036bb0343bf7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-snagboot-v2-1-036bb0343bf7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwMyBTYWx0ZWRfX8lWv3Qfbzqxe
 OtGeq7ui8cIauig9i590971+CYA+9TOQkOyoT9GiuV7MGKG58c48uGu13lBAKxGn96ujCE8A2E+
 zOhrSRgC57kv4HAO+AJpTTNfMC5hMCywjTIcORzkJJd1gn5IqOrxrSxnlWywK+hfm9mzQIddAiG
 PMUJoj4MHBKWHFJ1bdPVbsaivd2NIP4HBdP2XuJdO5KU4nRG1TGTqNT/3W+Akohg6LWRnngl3Zc
 Iral1Ekm4pPdbb30BExTTLRiDshQ/fSVgojlcmYYI6X8iNHgEHjIcx00cbZI1tqixsuk2klNaAp
 c2y2tINl3VQrJNTUupc/RgbEWa3E2ZVS+KPCeXzhh9oRynXby4cUcgTM30c8cwMx/l7s5J9XnFP
 Ky0jUpy/clB+yth5siemsZhG8imDxKaeBjiX5CVU3avwRn/7DASg/72lUcQ7PbcxGCrvaFzPHyU
 2ytj+YwodHrTNIyA/wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwMyBTYWx0ZWRfX910zK/pDnPOM
 pqJeabI8qaUcK1ZEWRC5x/Zsyi7nAMXtFP76I3hgunS1odYBvrVmCO9tjhtPunRgmkpA9VQYyd/
 oyqk7y/xvJ/Xu9eV1XQ2lXUhu0Imdrk=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a8c80 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=l0tQPX9EC9QjV6G11LUA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: GFr-okmfYlW8F3XDMwo0Tc0hRXMXPvjU
X-Proofpoint-GUID: GFr-okmfYlW8F3XDMwo0Tc0hRXMXPvjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110103
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

On Mon, Jun 08, 2026 at 02:36:28PM +0530, Balaji Selvanathan wrote:
> In snagboot mode, U-Boot is loaded directly by XBL without a prior
> bootloader to initialize PSCI firmware. Forcing SYSRESET_PSCI via
> 'select' causes failures in this scenario. Change to 'imply' to
> allow it to be disabled when PSCI is unavailable.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> ---
> Changes in v2:
> - Newly introduced in v2
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 514bf2000b4..a6d36f39069 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
>  	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select SYSRESET
> -	select SYSRESET_PSCI
> +	imply SYSRESET_PSCI
>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>  	select MMU_PGPROT
>  	imply OF_UPSTREAM
>
> --
> 2.34.1
>
