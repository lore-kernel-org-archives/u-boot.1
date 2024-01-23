Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA50C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 11:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E03987B9E;
	Tue, 23 Jan 2024 12:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="m8JdakYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B814087A01; Tue, 23 Jan 2024 12:12:11 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79D887A01
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 12:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:9106:5cb0:487c:7b4c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 4F3013D42471;
 Tue, 23 Jan 2024 12:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1706008328;
 bh=6+7ZKtABy1O1gKHnu43hN6g+dIyk0rE2KJuZzYPbWSE=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=m8JdakYY9aiFZCYG+Hr84h/C6fMiY62iAMoL0V/77Bv96ccHYYhJKKWfpChqiOHyX
 pTfHSjpQMsappRVm7HQ4EgwaKaqv+khUHnx4t3lx9pzOyQmONAfTMq8O5qQNGDig7g
 uS6oxEoC3QszwZTfl4xuA43YMeW9L9nN9hwgvBaw=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
Date: Tue, 23 Jan 2024 12:11:57 +0100
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <36C77701-6838-4ACC-B6B0-62286CD0F7D1@jens-maus.de>
References: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
 <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
 <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
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

> Am 22.01.2024 um 15:16 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> On 01-22 13:57, Ivan T. Ivanov wrote:
>> I was able to enable early debug UART in U-Boot and I will try to
>> find what is happening, once I get some free cycles.
>=20
> Ok, this was relatively easy to find :-)
>=20
> New versions of EEPROM firmware change =E2=80=9Ckernel=E2=80=9D/U-Boot =
load address=20
> from 0x80000 to 0x200000. And because on RPi=E2=80=99s =
CONFIG_TEXT_BASE is
> hardcoded to 0x80000 code run through the fields.=20
>=20
> Hopefully simple patch like bellow make it work fine in older and
> newer EEPROM firmware versions.

Thanks for this tiny but important fix on your patchset. In fact, I was =
able to verify that now with your latest v5 patchset for the initial =
rpi5 support even newer/latest rpi-eeprom versions work as expected and =
u-boot is chain loaded by the rpi boot loader.

So thanks again for that fix and I am looking forward to seeing your =
patchset integrated and hopefully also maintained in future so that USB =
boot and GPIO support will be added in the near future.

regards,
jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

