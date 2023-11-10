Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB0BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB378780B;
	Fri, 10 Nov 2023 14:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8OFPcAPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC7B877B6; Fri, 10 Nov 2023 14:23:29 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3263A8780C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AA9h8rg021917; Fri, 10 Nov 2023 14:23:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=3KUB27Bz1eGzx7Y/YLLWNww3hYlM7BCaUo9MS2Sv/ic=; b=8O
 FPcAPlY8ZHDaOe0IOqIYp4RO+mMLb3XdGoZz1/sRQWNTrcI6y4uwpoguS7fyncD/
 ilqN6fW2+wvN54Pz1brokOn6ybhtRvBUiLtAM/E/ehPz1T+HDh4cFdraISSE07p0
 R1oaOVUaQe4RSpVeTScuJW/Bq3DEad/68pESyP1AKFOiZRFLIzLUzpxfTCrtn7bz
 R82gp7zeDmTdGnwKwSNSsyqy3mnzbr4zlquBBrHqQndkwqWcJ484oDVlnKUZiwSs
 tJfnIfPLEj0Wds1n61TG1DAvyhRXzKfshm3xJ+VxDNAsIiOpFHCWr98ygOXefLJQ
 4cu/ilFoxYL9o2bd0Rbg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u84a5n1s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:23:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 516F7100056;
 Fri, 10 Nov 2023 14:23:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4ABF325E53F;
 Fri, 10 Nov 2023 14:23:18 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:23:17 +0100
Message-ID: <c34d995a-ba72-4008-a38c-0e32c1f89e66@foss.st.com>
Date: Fri, 10 Nov 2023 14:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] serial: stm32: Fix AARCH64 compilation warnings
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrice Chotard
 <patrice.chotard@st.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-7-patrice.chotard@foss.st.com>
 <ea3b3789-57ab-47d8-88d9-6aaab59c2b4d@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ea3b3789-57ab-47d8-88d9-6aaab59c2b4d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
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



On 11/9/23 10:15, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:43, Patrice Chotard wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> When building with AARCH64 defconfig, we got warnings, fix them
>> by using registers base address defined as void __iomem * instead of
>> fdt_addr_t.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/serial/serial_stm32.c | 23 +++++++++++++----------
>>   drivers/serial/serial_stm32.h |  2 +-
>>   2 files changed, 14 insertions(+), 11 deletions(-)
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
