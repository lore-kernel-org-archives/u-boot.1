Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34376F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E4843C3;
	Fri, 17 Apr 2026 14:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2Aosv0HG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7B184214; Fri, 17 Apr 2026 10:24:52 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D5C83FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3B768C5C3D7;
 Fri, 17 Apr 2026 08:25:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC41B60497;
 Fri, 17 Apr 2026 08:24:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34C491046095E; 
 Fri, 17 Apr 2026 10:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776414285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xWxffB3oFAc0V9VEfStwCUn9SRn3FhyDKwZFS95YsCc=;
 b=2Aosv0HG06elVz6a62bc3LOa3jZLeeUBB2qn2Fnf7KlUDAz60Suz1ts1cozHls3DXz8cg9
 9hiBz69kVjckjKR0BJ5bAC9zU5/VnhM/C2Eta/VGPBeDpiJMyMid9kSw92sISUsAFRw4DS
 JpZ5ybJHTN3Vjx6+HMaEe4EDVijuUItyp91pPzoNo5Q5TyWxinsVSGvmGdqiSylZjkpZs/
 eww34jyrFuO1+2IlJVxTbD6zVp3bAD65XaqQ3927q5Q6cwIZH4brJLm9W/CFoVvR9jZKwt
 v998yv7dq2QRWSxErOf691i2MXs2i977mbcVN1FabHvWNejm/J+DDyGXozGJRg==
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
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Apr 2026 10:24:42 +0200
Message-ID: <87ik9qc7ud.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

The patch has been in the mainline tree for quite some time now, but I
see today that the authorship has changed:

    commit 1fac577207196e12932c2c733b58e3b14013b1ce
    Author: Michael Trimarchi <michael@amarulasolutions.com>

    nand: Add a watch command

    [...]

    Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
    Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

It is probably a mistake but please be careful in the future :)

Thanks,
Miqu=C3=A8l
