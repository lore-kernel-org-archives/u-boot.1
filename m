Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CBEC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 04:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C8F884EA;
	Thu, 23 May 2024 06:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Rn/SZoUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBE6884B2; Thu, 23 May 2024 06:12:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEA888013
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 06:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44N4CaiT078829;
 Wed, 22 May 2024 23:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716437556;
 bh=J6ID91glU6Vjr3XSJKNiMPmVZbjwAfw6qTQcI/XMDvU=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=Rn/SZoUGFBpwrdOrwWj8VXy2DFvcY/IyfGZ+HdzKpKWiq4lR7gtvVbdXM47BEzdSZ
 ncj5+50hSSUi+3sB0G6WKEOj/pvMXn/LgJ+z3p1rfsbIQBNiA9qYspw24ru+bd/6sa
 gXyVzH1NbOhcxpnOXRoFp6EGUatSVgQ1W7h44gjk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44N4CatK037417
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 23:12:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 23:12:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 23:12:35 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44N4CZ3t067064;
 Wed, 22 May 2024 23:12:35 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 "Christian Gmeiner" <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, "Andrew Davis" <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, "Siddharth Vadapalli"
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, "Bryan Brattlof"
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/7] dts: beagleplay: binman: Include firmware
 capsules binman nodes
In-Reply-To: <20240522141048.GG2568172@bill-the-cat>
References: <20240419212819.170033-1-j-humphreys@ti.com>
 <20240419212819.170033-5-j-humphreys@ti.com>
 <20240510173200.GV2568172@bill-the-cat>
 <86o78yd1ud.fsf@udb0321960.dhcp.ti.com>
 <20240522141048.GG2568172@bill-the-cat>
Date: Wed, 22 May 2024 23:12:35 -0500
Message-ID: <86jzjlcgjw.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Tom Rini <trini@konsulko.com> writes:

> On Tue, May 21, 2024 at 09:20:26PM -0500, Jon Humphreys wrote:
>> Tom Rini <trini@konsulko.com> writes:
>> 
>> > On Fri, Apr 19, 2024 at 04:28:16PM -0500, Jonathan Humphreys wrote:
>> >
>> >> Fill in the BeaglePlay's capsule GUID properties of the base binman capsule
>> >> nodes.
>> >> 
>> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >> ---
>> >>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 27 ++++++++++++++++++++
>> >>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 15 +++++++++++
>> >>  2 files changed, 42 insertions(+)
>> >
>> > This series introduces failure to build in CI, and it's a little tricky
>> > to replicate locally, depending on your environment. You first need to
>> > NOT have BINMAN_INDIRS set and instead be using fake binaries. Second,
>> > it seems python version dependent perhaps? I don't see this on my host,
>> > but by:
>> > - Using the CI container
>> > - Setting up a virtualenv inside of it
>> > - pip install -r tools/buildman/requirements.txt
>> > I get:
>> > $ ./tools/buildman/buildman --keep-outputs --reproducible-builds -dvel --force-build -PEWM --output /tmp/am62x_beagleplay_r5 --board am62x_beagleplay_r5
>> > Building current source for 1 boards (1 thread, 12 jobs per thread)
>> >        arm:  +   am62x_beagleplay_r5
>> > +(am62x_beagleplay_r5) Image 'tiboot3-am62x-gp-evm.bin' is missing optional external blobs but is still functional: ti-fs-gp.bin
>> > +(am62x_beagleplay_r5)
>> > +(am62x_beagleplay_r5) /binman/tiboot3-am62x-gp-evm.bin/ti-fs-gp.bin (ti-sysfw/ti-fs-firmware-am62x-gp.bin):
>> > +(am62x_beagleplay_r5)    Missing blob
>> > +(am62x_beagleplay_r5) binman: object of type 'NoneType' has no len()
>> > +(am62x_beagleplay_r5) make[1]: *** [Makefile:1126: .binman_stamp] Error 1
>> > +(am62x_beagleplay_r5) make: *** [Makefile:177: sub-make] Error 2
>> >     0    0    1 /1              am62x_beagleplay_r5
>> 
>> Tom, this is failing in the CI container because the container is missing
>> the mkeficapsule tool.
>> 
>> To solve this, we just need to add it to the CI container.
>> 
>> My understanding of binman's handling of missing bintools is that it should
>> gracefully continue with fake data, so that buildman can successfully test
>> out builds for boards even when you don't have all the required bintools.
>> If I have that correct, I can also create a patch to properly handle this
>> when using mkeficapsule. But I want to verify this is the desired behavior,
>> since mkeficapsule isn't a unique or vendor specific tool, so shouldn't we
>> require it as part of the U-Boot build environment and err out if it is
>> missing?
>
> Perhaps it's a binman issue since we build mkeficapsule or at least
> should be? Neha?
>

Never mind - I figured it out.

The mkeficapsule tools is built by u-boot if TOOLS_MKEFICAPSULE config is
set. I didn't explicitly set it because it is implied by
EFI_CAPSULE_ON_DISK config. But this is only set for the A core u-boot, as
that is what would apply the capsules. SPL running on the R cores does not
need this. But that then means that the R core u-boot builds don't have
TOOLS_MKEFICAPSULE set and if that is all that is being built (as in the
case of buildman), the mkeficapsule tool isn't built and so is missing.

So I need to explicitly set TOOLS_MKEFICAPSULE in the R core defconfigs.
I'll repost the patches.

Thanks for catching the bug,
Jon

> -- 
> Tom
