Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8074CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 22:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95EB835FE;
	Sat, 30 Aug 2025 00:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LpKXPRpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DD0836D3; Fri, 29 Aug 2025 23:54:42 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999FA835FE
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 23:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id F0DD04E40C2C;
 Fri, 29 Aug 2025 21:54:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C97C5605F1;
 Fri, 29 Aug 2025 21:54:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43BA51C22C97A; 
 Fri, 29 Aug 2025 23:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1756504478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Vdgle1VxBZ5ZuV4u6klnZ0jk3frJP8bPwXyh4yvjhzI=;
 b=LpKXPRpZUQvwiuLKHefdR+2Ov/R790vX9yrakWjs9cKNncwY4iUXjCjkzbt6oft/2tSAaq
 USVdxyzCycusO1bhhmBv1iGOUfTle66IdiRx5eCz96XDpyoJjCpTcPE32xmewtcD/q73+N
 8EPzH/yU7e9TwUTvNcLRnkWnsa3xEbo9U5zSB0TPEU30FUw+H0RQVVGmL5Hd94bwvsEHij
 8tK+bEdV65PfuwgbUfYwi37VRffxTsg3oKIHAQNO5yqHyIrxSYti/hn48UUjDmKFDwefZT
 kAoV5Y+7jXsmHrHu+DWZGGNDsJ0XBT5NqSUSWGXlOrl6k1Q+IcgDUQNz1AI+5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH v5 2/2] cmd: mtd: add benchmark option to the help
In-Reply-To: <20250829075911.2895683-3-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Fri, 29 Aug 2025 10:59:11 +0300")
References: <87tt1r6api.fsf@bootlin.com>
 <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
 <20250829075911.2895683-3-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 29 Aug 2025 23:54:22 +0200
Message-ID: <87plcd94kx.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 30 Aug 2025 00:39:00 +0200
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

On 29/08/2025 at 10:59:11 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> The patch adds benchmark option to the help of mtd command. For the
> 'mtd write' case the help line exceed 80 characters. Ignore this issue
> as modern terminals are capable to handle more characters.
>
> The patch also formats other command to make sure all device names
> starts on the same collumn.
>
> Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/mtd.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 57f6c700f1d..f053dbadd78 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -782,18 +782,18 @@ static int mtd_name_complete(int argc, char *const =
argv[], char last_char,
>  U_BOOT_LONGHELP(mtd,
>  	"- generic operations on memory technology devices\n\n"
>  	"mtd list\n"
> -	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
> -	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
> -	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
> -	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
> +	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [=
<size>]]\n"
> +	"mtd dump[.raw][.oob]                            <name>        [<off> [=
<size>]]\n"
> +	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [=
<size>]]\n"
> +	"mtd erase[.dontskipbad]                         <name>        [<off> [=
<size>]]\n"
>  	"\n"
>  	"Specific functions:\n"
> -	"mtd bad                               <name>\n"
> +	"mtd bad                                         <name>\n"
>  #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> -	"mtd otpread                           <name> [u|f] <off> <size>\n"
> -	"mtd otpwrite                          <name> <off> <hex string>\n"
> -	"mtd otplock                           <name> <off> <size>\n"
> -	"mtd otpinfo                           <name> [u|f]\n"
> +	"mtd otpread                                     <name> [u|f] <off> <si=
ze>\n"
> +	"mtd otpwrite                                    <name> <off> <hex stri=
ng>\n"
> +	"mtd otplock                                     <name> <off> <size>\n"
> +	"mtd otpinfo                                     <name> [u|f]\n"
>  #endif
>  	"\n"
>  	"With:\n"

I'll let the decision to other U-Boot reviewers, but I don't know if
that is relevant to align all the parameters to the longest line.

Either ways, I'm fine,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
