Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DFACA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D81E82BF6;
	Tue, 19 Aug 2025 11:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="vFkdUTgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7910882CEA; Tue, 19 Aug 2025 11:07:26 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550FB81FEE
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 11:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1755594332;
 bh=fAIWvn4TzpHd9ewnLpBC0hJhN/A/f99XdQXFKhbAHTo=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=vFkdUTgg4eegN4x47V2VhuZPqJr1mIoONLFuZdAd9SoY8U1LQoO3VION746rTi3vI
 vgCoVsFmflEQmnkhneUV5PLaAuc6uisWovJhSDfj9CJ1XxlUfLhB95MNlr3B8zNLPa
 uGwNxFptjG/yy7anTl/radFU4eSRfg6KF9bW7+SS716bc31mwzUvmbLTByeEcq9BGS
 XtESye9QF7Q9kgP8pWVLAnba+py56KV2rM200CnRQMwS1DPdTqCgkcJlb2672e06t5
 ma931nA4a3ohml8gvHzcfNwNCwq5tKvVlOT4sqB2esbwDqULXqsKVsZJC/gaGSQq0+
 4bOltVRH2kpfA==
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
Thread-Index: AQHb+AZ1aKIjc26QW0W3g9DyFQd4ObRH0vwAgAQewvCAAGaTgIAdZuuA
Date: Tue, 19 Aug 2025 09:05:30 +0000
Message-ID: <64672dd94de34a8386bdebe23a250987@dh-electronics.com>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
 <20250728190320.GA1732232@bill-the-cat>
 <3770ea5747c249d49499737f4889f177@dh-electronics.com>
 <20250731160535.GB1807455@bill-the-cat>
In-Reply-To: <20250731160535.GB1807455@bill-the-cat>
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
Sent: Thursday, July 31, 2025 6:06 PM
> On Thu, Jul 31, 2025 at 09:58:27AM +0000, Christoph Niedermaier wrote:
>> From: Tom Rini <trini@konsulko.com>
>> Sent: Monday, July 28, 2025 9:03 PM
>>> On Fri, Jul 18, 2025 at 07:05:58PM +0200, Christoph Niedermaier wrote:
>>>
>>>> Add the "-l" parameter to the "env select" command to print the availa=
ble
>>>> environment targets, convert all argument parsing in the file nvedit.c=
 to
>>>> getopt() and check that with unit tests.
>>>>
>>>> The first patch converts the parsing of arguments to getopt() for all =
env
>>>> commands. The second one avoids stopping unit test on console output
>>>> "## Error: ". The third one adds unit tests for checking the env comma=
nd.
>>>> These were used to check the env commands before and after the convers=
ion.
>>>> The fourth patch adds the actual new parameter "-l" for the "env selec=
t"
>>>> command.
>>>>
>>>> Christoph Niedermaier (3):
>>>>   cmd: nvedit: Convert the parsing of arguments to getopt()
>>>>   test/py: Avoid stopping the test on console output "## Error: "
>>>>   test: cmd: nvedit: Add basic unit tests
>>>>   cmd: env: select: Add output for available environment targets
>>>
>>> I'm sorry, but it seems like a lot of the tests fail in CI?
>>> https://source.denx.de/u-boot/u-boot/-/jobs/1209804
>>> https://source.denx.de/u-boot/u-boot/-/jobs/1209794
>>> For example.
>>
>> I think I fixed my test, but broke other tests in the process.
>> I'm very sorry. I will try to fix the problem, but it is difficult
>> to reproduce the entire CI locally. I will try my best, sorry again.
>=20
> You can trigger CI runs too via GitHub / Azure, BTW:
> https://docs.u-boot.org/en/latest/develop/ci_testing.html

Thanks for your support. I'll take a look at it, but sorry,
I can't get to it right now.


Thanks and regards
Christoph
