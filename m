Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48BCC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BFD836F0;
	Thu, 31 Jul 2025 11:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="GxgEp9MH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C991837F2; Thu, 31 Jul 2025 11:59:32 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487EA83623
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1753955910;
 bh=3e/+aHZCTrHb0k+Nj89s7Z4UaDPJPIsdvqO393ou70w=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=GxgEp9MHxAuagzOWyU8Fd2BgwutC/HNjzt732+ES0GT+1qT5sVRFC+GexRxHEqXKn
 ZgDcaoJ5glmmOX9RE7JsQEfv7KDhEq/l1ZmTKEsHHo4/wP9VuCTRNFuaL9ZrOWi5Ru
 eRgQ4lVMH57ytOYzGEdMGOv4+cH/Bqupj8P2UYzmyp2DyzIPgZWzUNPZSrHr3JctDU
 41FS5sMQECFGmsw0hKHJtuGL5bzevDufwus/Un9x5gL16Viuo6LqpFpPrNIzfJemBs
 QWTJC/HaDSxjuvvFdvIYQ9p4jqv+s8o2rwAOxqiZ79eb+kSIomqrRXzLuAwrHuPa0u
 haovXZ+5L3DUA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Casey Connolly
 <casey.connolly@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?iso-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: RE: [PATCH V5 0/4] cmd: env: select: Add output for available
 environment targets
Thread-Topic: [PATCH V5 0/4] cmd: env: select: Add output for available
 environment targets
Thread-Index: AQHb+AZ1aKIjc26QW0W3g9DyFQd4ObRH0vwAgAQewvA=
Date: Thu, 31 Jul 2025 09:58:27 +0000
Message-ID: <3770ea5747c249d49499737f4889f177@dh-electronics.com>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
 <20250728190320.GA1732232@bill-the-cat>
In-Reply-To: <20250728190320.GA1732232@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
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
Sent: Monday, July 28, 2025 9:03 PM
> On Fri, Jul 18, 2025 at 07:05:58PM +0200, Christoph Niedermaier wrote:
>=20
>> Add the "-l" parameter to the "env select" command to print the availabl=
e
>> environment targets, convert all argument parsing in the file nvedit.c t=
o
>> getopt() and check that with unit tests.
>>
>> The first patch converts the parsing of arguments to getopt() for all en=
v
>> commands. The second one avoids stopping unit test on console output
>> "## Error: ". The third one adds unit tests for checking the env command=
.
>> These were used to check the env commands before and after the conversio=
n.
>> The fourth patch adds the actual new parameter "-l" for the "env select"
>> command.
>>
>> Christoph Niedermaier (3):
>>   cmd: nvedit: Convert the parsing of arguments to getopt()
>>   test/py: Avoid stopping the test on console output "## Error: "
>>   test: cmd: nvedit: Add basic unit tests
>>   cmd: env: select: Add output for available environment targets
>=20
> I'm sorry, but it seems like a lot of the tests fail in CI?
> https://source.denx.de/u-boot/u-boot/-/jobs/1209804
> https://source.denx.de/u-boot/u-boot/-/jobs/1209794
> For example.

I think I fixed my test, but broke other tests in the process.
I'm very sorry. I will try to fix the problem, but it is difficult
to reproduce the entire CI locally. I will try my best, sorry again.

Regards
Christoph
