Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC84C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 07:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6F78861A;
	Mon, 12 Aug 2024 09:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RsBkHux9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E4C86E85; Mon, 12 Aug 2024 09:52:58 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D0988636
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85550E0005;
 Mon, 12 Aug 2024 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1723449175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7PpzaDGHygdrqNUU7mMCnrk/pK60RIbiBDNEjFfHYc=;
 b=RsBkHux905z4OCUqxG0WXJHjtVA01ppwCHluboE/aY5/yyMIchoRwSvK1enA10qAcDf0tx
 Ul+JvAVgJZJPGcSVlBE4wfyobnz9L7cnriE5e7/roszbuWErMTSbDu2hT7rz+oz1F7LfXy
 CtLQdBURG4ilt63k9YNG9BjlXa86VMTqyiauD9svBK4FjWCZ/Hh+qmNBnhKIXAzFPMtVn/
 J9a6OWAbmQ6lDbjqbMXdx9aC49Ey+I8fDllM6F46qfmrcgSo2kXd8DMe9bjoKEvEBL+DTP
 ZgqOEtMQlHg8BYSL2v+wPVmzr+s+x0+ejo+8YoNmXgEte937S7wjd/WPXAYP3Q==
Date: Mon, 12 Aug 2024 09:52:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, trini@konsulko.com,
 thomas.petazzoni@bootlin.com, jmcosta944@gmail.com
Subject: Re: [PATCH] squashfs: Fix heap corruption in sqfs_search_dir()
Message-ID: <20240812095254.54a82ad4@xps-13>
In-Reply-To: <20240802200509.2471-1-richard@nod.at>
References: <20240802200509.2471-1-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Richard,

richard@nod.at wrote on Fri,  2 Aug 2024 22:05:09 +0200:

> res needs to be large enough to store both strings rem and target,
> plus the path separator and the terminator.
> Currently the space for the path separator is not accounted, so
> the heap is corrupted by one byte.

Mmm, subtle.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for the fix!
Miqu=C3=A8l
