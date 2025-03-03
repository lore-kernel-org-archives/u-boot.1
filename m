Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B81EC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 08:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C024280F70;
	Mon,  3 Mar 2025 09:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mmx2DaSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5957F810EA; Mon,  3 Mar 2025 09:21:50 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF28809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 09:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F750443BB;
 Mon,  3 Mar 2025 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1740990107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EZNZVBlPoItYgxg3sH05lnoxkPL+zL2BKxA3MrWlMU=;
 b=mmx2DaSUHsuNEgjWalfqx4sz/s/F7y8rWhQJYCCOT3NY6H31D6h/LiWVNodzY2hhbwqYrB
 uVX5xt3aoblQQZLxNFZjoAa97wl0233tIZ4EBTSu8iWQAtOf2A+2rMeQH6ZbEcvY6WYAtK
 EgQP5S4bZ+/P6nMwr+qOE6jl2jbiraXNWorVIExNw1NCUHa5wAf3Uq7T1VvBlBc4CIHGty
 bc6Jz4vxsKaNe1IXEdEiZBd2M4JPuVSLmsz7iADNyJr0ntVzb86jUG+AkZOZFnfLF1P+Hx
 U5dNJ0DeCZAHZo7ifPlfKSC8xNhG3il3cgB4YEWZ9FOTBtTQQrormOYzky5ftw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] fs/squashfs: Fix memory leak in sqfs_size_nest()
In-Reply-To: <20250302182931.15519-1-andrea.porta@suse.com> (Andrea della
 Porta's message of "Sun, 2 Mar 2025 19:29:31 +0100")
References: <20250302182931.15519-1-andrea.porta@suse.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 09:21:46 +0100
Message-ID: <87h64abk2t.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegrnhgurhgvrgdrphhorhhtrgesshhushgvrdgtohhmpdhrtghpthhtohepjhhmtghoshhtrgelgeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
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

Hi Andrea,

On 02/03/2025 at 19:29:31 +01, Andrea della Porta <andrea.porta@suse.com> w=
rote:

> In case MAX_SYMLINK_NEST is reached while determining the size
> on a symlink node, the function returns immediately.
> This would not free the resources after the free_strings: label
> causing a memory leak.
>
> Set the ret value and just break out of the switch to fix this.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
