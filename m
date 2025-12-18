Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A58ED68BE3
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 07:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7D683C2B;
	Thu, 18 Dec 2025 08:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T66/aa+A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FqFpFh97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53AD83C72; Thu, 18 Dec 2025 08:08:04 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A5D83C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YdVR813864
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AGXAQvoHXnwAge2hoWfO/VgX
 u3T6Gx1rCLoWW+XjIRI=; b=T66/aa+A7GgcWmOjT8TpHNiypA0iI5FwC6eaL57O
 CyWWxjudtOv4CPVhAnpF5PpJqLXn8aYrU/c+Jn8g1vtytDNPAIi/rfJwGw8IvGe6
 Tewc3awW6bNwxFmtrozIpXdI61XboQ/s1K7yn/Ti5Cwo6tk9Vn2Bw9YjtkTFP9z+
 jnhrYOolsRhmF/srPMAv8wgsyiGfTJ3bXG31LaKxe9GeIxa7ke/oRltAsWSM3e4F
 Hmk5HXwprWJPGr1TxXn+ziBHTN3/1D5q5/83iGExwlq1gk5D634lIt0MKgPYWRSC
 kf/hP51RPBv4qpKekUTXnXcA653p+xHxH45dl79VBE6wwA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v7a099-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:08:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f26fc6476so5851355ad.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766041679; x=1766646479; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AGXAQvoHXnwAge2hoWfO/VgXu3T6Gx1rCLoWW+XjIRI=;
 b=FqFpFh972bPKETgIKLgDNj1W3lRYYn3bYldEVl4vD+KVGAilUu07trwdApOnDjBu91
 lQux9McZZJo+4gxiRUuDe+KCQmtoXspB45RWEQ5Q+Jf+3woOgDCfPeQpAdKCK2Gn2He7
 ZjHTuy1/id/JZmDPmOJm6gY6JUFugJfdjqslv8Tl/b1ejEcbOLR9Gov7POL2Ulwg5D9n
 DlfEF4F5RVXwM31Q91pEHzktxj8+4KRVZu7mL3/ikmU4ykC5dZ/tWkXEPb4yrtaWF7o7
 V/8NFXbdniSqi3v8tWlPAM0hJFBZ/wMmx7QuLKU2jBmiaq4VCmT+n562d4YzT+NeZEav
 zeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766041679; x=1766646479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGXAQvoHXnwAge2hoWfO/VgXu3T6Gx1rCLoWW+XjIRI=;
 b=p4RX9Qz8cfPE906hNr7alc5jF1/rnJhPwfWfHkVQ5wp9WUygKvv1AYmKlzotfHBf/1
 IwttsczpyvC/l2lRIciSjGhew9g8Ihq8FSTlrWUQgxetJpbIpVQDs0t887z63gSchLE1
 zmrubLfsvJ409VmTAuDdWxNc0d/WJ7rGUaMiophCKGVoNeznEdDM0J33BooWTXpje77H
 VVWlQW02xIbKWlfd00ERZUmkAfXAaaX63c3k1cSPNeq+enw7a7GLp1uN8l+v49AKVcZO
 USPJaKAlHS2cdoB5cVxw4Ca4hJfTu1hDOa3PtLmi7T9gCeDpCRmyUnLqXLpYLbBg8pdC
 fLpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWx42+coUtTL+1EnZd8QcVHX65kwZqptqTR4DmaRoPS6rFgR/srKBjXuEloXXsv3DY0Fl5x1M=@lists.denx.de
X-Gm-Message-State: AOJu0YyFwjHxfJbEzVtafv95GIdu+JbnKP2K5fzOkcQksM7TAvih1U98
 fvksCt82h9OMQ3JVSXT0avlNdGgCBfMULwmbCtBpcXITjlrgjgdxLN+X9YLEno9VyK1gOc1p0ov
 7AG7NnsgcRHw8HqA7Y2pbWgCl8c2/17W3wYP4PnVjRFf1tzW7blenq3+x
X-Gm-Gg: AY/fxX5gBxIIjwJL4ujCe1OF1ZX3+ggTxf0U5xg79P746OXb5cJUljRvtaTxzaSSccp
 6gz9EvooERoCgadUANKJpF3uQF9IZb9mawaBcTYlgO8s1VDdV6zVfG+GXdnvKh0UYwxVAUk69aF
 +W0rDiWQUSXY3ClqiuD2x6nnUdkH98S0XFlEGKhLgqqDtVW+ypaWKmAvqep4bLVblZfAgu5AsnI
 AboIr3I0O/vjyCdHTSLSudBY69aBnpwg9MUBUT0Wvid01yj8TqrN2vIwIWZuCwEhA2cLVX34ncw
 Ib+sk/6ZQ8whAYFPIJEjr+/ShVcMOLlYkyPqzG/q/fu4dUdSOPVBGFkYbVzja04fIpahRBvB3GU
 2JifqV/M4cdAqrK8Dbb8Tr5yeoBpaGjXtkqVNgo+MYCMDHOD8sLdsPoPsYsn+5rVF/XFkj3QLUS
 423kl7xtJ7x/L/DttO+FgOiRRWev9QPvMMme1WLss=
X-Received: by 2002:a17:903:2ecb:b0:295:9db1:ff2b with SMTP id
 d9443c01a7336-29f244ba061mr206370525ad.57.1766041679526; 
 Wed, 17 Dec 2025 23:07:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeSUpCrRNImEZbIuDvCXBImqpumP+hrHQC9aQ7DqPeLmZC22bsq5QLqqVkd3SlylGI0WINBg==
X-Received: by 2002:a17:903:2ecb:b0:295:9db1:ff2b with SMTP id
 d9443c01a7336-29f244ba061mr206370245ad.57.1766041679090; 
 Wed, 17 Dec 2025 23:07:59 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d089c430sm14663805ad.38.2025.12.17.23.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 23:07:58 -0800 (PST)
Date: Thu, 18 Dec 2025 12:37:49 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
Message-ID: <aUOoRUD1BfER0OfA@hu-varada-blr.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
 <20251203110735.1959862-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203110735.1959862-4-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: APEYExlgXUtdUaBe3faFmCm4KwiHJNCi
X-Proofpoint-GUID: APEYExlgXUtdUaBe3faFmCm4KwiHJNCi
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6943a850 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Q0aDSbY18svbEdDyDxkA:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfX6oAAIgg2svId
 iwpWsslr1Cc2j60rOkTn0mVWS3y+IqFvZvX6TZKlyCCKv9PR8ODoT9WcW/rNNaYbeMJNU/ubX1a
 tFMclOjIdZHasQ22XHj2o7LyEkClkdebVhG+/DN5whuHZTSf6mDGRkXZagfB9OA4pRXB+VbxAt/
 7wRQoIr5H+j0Jt/kKRgUjlroErapBOjrRT/7TX0x4Y8wzQDwv2fRVv/vBkCLWpa05SlYLnTou2t
 A0hnoQWFWbA46AVssqLsQEWKNlFvw8w123KGDFPujAaqtrl8zQl7NKzX1L2XGVuUydPZDFex9P1
 BDOv6+CMT+3wShKceqRp04CT5zCNNJ04raUNLh2UjSJiRP7MlL8wA3qAyIDFkkLv5I/c7y8RZ4g
 XuI3avQlY6aiNewHGwR2m89wpHCd3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056
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

On Wed, Dec 03, 2025 at 04:37:32PM +0530, Balaji Selvanathan wrote:
> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
> SC7280 and QCM6490 platforms. This driver currently implements
> USB3 super-speed functionality of the combo PHY.
>
> The QMP Combo PHY is a dual-mode PHY
> that can operate in either USB3 mode or DisplayPort mode. This
> initial implementation focuses on USB3 mode to enable Super-Speed
> USB support.
>
> Taken from Linux commit 3d25d46a255a ("pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750")
>
> This patch is dependent on this patch: https://lore.kernel.org/u-boot/20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com/
>
> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v3:
> - Corrected regulator names
> - Made regulators mandatory; if regulator not present, now probe fails
>
> v2:
> - Added pipe clock disable in qmp_combo_power_off sequence
> - Added all required clocks except pipe clock in qmp_combo_phy_clk_l
> - All clocks except pipe clock are enabled and disabled seperate from pipe clock
> - Added support for regulator power supplies
> - Added a minimal xlate to only return the USB3 phy
> ---
>  drivers/phy/qcom/Kconfig                   |   8 +
>  drivers/phy/qcom/Makefile                  |   1 +
>  drivers/phy/qcom/phy-qcom-qmp-combo.c      | 644 +++++++++++++++++++++
>  drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
>  drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
>  drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
>  7 files changed, 784 insertions(+)
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
