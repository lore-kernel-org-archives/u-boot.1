Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E920FC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F5C760BA4;
	Fri, 24 Jul 2026 14:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZmU_NB0-U5A; Fri, 24 Jul 2026 14:02:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 134E360B97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901734;
	bh=uj2Aj0tPj5UnlycPzDExWsO0WR5NzxROoXa4iLNWIrQ=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MAwqBjD6N6n60Yo2NW6FRBbL7KBqw5McImlMkcc36OFO92csDSaOH2kYxtKvGeupL
	 SY+hMRWdhFlPWLbkpBZLxLsULGo9fBg0jlbRgrFykI1kbPyim9tphOhxDGyGtm0zKL
	 u3Epo1cfNDFfDIWDyJu1UxERz6oHt1161I/pyfcI5KTpjbEgG0PSYBMQqfx3vXZgRk
	 YOUyzzlz89s6usPNwJne2VRFKPH3/IBXiCbWQHHQme1/t4r+XQEuP+xjqJI4/L7aSR
	 veNSsepbD3Zbj4n3xcvREpXZILs1uJzwuhIfYWRZ+E7xR6EosOvMmdin2Q1xSAuNK9
	 BZmLBfcME1fRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 134E360B97;
	Fri, 24 Jul 2026 14:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E67D53B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D870F80AEF
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UijqNJBzYMZC for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:44:27 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=miquel.raynal@bootlin.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A476080ABD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A476080ABD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A476080ABD
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:44:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A4C803F6; Fri, 24 Jul 2026 11:44:24 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE9E800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 11:44:21 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 533DA4E40EE0;
 Fri, 24 Jul 2026 09:44:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 161DD60395;
 Fri, 24 Jul 2026 09:44:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 03C1811C11DF5; 
 Fri, 24 Jul 2026 11:44:17 +0200 (CEST)
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: u-boot@lists.denx.de,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Chris Packham
 <chris.packham@alliedtelesis.co.nz>,  Aryan Srivastava
 <aryan.srivastava@alliedtelesis.co.nz>
Subject: Re: [PATCH] mtd: nand: pxa3xx: Fallback to 1-bit ECC when chip
 requirement is zero
In-Reply-To: <20260624041243.1045912-2-ronan.dalton@alliedtelesis.co.nz>
 (Ronan Dalton's message of "Wed, 24 Jun 2026 16:12:44 +1200")
References: <20260624041243.1045912-2-ronan.dalton@alliedtelesis.co.nz>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 24 Jul 2026 11:44:16 +0200
Message-ID: <87y0f0rabz.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784886260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=uj2Aj0tPj5UnlycPzDExWsO0WR5NzxROoXa4iLNWIrQ=;
 b=JTwzhCIt03d4QU0ZtVYbjx2uvZ4pf+iKQg9ew/UWho4RR+yR5hI6KY7JtNUpIgplUyKhOJ
 pkbtuIGnQrVdWDcYvBvmdyykB0yxv35lEslxL3uEk50Cr5iSTH2f1ipgEgDhVWUOLTiVzD
 qQnAVWkXYS+dJRks39wBLsHRbM5iK4uBk+0sxgPnlYIhj/1eyY1xRzMMK1L0LCJd5+bKQE
 CuDuf9PKhyd2FiY/GHoEcvddNQHacmGv4fanGUlltKsj4NqGMf4VM2qhfKNlgvpGS0E+AV
 3Od8NefvoBfQdrtUTlRolspTCnmelbFN68OF+TJ4wwK+TWNnLr0eN9O5jpYfxw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=JTwzhCIt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miquel.raynal@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JTwzhCIt"; 
 dkim-atps=neutral
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
From: Miquel Raynal via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ronan,

> Currently there is no fallback condition for when a NAND chip connected
> reports an ECC requirement of zero and no value is specified in the DTS.
> When this happens, pxa_ecc_init attempts to find a match, but fails with
> the following error message:
>
>   ECC strength 0 at page size N is not supported
>
> Linux already has a fallback case for this scenario.
>
> Make u-boot match the Linux behavior by triggering the fallback when the
> ECC strength requirement reported by the chip is zero. Changing && to ||
> is sufficient to make the behavior equivalent.
>
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
