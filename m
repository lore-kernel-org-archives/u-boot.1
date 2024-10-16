Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E20D2A53C
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FDA88DD4;
	Wed, 16 Oct 2024 20:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="50ZK/NT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57EE388DDC; Wed, 16 Oct 2024 20:19:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6427F88DD4
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0019cf4dfa=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDWlXk011442;
 Wed, 16 Oct 2024 20:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 UOhz6TaqMQJKfNF2jOZ0xgysoE5O7+DZGplRdIL+xrM=; b=50ZK/NT4LEu/PYWO
 WNYJzTB2Ogq0OosczAS8h6IxVXnWfU/ID1YUhVRy4nO5fUhtwM2kRioDoFMz3e/K
 aOXgQeiGH/JvHXLexDYdHvTkcBvhUceshOhU+3Xx6SwvW6JEESNJFOxiQFvd3ek2
 SRKlRPjXGpatKz0bvEHsIubPErtptleGvrcdbDeUsQinbDqWuIdzbuk0ykEI6g0d
 jyHwsqlyoY8DfEVEZNcURPMt9eyTvMN/o2PwCVnAg2gsw207VXBzjJLjWsE4Rt8R
 BKuMhxk0ZUQhrMOpLI73x7dPdxqm4wqSgLkYVTBizH56PXaxdpscy/AujdZoo/PT
 Lytofw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 429qybex57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 20:18:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EB842400B9;
 Wed, 16 Oct 2024 20:17:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0839E26E52A;
 Wed, 16 Oct 2024 20:16:08 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 20:16:07 +0200
Message-ID: <e80ce86a-cfba-451c-be7e-f6c498cc66c6@foss.st.com>
Date: Wed, 16 Oct 2024 20:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: stm32: Duplicate cpu0-opp-table node
 into stm32mp15-u-boot.dtsi
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241005011647.436456-1-marex@denx.de>
 <4c1eabf9-5919-4a45-ba2d-4441e76a9bd6@foss.st.com>
Content-Language: en-US
In-Reply-To: <4c1eabf9-5919-4a45-ba2d-4441e76a9bd6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 10/11/24 19:57, Patrick DELAUNAY wrote:
> Hi,
>
> On 10/5/24 03:15, Marek Vasut wrote:
>> The cpu0-opp-table {} node does not exist in upstream Linux 
>> stm32mp151.dtsi
>> file, in order to enable conversion to OF_UPSTREAM, duplicate the 
>> node from
>> current U-Boot stm32mp151.dtsi into stm32mp15-u-boot.dtsi. This makes 
>> STM32
>> DTs buildable even with OF_UPSTREAM enabled. No functional change, 
>> since the
>> current U-Boot stm32mp151.dtsi already contains the cpu0-opp-table {} 
>> node,
>> stm32mp15-u-boot.dtsi is applied at the end, and does not bring in 
>> any new
>> content.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>> V2: No change
>> ---
>>   arch/arm/dts/stm32mp15-u-boot.dtsi | 30 ++++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
> ....
>
>
> Sorry for previous message,
>
> Re: [PATCH 1/3] ARM: dts: stm32: Duplicate cpu0-opp-table node into 
> stm32mp15-u-boot.dtsi
>
> I answered on V1 by error.
>
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick


Applied to u-boot-stm/master, thanks!

Regards
Patrick

