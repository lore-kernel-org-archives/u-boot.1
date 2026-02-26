Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75167FD8FD8
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F5B83F60;
	Thu, 26 Feb 2026 17:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="QdMcOjus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C353D83F36; Thu, 26 Feb 2026 17:39:47 +0100 (CET)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [178.154.239.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87EC283E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1e:3990:0:640:454b:0])
 by forward500b.mail.yandex.net (Yandex) with ESMTPS id B7B9FC127C;
 Thu, 26 Feb 2026 19:39:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id hdlNOb2GdCg0-uCsMksE0; 
 Thu, 26 Feb 2026 19:39:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1772123984; bh=5TpNakmSm+MbJYIjTqW4h1MS+5fWYDBYCoSfKC6ElVY=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=QdMcOjustvkF874IAHHugu8CqK4NHKG8T338rWtgv66+drQPZzmDgtGDURYehjIIY
 5uVr6Pij4bofdVolSBu/sA8i6gyuKkKr68gEHz7ZIGRtwAfyrvC44vg02oCv8ql3t2
 XEADMvEb5uRdjgz8vjk7fUJvxWE6sblW6pXdgAZw=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <b7d0a8ea1466754546797943a52da321c3996547.camel@maquefel.me>
Subject: Re: [PATCH] serial: ns16550: Fix return-type warning
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, Aiden
 Park	 <aiden.park@intel.com>, u-boot@lists.denx.de, Mattijs Korpershoek	
 <mkorpershoek@kernel.org>, "J." =?ISO-8859-1?Q?Neusch=E4fer?=
 <j.ne@posteo.net>
Date: Thu, 26 Feb 2026 19:39:44 +0300
In-Reply-To: <20260226163014.GI1593142@bill-the-cat>
References: <20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me>
 <20260226150842.GE1593142@bill-the-cat>
 <fccdc13e79b3a0bed390d6fcc25f04c0fd93feff.camel@maquefel.me>
 <20260226163014.GI1593142@bill-the-cat>
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

On Thu, 2026-02-26 at 10:30 -0600, Tom Rini wrote:
> On Thu, Feb 26, 2026 at 07:28:36PM +0300, Nikita Shubin wrote:
> > Hi Tom.
> >=20
> > On Thu, 2026-02-26 at 09:08 -0600, Tom Rini wrote:
> > > On Thu, Feb 26, 2026 at 05:02:47PM +0300, Nikita Shubin wrote:
> > >=20
> > > > Fix compiler warning:
> > > >=20
> > > > drivers/serial/ns16550.c: In function =E2=80=98serial_in_dynamic=E2=
=80=99:
> > > > drivers/serial/ns16550.c:153:1: warning: control reaches end
> > > > =C2=A0=C2=A0=C2=A0 of non-void function [-Wreturn-type]
> > > > =C2=A0 153 | }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
> > > >=20
> > > > Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time
> > > > configuration")
> > > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > >=20
> > > I assume this is from gcc-15.x ? Thanks.
> >=20
> > Exactly,=20
> >=20
> > ```
> > $ riscv64-unknown-linux-gnu-gcc --version
> > riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1
> > 20260214
> > ```
> >=20
> > To be precise.
>=20
> Could you please do a v2 noting the compiler version? We don't yet
> support gcc 15.x, but
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588=C2=A0is just now
> fixed,
> so soon we should be able to.

Sure - done !
