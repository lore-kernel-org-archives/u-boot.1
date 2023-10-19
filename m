Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814F4CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C688071F;
	Thu, 19 Oct 2023 12:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="faA6gVUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E187A80310; Thu, 19 Oct 2023 12:04:53 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD5F386F34
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9398FF809;
 Thu, 19 Oct 2023 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697709891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxjsQZc6mL2Ug50Fmcm5OZ2qiWmY2vO46oBX508ytFw=;
 b=faA6gVUsowix3okCAS+R6nuVHM6pWrbCeAgD88XjvNhCJVuost+EyYQssXQiAmZx8+JEeT
 Wf92NPwbp7i8atGJYtHFbzryq+4AJvn6PtoPs2zFQQyx2iKeIdZMxA6f1HvqH6zNK340QY
 RlcFz5KpZ1kxqqCsqQ8PqmDEYKVeHnS5YnXSrBIXsp7cMBGj4gRtkZzzYTPahNeJ+q0aaV
 ofP7xJXj3oyCtNdEIwsx1WN05BMFbtCdI4W5GugzLhzI2aHwi+S7vDBLwoL/VYFKXwTeky
 2y0Rg3AjOdAX9E/6jBRlhf8iAq4HYvh2KRlBvNXhsyGAWtvcZLq/geijxXBeqw==
Message-ID: <a178c150-d1d9-499a-a050-0e128812dd1e@bootlin.com>
Date: Thu, 19 Oct 2023 12:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ram: k3-ddrss: Add exit retention support
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-6-thomas.richard@bootlin.com>
 <20231018224211.o6u2bck4niqolonp@bryanbrattlof.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231018224211.o6u2bck4niqolonp@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 10/19/23 00:42, Bryan Brattlof wrote:
> Hi Thomas!
> 
> On October 16, 2023 thus sayeth Thomas Richard:
>> Add the exit retention support.
>> The enter retention is done by DM-Firmware.
>> A part of the exit retention sequence is specific to the board.
>> It is done in board_k3_ddrss_lpddr4_release_retention.
>>
>> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>
>>  drivers/ram/k3-ddrss/k3-ddrss.c | 302 ++++++++++++++++++++++++++++++++
>>  1 file changed, 302 insertions(+)
>>
> 
> Do you mind putting this behind some type of Kconfig option? For the 
> am62* class of devices the amount of SRAM we have is really stretched 
> thin. I'm worried this may put us over the top. 

Hi Bryan,

Maybe I could put this behind the Kconfig option K3_J721E_DDRSS.
K3_J721E_DDRSS is set if SOC_K3_J721E or SOC_K3_J721S2, and later
SOC_K3_J784S4
(https://elixir.bootlin.com/u-boot/latest/source/drivers/ram/Kconfig#L65).

For now it was only tested on J7200, but we can assume that most of the
code will be valid for J721S2 (and later J784S4).

And the code will not be compiled for am6*.

Regards,

Thomas

> 
> ~Bryan


