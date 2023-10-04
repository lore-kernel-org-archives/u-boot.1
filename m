Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68F8E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B243A86741;
	Wed,  4 Oct 2023 13:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="a7hdGQgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D404B867D6; Wed,  4 Oct 2023 13:57:01 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7297865ED
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394ALo4A026794; Wed, 4 Oct 2023 13:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=FfuhDUq8QmvdKIFp47kdWb8P2pvA4VHekfhecBJPM+8=; b=a7
 hdGQgpTdDDTSIA+QvaTup/pLUSfDOmfrZmYiShXuzlzGYFaWxDswhm9UQCAM7NXL
 WiaMfiuM1a+KTeav7JFtlK5ikWuhftp7oMIjfNU44BcowGeBFuLbGv7DWTXCLZTr
 Ui2IVye1bAgHcVzAimoYiKEDcnkYaEuY6jsIOOTOLA+t2AbnCIm0UOQHo7ERnN3H
 gWNUkEQQzASV2l5QR49SQK2zaSDWfdC8KxdLJLsBCzHHaFEVfzfbL04UHtdMcMlx
 ig4igHm6NgNUJvBI1Eq1oylVMFE8/4WAk5q8gXsiuCtOx8YR6QrilqXjmqDpt9P0
 uHWtc11t/LOaZFXJZJDw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tew80pge0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:56:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0F13100053;
 Wed,  4 Oct 2023 13:56:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D804A235F29;
 Wed,  4 Oct 2023 13:56:55 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 13:56:55 +0200
Message-ID: <55910f71-d7ca-bb3b-1611-10cb53b07da9@foss.st.com>
Date: Wed, 4 Oct 2023 13:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 6/6] board: st: common: cleanup dfu support
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-7-patrice.chotard@foss.st.com>
 <8a5daa34-e50a-2f2d-7ce2-9879e64e881d@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <8a5daa34-e50a-2f2d-7ce2-9879e64e881d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:57, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/26/23 17:09, Patrice Chotard wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> split the file stm32mp_dfu.c in two files to simplify the Makefile
>> - stm32mp_dfu.c: required by CONFIG_SET_DFU_ALT_INFO
>> - stm32mp_dfu_virt.c: required by CONFIG_DFU_VIRT for stm32prog
>>    command or VIRT device for PMIC for CONFIG_SET_DFU_ALT_INFO.
>>
>> This patch also remove some remaining #ifdef CONFIG
>> and avoid compilation error when CONFIG_SET_DFU_ALT_INFO is not
>> activated.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   board/st/common/Makefile           |   1 +
>>   board/st/common/stm32mp_dfu.c      | 103 ++---------------------------
>>   board/st/common/stm32mp_dfu_virt.c |  99 +++++++++++++++++++++++++++
>>   3 files changed, 104 insertions(+), 99 deletions(-)
>>   create mode 100644 board/st/common/stm32mp_dfu_virt.c
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
Apply on stm32/next

Thanks
Patrice
