Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF235FD8FD3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4994883E8E;
	Thu, 26 Feb 2026 17:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="WSPIEi97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A7583F2E; Thu, 26 Feb 2026 17:28:41 +0100 (CET)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d502])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 873AE83EEF
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
 by forward502d.mail.yandex.net (Yandex) with ESMTPS id 86E7EC0F41;
 Thu, 26 Feb 2026 19:28:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id aSlJZZ2Gxa60-s09OMZqJ; 
 Thu, 26 Feb 2026 19:28:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1772123316; bh=3SD3H31JJ7OIx95HtJWrunY0GG+xRHqxab+DoTltCjc=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=WSPIEi97GUa1FvVEZ4a5ujoN6N76dS2YDVhDZhtE2knkyAzQDC1HqETU8rwQOcvVW
 GbCZc+Dvvle466Siruuk95OM22I2p2ozVvbWx4RlHqiS+c/BaJJFXUHJTysSjDMXkQ
 hcWFiNgRqYpsUZyTzImod67VLWZPM6VpLumxDgGg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <fccdc13e79b3a0bed390d6fcc25f04c0fd93feff.camel@maquefel.me>
Subject: Re: [PATCH] serial: ns16550: Fix return-type warning
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, Aiden
 Park	 <aiden.park@intel.com>, u-boot@lists.denx.de, Mattijs Korpershoek	
 <mkorpershoek@kernel.org>, "J." =?ISO-8859-1?Q?Neusch=E4fer?=
 <j.ne@posteo.net>
Date: Thu, 26 Feb 2026 19:28:36 +0300
In-Reply-To: <20260226150842.GE1593142@bill-the-cat>
References: <20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me>
 <20260226150842.GE1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Feb 2026 17:51:10 +0100
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

Hi Tom.

On Thu, 2026-02-26 at 09:08 -0600, Tom Rini wrote:
> On Thu, Feb 26, 2026 at 05:02:47PM +0300, Nikita Shubin wrote:
>=20
> > Fix compiler warning:
> >=20
> > drivers/serial/ns16550.c: In function =E2=80=98serial_in_dynamic=E2=80=
=99:
> > drivers/serial/ns16550.c:153:1: warning: control reaches end
> > =C2=A0=C2=A0=C2=A0 of non-void function [-Wreturn-type]
> > =C2=A0 153 | }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
> >=20
> > Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time
> > configuration")
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> I assume this is from gcc-15.x ? Thanks.

Exactly,=20

```
$ riscv64-unknown-linux-gnu-gcc --version
riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1
20260214
```

To be precise.


