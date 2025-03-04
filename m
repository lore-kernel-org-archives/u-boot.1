Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155EC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCBA81335;
	Tue,  4 Mar 2025 14:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GqmRqIFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F188144A; Tue,  4 Mar 2025 14:55:42 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C695A812C8
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F903432EB;
 Tue,  4 Mar 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1741096519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vd5IVgYnGKFKBKkYbkYc0IUY0JKbl/aLpHT/63TenV8=;
 b=GqmRqIFw17p4Eu7Sb5ruAAlC/H2JUh7IlX+sbBBJPOsN9GxWUHMbkZeNe9hjn9F2veeHLG
 +JkMYUKk0qSmls0eMq57RBpfOH6xNOEIhHfs7Lx4NYsMHCKaa6r92h2I8ZMm6tLCFDyDjg
 lzvbnl7waCNxcGxrDmEDI+n0IW61503xpjsfqBbwFDHQmqC2ADgj/id3oikDU0BAVNqCxa
 aHzlfzkLKUI1yy+5FIl9I11u01ivkcGoj5sAYlMhrWMs6d1EGFa+Z0HSnfumVXKVq93WG3
 cqbNNhgohgTkoKpxZiGRses+/zQ7IQ/OLGopK6q9yMDDPDIOZCRNgNx80OhRAg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>,  Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 05/12] power-domain: Add refcounting
In-Reply-To: <CAFLszThZzGu6p1XnKuBUQTvDi+Q=ySzXirtiUJug9dGGZHrQhg@mail.gmail.com>
 (Simon Glass's message of "Tue, 4 Mar 2025 06:13:46 -0700")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <20250129-ge-mainline-display-support-v4-5-a43b3657ed7c@bootlin.com>
 <CAOMZO5BwB75QnfYKkcnq_kS_7N8yXzLNdpyzcWQ2Jy3zu9V1NQ@mail.gmail.com>
 <87y0xma4ib.fsf@bootlin.com>
 <CAFLszThZzGu6p1XnKuBUQTvDi+Q=ySzXirtiUJug9dGGZHrQhg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 14:55:17 +0100
Message-ID: <87senszyre.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrt
 ghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhm
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


>> >> It is very surprising that such an uclass, specifically designed to
>> >> handle resources that may be shared by different devices, is not keep=
ing
>> >> the count of the number of times a power domain has been
>> >> enabled/disabled to avoid shutting it down unexpectedly or disabling =
it
>> >> several times.

...

>> >
>> > Are you happy with this version?
>>
>> Would you have any feedback on this? I believe we agreed on the
>> implementation but it's been a month and I didn't heard back from you
>> since then, and I believe Fabio was waiting for your feedback.
>>
>> Thanks a lot,
>> Miqu=C3=A8l
>
> Yes it looks fine to me, thanks.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Great, thanks a lot for the feedback!
Miqu=C3=A8l
