Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DEDC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2D182B07;
	Fri, 11 Jul 2025 19:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="QT1yUzu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E477982C84; Fri, 11 Jul 2025 19:38:47 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 931328277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1752255487;
 bh=T8QzLf+exKXH2OrZ/+1tbujlzSS3OuVFSzo8hf5VctY=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=QT1yUzu+WLBD4F53qhUTniDxGQSl5+vDwc8NXWjkJN5X7ISoxB9G9tjW44N3VyfLc
 u64jN7rVGxcG8pDp8Q4+J/R68NMADEdeIIzU873kKZUBy2vnkNuCW5nP6MSBaex/Gl
 KMmiC4SoduqyP7IqNfvhMlRyquliDvys//JJqMxokP7D8pqt8kTjtyMalwGZvdxp29
 UPsnTzLBJJMVeGuJ5cDyjgVZwSCKy491a4gExdMLQktTFTAUi+DtrXAGHiJZuUUuVo
 PEdP8i/ynqssWt9CKdFjPgC67YtQSfZIFgLW1/CrI/p7MxcE5lo0IGYgofZIYy4T1P
 Q6LF2s9E6SEdw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: RE: [PATCH V4 0/3] cmd: env: select: Add output for available
 environment targets
Thread-Topic: [PATCH V4 0/3] cmd: env: select: Add output for available
 environment targets
Thread-Index: AQHb6dGg1PMbxiI2V0e6dQQ7cHE56LQqhxUAgAKY0NA=
Date: Fri, 11 Jul 2025 17:37:55 +0000
Message-ID: <7d8b712b9e71485ca6f057e95f19af1e@dh-electronics.com>
References: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
 <20250710015826.GY6424@bill-the-cat>
In-Reply-To: <20250710015826.GY6424@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

From: Tom Rini <trini@konsulko.com>
Sent: Thursday, July 10, 2025 3:58 AM
> Subject: Re: [PATCH V4 0/3] cmd: env: select: Add output for available en=
vironment targets
>=20
> On Mon, Jun 30, 2025 at 05:12:29PM +0200, Christoph Niedermaier wrote:
>=20
>> Add the "-l" parameter to the "env select" command to print the availabl=
e
>> environment targets, convert all argument parsing in the file nvedit.c t=
o
>> getopt() and check that with unit tests.
>>
>> The first patch converts the parsing of arguments to getopt() for all en=
v
>> commands. The second one adds unit tests for checking the env command.
>> These were used to check the env commands before and after the conversio=
n.
>> The third patch adds the actual new parameter "-l" for the "env select"
>> command.
>>
>> Christoph Niedermaier (3):
>>   cmd: nvedit: Convert the parsing of arguments to getopt()
>>   test: cmd: nvedit: Add basic unit tests
>>   cmd: env: select: Add output for available environment targets
>=20
> Can you please make a v5 that's run through CI? I saw that am64x_evm_a53
> fails to build now and I'm seeing the tests fail too:
> https://source.denx.de/u-boot/u-boot/-/jobs/1196652

Sorry, I will have a look at it and make a new version.
Are my patches also the cause of the build issue with am64x_evm_a53?

Regards
Christoph
