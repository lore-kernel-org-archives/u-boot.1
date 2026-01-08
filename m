Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D039D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C038F8425F;
	Thu,  8 Jan 2026 18:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ee5WmYlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0468415D; Thu,  8 Jan 2026 18:19:50 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C01284144
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BE868C1ECBE;
 Thu,  8 Jan 2026 17:19:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CF33B6072B;
 Thu,  8 Jan 2026 17:19:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29F22103C8826; Thu,  8 Jan 2026 18:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1767892786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dnQASySMirTf4s8RSkUKGShdusFcPjvnWd6RfHyEmGc=;
 b=Ee5WmYlzTcmSZDyJkfMCA6SjhBkuIlRfXuID7LefasplFZ3HEfXqfafzgECI0ImBSoGMar
 FdIKx1Y5VCKPnTdVRYdJiYiJ5YT5MfBFZ+6iCL+qP/66cssfKGwJykO9Yt6AIeZ10fw3Z6
 NGHrGjqWsSgeRC7+ovm31m2eGNvL1XqzrGFbo9PDzi2fdkRcbqjQ5RpTmcd+eHpoIDno05
 JxD1KSfI35kdNqwzKkJV+z7lZMLOpZEfSbqe4dXzg0PYMV7czfGrtXI3L9zqG/4nJDHt3E
 zBD+Casdzwfs/joIWpPxDR1QgdjeJ6IkgLq9ZLnyacJNmdmC1jfAaU5QZ2PQqQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Peter Suti <peter.suti@streamunlimited.com>
Cc: u-boot@lists.denx.de,  Radek =?utf-8?Q?Dost=C3=A1l?=
 <radek.dostal@streamunlimited.com>,
 Tom Rini <trini@konsulko.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,  Heinrich Schuchardt
 <xypron.glpk@gmx.de>,  Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 2/2] cmd: mtd: fix default length calculation when
 offset is specified
In-Reply-To: <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
 (Peter Suti's message of "Tue, 16 Dec 2025 14:40:42 +0100")
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 08 Jan 2026 18:19:44 +0100
Message-ID: <87tswwxbrj.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 08 Jan 2026 18:51:53 +0100
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

On 16/12/2025 at 14:40:42 +01, Peter Suti <peter.suti@streamunlimited.com> =
wrote:

> When the 'mtd read' command is issued with an offset but no size (argc=3D=
1),
> the length defaults to the full partition size ('mtd->size').
>
> This calculation is incorrect because reading 'mtd->size' bytes starting
> from a non-zero offset results in a read request that extends past the
> end of the partition. This causes the MTD layer to return error -22
> (EINVAL).
>
> Fix the default length calculation to be 'mtd->size - offset' so that
> reads starting from an offset effectively read "to the end of the
> partition" rather than attempting to read out of bounds.
>
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> [add {} for better readability]
> Signed-off-by: Radek Dost=C3=A1l <radek.dostal@streamunlimited.com>

Makes sense.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
