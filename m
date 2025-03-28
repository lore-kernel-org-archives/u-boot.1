Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B5CC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75E981EC9;
	Fri, 28 Mar 2025 13:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NqI5tw/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064C581DCC; Fri, 28 Mar 2025 09:39:28 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4451581A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD98A20485;
 Fri, 28 Mar 2025 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743151164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/f00pyk/ZPL3K3deJB8DVzOy/xBzl14TJYlPN3pl8U=;
 b=NqI5tw/lV2qwAYvoPFHCZgp5M21n7SuibMo1qnb+RIZEBunprEKzVbRce5ynajmn44lf9/
 sGf65hgqdeyS7G/Z2T9cVKEEvkAyj3I0wiX/imYvkTeDeYTBS1pS/dxPu8BDCfAIIqV7DL
 +KOP1Y9ZpBl4uy/9g64n2hzyYuRkvMJKdH1U0TLP4IZ/1fOCEwHcG0nm7CK3wIeHyartut
 hua5pc3B2a0pP+juli4XlIVvPEOW7SoBoGaO1zccR1zTRZm+7gEF7povqIEp4JL+POzx0V
 UE5PeFUK2ZJhIYqVMuDwFhEwmMN5VjmJrYkNau6Tk1YttDqXaKU99sMktdodNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>,  Svyatoslav Ryhel
 <clamor95@gmail.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon Chung
 <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean Anderson
 <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Peng Fan
 <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
In-Reply-To: <20250327141442.GO93000@bill-the-cat> (Tom Rini's message of
 "Thu, 27 Mar 2025 08:14:42 -0600")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 <87pli3q1j9.fsf@bootlin.com>
 <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
 <20250327141442.GO93000@bill-the-cat>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Mar 2025 09:39:23 +0100
Message-ID: <87r02hlfb8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeugeetudduudfhuedugeeuteelfedvveefhfdvfeffledtjeetieeiheefgffhfeenucffohhmrghinhepuggvnhigrdguvgdprgiiuhhrvgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrm
 hhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggv
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 28 Mar 2025 13:42:48 +0100
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

On 27/03/2025 at 08:14:42 -06, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Mar 27, 2025 at 10:31:18AM -0300, Fabio Estevam wrote:
>> Hi Miquel,
>>=20
>> On Wed, Mar 26, 2025 at 12:01=E2=80=AFPM Miquel Raynal
>> <miquel.raynal@bootlin.com> wrote:
>>=20
>> > I rebased this work on the latest next, fixed the conflicts, adapted my
>> > changes to use Svyatoslav's work, fixed the CI.
>>=20
>> v5 still fails in CI:
>>=20
>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25364
>
> And the exact failure is:
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1078073#L259
>
> Which looks like a series conflict or test needing to be updated, rather
> than a "what the heck???" kind of failure like before.
>
>> > Then I pushed a PR to trigger azure tests and figured out you applied =
more
>> > patches (imx8 clock related) which conflicted. So I rebased again and
>> > fixed the conflicts.
>> >
>> > Azure testing is failing though. I just pushed an empty branch with ju=
st
>> > today's 'next' and it is already failing, my series does not produce
>> > additional warnings as far as I can see.
>> >
>> > So I am sending a series that has been tested locally. dm unit tests
>> > pass, v5 is on its way.
>>=20
>> If I remove your series, I don't see any test failure:
>>=20
>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25365
>>=20
>> I don't know about the Azure failure. Please work with the team and
>> make sure v6 passes in CI.
>
> I see that the Azure failure is:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10824&view=
=3Dresults
> which was the unfortunate "next is broken because master has a fix and
> next has a test that needed updating now" that happened this week with
> -rc5 being merged. Sorry about that, it's fixed now.

Yes, my question got lost somewhere else, so let me ask here as well.

I need the tests to run on the test.dts and not the default sandbox.dts.
The documentation states to use -T for that when doing the checks
locally. Unfortunately, the Azure pipelines do use the default sandbox
DT. I can add few mostly useless nodes to the default DTS for the tests
to pass, but I feel like this is not the correct approach.

Is there a way to tell Azure to run some of the unit tests (especially
the DM ones) only with the test DT?

Thanks,
Miqu=C3=A8l
