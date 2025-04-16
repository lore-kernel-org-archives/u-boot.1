Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46353C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 22:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0B182DE7;
	Thu, 17 Apr 2025 00:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bGXpws7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A4681DE3; Wed, 16 Apr 2025 17:49:15 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD2080FEC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 17:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EBBF43B39;
 Wed, 16 Apr 2025 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744818552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75LBNh7Hb3NtG7JaLZCqwOlE2Syxnhemy39Y4a3Ffoo=;
 b=bGXpws7WhBg3Nu0hvIfI17HzRfwN8lSV238BUkU+YzcrfkwvhyiGnflmdp9lRsCL8S4Vq4
 LVz2Kgf+pSziPzerMKfgKmQzreaw4vzlyQEh/gmAwsXsmQpnzUWBktFUr6jv3H/98ItlIu
 obrfUCejwNxaV3K4AtrnI0XGaIVrOWeaJxfUNp/VnX5SMhz6p53kyGWUg5DYufT9LkkH21
 3voTbguEKyvuciqN75m/rsTpaqHeZcCx6yuHeJGeqS5GhmjkdhTFRpZRNTxB4qD/+XZ7qh
 Fjf4gUtjlXznVwK+WxBZuBB58fIsw8tdBLzSYPYbkz7glrDQ/Z8nTZiuQVfOnA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Neha Malcom Francis <n-francis@ti.com>,  Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel.holland@sifive.com>,  Svyatoslav Ryhel
 <clamor95@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
In-Reply-To: <94f3bd98-5854-4f09-9927-54d83cd9adeb@phytec.de> (Wadim Egorov's
 message of "Wed, 16 Apr 2025 16:20:06 +0300")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
 <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com>
 <87o6wwv5ke.fsf@bootlin.com>
 <7f87c129-b949-493a-9df7-26e9caf9d58e@ti.com>
 <94f3bd98-5854-4f09-9927-54d83cd9adeb@phytec.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 16 Apr 2025 17:49:10 +0200
Message-ID: <8734e8qf7t.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeijeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehnqdhfrhgrnhgtihhssehtihdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsrghmuhgvlhdrhhholhhlrghnugesshhifhhivhgvrdgtohhmpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsr
 dhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 17 Apr 2025 00:30:28 +0200
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

On 16/04/2025 at 16:20:06 +03, Wadim Egorov <w.egorov@phytec.de> wrote:

> Am 16.04.25 um 12:50 schrieb Neha Malcom Francis:
>> Hi Miquel
>> On 16/04/25 14:36, Miquel Raynal wrote:
>>> Hello,
>>>
>>>>>> -int power_domain_on(struct power_domain *power_domain)
>>>>>> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>>>>>>   {
>>>>>> +	struct power_domain_priv *priv =3D dev_get_uclass_priv(power_domai=
n->dev);
>>>>>>   	struct power_domain_ops *ops =3D power_domain_dev_ops(power_domai=
n->dev);
>>>>>> +	int ret;
>>>>>>     	debug("%s(power_domain=3D%p)\n", __func__, power_domain);
>>>>>>   -	return ops->on ? ops->on(power_domain) : 0;
>>>>>> +	if (priv->on_count++ > 0)
>>>>>> +		return -EALREADY;
>>>>>
>>>>> This change is broken for power domain providers with #power-domain-c=
ells =3D <1>,
>>>>> which can have multiple domains per provider device. There would need=
 to be a
>>>>> separate reference count per domain, and currently the uclass doesn't=
 know the
>>>>> range of valid domain IDs.
>>>>
>>>> I didn't see this reply earlier, would've saved some time debugging to
>>>> come to the same conclusion :) but yes this is the reason for
>>>> breaking.
>>>
>>> That's indeed the reason, thanks a lot for figuring this out. I am
>>> looking for a solution. I can reproduce on imx8mp by enabling the two
>>> LCD interfaces, as they have a similar pattern as on k3 platform: a
>>> single power domain node and one cell for figuring out which PD to
>>> enable.
>>>
>>> The uclass does not save any data, so I don't have an immediate fix to
>>> propose. Let me dig a bit more into that and find a solution.
>>>
>> Thanks!
>> Meanwhile, could we revert this patch to keep the platforms from
>> breaking?
>
> Would be nice, just took me the same route to pin this commit and find
> out about this discussion. I think more people will run into the same
> issue soon

Go ahead, unfortunately, it's not straightforward to fix properly.

Thanks,
Miqu=C3=A8l
