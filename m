Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E35C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 04:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84A08847F;
	Thu,  9 May 2024 06:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="jClFQe9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25895882C1; Wed,  8 May 2024 22:45:27 +0200 (CEST)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2692B88232
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 22:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1715201124; x=1715460324;
 bh=c/YnMMcqglq+DyNY3BoaTGDDg6n7Gx2GT5llKiduCz4=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=jClFQe9cyObfGLIQTkGsbpY5urDJYGb3u8Bk9+IZj/VCOqjuZO3RAi9o0tEBCOrk6
 Zb7Zon8PnM50vIODL6uWJe7sgTuQzrrWegFMZgyku3kkBiPmhrgcnMWtOMB6Ok9tQ0
 LDC2Er367fszJpbQtr1ddIdnGaTBbcn9L9gQ6hptFfWuutmHxTmfZvJ4K7bJ29DW0/
 AIHuFZBf3dSpFitfd3hG2UQ8uCR5UCBuk+6See5q8GcdN+KvcGNuoOY80g2sgX8ZD0
 yvVtLjT84Faz0PCr6NkYbAel/EJ/mgSvFq4LIeYFpxyDKQ1/Zy08s3kUwzgel9Wy4+
 CgYD0XHAxsl0g==
Date: Wed, 08 May 2024 20:45:20 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH] board: starfive: support Pine64 Star64 board
Message-ID: <FA20o8OKLcD-qkvYM3H9-K8AtQy5USkc9CTxhGBNKpSKJ9C4k_CH3KvRtW7lOAFJUctRcWLj-sb7nAIH-9YQ2zlwg9rYf7Z-dfqOUBfE6a4=@protonmail.com>
In-Reply-To: <CANV2PTPkebMS76obVPZ2e9vw+pgXhWbNAC5SGb1yLkiyByBU4A@mail.gmail.com>
References: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
 <CANV2PTPkebMS76obVPZ2e9vw+pgXhWbNAC5SGb1yLkiyByBU4A@mail.gmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 02e5e1efdc6078c76466b0c0d6ccd880cff2a911
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 May 2024 06:59:07 +0200
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

On Tuesday, May 7th, 2024 at 12:31 AM, E Shattow <lucent@gmail.com> wrote:
> On Mon, May 6, 2024 at 8:30=E2=80=AFAM H Bell <dmoo_dv@protonmail.com> wr=
ote:
> > + static const char compat[] =3D "starfive,star64\0starfive,jh7110";
> Should be "pine64,star64\nstarfive,jh7110" ?
changed to "pine64,star64\0starfive,jh7110" in v2

On Tuesday, May 7th, 2024 at 12:31 AM, E Shattow <lucent@gmail.com> wrote:
> New property names are not made clear to me how to choose these
> different delays for 10/100 Mbps vs 1000 Mbps operation. If the
> fishwaldo repo is a valid reference then it seems different than the
> content in starfive_vf2_pro starfive_verb[]. No Star64 here to test
> with, does this work as-is for both network interfaces?
Agreed. I've created a separate object in v2 for some further investigation=
s
with the delays/timings to make sure they're both working

On Tuesday, May 7th, 2024 at 12:31 AM, E Shattow <lucent@gmail.com> wrote:
> On Mon, May 6, 2024 at 8:30=E2=80=AFAM H Bell <dmoo_dv@protonmail.com> wr=
ote:
> > +#define FDTFILE_PINE64_STAR64 \
> > + "starfive/pine64-star64.dtb"
> Should be "starfive/jh7110-pine64-star64.dtb" ?
fixed in v2


