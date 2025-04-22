Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B17BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8750381B4B;
	Tue, 22 Apr 2025 14:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="o6uUDJoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2C58171B; Tue, 22 Apr 2025 10:45:20 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A2980EE5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44FD341E0D;
 Tue, 22 Apr 2025 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745311517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fP7kpORqgwjNthoR1HIaw6Dy3OaXgwP39GSXR8fRjvI=;
 b=o6uUDJojCZTNlurlptAbW1ADAXfnt0Ul+AWlggdmExbJsp7cHRf7hwsXmvx9muTsvophFa
 fbG/EXeAF7H2ujii/1JGo53fqhXftxV7CoYUhdmg87fC0wM/AF41/N/kmI+9Y9F48H2OF9
 OAWkTvgd6b5wDpNe81pEiASdWhxi+vhCBv8zhUb9eje7qyAjZtJW3kOb1UN90MQnASs2DU
 3177QYR5Tn1ARvnHIoEy+i5PxIgDVnzxK4jGiqo6IXGE6gRXXIGJFhFyfeOq4J2h/XBiLI
 zKYxDQPO6+DSPi4SmbfJcgPnzzT+6ldsdOTOSUEdjiXuHtBgRf6M9PspaqAF5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Wadim Egorov <w.egorov@phytec.de>,  u-boot@lists.denx.de,
 upstream@lists.phytec.de,  trini@konsulko.com,  jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org,  thomas.petazzoni@bootlin.com,
 ian.ray@gehealthcare.com,  dario.binacchi@amarulasolutions.com,
 aford173@gmail.com,  seanga2@gmail.com,  nm@ti.com,  francesco@dolcini.it
Subject: Re: [PATCH] Revert "power-domain: Add refcounting"
In-Reply-To: <CAFLszThLdBepQ+utC33iOJDO0da3u7o3zrH_nFKkJt8aPcpbdg@mail.gmail.com>
 (Simon Glass's message of "Fri, 18 Apr 2025 11:19:28 -0600")
References: <20250417115311.1905411-1-w.egorov@phytec.de>
 <87mscendw3.fsf@bootlin.com>
 <CAFLszThLdBepQ+utC33iOJDO0da3u7o3zrH_nFKkJt8aPcpbdg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 22 Apr 2025 10:45:15 +0200
Message-ID: <87plh4k2jo.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrheeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehuphhsthhrvggrmheslhhishhtshdrphhhhihtvggtrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjhhektddrt
 ghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Tue, 22 Apr 2025 14:35:50 +0200
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

>> This sadly needs to get in, there have been 3 or 4 reports already, as
>> many boards are broken. We need to find another way to add refcounting
>> (otherwise some imx8* features will stay broken), but it requires more
>> thinking time.
>>
>> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> We had this discussion on your patch and you ended up with a
> 'low-level' function to provide the base functionality. But it would
> be easier if you retained the current behaviour and then added
> ref-counting to two new functions. Then people can migrate.

It's not the fact that people are using refcounting which breaks. It is
the fact that the device model does not support well the fact that one
DT node might be used to picture several devices. The clock subsystem
handles that by registering all clocks manually, and at some point
abuses one of the uclass internal structures (there is a FIXME about
that). It's not even the drivers that break.

> Of course, people perhaps won't migrate. This sort of thing is quite
> tricky. But I still think this would be an easier route. You could
> perhaps even add a Kconfig option like POWER_DOMAIN_NO_REF_COUNT which
> uses the current behaviour.

I now have an idea how to improve the power domain uclass to make it
fit, let's see if that works, otherwise I might fallback to this
solution indeed.

Thanks,
Miqu=C3=A8l
