Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F78FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106E3887FA;
	Fri, 19 Apr 2024 14:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KB4ayLd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E0D887E2; Fri, 19 Apr 2024 14:27:36 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6744F887DB
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAuZ2i020533; Fri, 19 Apr 2024 14:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=6Wxg/jLo4NIR17Ta3jtybgObFUJDlAGvi0GdbJ0CA1w=; b=KB
 4ayLd0VWPfnGZYI9NfOREsPgs9OVmWJ13hAzB21bcOzkgVtFjNDDR1fey3MD4sWX
 15kzKMuMzmueFJnIgdBOqFYzWylI0JmJ14CpbLWzO0/apiKaqyuWqAlj7/a3diI6
 hxpFqGLfLjc9bZVh2NtMw3hU9A7j1zo3IFw/xxY9zt0rPYkhYjNwDcFaQ3VK1zkd
 mXPKLLsq3wqvQdZFYg0ye7JcfBnt/99H+epiUZzwaM/Z82KJ2ZStfusFLdWpk2//
 q836AJVeakCHqtCnMs2dGHGk7NyUR0h/fsWU0oioLIu5cFwbMyc5qAd3huuCMSo2
 J7pXv8xsEChuk8RaAcHQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m12ann-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:27:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 30AA840045;
 Fri, 19 Apr 2024 14:27:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 690AB21A908;
 Fri, 19 Apr 2024 14:27:12 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:27:11 +0200
Message-ID: <1cc63135-f0f3-4046-9afe-ddc413c13970@foss.st.com>
Date: Fri, 19 Apr 2024 14:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/25] ARM: dts: stm32: Update red led node for
 stm32mp157a-dk1-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-17-patrice.chotard@foss.st.com>
 <4a51be6e-1f75-43e2-ab10-99067684d1b4@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <4a51be6e-1f75-43e2-ab10-99067684d1b4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/17/24 11:10, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> As indicated in kernel led dt-bindings, label is a deprecated
>> property, so remove it and use red led node's name instead
>> for u-boot,error-led property.
>> Rename red led node's name to led-red.
>> Remove status property which is useless.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
