Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88DEC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A5882C7D;
	Tue,  3 Jun 2025 19:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Q/Uk7whW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A352982CA2; Tue,  3 Jun 2025 19:27:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8460782A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Eku38019273;
 Tue, 3 Jun 2025 19:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 zMQFbGFlf1dYCmjNSb87cRzEEk4UJiMAbuVeCGA0z/0=; b=Q/Uk7whWPsRASaHW
 xUOSaUHypcxV0SCcUJh7HSK7YBEbGxduw7Sd3kTd0bfv5g2niZAfLDpnzKS3/hGp
 ZKof0rCw3XpKuHPm1Z5FUlk7IDOg8k9//GDsg4HOLjD88zhKvWy7EhGQ8ZHQ6QWH
 rAsCCUkLb9AtUXST2Cl7mytYeA759xxX9dhRfBKvDH+Py9DY/LW7oIa7/q9CQyTg
 V3hkIgGlKfWIbZ9QltYhJn+sWSExT+fVKk0q/3lgllExWepylQ+aO0adKZMyNIaT
 cHHItwTC8opVe5LOX9GRmqbQkSodDLuaR4RHACogkaNIVKGn0Vep4qk7Xy414mGW
 Hniiiw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g93dbtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 19:27:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2F5B040045;
 Tue,  3 Jun 2025 19:25:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D75D4B5606E;
 Tue,  3 Jun 2025 19:24:18 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 19:24:17 +0200
Message-ID: <bd87fe8e-6ba6-4de0-9b6c-ed95ee35b9a6@foss.st.com>
Date: Tue, 3 Jun 2025 19:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] clk: add CONFIG_CLK_AUTO_ID
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Alexander Dahl
 <ada@thorsis.com>, Casey Connolly <casey.connolly@linaro.org>, Gabriel
 Fernandez <gabriel.fernandez@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>, Marek
 Vasut <marex@denx.de>, Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250527132755.2169508-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
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

On 5/27/25 15:27, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Add a new config CONFIG_CLK_AUTO_ID to support a unique clk id
> for all the clock providers, managed by clk uclass, when the clock
> reference arg[0] is the same.
>
> When the CONFIG is activated, the clock id is limited to the lower
> CLK_ID_SZ = 24 bits in default clock xlate function
> and the sequence number + 1 of the clk provider device is
> added for the 8 higher bits.
>
> We use sequence number + 1 to avoid the "dummy" clock id = 0,
> used for invalid clock when CCF is activated.
>
> When this config is activated, the new function clk_get_id()
> should be used to get back the internal reference to clock
> for the each clock provider.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>
> (no changes since v1)
>
>   drivers/clk/Kconfig                | 10 ++++++++++
>   drivers/clk/clk-uclass.c           |  9 +++++++--
>   drivers/clk/stm32/clk-stm32-core.c |  3 ++-
>   include/clk.h                      | 24 ++++++++++++++++++++++++
>   include/linux/clk-provider.h       |  9 ++++++++-
>   5 files changed, 51 insertions(+), 4 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


