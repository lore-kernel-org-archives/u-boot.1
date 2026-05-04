Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD70CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 06:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31F283FEC;
	Mon,  4 May 2026 08:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NXf/wJDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94D484255; Mon,  4 May 2026 08:34:33 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF6683EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 08:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC1061140E8; Mon,  4 May 2026 08:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777876471;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GVo57dwymXYjs/PcrghoYn8r13nz1bPvT56qGIJZ9Wo=;
 b=NXf/wJDrW66z8sVCbbn30HFedv0M0rXd87b/g5wjgxziBtvLql/Ya+TrqDCNt/v6eeu6+f
 NDxTQilf1yu+J0G4Oy6ao1YytcVqmJm/IfULxPPdP06NRM8jK4Rb8ShzIB5WBq/Cdz8v5k
 1EVXrCfVBAJyYVKLzOMg1wA11xOCD6DHuSOIL0MwjVHrd12Df3vNyvo3uPfqVkd005UJp1
 sxQt9tm4/+eMYrWyP4HeOOXFmGb2x0Qlz8zgc87HUiFygglaQXLRNo3OrzMc/Qwv0TslEE
 AKAvsBS6DUWIVG5Evi0wKchEx1RLKKX51mqFeke+0NcZngmyqqh9o6RtzKZD8Q==
Date: Mon, 4 May 2026 08:34:28 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?B?xYF1a2Fzeg==?= Majewski
 <lukma@nabladev.com>
Subject: Re: [PATCH 5/6] mccmon6: Quote recovery_status in bootcmd test
Message-ID: <20260504083428.14b3bc8d@wsk>
In-Reply-To: <20260503204936.3151124-6-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
 <20260503204936.3151124-6-sjg@chromium.org>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Sun,  3 May 2026 14:49:23 -0600
Simon Glass <sjg@chromium.org> wrote:

> The mccmon6 bootcmd starts with:
>=20
>     if test -n ${recovery_status}; then run boot_recovery; ...
>=20
> The default state is "no recovery requested", i.e. recovery_status
> unset.  The expression then expands to 'test -n' with no operand and
> relies on a U-Boot 'test' quirk that treats a missing operand as
> false to skip recovery.
>=20
> Quote the variable so an unset recovery_status expands to 'test -n ""'
> and the emptiness check is explicit.
>=20
> Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form
> of test") Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  include/configs/mccmon6.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/configs/mccmon6.h b/include/configs/mccmon6.h
> index 9f401718bfb..0cf62d6bda8 100644
> --- a/include/configs/mccmon6.h
> +++ b/include/configs/mccmon6.h
> @@ -88,7 +88,7 @@
>  		     "bootm $loadaddr};reset;" \
>  		"fi\0" \
>  	"bootcmd=3D" \
> -		"if test -n ${recovery_status}; then " \
> +		"if test -n \"${recovery_status}\"; then " \
>  		     "run boot_recovery;" \
>  		"else " \
>  		     "if test ! -n ${boot_medium}; then " \

Reviewed-by: =C5=81ukasz Majewski <lukma@nabladev.com>

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
