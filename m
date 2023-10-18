Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ABECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 23:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5396887047;
	Thu, 19 Oct 2023 01:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rRS5Hrbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AC887046; Thu, 19 Oct 2023 01:57:07 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609D18704D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 01:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so7626735276.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697673424; x=1698278224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YTWGU4VDxizOhDEp/ePRXOTZenBjUDJTMkwJGIWjXHU=;
 b=rRS5Hrbhen0iEpQl30eeUKSihT0SfiNyvpDxGeH2t+hlKSlcfEh8qKDgjA8qtWeZrL
 BjPp3lfVhxKqJd/nT4sEzuvXaekztaGIv82IZ7/Sr++yC4xG+CsRM0RUCPhrwTn8IPj5
 wJfLA8RpZ4NSNwXoiFABuQ6s4g3LFdvnBMTy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697673424; x=1698278224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTWGU4VDxizOhDEp/ePRXOTZenBjUDJTMkwJGIWjXHU=;
 b=XV6y7fNty7E+5ib/Cb9HvsepiJXnl+Fu3gd9VKLnp4OuYiddzK1UaPDhM3siAnFjB1
 IhPN7/aMtcZbv8Gev6Dogo0x0zj291HFGVFIG0D9O8v1K6Ul7PP0vW7rWBJPOCZfi7fx
 QDFfieWpK3ZvjW9rwCUgkTv9XV2NtRRJ58epDQnVFWqVZqs5Gu9Kx8byByocODIYtwVm
 Pqf0C+ylnQXBDv4t4r2WEo6Pn0KME+NNPspbFuWqARrPSfV+Du9YjB2ZQvHTwIlHZM5N
 1T+ZUuosIGyQTqkuSwWTZWQqSKADcW/FdFYF+0VWFfxa6+WDW/m5XEWmVC+0oH+ljupn
 hm0g==
X-Gm-Message-State: AOJu0YxqMumjdtocz+RIBa/RLzpKz4VBlIJuOKdIRuwYF9h6E7SjjVvk
 HA1Qi2mzkLnEm4lwjMZFhZ7WHw==
X-Google-Smtp-Source: AGHT+IGJaVzM3vkt++OgyL1TGWKabK5CZVF9Q/8t1c/SaaT1Bg4sY7F9E99KB4Do94u3YezOf44HCw==
X-Received: by 2002:a5b:182:0:b0:d7b:985b:278f with SMTP id
 r2-20020a5b0182000000b00d7b985b278fmr932564ybl.16.1697673423953; 
 Wed, 18 Oct 2023 16:57:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 n19-20020a25d613000000b00d8144f0b287sm1666634ybg.63.2023.10.18.16.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:57:03 -0700 (PDT)
Date: Wed, 18 Oct 2023 19:57:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 06/32] sifive: Drop an unnecessary #ifdef
Message-ID: <20231018235700.GU3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-7-sjg@chromium.org>
 <8ce172b2-8665-442c-8e41-6b36f1255e5b@gmx.de>
 <fc59685f-4c31-1859-73db-04fac964df4f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q3eRwJ0blWqc9whB"
Content-Disposition: inline
In-Reply-To: <fc59685f-4c31-1859-73db-04fac964df4f@gmail.com>
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


--Q3eRwJ0blWqc9whB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 01:23:13PM -0400, Sean Anderson wrote:
> On 10/18/23 09:51, Heinrich Schuchardt wrote:
> > On 10/17/23 00:27, Simon Glass wrote:
> > > This code is normally compiled for sifive, but sandbox can also compi=
le
> > > it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> > > possible to disable UNIT_TEST for sandbox.
> > >=20
> > > Drop the condition since it isn't needed.
> >=20
> > This is not what the patch does. It introduces another condition.
> >=20
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Sean Anderson <seanga2@gmail.com>
> > > ---
> > >=20
> > > Changes in v3:
> > > - Just drop the condition instead
> > >=20
> > > =A0 include/k210/pll.h | 2 +-
> > > =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/k210/pll.h b/include/k210/pll.h
> > > index fd16a89cb203..6dd60b2eb4fc 100644
> > > --- a/include/k210/pll.h
> > > +++ b/include/k210/pll.h
> > > @@ -13,7 +13,7 @@ struct k210_pll_config {
> > > =A0=A0=A0=A0=A0 u8 od;
> > > =A0 };
> > >=20
> > > -#ifdef CONFIG_UNIT_TEST
> > > +#ifdef CONFIG_SANDBOX
> >=20
> > We should be able to compile with and without unit tests on the MAIX
> > boards. Why should CONFIG_SANDBOX have any relevance here?
> >=20
> > Why don't we make k210_pll_calc_config() non-static in all cases?
>=20
> U-Boot is smaller when it is static. But the forward declaration can be m=
ade
> unconditionally, as long as it is unused.

I think part of the problem with this patch is confusing what it's
doing. The issue here is that we can (and this is good!) and do compile
drivers/clk/clk_k210.c for sandbox, so it gets coverity scans and so
forth.  However, if we build sandbox with UNIT_TEST=3Dn then we get an
undefined reference to 'nop'.  Because sandbox doesn't define nop().
This header then provides nop for sandbox.  But, we can do something
clearer, now that this is spelled out.

--=20
Tom

--Q3eRwJ0blWqc9whB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUwcMkACgkQFHw5/5Y0
tyzFpwwAtJ8PM6F3Hk6l2Uiqc/3GDyepaJZYDM+2vcd/D0qFplOLJ/wNsNHDPwiq
q6eNcCZxgdwV5l9gD1m8+irGM8U6yHtDR/wOxJHxzqqw7Bv4TK/0tolFjcDvtrTS
5nCMAoeu7jQwp2aMFPPa+mtacd1XiAxyqW6EQsAtDGES7wxAykqSnG5Iru000iy6
gdXsehB3fehOjHAgdFr+Qm2aSSsDAZ66H9Wnqs/oOCYIzbFy8189FUW0PQ4/jUtJ
ThMJs9453fWsS2AvHCyZn3FSsEvSDixu5ncqh3Bu6r+uodwf7jCVk3Oc46v8KnmA
P9gvgf1P9oiUEcwvpDWN8aBevkVP/7bOQBwP6Zr0P4G6GtVgr6GlsXFChAt3ApgX
m+6te0c7zGG2aKoytTj80YTOWacVCdmryI0Ccfid1Gy8UIdpYalUfqy0NYmRTkxh
kiiDWeFu1mo5q+QuMieoAgk4kckg6ncRvc+UlbKNSGwqXQ/6/q2PnjFU7XGrWgTi
15ytnUKy
=Yayd
-----END PGP SIGNATURE-----

--Q3eRwJ0blWqc9whB--
