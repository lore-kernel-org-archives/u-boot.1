Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11248C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 11:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432D187F0E;
	Tue, 12 Mar 2024 12:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZgoyaAt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0EC87F39; Tue, 12 Mar 2024 12:45:12 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9229F87D55
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 12:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C7rlAx011638; Tue, 12 Mar 2024 12:45:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=OCOBHxPAVfRUihThgmKQ59aQEQl5mxLkzFxkXkHBMBs=; b=Zg
 oyaAt+uoz8Ahog2V8TIhWCG9M/3d0mPzMXadaiIDGwL237WOZgrCmGLrndWPDu8f
 273SxzWnSh2Ofwo+35a504YjpndtAAzbFYl4VAL+j+txtPv5NrrVbQnip0KC+ufv
 VKKs6VJyeG6Xq8TeaGA2XTDIb5TIlk1jiz8ti7vLFyYTADVNQVpMNjTUef9iKTw+
 6NHo3NDF7NbgPwP8OAycW6rg4PZnUdz7/2K2dZ1jZrNVjoJ9ED2Y+zbfFzkq352u
 FsOItnq8UPPwog2SFxuc0/VXP7zDKUxY1peVwyhEDIwk2UjglYXmrUNiGvsmqgt8
 mu/+uEn4MZLltnfOOhqA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrg02n24h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:45:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B8414002D;
 Tue, 12 Mar 2024 12:44:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98F0726029A;
 Tue, 12 Mar 2024 12:44:17 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 12:44:17 +0100
Message-ID: <8a4d380a-4f87-407a-afa0-6a2786a6e527@foss.st.com>
Date: Tue, 12 Mar 2024 12:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>, Kumar Gala
 <galak@kernel.crashing.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240311193211.GA4582@francesco-nb>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240311193211.GA4582@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
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



On 3/11/24 20:32, Francesco Dolcini wrote:
> Hello Patrice,
> 
> On Mon, Mar 11, 2024 at 03:39:17PM +0100, Patrice Chotard wrote:
>> In case lmb_add_region_flags() is called with the same parameter than
>> an already existing lmb and this lmb is adjacent to its previous lmb with
>> different flag, this lmb is added again.
> 
> Is this
> 
> On Mon, Mar 11, 2024 at 03:39:18PM +0100, Patrice Chotard wrote:
>> In case a new region is adjacent to a previous region with
>> similar flag, this region is merged with its predecessor, but no
>> check are done if this new added region is overlapping another region
>> present in lmb (see reserved[3] which overlaps reserved[4]).
> 
> or this, related to some
> 
> ERROR: reserving fdt memory region failed
> 
> message in your opinion?
> 
> More details in https://lore.kernel.org/all/fe9431c5-6806-1b7a-f9f4-dbe97ee13bba@toradex.com/

Hi Francesco

I observed also "ERROR: reserving fdt memory region failed" on STM32MP1 platform,
the issue was fixed using efi_add_memory_map() as done in this patch :

https://patchwork.ozlabs.org/project/uboot/patch/20240308101230.2595220-1-patrice.chotard@foss.st.com/

Thanks
Patrice

> 
> Francesco
> 
