Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6CFC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234E882B44;
	Wed, 16 Apr 2025 14:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PICO5YlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA9F82CBC; Wed, 16 Apr 2025 11:06:30 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCD681F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69CC5439E7;
 Wed, 16 Apr 2025 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744794387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlqMSwMbX/dvhxeR8wMZuaTJI+BWCZkWzjXapSKMUNg=;
 b=PICO5YlOfaDDNyGSOt4oI8bOSLyptRmFzb7HkN1M8rnpUgnZuXoxwBdy78SyGRXz37Kh+F
 w5ve5m+Z3Zy5kchyC0TBX7U/WE6UlkvXBsxmkoZ2i1JUDTLKbT6wd/sT0iEnPVdRTcIIAR
 c6to2eYnEVod2NrhtdYXWn0eKRCT0sdoEQfJ0xuMaNVl+kvGQ1xAy7LRM7jMp+prlfBpWs
 DBqwfTOPWNjQWrbJKS+EREC89fqkbhdVy0RzNtVV4/JGWn6eRnHo2w2yOABlnOx3pyAPzp
 TgUKCZs2EZwDuzaPL1Qz/2nWgy+psaKUBeqpWUsZ/hNdCSicIgBvU+DEEB8Asg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,  Svyatoslav Ryhel
 <clamor95@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,  Tom Rini <trini@konsulko.com>,  Simon Glass
 <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,  Lukasz
 Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,  Anatolij
 Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,  Peng Fan
 <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
In-Reply-To: <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com> (Neha Malcom
 Francis's message of "Wed, 16 Apr 2025 14:06:05 +0530")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
 <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 16 Apr 2025 11:06:25 +0200
Message-ID: <87o6wwv5ke.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehnqdhfrhgrnhgtihhssehtihdrtghomhdprhgtphhtthhopehsrghmuhgvlhdrhhholhhlrghnugesshhifhhivhgvrdgtohhmpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrt
 ghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Wed, 16 Apr 2025 14:52:03 +0200
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

Hello,

>>> -int power_domain_on(struct power_domain *power_domain)
>>> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>>>  {
>>> +	struct power_domain_priv *priv =3D dev_get_uclass_priv(power_domain->=
dev);
>>>  	struct power_domain_ops *ops =3D power_domain_dev_ops(power_domain->d=
ev);
>>> +	int ret;
>>>=20=20
>>>  	debug("%s(power_domain=3D%p)\n", __func__, power_domain);
>>>=20=20
>>> -	return ops->on ? ops->on(power_domain) : 0;
>>> +	if (priv->on_count++ > 0)
>>> +		return -EALREADY;
>>=20
>> This change is broken for power domain providers with #power-domain-cell=
s =3D <1>,
>> which can have multiple domains per provider device. There would need to=
 be a
>> separate reference count per domain, and currently the uclass doesn't kn=
ow the
>> range of valid domain IDs.
>
> I didn't see this reply earlier, would've saved some time debugging to
> come to the same conclusion :) but yes this is the reason for
> breaking.

That's indeed the reason, thanks a lot for figuring this out. I am
looking for a solution. I can reproduce on imx8mp by enabling the two
LCD interfaces, as they have a similar pattern as on k3 platform: a
single power domain node and one cell for figuring out which PD to
enable.

The uclass does not save any data, so I don't have an immediate fix to
propose. Let me dig a bit more into that and find a solution.

Thanks,
Miqu=C3=A8l
