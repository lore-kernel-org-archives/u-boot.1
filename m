Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55237E6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA17E83C94;
	Mon, 22 Dec 2025 09:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRyBHiYw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UI8MQrfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43EE83D1A; Mon, 22 Dec 2025 09:44:21 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE67783BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM5g5aO2189489
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=f+1JwQzr8zCf4YGsBwfVv0RM
 IobwpHhGus36u6YvTnU=; b=VRyBHiYwWHySu48HdoDTJ7R9fe2Fv1Ec8Xu99hpa
 qwCsMGG1BSCOnCjEBw3YZxvQ+XzNI9wS8/WdhY2mpp3cglLXM3QvLyBUbxp2HHgI
 2Djw4nEk91u8FXWrKTZd70V8KkZ5DKtpGdQ4/4gv2lgdAK9gS4s5/RJSyLeQsMJ8
 12EsaoLqJcdrJpcUQrqjv7sgmlupe36jij/1jsTYEK86oRWDb0kKVLgKvdAe5JCx
 nFKFRiC4T9nXaud7hXLEUX8b2EbYCrdJu1nukubDGgToqIN36TnzO7mnmNDIfUme
 wlYaEVh9E1gla5TRpPff/Iiw/AqN0zXcES+kL8h5FOJgBg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b702t8hcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:44:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a07fa318fdso67357305ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766393056; x=1766997856; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f+1JwQzr8zCf4YGsBwfVv0RMIobwpHhGus36u6YvTnU=;
 b=UI8MQrfs1ulz+3+oKyDOFZPljNGzlelms3zlTbjOBMI39WGI/+FSIe1FVPO/Otw6sR
 FQQzDYeBmdAFMOBCaGHm6383bCkMFUGQwyurRMtTrdWX1PoeO91RfekkhRnoH3Q2J3+Z
 tmWvIuRx/OmlbkvqY36cYxtmwcegN+y0o3g6C26h/31HC8qqLWve3fRY57n6WMtuNh0W
 fZLqpqLyBQ4NfGmRgaf8ZdM1TBT7VngK+rDD01g09TjsPJh5dtSKM+eEc74Rg/xhisot
 fBGxKwM4jk9NDsS8IxyAIwmvjTy9P3QZxeSUqh9dEel7/YyjDPGaK1cjqxFvmVorX+Qp
 PS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766393056; x=1766997856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+1JwQzr8zCf4YGsBwfVv0RMIobwpHhGus36u6YvTnU=;
 b=K88UCHqrOdoIOPH1rfjDzynJFltKDEsQI1BR4qkZdUKDFMr6/wUslogtbr5pr15b9v
 gv/B9Dew3vBuwwOuNqMHv4DChlC5oHG2ePsimogEFrYtyuk5bwNaz4kOHOB+IHT28RSt
 mwWadNfl50AWtq6JlBGOc0rEPDPYeyzF8kQpgqYB5HMt176Lxb4tKbQPe6KMZpxViMUI
 gvgFhycYVn+MiWAHdQ6nshgZRJ/EdugjAAWES+ge6s3kiJ86vznFyCRZKPuqHgX4gkK+
 9BBjbY9i14B2gM+01fLjSJXTS4/Xu8EBG22xzH7moiFnoozevzl2SnM5yoW+qw9dfXsY
 ciWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIwVJTt+DHmAY6WoDFFvBY2uThkeYbjhsYjNQ4krP7ohtXY3lwjQ1Me45QPWd6a2dc9Buau5c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9TuJojGfB0Z6cYZV8wlq0q8sHn+o5Zv8r1FCrPdVJ0XS0ZGSw
 GfDFa3/wirUY2+Hr7gduEKf9YwtmDYfWlBfaY0P/jYgpKylIZFvNnO2mMlX56IVILgL9wxnRYYa
 N3JKuvrrhd+J8Ie+OQUQRhBA6eBgxPSw9KUa2i/dTDnFRh3fXcZnAg+DK
X-Gm-Gg: AY/fxX595hdJlCE0EO1iZ9XdsYrm00XhA57mryRd2aMOOBesThok/kEGTcSqAWmPYiu
 67lUxp3aerglO05FGszqrDzcJZ2VF1bkynQeTa9zHSf9e/MG+MX4mTJgBZ5dCNfY+KjwpT8XAf3
 dmzXOYmbT8O6T0TK753FC4/+7ZXp8/UwX0eZMQBk7pS5TXUTKTR02LQHAh43PpW5KwupbVOV3Bu
 mLIOFEGLjEAyM6/lF1y34TWfcdG0P+zPtK9HSwljprUnwjwTgNPf+Spfd0Qi19F/2x4dnmeKjQB
 hzZ4BraRY2LszJXBKuePfB/C1zafgMfoVRcQR/FpXbPfbjAxKYzUYtdLnNqB86IOCv8hAimVLTV
 28vEMp/c6aWh/Z2aqnPMvJt3BgqNuG8/6QR6aKdGNu8BBVH+O79GxiAjLRpab2Kq83djMOa6b0Y
 wrwQiy31jgsjbYcBD8rhA3TMjPhXdsIDIezTyhTKM=
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id
 d9443c01a7336-2a2f2212bc9mr112109615ad.6.1766393056185; 
 Mon, 22 Dec 2025 00:44:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8jyV7WXI1k02jIkki7aSweWNyXtR88E9w+U5PltAOYNWCBRsKtXJ1v5Tg55WLMSb+C5fn3A==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id
 d9443c01a7336-2a2f2212bc9mr112109395ad.6.1766393055727; 
 Mon, 22 Dec 2025 00:44:15 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c74490sm89604085ad.5.2025.12.22.00.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:44:15 -0800 (PST)
Date: Mon, 22 Dec 2025 14:14:09 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 4/6] configs: ipq9574: Enable fastboot support
Message-ID: <aUkE2UOHEp6LYN/M@hu-varada-blr.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-5-varadarajan.narayanan@oss.qualcomm.com>
 <aUVhRIWmfRHPnhRV@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVhRIWmfRHPnhRV@sumit-xelite>
X-Authority-Analysis: v=2.4 cv=SIhPlevH c=1 sm=1 tr=0 ts=694904e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FprwbJpvJ3V8Eb-ZiP8A:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: NDM06EspXmEAHVpVxHmWw1NURdg8bDQX
X-Proofpoint-GUID: NDM06EspXmEAHVpVxHmWw1NURdg8bDQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3OCBTYWx0ZWRfX+GSGePtc4/O7
 RhscPGxx+YnjjSd6ZQDBD+eDK+HVYksksG8BdX7p3CDE0P5Jg9BU4beIv9JnA8MR5QnHH+/9MSB
 9gGv3WkEVrtrkjYM3F3wAzBrv/jnYF1X+RZV2rUzGsK3S9mgtiV8vWwWKkJ4Fg1ou92T59KCkGI
 YTZZ916y/dXYxS013gW/Y/xI06hlr8Pcbl/GaFeonG18QlCQ2DA5C/6BWni2RWzOwkOhDGbxryy
 g0sPa2svnSOO709CMm2fNpRZmEcUIFys4JMpS3w2yJ59sx7xIkNSbXMzdlnEC2Ji5NTk2/LdWTi
 ErNPvStKH4rhelckf95ZV1KY9blUhofhLvvNUY1QW0mkWULOjCcCz/EHM3dHngRntCn+SzFjI3J
 /azSlHr5NhhrF0oxLw1HWRj+zIv4tAYpd70+TPjEmcWKNHTS1yD494iN9IxxQH+V8+mzEghweLu
 3QQQEcZ1kDCRubC+fUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220078
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

On Fri, Dec 19, 2025 at 07:59:24PM +0530, Sumit Garg wrote:
> On Thu, Dec 18, 2025 at 11:45:55AM +0530, Varadarajan Narayanan wrote:
> > Enable relevant configs like USB PHY, gadget, fastboot,
> > fastboot MMC support etc. to enable fastboot flashing
> > of IPQ9574 based boards.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  configs/qcom_ipq9574_mmc_defconfig | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
> > index 6592d9de39d..ac534738994 100644
> > --- a/configs/qcom_ipq9574_mmc_defconfig
> > +++ b/configs/qcom_ipq9574_mmc_defconfig
> > @@ -45,7 +45,7 @@ CONFIG_DWC_ETH_QOS=y
> >  CONFIG_DWC_ETH_QOS_QCOM=y
> >  CONFIG_RGMII=y
> >  CONFIG_PHY=y
> > -CONFIG_PHY_QCOM_QMP_UFS=y
>
> Any reason to drop this?

ipq9574 doesn't have UFS.

> > +CONFIG_PHY_QCOM_QMP_USB=y
> >  CONFIG_PHY_QCOM_QUSB2=y
> >  CONFIG_PINCTRL=y
> >  CONFIG_PINCONF=y
> > @@ -54,3 +54,23 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
> >  CONFIG_MSM_SERIAL=y
> >  CONFIG_MSM_GENI_SERIAL=y
> >  CONFIG_SOC_QCOM=y
> > +CONFIG_USB=y
> > +CONFIG_USB_GADGET=y
> > +CONFIG_DM_USB_GADGET=y
> > +CONFIG_CMD_USB=y
> > +CONFIG_USB_DWC3=y
> > +CONFIG_USB_DWC3_GADGET=y
> > +CONFIG_MISC=y
> > +CONFIG_USB_DWC3_GENERIC=y
> > +CONFIG_USB_FUNCTION_FASTBOOT=y
> > +CONFIG_FASTBOOT=y
> > +CONFIG_CMD_FASTBOOT=y
> > +CONFIG_FASTBOOT_BUF_ADDR=y
> > +CONFIG_FASTBOOT_BUF_SIZE=y
> > +CONFIG_FASTBOOT_FLASH=y
> > +CONFIG_FASTBOOT_FLASH_MMC=y
> > +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>
> > +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> > +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
>
> You should rather try to update following for fastboot:
>
> $ git grep -nr ARCH_QCOM drivers/usb/gadget/Kconfig
> drivers/usb/gadget/Kconfig:64:  default 0x18d1 if ARCH_QCOM
> drivers/usb/gadget/Kconfig:92:  default 0x4ee0 if ARCH_QCOM
>
> > +CONFIG_FASTBOOT_BUF_ADDR=0x50000000
> > +CONFIG_FASTBOOT_BUF_SIZE=0x4000000

Ok.

Thanks
Varada
