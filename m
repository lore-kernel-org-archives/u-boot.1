Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD34C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E35D81E8C;
	Fri, 28 Mar 2025 17:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R3f0OmEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BB881E1C; Fri, 28 Mar 2025 17:31:19 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48158144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 221D144342;
 Fri, 28 Mar 2025 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743179474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nm/qE8BPbcDAixFiUPqEiSk/xMoP95VlfIx95J9vtq0=;
 b=R3f0OmEdo2sdv2tpyIAkWiPV0SoNxzggJyUuk4OPMx+jL+R/U9cv4gLgmCXi5B8BL7Y8rW
 aXm/o0BR/DxCEMcgxZSjMWHrJUUlpr6gQlJEd8B/ErnYEOzVKdVdIfJOcsH3s6jUc+uT9h
 X7tA9vI+TREfLssu1fMvY8NlaE+inNEI2s4k5mXnut49KA+t/cDd0O1GWMgOxLAkfGeG7o
 hkIgUd5hDaMTNA6mNiu5uIJGEh5sVNgh8LGtXaEmya9J3AWGAcDk9C1HJ7sv0X0iDSdoTM
 Go7FJMgUwc7skNcMXHbUAnTYKm4iOOxmZzC6jfedGYLBQrFgv/AW3yQTBPW/jQ==
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
In-Reply-To: <20250328155711.GV93000@bill-the-cat> (Tom Rini's message of
 "Fri, 28 Mar 2025 09:57:11 -0600")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 <87pli3q1j9.fsf@bootlin.com>
 <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
 <20250327141442.GO93000@bill-the-cat> <87r02hlfb8.fsf@bootlin.com>
 <20250328155711.GV93000@bill-the-cat>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Mar 2025 17:31:12 +0100
Message-ID: <87r02hdsmn.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefiedtveetueehkeeuheelhfffleeuudehfedvfeegueeffeehhefgvdelueejteenucffohhmrghinheprgiiuhhrvgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghom
 hdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggv
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:32:08 +0100
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

>> > I see that the Azure failure is:
>> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10824&vie=
w=3Dresults
>> > which was the unfortunate "next is broken because master has a fix and
>> > next has a test that needed updating now" that happened this week with
>> > -rc5 being merged. Sorry about that, it's fixed now.
>>=20
>> Yes, my question got lost somewhere else, so let me ask here as well.
>>=20
>> I need the tests to run on the test.dts and not the default sandbox.dts.
>> The documentation states to use -T for that when doing the checks
>> locally. Unfortunately, the Azure pipelines do use the default sandbox
>> DT. I can add few mostly useless nodes to the default DTS for the tests
>> to pass, but I feel like this is not the correct approach.
>>=20
>> Is there a way to tell Azure to run some of the unit tests (especially
>> the DM ones) only with the test DT?
>
> I saw the older email first, sorry. But I think the docs have become
> disconnected from how things have been done practically.

No problem :-) Okay, if using sandbox.dts is the correct way to do, I'll
finally fix the pipelines with the remaining issues and submit a v6.

Thanks a lot for clarifying, it is much appreciated.

Miqu=C3=A8l
