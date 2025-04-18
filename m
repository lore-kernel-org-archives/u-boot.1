Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE0C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A7183212;
	Fri, 18 Apr 2025 16:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XDtGTrv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B56382D5E; Fri, 18 Apr 2025 09:10:41 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BBB82B7C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 09:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37EE843A55;
 Fri, 18 Apr 2025 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744960238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ve5sPW9FKcDBkqGiQBiUnMbz4ASfB5tibuXGqdFktRU=;
 b=XDtGTrv6CuDQavnuA5Kh6iat2NV4q5M9FfWsC1Ahdxp9loC+49VAu0i/OuPdZiCo60nMbH
 0y+n8hGgWAdAoG8k+TQ1GiBxpqhb9qcw9mBbgIDsd37fctrwsKdCvmMCyQm+iZGOwszB9Y
 gB1wb6uXwyIVGVogwt/LBDXgjdeDhDRLDoq4rYixdKSNTFk30u5LxMGogQ9G5KbDh4qXw2
 jbfCmbmJlVm9rj8CRSzjaw0H6sdOj0nTQbMGFXEkdIF1GEgqbYF+PS9JoZERJUahyk+Rxw
 0jPdl8FdtNl6xHy1Ym2ZzNqaBIKBP9yISdbgWooL2HLUq/l8h2nGV7p529Sj0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: <u-boot@lists.denx.de>,  <upstream@lists.phytec.de>,
 <trini@konsulko.com>,  <jh80.chung@samsung.com>,  <sjg@chromium.org>,
 <ilias.apalodimas@linaro.org>,  <thomas.petazzoni@bootlin.com>,
 <ian.ray@gehealthcare.com>,  <dario.binacchi@amarulasolutions.com>,
 <aford173@gmail.com>,  <seanga2@gmail.com>,  <nm@ti.com>,
 <francesco@dolcini.it>
Subject: Re: [PATCH] Revert "power-domain: Add refcounting"
In-Reply-To: <20250417115311.1905411-1-w.egorov@phytec.de> (Wadim Egorov's
 message of "Thu, 17 Apr 2025 13:53:11 +0200")
References: <20250417115311.1905411-1-w.egorov@phytec.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 18 Apr 2025 09:10:36 +0200
Message-ID: <87mscendw3.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeduhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhtdefudehlefhteekuddtgfekueetjeefleefgedthfdvueevkefgfeettdfgkeenucffohhmrghinhepuggvnhigrdguvgenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehuphhsthhrvggrmheslhhishhtshdrphhhhihtvggtrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrm
 hhsuhhnghdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 18 Apr 2025 16:20:26 +0200
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

Hi Tom,

On 17/04/2025 at 13:53:11 +02, Wadim Egorov <w.egorov@phytec.de> wrote:

> Unfortunately this change breaks boot on K3 platform.
> U-Boot will hang after:
>
>   U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
>   SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
>
> This reverts commit 197376fbf300e92afa0a1583815d9c9eb52d613a as
> suggested in [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2025-April/587032.html
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

This sadly needs to get in, there have been 3 or 4 reports already, as
many boards are broken. We need to find another way to add refcounting
(otherwise some imx8* features will stay broken), but it requires more
thinking time.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
