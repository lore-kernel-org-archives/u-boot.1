Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C058DC10F15
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 13:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64CE88840;
	Wed, 24 Apr 2024 15:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BtohNmEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B3088841; Wed, 24 Apr 2024 15:37:27 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A468883F
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 15:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=484434c3de=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OCE9Nj004066;
 Wed, 24 Apr 2024 15:37:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=kIyAcFRXq8ug/cyFLxav8q0LyDP334VdLuUEZiCkf4Q=; b=Bt
 ohNmEEPRojhGn8DAQ6SKJZTiJ0951iy5Ujq6/3XfRyhOR36ckb71Q03D4zewQ9ew
 c84Nmxuw06tM2CqGVFLHbQn5iAeQ+UDS6uuIV8FnDyWAOY2tknjlIQcAoIv6RIc0
 MUIJfyw/FEccEfkDlMs4i7udTEntC6iJw2s5eVhWp8EPzrW07BNp88TILC8xnLRj
 ae+vCbzb5Ra3w9l3maQCxLlTtnPVPbRt2sXn10AF7aLBgS+tKpOh6427cDnl8sNI
 6eG/OQblne4t2jx2k3tPzqcRe6kTpII30yuAxncf01EP4EivE0/5k6MYD+8apspt
 E4ASgnfZxEgGkbLl7MYA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4ee07w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 15:37:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F12934002D;
 Wed, 24 Apr 2024 15:37:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E46682207BD;
 Wed, 24 Apr 2024 15:36:48 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 15:36:48 +0200
Message-ID: <ed05aee3-f24b-4b16-b59b-4b9f6597db44@foss.st.com>
Date: Wed, 24 Apr 2024 15:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add PWR regulators support on
 stm32mp131
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240319024534.103299-1-marex@denx.de>
 <b8089d71-42f1-4cb7-9b5e-e3cd99e9ffa5@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <b8089d71-42f1-4cb7-9b5e-e3cd99e9ffa5@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
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



On 4/21/24 22:27, Marek Vasut wrote:
> On 3/19/24 3:45 AM, Marek Vasut wrote:
>> This patch adds STM32 PWR regulators DT support on stm32mp131.
>> This requires TFA to clear RCC_SECCFGR, is disabled by default
>> and can only be enabled on board DT level.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> It seems these patches have been missed from the recent PR ?
> 
> Is there any feedback on those patches ?


Hi Marek

Yes, these patches was voluntary suspended on our side due to internal discussion.
On my side these patches are ok. They will be part on next STM32 pull request.

Thanks
Patrice
