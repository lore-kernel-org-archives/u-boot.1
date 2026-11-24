Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BD606A33E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cWRCSAfT;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sb7S/MQN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 881BB607CF;
	Tue, 24 Nov 2026 18:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYjBD_-aoITc; Tue, 24 Nov 2026 18:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D756060744
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795544528;
	b=i/tf7IiWN2h/wsinJ6Vb6JbRoO80OTaRwc4QDM1tlJyKqPIjsvFJ56O3HBBaJeM8ani7
	 2m7qlkiMEiwMfuD0VmAfqTQZOp+znQzy4yseyOWqcrYeUy7cxXOMm+KCXlJ2ici40CEOu
	 9Ozi2RxPKkVO8LZ0GbZlV0LaG+swn3+1T/JtKectbhG481E0W6eb3GzpW/8sk5CP3DJE1
	 3vI5e8KBjsNdMPXS2FIglZrqAohjPIFiiF7MhAiabM+f2jMzOgoVIYFI3fidSXnpH0zvO
	 ZEkrj4yq3ZiTTheLtuOEOGvnZ0G2NFiY233m01PjYewQEegTnLFpFr3paS/00sEyiMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795544528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e/XACVgSjmGkEx2GQ60QYJfUU1IP65d7UhRlkMnUBo4=;
	b=cdwxMb38HtoWeoeb03CckBkOnSeeyR3D1e8j1OlRYmP6xbe1SYAVtT29aqAIF9R/Ro9T
	 Yl9qsLeOD8PaGnrCbp4+vPn7NAOpM71pFKQ6HjfOocmlq36OU144/bHBu+x+V/dtgYVKp
	 NiaaLZPgnInGzv4hVpkiVw5QR9jcQf6kn3kK15XDRdWYYW3WLtzO7c/pNc/Z5aZjMJsCO
	 wBuE3S1U1JAbK6YVcvUHAYFZMM3Dv9VFTadGcX1Luf5uFZabpnu8w22x2W8B7yvzHUGPE
	 qcudOrdtrcf4xB88qceheHRAZHRJ7Rc3Pf+eqWUL5ZMpJn/nJ9XmseesFe/nb8Xw3Kw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="sb7S/MQN";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795544528;
	bh=e/XACVgSjmGkEx2GQ60QYJfUU1IP65d7UhRlkMnUBo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWRCSAfTp6mm7K2Gfc/f8K6ifofC05naSIvk+y0CAIXCiJwPJnfeVylxiF+TlYNbm
	 VKRQc1VKZi0e7abc+BvWydG5zolS+F4qJsVMJ+NLsVlg7qADyKSnBB4+03uBZwnnHl
	 b7RzJdoulHdLcd9ioHgPdKqVMF3vMjf8oLMwj1KqDoP6hspnpZ/mn+dYBLqzUci9HS
	 aSukO0TNZwoI20cdfEqyiZEk6bxa6d7XFQjZwvqaEZsoHIzQak+i4NDESSk6wK0Tc3
	 k2htVZc08g2emt55sknee0wswUJQiM9oCmI176NYtMfuqQmD/OBDUwHMRFBTTGZa1P
	 gYxHbahSHoLxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D756060744;
	Tue, 24 Nov 2026 18:22:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CBD310B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E611F60744
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFgdtKwzFGzi for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:22:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FF8A60675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sb7S/MQN
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FF8A60675
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:22:05 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6d68de53053so3705605eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795544524; x=1796149324;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e/XACVgSjmGkEx2GQ60QYJfUU1IP65d7UhRlkMnUBo4=;
 b=sb7S/MQNzpGqLSsHoVbWC0t8vP5G1P3xbDMM5kG6lrkR8jRrBAeYTps4gFUxYHaj+1
 a4ccmiHtS1NCgG0g3k19xd5zxHiTyxVXO+6N/iMbAlf9sB+qPQqlGbXM1J8OtY6soqnC
 KgDed2Jy/qtUA7Hs20YZnBaB62I26Q6tEWBQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544524; x=1796149324;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/XACVgSjmGkEx2GQ60QYJfUU1IP65d7UhRlkMnUBo4=;
 b=2BxUsbHq2Rl+lse+1srq66ZpE/JzrJVys4aWbMGyA9hsUJsAgMZfn19i5muadN8i41
 xGsEozsLLumuOxuywpS0FBPHl/v6N4cmWE9ZeVsOYBzX6GC+M5TUXA5aqoumgmDXEm0C
 NpRwC607mDjXqPYykdkKN4WB3vg4IAnXpP/xyZ4SVSjQ4OtledhNy+IpgL0CmtMssT62
 2EG484KDDYdVKuBcNh7tNPu6ESpx4dP0Z6wvRRmw4Yn/Dm6C4QFT+v61V4vofTaq0zZb
 Jhyi9dda1ZlrXCohyucH7niFnZkXEm4hu2U/FLqzBOzwUSfNabiJVI3ZnYdNnyt3yBcu
 iWdw==
X-Gm-Message-State: APuU4Z+hv1Wi5d6Lmj4AtjvP/jJQGlgvgjVIBhQ3BmDHWoCYaDtHKxXs
 BXe5Li8XOLaly4J8xqUcuXp4TgzMuqfPIfMiUqu0yI8wo0nO8GP90BgQ0P2gsZfp0vps7yGDdIJ
 8JkSYOIqbG/7f
X-Gm-Gg: AZFdTZcWqFN5CO/3wXdF0to8iUaDA+9IvmRgV1WUCyG+nkUV1IxmnZ2JsC7LybtWnSw
 gBunqG1zhV0+XTZzv5rVUo9r0tTo6mgZwhFHLJyLoS5xKeSwx08VSW04/5Llq6BfRY7zd+ABIc/
 /APtdtMjki7/qpRWyU29bQiqkUnKsNIkB6VsN7dp/w7nUuTpHGrL7btLqcawgJ3bLSlO/VpsLQY
 yVIYxPZ6tfdc2OTi60veA6LwKIfiqmiwekBehgletp5udAQ5b+czKXpBxsbc7woKHeN7hMlzdQH
 ImjVRIAkJ79FWNO78uOa51W9u92jvwxUlPtvV0znFkciU7iR/4MScuHgnLDoGpLoeOtyMwco5ep
 53E9+wCIEx+NjBWgT1j5a4VaFthtxbhUM5ZjJrdNz08hAFO2SUXVE60pK9KUg7UhIydT0f2+1QX
 7u5XCB8tyNeeWu+WE8V5c0InxF5ZqOXrh4/hqQE9WsHs1cLpJAT5SRAgdQmbozLIGRviSoXkV+B
 UMBem0Skz39uw7Tf7BZ6BzS8KO9Tf67g2dHnTGLPRouTh693aNGYv08HVHjmKwXyRBWgLapgyFe
 J9moeUkqndebMI9BwC43DMhkloYMavzHci5fxJV/T3ERLt+3MQy4uKFr0mwEG9L2xO3Sf/pFLNp
 fJBUhf/gbREbumjJ+KVwtTa5cjOiNQKlKgmernA3doTsNVTssrGmS+H8N3kc0R6rzGfZQGiDc1o
 jvPY1v3tzeZ90ThnONRa6B1W9Ib4ak4FLf
X-Received: by 2002:a05:6820:4a8d:b0:71a:e7ba:ba09 with SMTP id
 006d021491bc7-71b3942fb96mr9816168eaf.30.1795544524352; 
 Tue, 24 Nov 2026 10:22:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6d33sm11101590a34.18.2026.11.24.10.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:22:03 -0800 (PST)
Date: Tue, 24 Nov 2026 12:22:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm64: renesas: Reduce size on Renesas R-Car Gen3
 Salvator-X(S) again
Message-ID: <20261124182201.GU3176972@bill-the-cat>
References: <20261124142648.947401-1-trini@konsulko.com>
 <3dc6575e-792a-4e51-83fa-fcb64ff880c5@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kYRhxGKH+NJuGKtC"
Content-Disposition: inline
In-Reply-To: <3dc6575e-792a-4e51-83fa-fcb64ff880c5@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--kYRhxGKH+NJuGKtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 03:51:32PM +0100, Marek Vasut wrote:
> On 11/24/26 3:26 PM, Tom Rini wrote:
> > To save even more space, as it is an issue again, disable the expanded
> > help text for commands.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >   configs/rcar3_salvator-x_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvato=
r-x_defconfig
> > index 50bfa1853241..3a51886fcf2b 100644
> > --- a/configs/rcar3_salvator-x_defconfig
> > +++ b/configs/rcar3_salvator-x_defconfig
> > @@ -31,6 +31,7 @@ CONFIG_BOOTCOMMAND=3D"setexpr dloadaddr ${loadaddr} +=
 0x200000 && setexpr dloadadd
> >   CONFIG_DEFAULT_FDT_FILE=3D"r8a77951-salvator-x.dtb"
> >   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> >   CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=3D10
> > +# CONFIG_SYS_LONGHELP is not set
> >   CONFIG_CMD_DFU=3Dy
> >   CONFIG_CMD_MMC=3Dy
> >   CONFIG_CMD_PCI=3Dy
>=20
> Where did this show up ?

When merging the rc3 tag in to the next branch.

> I don't want to disable longhelp, that is a really bad user-facing change.

I disagree. I'm not sure there's a case where users are relying on
longhelp and don't have access to the internet to verify syntax of
something. Your DFU patch also resolves the issue, so I'm happy to
reject my patch.

--=20
Tom

--kYRhxGKH+NJuGKtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXVxgAKCRAr4qD1Cr/k
CtDuAQDdYaJGl0l0Nc9J3CORqauhZFSApYVmHOLqBJtCvz0MYgD/dA2mcGAnWn9I
eJRfN0Ie2bEWPYD1iAtv0oB+BRTXpQQ=
=YFoz
-----END PGP SIGNATURE-----

--kYRhxGKH+NJuGKtC--
