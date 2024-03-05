Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FC5C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479AC875B9;
	Tue,  5 Mar 2024 10:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MNEYbndb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3DA87FEE; Tue,  5 Mar 2024 10:09:36 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA88D88013
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42599JsD011529;
 Tue, 5 Mar 2024 03:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709629759;
 bh=qsBHWrUvy//mMpsCLowsxyERsqtQypRoz80p0qL+5Vs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MNEYbndb6/aEs90r7TFUc7ttSDkszkdEF1BgGuDelnR5mNn+X/oszMI1Mwfgk5jp9
 QIWFoMMaSaPMscBIcqgCR4A7ha29tp9UNNYRTRxU0GCwDCO+yOzoqUJAkpCb4XUDZN
 JWykKG0rbwxxObHCGrikPRBTjuCstCHsFQC6irc0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42599JZ8105320
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Mar 2024 03:09:19 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 03:09:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 03:09:18 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42599Euq087749;
 Tue, 5 Mar 2024 03:09:15 -0600
Message-ID: <1a5bf390-f3e5-4ed3-9cc9-10180bf0737e@ti.com>
Date: Tue, 5 Mar 2024 14:39:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <34e1f240-1a5a-4982-aca5-43a508c469f5@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <34e1f240-1a5a-4982-aca5-43a508c469f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 29/02/24 3:43 pm, Roger Quadros wrote:
> 
> 
> On 28/02/2024 14:06, MD Danish Anwar wrote:
>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>> same firmware.
>>
>> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
>> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
>> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
>> load the firmware file to the remote processor and start the remote
>> processor.
>>
>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
>> Kconfig so that we can call request_firmware_into_buf() from remoteproc
>> driver.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Hi Tom,

Can you please pick this patch. There are no active comments on this
patch and Roger and Ravi has reviewed / acked the patch.

-- 
Thanks and Regards,
Danish
