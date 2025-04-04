Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797EC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 12:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD885828AB;
	Fri,  4 Apr 2025 14:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="f0MOOql2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6780828BC; Fri,  4 Apr 2025 08:22:38 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D4681F44
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 08:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FAC2442B4;
 Fri,  4 Apr 2025 06:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743747755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usQ7xxgVLrTvTW3GHmz0IjimN2nBzus8DIUpkQDKsmg=;
 b=f0MOOql2MY8hPIgKELyn3HuaGcc2SRrlIlnmg3mITLA+geHGxViPjZviuT7SfqDIrPDsfj
 RPN5R6uEjoYUlfBN3haFVMw9cWny45YXlizDFgeFMi3i9thFJa3dhesCUMjXIA6g6+AvAi
 dOypwMjl+iJA6FuopDPGn69sJuQWIaI3dhPgFIwRD8rBxBgS6Ho4Oi8ke/Ul9mjE4mU+NI
 KVNOjOoBh//Pg+Cnm6eYGkbRjLAXG7QmzGlJAdAFQHC4wK3GrJQ4EmPVfarOKKR858xijY
 qiDHYEONU09Lo5BzQsQa5F7iH3QZK6j9MINA5Hrer+3kljxgoAlxIH07/urTPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 12/12] video: imx: Add LCDIF driver
In-Reply-To: <CAHCN7x+NnM3TPS84uWRQavs15D8vta4nU+EppbAtvgi=inr7Fw@mail.gmail.com>
 (Adam Ford's message of "Thu, 3 Apr 2025 08:01:19 -0500")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-12-478b5e3dd872@bootlin.com>
 <CAHCN7x+NnM3TPS84uWRQavs15D8vta4nU+EppbAtvgi=inr7Fw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 04 Apr 2025 08:22:33 +0200
Message-ID: <871pu81m52.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrgeelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrfhhorhguudejfeesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrt
 ghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 04 Apr 2025 14:35:35 +0200
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

Hi Adam,

> since there are three instances of this LCDIF, when most other boards
> have just one, do you know what happens if someone's device tree has
> all three enabled? Is the video mirrored, or does it just go to one of
> the instances?

IIRC they are not connected to the same outputs, there is one for MIPI
DSI, one for LVDS displays and one for HDMI. The LVDS instance is
connected to a bridge (called LDB) which may join or mirror two LVDS
displays.

Thanks,
Miqu=C3=A8l
