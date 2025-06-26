Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3F6C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 23:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FA682CEB;
	Fri, 27 Jun 2025 01:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="syBx3l1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE09C82D21; Fri, 27 Jun 2025 01:54:51 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529D181F66
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QNsfLZ2263957;
 Thu, 26 Jun 2025 18:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750982081;
 bh=dpuZA+86AwB0zRIM6xarTcXtozVhKoasKIDP1UpX96U=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=syBx3l1uTXbkdBAzu7ZGeTOcGMC6Us0v2nrvbA2Q/FiI/np1AZ0PC7LM/kKzQah6T
 wor9Kx5b726ttgO/+S0qTtcTASd9LCTGwGn4FXW2HgshYj8jYLpWlxfw4bq/4qqiSb
 TNqGxjt8k1SZOrv/MLvALULUtptTpHYaHnvKBU3U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QNsf5u4063158
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 18:54:41 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 18:54:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 18:54:40 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QNsehD2102870;
 Thu, 26 Jun 2025 18:54:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Jun 2025 05:23:59 +0530
Message-ID: <DAWVBW49Y1VW.1FGEQJ4TMI0VG@ti.com>
Subject: Re: [RFC PATCH v1 4/4] cmd: Kconfig: disable loading raw images in
 secure os boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <bb@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-5-anshuld@ti.com>
 <20250626234741.GB4003484@bill-the-cat>
In-Reply-To: <20250626234741.GB4003484@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Fri Jun 27, 2025 at 5:17 AM IST, Tom Rini wrote:
> On Thu, Jun 26, 2025 at 05:34:42PM +0530, Anshul Dalal wrote:
>
>> Raw kernel images can not be authenticated so disable loading such
>> binaries in secure falcon mode. This change restricts the falcon mode
>> SPL to FIT as the only viable boot image which can be authenticated.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  cmd/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index ed741d43cea..8eb55dd7f6e 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -353,12 +353,13 @@ config BOOTM_ELF
>> =20
>>  config CMD_BOOTZ
>>  	bool "bootz"
>> +	depends on !SPL_SECURE_OS_BOOT
>>  	help
>>  	  Boot the Linux zImage
>> =20
>>  config CMD_BOOTI
>>  	bool "booti"
>> -	depends on ARM64 || RISCV || SANDBOX
>> +	depends on (ARM64 || RISCV || SANDBOX) && !SPL_SECURE_OS_BOOT
>>  	default y
>>  	help
>>  	  Boot an AArch64 Linux Kernel image from memory.
>
> This is just pushing things too far and we need to step back and fix it,
> sorry. We need BOOTZ_IMAGE_FORMAT and BOOTI_IMAGE_FORMAT to go with
> LEGACY_IMAGE_FORMAT, and then SPL_... variants too, and then use those
> symbols.

I can respin one of my earlier patch series[1] that migrated these
CMD_BOOTx symbols to SPL. But we should still disable those new symbols
to prevent loading of unverifiable raw kernel images in secure os boot
right?

[1]: https://lore.kernel.org/u-boot/20250408141436.712387-1-anshuld@ti.com/
