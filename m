Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E85CC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7443F81B4B;
	Tue, 28 Jan 2025 09:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oGh/vxYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F6A81BC0; Tue, 28 Jan 2025 09:57:01 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03FA8197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BDEA4418E;
 Tue, 28 Jan 2025 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1738054618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHgbSDwkCYAmLrXgxJ+PqYkf/1zLJXBAyU761ANpRzQ=;
 b=oGh/vxYFLyVOVuoDSJNtLI6Ta6Wd12j46/UsTwPOMPD3Hr3XJR73eqKp7ETvt6uGBuF52n
 faYOPmwZwj6cr2AGVtgZR2mCSJMOLzIXGLxKpEIdBT4xQP24jLMXBzOYIKbc0ScTT4uVHA
 bBYu67ZLL/0wZ5/urpFeoOnONtMqVbBxg34bvvNK80PvmykYP8a0w5s0o3JoMbIWrfHgZO
 eMQh8SF2f/J5mZxL3edRhwS/g1Ngpyno9peXEl6GRM0CRCw2g6eZ9U0/AH3EnxylYdOAYl
 /kMNSLMorXFNbNV9DJWbi5LXTvcTM2PPxqgXTSd0Uu7cNwNXUaDfu4JnUxQtjw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 05/13] power-domain: Add refcounting
In-Reply-To: <CAFLszTgc1n6t8sp8qV86r8v2PRvKFWDoyh+AYRpQNEU2jtA2aw@mail.gmail.com>
 (Simon Glass's message of "Mon, 27 Jan 2025 10:42:57 -0700")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
 <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
 <87r04sfdcv.fsf@bootlin.com>
 <CAFLszTgjNa3xugV5w1qtgK4MxsHyzCHUPZJqri8RQFDfYiEBEw@mail.gmail.com>
 <87h65k5gib.fsf@bootlin.com>
 <CAFLszTgc1n6t8sp8qV86r8v2PRvKFWDoyh+AYRpQNEU2jtA2aw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 28 Jan 2025 09:56:56 +0100
Message-ID: <87wmef48pz.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrdelkedrheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdelkedrheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpt
 hhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Simon,


Cheers,
Miqu=C3=A8l
