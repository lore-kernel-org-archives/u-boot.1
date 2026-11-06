Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42625606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OhwGikDo;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ul+bbzyr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84C93812F1;
	Fri,  6 Nov 2026 20:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoR1DIGNehU8; Fri,  6 Nov 2026 20:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80CE7812B1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793996207;
	b=GKHYoQmzOqL/CCsQD+ozxcbcTxDJJpuYfCZyl/vawMDeU/YYLNQ+84dGR4yaboiPxecG
	 /WeG19k2dxdajSzKjqttzd6FRmiM4+xIPbEgHUeggiej+/G0IY9PzujElt9EB0I1JGK7u
	 qKZrs21Ntbh+AobHzJWo7WZkFI60lkC7yd8kB+JheRZ2PvyvupjK+Y1BziewRzamEYIBp
	 BJq6fdVlzhoR0iE2GQTkco+fnwG4wMDcpZ4RSAYi/FFcZV00J0NClQCaGSWUG3Q75NNWF
	 GAkJCefwgQZ+DCi8SOF1HmzuT4rUHRhPOWVRCKTLx6dT8ZgVZYKwd+nqSGrEJqcNWOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793996207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GrosfRvyNFrTBoe3WWwErbC3L7n3Vqy0f/0WF+Aai6M=;
	b=pHrSXBmaOWRTT4B3Agjxr1hTH9MLY4SeW/5yPuVGoQVFxkniTLFCvDz31B3nIbPcM7Ht
	 x9zfPtIekWWoXrhGA0Tk21xGP8ir6Gc+HM/UCmIVv6JzNGHdoRwYv/VJfWC74NsGKF7I3
	 2H2w/rDvD0k9ko/TJgTuZgZ/rptpXeNO98Fcb2hybg6yUuNxM0rMkXTrJEi9FmkxvRqC8
	 Re2+INntf3CajFVsVgHQvf1tmK+fmYR+T7tjIoVp9gTm1godTB97GqZPmR0OAp9oBd5Xx
	 82do37gPcUbWS02vs+icFcB2ig2oJmh9HJ4cRjIFJmQrvcbhTPH8shUXKDc8vfEIQGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793996207;
	bh=GrosfRvyNFrTBoe3WWwErbC3L7n3Vqy0f/0WF+Aai6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhwGikDoXCfMvit7RPmG9qAV791asdQM9CmIcBYaEGnbpBfQ/wmGz/53hqjOYMMKb
	 CnB2DtVGtaCRg+iKq7uRCydKrxAPzrUSkMVzeB0Y+iuT6YpxH8snA63gL/f5PDMQ++
	 PbOsq7n4lKtJz1hdoXYe0sU1VHQpu3appGFnjzIQ6GtzPI0539wDYtPX8bget9fnv8
	 XEuHTOcS9/oKtMUm+ZosY0Wt/6sEBqPSBQ4xSHO1OWFwCrZcjI2xayx8bGyRi8e+nx
	 648sFAIOWydeLTWUWcSzP9fvq+KmpQzChe6SwboVXQqBtMhJ3oLBQ1xnEemcieJkCv
	 5bJoRzKflMWMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80CE7812B1;
	Fri,  6 Nov 2026 20:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EDD431F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 406CD400F3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gMx2NFLJJtIE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 20:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42F0A400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ul+bbzyr
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42F0A400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:16:44 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-828c0b569f6so515985a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 12:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793996203; x=1794601003;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GrosfRvyNFrTBoe3WWwErbC3L7n3Vqy0f/0WF+Aai6M=;
 b=Ul+bbzyrGRpB6EFmKN4zlCVK0fSBCgW2NvrKjwoROVn8QnJ8POsPQhHY7EeBkxqlqi
 cmUL63BUzYL6iFCjCkE+lV9OBV3n3WHPQBuyFsskjXebKWCG71wruWboo3PtyFnQTCxn
 Uv7BpRtietxYze+aUpaFHbq9gnXIYexu3kP4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996203; x=1794601003;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrosfRvyNFrTBoe3WWwErbC3L7n3Vqy0f/0WF+Aai6M=;
 b=h2HRLIpYd18guG8NzB2KC7G7EszOWmqIKntji/UejSHAbhiVrOil83Nf+Fysjn4oLW
 b2uaYNfGgAcFN4oWBw527tGIq7bZjJPkQv11p8lPNeaBXnT3anSOozrvZV0kVKm7RMo/
 r+UaVmZike2NQeghas4i5CDQBL3+0ADB1XbuQGA2Sf0RUEat1oe5/V61QboMsW6OM6dF
 JGGj/ltI38Y0VXcjAePP5nsTdKD7falqREz9qcGjkykCZ/GdUH9og/IHepysX6tDignn
 dEhzFvZG3ek3YMldpqrYZzFt0ZVtLNaOMVeaxbDQdRf1+eI86GKIuvo3iniwOdtZWd95
 ntjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv0nOrvW+g8MH6MwXH1BJVWlm9jA+PyY+uQppn+2PAkXqZfOFqMAcrm1feJG6jGSO773+uE5w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/uLKueI5VaPzrrF0I8Q2FQLIvp9hysvqqd631nnNKKdwWXmDhh
 yIi9ELsbIlPQDu8B/+/SXNqE1MneVu4BcVsyeN7dDjcOCwYNmBfXdDD1QhughOLMlp0q/lpg63R
 RjfkJdH3Y+qlsDZg=
X-Gm-Gg: AYBFou09rjIs1ckQqNDAW+ZevIiIk6/emC8NoRnBgMrLGqOW39WqQfy3VzQrkTd+izH
 52y2ku+Rnb5+xJCar4GvycQaUx4+aDrVpF9or2H3sFK5uGLoHISLElxem92biYtKCZ7YSVfqiEu
 a0IcdZI3EiXy1O8l3725pi/YuX4B3A3EPToi1oM/Y1CJZS8bWpfGr/ColyVcuwPlSDdqT0uKkdE
 yWJ9m6qdaMKEQoxg8bqXuLz34i/iVDOYAuc2OGfkgyqh7g6AKPrAufHlWwsIvRa2/AMNxNJWAiJ
 YG9O3jFKhDV08C00vyHf6fOLOMvx7uFTdbW00/UNMzsVh4RwPsiTs348JF7awzhQfr7rUEDxyCQ
 ken48BCB13X6uHz8gk8h4lmSjlV8VmkLVId7pXMa7QJFwuhkxgKTifKDwdqrqFfD/hZvljIsrEo
 RiZIEkpURtnsM5jWig5ICle74L2s0QAeW/KgyCUYTEk9MUW2D1CjlVVWNjGiGK3mr2VwmfuqYTD
 XeOptT2AoJZioZjpb/NZ+Yg5SsbvB73VCBV1axx2WN+RO4xDmv59GsC22o6MFs067lkyt/0R8f/
 +s4xFF/HtG7XcAjx3nQpLemGiqcsT3hpEWkbjGfqi5F4a6NYEnd9z46xlKFYQPEwJx0OVZCtdHn
 NIVfg9o0UfOQcXiqfcJ0jMpbA5mc6z4hF03mpIAjBhSqMvIdX28Gny2KwGYra5afq1W1JmPR2X5
 XtxocNhUFMJ0WYU0Wp1dChpz92h+qG7A==
X-Received: by 2002:a05:6830:3114:b0:7fa:ac4f:79a with SMTP id
 46e09a7af769-85f1d0ac516mr4252025a34.22.1793996203457; 
 Fri, 06 Nov 2026 12:16:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd1d7d9sm2728791a34.17.2026.11.06.12.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:16:42 -0800 (PST)
Date: Fri, 6 Nov 2026 14:16:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261106201640.GC3741582@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
 <20261105194153.GP1164024@bill-the-cat>
 <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
 <20261105212346.GS1164024@bill-the-cat>
 <137d1afb-e65d-4d33-825d-c02fdde637b1@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d7BG/VWgvlrUo7A3"
Content-Disposition: inline
In-Reply-To: <137d1afb-e65d-4d33-825d-c02fdde637b1@mailbox.org>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--d7BG/VWgvlrUo7A3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 10:30:41PM +0100, Marek Vasut wrote:
> On 11/5/26 10:23 PM, Tom Rini wrote:
> > On Thu, Nov 05, 2026 at 09:03:55PM +0100, Marek Vasut wrote:
> > > On 11/5/26 8:41 PM, Tom Rini wrote:
> > > > On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
> > > > > On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulk=
o.com>
> > > > > > ha scritto:
> > > > > > >=20
> > > > > > > On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > > > > > > > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > > > > > > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wro=
te:
> > > > > > > > >=20
> > > > > > > > > > Add conditional around REMOTEPROC menu entries, turn RE=
MOTEPROC into
> > > > > > > > > > configurable boolean, and update all defconfigs and Kco=
nfigs which
> > > > > > > > > > previously only selected REMOTEPROC driver to also sele=
ct REMOTEPROC
> > > > > > > > > > itself.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox=
=2Eorg>
> > > > > > > > > > ---
> > > > > > > > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > > > > > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > > Cc: u-boot@lists.u-boot-project.org
> > > > > > > > >=20
> > > > > > > > > Unfortunately this misses some handful of at least TI K3 =
platforms. I
> > > > > > > > > think using qconfig.py to confirm which configs have REMO=
TEPROC set
> > > > > > > > > before / after, and that they match would make sorting th=
at part of the
> > > > > > > > > problem out easier. Do you have time to do that, or shoul=
d I pick it up
> > > > > > > > > and do a v2? Thanks.
> > > > > > > > I can respin this, but do you know which platforms got miss=
ed ?
> > > > > > >=20
> > > > > > > I lost the list, sorry. It was a number of the r5 builds. Per=
haps some
> > > > > > > fragment got missed? But qconfig.py -f REMOTEPROC, with a db =
built with
> > > > > > > and without the patch will quickly show which oens it is.
> > > > > >=20
> > > > > > This is the result of comparing the two qoconfig.py outputs:
> > > > >=20
> > > > > u-boot$ git log --oneline HEAD~4..
> > > > > 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC =
options in
> > > > > REMOTEPROC conditional"
> > > > > 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC con=
ditional
> > > > > df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REM=
OTEPROC
> > > > > d1d45c926a5 (origin/main) Merge branch 'main' of
> > > > > https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
> > > >=20
> > > > Wait, your new patch didn't just replace the old patch?
> > > Nope, it is two patches now, simple clean up one, and more extensive =
change
> > > one.
> >=20
> > Alright. I can't reproduce my failure either. That said, should I just
> > squash these two patches together, along with adding the fix for the
> > newly added TI rproc option and post v2, or do you want to? Thanks.
> Nope, keep them separate please, they were intended as a simple fix and
> larger rework. In case the later breaks something, it could be reverted
> separately too. Thank you.

After fixing up the patch for the new driver, this patch causes us to
link time discard rproc code on:
imx95_15x15_frdm imx95_19x19_frdm_pro (possibly new platforms since the
patch was posted, missing the same change other imx9 platforms have)
along with iot2050 phycore_am68x_a72 j721e_beagleboneai64_a72
j784s4_evm_a72 j721e_evm_a72 j721e_sk_a72 am69_sk_a72
am69_sk_a72_ethboot am68_sk_a72 am68_sk_a72_ethboot j721s2_evm_a72
j742s2_evm_a72 aquila-am69_a72 am65x_evm_a53 as the k3_r5f driver seems
to be missing. I see all this through using buildman's size comparison
flags, but just "size" shows the basic reduction in text+data.

--=20
Tom

--d7BG/VWgvlrUo7A3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau41pQAKCRAr4qD1Cr/k
CudGAQDDyezdbaQZIKdhU4NUtCcjGyvKGthvjizfGpdRZixqXQEAywC1m2bphVKp
lpylvkW0YF8T4CbqVu3t99hF4ncDCw8=
=mtls
-----END PGP SIGNATURE-----

--d7BG/VWgvlrUo7A3--
