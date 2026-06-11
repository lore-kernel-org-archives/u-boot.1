Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E93CD98D5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AC284942;
	Thu, 11 Jun 2026 14:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgFam85M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWY0tUPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50215838D7; Thu, 11 Jun 2026 12:57:54 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF0D839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA05RJ318976
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BNR/Vr2+ElUNKZw3yTE/TCrw
 QahnWdEmsJLAO26iNzs=; b=hgFam85MmeVrd7J8MQjh2aRetuNgC2NU/TZHUfI3
 zwruS9tAtkIzYhVQDllO1FiCMvqOmGyvSp+jn0KQNvT3Kd5GhQiz3hvOmlisZP0F
 pgdZh7CoT0VNm1I0QhZFH3coD1tFP8nheaquZLg5SalllvzNs5CA6Ag+3iZAXolB
 JHo48rgWRQto18Vy8VLuF8L9izxL0psZlBNbBVLesXi84a1bK8n1wMr1UnXFoJ38
 Nq09fl7BqEwjS9zNty1LyIDBOYGyLp3ep7yv+yFUuMkuvFxzQvp08trHg1QrXZtN
 xnlXLo0oVG6Zr6p7ZANZwpwtm7DKMfav5cGnTmc9bcRQdg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sk3c9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:57:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842446a3851so3863681b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781175469; x=1781780269; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BNR/Vr2+ElUNKZw3yTE/TCrwQahnWdEmsJLAO26iNzs=;
 b=HWY0tUPBCsN5xJc193ZGoITT5gI+Et6O0oXoLH//OfIQDJhNctcJ3AHmxZlM95iCKI
 JZFzCL5UVHNmNmHzI0AK/zKGIm8dwJf2+F1HiaZezMt8FfcbdupS2i3w/vsdVebsZfg3
 FJJt7ayVI/T1WHIflq/IYYVn2psCbwzzI9XfPM9JiLMtskLaJVk62JPQezw4CcUaPiTU
 E2okz9tsXErFedabJN8sRbheg3AVqI5OmNsL4nXGac17z7/W5iK7PXP31Y9diDlKm8pb
 ioNGZr5QiwPJOyuQ14iAU0yUjXbRgzOTwooceJ9owQgbupFXI0bM+3N+y38ezGiOnLum
 ZBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175469; x=1781780269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNR/Vr2+ElUNKZw3yTE/TCrwQahnWdEmsJLAO26iNzs=;
 b=Y2ErgkNYgAGUHvb9YXdOqyFcbUd30COrKLni0/xFgja9mS9RDDitxIEXojCS1JmPjx
 eHBHcoF6WMO5U4I9ktL5ioU8NfPp0TFPH7fYYhp+0j1gon/Mq5Of6ZbW2MXGgv480OF0
 AGJBBNfkDzQ04BTYEcWKWmzTqSjARz7tnk77cfCKHGn9rozlMxGroUzl03E/Ll1MZGX/
 s+G3C8/8JPecpSOyM35GFFArd1O/0LzJ9IQRWgeVVInlykNla8i1mlCqB+AUB63Lqf9F
 vGmuSRdaP4z5SL4v8f4tGPLTKA8NvITVt52/oCYjGsbSImHbOpkrZ7kn9AuGy/zWytPN
 lbKA==
X-Gm-Message-State: AOJu0YyjXEgyQzYPbQQw41jHYNyS176U0/G8/7qKNLjZF51KWZ9wJsST
 1n7IOrY2NUnusZeW1y/n4UUNNTXHUKnQVAYnEhe/mDwkTTtCGyrXacyyw5zJTxGH2ZN2/AoZrCK
 IObBvWWd/QtqYsXhrcUUhZZP4GyIWEhmCr137ezw1mKdo7YELwCwg0ub2
X-Gm-Gg: Acq92OG22Gp7d2YsWkEw44DbyYFVFy//RL2j3qWcD+7BxmgjD2DE+W+KEDtZyUgdOug
 Dnvk/BnOtR3KX2lN3aVLnYiF78UzRCwz8js+9rbadfL2REAVHJLtjtRDz5FBK0kT8Nuc5Yx3GGx
 50dtr8G0aYcLCeg/mClijuBEOXggfdct7HfiMh9chINVBDd4xcCIlH43iZGvRKaf555JCxpqcT1
 T+70Omtt1SzlcQXkmumeoTyWRqgvPUNqRkeyGgv/WB8ff3o06e6GtRwia64T04LZlgDrN3AbfsB
 EeFgeHS1y33vnmDBJPToRwTr6uC9DM3l2nfHxC01A9RiRpbRvhV2i51FN4YZ1qEebBTWPRFGcUz
 +C3iWJMuyd+pdggYqigA34snA1q6cTz2JZdRuSori1X0t+TbGV5ARRry+Fk1ZRNyDWLHyHrTgqp
 6a1EVwO/+dBJPqYlGfSu6c6mGz6i4SvGUEVsHsxWxYMiUvaY+gZ9r6zGofCmlrHA==
X-Received: by 2002:a05:6a00:1f0e:b0:842:74e3:48a9 with SMTP id
 d2e1a72fcca58-843367ecb27mr2525038b3a.12.1781175469271; 
 Thu, 11 Jun 2026 03:57:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f0e:b0:842:74e3:48a9 with SMTP id
 d2e1a72fcca58-843367ecb27mr2524996b3a.12.1781175468767; 
 Thu, 11 Jun 2026 03:57:48 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843380c9307sm1569995b3a.29.2026.06.11.03.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:57:48 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:27:29 +0530
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
Subject: Re: [PATCH v2 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
Message-ID: <aiqUmUNyCQ8/wN/m@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-1-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-1-72fed24ef01b@oss.qualcomm.com>
X-Proofpoint-GUID: 6g_MdpEE5RvA9lAp6y6CmAu4sI8nSL1e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwOSBTYWx0ZWRfXwEKKVFwyKw67
 oyIyFJruZZMgllhZig6KVWp24QviXvgEkHEBK2k8LjbnGvgZhkPphVPqoot1GGLAgT6CvMCod0P
 7I1z5z2TbtfWlRuwXhvcTeLYsZdVHCw=
X-Proofpoint-ORIG-GUID: 6g_MdpEE5RvA9lAp6y6CmAu4sI8nSL1e
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a94ae cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uDjYacrXqn4QI2cSJNMA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwOSBTYWx0ZWRfX/AUtwgbRpDgY
 OnjX7kepWRFF3MDECmUx2DglV48SmxgxebZAeicjlJwPn0/ev2uCbZiHxL9W1omDOK4PwLi66Ga
 i5LEV6qFFoBhhDVE5302mmCzunySuwS4PzZWAY2BfdISt5400GkT0QM5sZ3Uxx4VXFdCIZ3VLZj
 R7IsZcsFo+IPtYsewNAxxnKNGEe8Tm+eGCT9dCXbZTQFOQcD3+C1eXu/OOXxedHYe7bJO+r5ZQ4
 +CNdJcAwJd7UzDQbWnOk3KA6089gE3JC3LfRtxV5Mts87gtrFfWobTnnNX86zKGS5hpAhMqD8QT
 zamS4eSn0XLdzirWgUtk7GZqEvpF0dkJnstEyTl1RBRWu6C24i+WeRLyFSGfC11kVz2FZH7zvvP
 dOZxBlblgQg2Fy4tiJFTnhcuQDlpXudTuyV+LA7Ra8Oip1cq193A4JmtJjuxDV8sW4sTK6Pixdh
 CalhiaUALpS31h+qJ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110109
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

On Sat, Jun 06, 2026 at 03:48:32PM +0530, Balaji Selvanathan wrote:
> Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
> the naming convention used by other SPL storage drivers (e.g.,
> SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
> $(PHASE_) prefix macro in Makefiles, allowing uniform use of
> CONFIG_$(PHASE_)UFS across SPL and TPL build rules.
>
> Drop the redundant `depends on UFS` from the SPL_UFS entry since it is
> already implied by the driver selection.

How?

>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - newly added in v2
> ---
>  common/spl/Kconfig    | 7 +++----
>  common/spl/Makefile   | 2 +-
>  drivers/Makefile      | 2 +-
>  drivers/scsi/Makefile | 2 +-
>  drivers/ufs/Kconfig   | 4 ++--
>  5 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e49..10dcb7b2f87 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1613,9 +1613,8 @@ config SPL_THERMAL
>  	  automatic power-off when the temperature gets too high or low. Other
>  	  devices may be discrete but connected on a suitable bus.
>
> -config SPL_UFS_SUPPORT
> +config SPL_UFS
>  	bool "Support loading from UFS"
> -	depends on UFS
>  	select SPL_LOAD_BLOCK
>  	help
>  	  Enable support for UFS in SPL. This allows
> @@ -1624,7 +1623,7 @@ config SPL_UFS_SUPPORT
>
>  config SPL_UFS_RAW_U_BOOT_DEVNUM
>  	int "SCSI device number of the UFS device to load U-Boot from"
> -	depends on SPL_UFS_SUPPORT
> +	depends on SPL_UFS
>  	default 0
>  	help
>  	  UFS devices are usually configured with multiple LUNs, which present
> @@ -1637,7 +1636,7 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
>
>  config SPL_UFS_RAW_U_BOOT_SECTOR
>  	hex "Address on the UFS to load U-Boot from"
> -	depends on SPL_UFS_SUPPORT
> +	depends on SPL_UFS
>  	default 0x800 if ARCH_ROCKCHIP
>  	help
>  	  Address on the block device to load U-Boot from.
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 9c94e8f143e..9714ada59f4 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>  obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
>  obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>  obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
> -obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
> +obj-$(CONFIG_$(PHASE_)UFS) += spl_ufs.o
>  endif
>
>  obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..86a54b5f332 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>  obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>  obj-$(CONFIG_SPL_THERMAL) += thermal/
> -obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
> +obj-$(CONFIG_SPL_UFS) += scsi/ ufs/
>
>  endif
>  endif
> diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
> index c9af60d5d03..6d1f57bf101 100644
> --- a/drivers/scsi/Makefile
> +++ b/drivers/scsi/Makefile
> @@ -16,7 +16,7 @@ ifdef CONFIG_XPL_BUILD
>  ifdef CONFIG_SPL_SATA
>  obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
>  endif
> -ifdef CONFIG_SPL_UFS_SUPPORT
> +ifdef CONFIG_SPL_UFS
>  obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
>  endif
>  endif
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..64172454bc6 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -78,8 +78,8 @@ config UFS_ROCKCHIP
>  	depends on UFS
>  	depends on DM_GPIO
>  	depends on RESET_ROCKCHIP
> -	depends on SPL_DM_GPIO || !SPL_UFS_SUPPORT
> -	depends on SPL_RESET_ROCKCHIP || !SPL_UFS_SUPPORT
> +	depends on SPL_DM_GPIO || !SPL_UFS
> +	depends on SPL_RESET_ROCKCHIP || !SPL_UFS
>  	help
>  	  This selects the Rockchip specific additions to UFSHCD platform driver.

Additionally defconfig files that might use CONFIG_SPL_UFS_SUPPORT should be
updated.

-Varada
