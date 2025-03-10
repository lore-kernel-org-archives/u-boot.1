Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3781AC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CCA81430;
	Mon, 10 Mar 2025 11:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7uOjRtxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D95681671; Mon, 10 Mar 2025 11:15:32 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367EA8142D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5164540d7d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9G8ML017253;
 Mon, 10 Mar 2025 11:15:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 fIF9rnF3d2Ip343I+DIftghSxlEVAiOjkSJvoJuSFf8=; b=7uOjRtxhPCNay7cC
 6tg5GiLN2yBApahH/snJacRgn8CN3ZJjuDOdqu7Cwgh4wfxPCeaY7YpD9RrumI5F
 pphi63/06trpahQ5W6DQLHi+yGSbEZnv7hZcNqommG/lL6OkNS5W7GQwhEuCw636
 OOe/O669GnivWQWJRVqdYbOKEvbw6vv+jJrV740UyGSXWBZgcy5oIjQl5NSyOJYb
 gTPW+bYAWK34UdnQoxEzhWxtBt89sS+3ong9yyBLsEQ/vhIi5gqbgky/u3IaO6Xu
 nmBB5elt+9ERqirHQViCegCo8P/g6AiJFE4AkW3yxxikUMj/KwxtWYVtG/5B4tdG
 IMAUPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4590b8uuke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 11:15:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 65DA24005C;
 Mon, 10 Mar 2025 11:14:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4053657CF3A;
 Mon, 10 Mar 2025 11:13:14 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:13:13 +0100
Message-ID: <34d7dc22-4a06-48df-9e44-1729b11758c8@foss.st.com>
Date: Mon, 10 Mar 2025 11:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on DH
 STM32MP1 DHSOM
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
CC: <u-boot@lists.denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250221170851.184893-1-marex@denx.de>
 <20250221170938.GM1233568@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250221170938.GM1233568@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
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



On 2/21/25 18:09, Tom Rini wrote:
> On Fri, Feb 21, 2025 at 06:08:38PM +0100, Marek Vasut wrote:
> 
>> The environment is missing closing quotes for string variable, but the
>> variable is empty on this system, remove the CONFIG_BOOTCOUNT_ALTBOOTCMD
>> assignment entirely.
>>
>> Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig")
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
Applied to u-boot-stm32/next

Thanks
Patrice
