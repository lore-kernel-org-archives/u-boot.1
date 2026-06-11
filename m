Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A54ACD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0161384949;
	Thu, 11 Jun 2026 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LHwLtyOU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6QU1WJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB3283FF5; Thu, 11 Jun 2026 13:08:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126B6838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xJvD2890230
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ujFF+oF2k/w7NBWTL+RCb/Qu
 z00h+gGqBbQLvEHaMBk=; b=LHwLtyOUSg73O2fOKmlKbYoMpslPG0weHr2dP2OK
 hTWn1UOG5QgXujqYGIHzokjNfdDDyGykQJfcKUIlw56V14gJbj0EQGmMmjb5rqlA
 AWfJkRmO/sLrdLa3+Y3unE+VCss2n2b3wYtyHIfIerA9/iWnyYGvhpbl7Di7rx9l
 JR14wRwpdPsWOqTGEB+wI/PdLQunivO7C2EamKOrgU2TEY0zjz/0awRrTAUWnnwC
 Cr4Bc6PGmTbpb6ycjv47Jh6PpntpCtak7UWl9g5uTdFNhKDIpk/J0uCqQ0VFllFD
 Im6v60BSjzFUsA4xu8Smg6SL3Qpc1wfQvmhF2iHAEfkqXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79k1qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:08:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8424aac207eso7919425b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781176106; x=1781780906; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ujFF+oF2k/w7NBWTL+RCb/Quz00h+gGqBbQLvEHaMBk=;
 b=C6QU1WJfsqgWkPcVG0IKs28t3RoETubySNNFLW0JLkGpCG5vWQSW4o0E4zDr3GLNU1
 rsC49gre2vvG1n5ICs+Jfc5JmTTKk0k50HUiemfJigFsSISD3iEDxxS1j/87ykorgTt8
 xVhBW1q9YtPKw+kUyMiyyNWF8Ki4jRUx72oF17ebeWDKG/0+j2dALmL/pvuxAtcfzNmP
 5Sq8+YesbkZzW7/t+6jmi0UrarxLViSVcphKBnYRiOtUxPVfk+kUSAEgjX7AnoC/vycK
 i/NFTZ6anUxL1fUy2gEl4CjYT8/bToJhFOidji+Ow61U0FGVOl0ExtCkqBRR1jQUtjzh
 dFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176106; x=1781780906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujFF+oF2k/w7NBWTL+RCb/Quz00h+gGqBbQLvEHaMBk=;
 b=Qn71HgFBvqKmwsEiIythHRcatyGIR56bgzjQyjWDRcsOALIXxzERR/At/R4mf7LXHe
 iECV6x0m9YjwoOVl9CgvJ0pTJ4qg/qG7jTnTIo8AWw7mWD9h8s+DshAn6zxlNw0Hv1+V
 zD9fd4J5TCeMs3Y8MnftuTj/dLASQ2zg4XLq7PKNnVA1Jdl4c6N/Ijb5lpV7VGQZ9hf5
 Hvh+oOIa14poBXTiQuVP8OGUkvTpP/jAQgF+2nfl73kvFSeTTh07D7w86VpHLXRp2fpZ
 YHIlqpIVr9uJqSSdlRKtyOPttnjRAQjlQWkJp3EVBE2tr+m6LPMLa+ZUJKrxJIkOXvlg
 5sIg==
X-Gm-Message-State: AOJu0YwADDVccDm+kjiVlAq/hLEQrn3+qjhp9sxVV0nNtcglC5zCtZZt
 7ThUMfkgmxyGa9FfhU1URbDNxuPnzE+ow9954Erjq6AJEVqW3EjErmsn3KCNsD9RH+n4JMg6x+A
 UzkR3iLrdP5QaU8fCgKtZ0pSGdtPzvFL343SUI1o9+OkEEQRJlmxbcAe1
X-Gm-Gg: Acq92OHck7+Exg4kVesdw0GCJE22QNILTh6uVYQOesLbygUh9/XXOOSeB/K04YJGmcb
 Oo6CEuOwDtMpbOb0M8peOS/SkjVjmwCy9c3ZQOXtscFrRrjExBJFjvxFaT272dl2rmHkdTy2pxh
 MbzAcyopVsNNev9jQpN0EXWeKJL2RazKQz7rxvg033keVPi7e7DlhYdFFQLfaA90c5nLfU00w31
 QsxL71u3FHxw+DidOufSRPX3w7RNqZchJJRNONq2MUDYlx74u20mPQOwjOFrnkQp8tZ6ycDiqC1
 6rM54gExgTPjqiANGaaEJvqRW3kJcUfndPE1Yg08rmyLgO7gVKQI8KOPLGrJ/OZ6X5nTOxlxXPM
 YNUzGApvx2ezkxsMYyELZsbsTxzPLrPcfYqQTjOtZxW/hDVu0oEBBQmggpl5xCtvQj0jsYSgxOA
 kZNUqT0n+xcQP0qQsKIyidXLSvfQoPAlRp3JiJUcynVsk2ydQNNjdQW8UOCk9cmg==
X-Received: by 2002:aa7:9064:0:b0:842:6fec:12aa with SMTP id
 d2e1a72fcca58-843367ec18fmr2787198b3a.8.1781176105954; 
 Thu, 11 Jun 2026 04:08:25 -0700 (PDT)
X-Received: by 2002:aa7:9064:0:b0:842:6fec:12aa with SMTP id
 d2e1a72fcca58-843367ec18fmr2787124b3a.8.1781176105385; 
 Thu, 11 Jun 2026 04:08:25 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337b915c1sm1785666b3a.7.2026.06.11.04.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:08:24 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:38:06 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2 02/14] spl: ufs: add Kconfig choice for U-Boot
 location method
Message-ID: <aiqXFoZu3OHn7WzV@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-2-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-2-72fed24ef01b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: VO8fggQhfek9IQeoy5f2yvTAwYexi7DY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMiBTYWx0ZWRfX3kSIbI26ArwB
 UDhmmFoW7IHQNcaZibXwvABHc7HncYoKc/BkzevU3ppfplIfrpt5ave+T2zP7CNyX1FLJiTd2Oy
 +z6X5VFM0tFasYaPyyIR7VG8PF74/RxSDS6w1Fww6mm+V80Eq3a3KeDL5dHcvLdGczkdTeM16gq
 /TzZ7Qe735FkI4LoHJWWadSCjNGXPtYrUIcBb3olKiEmHVbeGdNS5y3yLVyONUuCWgtxz7Xzuh3
 NYXu4SZvpNiXvY7f7texYXrLZvFdwgWbPOvDjMOCtmCVsZ0aHN4f2SeewBGGGw9rs1hT+Mv3ylt
 xO/KWF5D5hQHKh0xRKiqYCWzTdXTBZ08I7K+KAbFREeyF4dSCaZqk+YXaRS4Ob8jA3W4Y2EKqWS
 6aeIlC62eaGGP3PVytRFxEZugEXIyBo1N9F0zxsgpzg4ynqYfN5t11WSp3VU1DOn2nV3VTGQ6be
 QaH4I2I3FN2kOhfpewg==
X-Proofpoint-GUID: VO8fggQhfek9IQeoy5f2yvTAwYexi7DY
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a972a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Dkuf0lDLBy1VlIdroXoA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMiBTYWx0ZWRfX5eJRUIzD5bFP
 O9SRdipfTYSilcldv6R8kqdv78exwmhVgrsN7ceEIMKE/aSUAsbJmDJ2Wqi6k1DrzsDKvDQ8WOY
 f+umnH53MdnaqmyMfLtRXjQzf/yE6M0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110112
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On Sat, Jun 06, 2026 at 03:48:33PM +0530, Balaji Selvanathan wrote:
> Replace the single SPL_UFS_RAW_U_BOOT_SECTOR config with a Kconfig
> choice that lets the user select how U-Boot is located on the UFS
> LUN: by absolute sector offset or by partition.
>
> The sector-based path (SPL_UFS_RAW_U_BOOT_USE_SECTOR) retains the
> existing SPL_UFS_RAW_U_BOOT_SECTOR option with an explicit default
> of 0x0.
>
> The partition-based path (SPL_UFS_RAW_U_BOOT_USE_PARTITION) adds
> SPL_UFS_RAW_U_BOOT_PARTITION_NAME and
> SPL_UFS_RAW_U_BOOT_PARTITION_NUM, allowing U-Boot to be loaded by
> partition name (tried first) or partition number as a fallback.
> SPL_LIBDISK_SUPPORT is automatically selected when this path is
> chosen.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Introduce SPL_UFS_RAW_U_BOOT_USE_SECTOR to clearly select between
>   sector based or partition based lookup
> ---
>  common/spl/Kconfig | 46 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 10dcb7b2f87..82b757d1efa 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1634,13 +1634,53 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
>  	  SCSI device number, which might differ from the UFS LUN if you have
>  	  multiple SCSI devices attached and recognized by the SPL.
>
> -config SPL_UFS_RAW_U_BOOT_SECTOR
> -	hex "Address on the UFS to load U-Boot from"
> +choice
> +	prompt "Method for locating U-Boot on UFS"
>  	depends on SPL_UFS
> +	default SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +
> +config SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +	bool "UFS raw mode: by sector"
> +	help
> +	  Use absolute sector number for specifying U-Boot location on UFS LUN.
> +	  When selected, SPL_UFS_RAW_U_BOOT_SECTOR specifies the sector offset.
> +
> +config SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	bool "UFS raw mode: by partition"
> +	select SPL_LIBDISK_SUPPORT
> +	help
> +	  Use a partition for loading U-Boot when using UFS in raw mode.
> +	  You can specify either a partition name or partition number.
> +
> +endchoice
> +
> +config SPL_UFS_RAW_U_BOOT_SECTOR
> +	hex "Sector offset to load U-Boot from in UFS raw mode"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_SECTOR
>  	default 0x800 if ARCH_ROCKCHIP
> +	default 0x0
>  	help
> -	  Address on the block device to load U-Boot from.
> +	  Absolute sector offset on the UFS LUN to load U-Boot from.
>  	  Units: UFS sectors (1 sector = 4096 bytes).
> +	  Note: Setting this to 0x0 will load from the start of the LUN.
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +	string "Partition name to load U-Boot from"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	help
> +	  Name of the partition to load U-Boot from in UFS raw mode.
> +	  This is tried before partition number lookup.
> +	  Leave empty to skip name-based lookup.
> +	  Example: "boot", "uefi", "dtb_a"
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
> +	int "Partition number to load U-Boot from"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	default 1
> +	help
> +	  Partition number to load U-Boot from when using UFS raw mode
> +	  with partition support. This is used if partition name is not
> +	  specified or not found.

Should PARTITION_NAME and PARTITION_NUM be mutually exclusive, or both are
allowed?

>
>  config SPL_WATCHDOG
>  	bool "Support watchdog drivers"

Can this be simplified?

config SPL_UFS_RAW_U_BOOT_USE_PARTITION
	bool "..."
	...

config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
	...

config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
	...

config SPL_UFS_RAW_U_BOOT_SECTOR
	hex "Address on the UFS to load U-Boot from"
	depends on SPL_UFS_SUPPORT && !SPL_UFS_RAW_U_BOOT_USE_PARTITION

-Varada
