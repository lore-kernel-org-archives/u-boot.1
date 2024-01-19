Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8B1C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 10:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A5687B4C;
	Fri, 19 Jan 2024 11:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="1rZzj4At";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2AF87B93; Fri, 19 Jan 2024 11:50:07 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B65487A82
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 11:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:8cb:7c21:219f:c18e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 4D16D3D486AC;
 Fri, 19 Jan 2024 11:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705661404;
 bh=3u7qHbBmOwIib9NGOLczwBlKwUQoZozfVKm0AoGlWXw=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=1rZzj4AtRFrT7QqsQxd1JBUmGElEvAEtkzsBRzPS2ZroTePifpklk2D52gSwNSXTB
 qR1G9ImQDAZGPpN5I5GXppzVDSUmg9iaUY3rW13pDW47NQW6WUI1r4DCr+34UbZgdf
 puBCJ8BbSjQH0RiLN/bBbOO5HCLN9MG6fqTiwVm8=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
Date: Fri, 19 Jan 2024 11:49:52 +0100
Cc: "Ivan T. Ivanov" <iivanov@suse.de>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
 <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
 <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

Hi,

> Am 19.01.2024 um 10:20 schrieb Stefan Wahren <wahrenst@gmx.net>:
>=20
> Another idea could be to dump the runtime DT of both variants via =
sysfs
> (using official RPi OS) and compare them with each other. In the past
> there was a lot DT firmware hackery for the Raspberry Pi 4.

Good idea indeed. I just did that and executed "dtc -I fs =
/sys/firmware/devicetree/base=E2=80=9C in a quick RaspberryPiOS =
installation.

See [1] for the corresponding output. Hopefully Ivan can do the same so =
that we can see if there are any differences that might explain why his =
u-boot patches are working for him while they does not for me.

Best Regards,
Jens

[1] https://gist.github.com/jens-maus/497e03cf1305ffe8a07e3196c27d6ebd
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

