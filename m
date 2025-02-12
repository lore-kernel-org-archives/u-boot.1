Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74380C0219E
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35B780824;
	Wed, 12 Feb 2025 09:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bz5oivyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225F080BAA; Wed, 12 Feb 2025 09:24:23 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B32807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47D6E4328B;
 Wed, 12 Feb 2025 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1739348660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oK2sPv4LMCXJy8yVS147MvhejzIS3HvMFZ7xWU0RsY=;
 b=bz5oivyuGG/36TQyTZOE5sUeuBIKSQJBW/yljLrkLTdZjG+Cs6bh2k6+82N7tC9enu90Z4
 VJbRY87FDapshatpYC1N07NfLXoTXJT6jPqyB04C7jHt2Q5Fv7eN+KUkIorip3hkP4hcYj
 6+UoxTH1wSVRlYNTp9itD0SMkZKzwDtyCwdo5ThOp2uhjLR3eKQp9XARWBmohWSz0d6KMr
 PsgJx7xzM6kZ15MoybZm46VArk45P9IkiQmck7C3nH4F7fe6o4EB0W68RZlCZszGdb3eHf
 NwNGkyI1pgcZuYe2m8JkeLYiWV1G4zIl8DWoTSsjhQOWGOx/NdP4yU7ntHe0Ug==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jonathan Bar Or <jonathanbaror@gmail.com>,  Gao Xiang
 <hsiangkao@linux.alibaba.com>,  Huang Jianan <jnhuang95@gmail.com>,  Joao
 Marcos Costa <jmcosta944@gmail.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Subject: Re: Security vulnerabilities report to Das-U-Boot
In-Reply-To: <20250211212909.GI1233568@bill-the-cat> (Tom Rini's message of
 "Tue, 11 Feb 2025 15:29:09 -0600")
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 12 Feb 2025 09:24:18 +0100
Message-ID: <8734gjsh8t.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhgsrghrohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjnhhhuhgrnhhgleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhmtghoshhtrgelgeegsehgmhgrihhlrdgtohhmpdhrtghpt
 hhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhg
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

Hello Tom,

On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
>> Hi Tom and the rest of the team,
>>=20
>> Please let me know about fix time, whether this is acknowledged and
>> whether you're going to request CVE IDs for those or if I should do
>> it.
>> The reason is that I found similar issues in other bootloaders, so I'm
>> trying to synchronize all of them. For what it's worth, Barebox has
>> similar issues and are currently fixing.
>
> Yes, these seem valid. We don't have a CVE requesting authority so if
> you want them, go ahead and request them. You saw Gao Xiang's response
> for erofs, and I'm hoping one of the squashfs maintainers will chime
> in.

Either Jo=C3=A3o or me, we will have a look.

Thanks,
Miqu=C3=A8l
