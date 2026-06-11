Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01990CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFAB8496E;
	Thu, 11 Jun 2026 14:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ab/w/Kts";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YA1AHnyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815DD8466E; Thu, 11 Jun 2026 13:31:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6BE841C2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xEUX263737
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=V0Lq1m571Y84gsUmJxsnkqxr
 95Y1dAXzmrfOP87g+uw=; b=ab/w/KtsENZ5UgVZrPw2b0OXQoRAqrhzmI9F7zSU
 FNtCEfvGzDFuEh68P0TaroyQxICQV4//Crd/imDUKm+BFHAH84rmvXRpUbS/tVf4
 0JkW2OSgCW1sRpoXKC1y/YoGHexNa9cocbZmX8UjTSdYSWBdtFBf6GGla2hIfBtr
 kbjKtF3AFlhhp2IlBc0HLqWT8qpQd298KPonyme6MLp4oainusFS57+RkujgCU4B
 oB6Bn+PSh88NcAXnHn8wP8Dz2+6cDLowdRlsYKYP9q43b2cFbi41cLTKQTpFTpaZ
 rtPj6JdJZc3XCKibkgvZnwjkCqG5o1Uc8Y5j+3cCZTN2Xw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uu58b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:31:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bc380fbf9so7778145a91.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177496; x=1781782296; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V0Lq1m571Y84gsUmJxsnkqxr95Y1dAXzmrfOP87g+uw=;
 b=YA1AHnyk75fV7H3MadQadSIrNkQlKEzrB9AfNMWBoYkEuWPNMIXuwTFyAmB9MzUWMp
 uG1d4DaAXwDVKf6KlpqNTAQQK9otEJA4ID0DC+gMEDhj6J59WtTVoNCr2B7RvEBGWDo0
 vgs1usphz/zXcIaYt1+MScruVlPiMF0+tK4tF5wXze+eovEVqnokzgtarIwXjd/1vpAx
 zoEA7qESBdTCV+gZKJ1t6FFb9z4lOeWXtPacgc48kSrpXaMCjTVCHfHWzW8QgtIK5snb
 P4xNKIWDTfOwzFuFrhB1mAbKK4JGpb5+UUcUMwKeMvhqSzJNHfbL+G2VUWCBoZgBa3tE
 xsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177496; x=1781782296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0Lq1m571Y84gsUmJxsnkqxr95Y1dAXzmrfOP87g+uw=;
 b=OK/vee+WA2YJ/RbplrDaa6YXFdzRRKIL6V7KxKmnJ83+dm6ebpjvjs5MeYJm334sEx
 1EBXZG8VUhmvmZ1LMH0XRZ607ZgDl6D1ox4angXokUXamTmnEflM5YQ0Djcny49yN2rL
 jn4RN1X9KZH1UrIlLRzfNVOHbIyPK6AeQKS6jLkAHwjtRSXvvl/7SkCzT4jJFUffb1/x
 L1EmPEPi9u6KjcjWnyD02CfHLXXlKjPXL/W15NFlseqQCaqUJYI/NUiTWeejQG3YKMp2
 LIe9Y6oiS7tMdPvWrBrjFDs71+8vXBX0pkI2IlzGeEHyCCbGwM/22MEiP1iuS31pHu5a
 M2ag==
X-Gm-Message-State: AOJu0YzJr3UYYEF4sNqKpttZaIHIsItpD2vMfTe/ynQI3zGNiH8txe/i
 Tv36y0SUgc2rSMM7OV3IHJqYXKRChIc4lhcfFX1cJt8ZAuIBnuIV69TufX6jKWdvUrTKVs9R7NF
 dTBlkCXZ4WCmiLSLT0kxFNcXZl/sorVtMOOAOb3lM5pVohlvuDAO+adQx
X-Gm-Gg: Acq92OHG15TlWqbcIaIuU2A40t8Jg6dlniWn6OVbjyNaugzzR1a7mfH/olgtJ+Vt5ds
 OAiqZLhPmmFUjDoWmtpS7q/2zS/qTn1DFOvtfneOgVXo3GeIiczjrt430LlfHAKPbBoYltbJ6Pq
 KOZMSnEXXMyZvG8v/c3qpBmS0IhyEuCMaUYnhcNHQJyVvs35tFKjOr5DIdqCuxTH3ecdqPcse8w
 JKmIV68BarFfYYUO3IqlsxyZCHKYQtxsbNPjWJzq5ZVGg0GLv2NjB8ypA37cj3DVhV22vO9nPK4
 LxzXyZRLsYNw3uWjfTcyv32lxS8KKCQB7Hw3U+q9Vbw3jMEF76yPirNtiETE27Y2/Hzh/SFSDeC
 ARoLn61a5hjjhSYUAfT07lY7yQU2Blgieu3ojyXVr/7Z/wt6GkMnqLuq89bMxoIpcjQ85oQAdH6
 AWndnpEZp5GGTabVih0cYYNvUD3n9qRcD3JkEAg1eURx+gEy0FX52QD0QHxI8W8w==
X-Received: by 2002:a17:90b:5627:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-3779cb262cdmr2777458a91.5.1781177496065; 
 Thu, 11 Jun 2026 04:31:36 -0700 (PDT)
X-Received: by 2002:a17:90b:5627:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-3779cb262cdmr2777404a91.5.1781177495596; 
 Thu, 11 Jun 2026 04:31:35 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753329a46sm2416397a91.8.2026.06.11.04.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:31:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:01:16 +0530
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
Subject: Re: [PATCH v2 05/14] part: enable part_get_info_ptr for SPL UFS
 partition boot
Message-ID: <aiqchHoJsFbZFiaD@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-5-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-5-72fed24ef01b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a9c98 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Xk9Ea06V8EIF_FXEUgYA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX5k2dkqylwikA
 u14NzGYcuhD6ksDo11j/ucWZFIGcZUQ3W/cgekl2Akp7mT2pNMEyssB2Cal05b9xUwEQ9piEf0j
 bkZQCMeuuIZm+ld9PEFF9SMi/Db/krA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX8+t318gCKfuE
 UEJg+yvCuYwTMOSGXh8+aQVTN2M7CWdpdx6TbFQxAouUhUxtsyQac2nKoSJwpNt5XWvC3Wm1bHm
 3imCyuEDuVgSwCl9YIbBFeEmA4/vA2ZOChIM1QtH/E6vzwBDv+CooZzRL7kbX3i4N3n+s8+fjsj
 3MkRKZVQGmmAEh5yehRbIGvkOn0Nobn2qsIIC9qFuX2xSdvAnJqitQDeIjdxFnlWiVR1y/CZ47C
 ht7aD26pATduFUDP+0wzUhfIpqF6a1s9s4zFtMgmSDm6wDqpOunjb4agL9NTp1IZHM3roDfWRJO
 LaORqiZzWGsz8pRweAFvMrYLaT5jXXG2pOwtFPpB9CGE1a0M7TZpqj08lhXDNj7Aa95CEafONV2
 51GZ0DuPAt7IykFUXE6nPZNb+imkQgFXeFY+P77XZqMNtMP74fVfdtCs/wExeVONHQGeNWnFXu3
 +977xY0syrCO8G+Yqsg==
X-Proofpoint-GUID: enJFge22pMOSf7iLGHrjEha6goolGwnX
X-Proofpoint-ORIG-GUID: enJFge22pMOSf7iLGHrjEha6goolGwnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110115
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

On Sat, Jun 06, 2026 at 03:48:36PM +0530, Balaji Selvanathan wrote:
> Add CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION to the preprocessor
> guard in include/part.h that controls whether part_get_info_ptr()
> resolves to a real function or NULL. This ensures partition lookup
> is available in SPL when UFS partition-based boot is selected,
> consistent with how MMC raw partition mode is handled.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> ---
> Changes in v2:
> - Added enabling part_get_info_ptr for SPL UFS as a seperate patch
> ---
> ---
>  include/part.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/part.h b/include/part.h
> index 15daacd7faa..47b91e2043c 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>  # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
>  	defined(CONFIG_SPL_FS_SQUASHFS) || \
>  	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> -	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> +	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
> +	defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
>  #  define part_get_info_ptr(x)	x
>  # else
>  #  define part_get_info_ptr(x)	NULL
>
> --
> 2.34.1
>
