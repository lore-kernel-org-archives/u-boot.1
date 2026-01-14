Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ACAD37E40
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01DA836C8;
	Wed, 14 Jan 2026 16:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lrnNM2Ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49198836C8; Wed, 14 Jan 2026 16:16:56 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44798352B
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6D7974E420D5
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:16:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 345DA6074A;
 Wed, 14 Jan 2026 15:16:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81D8810B6826D; Wed, 14 Jan 2026 16:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768403812; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BSQKxcOS9e6uyEIEJUbV/6ePet4qoF2an/XilgfAeQ0=;
 b=lrnNM2EvFnoGibFhyn5DUgt8s/XHmbrHpBcy6pfK2S5P9+KgtBfUl2tkDPeHq2MeJv1Tns
 NIttxRB+zZmL67aMt7ZrMFKBpDyzx6Lj3BzMQjBB6M4ESSmV9vSzyu9z70ZJjx0oapJcIe
 KaYNTGTswCISeEw7sgsC8PQh7SwChYtCklfINxlgOGEdIIhF+NqV9FAEHJZ5MT395Hc2YH
 HpinUEQqS3qZ5BEGQsJdHp5W1ZE3MQtzjzbtgUiCKvekKgmFdl5oKvZBobuzQDti3RTayP
 mfAFDL6ixmAOXvgiYjMS3Kp5xbbOWNy3yXdBixzqeXYH6bpJ1GJH5axam8X+9w==
Date: Wed, 14 Jan 2026 16:16:49 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, Tom Rini
 <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH] fwu: Mark failed bank as invalid during rollback
Message-ID: <20260114161649.76cd4f23@kmaincent-XPS-13-7390>
In-Reply-To: <CAC_iWjKRVFF8aDLyyJi5Mbnbku=NJMX7SG4ZRfoJ2YzrAwyGQw@mail.gmail.com>
References: <20260114095917.737634-1-kory.maincent@bootlin.com>
 <CAC_iWjKRVFF8aDLyyJi5Mbnbku=NJMX7SG4ZRfoJ2YzrAwyGQw@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed, 14 Jan 2026 15:54:07 +0200
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Kory,
>=20
> On Wed, 14 Jan 2026 at 11:59, Kory Maincent <kory.maincent@bootlin.com> w=
rote:
> >
> > When boot_idx differs from active_idx at boot time, it indicates a
> > rollback scenario where the firmware update failed and the system
> > reverted to the previous working bank. In this case, mark the failed
> > bank (active_idx) as invalid to prevent future boot attempts from that
> > bank.
> >
> > This change adds a new fwu_invalid_bank() function that sets the bank
> > state to FWU_BANK_INVALID and syncs the metadata. This is only
> > supported in FWU metadata version 2; version 1 provides a no-op stub.
> >
> > Without this change, a failed bank would remain in a valid state and
> > could potentially be selected for boot again, leading to repeated
> > boot failures. =20
>=20
> How? Doesn't the code already switch the metadata to point to the
> 'boot_idx' bank as active?
> What could happen here I guess, is the selected active bank to go bad
> somehow and the firmware would try the secondary bank, which contains
> an invalid firmware. But in that case the board will fail to boot
> regardless. Is there a corner case I am missing?

I think I have faced a corner case, but I can't recall what it was. :/
Anyway we should change the bank state to invalid if we don't manage to boot
one bank right. We should provide to the user the information that one bank=
 is
in an invalid state if that is the case. What do you think?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
