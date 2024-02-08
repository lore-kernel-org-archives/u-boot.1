Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D66C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 19:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A089E87CED;
	Thu,  8 Feb 2024 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iBDt2Clg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498DA87CF9; Thu,  8 Feb 2024 20:37:57 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8D387CE8
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 20:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418Jboaf093738;
 Thu, 8 Feb 2024 13:37:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707421071;
 bh=gd+R+Ee6FiYFMzmbUIsP8F2mpc9swQrFYveLWdKrUQM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iBDt2Clg2NXEPWEbd8fz8+fesM95LpPzBvLQGnjg+W8Ksmm86NzEXdGwi7gArWaC3
 CHgfR7C1osT/5/cOp26Nchm5KzjPgFMqIZxbsElGGrtxex6hWa7eI7bATLEIlqq+G+
 HunsQSvAxbVLkkayGozjyZ2ltq6029rJyAG/MqZ8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418Jbo3o084148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 Feb 2024 13:37:50 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 13:37:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 13:37:50 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418JboS1115134;
 Thu, 8 Feb 2024 13:37:50 -0600
Message-ID: <3789611b-7f39-417b-bbdb-af6d7b10ce8d@ti.com>
Date: Thu, 8 Feb 2024 13:37:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ti: keystone2: Move common Kconfig selections to
 under ARCH_KEYSTONE
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>
References: <20230725155416.100678-1-afd@ti.com>
 <20230725155416.100678-2-afd@ti.com> <20230725174105.GY3630934@bill-the-cat>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230725174105.GY3630934@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 7/25/23 12:41 PM, Tom Rini wrote:
> On Tue, Jul 25, 2023 at 10:54:16AM -0500, Andrew Davis wrote:
> 
>> These select/imply settings are common to the whole architecture not just
>> these boards, move these settings to the architecture config.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

ping
