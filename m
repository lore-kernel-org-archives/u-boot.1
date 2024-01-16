Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F68DC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 08:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B823A8771B;
	Tue, 16 Jan 2024 09:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EqL6EZGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86F5875A0; Tue, 16 Jan 2024 09:01:39 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8404887800
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A83AA1F83F;
 Tue, 16 Jan 2024 09:01:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705392096;
 bh=ORiwVzjxfbhB6GhxBaAFRw5uRI2eGnVyFpoyV7wZ0yU=;
 h=Received:From:To:Subject;
 b=EqL6EZGtL1dtpRT7vM3sIXvJUyqCROpYMMsFdvjTzqukDnhgu4hHVycBGMJ0Mbtj4
 E/QxOOyFDvUD5YGatAdupqji5c37KMg982AOGKRMc1WCeLw1LoWtN0UC/UVf+wMM03
 52ovN2EAxfAGfs2IJyrwSKJRG3hyo6Ug01iPE8YA4RKk0cO6uoBOFq6tPQ7fB/5TB2
 LdK9//6njlamigqYt7QGvDRj7dsjdzVr0L+98jHhVJTe4jhlAK/pnw6QcIRp725aFT
 Hb9cr0KCgV+a99O876VgpV7/S7gHkrWG3UOeK1sI9h0G5TBZ+wJYtHJCnWtcJ/ZrCW
 8hiGgAucu7FIA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 351E47F96B; Tue, 16 Jan 2024 09:01:36 +0100 (CET)
Date: Tue, 16 Jan 2024 09:01:36 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Stefano Babic <sbabic@denx.de>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Message-ID: <ZaY34AgTKBSOdr3w@gaggiata.pivistrello.it>
References: <20240113183350.176131-1-marex@denx.de>
 <20240115154420.GA31739@francesco-nb>
 <0da23033-3084-4cf0-9339-10cfa0ba5351@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da23033-3084-4cf0-9339-10cfa0ba5351@denx.de>
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

On Tue, Jan 16, 2024 at 02:01:02AM +0100, Marek Vasut wrote:
> On 1/15/24 16:44, Francesco Dolcini wrote:
> > On Sat, Jan 13, 2024 at 07:33:17PM +0100, Marek Vasut wrote:
> > 0059, V1.1A and V1.1B, use a 20MHz oscillator
> > 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20Mhz oscillator
> 
> Do you happen to have a table of what was populated with which oscillator,
> so I can fill all the 20 MHz parts in right away ?

I guess that one quoted here from my previous email is "the table", but maybe I
have not understood your question.

Francesco



