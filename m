Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23559C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DEB87622;
	Fri, 27 Oct 2023 02:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TmejVq2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F7087623; Fri, 27 Oct 2023 02:59:12 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DA88761C
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bcef66f9caso267192b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698368347; x=1698973147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHjyKoWII182CRgQxnC9TMng9D1JS+XLJ5ne4rcwtsk=;
 b=TmejVq2h0OvZtj8Ues8fYZWU40/pPA5kKZkkF+ixEhFLEJkQ497HMbkK5itfGYQ2nW
 Kv9BcB2aKkj+tAuuvZ2T902i15IdMJQvUR/gMz9Oz7MZnLbHAdDnsud9BolzylHXaRj7
 zjMyPFfo4jxRDiK1+E2oZMr0M3e3qaEogWBSwFZBtzXlWOeOmivc8uBhUdw15IGqMWse
 0Q7NmlsbQ+KxA6yiirazaoSlI8npR8gTZAfO6OkykNGGDhswmO49FeA+sFQTjb1kErLg
 YYguUvG5oz9tokdg+6+Z8AY8SwOSll3joh9YbbDw844icwQRBaX7UnC0xKVLjRwWLJJL
 9m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698368347; x=1698973147;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHjyKoWII182CRgQxnC9TMng9D1JS+XLJ5ne4rcwtsk=;
 b=sd7zvezlusNLg5Z89RZvYY6lOhIAkYT8b+lh7aAqC2rBNsCGYjFDH91LwvMdkJBucO
 fHnuCU4BPG/I+rJYz3YBdw7gmSOyp2iKEnJaLNBPKcQ6Y4+9NalpK+dT0tP9vwNT3FIC
 rU5+RXj7viAvo/No1/oC7s/vbVE/OBjFDwwYiP8CRbpNE+EpB0TBvT8RZ1VZwmguuuQT
 bBfa95BW5iJWIhtAXODhf3DNvvIJY5DAEGX6UsBtS/Fb9jSBOwnZjDQWj/a5O1HWYNm3
 t52XZU4RLIehlBry0oT6NlhFOyCW6qzX7VfJnTGdyxo0JXlwEcHU8A52WnVBQZ9KhpAq
 o82g==
X-Gm-Message-State: AOJu0YxjuIf8NClxY6LwD4vnb6CwPsfhx1wZJfN+fwIZ08EAaNKg0kF4
 r8abO44BnM52JfuAWfIdcJkkMw==
X-Google-Smtp-Source: AGHT+IGI5YPjrIzIX8cvy3wDPAmMRS7jBhpPu0OMHy0QmsLPDoQdUObxnFbyaPAdR64NiPpIC+GroA==
X-Received: by 2002:a05:6a20:7f93:b0:159:f5fb:bf74 with SMTP id
 d19-20020a056a207f9300b00159f5fbbf74mr1643585pzj.3.1698368346855; 
 Thu, 26 Oct 2023 17:59:06 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:6429:7b83:d86b:e393])
 by smtp.gmail.com with ESMTPSA id
 f30-20020a056a000b1e00b006926a2c9eb7sm201581pfu.119.2023.10.26.17.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:59:06 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:59:02 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, sjg@chromium.org,
 ilias.apalodimas@linaro.org, jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 11/13] fs: remove explicit efi configuration dependency
Message-ID: <ZTsLVnXoP5SBvFlz@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, sjg@chromium.org,
 ilias.apalodimas@linaro.org, jbx6244@gmail.com,
 u-boot@lists.denx.de
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-12-takahiro.akashi@linaro.org>
 <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
 <ZTon3nThWP/XmkGd@octopus> <20231026124752.GF496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KW8RxXpzRbUou5HA"
Content-Disposition: inline
In-Reply-To: <20231026124752.GF496310@bill-the-cat>
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


--KW8RxXpzRbUou5HA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 08:47:52AM -0400, Tom Rini wrote:
> On Thu, Oct 26, 2023 at 05:48:30PM +0900, AKASHI Takahiro wrote:
> > On Thu, Oct 26, 2023 at 09:58:53AM +0200, Heinrich Schuchardt wrote:
> > >=20
> > >=20
> > > Am 26. Oktober 2023 07:30:50 MESZ schrieb AKASHI Takahiro <takahiro.a=
kashi@linaro.org>:
> > > >Now it is clear that the feature actually depends on efi interfaces,
> > > >not "bootefi" command. efi_set_bootdev() will automatically be nulli=
fied
> > > >if necessary efi component is disabled.
> > > >
> > > >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >---
> > > > fs/fs.c | 7 +++----
> > > > 1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > >diff --git a/fs/fs.c b/fs/fs.c
> > > >index 4cb4310c9cc2..70cdb594c4c8 100644
> > > >--- a/fs/fs.c
> > > >+++ b/fs/fs.c
> > > >@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[],
> > > > 		return 1;
> > > > 	}
> > > >=20
> > > >-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > > >-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > > >-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> > > >-				len_read);
> > > >+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > >=20
> > > This function should not exist for CONFIG_EFI_LOADER=3Dn. There are o=
ther places where the function is invoked. Please, review all of them.
> >=20
> > Please go through the whole patch set, especially patch#8
> > "efi_loader: split unrelated code from efi_bootmgr.c".
> >=20
> > efi_[set|clear]_bootdev() will be nullified if not necessary.
>=20
> In this case I think what we have here today is more readable / clearer.
> We don't need empty functions as we can either do like this section of
> the code does today or the linker will discard things correctly as it's
> a case of funcB() calls funcA() and nothing calls funcB() so it will be
> discarded. I don't know without digging through the series more what the
> correct IS_ENABLED() guard should be here (and then also in patch #10).

If I correctly understand your question, it is my point in this commit.

I believe that a caller should not be bothered by thinking of what efi CONF=
IG
be used for the guard. All that should be done is to just put a right hook
(efi_set_bootdev() in this case) at a right place as a caller (do_load()
in this case) is apparently irrelevant to UEFI subsystem.
Hereafter, whatever rework may be done on UEFI side (like my refactoring
here), other code won't need to be modified.

If you want to rely on an intelligent linker behavior, I would suggest
another approach, modifying efi_set_bootdev() as follows;

efi_set_bootdev(...)
{
    if (!IS_ENABLED(EFI_BINARY_EXEC))
        return;
    ...
}

I hope it would also work.

-Takahiro Akashi

>=20
> --=20
> Tom



--KW8RxXpzRbUou5HA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmU7C1EACgkQJ6vpGq1m
yG1JBgf+JaSsA8py6s+tpRTSH/Jx/ve4yeYpM/iQwlltGEHs66cUik+NvPhEWnYv
IAr0wnSW6CQUrmCTgI5pq/Tcg7rfx85kt0tQ2axH9SGrsLW5BUe4qPJ+2GWFSW1L
i1/WmkCMVQCXab2p1GGX43KJ6S9i2B/Ci+pWqioK+DoPT+fHHIdcINxviw2q77yM
4yxVvYlcjXpMML2dcXTK1PiDeejzbY7T2KGdv3xPujdOQ+3PQP9WAif39UpC/0j5
Pggd/QOQslSUfpON34UZtA4Q1mb6IzweIGoA7lenpg/A/WaGRhSmE2gEy6TuyLCu
VMhW4lgUOYuHdHp4RqTeEED4ak/hzQ==
=y519
-----END PGP SIGNATURE-----

--KW8RxXpzRbUou5HA--
