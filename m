Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FBC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56E687C7D;
	Tue,  6 Feb 2024 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QFczuriD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EDD587BB5; Tue,  6 Feb 2024 14:00:50 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B97C87C7D
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 14:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783def87c8cso324392085a.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707224445; x=1707829245; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wR2EZlYHyUX/Zh+O4Z5Bqkv8bzyb87ssUbYpNEM4pcE=;
 b=QFczuriDWsCEykAXiH8OzYt4l1ozyL2/oOy/+TWwKGRbmfT3o2u+MBD/VgAU7YOL0i
 jGDVgXvlNA7y8TDqB3Drz2qbVWq9YMrr1dOLzPermqPNEamEmnZMtogAhyyNqATLcYFQ
 NgW9lKQwNHQkRg2kLnSSHWql4vdfv2avHMD7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707224445; x=1707829245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wR2EZlYHyUX/Zh+O4Z5Bqkv8bzyb87ssUbYpNEM4pcE=;
 b=jWtb3OfJAmijDBgpxF9MdS+l/cEM8FOAc4VFChRCsx/eIAOcn3x23OKZ0Ho9umiR7+
 NS2TtFkEOoWTJrT5GzR9F21YnySRMPxS4w9hzwXV35Wi4YYVNjnlPK6Y9C4jBC12PF3b
 /siDm3VyJhQ8SxmtAP7ahle5h512dQdhO3uCqkAOdQyhSZDi6nBhLKGYFAleyn6zYr8m
 he2FfGYBs7JvGsESA5Ae2E+1EI8m/hr0KZDLlD1YmvljVAqvWAY08oA9/4+veK2JjmOo
 PPXKY9j+CCUl+E9m7hPobnTJCvihg7U5jLl4YKgBCUantu+tOvJukXZc2+91iXZldByW
 SsmA==
X-Gm-Message-State: AOJu0YwNcp8wu3zCUbNagPE/CJXmjJKB8mKy5Nqpke2bFIf9OBNywRP0
 RCk5341EiKH6SOjYzBCMyRjNmw3wBBu1E3DbCopV9SpcP4ZNx9s3kyHDGQs1hwY=
X-Google-Smtp-Source: AGHT+IGI3ztPMgM1i4Y1KQgt19deWmdmHTt35W5tpGF+QpDZsQY2xY2OxAdea0LakVMoRyz77FJWaA==
X-Received: by 2002:a05:620a:16c1:b0:785:9690:91c with SMTP id
 a1-20020a05620a16c100b007859690091cmr6969qkn.41.1707224444948; 
 Tue, 06 Feb 2024 05:00:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVEDGBBvjiZMcwMafYa1HDx/cC9CR/oV2wvHFxypLo2l5puL15DKd7fXzGMvL4rGaceA/PtLXxy7uMCpzUFQIihysl/eVdo2od0nZ+IVjJf8F5zGzoc2EdnV8GxoCzfg8PpoBHJDziW2x8igG3FC0tPswF0mKakoxPsR29VQZ8Hi/L0ERbzgzefXIlS9kBL6fsuIm8ziC2gDX+VsR2r2a4TAWgx1nOBMdIOxQl5y3LS0rEZvuBayKHKm1ewmIj2Ezzfaw6AIFplmuP/+6As7vgYLQO1NPQ8taMFbBU+UFz1QYL0n8+Dx9Z+UKIDOWcCe+L310xHVkshmiwel2DSWZ8su415DD2zSluVFcWEFHByrepHfeu+6qDT0B9I1d8VotZlOgVACRERu8+InD/4CBNuXIib9CD9KXa9LhQ5NSdR/dhiz0epC4PAc6Uq6t2XK6+BjbbBtyKyBW6G1FYzDlTOK7ekoTWnu3Q5oK7Gu7QY+I0JiktV4tNF7iq8gVRQlX0ARM+fwVeyzcjaWTLMv5y3WH4h0QCQ/I8xYtouccCG3aAzC3Y6lI9CiNhul/qRr/WxMED7c0RsRf3lBvGLRhlyOi7uhfvGQRVoQI/RTcWSTp8Rtp9inUmr4lmCQfIarPJ+ecVmfTRkNlVBSKEiyQGBs/oB4Wv3VB/GCEWgqEEX5xNUO/lrgtl75+E3bF6Y8k5AZIzKMQ08O5XrJVtT6BK3LND9HpxlHL1nMwU0KQAfW9x5QnvYOvrWyjTe+ansxuqN5fG2YH8yNePHWdqeW9/J+7Wtl4P0i0d5WexIJ1XtKgISNkOQTzcXtIfVXUXIvlL5UMH3SUQ8KUYGmY0Yizz6Rlifqr2r4tep1urqixqqLk5MINo8k0YEP/RNE/ZfMt8JjA==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a05620a601800b007858c3d50a5sm670326qkb.42.2024.02.06.05.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:00:44 -0800 (PST)
Date: Tue, 6 Feb 2024 08:00:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 festevam@gmail.com, nm@ti.com, andre.przywara@arm.com
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240206130040.GO1152441@bill-the-cat>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202180226.GF1152441@bill-the-cat>
 <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oyg9RMJBWZp/AJxW"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
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


--Oyg9RMJBWZp/AJxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 10:57:12AM +0530, Sumit Garg wrote:
> Hi Tom,
>=20
> On Fri, 2 Feb 2024 at 23:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:
> >
> > > Changes in v5:
> > > --------------
> > > - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> > > - Created v5_dt branch for testing purposes:
> > >   https://github.com/b49020/u-boot/tree/v5_dt
> > > - Patch #6: Added support to cherry-pick fixes in subtree update scri=
pt.
> > >   Also, used https:// instead of git://.
> > > - Patch #7: Fixed inappropriate documentation update.
> > > - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
> > >   tree.
> >
> > OK, for v6 please push this through CI. I've started a run now to check
> > other things, but just sandbox currently fails to build right now.
>=20
> Yeah it looks like patch#3 rework in v4 has broken EFI capsule .dtsi
> file generation logic which should be fixed by add-on fix [1] for
> patch#3. The github CI passes [2] with that included. I suppose the
> gitlab CI should be fine too. If its fine for your testing as well
> then I will incorporate it in v6.
>=20
> [1] https://github.com/u-boot/u-boot/pull/484/commits/d796c34307cd363674e=
0d0d2e31618643ac8e76c
> [2] https://github.com/u-boot/u-boot/pull/484

Yup, if Azure passes GitLab should pass too. I think you should wait to
repost v6 until you and Marek agree about how we are (and perhaps
aren't) handling fixes to dts files.

--=20
Tom

--Oyg9RMJBWZp/AJxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXCLXIACgkQFHw5/5Y0
tyxbggv/dj82883DFxw4JCF99N2EqcCpFOZJpQzLseN3b7XAmvPaIF3KqZAiBfaE
5WR73UUvhlwYhxquIOORuWMlxExX0HqbNGDVDIz6cMQ996BxoNCbJsDElOTGfZTg
Ccal/Mw5qgWHGfRZkrRkVDaktPSciGOFmPKucH1al1soe0/TZqmbVi7RJjRo9ZYF
YMY1zi+gzAit0+zgfcTt1QWhF2pQ8+cG/gVMkYi7/FKrAmPaa33mKWbialTyQMO9
besBQ88TovF7UYbXSf9XKifRDs2AXNTghFpw/ilZdH56cpwaYPQWumBqE/+7Mcsw
jekq/ldONt/4nmEQi3LMJL2uD3uHfMEAmXFC9YH2+s5gXZJRzR4XZNSJ3eC+U9kA
QWbrZ6oU1NNBZMutbaSSjHtwUEz3Eoz1efPddc0rLtJjqpU1ZoTJ31VMDFoMubQX
jblUlM+ks9DAN7un4EbuB0VU8ncj4vEpgT3Cs42T/IQS+LD0gXf3qUiWqmIJu8g9
xSVhpNHE
=QLS3
-----END PGP SIGNATURE-----

--Oyg9RMJBWZp/AJxW--
