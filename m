Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461DFC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DEA83678;
	Fri, 18 Jul 2025 19:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="uP8UinCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179AC83692; Fri, 18 Jul 2025 19:17:12 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C17834EC
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1752859003;
 bh=6CROeabS+W1cVykibjIiwqwcuKG5kG4TIFhTohSB0MI=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=uP8UinCZwtWKb7DxnOOqqPnxO+GabwNCOCehb2EaFfeyKcpl7F7AUwYqGe4Xja3ev
 3KZjbafX/6GnXLeXwI3sNvL10rF04ra+UrV3Zz3WKCmF3TCzIfawFEN0yjJz8CF9Ka
 oHGXIqubQCMTp2Z3sSpas7Jlo+/Av5hcF6FJa79iguTgPN2NwNQZNlaTRMc+5MRYro
 NkHNDJBko+NvomQ7HZ8TFCPQwWaRbeGei579bfzgDfL4W6bMytO/izAyMXiLo680bi
 v2CloPt7fAZhVDBjDM2h7L10Y81k435OHgi5Q3NmcWOnbiMKEFK/5A0q5HZc/fEzSt
 koI7xHs8nnBlA==
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
Thread-Index: AQHb6dGg1PMbxiI2V0e6dQQ7cHE56LQqhxUAgAKY0NCAAADmgIAANquwgArC0bA=
Date: Fri, 18 Jul 2025 17:16:41 +0000
Message-ID: <e7284037388042d089ded45ef18856ef@dh-electronics.com>
References: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
 <20250710015826.GY6424@bill-the-cat>
 <7d8b712b9e71485ca6f057e95f19af1e@dh-electronics.com>
 <20250711174107.GK6424@bill-the-cat>
 <073f00355c2d490ab8242e129d662ecf@dh-electronics.com>
In-Reply-To: <073f00355c2d490ab8242e129d662ecf@dh-electronics.com>
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

From: Christoph Niedermaier
Sent: Friday, July 11, 2025 10:57 PM
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, July 11, 2025 7:41 PM
>> On Fri, Jul 11, 2025 at 05:37:55PM +0000, Christoph Niedermaier wrote:
>>> From: Tom Rini <trini@konsulko.com>
>>> Sent: Thursday, July 10, 2025 3:58 AM
>>>> Subject: Re: [PATCH V4 0/3] cmd: env: select: Add output for available=
 environment targets
>>>>
>>>> On Mon, Jun 30, 2025 at 05:12:29PM +0200, Christoph Niedermaier wrote:
>>>>
>>>>> Add the "-l" parameter to the "env select" command to print the avail=
able
>>>>> environment targets, convert all argument parsing in the file nvedit.=
c to
>>>>> getopt() and check that with unit tests.
>>>>>
>>>>> The first patch converts the parsing of arguments to getopt() for all=
 env
>>>>> commands. The second one adds unit tests for checking the env command=
.
>>>>> These were used to check the env commands before and after the conver=
sion.
>>>>> The third patch adds the actual new parameter "-l" for the "env selec=
t"
>>>>> command.
>>>>>
>>>>> Christoph Niedermaier (3):
>>>>>   cmd: nvedit: Convert the parsing of arguments to getopt()
>>>>>   test: cmd: nvedit: Add basic unit tests
>>>>>   cmd: env: select: Add output for available environment targets
>>>>
>>>> Can you please make a v5 that's run through CI? I saw that am64x_evm_a=
53
>>>> fails to build now and I'm seeing the tests fail too:
>>>> https://source.denx.de/u-boot/u-boot/-/jobs/1196652
>>>
>>> Sorry, I will have a look at it and make a new version.
>>> Are my patches also the cause of the build issue with am64x_evm_a53?
>>
>> Yes, something in the series was leading to at least that platform and
>> likely many others (I saw that in my local board testing, CI failed the
>> pipeline before getting to the world stage so I don't know all of the
>> ones that failed).
>=20
> OK, then I will also have a look at it.
> Thanks for the clarification.

I have submitted version 5, which should solve the problem with CI. I
could not reproduce the problem when building for am64x_evm_a53. I hope
that it will also be gone with version 5.

Thanks and regards
Christoph
