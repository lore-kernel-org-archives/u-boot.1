Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1D3CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BA786B82;
	Mon, 25 Sep 2023 06:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FnpQSjyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AFC86B89; Mon, 25 Sep 2023 06:28:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B35B86B18
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P4Romq015406;
 Sun, 24 Sep 2023 23:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695616070;
 bh=J3zOq6Fw2y+pdwsEOEnCRpteJ/M2G6budrlUMgdhws0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FnpQSjyGB+paNzlx4aJZztIIV+vPUOqaVywIfWNTLpE1NRFyUnbMFVT2G6o1mHudW
 7gza2Dl/9f8HCeuSNPX3VBkG9YR6tOzuJ83xGZJS+s3k1lvwXs4I962+5KzP2JVrN3
 5thNwY5vdTXObe645NmQLhTZ65kQKEJc3TmPXwWA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P4RoiJ121767
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Sep 2023 23:27:50 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Sep 2023 23:27:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Sep 2023 23:27:50 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P4RlWE000423;
 Sun, 24 Sep 2023 23:27:48 -0500
Message-ID: <bbcadd96-bf67-eb2d-1100-74bb942182b5@ti.com>
Date: Mon, 25 Sep 2023 09:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Question about boot failure of AM64-SK
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: Nishanth Menon <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
 <CAK7LNAQKucgcJViKGts4GmwUxNZ2Wi-rpEqst4=ueBj66-QTeg@mail.gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAK7LNAQKucgcJViKGts4GmwUxNZ2Wi-rpEqst4=ueBj66-QTeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi,

On 21/09/23 21:52, Masahiro Yamada wrote:
> On Fri, Sep 22, 2023 at 12:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> Hi.
>>
>> I am seeing a boot failure on AM64-SK.
>>
>>
>> I got the following error in SPL of the main core.
>> Do you have any clue?
> 
> 
> 
> As a side-topic, I downloaded a prebuilt image
> from https://www.ti.com/tool/SK-AM64
> 
> It failed too (but in a different way).
> 
> I flashed tisdk-debian-bookworm-am64xx-evm.wic
> to a SD card by using the 'dd' command, then I got this:
> 


Prebuilt images are targeted for High Secure (HS FS) devices. Looks like
the board has a non HS Silicon (GP). Please overwrite the tiboot3.bin in
boot partition with that of GP

cp tiboot3-am64x-gp-evm.bin tiboot3.bin


> 
> 
> U-Boot SPL 2023.04 (Jul 14 2023 - 08:10:06 +0000)
> EEPROM not available at 0x50, trying to read at 0x51
> k3_system_controller sysctrler: k3_sysctrler_start: Boot Notification
> response failed. ret = -110
> Firmware init failed on rproc (-110)
> 
> resetting ...
> ti_sci system-controller@44043000: ti_sci_get_response: Message
> receive failed. ret = -110
> ti_sci system-controller@44043000: ti_sci_get_response: Message
> receive failed. ret = -110
> ti_sci system-controller@44043000: ti_sci_get_response: Message
> receive failed. ret = -110
> no sysreset
> ### ERROR ### Please RESET the board ###
> 
> 
> 
> 
> Am I doing something wrong?
> 
> 
> 
> 
> 
> 

-- 
Regards
Vignesh
