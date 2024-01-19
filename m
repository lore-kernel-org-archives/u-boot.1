Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65223C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 07:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A5187B8E;
	Fri, 19 Jan 2024 08:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="H1b/8OcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5304F87B9D; Fri, 19 Jan 2024 08:21:55 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D748767C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:8cb:7c21:219f:c18e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 77DCA3D486AC;
 Fri, 19 Jan 2024 08:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705648912;
 bh=oLEWnBIn3ETV6iFcr0p2xoi2BKZsgWnEdFZVXIKUa8M=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=H1b/8OcDCHP/UIJ/PazEvfGz6LpfmPryUpyRD/Je+ejBrh/fVauLnvjplt/h09wdH
 AbTMpRvNZlMBgAln31GVPna/+IZJoEzoDz3cipCLWblbX+7M3AvGd7Iq4r1MwVgvoo
 d943iy6knbrHNKCKK7UirJacpG5ajnCCPSQK7NyM=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
Date: Fri, 19 Jan 2024 08:21:41 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
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
To: "Ivan T. Ivanov" <iivanov@suse.de>
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

> Am 19.01.2024 um 06:29 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> On 01-18 18:18, Jens Maus wrote:
>>=20
>>> I am afraid you will have to connect that UART debug cable and share
>>> what is the memory map on your device :-)
>>=20
>> No problem.
>=20
> Thanks, but could you apply attached patch and send me
> the logs when there is HDMI monitor connected to the board
> and one when cable is unplugged.

I applied that patch, but unfortunately no U-Boot specific output on the =
special debug UART of the rpi5 at all. As I have shown in my earlier =
email, the output ends with the =E2=80=9ENOTICE: BL31=E2=80=A6=E2=80=9C =
messages and there is no single line coming from U-boot at all. Also =
tried to add =E2=80=9E#define DEBUG=E2=80=9C to the fdtdec.c file and =
added CONFIG_LOG=3Dy as well as raising the maximum debug level to 9 to =
the U-boot build. This for some reason this does not end up in any =
additional U-boot debug line output on the RPi debug probe connected to =
the special UART of the rpi5. I even tried to connect the debug probe to =
the UART pins of the GPIO but also there no U-Boot debug output at all, =
I am afraid.

So where should that U-Boot debug output actually appear with your =
u-boot.bin patched version?

Best Regards,
jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

