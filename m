Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1137C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 21:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6F087FA1;
	Tue,  7 May 2024 23:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="utvkdEya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4929687FA0; Tue,  7 May 2024 23:23:53 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 158E4883B6
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 23:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79290021fc6so287700985a.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715117030; x=1715721830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v0FQ2rwiMRNl9FOr6XgpI0Urwuon+ABghrJ58vV/LAs=;
 b=utvkdEyaqFi3z3sIZF2FEGc/Vdqp7xCk51ipiz2KY3zMgge4yOEPjGwEX/ISlXZjPD
 8JhnJGFAFsafDIyU0+WnGj1mcloa6FnXtbGXUy3PJZidssyco3ppxOgRrG7nagy9Rbag
 BfbVhXWejrMYiGSGi9sN6jS4kWl6IHcTxy+Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715117030; x=1715721830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0FQ2rwiMRNl9FOr6XgpI0Urwuon+ABghrJ58vV/LAs=;
 b=gt7vtqPt1aGiK1mFi5hXMU69wz/tsBSbgIXE2/hVPmBed8uoZ9jEytBvSkrflXWIYb
 qOZBd9sYqo+wq6gGw6Os/iLtiC8CaUXWG584LpZkzKs+1Fn8aleV5wqjAKrEKWEskMEe
 eNl2JyRcpusaML70goe1sZbAIxhPAdyc+lH1FvxiOJVgXaGkIuSWrn+opjfHcOR1Kn1o
 RDiqpDZG/iAq0XJwWeL/7poFjCueM4XDzjNq68yi34IgJcNH9bwznrrH5HVfM5I/R2gr
 1WY2HaJB0dHiKtG9dIvBtsqq5P0wRQ/JPrPrFTsnaxb/kBb0eYn//eXrKmsxi9CFequi
 uwaQ==
X-Gm-Message-State: AOJu0YyPYNujodWEczpcI9WcYRho93opBu/3IXrcGnRZFARAbuAJEH4C
 snDw1bh0tEeMWZ34gq9gT75ZynlT7OotLtndRnvvZY9wVVVzSshE2SJ4U/b1/34=
X-Google-Smtp-Source: AGHT+IHR2Hj4DMRjJNhPx3y38s08/SZimrAMjzk1XFAHr6NFFf4i9eZCI2yOpj96FSXr1gx4HWansg==
X-Received: by 2002:a05:620a:254a:b0:792:9313:a65e with SMTP id
 af79cd13be357-792b27fcfa1mr106895785a.46.1715117029910; 
 Tue, 07 May 2024 14:23:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a05620a109800b007929d1570fdsm2018501qkk.97.2024.05.07.14.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:23:49 -0700 (PDT)
Date: Tue, 7 May 2024 15:23:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 01/28] CI: Exclude MbedTLS subtree for CONFIG checks
Message-ID: <20240507212344.GZ2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gOQFnUvk56h6jxjX"
Content-Disposition: inline
In-Reply-To: <20240507175132.1456512-2-raymond.mao@linaro.org>
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


--gOQFnUvk56h6jxjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:50:43AM -0700, Raymond Mao wrote:

> Since MbedTLS is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gOQFnUvk56h6jxjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6m+AACgkQFHw5/5Y0
tywtTQwAiB4qLkj9D1oNFM7IhBfpJNpLh0pdrtYm56R2OyPpkYiHjln+lcJxKf4v
NOIANaesLWgYbcf9I/FH/Y4Xb6nbPntHoYaggxTbNqzSvZ3oGCg9RE/3Z5IVaLK7
CZPTWr+d70GvsJ1QLC4CMO24EgxUYzOCpVtOQ6irGELUFczvk1fuExuXDBrXj96U
HHLxi63HSar7QXMk1jSPegW89ub7Ek8T8Q9lvBCmjsrBAJNcLDutkhLVu21pserD
iHHC3C9TuKcFlnZGLRgK1rEMiz3pLizgp9ziWKrLB9DSieQiuIGcox/HpMJqcOV9
9DGnRmjFBb8OAK2CjFl4nGI63uuQivJmvz0KKV1WUwlnlzGepMKLWK0kkH1NjXo2
VtC+e6lgRsPRBlikEKgoFjiHEPqHBk2/gulwo/ivhPA3L8RNLtZHqxn+0dh0Jzfb
lfJQ2hgJNuHbwVQdB/BFo8dVJN0A0S8BMHIAUabCwdRtkWdNoXE4MCsvX2XMBu7+
9+eyCNw6
=tTfV
-----END PGP SIGNATURE-----

--gOQFnUvk56h6jxjX--
