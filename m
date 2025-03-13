Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC57C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD41E80FF7;
	Thu, 13 Mar 2025 17:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eo2xfH9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D315480540; Thu, 13 Mar 2025 17:02:57 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4437D81895
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c07cd527e4so92050185a.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741881774; x=1742486574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=64sVZoDgdcq9RUx7C74r07BakAIgFtTRM7xafOFtVs0=;
 b=eo2xfH9qVieX715GODXOu5prvgW616POCKVsJ+b5JXYgOouWAfl9Tn2DYEAk/ECfkD
 QcCv8X1WbLywEBqHKETUOqM430irE7zvFv/311Y8OvZ3jpLHULskizMW+SxEumWWdMlA
 WtaRNDgmD6V+pAWGwHPDnWmcSYFHARon4UF6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741881774; x=1742486574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64sVZoDgdcq9RUx7C74r07BakAIgFtTRM7xafOFtVs0=;
 b=m+XMQxHbnIwCcns2JhIg+sI/6O69+kbM0gDQcvM/qfnNHBSR/zKjDiRA13MQPjaM0U
 KiA6Uxsh2rttmgs9gqmBS/RrXrhE0/MHJnf4JGC5q9mEF1ZffT+y+Hz9zv34OZLtQcUn
 FGcWDZ8Nm2Fz+tD9ZCoH44hA5n8bPyVjf62TyhicKgcMo9gGNVlms4QAakwTLncQM8PS
 42zMRQKeZBo8Wl7fg4gAPie5Om5P/alXInRqnkdKWidIpvR5TqzKCVDnds+09uglRAgM
 evxGlhzVi03XrtOSaGR9l+oI0GMkVHlxtzhW0kGZx4hMSlHPBjY5tq3GOw5OM+9h/+F8
 +XdQ==
X-Gm-Message-State: AOJu0YxbRDrzxPx1Ik7Sr2rgUjUwa17FxAV7NAqdboEhWgzXaVeLnBDc
 BI0BVplAUyxzuKKss4H1I6hy80wGp2C5JYoe0mvJ06ZVdKhbFAlyD3Sx//84+u+quTXFHeeYHxj
 v
X-Gm-Gg: ASbGnctgg2SvSQuaNT3ac7dhe6L6AworIQc60WajCBmCqIxgDr3ZljUPMfcoifcJuH6
 GN+klh3q8fuut1iI1rcrSDNcFVzxv78ugwM2q1+B4Z7ENS2fPsmNAl8EhY7L/P6W2fUYB65kDqx
 0SabYKB6zuZGLX7KzUo7ZBiA1t9dl5vBlhGPCgP79y35hVWroaj/YLBazeBr9rsiFi0IhAiR7+y
 sEaqasdMBZzItg6heZWGulrH4uO85uYYnYWREFlc4i89xkKzKbviaDutDHxE2Kcy7aWB24QqDOM
 y6Zh3JEBE6Oa1Jvs4RUBIEfUmgt/mfpml/ykctYXAcGLGg==
X-Google-Smtp-Source: AGHT+IFCPRPiogo1cK/hUDiccuhTkeK98YzpyTZa/rl3+pIp0z3s8sM/47s6tnw8P1gV43KYRj9WNA==
X-Received: by 2002:a05:620a:688f:b0:7c3:bc90:a46b with SMTP id
 af79cd13be357-7c55e83ce1cmr2012294585a.1.1741881773898; 
 Thu, 13 Mar 2025 09:02:53 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c7e406sm114258085a.46.2025.03.13.09.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:02:53 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:02:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] doc/develop/codingstyle.rst: Add a section on
 conditional compilation
Message-ID: <20250313160250.GB2640854@bill-the-cat>
References: <20250312010021.1671010-1-trini@konsulko.com>
 <20250312010021.1671010-2-trini@konsulko.com>
 <07042041-5793-478a-b66e-112d89c00688@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IaVoQ1cxhVCAv1yJ"
Content-Disposition: inline
In-Reply-To: <07042041-5793-478a-b66e-112d89c00688@cherry.de>
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


--IaVoQ1cxhVCAv1yJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:15:35AM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 3/12/25 2:00 AM, Tom Rini wrote:
> > In order to make a start on explaining how and when to use certain
> > macros, we need to document their usage somewhere. As a first step, take
> > section 21 of the v6.13 Linux Kernel coding-style document on
> > conditional compilation and add it here.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >   doc/develop/codingstyle.rst | 48 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 48 insertions(+)
> >=20
> > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> > index fa3cd6aec82e..7211e4e4eed1 100644
> > --- a/doc/develop/codingstyle.rst
> > +++ b/doc/develop/codingstyle.rst
> > @@ -154,6 +154,54 @@ See `here
> >   <https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#fun=
ction-documentation>`_
> >   for style.
> > +Conditional Compilation
> > +-----------------------
> > +
> > +Wherever possible, don't use preprocessor conditionals (#if, #ifdef) i=
n .c
> > +files; doing so makes code harder to read and logic harder to follow. =
 Instead,
> > +use such conditionals in a header file defining functions for use in t=
hose .c
> > +files, providing no-op stub versions in the #else case, and then call =
those
> > +functions unconditionally from .c files.  The compiler will avoid gene=
rating
> > +any code for the stub calls, producing identical results, but the logi=
c will
> > +remain easy to follow.
> > +
> > +Prefer to compile out entire functions, rather than portions of functi=
ons or
> > +portions of expressions.  Rather than putting an ifdef in an expressio=
n, factor
> > +out part or all of the expression into a separate helper function and =
apply the
> > +conditional to that function.
> > +
> > +If you have a function or variable which may potentially go unused in a
> > +particular configuration, and the compiler would warn about its defini=
tion
> > +going unused, mark the definition as __maybe_unused rather than wrappi=
ng it in
> > +a preprocessor conditional.  (However, if a function or variable *alwa=
ys* goes
> > +unused, delete it.)
> > +
> > +Within code, where possible, use the IS_ENABLED macro to convert a Kco=
nfig
> > +symbol into a C boolean expression, and use it in a normal C condition=
al:
> > +
> > +.. code-block:: c
> > +
> > +	if (IS_ENABLED(CONFIG_SOMETHING)) {
> > +		...
> > +	}
> > +
>=20
> We should mentiond CONFIG_IS_ENABLED here too, as this is probably what m=
ost
> people should be using in driver code?
>=20
> > +The compiler will constant-fold the conditional away, and include or e=
xclude
> > +the block of code just as with an #ifdef, so this will not add any run=
time
> > +overhead.  However, this approach still allows the C compiler to see t=
he code
> > +inside the block, and check it for correctness (syntax, types, symbol
> > +references, etc).  Thus, you still have to use an #ifdef if the code i=
nside the
> > +block references symbols that will not exist if the condition is not m=
et.
> > +
>=20
> And I think this is a perfect example why we should follow the
> aforementioned best practice as this would not happen had we had a stub
> version of the function instead of the function just not existing? It'd be
> nice to give that as an example in the docs. Follow-up question: is there=
 a
> reason for NOT wanting to do that?
>=20
> > +At the end of any non-trivial #if or #ifdef block (more than a few lin=
es),
> > +place a comment after the #endif on the same line, noting the conditio=
nal
> > +expression used.  For instance:
> > +
> > +.. code-block:: c
> > +
> > +	#ifdef CONFIG_SOMETHING
> > +	...
> > +	#endif /* CONFIG_SOMETHING */
> > +
>=20
> Applicable to the whole patch, maybe highlight non-English words with dou=
ble
> tick quotes?
>=20
> e.g. ``#if``, ``#ifdef``, ``.c``, ``#else``, ``__maybe_unused``,
> ``IS_ENABLED``, etc...
>=20
> Looks good to me otherwise, nice addition!

I'll reword the commit message to be clearer that this is just literally
copy / pasting the kernel section as a starting point.

--=20
Tom

--IaVoQ1cxhVCAv1yJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTAaoACgkQFHw5/5Y0
tyzpwgv+PSfKj2/JZRmZc7FSLLj1e3q4wSCRtLjcLiMLBfq/fThk6MahsxXaRwgt
eCshm0yF/AY8VC2SPXABHK+HFAr+DILpXbO7hS/NVQVJDWKBkP2CjV/FlL9HvhXk
qza7gm3/3tkudJLvi93A366juIO5cqZiWiMYENgW3VOvU10XPrxr/GZZryUfNN1x
cS+S6nL81Jnrh0+OeFOTdZLRBxOdkeiHcid+SWRfNJOCqWaoly2Nk5mTua8vaKaK
+NgCq5pD6a8gQ4eD/gNpIIxBNprUpg0M0Bh6KTCb5vWCnDYnuEznc49V8JTlnlbu
AGbms1UMjMD6M33msoQBX3SdHhe88h+c+Szj1wqBWf5rnsD7RbJCPSP7HLYG4U2y
3oDJMiJNZS58oX5mzvxyDO6QGB0RwaHozyvfHrkAmGc3eA/Vh3WkyCEBVnRBxzUU
OAR+v7prHN8zSe3lIUOR3Vj1OTH8g59TP4HpkPDbd8O4hKBvh5Hcx8Q8a0KcxAGW
rNo5ysRS
=jFNt
-----END PGP SIGNATURE-----

--IaVoQ1cxhVCAv1yJ--
