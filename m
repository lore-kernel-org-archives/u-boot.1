Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD70C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 05:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD88E87E2F;
	Mon, 11 Mar 2024 06:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gkgdqSMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353EE87E2F; Mon, 11 Mar 2024 06:05:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF6D87EBB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42B551Rs046257;
 Mon, 11 Mar 2024 00:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710133501;
 bh=Clrmo4p1FxIQ+lgRDYy+hYHmTNNrlKtxZca4y8VbSTI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gkgdqSMScihk+qn6w0qaO9cPQgR9+1ZtHF6qZrKWWCyNGUuG4mi2jco0slke39UON
 9bDtYOeqFxy9X2I3NNNx4Jtl/ALC4UOOZVen6roHVndnF38zt/aW3F/2paDM4V0fGz
 ktV+E5/Mo0hU+rAWyTIxy71OmnxKyJNuYKXlrrrU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42B551SI084050
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Mar 2024 00:05:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 00:05:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 00:05:00 -0500
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42B54tbX058288;
 Mon, 11 Mar 2024 00:04:56 -0500
Message-ID: <af15ffae-fbf1-4b14-8035-1f95beb440e1@ti.com>
Date: Mon, 11 Mar 2024 10:34:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <20240307124612.GA4110939@bill-the-cat>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240307124612.GA4110939@bill-the-cat>
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



On 3/7/2024 6:16 PM, Tom Rini wrote:
> On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> 
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
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> This breaks building on am64x_evm_r5 am65x_evm_r5_usbdfu
> am65x_evm_r5_usbmsc in next currently, thanks.
> 
I will work on fixing this build error and re-spin the patch.

-- 
Thanks and Regards,
Md Danish Anwar
