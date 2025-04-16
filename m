Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FFCC369C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF29808AF;
	Wed, 16 Apr 2025 15:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SS1kI1xH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAB88006D; Wed, 16 Apr 2025 15:49:15 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D44F8006D
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GDn9Hq2788327
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 08:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744811349;
 bh=BjlP/RatMA9H6Ei7nnchfsACKHXLQDshKFlULsQuH3I=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=SS1kI1xHoyfgLDZFZtCUPsW8fk1pbU3QEdk8FdvuMew0TgsUyCHSvJxPPmsEerKx7
 RNZr4f8V33nDHHVFJdSP7/70j60VEBWjAdGgIPkDYwfvaPlmJAw52vQPMwQ1nMVceC
 r5v4K1FAKoK8peB4izwM+jCwUxmgqWFbCnrspYvQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GDn9YB129997
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 08:49:09 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 08:49:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 08:49:09 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GDn8CD121085;
 Wed, 16 Apr 2025 08:49:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Apr 2025 19:18:54 +0530
Message-ID: <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
From: Anshul Dalal <anshuld@ti.com>
To: Nishanth Menon <nm@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus>
In-Reply-To: <20250416112418.nod2fut4v77qlmfq@hummus>
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

On Wed Apr 16, 2025 at 4:54 PM IST, Nishanth Menon wrote:
> On 13:00-20250416, Anshul Dalal wrote:
>> The change to ATF's PRELOADED_BL33_BASE[1] requires respective changes t=
o
>> SPL_TEXT_BASE on u-boot side. This is necessary to allow the ATF to jump
>> directly to linux kernel (like in falcon mode) which requires a 2MiB ali=
gned
>> load address[2]. The current address ATF jumps to is 0x80080000 which is=
 not
>> 2MiB aligned.
>>=20
>> Therefore in parallel to the ATF change, this patch set makes the corres=
ponding
>> changes to u-boot. To maintain backwards compatibility with older ATF bu=
ilds
>> (that still use older address of 0x80080000), the patch set also adds a
>> jump-stub which modifies the execution as follows:
>>=20
>> Old ATF -> 0x80080000 -> 0x822000000 (Main domain SPL or kernel image)
>>            jump stub    SPL_TEXT_BASE
>>=20
>> With the following instructions loaded by the jump-stub:
>> ADDR       | Instruction
>> 0x80080000 |   mov x15, CONFIG_SPL_TEXT_BASE (0x822000000)
>> 0x80080004 |   br x15
>>=20
>> Depends on:
>>  * [PATCH v3] configs: set SPL_TEXT_BASE by default for k3 platforms
>>    https://lore.kernel.org/u-boot/20250415095028.446254-1-anshuld@ti.com=
/
>>=20
>> [1]:
>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/37447
>> [2]:
>> "The Image must be placed text_offset bytes from a 2MB aligned base
>> address anywhere in usable system RAM and called there."
>> - Documentation/arch/arm64/booting.rst (linux kernel)
>>=20
>> Anshul Dalal (4):
>>   spl: Kconfig: k3: set SPL_TEXT_BASE to 0x82200000
>>   mach-k3: add a jump stub to support older ATF builds
>>   binman: k3: add jump-stub to tispl.bin
>>   binman: k3: add jump-stub as loadable
>
>
> 	How about u-boot documentation?

I will update that in the next revision along with any feedback I
receive on this patch.

Regards

>>=20
>>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  2 +-
>>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  4 +--
>>  arch/arm/dts/k3-am625-sk-binman.dtsi          |  4 +--
>>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  4 +--
>>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |  4 +--
>>  arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 +--
>>  arch/arm/dts/k3-am62p-sk-binman.dtsi          |  2 +-
>>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  8 ++---
>>  arch/arm/dts/k3-am64x-binman.dtsi             |  8 ++---
>>  arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  2 +-
>>  arch/arm/dts/k3-am65x-binman.dtsi             |  4 +--
>>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  |  2 +-
>>  arch/arm/dts/k3-binman.dtsi                   | 31 +++++++++++++++++++
>>  arch/arm/dts/k3-j7200-binman.dtsi             |  4 +--
>>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  2 +-
>>  arch/arm/dts/k3-j721e-binman.dtsi             |  4 +--
>>  arch/arm/dts/k3-j721s2-binman.dtsi            |  4 +--
>>  arch/arm/dts/k3-j722s-binman.dtsi             |  2 +-
>>  arch/arm/dts/k3-j784s4-binman.dtsi            |  4 +--
>>  arch/arm/mach-k3/Makefile                     |  7 +++++
>>  arch/arm/mach-k3/jump_stub.S                  | 16 ++++++++++
>>  common/spl/Kconfig                            |  2 +-
>>  22 files changed, 89 insertions(+), 35 deletions(-)
>>  create mode 100644 arch/arm/mach-k3/jump_stub.S
>>=20
>> --=20
>> 2.49.0
>>=20

