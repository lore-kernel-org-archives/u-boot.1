Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF02C4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB648718F;
	Tue,  7 Nov 2023 10:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HbwM+Tn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A7A8718F; Tue,  7 Nov 2023 10:46:00 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28CC8715B
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A79jpG3006967;
 Tue, 7 Nov 2023 03:45:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699350351;
 bh=j/uxCZgUwxCvYFHywXQHxr2BmkkbABL9U61F81gdyqU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HbwM+Tn8bEgIfrpFn16K/PJxVcDU+mCDmzT2VZBzHhUWC6U3FZJoMJVNr8aU4wabp
 XNUJ4fGhJaFJs9luh9uxTDeLu5Bq0R4QAl81i4lH/5Zht6XXWLlUU8CdSjdVAqgmn1
 INfQtWAor9Qf9gT1NMMqK8xQrzJAxFm4eGj+AaZ4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A79jpN5028365
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 03:45:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 03:45:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 03:45:50 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A79jkMn017407;
 Tue, 7 Nov 2023 03:45:47 -0600
Message-ID: <9f562302-3fb5-4b79-acec-5bf6f201f29f@ti.com>
Date: Tue, 7 Nov 2023 15:15:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Content-Language: en-US
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <matwey.kornilov@gmail.com>, <jkridner@beagleboard.org>,
 <robertcnelson@gmail.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, 
 <a-nandan@ti.com>
References: <20231030170458.21668-1-p-mantena@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231030170458.21668-1-p-mantena@ti.com>
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

Hi Prasanth,

On 30/10/23 22:34, Prasanth Babu Mantena wrote:
> EEPROM detection logic in ti_i2c_eeprom_get() involves reading
> the total size and the 1-byte size with an offset 1. The commit
> 9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM read
> quirk for 2-byte") that attempts to fix this uses a wrong pointer to
> compare.
> 
> The value with one offset is read into offset_test, but the pointer
> used to match was still ep, resulting in an invalid comparison of the
> values. The intent is to identify bad 2-byte addressing eeproms that
> get stuck on the successive reads.
> 
> Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> ---
> v3 <--> v2:
> Improved and concise commit description.
> 
> v2 <--> v1:
> Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
> Improved commit message.
> 
>   board/ti/common/board_detect.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> index 9a53884c98..869f7a47f8 100644
> --- a/board/ti/common/board_detect.c
> +++ b/board/ti/common/board_detect.c
> @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
>   
>   	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
>   
> -	if (*((u32 *)ep) != (header & 0xFF))
> +	if (offset_test != ((header >> 8) & 0xFF))
>   		one_byte_addressing = false;
>   
>   	/* Corrupted data??? */
> @@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
>   
>   	rc = i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_test));
>   
> -	if (*((u32 *)ep) != (header & 0xFF))
> +	if (offset_test != ((header >> 8) & 0xFF))
>   		one_byte_addressing = false;
>   
>   	/* Corrupted data??? */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
