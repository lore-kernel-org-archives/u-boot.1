Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6C0C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 18:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0973487D82;
	Fri,  2 Feb 2024 19:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDgLi0P/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A02B87D83; Fri,  2 Feb 2024 19:02:43 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1E487D84
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 19:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68c813ba956so10404366d6.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706896958; x=1707501758; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ikCoWzu3aYA7x3gUE8fRZkoqiwKJc4G1nAp4b+pRdwU=;
 b=KDgLi0P/00NRhiiH5TYoXXcza3LsXI3e5o5cnFw3BPMWMUTtkydVkvt9julwgpRIYC
 tCW3nawhNlaCK4zquZOOhmge75oi0FpLd6FRLbbvGIp6lSK2WsuhMy1X3UXf7sAluCEM
 GDF9s8OWEwVbOYGWWXyQ7XXLVZ0GCSYqs0OSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706896958; x=1707501758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikCoWzu3aYA7x3gUE8fRZkoqiwKJc4G1nAp4b+pRdwU=;
 b=MmrNsf27JncR9FoU/69MmGLMJT1OVqlVzhmnhDOzbq64d/hV1hy887IXKGNrkqUqPt
 E/2nAbuAGvPR1RiTO43rJ2SXEf9/6I2eXCHPNEGmU1ZyQhM34prdTauAaID4y+2EOMoW
 X5qayFuPBhzHOzMmV/HWEwTikyBU/vkdobpIBH7NgRgzyXdtrJKaQj6FdelwTanltdUb
 /aENivfYq88htna8nKeusbfu0Yg/SHwAVOBF5upHzcxhVblK5MfRz8bg2RBXRLfXJBk8
 wnWY+PboptwRxk/L1iwCyk9ch+vOu8p6vc6KJo+2R3xxcq8jYwqnvSPZRvJhQVOSuRaX
 FhRg==
X-Gm-Message-State: AOJu0YxVqiAvri+R4FPW07cpC3sV262//UTSvDPCbtNRiAkIuMcEp+mx
 AOMtXv6tJwC6Wovk8AYMbdmuFI9k8ovtxeiwEkX/XAQ6WsT0YK2Y80akrsWYP8c=
X-Google-Smtp-Source: AGHT+IEL6a+emR8iVTn61JN3UiFucOkdPsKv/VPusMoWlgEr1PM/7xxyFuB4O8nB5kllUMmX6tTL3w==
X-Received: by 2002:a0c:f281:0:b0:68c:8a61:fd2d with SMTP id
 k1-20020a0cf281000000b0068c8a61fd2dmr1373108qvl.2.1706896957666; 
 Fri, 02 Feb 2024 10:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXqYnApDsIbF7+SQWcdA8wxQ0Vm7lWpvtHafg+9lcD4KhLCSZLkmcx6WHuPVghYaKRnd2UrIMopejdGV8USsvfYo4isfXlbSIYufr2S3D7/kD4H84P3FSsfpcA+dfFaMnJ5z1OPdjtAtOxR+T+OmQYC2gSekY4FWne3mKbFnHQQcnjiFeZC4x1CCJ+prrOYf2vEWavYrabUvLnf0rUuOaYHehHFK2btABp21Tefdzi7ciarQNIhxoJ2mtpWzez4mXLXSA5ttaBL6V9/syHcuGc8+11qBc462lVrdR41PlBiMS29jq09BwlK6Y1GnPxGMW0FE17XU5kp9F9oQsyWx/fEdgI12TkPlijiZIM9e5NrwmreW310yU879GLL/+yXQAlKkta8wPpu55uxUFdwY91Fk6WXDLhlrDjPX6PqYkmpd/nkn11GhvWJ6pNOcqNXEb0he2ebRUCNnwlZsz1INb46G/3Wbpj2QWTYM3GHN8orF49jyubEq5fHvA8nETFlG5DVMtqzUlL1JuQFWFRzHhaFeJW+geH0WKBdMAsQueNFncmM6mpZNbBe+AFomF6gCfKlBsu2xw0NiLqTvm26OjLokzKsxwJnh2/ayvP3d8TDHRebuLziLfjCbAaq2NVfCTPlm6es0/2UfJnEvtQbkhMkTH6BNb2NVm4fsSRPE18Q4aYl4KqobuaXdp7T+I6v+qx++JD6P2JfURSwu9X9I2z4iOBk4ZgSqk3PzJG9/cy5Qv2PBP5hLdPUAbpMmh9SlhMQwIQVa84pDhG92G3S1TBcxuYGQXoUze9rzZrBedm5LYrqA3n6CxVPE8ehNnfbyYoRHFDu91D7/D9MvD3jklInAmmyOYviz+mTyoOR04CD1ypJ4HdCIrEZ3b/x7LuYVA5olA==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 qq2-20020a0562142c0200b0068c8b31787bsm327048qvb.139.2024.02.02.10.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 10:02:37 -0800 (PST)
Date: Fri, 2 Feb 2024 13:02:26 -0500
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
Message-ID: <20240202180226.GF1152441@bill-the-cat>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8AzBqysBa+jAAGLt"
Content-Disposition: inline
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
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


--8AzBqysBa+jAAGLt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:

> Changes in v5:
> --------------
> - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> - Created v5_dt branch for testing purposes:
>   https://github.com/b49020/u-boot/tree/v5_dt
> - Patch #6: Added support to cherry-pick fixes in subtree update script.
>   Also, used https:// instead of git://.
> - Patch #7: Fixed inappropriate documentation update.
> - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
>   tree.

OK, for v6 please push this through CI. I've started a run now to check
other things, but just sandbox currently fails to build right now.

--=20
Tom

--8AzBqysBa+jAAGLt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9Li8ACgkQFHw5/5Y0
tyxvZAv/ft70KJ7IMe6F7NhgZx9lco9F1vb/PYGDoB6LvMfR8g0NhUVJdR1KMIXe
bLPAzQH761Zwa5OSyOJjiv3kCMPKSmcFXaSlvaHurLpIHhEN3600pXOeEIbBHRx9
MrzKPQ2ITZChkwpvuxJKYDeDP+54kOXPGLyM+en6Z+KaDDuaa4pM50hvkCB7o0fV
LalPr46rUoT3/J2alHFhgNtT6EOMfwg0kFPDkmNtoMkst+aPDTvDS76Sdprj1usO
VOpfr+b+JUdDT0r+iSMyX8j4eKEhxoZmGJkHbnqGK1nARZDDrh3gvPG1KbLCGmpT
Iq5nxpTSiGVqdr9xu6o922kTt+PQ/XBsyA3WviO8wYj0hOLFmwWVPBBx670rPlme
41bOGoW8Q1hXpSTJDj4BShvskZZt3Oza92LOGY1ojDVCg2E8MkDoXsHO0qp4eLBQ
1dC/fBK93Pcg/UDET2mPYMi8CBiDu914FqzOvNkKfcoMphZzJ20UqUWAVO2b4QFY
qMwPAnSZ
=Locy
-----END PGP SIGNATURE-----

--8AzBqysBa+jAAGLt--
