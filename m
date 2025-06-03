Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DCFC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C5582A76;
	Tue,  3 Jun 2025 17:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oKZVrhXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7D1828BC; Tue,  3 Jun 2025 17:47:56 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF0482AAF
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso1926268fac.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748965672; x=1749570472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yivoI+IMcT4oYe/RiNrB9Yjs804Uzz0Y27arrMQUZNQ=;
 b=oKZVrhXtVZiOlqWdX8/3Pn30O4jRFionSPVy6GJqn7Eq0qRTUbPi+qzFnTCCmNjsJe
 zzMeE/nC2CplQ6WCVIDuGe38qpehnyfdUsDhhf8pAVCGqaGP5TZEWx9Mof1ZbLxjWL4u
 5vg3FlgxeTIUXuX1eqlyBynB6zf7lwg7t2E+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748965672; x=1749570472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yivoI+IMcT4oYe/RiNrB9Yjs804Uzz0Y27arrMQUZNQ=;
 b=ewMLYsbg2qhDMiA+sEiB981LfXRzLXO0wUz1WFUmrjOXIlpesWLtA5lQV3AeTKLU+l
 JNTqJd6BQkDM5zwSo7z6vKiGHbx4JZDUSyvodze9EWjo2F/FsXukZ4aiZYqdOne+8kdt
 253GsSHExZP3Gu2SaJNGI9FgPNNaMTtH9AzTtalX3nNShxl7dL7O7afhhYRnb2/HbBlU
 S4uMbdKD+61Mb5NnF/SX6xk1CpZI7tXmciydQk6FYPwh9h4kATyHZedPkiI3Pte6nYoo
 Qjz6D9uyfrCvXXxpJWwOwRIEQDwa0I6dj/yzWmRluaqr55h9lWWX2Y1YKB1EWgAZbX3e
 u13Q==
X-Gm-Message-State: AOJu0Yzac5zwVswVKf8jjymSRRYT814sMWD0yb6uwxslLZporB8+/iZf
 8Qyat4xDRiK1xj95Yb0/zHUcLe4/qqz2dKVFLtFbyrCOQzV3LM7XzZJROzStS+PF2ZA=
X-Gm-Gg: ASbGncuVan21qVl6PcVHFh+Q3xeBiT31fVgnr9vfAjLjcUenxvybKlebXRlf5JKn6m8
 DbmR3z1NWrWJg3exWyV8vDTkHJXbBk3BtQuQPrFr0i+JwHVVSga0RZYBZbbYwkGd/fI6GqzTHIi
 C+qswDDcc8MjzB/i/CD8ZoZPZ2tj9uIH1splt+gVb/fWQOWZuhrn0meWPXlZCLg8+FTgU+gm7xy
 dz7zUQCpcKs0E375X3U9SIo2h0OdlOKC6EYL/KAq9oUJlkF9deMqwQ077fDdb39n+Tcz+95TqoH
 ccb9V7EyQbM/KmbMBqL5gXR6FVQvls7DTBdI8FeArMW3MnDlrIG7dWOqU642HnMRuJjFkkLIClM
 mXJy1ZPMjpgDI
X-Google-Smtp-Source: AGHT+IHoVIaqpYArXOYhf9zM05W3CM/Hiy7CqAtHyurlaxRS0qPVmxOmJDY11DVOuccS9rDsE9d1mg==
X-Received: by 2002:a05:6871:6b08:b0:2d6:6639:52d9 with SMTP id
 586e51a60fabf-2e92a487d3bmr11658161fac.32.1748965671948; 
 Tue, 03 Jun 2025 08:47:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906c0a87asm2290039fac.42.2025.06.03.08.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:47:51 -0700 (PDT)
Date: Tue, 3 Jun 2025 09:47:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
Message-ID: <20250603154748.GG1382132@bill-the-cat>
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qX38x6OjcmIMlVpy"
Content-Disposition: inline
In-Reply-To: <20250603151401.1709532-1-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--qX38x6OjcmIMlVpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:

> This patch is to solve the sandbox building error:
> $ make O=3Dbuild-sandbox -s sandbox_defconfig
> $ make O=3Dbuild-sandbox -s -j2
> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to=
 symbol 'pthread_kill@@GLIBC_2.2.5'
> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols:=
 DSO missing from command line
> collect2: error: ld returned 1 exit status
> [...]
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  arch/sandbox/config.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK, but how do you get this failure to start with? What host?

--=20
Tom

--qX38x6OjcmIMlVpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/GSAACgkQFHw5/5Y0
tyzjQAwAplVs0/Xuqs9wzo9b9rzZ56bSX5DtugF7p4CFiaTZZzq90mBljVqAK7AZ
zQt4PDZY5RcsTUR1YAF+WdrXFoQ8SO8lPX8LuRkOr3u0Cy9Bh/fqpEXBtcM8WWeM
QtmrbXF4Rs+xmqe5w6lBrf1z/heyoYNhCsIltGynF+sHP7u7aXboU4T7jR0B+B1a
AH4abzk9gMJCCbTkP8E1uB8UAyk3yEkmtlIdUinilEf0gTDSsf2jNeGq0tFB9b89
ujyqv+AEe4u8RmArTz7ku14pnqHVFmelGz2+QIqZnlqmoA5szYS4dCAoizxLzoFn
0hm7MDTqYhe3DErPHjEVumsvx9y4tYRy2O0KjRST6/1qqwpPIeFAyvILLd8BPg4U
LCzm8DjOVPoUlAfipUFUm8hJtdmtt2VIFGsSTKuXCCyHAoaDrRjAipL8dZwPqlr/
pmbEowYRTxHt1CXDl7Lss53h78yFisZ8jE9nU70ASArH6Xlxb6ylN5MXOx6k4qC3
jk5djWHV
=19JJ
-----END PGP SIGNATURE-----

--qX38x6OjcmIMlVpy--
