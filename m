Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BAE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 14:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6251189206;
	Tue, 10 Dec 2024 15:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CTstWqeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D6789449; Tue, 10 Dec 2024 15:58:45 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29C9891C4
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 15:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAEwdZC2943462
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 08:58:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733842719;
 bh=sjJI2rk5cY0IfKEKBe7059Akc5oGLRDAhx1VoHHzYOw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CTstWqeRheUpwPoxv7fwsSAaw5iY6yeYue9qCc88qIvCft3gxGUaMXuA/ra3SqJQ1
 0QTPYNv5YdlsEcT6+9eLhYfxkqLaBcY3qTvNEjEo90K7E929RE+b5agWOhhVAFbwqM
 d6i17qGydVMpzSJaj0p5GDMd9qyNv1etoalLVyQw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAEwdFC112459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Dec 2024 08:58:39 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 08:58:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 08:58:39 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAEwZWn060748;
 Tue, 10 Dec 2024 08:58:36 -0600
Message-ID: <019d0101-a174-4181-bb1f-b8096b10c4e0@ti.com>
Date: Tue, 10 Dec 2024 20:28:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix OSPI boot for J722S
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20241210135731.1043269-1-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241210135731.1043269-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 12/10/2024 7:27 PM, Prasanth Babu Mantena wrote:
> This series fixes OSPI boot for J722S. It contains fixes for DMSC
> communication, R5 regmap for ospi and dma specific overrides for ospi.

Subject of series, If you are fixing then one or more patch should have 
Fixes Tag


>
> Test log: https://gist.github.com/PrasanthBabuMantena/ad469dd09ab7263f85f87dadda46c86d
>
> Vaishnav Achath (4):
>    mailbox: k3-sec-proxy: Add DM to DMSC communication thread for J722S
>    arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread ID
>    arm: mach-k3: j722_spl: Add FAST XSPI boot mode
>    arm: dts: k3-j722s*: Add overrides specific to OSPI
>
>   arch/arm/dts/k3-j722s-evm-u-boot.dtsi     |  4 ++++
>   arch/arm/dts/k3-j722s-r5-evm.dts          | 17 +++++++++++++++--
>   arch/arm/mach-k3/include/mach/j722s_spl.h |  1 +
>   arch/arm/mach-k3/j722s/j722s_init.c       |  2 ++
>   drivers/mailbox/k3-sec-proxy.c            |  2 +-
>   5 files changed, 23 insertions(+), 3 deletions(-)
>
