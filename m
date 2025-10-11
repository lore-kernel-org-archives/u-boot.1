Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8B8CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 09:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6849A83CF5;
	Sat, 11 Oct 2025 11:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mlLyWgDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B5783D01; Sat, 11 Oct 2025 11:49:11 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6054C83C94
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59B9n6vq500690;
 Sat, 11 Oct 2025 04:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760176146;
 bh=KxjB04fmgQmJRhmSljD771MkTw++NEpKb/63fKvAZrI=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=mlLyWgDXNanJfNuepGyZtLoymlCI/vRzrscUPv8B0t0vV6QRqvCja0KR6SV8yaEJq
 hf7WEbnoK5GdkN1NCztX983YH/Qf1ocUSHIlJ2IBidjSZj9GMf+5yR7sHa+ir6XjY1
 lm9kkMasVAVtVpuaewpiKWRdqIFXBsZMJGqxbkzs=
Received: from DFLE215.ent.ti.com (dfle215.ent.ti.com [10.64.6.73])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59B9n6ZU1703405
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 11 Oct 2025 04:49:06 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 11 Oct
 2025 04:49:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 11 Oct 2025 04:49:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59B9n4ej3242151;
 Sat, 11 Oct 2025 04:49:05 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 11 Oct 2025 15:19:04 +0530
Message-ID: <DDFED9QXU8H0.1TIYFYA1V96TE@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v1 2/5] board: ti: common: Kconfig: add CMD_SPL
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-3-anshuld@ti.com>
 <20251010160324.GD298503@bill-the-cat>
In-Reply-To: <20251010160324.GD298503@bill-the-cat>
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

On Fri Oct 10, 2025 at 9:33 PM IST, Tom Rini wrote:
> On Fri, Oct 10, 2025 at 06:48:24PM +0530, Anshul Dalal wrote:
>> Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS. This
>> allows the use of 'spl export'[1] command for preparing a device-tree
>> for falcon boot.
>>=20
>> [1]: https://docs.u-boot.org/en/v2025.10/develop/falcon.html#using-spl-c=
ommand
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  board/ti/common/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
>> index f481812247c..fa8260e3fa4 100644
>> --- a/board/ti/common/Kconfig
>> +++ b/board/ti/common/Kconfig
>> @@ -53,6 +53,7 @@ config TI_COMMON_CMD_OPTIONS
>>  	imply CMD_REGULATOR if DM_REGULATOR
>>  	imply CMD_SF if SPI_FLASH
>>  	imply CMD_SPI
>> +	imply CMD_SPL
>>  	imply CMD_TIME
>>  	imply CMD_USB if USB
>
> Commit message says adding CMD_CACHE, content is adding CMD_SPL.

Oh my bad, I guess I forgot to edit the message I copied from an older
commit. Will fix in the next revision.

