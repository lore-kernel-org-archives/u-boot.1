Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4188FC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 10:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0B787E49;
	Tue, 12 Mar 2024 11:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XAcyW3vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA5187E71; Tue, 12 Mar 2024 11:47:45 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7456187DE3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 11:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C8Ebvi008429; Tue, 12 Mar 2024 11:47:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=pNVnSVyIrEHEevMamB3nh4clvFqBJjsbVjna3O5/ryk=; b=XA
 cyW3vdsDk2vjKbis4LQxMiSgH51WntAkqtgXtl4BBT/d//Wpn7ocSsOIpnuWZNMg
 +vUIraqhIJaoQ7nzkhl63J9KDsB4gmPBHkGhpO3JWmmwirIIdJxHAPuJNU0ePhb3
 WLrSyjaSGywG/bL5JK88X32LM3cErEFi/TZThFHPfUBMWmbrF1j16DJ4F8WHEY1+
 I/rXfWMm7kApEVzZQ2RHjEIrje7ozV4UDh4NxnYUW4XmMypq+GyCsGxm9zL3UQt2
 sYo2bTIZdgP1Qid4GowAZJ7MyV49O/gcZ/SAXGlwGQwnfgf8Zl2ATopVQc/cbdLA
 RrFnQpYnPyop++YM1HIQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wtd61t7eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 11:47:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 265B840046;
 Tue, 12 Mar 2024 11:47:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC8EE24E1D8;
 Tue, 12 Mar 2024 11:47:07 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 11:47:07 +0100
Message-ID: <97800223-2241-4367-b99b-5c7d1600ccc4@foss.st.com>
Date: Tue, 12 Mar 2024 11:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt_support: fix fdt_copy_fixed_partitions function()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
 <5b95fea0-581a-44e5-b275-09393b7b02a1@moroto.mountain>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5b95fea0-581a-44e5-b275-09393b7b02a1@moroto.mountain>
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

On 3/11/24 12:37, Dan Carpenter wrote:
> On Fri, Mar 08, 2024 at 02:34:04PM +0100, Patrice Chotard wrote:
>> Move variable declaration at the beginning of the function.
>>
> 
> The problem, presumably, is that when declarations are in the middle of
> a block then it triggers a GCC warning.  "declarations after code" or
> whatever...  The commit message is not really clear.

Hi

Yes it was my intention.
During code review, i noticed this "in the middle" variable declaration and always
thought that compiler will warn about this.

> 
> And when I built this file I don't get a warning.  Is there a specific
> config required to trigger the warning?

I confirm, i checked also on my side and don't get any warning.

> 
> Btw, the Linux kernel recently silenced this warning because it doesn't
> work well with the cleanup.h code...  It will be interesting to see if
> people abandon this style guideline.

So this patch can be abandoned.

Thanks
Patrice

> 
> regards,
> dan carpenter
> 
>> Fixes: 163c5f60ebb4 ("fdt_support: add fdt_copy_fixed_partitions function")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
> 
