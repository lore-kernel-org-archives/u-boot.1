Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED298CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 10:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0AD839A8;
	Thu, 11 Jun 2026 12:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlrI9X1y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3u+Vb6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF8B83FF5; Thu, 11 Jun 2026 12:25:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF9F838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xJfn2890211
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uXSePwAO+wIai4oan1v2DH4x
 d+SocKRudZqclrazFnY=; b=UlrI9X1ymMzFfiyrC44Fnes6h+Aucr57rE/PZYbB
 WUN+hS4FHgluKkWf1xixTv8FqTjurHcv7ckHRUFOXnSx7f5FoJJS8Tx1udSBGyN8
 /gupQ6eKmYQTxAQp+tw/goTs6act8P0+JpMx/95QqgbMrmZd3Jrg6sw2zIz3yJpz
 HwcpRzUDV+XuQW9VBtATV0dwsiC/XnB5ZGOhyNqMwMeP3ETH+LC/KcVzvWzA0/Em
 yLqxVnq3Ay4TQGQd2DcdxVxkQhS8FInvDUDdrs3IWOPHMtIrDDRf9Aq2lZLZbUn4
 9FqVeKHHBEjaWS5SlgptDKy3ahKZfg8Bh3JpPEo1z01Jyw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79jvq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:25:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf55c3f44aso7388055ad.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781173537; x=1781778337; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXSePwAO+wIai4oan1v2DH4xd+SocKRudZqclrazFnY=;
 b=I3u+Vb6GY5u/Xa9F1GnUcaxZHRbP3PvzmsvymN7wjdb48He3oJjbJF+YtINOgD4uG1
 n8uAdcRunZWyFTyX8nqwPEbA7ZPcqHB4b/pTjXDQPYLByuXKYtwgrvBJ5Z7I6+zsWErX
 Ga+AEBHZ4FOVA2pIt0rgZftz1Dt0EW+Pvzde8M192JTdeRlNghO/eoAdUk9aYY3kBVQl
 ZmVT26i2CTw2lhu5dgs3CB0QiGYMNvf+BII32pz+lyc2/0oNxD1xhyBVOQPwS+l3Fz7w
 BXLmzALusBbsYSc9CSAts/IIfViosKyEFDKKMuwRe5J+FfeGH2eKILykftvSn1uoTW8h
 HLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173537; x=1781778337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXSePwAO+wIai4oan1v2DH4xd+SocKRudZqclrazFnY=;
 b=s9pPI6dYMkOet+cR4NGaJQJuXgcKh1YL1pkQqVksaHeEu1HmjAWCJE2KkOgPKCfD6P
 iAvCt4IWikGU/T/B/Sk1kbLICEaIfs7rFyceIVbWA+CUSwgOpIijqWvvGxf6PomxnIQH
 77P1hsxtPwE+Br/GL/W+DoG7GTbcl+TEfbpxBWJOdT3QOW9HMO9K8YAllnAby5qeaJGy
 DDxRoQihO8d26WZK162Jp9ROfGbPp7yUpBnly3sB7X+4Lg7OkbXT5YsuGXhXhXYU/1Zc
 ONdFMRyUVbFKttg3bkBoSzXjKp2cHWQuhE+NeID0voULIdSrhSwtMKIpbSyGYxNDz1lP
 xbzQ==
X-Gm-Message-State: AOJu0YwavtHhX2+Xx5OQ/LDwWWdG2qMrRcW7bCfE6nP+ofQ+MPATosuS
 787IpAyeZh52C6MKtq4czPF8lbOu/8qR0J6cWVZ23Qs74ZPHEOLCDFHDqm6SJAI8z8hUTGtidn9
 teEBo8j2PMiBMEuFkvnkG9NyR8sc8Jdmg8nKFnw37E5dsqZxGQWBPZZOP
X-Gm-Gg: Acq92OHrquZSFs8KJEzLJ8myXrufAe4qJyvRXuEwwztPxb7sqkwURIQSc4dglcqISCF
 /d8bbc1AyMzXHUAESVsd2BEZ1FMw3FQhkij0eylaUoqIwLV2zEsy0DrRKP80wDhw6YXfDmb+Cc8
 5kcCwixvjEFrnMzwc2IRcX3ZE7qjLo/BjEdJEikN7KW0+4OZ/AFKi05RGWSgrVt2rAlxDk+XVaw
 m6/MMPjDobL7lanvriW1UynQNzggfE3F9rMJF/ab9FKd+T34S1LBjfzQP9muwkfy2RfURP6etcL
 fZcUSV5wv6yId4wgGaMGSbg4Xwk0GXf6gqehY5I0EoMkAfORNB4hJ/MABZKKptQ/Jy1ubFlF2ob
 yryaWRCz7BKyrOZes50IXgNuIfUOFy7OxmcSoDCOjDfMctjvv74/xqoMfxb9TtUZhjk5JPJWhaq
 vket5AKLLF7AAKpjHfSVkhxG2VkncnNW2mWvhakP2lGvuSYPr/O1nqENFKlbNDQA==
X-Received: by 2002:a17:902:f64e:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c2efc632d5mr19655595ad.13.1781173537169; 
 Thu, 11 Jun 2026 03:25:37 -0700 (PDT)
X-Received: by 2002:a17:902:f64e:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c2efc632d5mr19655125ad.13.1781173536633; 
 Thu, 11 Jun 2026 03:25:36 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d1e5sm259956235ad.12.2026.06.11.03.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:25:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:55:25 +0530
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
Subject: Re: [PATCH v2 2/6] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
Message-ID: <aiqNFes36dgtWLJq@hu-varada-blr.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
 <20260608-snagboot-v2-2-036bb0343bf7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-snagboot-v2-2-036bb0343bf7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HEMpWZdygRBToHLHRD1VyZS6K4-klm7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNCBTYWx0ZWRfX+wVABrnXVPbE
 GMtOidyG5Oos4GhpJMz9VwbPUCZIBKB/ijgTDKAG1U+D0w0r0VCER4uvmZx3lCLTje5q/5+636S
 24eBD28oFzo+k9vVFwaBmhzG5n0skWHRNgH80BoxrKTzmoAHrZ3K6AhSHjfgfc25on0UgO8JT7l
 9plP6r6VHM3n1x4xjw05fhns5adU41QkU8GDDLnqW4vBVl9lCPZLm9d/bisSLDcQh4XbnjHwkdg
 H+yz6CFmuFGvkwj+/IxDgkblFLYHsPpqkfTFw2wFcmwL3clDeZHFPpXFteiKIDneZqacXDzpMHP
 p2sWmlQuiS9qctaiZ3RW3sQ5WJ/vveb9SGEeiK1xbLLojMdeHnCiVfHRQAP+FY8Gj57kVFfpuWr
 8XpEtvYUoiprT3PYkA5WjH832Ep4YKj8oSOk2Jd9XAEcIEPrY0g0BjszQehXuTOPsuVg4AVLBnQ
 EJzJ4RpYKk15i2bcLXQ==
X-Proofpoint-GUID: HEMpWZdygRBToHLHRD1VyZS6K4-klm7Q
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a8d21 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tsbQDVE2_yd0CtrqC3IA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNCBTYWx0ZWRfX3NQfojC8y7UT
 9gXtgrr0WGCfc4agZELTnaGEnRcFmuu76B9HmrQLof8YLacZNuEeH9Mg2AlLyGd6plA9XA3wnRq
 majKD6Ok6SsTKnEcYKZxMdjNd5pVm8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110104
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

On Mon, Jun 08, 2026 at 02:36:29PM +0530, Balaji Selvanathan wrote:
> In snagboot mode, U-Boot is loaded directly by XBL without PSCI
> firmware support. The functions show_psci_version() and
> qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
> CONFIG_ARM_SMCCC is disabled, causing build failures.
>
> Wrap both functions with CONFIG_ARM_SMCCC guards and provide
> empty inline stubs for the disabled case.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Newly introduced in v2
> ---
>  arch/arm/mach-snapdragon/board.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..be4bdd49cf6 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -158,6 +158,7 @@ static int qcom_parse_memory(const void *fdt)
>  	return 0;
>  }
>
> +#ifdef CONFIG_ARM_SMCCC
>  static void show_psci_version(void)
>  {
>  	struct arm_smccc_res res;
> @@ -172,6 +173,12 @@ static void show_psci_version(void)
>  	      PSCI_VERSION_MAJOR(res.a0),
>  	      PSCI_VERSION_MINOR(res.a0));
>  }
> +#else
> +static inline void show_psci_version(void)
> +{
> +	/* PSCI not available - no-op */
> +}
> +#endif

static void show_psci_version(void)
{
	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
		return;
	. . .
}

Wouldn't this work? Didn't checkpatch complain?

>
>  /**
>   * Most MSM8916 devices in the wild shipped without PSCI support, but the
> @@ -180,6 +187,7 @@ static void show_psci_version(void)
>   * firmware driver doesn't bind (which then binds a sysreset driver that won't
>   * work).
>   */
> +#ifdef CONFIG_ARM_SMCCC
>  static void qcom_psci_fixup(void *fdt)
>  {
>  	int offset, ret;
> @@ -199,6 +207,12 @@ static void qcom_psci_fixup(void *fdt)
>  	if (ret)
>  		log_err("Failed to delete /psci node: %d\n", ret);
>  }
> +#else
> +static inline void qcom_psci_fixup(void *fdt)
> +{
> +	/* PSCI not available - no-op */
> +}
> +#endif

Same here.

-Varada

>
>  /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>   * or for supporting quirky devices where it's easier to leave the downstream DT in place
>
> --
> 2.34.1
>
