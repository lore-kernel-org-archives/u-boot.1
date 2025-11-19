Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E5CF34DA
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11AB83F80;
	Wed, 19 Nov 2025 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jA9e1F2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5181D83E0E; Wed, 19 Nov 2025 11:02:06 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5800983BD2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7D614C11185;
 Wed, 19 Nov 2025 10:01:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B340D60720;
 Wed, 19 Nov 2025 10:01:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 71C7110371A28; Wed, 19 Nov 2025 11:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763546518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4zdUdhGjFvIXvvkwcHsZ5fKvhq2f0rigYrMbylHgKRs=;
 b=jA9e1F2dsA9Csvwynq6RZxciPf33fXNvnQgp8/rabJXaWJFpr6GHiftzBA2SpAvRI9/Aw0
 mp31hNmCio6VEvT5Ysnyt0NiXjJ4/uHFqmFwysEqIdW16E71utjV3ddBYtbDSYqc5swGgy
 0VPSYDBgmvWniUGRaFduYIcQ7qmv4o7mq4338OMu7xatNPpsHOo+S7Dw4RUmxg5vhT0VJ5
 8sKf4mhXzY0bKs6fRC4ldXedixAHeA3PqwnUMEMs7308rWSyr4yik0cNru69m5XPp0atPL
 HRgU78BX2MOOpCEU6I953nSrJcw53s+ssTSRBlwp+ptnsxuTyVT41KpDiSu4dg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,  Jagan Teki <jagan@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Vignesh R
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  U-Boot-Denx
 <u-boot@lists.denx.de>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
In-Reply-To: <CAOf5uwmygi5z3ae_wgJxu4LSKWfEHfAzPTWzN3TUCk22pHqikQ@mail.gmail.com>
 (Michael Nazzareno Trimarchi's message of "Wed, 19 Nov 2025 10:06:42
 +0100")
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
 <20251118143405.GA527619@bill-the-cat>
 <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
 <CAOf5uwmygi5z3ae_wgJxu4LSKWfEHfAzPTWzN3TUCk22pHqikQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 11:01:55 +0100
Message-ID: <87cy5ecpd8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 19 Nov 2025 16:39:33 +0100
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

Hi Michael,

On 19/11/2025 at 10:06:42 +01, Michael Nazzareno Trimarchi <michael@amarula=
solutions.com> wrote:

> Hi Tom, and Miguel
>
> I pick a large part of the patches now, and check them and rebase all
> of them. I will prepare one pull request today and another later this
> week

What do you mean by "a large part"? Can you be more specific about
which patches you would not be picking and why?

I am not comfortable with this sentence given for how long these have
been reviewed and applied in Linux and also submitted to
U-Boot. Custodians are supposed to work in best effort mode, but
delaying, delaying and further delaying is not what I would qualify as
an adapted behaviour. I understand you have other work to do. I also
take my responsibility in reviewing and collecting and merging patches,
I may do errors and I correct them when that happens, but try not to put
all the pressure on my very own shoulders, down to the situation where
nothing moves anymore. Tom has been regularly trying to provide support
and help. I would friendly suggest Amarula folks to adopts a softer/more
progressive approach regarding maintainance roles.

Thanks,
Miqu=C3=A8l
