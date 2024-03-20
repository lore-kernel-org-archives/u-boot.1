Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058B9C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 15:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F5087ED0;
	Wed, 20 Mar 2024 16:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V1c/fIWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA83888063; Wed, 20 Mar 2024 16:22:51 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E4387D6B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 16:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KFMaH2107178;
 Wed, 20 Mar 2024 10:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710948156;
 bh=c5aoG2v+tVbC48fV2phwvc3rlNsJh0AiUZZCDiLbV/g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=V1c/fIWK+48xVhI0vlK+Zcn8KAnxSM0PZgSW459isqX9w4L7hZns4+gVz4m8vnhUs
 12RvgWIOO9uvDnjU/iYx6HPolmZ0bjPq0WabslegoeePgIok6tkVTo/dZWexHaPdc4
 xpkbcuED6uGJ7rQ5cnkGTdNeU4rm+wtw9CeMSUDg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KFMara124205
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Mar 2024 10:22:36 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 10:22:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 10:22:35 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KFMUbe115902;
 Wed, 20 Mar 2024 10:22:31 -0500
Message-ID: <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
Date: Wed, 20 Mar 2024 20:52:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, <lukas.funke-oss@weidmueller.com>
CC: <u-boot@lists.denx.de>, Lukas Funke <lukas.funke@weidmueller.com>, Andre
 Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Manoj
 Sai <abbaraju.manojsai@amarulasolutions.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Samuel Holland
 <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
 <20240320143048.GU3442575@bill-the-cat>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240320143048.GU3442575@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom, Lukas,

Thanks for the patch Lukas.

On 20/03/24 20:00, Tom Rini wrote:
> On Wed, Mar 20, 2024 at 02:19:26PM +0100, lukas.funke-oss@weidmueller.com wrote:
> 
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> Some architectures use spl_board_init() in their architecture specific
>> implementation. Board developers should be able to add board specific
>> implementation via spl_board_init(). Hence, introduce a spl_arch_init()
>> method which is called right before spl_board_init() for architecture
>> specific implementation.
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> 
> I think this could allow for other SoCs to clean up their existing

Does it make more sense to make this SoC specific then instead of arch
specific to allow broader range of code?

For e.g., if we have something like spl_soc_init then it would help
accommodate soc specific functionality too along with calling arch specific code ?

Also I see some vendors already having implemented spl_soc_init in their arch
specific files [1], so I think it would be good if it is moved it to framework
level.

[1] :
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/riscv/cpu/fu540/spl.c?ref_type=heads#L10
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/riscv/include/asm/arch-fu740/spl.h?ref_type=heads#L12

Regards
Devarsh

> ad-hoc mechanisms for SoC/architecture init and then board init, so this
> looks like a good idea to me.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
