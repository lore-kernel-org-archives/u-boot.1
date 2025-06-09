Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D29C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FE2826AA;
	Mon,  9 Jun 2025 15:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LkVF4YyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D6482998; Mon,  9 Jun 2025 15:44:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F5F811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559CwQd6000352;
 Mon, 9 Jun 2025 15:44:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 BQw9Ma2myKr8mMDoyGRtuDFmDBiVileKRhh09WT6C9E=; b=LkVF4YyVJBoug8Ic
 zPqh88aW4ttkd1snR2u3q6XjQwQ2mTAkddThoxoY78J0KK4kt8YyIwMNM9jgDmcA
 Oag7Jt+midYu99kjGrjvzwG1FXdo5WOTcvP23AeoNRIjucnT0JZ1qOHvnpe/l1jo
 Pi04di6dnNAiTgoJ70SllsZkTi16qQbqArhpFg+vdr+Hop1AwYVtup/al5NngOOX
 Xz40oVz5E5ALEClxF6OkDLKSwXPYqwT1T1+9qidPyFcSQffATNvN7ZOEZiki2Y97
 6DuMX7qQoTP+c1xhYlyzscwsQdLVTQdalXMustdwYqSbtQvhNVuaqqoyz7Zmgs0T
 OVfAMQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474aum876j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 15:44:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F00E4005F;
 Mon,  9 Jun 2025 15:43:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B82A9BD0853;
 Mon,  9 Jun 2025 15:41:17 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 15:41:17 +0200
Message-ID: <5cf111d7-a209-4669-921e-10b6729cca26@foss.st.com>
Date: Mon, 9 Jun 2025 15:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ums command broken since commit c5d685b8993c ("usb: dwc2: Unify
 flush and reset logic with v4.20a support")
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 <seashell11234455@gmail.com>
References: <16f6e5bf-f7fd-4e5b-95fe-1388975484b6@foss.st.com>
Content-Language: en-US
CC: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <16f6e5bf-f7fd-4e5b-95fe-1388975484b6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
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

+U-Boot mailing list i forgot to set.

On 6/9/25 14:40, Patrice CHOTARD wrote:
> Hi all
> 
> Since commit c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support") on next branch
> "ums" command is broken, we got the following issue on STM32MP157c-DK2 and STM32MP135f-DK boards:
> 
> 
> STM32MP> ums 0 mmc 0
> 
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
> \dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> |dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> |dwc2_core_reset: Waiting for GINTSTS_CURM_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> \dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> dwc2_core_reset: Waiting for GINTSTS_CURE_HOST timeout
> dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /c2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> -dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> -dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURM_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
> 
> 
> Thanks
> Patrice
