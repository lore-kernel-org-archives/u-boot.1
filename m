Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DC7C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2906C87BFD;
	Wed,  6 Mar 2024 14:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OXSPjbv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D1487C61; Wed,  6 Mar 2024 14:09:13 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406EB879E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426D98J3109753
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 07:09:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709730548;
 bh=MABvL+7ymoC4BhYwk0Fh1V046MLwg1ifi/GfAjEyJ94=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OXSPjbv8F+ntZ/Xiw7VIMEMxLTqFJTfOABU+whxxtpEU2IleXQoekr8Kj1uo7seL1
 f5A0A8kYxAiMLYZ9mbLqvQ+k1x3KY5jyOKoUMjTCBPGy5kVKEsAh487q6RCmxB0Dln
 IyhYivfgipByuxy+QTrWVncDE0S9d8eonKrXN6yo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426D98B2130566
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 07:09:08 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:09:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:09:08 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426D95aY109328;
 Wed, 6 Mar 2024 07:09:06 -0600
Message-ID: <585656b1-4b72-4c25-a66e-da302969e14b@ti.com>
Date: Wed, 6 Mar 2024 18:39:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix OSPI bootmode for j7200-evm
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>
CC: <vaishnav.a@ti.com>, <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240306063749.1411176-1-a-limaye@ti.com>
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


On 3/6/2024 12:07 PM, Aniket Limaye wrote:
> Support for OSPI probe and also read/write is broken and/or missing in current master branch.


Its broken :)

> - sf probe failure from u-boot prompt & OSPI boot failure [0]
>
> This series adds necessary configs, as well as fixes some bugs in the existing u-boot devicetree,
> to add OSPI boot support for the j7200-evm device.
> - sf probe and update in u-boot prompt & successful OSPI boot logs [1]
>
> [0]: https://gist.github.com/aniket-l/f487472baa47e819defc82e5f57b7860
> [1]: https://gist.github.com/aniket-l/e5353c4511009d2ebf5f1743ebaab61a
>
>
> Aniket Limaye (4):
>    configs: j7200_evm_*_defconfig: Enable OSPI configs
>    arm: dts: k3-j7200: Fix support for OSPI flash
>    arm: dts: k3-j7200-r5-common: fix the mcu_timer0 clock frequency
>    arm: dts: k3-j7200-r5-common: Add missing overrides for ringacc and
>      udmap


Please copy Nishanth in your posting


>   .../dts/k3-j7200-common-proc-board-u-boot.dtsi    |  4 ++++
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts    | 15 ++++++++++++++-
>   configs/j7200_evm_a72_defconfig                   | 10 ++++++++--
>   configs/j7200_evm_r5_defconfig                    |  9 +++++++--
>   4 files changed, 33 insertions(+), 5 deletions(-)
>
