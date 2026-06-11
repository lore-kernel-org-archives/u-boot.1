Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE77FCD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 10:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 469DF839A8;
	Thu, 11 Jun 2026 12:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELEc68+d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eS/xQrNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B8B83FEC; Thu, 11 Jun 2026 12:37:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12082838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1plS271463
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3ffogZMJScVO/onXoNFMXuSA
 fZc00b+4Dy/HSXVyiUk=; b=ELEc68+dqE1VM+1TlkU9187M/4k4t6f7HRrihQZ1
 ZDDRNK7wovhFrsP2BOkPmpK904wAXJWlmj5HIU6oVKZkLHImC7d1PIOmjT0dlQjo
 GO5D1SM/d1aWz4xmbADcwrQcb3FZiRDvSJNYOz6UnOwOjD7TTJHwKs5I8HQPG6jn
 wBWMMpErfTTxFQyaj2ejrkSrdPrX5XdYQgsOLqWhLWS+XjrolxIDLXFCzKwKojvG
 6ky+o4GOkK3DjUT6FjujzjdvpQ3mFE0hy0QYUzaXYOCyEEv4RjiVZ0brJ6lhjTph
 hHhuGmSWbJSkfI4QfgKfmrpCtiPqPtqdrajx9ACq8A60Mw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71k2kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:37:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so141709215ad.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781174268; x=1781779068; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ffogZMJScVO/onXoNFMXuSAfZc00b+4Dy/HSXVyiUk=;
 b=eS/xQrNER5+nF6bfFcyS5ZsK/ilhZ+wa0vFbJkMMyxKps/8Mvweh8yTLwwZOVpQpcg
 oNf2Iu3nLZmXuq6rxtboCigf0nQ8vJVacRZTm0Eg09qrn55SN6XLL5uRJxIjBCUQUmJF
 Ska+0ppmE/Irny+2Zs7M+aVqaKaRgfifwwRALSFxJoGepftZmzIKzvQy0EcUa1/KNC55
 ghofpF6QRepnniRzIjv6AVxOyUBkVftR/Je7Wl1IUS6ucIPK0Uhvn3E0TM2wOg9WqYaX
 C0q0IoPnR1YW1dcZjc3r9JKG5Q24V82cykX6HzzcsXbYKukECSjhnYCCtLZeVj0O0sIU
 ollA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781174268; x=1781779068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ffogZMJScVO/onXoNFMXuSAfZc00b+4Dy/HSXVyiUk=;
 b=msau1dl5MD0hFYaFZ/qwtKudZ4udJu9EW+HnPY9v8R/mr5GpnnQFCfrIJdtMCoBdOK
 nA1JNsFXHwDTl13w3ggjZ9VIRVX7/V8W64ZEdSCkcP+5tfez4RQIISt3bGxIvOsBluYX
 NEj9b60nlz3ExjE9Mchp8qhezJbPQMQqQOYTc7AXL+AZtRlEFLdC1jmbWT6plp5ux3Wp
 yQMJxMYEOo4pWqXvoPgh9ewH7USO2TVTKpSuoSfd0xU0rls7g/6tpZFkPAVJOSP55Hbe
 GdZzSkdLofTUAx16DtysYoew1kD1LoH9wyiKFhlos6rrDpplmAhT2o1jlW3LoJcTxTqJ
 mplw==
X-Gm-Message-State: AOJu0Yz4J3fX65nZuus351rDDM/gRNgQpRtLBOTTdvWimUDjm4TcExKD
 EqkRD2wlQtUVmWtLNm0Ml+L8/XWJDCYgojlRwmPAygaoRX3hnBjX+vQwCcC96zecJOcMWbRHZMD
 +S+c3nkHIIkrNyq41+pgGgF0ZHsBATUA6ijrq0ihZh8/B5yPGt0ya7Bty
X-Gm-Gg: Acq92OGQ4UCpc6suZFoNxeT8ZatyKf/P4IFswIhV+8d5fR5++WmXX61HUZMQ1HM9Vtn
 519Wx30AL4i7fDGtAStdroz474Q+eCkWrjerKEwwgb2caDs6yLzixVopHVVsd418bkFhConGy/e
 +D1+I6MTqBGaaC3bMJqK6dZ3SP70IipXLxjsvEY/wX55PsyX8un1D2AazpqSRzrFx2q5SOvAtwy
 /yHQMCPkYP+lmBl2v0HH9zWA0X7W56G1QT3/TbuM5jCAhQiK5muLxGW9zqb2GMFa9hYwUqWeURG
 Le9I2ycLw6kOZPs4chu2nKCwoipBaJiq7jV8xcMHygXXrCOJETw3WhSnNPsWec2TrzfL6+KC5uP
 snBtvWN+4sBHzPBU9S6kvhTNmZxReNgI/dUHhjullkPg9j59RpgJi7tfypUUm16BBX7eKzDjvcr
 Hte4OwcbbesHX7WAF0y9hOo1UJFet55FNxg4Ul3xNBI3sy78SbHFt4PKGXw4nNJw==
X-Received: by 2002:a17:903:1a88:b0:2bf:2e06:2ebf with SMTP id
 d9443c01a7336-2c2f3054645mr27800195ad.31.1781174268324; 
 Thu, 11 Jun 2026 03:37:48 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2bf:2e06:2ebf with SMTP id
 d9443c01a7336-2c2f3054645mr27799615ad.31.1781174267843; 
 Thu, 11 Jun 2026 03:37:47 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649fab9sm274959055ad.79.2026.06.11.03.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:37:47 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:07:36 +0530
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
Subject: Re: [PATCH v2 4/6] soc: qcom: cmd-db: Allow boot without CMD DB data
Message-ID: <aiqP8CIzwdL37DMO@hu-varada-blr.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
 <20260608-snagboot-v2-4-036bb0343bf7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-snagboot-v2-4-036bb0343bf7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: DHt4ZzYiF7c0wBXsxOW82Six6Xwmh5Y0
X-Proofpoint-GUID: DHt4ZzYiF7c0wBXsxOW82Six6Xwmh5Y0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX70TSPfIGmcap
 wypM1bFJsFKlfknDhnbUsmJaVr2ADsGbJ8ZXs3KCVGeInZKCQ6c7xcMQBAqwjCH/GARHz4mTvBy
 veVvp0bWbPgHXFiKKWA8yajRv1wZa/nYCB7al5KrESz3XyrINHjDuTPBCiFYkVTpNJVfPDn2BD3
 ogp8XMRBjTpvVRQO32pVAqM2eN1G8TRGJaV/yUMhUpwlIOK74SxQHqkgUWQnVQgvCwg69bFdP3W
 fdyGe1RdNNcCNpFTaW7AOEXHPNLKPkTxmzu91mG+nFoVe9GMb6TOL/t/AnCrUbi1qB++n1Xi0e5
 G7Dkc92aDRJWmsQmXs7A0ryq3IFvaMJ+n1vdGyTb8t+09JuO1RHS8xKen4QObZiA+piowIdaa9r
 aJaCdCJ/30ruCDx8A0b2VG/pxakmU0Cibt3/mdGIb408/R4KemN8AFuzlETcP86FSu4CvlSDX6/
 npEnDtoiKcZDLKtPZaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX8OJd0A2vdVjc
 FITA40s7lSQGLtUEJKkP7lzz+FM8lsdXBjKc6s6HM7d+tQ21ooTXXGerNZ8n0n2jE6UzPBOvjuh
 j6vhn77jdRYCRxQwtpeoi1q/MByQsR8=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a8ffd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=3CHEZ3LMdpUmoafmjakA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106
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

On Mon, Jun 08, 2026 at 02:36:31PM +0530, Balaji Selvanathan wrote:
> In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
> The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
> boot even when CMD DB is not strictly required.
>
> Add QCOM_COMMAND_DB_OPTIONAL config to allow the driver to bind
> successfully when CMD DB data is absent. When enabled, a warning is
> logged and cmd_db_header is set to NULL, so consumer drivers receive
> errors on resource queries rather than preventing boot entirely.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - No changes
> ---
>  drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
>  drivers/soc/qcom/cmd-db.c | 10 ++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8243805e46a..239d87e044f 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
>  	  resource on a RPM-hardened platform must use this database to get
>  	  SoC specific identifier and information for the shared resources.
>
> +config QCOM_COMMAND_DB_OPTIONAL
> +	bool "Allow operation without Command DB data"
> +	depends on QCOM_COMMAND_DB
> +	help
> +	  Allow the Command DB driver to bind successfully even when CMD DB
> +	  data is not populated or has an invalid magic number.
> +
> +	  This is useful for platforms where CMD DB is not populated by

incomplete sentence?

-Varada

> +
> +	  When enabled, missing CMD DB will generate warnings but allow boot
> +	  to continue. Consumer drivers must handle cmd_db API failures
> +	  gracefully by checking return values.
> +
> +	  If unsure, say N. Most production Qualcomm platforms require
> +	  valid CMD DB data.
> +
>  config QCOM_RPMH
>  	bool "Qualcomm RPMh support"
>  	depends on QCOM_COMMAND_DB
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index d0a6047b8a6..b4682d811f7 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
>
>  	cmd_db_header = base;
>  	if (!cmd_db_magic_matches(cmd_db_header)) {
> +#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL
> +		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
> +			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
> +			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
> +		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
> +			    __func__);
> +		cmd_db_header = NULL;
> +		return 0;
> +#else
>  		log_err("%s: Invalid Command DB Magic\n", __func__);
>  		return -EINVAL;
> +#endif
>  	}
>
>  	return 0;
>
> --
> 2.34.1
>
