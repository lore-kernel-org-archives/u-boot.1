Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2B5C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA594826C2;
	Fri, 31 Jan 2025 15:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Qap8Pu9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B1582119; Fri, 31 Jan 2025 15:40:21 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0DA8277D
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 15:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738334417; x=1738593617;
 bh=iNXcM3VHlqzokf9Ie9l65Ex1y2cZ+4+Q79sgykxpDFw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Qap8Pu9U0/rcDUPz0l/Zln5vSe2s9ICH9iRrkigbIgNSWYdOPOX3GHh36hldCnXPV
 jstJ/oy0l5XgYrEtCvKqIB95nr5OeLGF0uvt3KUUM8aQYKk3gA0K5BXx1pk4VTloi4
 kB12ceUEpIrL8LE3WlaB2zDBb2xET6OeTrxxIS5YOBRcsdNMuWfAlC6T74uK5nhNIr
 CambcAYutmwq13ZNavH3pHo2RFC3nhMQaxcvh+PaGqxDTDuybIJEpyQL1rOy5cV4yH
 PvbucCJVH6LZQth8xJEaRKTxTL77Ozmym3k2MFAH2LGDaY7NWELu3K+EiLJct0cJqD
 jZ5ZKvsQpDNMQ==
Date: Fri, 31 Jan 2025 14:40:13 +0000
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
Message-ID: <xIlslvS8rZ7CIVHeC6936caZmG2zwkB2gTgRzz15Qk2aKUPUgriyCGqttUhf7kU7PMlvrM-8Nh1scNnGdHbtWP3iUvE66srLi-p2gzTQnIE=@samcday.com>
In-Reply-To: <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
 <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
 <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 4d0228f2d891cc998c58d98b3c2653b963d6b9a1
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

Hi Neil, Fabio,

On Friday, 31 January 2025 at 12:04, Sam Day <me@samcday.com> wrote:

> I'd love to take credit, but actually it was Stephan Gerhold who spotted
> this when we were debugging the issue together :)
>=20

I got myself very confused here :) Stephan Gerhold helped me identify the
issue fixed in patch #1 of this series. But the patch here to keep the
clocks disabled was all me, baby.

Still, I wasn't aware of the Suggested-by: tag, and have since applied that
to patch #1.

Regards,
-Sam

