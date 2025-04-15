Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2406CC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7833382B07;
	Tue, 15 Apr 2025 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PR1UXCRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21E5829CF; Tue, 15 Apr 2025 11:50:54 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5604582145
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6716343AD8;
 Tue, 15 Apr 2025 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744710651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pklktYNZLN60du+KVGABFNL3qEDS8+E/gwmUzOK8v50=;
 b=PR1UXCRjgY3lOk2lN6DpaVLHchQ6if6En5usrJ2SlBofSeZ1dWb9f9G/u2NhTYp4+xxi9+
 qwdtebAXXGsLvWJa60r3HvrU3fMA+hpK1p2sfXrbKzkpfsh4E+mKu/aGpote5tS9DdK+/d
 /4JrKyUrO8YZc0R+WzGZ0Yxpkr1G0+DAjxj4dtK1xbDpcpcR+7vUiUO/4j5co+06dNqhms
 Zry3+vUlXhyne3oZByuSY6XRYk9aM20fP8LCdXIBCFqBtkKzseMgZ+NdoVa+OSJ30op7kF
 jvdr8PzHDw58d6Z6Q/Imdbn0i3RULAWWwgRcjT7D1j7uPKdXpwP0FKNOrAWC2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,  Tom Rini
 <trini@konsulko.com>,  Nishanth Menon <nm@ti.com>,  Simon Glass
 <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,  Lukasz
 Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,  Anatolij
 Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,  Peng Fan
 <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Svyatoslav Ryhel
 <clamor95@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,  Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
In-Reply-To: <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com> (Neha Malcom
 Francis's message of "Tue, 15 Apr 2025 14:29:21 +0530")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
 <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb> <87wmblyh6j.fsf@bootlin.com>
 <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 15 Apr 2025 11:50:49 +0200
Message-ID: <87sem9wy6e.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelveetiedufedugfejveehvefgvefgvdehleefkedutedtffevhfegjeeggfekkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeelvddrudekgedruddtkedrvdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrvdeftddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepnhdqfhhrrghntghishesthhirdgtohhmpdhrtghpthhtohepfhhrrghntggvshgtohesugholhgtihhnihdrihhtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepnhhmsehtihdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjh
 hektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Tue, 15 Apr 2025 14:50:26 +0200
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

>> Francesco, are you also testing on K3 platforms?
>>=20
>
> Yes he would be, since the firmware print is K3 firmware.
>
>> Can one of you boot with the patch below applied? It should partially
>> revert the commit to the ancient behaviour, while adding more debug
>> traces (please enable the debug logs as well). This should clarify
>> which one of the 3 different path is likely failing. It should also help
>> identify who's the user that fails to enable/disable its own power
>> domain. I will need to know what board/SoC was used for the test, so I
>> can look the relevant driver up.
>
> Booted on j784s4_evm
>
> https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3
>
> Currently debugging on my build where I hang in console_init itself, I
> think the path for failure is different here, will confirm.

Thanks a lot for your feedback. Normally by applying the diff shared in
my previous e-mail, you should have the console back. If not, maybe
there is something else involved and the blamed commit is just the first
showing an underlying problem.

Thanks,
Miqu=C3=A8l
