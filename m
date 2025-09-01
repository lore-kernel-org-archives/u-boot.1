Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E5BCA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4C383A28;
	Mon,  1 Sep 2025 15:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WOBZDR3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F23839DD; Mon,  1 Sep 2025 14:10:44 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9564583965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 14:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EA3F11A09DD;
 Mon,  1 Sep 2025 12:10:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B74BA60699;
 Mon,  1 Sep 2025 12:10:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B7E871C22DE24; 
 Mon,  1 Sep 2025 14:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1756728640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=41igIydgUhHSMr1STGB89wOpFGjc5ziyQSy+xTKGXnU=;
 b=WOBZDR3oGo0cxDeNAGaEzba8Zytdg1/qeMsrnfMEd1J3glitxGmSsgzJgNFmw1eh4RlToP
 y/d7prYw7Sh6RGiSRyQexicJrxzqkUD+Rans3PKYatBJFSiyC8fRdL4ncnwHuZKGDHHeBj
 MVmrWRWgkHlRDyMUhSG7r+aAKJJmmRb3Cljfq4ruakcXWgBMPuOA+yIR24bPk6roR4a1l8
 CCP9TdtzZws3tA+dZHSUyPQYameKDnWqIRnjx8KyJ4+cPZSMM4UsKavl8lBrqe1EdUM3hA
 9Z61SDKI7QKvQfLqEqXkC0IdFCWuOaniXgd4y4Cemzmf6w7loUeeRvv7YGYmNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: bigunclemax@gmail.com
Cc: Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Patrick Delaunay
 <patrick.delaunay@foss.st.com>,  Sam Protsenko
 <semen.protsenko@linaro.org>,  Christian Marangi <ansuelsmth@gmail.com>,
 Marek Vasut <marex@denx.de>,  Maxim Kochetkov <m.kochetkov@yadro.com>,
 Jonas Karlman <jonas@kwiboo.se>,  u-boot@lists.denx.de
Subject: Re: [PATCH v1] clk: Only enable the parent clock if the clock was
 enabled before reparenting
In-Reply-To: <20250829082628.623597-2-bigunclemax@gmail.com>
 (bigunclemax@gmail.com's message of "Fri, 29 Aug 2025 11:25:00 +0300")
References: <20250829082628.623597-2-bigunclemax@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 01 Sep 2025 14:10:08 +0200
Message-ID: <87iki2pe5b.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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

Hi,

On 29/08/2025 at 11:25:00 +03, bigunclemax@gmail.com wrote:

> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> The current implementation of clk_set_parent() unconditionally enables
> the new parent clock, even if the target clock was not previously enabled.
>
> To avoid this implicit behavior, this patch adds a check for whether
> the target clock has been enabled before parent enabling..
>
> Fixes: ac30d90f336 ("clk: Ensure the parent clocks are enabled while repa=
renting")
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

It took me a bit of time to understand your issue, but that sounds
legitimate indeed.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
