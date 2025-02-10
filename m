Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5275C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 10:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DEA803B5;
	Mon, 10 Feb 2025 11:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BFf6SSQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE8880548; Mon, 10 Feb 2025 11:32:21 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AC4801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41360c9821=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9ekw3003703;
 Mon, 10 Feb 2025 11:32:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 H/plYcKfUN7OVXBsLbqMqWi84AgK0qu1wBDzevYXICE=; b=BFf6SSQoHwk/DzmD
 R2RFebhrD0fbfwojeZHyFYdMYwrCdyhs/MUGYmZJuPiDMK1zD4tXq/1s2KhNwTdd
 w3SQKFyhx1euTNnR3P2AjYKwQYONxWdSdXUKk9N/yUx/3VJao2D+IFhZjkNOdTzH
 dtZhBZcXYDNkmhJ5YaXuz+rHUfupMbbKlOzQ/ZUzAgiWJIaQO3x9vWgPYp6yZTLs
 RpvI/tN6+jk3HN1oQs1fMwdYSUDC9ajcWIu7yeG6wrQyrauvW0TDR9nwppFBhL8Y
 9seS3kzZHHiqJzsG16J+UqbHbQWBCVbVn4TLzWFu1pX6zJUcw7x4rGHTXb2DtO6+
 Usg+9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44phq3m0up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 11:32:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD7F440052;
 Mon, 10 Feb 2025 11:31:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E6162D1652;
 Mon, 10 Feb 2025 11:28:08 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 11:28:07 +0100
Message-ID: <c89e94bf-0ed6-4b3f-9f3b-eee9d30a91df@foss.st.com>
Date: Mon, 10 Feb 2025 11:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
 <87zfldnlmw.fsf@baylibre.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87zfldnlmw.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
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

Hi Marek

Any chance to get this patch merged in next U-Boot tag 2025.04-rc2 ?

Thanks
Patrice

On 12/3/24 10:47, Mattijs Korpershoek wrote:
> Hi Patrice,
> 
> Thank you for the patch.
> 
> On lun., déc. 02, 2024 at 08:46, Patrice Chotard <patrice.chotard@foss.st.com> wrote:
> 
>> In case "ums" command is used on platforms which don't implement
>> g_dnl_board_usb_cable_connected() and USB cable is not connected,
>> we stay inside sleep_thread() forever and watchdog is triggered.
>>
>> Add schedule() call to avoid this issue.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
>>
>> ---
>>
>> Changes in v2:
>>   - move schedule() right before dm_usb_gadget_handle_interrupts()
>>
>>  drivers/usb/gadget/f_mass_storage.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> index ffe1ae6eb73..d3fc4acb401 100644
>> --- a/drivers/usb/gadget/f_mass_storage.c
>> +++ b/drivers/usb/gadget/f_mass_storage.c
>> @@ -682,6 +682,7 @@ static int sleep_thread(struct fsg_common *common)
>>  			k = 0;
>>  		}
>>  
>> +		schedule();
>>  		dm_usb_gadget_handle_interrupts(udcdev);
>>  	}
>>  	common->thread_wakeup_needed = 0;
>> -- 
>> 2.25.1
