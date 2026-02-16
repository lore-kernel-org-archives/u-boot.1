Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F53DE63F2A
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB148063E;
	Mon, 16 Feb 2026 08:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I7vp2dXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3427D80FA1; Mon, 16 Feb 2026 08:34:19 +0100 (CET)
Received: from mx-relay99-hz2.antispameurope.com
 (mx-relay99-hz2.antispameurope.com [94.100.136.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B409380325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0500d65fcd=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate99-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=6UwSF7HOnM2lROrgn2piCby+HNOLQL9SQYT05xEJ9xw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1771227243;
 b=ItC5Yjx3gDGsZ7P6xe5sr7PqPPIrWuhr1rgsQJHoNhIhe6ltvSjWY87ssWuJTRZ3vqqwL0EG
 BvPmLi+3TTW+TiIRYorvjRECQ54Ff5YkGikJYVohOxx2qdLahIlRF1zSQMIBhaFejlV79wGZVX6
 X3UUPBoOO7x2WzdWRtRjFfZiKMFy/R3+QsIYK1Q6QV0Ml6Jt7f1vm7Gi75dSazIsG6QkyFIcFgY
 1oG2US0zM6KOb0UcDQzaEy/xsGyhD3PGW0JQk6XO0yUNYdWYZpNPa1AdAStInjTR7RHi55e/stC
 earvIHpZXP7Tv6oR66XZru0RFIKmdMhgk0TcTFqzitX0Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1771227243;
 b=g+I3he1/1uXxPC7UQG69Sd+SwCWXfaLK/LdSlTxoqbgJ3Sih4g6CptaY9lKpbEmwCbZzn3vm
 J/MPpT+MQnEm+LkK46Vm4mQNjmPhUlW4e7UNcjtbwzC+QYlWLYiWY+z5VpKjlTLj+TbQQVIkc/f
 FubfHw1AdPpBZM+HX+DOQ/PQFT74QYNmH824u054p6OoxwiZmP1gjTrzWGmWU5TsC2GcUsyi9pe
 h9y/aZLqQH7/xukf+K4YA2Q8EwfQNtA9Iw7x41rZQmG4+sQ6HuGFSSI5ghsZFUiPQZgQj2YW+dn
 7Jwrf7cRvbgE3/1rO7NQ0WynwQChmZYgk7UMKY0HNMHHA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay99-hz2.antispameurope.com; Mon, 16 Feb 2026 08:34:03 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 E701C220535; Mon, 16 Feb 2026 08:33:36 +0100 (CET)
Message-ID: <d91ba34a-0b64-47ee-89d6-458c7c3958e3@ew.tq-group.com>
Date: Mon, 16 Feb 2026 08:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] imx8qxp: siemens: small board updates
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
References: <20260214045703.28051-1-hs@nabladev.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay99-hz2.antispameurope.com with 4fDvds5ZBtz28mWB
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 1eb7458585fca7ebfeb762f74eeee08f
X-cloud-security: scantime:2.090
DKIM-Signature: a=rsa-sha256;
 bh=6UwSF7HOnM2lROrgn2piCby+HNOLQL9SQYT05xEJ9xw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1771227242; v=1;
 b=I7vp2dXdXdjgD0cYLy3ksI2K1/EL2x5RLetxEN9Nm3KpIJNzqOnKxzAxGgzQEvMrGfgffhC3
 yfYArsqn7irJCzIkr/fnAb8m00TwMdJG6z5JIsseriX4IPZ5DMTFbyzvoT4mnhENrJKS3TY8c+P
 tNUkQLvSlQ7ahXgfnB3zj0rsdaKg0uvKTMAcbjdNVWxJI2IL+H38tbczRr9330qG0a7Fr+g/yee
 SAdm9Acog1PrBW5Cv1YM80RHNpYhdFs0yszT+ilNHhrhW9TH5yXaAORfzMtRaIgpaZsv4kUTcbg
 NVMW2zlHQl5b2BSZSZjp5gzHa9LZMbXB+e6lCJRrIsA/A==
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

Hi Heiko,

Am 14.02.26 um 05:56 schrieb Heiko Schocher:
> 
> - small DTS fixes
> - add wget and bootcounter command
> - Environment changes
>    - introduce protected Environment
>    - a lot of fixes and tries to simplify environment
>      as it has grown over the years.
> 
> Some patches has changes in environment text file with
> long lines, ignored the checkpatch warning for these
> added commit note in the individual patches.

Why don't you fix the warnings in a separate commit first?

Line breaks in environment files are easy to add and significantly 
improve readability.

If you need an example, you can take a look at the following environment 
variables file:
/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env

> 
> Changes in v2:
> - rebased to mainline
>    b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
> - respell the commit message as Peng suggested
> Added Reviewed-by from Peng
> Added Reviewed-by from Peng
> Added Reviewed-by from Peng
> Added Reviewed-by from Peng
> Added Reviewed-by from Peng
> enhanced commit message
> Added Reviewed-by from Peng
> fixed typos in commit message and board code
> Added Reviewed-by from Peng
> Added Reviewed-by from Peng
> Added Acked-by from Peng, fixed typo in commit message
> Added small fixes in Environment from Adrian: It fixes a serious bug which
> Adrian detect. It occurs when a broken firmware is applied as a downgrade.
> The old bootloader ended up in an endless reboot boot loop. With this fix
> also the old bootloader is able to reject the update and recover. Also
> slightly reworked bootcmd.
> Added Reviewed-by from Peng
> Reworked writeable variable list, as we dropped patch
> "env: add w flags for net config in explicit write mode"
> 
> Adrian Freihofer (3):
>    siemens: capricorn: set max-frequency for usdhc1
>    siemens: capricorn: rework bootcmd environment variables
>    siemens: capricorn: protect environment
> 
> Heiko Schocher (3):
>    capricorn: config: add bootcounter command
>    siemens: capricorn: add logic to U-Boot to avoid zig-zag boot
>    siemens: capricorn: always detect emmc device
> 
> Lukas Stockmann (3):
>    arm: dts: capricorn: pinctrl_usdhc1 cleanup
>    arm: dts: capricorn: remove pinctrl_usdhc2
>    arm: dts: capricorn: move fec2 config
> 
> Walter Schweizer (2):
>    imx8qxp_capricorn config: add wget command
>    siemens: capricorn: fix fallback bootm call for fitImage
> 
>   arch/arm/dts/imx8-capricorn-cxg3.dts          | 44 ++++++++++++++
>   arch/arm/dts/imx8-capricorn.dtsi              | 60 +------------------
>   board/siemens/capricorn/Kconfig               |  2 +
>   board/siemens/capricorn/board.c               | 56 ++++++++++-------
>   board/siemens/capricorn/capricorn_default.env | 17 +++---
>   configs/imx8qxp_capricorn.config              |  3 +
>   include/configs/capricorn-common.h            | 13 ++++
>   7 files changed, 106 insertions(+), 89 deletions(-)
> 

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

