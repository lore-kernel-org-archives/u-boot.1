Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5272AC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 10:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC9481F6B;
	Tue, 15 Apr 2025 12:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ShNT68sR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A302829E4; Tue, 15 Apr 2025 12:48:01 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F781810F4
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4D6F81F8F7;
 Tue, 15 Apr 2025 12:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744714077;
 bh=mI6zlx+ghS81wX1zqcIpPqms1OCJWI56+L8etwaA5gI=;
 h=Received:From:To:Subject;
 b=ShNT68sRe54LvAzhAAMWXu2z61VPejpvuEVwaf4im/024s5P+uDpQHkaRN7N7WoFD
 vh540AaAnfocBzWKE6ko3DkogpVaz5ouqrWy0ws6j9943PkDRuxDNK6j2BNFWv9UsQ
 +tpYomLn2dvkKe+nuYaLfIkAp7xe0qIjvfxiLT5QSHhGIdaPwvZxQsa5tEXfHf0ie0
 7NpczN/NWrdRClTnflJg5c4bJ6LfhFMrfgRN0GkIDgJfegRcy05fTuicAsN8vvZH+I
 s5z+8b5B5Wt19VHjMT45xWqhPJLbuq/VxcU7+lmQcMCaAm9FsJxQz3AdxkE2aH7CVc
 6xIAgH4WpW1MA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id C27F57FA6A; Tue, 15 Apr 2025 12:47:56 +0200 (CEST)
Date: Tue, 15 Apr 2025 12:47:56 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
Message-ID: <Z_45XKwccE7r8UiT@gaggiata.pivistrello.it>
References: <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
 <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb> <87wmblyh6j.fsf@bootlin.com>
 <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com>
 <87sem9wy6e.fsf@bootlin.com>
 <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com>
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

On Tue, Apr 15, 2025 at 03:29:09PM +0530, Neha Malcom Francis wrote:
> On 15/04/25 15:20, Miquel Raynal wrote:
> >>> Francesco, are you also testing on K3 platforms?
> >>>
> >>
> >> Yes he would be, since the firmware print is K3 firmware.
> >>
> >>> Can one of you boot with the patch below applied? It should partially
> >>> revert the commit to the ancient behaviour, while adding more debug
> >>> traces (please enable the debug logs as well). This should clarify
> >>> which one of the 3 different path is likely failing. It should also help
> >>> identify who's the user that fails to enable/disable its own power
> >>> domain. I will need to know what board/SoC was used for the test, so I
> >>> can look the relevant driver up.
> >>
> >> Booted on j784s4_evm
> >>
> >> https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3
> 
> ^
> >>
> >> Currently debugging on my build where I hang in console_init itself, I
> >> think the path for failure is different here, will confirm.
> > 
> > Thanks a lot for your feedback. Normally by applying the diff shared in
> > my previous e-mail, you should have the console back. If not, maybe
> > there is something else involved and the blamed commit is just the first
> > showing an underlying problem.
> 
> I do have console back with that patch, see the gist link above. What I
> meant was the path of failure seems to be different, it's looking like
> with my version of firmware the serial driver probe
> (ns16550_serial_probe) tries to do a readb() and fails, this could
> possibly be because the device was not powered on to begin with. Whereas
> in another case (what Francesco is seeing), this issue is not run into.

For the record, my logs and tests are on Verdin AM62 (that uses a TI AM625 SoC).

Francesco

