Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4B8C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4075482AA7;
	Tue,  3 Jun 2025 19:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="N6/MwGCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AFE82AAA; Tue,  3 Jun 2025 19:18:34 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6376C82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553G7d01021217;
 Tue, 3 Jun 2025 19:18:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 0/UKU+OLY1C9ZzpB+/n6RlwQPK2uNlq3tnk8qBIEA+Y=; b=N6/MwGCu6Rc/vym4
 Tabsc/kXfLpKOu6h7VCZgO/XLiuh9DsHFH+eENH3OATF+FZba4d1UHOx/dYUpJAB
 lWpb0Yk7xrxLudhBw4Xas0O95XYwfGIIfHDBkLKKZZtb1VOYWxHgo8WxCyA76Ucv
 YxIH6rITl1NVwgGhETNitkGIlssswzfq/gK3kBd6zL3jI2QIsAPBv0rfbiKybU0/
 LCFDuCFs7ZWKDiSmG9YIGjpXzqwcSLh5CL2zDx7MDW+zG+3wrOK2tYRByI/MYkeQ
 F8FMrxJdtyomClp2bA03MElGs8RJPso4M4urv3mdiZ6pvlw/eoBBrnt7FJmBhzUX
 pKHnPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8sw769-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 19:18:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9A20D40051;
 Tue,  3 Jun 2025 19:17:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E93DB4AF39;
 Tue,  3 Jun 2025 19:17:17 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 19:17:16 +0200
Message-ID: <7b238ac9-aa6a-48cc-b4a2-0dcbc84c73f4@foss.st.com>
Date: Tue, 3 Jun 2025 19:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] clk: stm32mp25: implement clock check security
 function
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, Valentin Caron
 <valentin.caron@foss.st.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250527132755.2169508-4-patrice.chotard@foss.st.com>
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
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>
> Check clock security to avoid access at boot time.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>
> (no changes since v1)
>
>   drivers/clk/stm32/clk-stm32-core.c |   2 +-
>   drivers/clk/stm32/clk-stm32-core.h |   2 +-
>   drivers/clk/stm32/clk-stm32mp13.c  |   2 +-
>   drivers/clk/stm32/clk-stm32mp25.c  | 449 ++++++++++++++++++-----------
>   4 files changed, 286 insertions(+), 169 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

