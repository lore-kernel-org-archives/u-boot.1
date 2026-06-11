Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F8ECD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1D984975;
	Thu, 11 Jun 2026 14:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUkI1Vii";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NY32PINJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B378407D; Thu, 11 Jun 2026 13:33:39 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AF5838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xJua2890192
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=d/YJMdCXTPOP1aL9dPGsRcmd
 SP2HHOLFi5qr7vW8QA8=; b=SUkI1ViiVYji00k65aIaTa9El2rBP5hibLcS4gDy
 eLOOOqvFe5eoO6pZN98rGYxG2WI4MosGxqD1kiDczO0IbjiXllOzP9ft+Iu1NnZm
 GZ+a4sep/aVgRrEZK9HgEWPk/rzSHcbTgFHyBYW/g7TaDPM5QgEM62qhMuxboV39
 HbxSFCTv0BNLnLOJ4Oj0uMLrXge52WHXeofGYgPtpDVWDSQ6YebV0FzfAXDKvx+3
 1FACi6tYnPCkFuwjT39ts1vlz+1EY/DvO+hxi9yfvCR/iH011cBlvaLXrd44sb52
 PAvGwCa0IWUYfuM5hhBjvMw/lfl6YjVGQXIs/HD74R9oNg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79k4eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:33:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8428419982eso6862015b3a.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177615; x=1781782415; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d/YJMdCXTPOP1aL9dPGsRcmdSP2HHOLFi5qr7vW8QA8=;
 b=NY32PINJUVoXWZV8hDqBYRdlU4GW+XXWZh3eancckTpRujSHkfZDqTouDEToeA3Nf7
 yfBYreIlww820FVpWlLS5raopuomAnSLQrlQLoc0A5tFRuNryWCOhX9DH5+KHVLhwLzy
 yYN1PNRYz8vr7ilOlBQ9FQAIVGS2C0xi37rtZI7mbeor0oHl4fLGmc6FuucWK7y1KSNM
 HTUpSU2B5l3M8wAMR4EmsKXACgPisKsqJm22hlTpdtBsZjWuXIhrYYdMAtsgw0wDCL/m
 TvyXR76cvT9c30rU4vJN4gfql+uB5npQvXx2HsXp2fXapnJ5tnLOYLlI1prp1Pc9QelZ
 cR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177615; x=1781782415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/YJMdCXTPOP1aL9dPGsRcmdSP2HHOLFi5qr7vW8QA8=;
 b=A/Rb22tMBMaRz2TzQprK1+HzNyuyFk+BG/frScg/UGghmWGf4G4n/cdpGsqgtCA42Q
 s9DONhGSyYEGLLRVuPomImZdm2A2PL2aHj7FVOC7wmSHOlHeEc87IIsL4fWLGe/Yql6i
 ZBxBEF2i0uTxxPmAJjH623hzVlW+eDce7PMK+RmCQ47qfND93Ya+YmVGC9aGfnL1pb50
 UNNUA2yFdEXsKxaTMHdq4LJbBSGB3U+PhpLiIKsvhM48aX6IyDjHPLzrsgRXdF4EEQlQ
 6HKdfGeJt+69RxA8DAJnKiBoeTf5SANwlpF0CUmVTQB+tOGfQYJSPJ3Aru2URdahbsse
 uf/g==
X-Gm-Message-State: AOJu0YyVP3SQZ287DPqGDShA/U4RO+HxMR2ebfqMwMogkbSwalZoAbfX
 6BdyrxqCXo63TniH9nTy8CJc9AX0OIJlPsrBIKRCsEhU+hVgErjpCaYU3+MsgYEiVaCn0HQYMiH
 a9Ye6V1LHMTsFBr6NGu+t+4Hp/o9mZyyIVKgT1LNE06kd/H44V8kf1npD
X-Gm-Gg: Acq92OFRMFInRao5qstwU2nNXMUG6CxGzQuxRE8pl+Wumlj+5zBNpPKCehuHq9+V+sC
 ISfytCYsiSm6H5D5ylXkznBQsyLErzkEzOvoSfM0uTLi1sWsE6mY1JhIS6GTLYqKyECtUNSt11M
 PqfMW37QeU4BB/FOR5dZI3gW3Xb6/6Qv4XbGnFvOIxsmbG2lN1norvsCaXFLsAFvBeONQrGQdC/
 AEbP1/f+/ov3FRPhoH8f6h57KPOy5uQTMVEH7ZBV4kyq5xFUWmJOl4xU0Dotce4uEuehTXPdX+8
 clI49EqhjDuJ9A6HY8aQhUsYX3nCp+2z+RFEZ6ZoWcVH3lS6JjUzfW+xArW2F/58WLNp/dI1s+I
 wIXNxeJYEObEjfHcEUdtbwkd23MMd2ZN/WvOlmrhv2ALffPKOKZ8nNECOK/wOz9U5ox/MSGEIUE
 y8Vha7UIYNwTSysb/OVbIqDABjp6VSaLu+6NAOPyxey2R93gFdjDjDiP/fV6yf3w==
X-Received: by 2002:a05:6a00:9513:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-843367daee8mr2788575b3a.7.1781177614732; 
 Thu, 11 Jun 2026 04:33:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:9513:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-843367daee8mr2788533b3a.7.1781177614292; 
 Thu, 11 Jun 2026 04:33:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337bd0a19sm1960004b3a.21.2026.06.11.04.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:33:33 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:03:15 +0530
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
Subject: Re: [PATCH v2 06/14] spl: add UFS boot mode defines to spl.h
Message-ID: <aiqc+4tVU3cIfCGk@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-6-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-6-72fed24ef01b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ztEz9WdTiAcJKm-fnxfkOjebohCrZys6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX4dfhSWQM7dFT
 cW4SLVu27Ozt7sX9t7l7fPa7DFWBo3d0AdsutMApkEq4rf9TByFlXg8sjSnNnVtuXr+LsbSMVv2
 zBKdZRNpX0Ll8jPoYwyOtxf6k4aR6n+9LON+E5NMFDJA+gAqyF5n2/RYHLA2t/qpiWWM8axp8as
 R2SLFxT1fHCnXdrQ3BjwEJzJW2CS8JVO2hmlhYoxUIq/+PVtszpMkqNX54JXA9IqKEKotFvRy1k
 5B94lGBIAsME2kxk8Vnkbr7kNwUAbtDoR04pRvOoILjRoGz7XQuAuZR/8f2i7RNpcbw6U5u15j7
 Rcqt47VXWM/+pmWAai7BphZLGnDMT73mv5JrXTil/QJX3DISmBpsJRszHbT+y6OPnwjXVX05rhI
 +tVR24G9MvhzBWcaqQqYrARH9zJMzg4EUtsL0/YmmagyqK8MGnwNjcp1XF93uwnmp8dWNAtlWCc
 ++Y5dOmsBjBAeUsjuqA==
X-Proofpoint-GUID: ztEz9WdTiAcJKm-fnxfkOjebohCrZys6
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a9d0f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=G__5AvY7WKfxa4IQt1EA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX+p8IQTXLaN9p
 y3Z76HCtw/u/wSfoDCYm4VzueiSkGGV9Z6XLLN9xwXmJldCJvkVwEDjCcm+uAwiPbrIhUjh11Yn
 rl+kqIcfj3dhDXyiqRPiokCg8dSw71A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110116
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

On Sat, Jun 06, 2026 at 03:48:37PM +0530, Balaji Selvanathan wrote:
> Add UFS_MODE_RAW and UFS_MODE_FS defines to include/spl.h,
> mirroring the existing MMCSD_MODE_* constants. These are used
> by spl_ufs_boot_mode() to select between raw sector and
> filesystem boot paths in spl_ufs_load().
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> ---
> Changes in v2:
> - Added UFS boot mode defines in spl.h, as a seperate patch
> ---
>  include/spl.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/spl.h b/include/spl.h
> index 5078d7525ab..a617bc26c04 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -29,6 +29,10 @@ struct legacy_img_hdr;
>  #define MMCSD_MODE_FS		2
>  #define MMCSD_MODE_EMMCBOOT	3
>
> +/* UFS boot modes */
> +#define UFS_MODE_RAW		1
> +#define UFS_MODE_FS		2
> +
>  struct blk_desc;
>  struct legacy_img_hdr;
>  struct spl_boot_device;
>
> --
> 2.34.1
>
