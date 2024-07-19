Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02C8C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 22:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37EF8855C;
	Sat, 20 Jul 2024 00:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8D688B49; Sat, 20 Jul 2024 00:22:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2FAC3884C3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 00:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3CB6169E;
 Fri, 19 Jul 2024 15:22:23 -0700 (PDT)
Received: from [127.0.0.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13EF53F73F;
 Fri, 19 Jul 2024 15:21:57 -0700 (PDT)
Date: Fri, 19 Jul 2024 23:21:54 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
CC: Jagan Teki <jagan@amarulasolutions.com>, linux-sunxi@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_sunxi=3A_dts=3A_arm/arm64=3A_up?=
 =?US-ASCII?Q?date_devicetree_files_from_Linux-v6=2E10?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240717175153.GR561963@bill-the-cat>
References: <20240717143415.343827-1-andre.przywara@arm.com>
 <20240717175153.GR561963@bill-the-cat>
Message-ID: <191A0F66-E2AE-4D1B-ACBE-E411E135BB61@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,
Sorry for top posting, am on the road=2E

First: The Allwinner drivers in U-Boot work with mainline kernel DTs for a=
ges, so there are no code changes required=2E
We manually sync the DTs from the kernel for years, but I always do one ch=
ange:

In kernel v5=2E13 the Allwinner IRQ controller (not the GIC) DT binding an=
d DTs changed in an incompatible way, and some critical devices now route t=
heir IRQ through that controller instead of to the GIC=2E If an older kerne=
l sees such a new DT, some critical devices fail to probe due to that, and =
the kernel does not boot=2E Using the old DT routing fixes that, at the exp=
ense of losing some advanced power saving features=2E
So in the interest of  better compatibility with older kernels and $fdtcon=
troladdr (default for UEFI boot), I always kept the old way during the U-Bo=
ot sync=2E This affects all devices with the popular H3, A64 and H6 SoCs, a=
mong others=2E A20 and older or H616s are not affected=2E

So my plan was to migrate the latter group ASAP (after the v6=2E10 sync), =
and then maybe the others in the next cycle, which means pulling the plug o=
n original Debian Buster kernels, for instance=2E 5=2E13 is three years old=
 by now, so I guess this might be fine now=2E

Does that make sense?

Cheers,
Andre



On 17 July 2024 18:51:53 BST, Tom Rini <trini@konsulko=2Ecom> wrote:
>On Wed, Jul 17, 2024 at 03:34:15PM +0100, Andre Przywara wrote:
>
>> Sync the devicetree files from the official Linux kernel tree, v6=2E10=
=2E
>> This is covering Allwinner SoCs with 32-bit and 64-bit ARM cores=2E
>>=20
>> Besides mostly cosmectic changes, this adds cpufreq support to H616
>> boards, Nothing that U-Boot needs for itself, but helpful to pass on
>> to kernels=2E We also get the =2Edts files for the Tanix TX1 TV box and
>> three Anbernic handheld gaming devices=2E
>>=20
>> As before, this omits the non-backwards compatible changes to the R_INT=
C
>> controller, to remain compatible with older kernels=2E
>>=20
>> Signed-off-by: Andre Przywara <andre=2Eprzywara@arm=2Ecom>
>
>This reminded me I needed to see that v6=2E10-dts is tagged upstream now=
=2E
>So, for the record, when can we move sunxi to OF_UPSTREAM? Or what's
>blocking it? Thanks!
>
>--=20
>Tom
