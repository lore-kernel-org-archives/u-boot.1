Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104ED68BED
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB11583C94;
	Thu, 18 Dec 2025 09:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvAjgyyE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0HcvWJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D2F83CB9; Thu, 18 Dec 2025 09:06:17 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DA983C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1Yjnk167749
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=G2d5+nLcQwRPPciddjJvO20d
 Kowod+7/PcMa2ATiL+o=; b=XvAjgyyEMZ3UMY9b6b4Ct3k36+uwn2j4vXoTiGNN
 0L1e08t6PG2jUfmEfGHFJ3vQVyBgijqbXb12m4uLcN/x8fq7UJlflfVydvUIuPPH
 dnEyLU1twHkgijXScxsYicEPo2mStTvdV46pvZMn2FNr6LbOSFbvF/FxMwGhl6gy
 v8wf7Mlj+IwaYv0lW4JU/50v6d0p0GO4t93B0JXcKTAC3dfuV4lPNXC57zkIoLAS
 dfqhd+0YGJkCm02npGQNEuNG4dmk1xZ0/06ke/ZtephLhdDPeoMd9NXghRRDQhoU
 S0npWBzfYlN4+yqS3XdP3wHXvOLANz0QuDe6ogtpqTresA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45w51b31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:06:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7aa9f595688so737597b3a.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766045173; x=1766649973; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2d5+nLcQwRPPciddjJvO20dKowod+7/PcMa2ATiL+o=;
 b=Z0HcvWJzMNa69X0fqDHFPMRrsAt8KtfGHZR3tAcZoU4k3TMobOQceJSLi/ry4H2FOE
 aXdWksxDBgfSCDxVru/O/PfKzESfSWb6s8dPfTfhhNANXoCRdjFMuNNpaGSwjXd8gKOF
 232xUg+OUXT6DgIRUask45k4otC0sqxk1AXur4ybeQwTkxRXylIPaCX4MWjSj7BUXt2t
 jJ4KFB0hVtGe6URXzWLCejR4fdvp6nZRZtrxg9HCplRX8EyxeES1N+HECTv3yhgnmAtj
 bS4JY45Avt4q5SeG2AspfzldFBeJUAqJM1eOsJGqmHDhg0gCsYFcFxLvOkPtA0vX8lHS
 HYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766045173; x=1766649973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2d5+nLcQwRPPciddjJvO20dKowod+7/PcMa2ATiL+o=;
 b=j12hVmivhV4FG2tDUv3rEgW1Nqmtpp6sYOC+G3Y2SDggFkboJqNThdvDLDtdePMi6j
 Ip4wpmyDxOSW34oV93/87TAXT82lKunmloqrKTOJZ6p+awyQuccI4MF2H+ArXcUsLN1p
 QGWfIgtL2rtZI6mNf5qIpf/uqdnBl8/m4EKFuTfaxMjGsLSljCsvs3j4QqIvzxhsXcuT
 pmwRZjGsR74v3oiLHj8V87sfCy1tGM9IiDgjwBW+27qgnSrDngm30ZnkvWbSPptPgRFR
 SKxxeZjxzYbtVdYsN3QvXDLPqxkUsX2/uhS4HugTzOG3bP4jyX3CdmdvjBTkOe8c8Lk+
 tNAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAgMvoQbexNK9qUS+/UZ3vZdonjAiYjasMpl8n2kDmRZCLZ0Q3e8EBnI53UT7Y0xlhOfQFXAU=@lists.denx.de
X-Gm-Message-State: AOJu0YwyoAirSKinExTpCd7RIGq3HTslXTOnZiCmo+8KaS+MvuhJjntG
 oF5p6Eg5MvYDuq4eh3Xkpcaz1WhCjebVBzGEs/R6+Ir9AIGAADHZ5RE5YkfBWKvkZWWGrqI0Xld
 0E7X1jD+DUVxnZbOUMbJG/jGgjJwYKuHSyyxSTe6CMO5qieGEfIMjGa9X
X-Gm-Gg: AY/fxX4T/ED8bpxDQLFkjw+qS0wusP6Eyd0GfR1tpgzBrTNwNvC5U9glqcRz9DVECxf
 xA9bhYYBD17RdKE4bBDZ7heLAERFfAU3A6UWQPyuu5+BzczwK5Xxe18q1Z1Am4W/rzNikH+xLvQ
 Mq0y/hept56jFVIS5uKls2dftv7I7GfOdfOe6kBNeE6dUUhoiNjksvsoRROi8f+nQD9LWS1N4rv
 PiIhiWeFp1B9mWAA/Az3EiW0GpiKE0kBDMYFXwBa0tDAWcaPc1oz6jpEW49CByvMEB9y+msAgH5
 Din+TZ3C3P0vGCTkuYDWZa07Pttv9kICvPlrw34S/9O2ZcvzkwdZUAKZygmUzmGKUsPyt/RxCAl
 Ggp0r/IHqVPeqWFQu8ha/lEb3fK/Uy1N/v0c1Ay0afYO5ZhrueMzNBrcGwPpSu3z8FARyT/UtBi
 meFV4vop0TBrOiCDU2YBWceIcLArNcnmJFo5R4eJU=
X-Received: by 2002:a05:6a00:3311:b0:7e8:4433:8fa8 with SMTP id
 d2e1a72fcca58-7f669a9369amr19103831b3a.48.1766045172918; 
 Thu, 18 Dec 2025 00:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl5TpF7cF029di2jRyNnqi8uNYb6DJVEYSfTGcOstltTLlsYMHORVOl6DdASIB3M8ND9a/zA==
X-Received: by 2002:a05:6a00:3311:b0:7e8:4433:8fa8 with SMTP id
 d2e1a72fcca58-7f669a9369amr19103787b3a.48.1766045172442; 
 Thu, 18 Dec 2025 00:06:12 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe14179645sm1746137b3a.47.2025.12.18.00.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:06:12 -0800 (PST)
Date: Thu, 18 Dec 2025 13:36:02 +0530
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
Subject: Re: [PATCH v3 5/6] configs: qcm6490: Enable super-speed USB support
Message-ID: <aUO16hjr/fSgtZnq@hu-varada-blr.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
 <20251203110735.1959862-6-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203110735.1959862-6-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: quvjB3-mVOJpYrxMeEE5_W1Tzrle2KQi
X-Authority-Analysis: v=2.4 cv=eKceTXp1 c=1 sm=1 tr=0 ts=6943b5f5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DvA_g8EdwWjvh1yinrcA:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: quvjB3-mVOJpYrxMeEE5_W1Tzrle2KQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NSBTYWx0ZWRfX9k6nn1kUPG7v
 iMCs9dIqXwXJRfA76STU8s11vVrkd9nXlco3Pq6q8wVpYuVSK7Q7HhPTH2GwcaubX0wT1K1EOwn
 Q7+fcwJeBqG51Qw1ebIWCxzOOzOopHaDUjmmcUwxQfP98qaeDFFWD+rcDaFOIqJnQZFFn4Ab1T2
 f7dhlRuaVSIqqYv8qxUh2o+ntwc1FOtPm4FpJhj+Zw2RR6CgJIy85ED5kA8nbIJfZZQPACuKyKw
 r+HdOQ09h5aQE6BYEohE8DhHOPPCp6Qbn4SyJzKyVNHIsDW+/1/5j8EarNMmW/0mudNskmIJ+VN
 ZUlakrY78rNhAmOC7mKxWoI4D5KC7LH0QMUY+x8ZwCHyMUqOZNc8AQGyVpsLNWmXOG6l+MoEjnC
 L7w/CZucDwV3lwbQ3yhlm0dFXC/InA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180065
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

On Wed, Dec 03, 2025 at 04:37:34PM +0530, Balaji Selvanathan wrote:
> Enable the QMP Combo PHY driver to allow super-speed USB
> operation on QCM6490 platforms.
>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v3:
> - Removed disabling CONFIG_QCOM_USB_FIXUP as it now removed.
> ---
>  configs/qcm6490_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 54eb5dedaec..2418645003e 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -13,3 +13,5 @@ CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +CONFIG_PHY_QCOM_QMP_COMBO=y
> --
> 2.34.1
>
