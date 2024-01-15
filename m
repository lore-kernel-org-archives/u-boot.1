Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B70C4707B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F78B87634;
	Mon, 15 Jan 2024 14:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qmjCyhlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2BD8743A; Mon, 15 Jan 2024 14:06:23 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A0B87527
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F8tekd001615; Mon, 15 Jan 2024 14:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=tYo/tlvjZLyvVgfgeyg8IlZMDEp0+gUXNZPYL96Pt9o=; b=qm
 jCyhlVpKIrP3wNrRd4PdGFNCLfyFFWdgEsw9wyBMm7/2ITaAqbbqypkPlQAQCrDS
 6qZ69JbDi9GAP3nKjFZYHsJp1ydKTDyzUEWLD96ONXWtHoVTz/v55hYIYVsEXGZe
 qymoiIuOUlvw63DBzkw38+6pEFC8C5lLwihaJQjTlEs+bosjharv2MrUCwxL5Kpf
 bsVI4hiBvG99HYonCi2g7kPylPT7uda4EjISZ2LYmp+TsL1U7ZUp4hFgvaV961dU
 yQMK9esJIyAS7KZdEUeuk15yIf0RxdcarpZTrQJUfUVhkIQAF8hgeYMibG7l0yy5
 OZ33jwHq+0fi3W3gdofQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y4pcd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:06:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B03BD10002A;
 Mon, 15 Jan 2024 14:06:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A938C2815DA;
 Mon, 15 Jan 2024 14:06:19 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:06:19 +0100
Message-ID: <25b41d0d-63fa-4970-b06f-4d6dfacdfdf0@foss.st.com>
Date: Mon, 15 Jan 2024 14:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] configs: stm32mp25: add support of fuse command
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
 <20240115134642.5.I3c66d36ce7ac148b8d78855c73ea5f75ddde9b4f@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115134642.5.I3c66d36ce7ac148b8d78855c73ea5f75ddde9b4f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/15/24 13:46, Patrick Delaunay wrote:
> Add support of the command fuse with CONFIG_CMD_FUSE to allow access
> on OTP with command line.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  configs/stm32mp25_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 75f27c98b441..9fbd7eb15755 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -21,6 +21,7 @@ CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_MEMINFO=y
>  CONFIG_CMD_MEMTEST=y
>  CONFIG_CMD_CLK=y
> +CONFIG_CMD_FUSE=y
>  CONFIG_CMD_GPIO=y
>  # CONFIG_CMD_LOADB is not set
>  CONFIG_CMD_CACHE=y
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
