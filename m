Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1AAD10DDD
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 09:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60801893E9;
	Mon,  2 Dec 2024 10:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GnQ6UyYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1209894F1; Mon,  2 Dec 2024 10:39:10 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6EA893CF
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 10:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FEFF1BF206;
 Mon,  2 Dec 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733132348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44z5l1oXpFsRTi6s+HhQMMEPssKHGX1C0oxWvRjA218=;
 b=GnQ6UyYFw6J2sCe5BVu/feryMvTAQaZOqvgYRPoJ2ZoxHuJ2f34veMm4sjG4JGDuinbFE5
 VzLG6kO/TOuu5ImURpJ9iEDGhYg1qgeC1q29ze/mnonMjrLcXPqywDPxJSa+8QDZ2RWgUt
 VEOkw7EQ7QH7/h0b9407MnlF7/F6HsIlzABp+R5kErGYGWbNwrYo8Sn1FubZxod6PllVVw
 8O+C5BG+7nN5oLBOyUrS/U3fG+6qGyM+5+GeYfvU/I+Bgr5XV+lzusCGis06oUhHRa5gmD
 nlxqiQNrm2+8HK60aZRjp4QVyHiJRvzOVH+CG4elhOFCdXYLZ78Jxj7W9xdXXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] nand: Add a watch command
In-Reply-To: <CAOf5uwnP4O1cop9_CcBYN0YauvQQ_A0cuhno+PDOQzr2=h=UaQ@mail.gmail.com>
 (Michael Nazzareno Trimarchi's message of "Tue, 26 Nov 2024 21:19:58
 +0100")
References: <20231128105611.488906-1-miquel.raynal@bootlin.com>
 <CAOf5uwnP4O1cop9_CcBYN0YauvQQ_A0cuhno+PDOQzr2=h=UaQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Dec 2024 10:39:07 +0100
Message-ID: <874j3ma0g4.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On 26/11/2024 at 21:19:58 +01, Michael Nazzareno Trimarchi <michael@amarula=
solutions.com> wrote:

> Hi Miquel
>
> On Tue, Nov 28, 2023 at 11:56=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>>
>> This is a debug command to monitor the retention state of the data on
>> the array. The command needs a duplication of the mtd_read_oob()
>> function to actually return the maximum number of bitflips encountered
>> while reading the page. We could write a specific implementation for the
>> Sunxi driver but this is probably enough.
>>
>>     nand watch <off> <size> - check an area for bitflips
>>     nand watch.part <part> - check a partition for bitflips
>>     nand watch.chip - check the whole device for bitflips
>>
>> The output may be a bit verbose and could look like:
>>
>
> I have rebased and I will take a look on this patch tomorrow. I think hav=
ing it
> is ok.

Haha, I must admit I forgot about it, but I think it would be nice to
get it in, I used this tool quite a lot for debugging purposes, I am
sure it can be useful to others. :-)

Cheers,
Miqu=C3=A8l
