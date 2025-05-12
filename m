Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D7C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 08:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F198091A;
	Mon, 12 May 2025 10:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="gqWK2AJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5171E82162; Mon, 12 May 2025 10:22:59 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06104805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 10:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1747038141;
 bh=uvo4OrsL2vQnyNLhtSEC6Wg7hjVEHN4THoTudmMBGmo=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=gqWK2AJc39q7YYlJCeexliNaWWQeOZiPEUoeaG6rkis/NB2LsvOFumBwMNDw2TkY4
 MtCFkGT50lL1kg9dp36oiEX6HPeultp1SHtFym9xV25oln/EVIArFp4QGONBNfcTvC
 hZeta3xs9F84OAQbr1PCqr5FV240iL4tWF+h8ptwQsRz8zJfRGBhqpZyXHqLi8UD9+
 UuKukCb3Xojso4h1cPtWnxR4jm/OhoijMS1vbvvVtzq4wNNhL/m8rOosax24NGZoyd
 dUIz3s3fI5JQvjZQI5jtvgF6WM+KPlLpORun2Kzi170ibW18lxnRw/TDO3LsBJQq2H
 OVrM+DlT6W/0w==
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
Thread-Index: AQHbwRTicAaSbjFs1ESxcWoUNFnGWrPOfcGAgAAp0/A=
Date: Mon, 12 May 2025 08:22:19 +0000
Message-ID: <10712670b2bf422dbda67be449b0107a@dh-electronics.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
 <aCGlPXMozNUty7R-@smile.fi.intel.com>
In-Reply-To: <aCGlPXMozNUty7R-@smile.fi.intel.com>
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
Sent: Monday, May 12, 2025 9:38 AM
> On Fri, May 09, 2025 at 09:00:40PM +0200, Christoph Niedermaier wrote:
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
>=20
> What is the binary size increase with this change, please?

I don't know exactly which binary size I should look at?
I have looked at the object file of nvedit.c:

I built it with the config dh_imx6_defconfig.

Before my patches:
$ ls -la cmd/nvedit.o=20
-rw-r--r-- 1 developer developer 57644 May 12 10:03 cmd/nvedit.o

After my patches:
$ ls -la cmd/nvedit.o=20
-rw-r--r-- 1 developer developer 59292 May 12 10:06 cmd/nvedit.o

So the increase is 1648 Bytes (+2.86%).


Regards
Christoph
