Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C98EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A037186D7D;
	Mon, 11 Sep 2023 11:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="W2lIo67m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC4F86886; Mon, 11 Sep 2023 11:53:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894A286D88
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76189757ae=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B9T7uj009467; Mon, 11 Sep 2023 11:53:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=O4EQaag1Wgr54B3G94P3wuisaAdFGBiccDYfaMI+oLk=; b=W2
 lIo67m5RkLLYkDyKIuuhUovCY3JGVUPdkuBJJATIhmWJKKLwQ5e4zusoR6VVXVUM
 CQks+ptoDT3LyjC9Ir2Bm1YcWRzcRqRytzgxpOYVbj30tQTRCT1a0JkgdPCCxosM
 esDvdPgZxa10VztuNYCbw3GbN2NB6G2rzMmHzShy9fBujOBFNYyKC+rrUsuhdn7T
 nDcoV9vSzydSTkmOtXH2+inHbQ6jYEjVC9EPN/2bizxsW+er1JcYg7OdOCv7YKWk
 LrPNaYRbg0CU8Q4/cI1VUwhvXWlT1jB6h8fjKKY5qIQ8dKMtbSr+ngwNHrFNPCOV
 6dxQDbKVGA3sVgedZhHQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0du50d97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 11:53:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9FC810005A;
 Mon, 11 Sep 2023 11:53:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3ABA23A16C;
 Mon, 11 Sep 2023 11:53:51 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:53:51 +0200
Message-ID: <1f6a2067-3468-5d9c-4579-f5958d81538d@foss.st.com>
Date: Mon, 11 Sep 2023 11:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] rng: stm32: add RNG clock frequency restraint
Content-Language: en-US
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-4-gatien.chevallier@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230907162200.205602-4-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
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

Hi,

On 9/7/23 18:21, Gatien Chevallier wrote:
> In order to ensure a good RNG quality and compatibility with
> certified RNG configuration, add RNG clock frequency restraint.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>   drivers/rng/stm32_rng.c | 43 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
>



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

