Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274FC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E3A82163;
	Fri, 31 Jan 2025 15:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Av407HFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40C6827A6; Fri, 31 Jan 2025 15:46:25 +0100 (CET)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02EF82119
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738334781; x=1738593981;
 bh=ZmLQWQNYYxJpf4Fshn7I+YBCzln/kPpDvcXEhr7s9R8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Av407HFCIccHzzQMHEtGxxv9cgztWRQtwLcMTO7xt5MhHOHCt7sfF/i7mrp1Y5Agl
 ZDpJETUvDPEB7nDdmVkLp/NpoDro3ZYTM622Xw2jQEq6ItDDtYwH9EueYVkOzakMOp
 /5Amy0SDdd0T2VGuIR1twSpzk6qBI/wxMEiIejXJz22peUMqXBC8zIDijZAqr+2NB3
 xr/TU7SnMQZhLSbrXB69/pX6Nw36C7UqHZ8UtXCbnqPQBDMqfS3PtAR9axw5NW8aaz
 N2zj43bRjAOLetAxxV7e/8I5xR5YKiPmSZXSFwDxl1pmRcF1M74HbwapKyoR5/t5Jd
 j/6aD/HyUAt8Q==
Date: Fri, 31 Jan 2025 14:46:14 +0000
To: Sam Day <me@samcday.com>
From: Sam Day <me@samcday.com>
Cc: neil.armstrong@linaro.org, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
Message-ID: <s_fb8uiMw90w0qZFRTbvEoluC8dWQ0g1rIK3JnE2jrWt2VAZGX8Dt_JkNHQ65D6knKqPlrYxU61vhZ4zVQKKVb-eK5E5THmStpUOjMSuMac=@samcday.com>
In-Reply-To: <xIlslvS8rZ7CIVHeC6936caZmG2zwkB2gTgRzz15Qk2aKUPUgriyCGqttUhf7kU7PMlvrM-8Nh1scNnGdHbtWP3iUvE66srLi-p2gzTQnIE=@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
 <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
 <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
 <xIlslvS8rZ7CIVHeC6936caZmG2zwkB2gTgRzz15Qk2aKUPUgriyCGqttUhf7kU7PMlvrM-8Nh1scNnGdHbtWP3iUvE66srLi-p2gzTQnIE=@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: f95f28c4fc9278504c0b8207a9f7bf28bc90ea0c
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

Hello (again) Neil, Fabio,

On Friday, 31 January 2025 at 15:40, Sam Day <me@samcday.com> wrote:

>=20
> Hi Neil, Fabio,
>=20
> On Friday, 31 January 2025 at 12:04, Sam Day me@samcday.com wrote:
>=20
> > I'd love to take credit, but actually it was Stephan Gerhold who spotte=
d
> > this when we were debugging the issue together :)
>=20
>=20
> I got myself very confused here :) Stephan Gerhold helped me identify the
> issue fixed in patch #1 of this series. But the patch here to keep the
> clocks disabled was all me, baby.
>=20

Sigh, no. Ignore my last email. This patch (#2) is indeed the one that
needed an attribution tag.

It's one of those days where I should just ban myself from the keyboard to
save myself (and others) from needless suffering...

-Sam
