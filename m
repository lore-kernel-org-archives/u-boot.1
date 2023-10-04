Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E36E7B617
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948058752B;
	Wed,  4 Oct 2023 15:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1TYyTaW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3908755F; Wed,  4 Oct 2023 15:39:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176CD87556
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394AOMWA022604; Wed, 4 Oct 2023 15:39:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=c3Af2TXTYSbw5YqzOF+BNyaZQgqYJWXUklkvNFgfbyY=; b=1T
 YyTaW5ulZrcbzSQ756CjmdAnrEGiCsw2XBwIjQQOnCfhemsFOCerR//RFjejqFjC
 gxP/577RjKqsOBM0RbvGwSmVucP+I/qg7HMsvFjGeIvOwnFNETJSZLorqJdwZysh
 KnJ3PaS+C0r1Eaua1cuym5rrxnHw3/zSLHyvsJ8Cidta6s5XvqYHCKCw2BVl9D1+
 fGKUiTGQUacY6Smx1/Wz3vowLkZgMA5IIiQeU81Nm5Huiq0wWpnoRdMQR7jwghcq
 ltAxC5rmXmDPBqvr8rz2hff2323922X3+/qTAkXNNy9+ViFy1Z5n1SF3cfPad+n+
 vFdT0RB1HVnmtQsmCPLg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tggx35sdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 15:39:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3596A100053;
 Wed,  4 Oct 2023 15:39:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24E5324B8A3;
 Wed,  4 Oct 2023 15:39:10 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 15:39:09 +0200
Message-ID: <3cba2f3a-918f-2831-ffbe-e05fe3ccb4f8@foss.st.com>
Date: Wed, 4 Oct 2023 15:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Harald Seiler <hws@denx.de>,
 <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@dh-electronics.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230927124625.247858-1-hws@denx.de>
 <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
 <756093f5-d3da-eeae-9619-763e48d297cc@foss.st.com>
 <6334910c-baf3-4e6a-81b0-784f3dd372f6@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <6334910c-baf3-4e6a-81b0-784f3dd372f6@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_05,2023-10-02_01,2023-05-22_02
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



On 10/4/23 13:41, Marek Vasut wrote:
> On 10/4/23 11:19, Patrice CHOTARD wrote:
>>
>>
>> On 9/30/23 23:02, Marek Vasut wrote:
>>> On 9/27/23 14:46, Harald Seiler wrote:
>>>> Ensure that the SoM and board code information is only printed when
>>>> CONFIG_SPL_DISPLAY_PRINT is set.
>>>>
>>>> Signed-off-by: Harald Seiler <hws@denx.de>
>>>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>>
>> Apply on stm32/next
> 
> This all should be on master, since we're way before 2024.01-rc1 now , 2023.10 was just released on Monday.

Hi Marek

Yes it was my intention, thanks for checking ;-)

Patrice
