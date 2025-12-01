Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EC2D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1556E83C30;
	Mon,  1 Dec 2025 17:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="cVRWeKWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741C783C39; Mon,  1 Dec 2025 17:11:10 +0100 (CET)
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA4B83C23
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
 by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 5B1Fdf7k007074;
 Mon, 1 Dec 2025 17:11:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps; bh=qhnl+Y
 ltYaSLU0e80Z0EB2CVZX6DeO0+exP9wq1Sn4c=; b=cVRWeKWbCt3bC35Jj68wRa
 LwyBwv8PVfQaJZtD2QvOgbEanA+ztgIgU7IuZb1WIUdRf6KnXYRI2mxdyWh9y5va
 FvAzkfcVxwhIKmZws29oEXR+xBQrNzcQ6piRGECUacGYM6WXMYTgv7ap57mpfvAl
 1j31jtdNTRjkL8+YV//q5EC59yKFq2Ullf9Ee03HWlPoZu4qdIH8OAcmYBempZQF
 wp1XY4K/n3srWm8LR3vZvDMYu7D1UERtpbdNN1VIjjkKDH2Npe3t57ei1kUGqS47
 P9qob/Z3YNRQHLgW962YAvuylytT7nun15O97WgqouznMqub1ln6C/7ga/pV9WRw
 ==
From: <fedor.ross@ifm.com>
To: <marek.vasut@mailbox.org>
CC: <alice.guo@nxp.com>, <fedor.ross@ifm.com>, <festevam@gmail.com>,
 <joao.goncalves@toradex.com>, <marek.vasut+renesas@mailbox.org>,
 <peng.fan@nxp.com>, <ranjani.vaidyanathan@nxp.com>, <ravi@prevas.dk>,
 <sbabic@nabladev.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <uboot-imx@nxp.com>, <ye.li@nxp.com>
Subject: Re: [PATCH] imx9: scmi: soc: USB instance number change for silicon
 revision B0
Date: Mon, 1 Dec 2025 17:10:22 +0100
Message-ID: <20251201161036.56586-1-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d4b29293-3858-4168-b964-90421f98e9d4@mailbox.org>
References: <d4b29293-3858-4168-b964-90421f98e9d4@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.129.122]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4aqqk5mun8 QID=4aqqk5mun8-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
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

From: Fedor Ross <fedor.ross@ifm.com>

> On 11/27/25 6:50 PM, Fedor Ross wrote:
>> For silicon revision A1, the USB instance number for USB1 is 3 and for
>> USB2 it is 4. This changed for revision B0 where the USB instance number
>> for USB1 is 0 and for USB2 it is 1, which is the intended instance
>> number. Select the correct numbering according to the selected revision
>> in the defconfig. The config for the B0 revision is IMX95 and for A1 it
>> is IMX95_A0.
>> 
>> This patch is based on the information provided by:
>> "AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .
>> 
>> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
>> ---
>>   arch/arm/mach-imx/imx9/scmi/soc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>> index dbaa19a9e6e..354df7d88a4 100644
>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>> @@ -921,7 +921,7 @@ enum boot_device get_boot_device(void)
>>   		break;
>>   	case BT_DEV_TYPE_USB:
>>   		boot_dev = boot_instance + USB_BOOT;
>> -		if (IS_ENABLED(CONFIG_IMX95))
>> +		if (IS_ENABLED(CONFIG_IMX95_A0))
> 
> It seems this can also be made even more generic:
> 
> -if (IS_ENABLED(CONFIG_IMX95))
> +if (is_imx95() && (soc_rev() < CHIP_REV_2_0))

Yes, that's better. Thank you. Considering that the support for IMX95_A0
might be dropped sooner or later, it also seems to be more future-proof.

Best regards,
Fedor
