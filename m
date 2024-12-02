Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65E6D10DB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 07:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249D089323;
	Mon,  2 Dec 2024 08:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Y3IZqd6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D773389385; Mon,  2 Dec 2024 08:30:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E354589287
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 08:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2066b4005c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27GlX7004910;
 Mon, 2 Dec 2024 08:30:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 HSAsbV4pjxZWIASvbK5KX8HegebFGAU2WgM3HY/SRIQ=; b=Y3IZqd6dRLeWT45C
 g4sv/X7g0po/KUwVlD7jCjKuZ7833AuHITNBtmul++rSOKdQKdVt6iqqcXcdIOGN
 ILRHRri5lr4PwkFki1d3ReALKA2BvWgn6Hvj90JRBxPh5RiI3f4jhfWLZ6sXhMw9
 6LnC0DxHQRtiD+a4huoH17UZ01w350wS7SSYgDTnmUnZnFGKm4zwhvn20k9BdP61
 CQUsRWWP4sogWDyXvz2pL3lGQxoXup/O7bDOJbcJeeigCc8ABNzUljuu16yFtTki
 K9A5x+aASml3xAyDYRx1FKloj0CE5ShXVk3FD+t8fhwZdn7/1/iXQVhD8vP5o+k4
 RCi3lA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437rq8xcvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 08:30:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A382440049;
 Mon,  2 Dec 2024 08:29:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0038C266A5D;
 Mon,  2 Dec 2024 08:28:49 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 2 Dec
 2024 08:28:49 +0100
Message-ID: <e884dd0e-7ff1-4e1c-9e77-dadb0fd26891@foss.st.com>
Date: Mon, 2 Dec 2024 08:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241129124617.436381-1-patrice.chotard@foss.st.com>
 <98fb1df2-b5ba-4ccf-97c8-d0555c1cdb61@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <98fb1df2-b5ba-4ccf-97c8-d0555c1cdb61@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
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



On 11/29/24 18:35, Marek Vasut wrote:
> On 11/29/24 1:46 PM, Patrice Chotard wrote:
>> In case "ums" command is used on platforms which don't implement
>> g_dnl_board_usb_cable_connected() and USB cable is not connected,
>> we stay inside sleep_thread() forever and watchdog is triggered.
>>
>> Add schedule() call to avoid this issue.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/usb/gadget/f_mass_storage.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> index ffe1ae6eb73..6dc73ef447b 100644
>> --- a/drivers/usb/gadget/f_mass_storage.c
>> +++ b/drivers/usb/gadget/f_mass_storage.c
>> @@ -680,6 +680,7 @@ static int sleep_thread(struct fsg_common *common)
>>                   return -EIO;
>>                 k = 0;
>> +            schedule();
>>           }
>>             dm_usb_gadget_handle_interrupts(udcdev);
> 
> Shouldn't that schedule() be placed right before/after dm_usb_gadget_handle_interrupts() ?

Hi Marek

Yes schedule() can be put before/after dm_usb_gadget_handle_interrupts().
I will send a v2.

Patrice

