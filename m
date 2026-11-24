Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59231606A323
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KzcDW7Nt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B9BF6080E;
	Tue, 24 Nov 2026 18:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6wpqKQY3mZR; Tue, 24 Nov 2026 18:41:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BFBCC606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545671;
	b=aqapidhgiMUkNe+OxA5CZjzQXxV1pgiTFim9Jl4KYY7ovuCcjbOwZnf7BLL8pG4gz2Pu
	 knE2p4WT7kTrH3GiffscAhL79m+p02NxRGkRV9zuQJzdAu1rT+KxcZMp+RpCoSpZh7inl
	 DgJ8rtiOBMBP+Ab82ElJl5kK/F/aGqgHSFcDXrFg7DmsAL33oMbfdfhokLIqQVy62yckE
	 N7uX1Vz6zl4EJ/8loUtXGFvChxizA5pY0LAuCcT+yt4pub2o/tf8jVflrurHmgafN5TjZ
	 eY6S2+f++IfD/wAXksSfGTnhQqp0bsjfoZYABC54EyUeXVBShlh1uztAnXdlRbs3fKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ms2ZrFC+duFeH9vT1lG+/3PylOIvI7u3Y5tjPa17CZg=;
	b=soXM6vSrGNg7+Y8bgRmowy6zV7naMbKeDr2Fx+ikGiUgY+nDsCKuMgEL+gni0it0RdDD
	 fmGQ6DyUWHBRCqaXWDGxDT0UVHl0/fI6HvwO6jfbYTIyHP3yIlYeeooKi6lBgR2jNvs77
	 NMWE+jOg061F9tqx4fza7gYGITCOqBDC+bVYgY6pV/HqAQIYsvxJZOMGGvaJvwc8vAs3t
	 uIiY5w+908YKH1cfYrUaZb611HY67zf1jo3ZcBmdaFhPAnmW70oruyZ0ApxlvnpQ/slne
	 oI1nFDJD7Sxl3fNsHBa3SUQgxICbDfgNA5pwz9Np8/o45KlPyYAC1saNIO47nNbsMng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545671;
	bh=ms2ZrFC+duFeH9vT1lG+/3PylOIvI7u3Y5tjPa17CZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzcDW7NtkbNPWOCR2tf1W8KzpfPoqXMUK1qKS3H/YGNrHZgLcRjb9pd2oK7ByHj0M
	 I+smmbtWPAJd1guxpMXaGdwGDMUwuqa3uDv5kWCcy/B7cgiILrw8TYck41o099RbR3
	 0xPHzIh/jdYnFx+NFhiHUJzLWfBeex2SroPax+qjmNoCNl9J4peMMD9KwQ7hzzQAs5
	 aQ+x0mHR1qooB40/euHKFj8gwT4WA1IaVw3leVEcLXsjxFlhp9SsWb/K8tCqerte+f
	 vi4bEoatL6CtjMPjWbdbyunwWR4y9iCO31cKszkimWmzULif300X+9Nr802T/Firdp
	 zSFc1NcxuDMxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFBCC606F6;
	Tue, 24 Nov 2026 18:41:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CD9C2F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1294880E5C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6YotjUbNJEF for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F03D480E5B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=213.95.11.211
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=duwe@lst.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F03D480E5B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:41:07 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 107)
 id 3043068C4E; Tue, 24 Nov 2026 19:41:02 +0100 (CET)
Received: from rocky.lan (dynamic-077-007-076-138.77.7.pool.telefonica.de
 [77.7.76.138]) by verein.lst.de (Postfix) with ESMTPSA id DCA9A67328;
 Tue, 24 Nov 2026 19:40:21 +0100 (CET)
Date: Tue, 24 Nov 2026 19:40:17 +0100
From: Torsten Duwe <duwe@lst.de>
To: Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Filip =?UTF-8?B?S29rb3NpxYRza2k=?=
 <filip.kokosinski@gmail.com>, Anders Roxell <anders.roxell@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Dan Carpenter <dan.carpenter@linaro.org>, Tanmay
 Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, Yegor
 Yefremov <yegorslists@googlemail.com>, Volodymyr Babchuk
 <volodymyr_babchuk@epam.com>, Oleksii Moisieiev
 <Oleksii_Moisieiev@epam.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 6/8] mfd: add support for RPi5 RP1 chip MFD
Message-ID: <20261124194017.77e63905@rocky.lan>
In-Reply-To: <CAFLszTi7ubty_U1QArv399VxO-qj7h4_pQ9M_UW8YG9_-RrZsQ@mail.gmail.com>
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105627.70D9668C4E@verein.lst.de>
 <CAFLszTi7ubty_U1QArv399VxO-qj7h4_pQ9M_UW8YG9_-RrZsQ@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.50; aarch64-suse-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Sun, 27 Sep 2026 09:06:36 -0600
Simon Glass <sjg@chromium.org> wrote:

> > diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> > @@ -0,0 +1,127 @@
> > +static int rp1_pcie_read_config(const struct udevice *bus, pci_dev_t bdf,
> > +                             uint offset, ulong *valuep, enum pci_size_t size)
> > +{
> > +     /*
> > +      * Leaving this call because pci subsystem calls for read_config
> > +      * and produces error then this callback is not set.
> > +      * Just return 0 here.s
> > +      */
> > +     *valuep = 0;
> > +     return 0;
> > +}
> 
> A leaf UCLASS_PCI_GENERIC device shouldn't need dm_pci_ops at all -
> those are for PCI controllers. If the core is complaining, that looks
> like a real bug in the PCI uclass rather than something to paper over
> with a stub that silently returns 0 for every config read. Please
> investigate and fix the root cause.

You're absolutely right. The root cause is an oversight introduced in
commit ff3e077bd23 ;-) I've sent a patch [1][2].

	Torsten

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/641214.html
[2] https://patchwork.ozlabs.org/project/uboot/patch/20261119183502.30B9C68BEB@verein.lst.de/
