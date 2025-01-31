Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38DBC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 12:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1030B8215E;
	Fri, 31 Jan 2025 13:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Z9RFklzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84F88215E; Fri, 31 Jan 2025 13:49:47 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B4882119
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 13:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738327784; x=1738586984;
 bh=aPIJH7bNuth4LEusCoG4oWYEMJOaIkCdIsibfuhoWbA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Z9RFklzY5uMTrHqnAHYqqcyKtFJmX2fbBCLrIydAAnxP9mUgE2sJuCw752NndtihU
 L3ovtRQaPxj0RjLm4go81Pi9+BS6fgQo0/7NvJZRnX8tIWNWREfG3VetJdhEkcUW7u
 z3YWOHzcc6ydBe2CHWYUF44CqF2bX/ENfAPba5u/O6PYu/5UCj2wXs3kSH5m2OBVNv
 1dHJ2d5tGNktvqJirchAl55BJpW5RJJOaU+2yZCiKjTSqG3JZQ15+zMXTV+Y28aXBq
 h0kxSGs+uATkQ5H97l28SG8I35h2m9QZRUYpLngA+gs8N6WZ5ldkMN/Ty1zMp8Ldwr
 BGoWSpwamv8Ww==
Date: Fri, 31 Jan 2025 12:49:40 +0000
To: Fabio Estevam <festevam@gmail.com>
From: Sam Day <me@samcday.com>
Cc: neil.armstrong@linaro.org, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
Message-ID: <NjPJRn1ysduE-G625vvanUTRDEpCoaR2-XYkpPxMmorhMUTdXS5tUGUD3tQucGPl1GZphHNIjzbudzxyObI52n4HxZ_0rc-cfoASQv5614A=@samcday.com>
In-Reply-To: <CAOMZO5B0aKxmM52962AGeHthQurBnqM8Ob3es=xvM0=P-KoXgg@mail.gmail.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
 <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
 <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
 <CAOMZO5B0aKxmM52962AGeHthQurBnqM8Ob3es=xvM0=P-KoXgg@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 2c973f181457f34b4fc324cc68208c90575cde98
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

Hello Fabio,

On Friday, 31 January 2025 at 12:29, Fabio Estevam <festevam@gmail.com> wro=
te:
>=20
> On Fri, Jan 31, 2025 at 8:10=E2=80=AFAM Sam Day me@samcday.com wrote:
>=20
> > I'd love to take credit, but actually it was Stephan Gerhold who spotte=
d
> > this when we were debugging the issue together :)
>=20
>=20
> Maybe you could add a Suggested-by tag.

Thanks for the suggestion, I've applied that locally (but will hold off
on sending a v2 until I get more feedback on this series).

Perhaps I should also add a "Suggested-by-suggested-by:" to attribute my
learning of this tag to you? :)

Regards,
-Sam

