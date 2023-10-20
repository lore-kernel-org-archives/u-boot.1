Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F58C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 15:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E30874CE;
	Fri, 20 Oct 2023 17:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KwKuKsy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822EA874D0; Fri, 20 Oct 2023 17:23:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2FE874C4
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 17:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KFN2AE087996;
 Fri, 20 Oct 2023 10:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697815383;
 bh=PGtGMy8LFIysHnuF03WZ3k0wKTO/sYPdozmYdAAHNeg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KwKuKsy+ahPFT7Z4WWiLXFrIZHYHIroD01ZqiWOQfDyANjJwDkv0H1hjen5HhM88V
 R0ZvFVO+rulN+xKTRen05Xfdpd/u+JIUlXx/j9qizUA8n5OIkhzlV0zGmxBW3hhd82
 6PxbxNwi1hdEG57JV5JSHWMDX21L/OUtXFmCxJdA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KFN2mU005758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Oct 2023 10:23:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 10:23:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 10:23:02 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KFMwcM001232;
 Fri, 20 Oct 2023 10:22:59 -0500
Message-ID: <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
Date: Fri, 20 Oct 2023 20:52:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <a-nandan@ti.com>,
 <n-francis@ti.com>, Nishanth Menon <nm@ti.com>
References: <20231020070128.28320-1-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231020070128.28320-1-p-mantena@ti.com>
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

Thanks Prasanth

On 10/20/2023 12:31 PM, Prasanth Babu Mantena wrote:
> EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
> size followed by reading 1-byte size with an offset 1. This commit fixes
> the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
> board_detect: Fix EEPROM read quirk for 2-byte").
You can fixes below as well. I think you can avoid this in commit message
>
> In the previous commit, the value with one offset is being read into
> offset_test, but the pointer used to match was still ep. After reading
> with an offset 1, the second byte of the header is compared with the 1-byte
> data read from EEPROM. This is taken care by comparing proper first byte
> value from the header.
Nice catch
>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
Please consider Fixes line, first than Signed-off-by


Please copy Nishanth in patch as well .

> ---
> Resending due to incorrect patch tag last time.
>
>   board/ti/common/board_detect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> index 9a53884c98..17fe8f8069 100644
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
