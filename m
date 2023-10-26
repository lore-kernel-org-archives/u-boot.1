Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9905C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 21:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D67C87650;
	Thu, 26 Oct 2023 23:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h/PpGGdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF3D87AFF; Thu, 26 Oct 2023 23:02:48 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D6F87641
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 23:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39QL2er0100793;
 Thu, 26 Oct 2023 16:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698354160;
 bh=7zMQl8waYojeUu7FzB91z95cei6lA5OsrEW5B6zeM2k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h/PpGGdNXfHGTlWUt7HPoBbpovBO1KS4zlJPq7fCYVdhZDUBFSFoJEXEISCMCpJb5
 5vpZMgCNJtSdLCvIJD7zt5EhkZJ+YI/P5OPzbYaflJxw4qoIIywcJ7K5gu5v5Oep2L
 yc/ftAmliB8ImgJ1HQbE3gmS7/X/HomlJTEDsWNI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39QL2e6g108040
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 26 Oct 2023 16:02:40 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 16:02:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 16:02:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39QL2eAW062444;
 Thu, 26 Oct 2023 16:02:40 -0500
Date: Thu, 26 Oct 2023 16:02:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <matwey.kornilov@gmail.com>, <jkridner@beagleboard.org>,
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <a-nandan@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v2] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Message-ID: <20231026210240.esopotwu4wy3mnyo@sediment>
References: <20231026122413.4116-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026122413.4116-1-p-mantena@ti.com>
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

On 17:54-20231026, Prasanth Babu Mantena wrote:
> EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
> size followed by reading 1-byte size with an offset 1. This commit fixes
> the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
> board_detect: Fix EEPROM read quirk for 2-byte").
> 
> In the previous commit, the value with one offset is being read into
> offset_test, but the pointer used to match was still ep. ep is the
> pointer where previously read data is stored, resulting in an invalid
> comparision of the values. The intent is to identify bad 2-byte
> addressing eerpoms, which respond to the initial 1-byte addressing
> request and gets stuck on the succesive reads. After successive read
> with an offset 1, the 1-byte data is compared with the second byte of
> the header to ensure it as a valid 1byte addressing eeprom.
> This is taken care by comparing proper first byte value from, header
> with an offset 1 byte, to offset_test having the 1-byte data read from eeprom.

Rephrase (I at times go to grammarly.com to make sure I use the right
verbage): So, keep it simple (we can read code - no need to give us the
detail readup). Stuff like "in the previous commit" leaves us wondering
which commit.

EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
size followed by reading 1-byte size with an offset 1.
The commit 9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM
read quirk for 2-byte") that attempts to fix this uses the wrong pointer to
to compare.

> 
> Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
> v2 <--> v1:
> Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
> Improved commit message.
> 
>  board/ti/common/board_detect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> index 9a53884c98..869f7a47f8 100644
> --- a/board/ti/common/board_detect.c
> +++ b/board/ti/common/board_detect.c
> @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
>  
>  	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
>  
> -	if (*((u32 *)ep) != (header & 0xFF))
> +	if (offset_test != ((header >> 8) & 0xFF))
>  		one_byte_addressing = false;
>  
>  	/* Corrupted data??? */
> @@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
>  
>  	rc = i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_test));
>  
> -	if (*((u32 *)ep) != (header & 0xFF))
> +	if (offset_test != ((header >> 8) & 0xFF))
>  		one_byte_addressing = false;
>  
>  	/* Corrupted data??? */
> -- 
> 2.39.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
