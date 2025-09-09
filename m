Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB40CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E18C831B4;
	Tue,  9 Sep 2025 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Yjkuiycv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E878312A; Tue,  9 Sep 2025 12:14:02 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD96830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1F9FC4E40C65
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 10:13:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id ED9D360630;
 Tue,  9 Sep 2025 10:13:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82A27102F1CF6; 
 Tue,  9 Sep 2025 12:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757412838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9jGCyGPWaO6x60sN5SLQPCw6/kLdqfycIyqAtRL1FjQ=;
 b=YjkuiycvFrJz7r9FfMpLWVFHEZbq4/GEgLFhs26v0gkBGhwsBPhc8dsCTUAdCgP2ud65WR
 UvOZMK1hASOQINkF1RYQ3XYRsfU7MYUlOgZ/AL2N6hwmruBdKCxuTYrBdxsWcWDzrlOVcq
 vp4V2JqSGlqtcnc/L3KETBqJ73U7MO1CJvDn7RP6K5Xs+qp6D9ejDTMp06+0Tw+OlNK3rM
 IVlj1Z65FHMWLRSfXY6ukYcl75SQMx1qGVzgrTAhlfHFFV1HYcks3vvDy9V30tT+wed7wf
 9B4eXDwQZZ7a0vHkaqwdPxEhuJRnHUSQBF/kkTcJGN+nrECP/mVUMji8t0yAsQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>,  Tom Rini <trini@konsulko.com>,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,02}jv behave
 correctly
In-Reply-To: <20250702092313.970234-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Wed, 2 Jul 2025 11:23:13 +0200")
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 09 Sep 2025 12:13:55 +0200
Message-ID: <87a534exwc.fsf@bootlin.com>
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

On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> These chips are internally made of two/four dies with linear addressing
> capabilities to make it transparent to the user that two/four dies were
> used. There is one drawback however, the read status operation is racy
> as the status bit only gives the active die status and not the status of
> the other die. For commands affecting the two dies, it means if another
> command is sent too fast after the first die has returned a valid
> status (deviation can be up to 200us), the chip will get corrupted/in an
> unstable state.
>
> The solution adopted here is to iterate manually over all internal
> dies (which takes about 30us per die) until all are ready. This approach
> will always be faster than a blind delay which represents the maximum
> deviation, while also being totally safe.
>
> A flash-specific hook for the status register read had to be
> implemented. Testing with the flash_speed benchmark in Linux shown no
> difference with the existing performances (using the regular status read
> core function).
>
> As the presence of multiple dies is not filled in these chips SFDP
> tables (the table containing the crucial information is optional), we
> need to manually wire the hook.
>
> This change is adapted from Linux.
>
> Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volatile-=
bit-v3-1-735363f8cc7d@bootlin.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Same question for this one, no feedback for the past 2 months, I'm not
sure who's supposed to take these, Jagan and Vignesh you are marked M:
in maintainers, any chances this can get it?

Thanks a lot,
Miqu=C3=A8l
