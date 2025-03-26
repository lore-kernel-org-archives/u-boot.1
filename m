Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACA7C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B83E81F7E;
	Thu, 27 Mar 2025 05:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ge6OAG+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189B881951; Wed, 26 Mar 2025 16:22:56 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1898070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DBFD441C3;
 Wed, 26 Mar 2025 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743002572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRuMv/AQWVAHvhA3iSmRvbQZOPCVkRWjEHQ/pP679sM=;
 b=Ge6OAG+e+ohB2Q/bJsQ2/N434z1VZf6HOUEJeEIe9+RpnXHqoF71ffQaAifniy5Z07jW/R
 Zu8Bfm+6EMTvX3rvdaaxIDHMuA72XZiX2nNcsNerWda5ggImhQyCKu2wSloE22h4iO3qis
 akPS/OVJbG4d4Qi5BLfn45yLByzPtDpU4sOJDM03V/y6NJbQQRd2Yx0RJhB2g4g3rDuCny
 oodEpeHLXHwonMknDvO854i5NPWUdh4iU73lm4ptvwQaZjR/sm62ykltsTyZ3C1mBoOXFC
 oGPxQAFTp3C9GMjPPBUHYsB/Llgiw0F18O0/7xyKFFxHPA1GfiqscR0ss2gDMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Svyatoslav
 Ryhel <clamor95@gmail.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 00/12] Add imx8mp video support
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 (Miquel Raynal's message of "Wed, 26 Mar 2025 16:00:44 +0100")
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 16:22:51 +0100
Message-ID: <87h63fq0j8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefiedtveetueehkeeuheelhfffleeuudehfedvfeegueeffeehhefgvdelueejteenucffohhmrghinheprgiiuhhrvgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtt
 hhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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


> - Fixed the tests, again.

I observe that the doc explicitly says that we should run tests
(specifically the DM tests) using -T to use the test.dts DT
instead of the default -D sandbox.dts.

However Azure pipelines do not use the test device tree and obviously
fail sometimes:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10823&view=3Dl=
ogs&j=3D1b505e53-b56b-5aa3-debb-1f30f6ef305e&t=3Dd20c71d4-f145-577a-cd4d-4c=
d8ed956b7a

Is there a trick to tell the pipelines to just use the test device tree tha=
t I missed?

Thanks,
Miqu=C3=A8l
