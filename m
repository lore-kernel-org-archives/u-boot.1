Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92162C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 07:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AFD883C3;
	Tue,  9 Jul 2024 09:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z+917t1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7B4884D0; Tue,  9 Jul 2024 09:14:57 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE51E883C3
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 09:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4697Eq9T040282;
 Tue, 9 Jul 2024 02:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720509292;
 bh=qiKaJvGCJsnfF+tciTxPoAjRoI+Cyuf/PqevGdywHdo=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=Z+917t1zgxQNwd09T2Kxmm1Y9p7GQ2G7i+GQK/t2p284cV4bMoVs8RWZuS8rScad7
 shlTBpAwMAtMv1Dj/iqQssvvbRjcR8AoE2P6ahIhoFr/pOw8fhcQiTNXgV3JGUjSlt
 jKx949h2FZ3BLx9BmPwhRybodMJRyyBT9Q+FwO9k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4697EqvE027082
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jul 2024 02:14:52 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 02:14:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 02:14:52 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4697EpVP086615;
 Tue, 9 Jul 2024 02:14:51 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH] configs: am62x_evm_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
In-Reply-To: <20240709044346.jyntpefkhpgdfd2x@uda0497581>
References: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
 <20240709044346.jyntpefkhpgdfd2x@uda0497581>
Date: Tue, 9 Jul 2024 12:44:50 +0530
Message-ID: <87v81f595h.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
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

Manorit Chawdhry <m-chawdhry@ti.com> writes:

> Hi Kamlesh,
>
> On 17:20-20240708, Kamlesh Gurudasani wrote:
>> Increase the maximum size of the buffer that is used to decompress
>> the OS image in to.
>> 
>> If image size is greater than the buffer, boot
>> will fail with following error,
>> "Error: inflate() returned -5"
>> "gzip compressed: uncompress error -1"
>> 
>> Default limit for ARM64 platforms is 0x4000000, remove
>> CONFIG_SYS_BOOTM_LEN=0x8000000, so that it follows default limit.
>
> Why were we failing with a larger buffer size..?

Thanks for reviewing, Manorit. Typo in the commit msg, extra zero.
It should be 0x800000 as in actual diff. Will fix in v2.

Kamlesh
>
> Regards,
> Manorit
>
>> 
>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>> ---
>>  configs/am62x_evm_a53_defconfig | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
>> index ca993b427b..dfa5ecc847 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -32,7 +32,6 @@ CONFIG_SPL_SPI=y
>>  CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>>  CONFIG_BOOTSTD_FULL=y
>> -CONFIG_SYS_BOOTM_LEN=0x800000
>>  CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
>>  CONFIG_BOARD_LATE_INIT=y
>>  CONFIG_SPL_MAX_SIZE=0x58000
>> 
>> ---
>> base-commit: fd46ea0e701920eb205c2bce9d527bf0dec10b59
>> change-id: 20240708-remove-bootm-len-ab4e46039656
>> 
>> Best regards,
>> -- 
>> Kamlesh Gurudasani <kamlesh@ti.com>
>> 
