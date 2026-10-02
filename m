Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768CBCA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4316560DCB;
	Fri,  2 Oct 2026 21:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNWtkQpOMTQd; Fri,  2 Oct 2026 21:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F34A60D9A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976730;
	b=lfV/rSQfwZ1QVG+O7tE6OAyQPzuUv7jsHDv+Kdd2bSFV3ByA69FWOs1bvarViFgKCv3x
	 CUgAZ6lglkoPXpAfLGWaucMaPsudkq/4FoMI2wtriwQGD4r0URLX1KYnolhqFN9uNEDjr
	 V+Z8B9vqybbQIhEAv5RyPxnAYjKKhrE5c5R2SrAAB9DQpoPQdWmhApeu506sCb1ME/AHu
	 MaEfArZBXMZaYgYuQwla4wldwC0wganFD+Mi4idG0sLBbPUacfMwCcKspU3SmQspWkozg
	 Ni2WhvJc6959+Srs4vsZs6wMJ50xb9dtnPfIG6lh9ObjPSLzO7GffvV3qbMp1BG3JnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C88FtFcG1zvWKXucrQ3aMcqdZ08pgPQd70A8Lz6/+3Y=;
	b=pzunkjVoI8QOJea+smcCTtm8kLRySTh2YrTcDb5sYWCHYvZRcX/Rbd/g8bLQVZRyw5fr
	 0DHZSoFMnppeXuDYqW+fT4No8Rrd4ib+3BYd3r8eT71eIBJCcq7wOnKqEYRJ6eeqzjgbY
	 31nKojzILBntPaF7TVZq4Z2emf7yQ8FaLuSM46PulfYIvf+baHVV//tPYAxtOFypZYmqM
	 ukwqkGlBCFqxzqBSoC3tdIp5v2+1wnXVo8tuQEKPkAEvswGZhl6He4bFduOGF1Jrs42Fm
	 HTl0JPUX+sroWqG0LvbLDaOZlAi8/jrpEOa8f/Bu5T30Xtmy5Ya1GtPA+olnTYwO6gQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976730;
	bh=C88FtFcG1zvWKXucrQ3aMcqdZ08pgPQd70A8Lz6/+3Y=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Abr59we7532WUAAu1VOXgPHX7hTKp5xx/m/6EG57k5hCcKg87D4Fp/InUQJeUdezF
	 ja0VHoZ4dNsysb6hHFJ12H1AgJLsHpp0mxUo1lYf0GA8EyRbi3zLdK5qIZYPRUsIce
	 o8e7Upa/jSXRk51JI8AvJpocjxxIOnugmjzhD423I68Sx4EF7WX1A8dhTepYRgL8Wo
	 8jTTqYVTUm44cubo9oNXx3R/lRR0ZmzQ89dhy+ajJGN6xB34yv3Ga4dIYVtH8UNg6H
	 3Oj7401UQLtL95Q1tgv1RDtWYKHXzifULhCcqf985NHiKUQkWoKvRb5krgWMrhw+jQ
	 PFjUSFKdGtLTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F34A60D9A;
	Fri,  2 Oct 2026 21:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 419B1282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 334EB81396
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rq5AsnZsV3cK for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 710FA81349
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976700;
 b=TXAcIZxUi+3ERujtc5Ec2xptenhYz6sHqgIDit5NBP9z+VmjOYh4U6kiop+TtuNEnVcU
 u503/AQk7LIk+KrkS8SAbXT/VmrwVIyhvXPf8xmxYzzVlES6dC35GvLPUCF+rFuNw+t2p
 XccnL6p0F70AcLBROgNBR1F739PusCG3seU+1qnXgEgPGvf8JV0L0DjtYegCD7jlcFK4U
 Z8Omx+X/Du7zFZcuodY2TfYAbNrxjYYfFkA/wPvpyx9ZsNMlpPogCBFfm8j6ATmqdqkLY
 aTaFP3uJp0rQJBFJrCSN8MZxb0bSZqGw7ns5ilAL8hcZ7ZScPO1RIBQHihN3PPsaUyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976700;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=C88FtFcG1zvWKXucrQ3aMcqdZ08pgPQd70A8Lz6/+3Y=;
 b=UCc/+4AxOzWZPoWFwYDi0tLSYEYhYwaXUulVWg3bkfWB7AaauvrylHiqvxMhgrXDcIOk
 EhZKvTmr1VDJtIWsR6fdSYmOz3U7v6drvpkTwGkSuntpZEFw7qtdMxnkurQrdW61Fa+FY
 kcSHcqkSk1oF1tXHORUkO/vMcpqR4T6u8ngBOp0HSZ1rOTsAvNX5clKB6wrRv7SHqdCr1
 0t+dMc5XaFoNWDe4VU7hO3e7neKNJ32FhWPozCaUxM6Y+1QB6QWAikiJxcEQ/Z8vBE6ww
 6Umrj+1lg4QN7oH/nV/8o/jzoMQAW2PoMLjNTby1VpfOACP/+d8nOLoCX7/1VTOjTzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=eICJSv+q; 
 arc=none smtp.remote-ip=185.70.43.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=eICJSv+q
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 710FA81349
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976698; x=1791235898;
 bh=C88FtFcG1zvWKXucrQ3aMcqdZ08pgPQd70A8Lz6/+3Y=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eICJSv+qqgh/Q4Sy+t9LI0ts8NzhUe8g7f6yEVFHmmKSsaW14yPpU/eWY05A1Vr5q
 PZJYCPAEogEgZuksmvgo+jlZlchYV9x4pg/fjqYkKK+HWeMi1mIsAxR3cAv0rnCOf6
 EGk64x/AM/tL4FuvgpV6f9kNoF7+m9uCERHJr882DAofjN/9gmR4D1RM/8QBDm6dpb
 whYe2Q3o0IscUf/yC78tfmim14AnBHsp41IWlGNynSPDlT+alwBVxfzM8AJP8cYn33
 +b/4GlU9h5z6X8yWhvH3Thrkycz811BFRu89/djtb0UwIaXp1I8P+uCIpGprEhjOHn
 f/KpQ0jhrEXsw==
Date: Fri, 02 Oct 2026 21:31:33 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH 0/2] spacemit: k1: SPL robustness for boards without a PMIC or
 SPI NOR
Message-ID: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: abd65b509010326f8d71098ce06d2399c3ce960c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Message-ID: <20261002213133.GTPAJWy-qdnCacf-4wbD3uPXAWd8ZgASBkeU7uocbsw@z>

Two small SPL changes for K1 boards that do not look like the BPI-F3
and MusePi Pro:

1. pmic_init() and nor_early_init() panic when the device tree gives
   the SPL no PMIC or no SPI controller. A board that boots from eMMC or
   microSD with its rails already up (the OrangePi R2S and RV2) stops
   there. Log it and carry on.
2. Provide board_boot_order(): the device the BootROM booted from, as
   detected now, then the other MMC controller and SPI NOR, so an
   unexpected BootROM path still finds U-Boot.

Tested on an OrangePi RV2 booting from microSD (no SPI controller in
the SPL): "No SPI controller", then the SPL loads U-Boot from the card
through the detected MMC2. The fallback order was not exercised, since
the detection was right.

Dave Klotz (2):
  spacemit: k1: do not require a PMIC or an SPI controller in SPL
  spacemit: k1: fall back to the other boot devices in SPL

 board/spacemit/k1/spl.c | 48 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)


base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


