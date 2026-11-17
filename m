Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9EA606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BoEZDGaF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aj2dWXHD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 841D4810A5;
	Tue, 17 Nov 2026 21:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJxZ2Mpgfvlm; Tue, 17 Nov 2026 21:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 103C6810C5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794949460;
	b=ko60j3bg126Mj8k5XgMziYFBFjg/LfuzpBxELk2VV4p4zW5jwIGgZ09R21hDKxY69RGy
	 LgnZcO7LWVd1uWhKoKr08XAY4HSWcVS3dp5XRxJy4NxSOBfNH0ko10fwCF7+A/6GjgHle
	 rQi90FfilA2hw+ToUHchHhQZAJYR6WkSUy8duny6J2UFjpKOIJyvxaALhUzIwka1749rt
	 9gfRfDHgTomZ3Yw0+HHyQNgjwtyht73yLXWlDTuWrnPrS4tsV9f0CYK7En4YH2F4fOfx8
	 umtYITdIhJkW0MIMvEsbOY+GDbujbJuVFwcQaDT4VlaZ78nD1R+pBnPNuA6l0/l4IHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794949460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F0dy7XkyaX/RJ7EU1DN3F4KN19EsjFCEY4BSVlFU+5c=;
	b=mTC1ekhBP4nQnsNa89RD1+F2odx7oHbV4J0sDQyg3pRdChQB97dXMfnRWFWad9xnDLnW
	 WgMfS/MebZKWPy3M5MPReJE9R9rNh0vv4qk61ma85XnKviM8e9P4e2XUSFlWoTFq9IRJV
	 w3Ax1i4UoLH0LHLqH1NbF5DZc1Jbtwn8c4yxXqPRkH8ZbY3FGK/Zb9TYG2aVVDnvN5P+R
	 F0GjnU0Pgvi7pHt6fDH9U7KXnPjbLvin5HTh8bBBBDbvrNzliGfXeiXn/3Uq22t+bEe+E
	 i/EOfjGnMbAn47osW0cTBwioammLbPYjD45Lo2rPqDC7rZy2mhYEeTP/NcgHA2bLlYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794949460;
	bh=F0dy7XkyaX/RJ7EU1DN3F4KN19EsjFCEY4BSVlFU+5c=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=BoEZDGaFVlHrItomN6fEUtG2z/QdD+SaHYIqmKgCZ+Mu2fm6Ajs0p4mzQj97shdx+
	 UGYRRhyYEILbCnzuGawAtzqN9qQJSb9flfxmfychT5KltH+BholXxxs1JR49ttn/qu
	 EdxAkP9G8dLMZB/o9CD2glEJBD3n+bjCRacOoLyKecMRVmY7xb84jkfCVhiJl19fXd
	 URDeupfZMuatATaKw2nWhNRFGOHeJLxlT9ZfWanBEGXfLW86L0kl9ee916+JgbIcJA
	 DAmxgsTYWs7ijIoLUQFJREsnwNRSpdzQkK0aGjybp+pKa9rWaWmiQEzqtkL6KiIS9N
	 x3YItp5Sro5Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 103C6810C5;
	Tue, 17 Nov 2026 21:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FA8D9F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 657FF60642
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0J64rOpJnxm8 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 21:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81C8B605C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=95.215.58.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.102;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=aj2dWXHD
Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81C8B605C7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:04:12 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=WGlcWSCAGHTJUa2nW3bm3EbzSakSFoDJSDNzTIzmRxE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794949448; v=1; x=1795554248;
 b=aj2dWXHDunb7EOA6aKvh0XWDQSuIpVNEc/k3TDLPEhpks/oaWjt+JO168nPnPTLbgzeqt18k
 J8qMiXsi1n2C+CoK+hFfAhdUCapZCPi54HejINBLIc50NOHu0G3pGngf+lhQfjhqjeoopP3PZxe
 OPbEHlXCQYmTGL1hZi088ozY=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 0853f31d74460f71;
 Tue, 17 Nov 2026 21:04:08 +0000
X-Mizu-Trace-ID: 0853f31d74460f71
X-Migadu-Flow: FLOW_OUT
Date: Tue, 17 Nov 2026 21:04:06 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: trini@konsulko.com
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] doc/git-mailrc: Start updating
In-Reply-To: <20261117164733.2806843-1-trini@konsulko.com>
Message-ID: <2F72DF93-9050-4AE1-BF50-225312A5EF0E@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17 November 2026 16:47:32 GMT, Tom Rini <trini@konsulko.com> wrote:
>The file doc/git-mailrc can be used by git and other tools that read
>this file format, such as mutt, to make it easier to email patches by
>providing aliases. The file is also long out of date, so do a first pass
>at the moment to more closely update the current state of who maintains
>what.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>
>---
> doc/git-mailrc | 47 ++++++++++++++++++-----------------------------
> 1 file changed, 18 insertions(+), 29 deletions(-)
>
>diff --git a/doc/git-mailrc b/doc/git-mailrc
>index d6045875864c..f745279bfa58 100644
>--- a/doc/git-mailrc
>+++ b/doc/git-mailrc
>@@ -12,11 +12,9 @@ alias u-boot uboot
> # things simple and easy to look up/coordinate.
> alias abiessmann     Andreas Bießmann <andreas@biessmann.org>
> alias abrodkin       Alexey Brodkin <alexey.brodkin@synopsys.com>
>-alias afleming       Andy Fleming <afleming@gmail.com>
> alias ag             Anatolij Gustschin <ag.dev.uboot@gmail.com>
> alias agraf          Alexander Graf <agraf@csgraf.de>
> alias alexnemirovsky Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
>-alias alisonwang     Alison Wang <alison.wang@nxp.com>
> alias angelo_ts      Angelo Dureghello <angelo@kernel-space.org>
> alias apritzel       Andre Przywara <andre.przywara@arm.com>
> alias bmeng          Bin Meng <bmeng.cn@gmail.com>
>@@ -29,29 +27,21 @@ alias freenix        Peng Fan <peng.fan@nxp.com>
> alias iwamatsu       Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> alias jaehoon        Jaehoon Chung <jh80.chung@samsung.com>
> alias jagan          Jagan Teki <jagan@amarulasolutions.com>
>-alias jhersh         Joe Hershberger <joe.hershberger@ni.com>
>-alias kevery         Kever Yang <kever.yang@rock-chips.com>
> alias leyfoon        Ley Foon Tan <lftan.linux@gmail.com>
> alias lokeshvutla    Lokesh Vutla <lokeshvutla@ti.com>
> alias lukma          Lukasz Majewski <lukma@denx.de>
> alias macpaul        Macpaul Lin <macpaul@andestech.com>
> alias marex          Marek Vasut <marex@denx.de>
> alias mariosix       Mario Six <mario.six@gdsys.cc>
>-alias masahiro       Masahiro Yamada <yamada.masahiro@socionext.com>
> alias mateusz        Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> alias mbrugger       Matthias Brugger <mbrugger@suse.com>
> alias monstr         Michal Simek <monstr@monstr.eu>
> alias prom           Minkyu Kang <mk7.kang@samsung.com>
>-alias ptomsich       Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> alias sbabic         Stefano Babic <sbabic@nabladev.com>
>-alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>-alias sjg            Simon Glass <sjg@chromium.org>
> alias smcnutt        Scott McNutt <smcnutt@psyent.com>
> alias stroese        Stefan Roese <stefan.roese@mailbox.org>
> alias tienfong       Tien Fong Chee <tien.fong.chee@altera.com>
> alias trini          Tom Rini <trini@konsulko.com>
>-alias wd             Wolfgang Denk <wd@denx.de>
>-alias priyankajain   Priyanka Jain <priyanka.jain@nxp.com>
> 
> # Architecture aliases
> alias arch           arc, arm, m68k, microblaze, mips, nios2, powerpc,
> sandbox, superh, x86
>@@ -73,19 +63,19 @@ alias s3c            samsung
> alias s5pc           samsung
> alias samsung        uboot, prom
> alias snapdragon     uboot, mateusz
>-alias socfpga        uboot, marex, dinh, simongoldschmidt, tienfong
>+alias socfpga        uboot, marex, dinh, tienfong
> alias sunxi          uboot, jagan, apritzel
>-alias tegra          uboot, sjg, Tom Warren <twarren@nvidia.com>
>+alias tegra          uboot, Svyatoslav Ryhel <clamor95@gmail.com>
> alias tegra2         tegra
> alias ti             uboot, trini
>-alias uniphier       uboot, masahiro
>+alias uniphier       uboot
> alias zynq           uboot, monstr
>-alias rockchip       uboot, sjg, kevery, ptomsich
>+alias rockchip       uboot, Quentin Schulz <quentin.schulz@cherry.de>
> 
> alias bcm283x        uboot, mbrugger
> alias rpi            uboot, mbrugger
> 
>-alias m68k           uboot, alisonwang, angelo_ts
>+alias m68k           uboot, angelo_ts
> alias coldfire       m68k
> 
> alias microblaze     uboot, monstr
>@@ -96,39 +86,38 @@ alias mips           uboot, danielschwierzeck
> alias nios           uboot, Thomas Chou <thomas@wytron.com.tw>, smcnutt
> alias nios2          nios
> 
>-alias powerpc        uboot, afleming, stroese, wd, priyankajain, mariosix
>+alias powerpc        uboot, Bradley Morgan <bradley.morgan@linux.dev>

Acked-by: Bradley Morgan <bradley.morgan@linux.dev> # PowerPC

> alias ppc            powerpc
>-alias mpc8xx         uboot, wd, chleroy
>+alias mpc8xx         uboot, chleroy
> alias mpc83xx        uboot, mariosix
>-alias mpc85xx        uboot, afleming, priyankajain
>+alias mpc85xx        uboot
> 
>-alias sandbox        sjg
>+alias sandbox        uboot
> alias sb             sandbox
> 
> alias superh         uboot, iwamatsu, marex
> alias sh             superh
> 
>-alias x86            uboot, sjg, bmeng
>+alias x86            uboot, bmeng
> 
> # Subsystem aliases
>-alias dm             uboot, sjg
>+alias dm             uboot
> alias cfi            uboot, stroese
> alias dfu            uboot, lukma
>-alias eth            uboot, jhersh
>+alias eth            uboot, Jerome Forissier <jerome.forissier@arm.com>
> alias kerneldoc      uboot, marex
>-alias fdt            uboot, sjg
>+alias fdt            uboot
> alias i2c            uboot, hs
>-alias kconfig        uboot, masahiro
>+alias kconfig        uboot
> alias mmc            uboot, freenix, jaehoon
> alias nand           uboot
>-alias net            uboot, jhersh
>-alias phy            uboot, jhersh
>+alias net            uboot, Jerome Forissier <jerome.forissier@arm.com>
>+alias phy            uboot, Jerome Forissier <jerome.forissier@arm.com>
> alias spi            uboot, jagan
> alias spmi           uboot, mateusz
> alias ubi            uboot, hs
> alias usb            uboot, marex
> alias xhci           uboot, bmeng
> alias video          uboot, ag
>-alias patman         uboot, sjg
>-alias buildman       uboot, sjg
>-alias pmic           uboot, jaehoon
>+alias buildman       uboot
>+alias pmic           uboot, freenix, jaehoon
>

--- Thanks!
