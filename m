Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E4DC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 16:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132D787BB5;
	Mon, 29 Jan 2024 17:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EWBUw1/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ACD287BCB; Mon, 29 Jan 2024 17:08:01 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BD287BAD
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TG7s4n006322;
 Mon, 29 Jan 2024 10:07:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706544474;
 bh=aPJe6Mo4+SXXuxY0XP0F0I0KbjNuf5r/fc0j9/v+Ed8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EWBUw1/6wtUvdafIQ/fqi8UXZqwjEO7FyVlrQujl5UdO/DGFzmFDC+aWoeqjnyBtm
 l8oZu1s6JvV6ogfEGiipylV6kQClb9XB/aGdJjIbeWZYIDLtjGrQyfk1Kdipgllvq4
 IiL3ibB7wSQz/XRss5NH0Qbh2pKKMcEWWSba9Fj4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TG7swk008823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jan 2024 10:07:54 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 10:07:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 10:07:53 -0600
Received: from [10.249.128.48] ([10.249.128.48])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TG7oNc025641;
 Mon, 29 Jan 2024 10:07:50 -0600
Message-ID: <4adff3fe-524c-8835-85d2-65830789d453@ti.com>
Date: Mon, 29 Jan 2024 21:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] common: splash_source: Don't compile ubifs splash cmd
 for SPL build
Content-Language: en-US
To: Nikhil Jain <n-jain1@ti.com>, <u-boot@lists.denx.de>, <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20240124090509.303787-1-devarsht@ti.com>
 <ce659935-93e6-4f7f-b511-b452d08d74e9@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <ce659935-93e6-4f7f-b511-b452d08d74e9@ti.com>
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

Hi Simon, Tom,

On 24/01/24 17:26, Nikhil Jain wrote:
> Hi Devarsh,
> 
> On 24/01/24 14:35, Devarsh Thakkar wrote:
>> Don't compile ubifs splash mount command for SPL build as this command
>> is not supported (and also not enabled) during SPL stage.
>>
>> This fixes below compilation error, when CONFIG_CMD_UBIFS is enabled in
>> defconfig along with splash screen enabled at SPL stage:
>>
>> "aarch64-none-linux-gnu-ld.bfd: common/cli.o: in function `run_command':
>> u-boot-next/u-boot/common/cli.c:51: undefined reference to
>> `parse_string_outer'
>> u-boot-next/u-boot/common/cli.c:51:(.text.run_command+0x10): relocation
>> truncated to fit: R_AARCH64_JUMP26 against undefined symbol
>> `parse_string_outer' make[2]: ***
>> [u-boot-next/u-boot/scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
>> make[1]: *** [u-boot-next/u-boot/Makefile:2053: spl/u-boot-spl] Error 2
>> make[1]: Leaving directory 'u-boot-next/u-boot/out/a53' make: ***
>> [Makefile:177: sub-make] Error 2"
>>
>> Fixes: eb9217dc03 ("common: Enable splash functions at SPL")
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Reviewed-by: Nikhil M Jain <n-jain1@ti.com>

Sorry for the rush, but just wanted to check if it is possible to pull 
this in for current merge window for v2024.04 ?

Regards
Devarsh
