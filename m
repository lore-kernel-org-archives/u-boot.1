Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E498CCAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B75E8318E;
	Tue,  9 Sep 2025 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oLNjXnd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBC08312A; Tue,  9 Sep 2025 12:12:36 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DD5830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 324904E40C6A;
 Tue,  9 Sep 2025 10:12:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0472160630;
 Tue,  9 Sep 2025 10:12:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB880102F293A; 
 Tue,  9 Sep 2025 12:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757412753; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5FID/S3JDIUnF8mBd/e/zII4on4hbMWSUkkDfmnJAoc=;
 b=oLNjXnd9CiMwIahbnAu3xCrfHvx5qzGjR5XCoETW5EOjwaITonNA8D+kKQSlyTLSUJU2W1
 wQ/62/4MpL7EtjRmP050nkUodjRsQu/yGU4e3xsoaNDSlMvdgZH4aHpjPRvQIUetWADu9K
 BpusL/A8U5R0YDiVyBt+fgyTMgDJqqTBINn0E9Osp7nfThqrO3t6EVVs2+q/9LMGlsePk6
 N5mmh493dMFTCvKEpdwjd6d4a3i0TzHojwzraLSFjYB8BsUDcsar/bRoyf/9RrSY71/U9y
 i0orzklM4zPINgY2+TQiY1ly9CYzslLZtoVVQpd6CuwEp/Ruc3ZZSTj2YUYvOA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,  <u-boot@lists.denx.de>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
In-Reply-To: <20250703170253.1231818-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Thu, 3 Jul 2025 19:02:53 +0200")
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 09 Sep 2025 12:12:26 +0200
Message-ID: <87frcwexyt.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

Hello,

On 03/07/2025 at 19:02:53 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> All these chips are dual and quad capable. They are also DTR capable,
> but the core is not yet ready for that.
>
> Performances of all chips are comparable at 30MHz and are as follow:
> Eraseblock single read speed: 938kiB/s
> Eraseblock dual read speed:  1068kiB/s
> Eraseblock quad read speed:  3751kiB/s
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I believe this patch has been out for more than 2 months and is simple
enough, any plans for taking it soon?

Thanks,
Miqu=C3=A8l
