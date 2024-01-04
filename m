Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8744AC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 03:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2948877FE;
	Thu,  4 Jan 2024 04:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HHeFvYxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADA987811; Thu,  4 Jan 2024 04:46:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DAE38771E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 04:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4043kRAx063196;
 Wed, 3 Jan 2024 21:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704339988;
 bh=bYTk3lfp+zFGDz40hvILIjpM7HEWaDtDNDsOVtAPWUU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HHeFvYxQIj9OERLDmcSYKIzGv4fCzIdx4VekZzHBtfOmz6M5ion1CrfzUtZEhCxVq
 PgfcwKJBDuW4HTKygPH/5jCV3JGcC2oYi7nXpMwTHKHwtjj8DqMxQta7U6yJfZR/cQ
 zHSLFcuNiJ2wio5zceGQ9thtsOSWiArUAfAVlc74=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4043kRuP092300
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 21:46:27 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 21:46:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 21:46:27 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4043kL09033573;
 Wed, 3 Jan 2024 21:46:21 -0600
Message-ID: <e4fdf6f6-db02-4d85-8745-69f999781d82@ti.com>
Date: Thu, 4 Jan 2024 09:16:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/17] board: ti: j748s4: Add board config yaml files
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Simon
 Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof
 <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-10-a-nandan@ti.com>
 <20240103173637.fdhfwgmsmqrfpzdp@manmade>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240103173637.fdhfwgmsmqrfpzdp@manmade>
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

Hi Nishanth

On 03/01/24 23:06, Nishanth Menon wrote:
> On 00:45-20231220, Apurva Nandan wrote:
>> Add board-cfg, rm-cfg, pm-cfg, sec-cfg, tifs-rm-cfg yaml for buidling
>> u-boot sysfw data.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   board/ti/j784s4/board-cfg.yaml   |   37 +
>>   board/ti/j784s4/pm-cfg.yaml      |   13 +
>>   board/ti/j784s4/rm-cfg.yaml      | 3058 ++++++++++++++++++++++++++++++
>>   board/ti/j784s4/sec-cfg.yaml     |  380 ++++
>>   board/ti/j784s4/tifs-rm-cfg.yaml | 2656 ++++++++++++++++++++++++++
>>   5 files changed, 6144 insertions(+)
>>   create mode 100644 board/ti/j784s4/board-cfg.yaml
>>   create mode 100644 board/ti/j784s4/pm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/rm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/sec-cfg.yaml
>>   create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>>
> 
> Cursory review.. but btw, when I run:
> $ yamllint board/ti/j784s4/rm-cfg.yaml
> 
> it throws a bunch of warnings, but it does the same for other yamls as
> well. Not sure it was supposed to be yamlinted - Neha? Might be good
> idea than manual review to ensure some basic checks are done?
> 
> Either way,
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 

Yeah I didn't have any other checks in place for the YAML files, thanks for 
noticing this, will target a quick clean up patch.

> 
> Ref - I used yamllint 1.26.3

-- 
Thanking You
Neha Malcom Francis
