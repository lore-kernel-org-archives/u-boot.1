Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC4C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 15:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B5C80C83;
	Mon, 12 May 2025 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="IXg9VZyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478E081DD6; Mon, 12 May 2025 17:22:23 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA14805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 17:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1747062916;
 bh=Krj+tr1cYGmKKkfGHI/aggYbMav+VevjOnIFM1s8X8g=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=IXg9VZyzW36uPXNSR1dPWoL6OjznA6wRb2FSYUn7fszbKfNHJPDM0LC4OvGh97mAa
 +NkQ1581weeI2fBf8wDgLnpBb/miiCb0Y0mKqlf7Z8ohghbDx+ylDjwzbfIiYxNjH0
 KBPV+WPHeiFxH1i7xCBAkYODRTwbpVhw+CSkF5YqFHv2ipO0hZR0UppPu4mYaJUn0t
 iNBCPTgLKXyngS0169ZFnuIQiv+u2ruT9p43531Z90W7AAsvOk6GJo7YaqksJwuYIR
 XYNYZX9dFPQWrIWCbbv8KP13etVcA216SwNY/yVzjaorDvcwEPedj/68sZnTvFbZ5t
 J18aqNlJLbEZA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: RE: [PATCH V3 0/3] cmd: env: select: Add output for available
 environment targets
Thread-Topic: [PATCH V3 0/3] cmd: env: select: Add output for available
 environment targets
Thread-Index: AQHbwRTicAaSbjFs1ESxcWoUNFnGWrPOfcGAgAAp0/D//+cyAIAAi7sQ
Date: Mon, 12 May 2025 15:15:06 +0000
Message-ID: <bd2e8c8f75a74a509653351208abf4d8@dh-electronics.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
 <aCGlPXMozNUty7R-@smile.fi.intel.com>
 <10712670b2bf422dbda67be449b0107a@dh-electronics.com>
 <aCGzhJPzGuL2i-mt@smile.fi.intel.com>
In-Reply-To: <aCGzhJPzGuL2i-mt@smile.fi.intel.com>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sent: Monday, May 12, 2025 10:38 AM
> On Mon, May 12, 2025 at 08:22:19AM +0000, Christoph Niedermaier wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Sent: Monday, May 12, 2025 9:38 AM
>>> On Fri, May 09, 2025 at 09:00:40PM +0200, Christoph Niedermaier wrote:
>>>> Add the "-l" parameter to the "env select" command to print the availa=
ble
>>>> environment targets, convert all argument parsing in the file nvedit.c=
 to
>>>> getopt() and check that with unit tests.
>>>>
>>>> The first patch converts the parsing of arguments to getopt() for all =
env
>>>> commands. The second one adds unit tests for checking the env command.
>>>> These were used to check the env commands before and after the convers=
ion.
>>>> The third patch adds the actual new parameter "-l" for the "env select=
"
>>>> command.
>>>
>>> What is the binary size increase with this change, please?
>>
>> I don't know exactly which binary size I should look at?
>> I have looked at the object file of nvedit.c:
>>
>> I built it with the config dh_imx6_defconfig.
>>
>> Before my patches:
>> $ ls -la cmd/nvedit.o
>> -rw-r--r-- 1 developer developer 57644 May 12 10:03 cmd/nvedit.o
>>
>> After my patches:
>> $ ls -la cmd/nvedit.o
>> -rw-r--r-- 1 developer developer 59292 May 12 10:06 cmd/nvedit.o
>>
>> So the increase is 1648 Bytes (+2.86%).
>=20
> U-Boot binary. And better to use bloat-o-meter script for that, it shows =
the
> breakdown in more precise terms.

With bloat-o-meter it looks like this (before and after my patches):

./bloat-o-meter -p arm-linux-gnueabihf- u-boot_before u-boot_after
add/remove: 5/1 grow/shrink: 4/2 up/down: 1152/-652 (500)
Function                                     old     new   delta
bdinfo_print_all                               -     404    +404
__getopt.constprop                             -     292    +292
substitute                                     -     156    +156
print_eth                                      -     124    +124
print_bi_dram                                  -      72     +72
do_env_default                               116     152     +36
do_env_import                                424     456     +32
do_env_print                                 740     764     +24
do_env_delete                                 92     104     +12
do_env_export                                336     328      -8
substitute.lto_priv                          156       -    -156
do_bdinfo                                    580      92    -488
Total: Before=3D501681, After=3D502181, chg +0.10%


Regards
Christoph
