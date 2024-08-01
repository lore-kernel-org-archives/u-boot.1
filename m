Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44260C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A469A88B33;
	Thu,  1 Aug 2024 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="wLlc2BSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADBA88ACA; Thu,  1 Aug 2024 13:19:48 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAE688646
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 13:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1722511185; x=1722770385;
 bh=8Fy02Y1DWpBEOrPy/C0lfmJuSpQwQndWGLsT1F0tb40=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=wLlc2BSYIZfM+hp2oR0U6R2oTP8faRIlkFAxfQ9kmSmXSmBVX8LXnqptJ5rcBEM9E
 wZMI4OAs7t4b+2j27Ll2BWCLLM8Nvqe7NKZM3BupQXd5f46gy4VQUjjAo/1B4092cN
 LztppSmYbft8r4N2kZUOH5qJpnKGLQZWYhVu8ah/mw+IWyPYFyWMsfJ21QEEWIa6Lj
 x0NTEsgJbsyEzARtSXNwXI06tCSLIHxx4zI1/AjJRplNY59N8plwJY+zlxTDtvXDqD
 mB4esA4W+21GOp9Fczk5T8G53MHVX1KWAu5jhmN1Q+mangHZ2DNJoUBUbgm8FMn8/o
 ifjTPZE6nFSUA==
Date: Thu, 01 Aug 2024 11:19:42 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3] doc: document the pwm command
Message-ID: <3zkkz5fksjdmjmpfjxokm6ymu6ydgwnk2qjzgre5fxfzgvbans@7agvsuirvjrb>
In-Reply-To: <10b8ae68-36a1-47c1-bdea-2612659101b4@cherry.de>
References: <20240801100754.44732-1-emil.kronborg@protonmail.com>
 <10b8ae68-36a1-47c1-bdea-2612659101b4@cherry.de>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 5e38d732cb7bde6bff0b98934039239d61db5ace
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Aug 2024 16:06:21 +0200
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

Hi Quentin,

> On 8/1/24 12:07 PM, Emil Kronborg wrote:
> > [...]
> > +.. SPDX-License-Identifier: GPL-2.0+:
>=20
> This isn't a valid identifier (spurious ':') I believe.
>=20
> Also, I would highly suggest to change it to GPL-2.0-or-later which is
> the current naming scheme for the same license, c.f.
> https://spdx.org/licenses/
>=20
> Otherwise, looking good so with that changed:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Thanks!
> Quentin


> On 8/1/24 12:07 PM, Emil Kronborg wrote:
> > [...]
> > +.. SPDX-License-Identifier: GPL-2.0+:
>=20
> This isn't a valid identifier (spurious ':') I believe.

Hm, I agree that it looks weird, but I think it is fine. There seems to
be a mix of colon and no colon though.

    $ git grep "SPDX-License-Identifier: GPL-2.0+:" doc/usage/ | wc -l
    48
    $ git grep "SPDX-License-Identifier: GPL-2.0+" doc/usage/ | wc -l
    114

With that said, GPL-2.0-or-later is most correct to use, and probably
_without_ a trailing colon. In fact, GPL-2.0+ is actually deprecated
according to the link you sent.

Should I send a new patch where the license is fixed?

--=20
Emil Kronborg

