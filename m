Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36248E776F4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9783886E43;
	Wed,  4 Oct 2023 11:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="pX+/b3iP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F8B86E5A; Wed,  4 Oct 2023 11:19:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7A086E17
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3945RSr9021989; Wed, 4 Oct 2023 11:19:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:from:subject:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Yoqj9Xe8Qj4FtA0LXijqBrEf9f1Vo/uww1tHl+ucB64=; b=pX
 +/b3iP3wkvWsukcc6T+vx2ZXnDYyhLgZ5kI8Av41rzp+TQ2enWLImCYDzcds1Ma+
 DUk1CJvzDNYjtM1/V0iaSD3TYSl9s5PrNnjQX89tyxUi+/HGr12hzgTzDYv+WkdF
 pZVkvKNrRpX/oC9S1omsuFoHnJywu9RWRto0eaeXX5vneLLfwdVJ3K+W1f7yZem7
 B/ZaVuaXxvuKm7zqH23L8S92953wIEbvkKy5KZ6/lD9yhk83LteFq+1UxZsYTvBL
 iePOFT2hAii+VUE00mIDHUUhUmNUMrPzTgYV7F9nvWsyei3ozH1nx1k1pudpyzkP
 ajIgp0kCST6dV8NX1mAg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3teajd059g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:19:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC268100057;
 Wed,  4 Oct 2023 11:19:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D46F422A6E4;
 Wed,  4 Oct 2023 11:19:17 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:19:17 +0200
Message-ID: <756093f5-d3da-eeae-9619-763e48d297cc@foss.st.com>
Date: Wed, 4 Oct 2023 11:19:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
To: Marek Vasut <marex@denx.de>, Harald Seiler <hws@denx.de>,
 <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@dh-electronics.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230927124625.247858-1-hws@denx.de>
 <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
Content-Language: en-US
In-Reply-To: <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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



On 9/30/23 23:02, Marek Vasut wrote:
> On 9/27/23 14:46, Harald Seiler wrote:
>> Ensure that the SoM and board code information is only printed when
>> CONFIG_SPL_DISPLAY_PRINT is set.
>>
>> Signed-off-by: Harald Seiler <hws@denx.de>
> 
> Reviewed-by: Marek Vasut <marex@denx.de>


Apply on stm32/next

Thanks
