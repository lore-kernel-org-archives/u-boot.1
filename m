Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9773AC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F4387D8F;
	Fri, 19 Jan 2024 17:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="qdg0n4+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E9387D8C; Fri, 19 Jan 2024 17:12:25 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82FB87CF4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:8cb:7c21:219f:c18e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 5390F3D48651;
 Fri, 19 Jan 2024 17:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705680743;
 bh=ta4jKGn3ikMJh6VuD+ClGXomJfjFD255t2viTsVWhPk=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=qdg0n4+dU9xTMd/R+FGy9aCMCuB7F+Nhct33t1kkJlXMjwX5ZvlePgxHfwXExDKGT
 +NBdxClNYD+B0EO7V24dXcyg3wn+LX3SEZwOcrb7Y3YPZd6bD+xnncdvkboe2W1dur
 erbifCVU7T5gfrhN0QrOLIYwE5+b/uz/HF1Svxd0=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
Date: Fri, 19 Jan 2024 17:12:12 +0100
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
References: <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
 <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
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


> Am 19.01.2024 um 15:24 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
>> On 19 Jan 2024, at 16:08, Jens Maus <mail@jens-maus.de> wrote:
>>=20
>> On the HDMI port, right? But what about the serial UART output?=20
>=20
> Yes, I can see serial output from U-Boot. I am using one of these
> simple USB<->UART cables. You can see serial output when you boot
> with RPiOS, when you use "Raspberry Pi Debug Probe=E2=80=9D, right?

Yes, when booting up RPiOS I can first see the same serial debug output =
regarding the rpi boot loader until the same =E2=80=9ENOTICE: BL31: =
=E2=80=A6=E2=80=9C lines. Then RPiOS comes up and in the end I get an =
interactive serial console login "raspberrypi login:=E2=80=9C prompt on =
the RaspberryPi Debug Probe connection to that special UART port on the =
rpi5 pcb.

So you say with your own u-boot.bin you see serial U-Boot output after =
that =E2=80=9ENOTICE: BL31: =E2=80=A6=E2=80=9C lines? On that special =
UART port on the rpi5 or on the UART on the GPIO header?

regards,
jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

