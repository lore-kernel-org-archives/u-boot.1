Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C3CCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C73833AD;
	Thu, 23 Oct 2025 09:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lUmAyYql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D83882E34; Thu, 23 Oct 2025 09:24:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B59F82E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D4A6D4AA45;
 Thu, 23 Oct 2025 07:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EEDC4CEE7;
 Thu, 23 Oct 2025 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761204281;
 bh=+iHKKfd/BVZtMu2R1TMQSk2NsV9OH1eKL2iJGkW3McI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lUmAyYqlDGGI4hLoT0SEzOA4InoNMdBV4jjNCdzs8MS9ZPgh7hJYMu/G3ZwbYgTAA
 PP1mFXnQXlMuHBAKs0hKnKiD7gC0d1zVq0o3fKYngeW7XAWJZvrJugfO4xd5CeKInG
 ZV5XOYkm4yWxaFIFMtD0BkY5LpclEcx62qTWRu2AJdCVm3Rf41VuxcUo88x/q+O4C/
 /wHhyNWeHCkndmZxSerNL0c7zK/U7EJX4inYBfIU+E5lF/D1ZgPZSyynp1gjvaET0l
 GYSUX4YjkJBoAfPtbeKbL1N1RUX2hDZY+yPeg0yeS8RvsxWnThNWhnRRd+vAzIMiii
 CiseHUpRp7NJA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome
 Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] doc: pytest: Complete dependencies list with missing
 packages
In-Reply-To: <20251022180451.1e91cee4@kmaincent-XPS-13-7390>
References: <20251022132055.816662-1-kory.maincent@bootlin.com>
 <87bjlzarlt.fsf@kernel.org>
 <20251022180451.1e91cee4@kmaincent-XPS-13-7390>
Date: Thu, 23 Oct 2025 09:24:39 +0200
Message-ID: <875xc6axmw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 22, 2025 at 18:04, Kory Maincent <kory.maincent@bootlin.com> wr=
ote:

> On Wed, 22 Oct 2025 17:22:38 +0200
> Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
>> Hi Kory,
>>=20
>> Thank you for the patch.
>>=20
>> On Wed, Oct 22, 2025 at 15:20, Kory Maincent <kory.maincent@bootlin.com>
>> wrote:
>>=20
>> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>> >
>> > Add missing dependencies to the pytest usage documentation and correct
>> > the device tree compiler package name from 'dtc' to 'device-tree-compi=
ler'.
>> >
>> > This ensures users have the complete list of dependencies needed to run
>> > the pytest test suite without errors.
>> >
>> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
>> > ---
>> >  doc/develop/pytest/usage.rst | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.r=
st
>> > index 779b2dbe24b..454877837ca 100644
>> > --- a/doc/develop/pytest/usage.rst
>> > +++ b/doc/develop/pytest/usage.rst
>> > @@ -39,7 +39,7 @@ will be required. The following is an incomplete lis=
t:=20=20
>>=20
>> If the list is now complete (as per your commit message), should we
>> update this sentence as well to remove "incomplete" ?
>
> Indeed I think we can. Do you want a v2 with this update?=20

I think Heinrich will be the one picking this up so I'll let him chime
in.

If you do make a v2, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Regards,
> --=20
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
