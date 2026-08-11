Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBEDC5B572
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 16:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C48424081C;
	Tue, 11 Aug 2026 16:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2G5vXBoj57Xk; Tue, 11 Aug 2026 16:43:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB53340732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786466628;
	bh=AtAmtZ9CreVoOeeN9dc78p+VRkyVq1e7aqNaxL4Y6C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z9TU5QYaV2+9wvJs1jVkBe2+fManA7I8pWlI27eC+1FGnzg72KEhrHnj7prpNQwVN
	 S2Exsmws3zB65Kt/hOmshdRrgpxrvCP58Gg5nh05OcUllC0Nzi6/oewK/mMzlNSEwZ
	 ia3wVJGgwuSLfD/hoqTifMK3CIvKXs44pvLGBVlFqb0nASXtupnEv/1HVHgZkKdgqW
	 L09TpsltnIq45wTl2X6UxKvUqaef3yMVEO69sC7kY4ySW4dc1npkIenM18meBTQi8X
	 vgwuyrZ5xLXs+8WY8DquYyufGqsu80LlBHeotuKvwJpTHvnvM05cPlpu9+76KKHj3N
	 Xyvg2RP7ljsdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB53340732;
	Tue, 11 Aug 2026 16:43:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86996259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78EB5810BE
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgXhO6Aq-GNc for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 16:43:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 83C8581097
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83C8581097
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83C8581097
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:43:46 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7ec58fa3e01so73090a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786466625; x=1787071425;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AtAmtZ9CreVoOeeN9dc78p+VRkyVq1e7aqNaxL4Y6C0=;
 b=nH76QVc+qdv7S2SKM9MsaKkLpAmEjvNKlrb06WU84sMArZv2rI8pjSYjC5mcXiF63u
 /HtlJgG4DGqI4QFOt0ySeITJ0+/U3UrWBkGZk8LwqXoxgRX1HN1wb55PpLMUOMrdzetJ
 25Gwqz0KYUgZ1egZ++dkpCcR3+v42KzZHddQ2lNlUL0/FGFRrf02x7YOoxmyn5xOwqfz
 Jbp1qzPv9yENFTFio1jBrEDPBLQry2STDYngGecrnTqwYlZ5BGqvq1n7p++Q+U6R2toL
 0jUCGo4xWDyRpfdH9Nq2s1AFAgpvPYPaA3tRrBgzsg0H/sl8N3CzFVfvje0czSsp2Omr
 /jKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqa3ZsNQI79z6uoSbUN/HkFHvQ6YV6D5wR3rbPi4V+8R1CoTBOE2+D8hORlywrd7XCI48UoyNI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxbqK85YEhmK9/Zh5NogApwf/RPqAsfSYYBJ05RVfE1+V76zf1s
 DLULXCIpdL5aCA9aaeE9jaoXKfU24BNtdOLr8OQ4Jw421kn5hP+r069DOu9YE86NNJk=
X-Gm-Gg: AR+sD13mV1/zK+E/A5zobGpsRantnUldtIR8oyrkxl7KHBj5NfYWq2CEQGJdhrYbc+e
 bPEn5IdJbei2sdj9kf5j0KO3ydCTmvXrHsAbFaRAz503lTQNDcWIzAd37HrJrv1RtiWg6eOCiAE
 87spz1GS4/RBcOfUIuca+QCSHEdVT/DioU/kjV9HLywdj4EYRodKLQoSZ7Aq5CgNZHUX5y13ije
 KzyZ2DaOA1A9L9gnM8B2XnIFSk5pM20mIqDDY77XCloran8oDDuPRZcZ9L3yr/PMv3liUAyig/H
 ItwTWMnuwsJF3mNMF4IR/7r8AHs60e3rEiABjuwWKYMWQKawAsC92FxOVxgi3FVz6mCErv2EjaY
 MHBWxy37R2YiURaltngm4oTCCUtp5Bj2rx5bSM74h60WP60YA/acVWHy1/ZaKfQt4RzXCcKUWLl
 L7DGPi8ocVaFcgQ6RxlQ65828F+Us2mUELZjcE91h15zUybVM71gHHqJH/sDDhC6lq/jNM1pIqc
 eoCY60+QWlb2FnowNFJvpL/OcdrSq8Rt+ZWXIYT5AxQsNDsyjMHVlSiJJ1wbiga4Ob0f/OxrDLB
 xr86Btt7GQ==
X-Received: by 2002:a05:6830:83a3:b0:7e9:e8ae:7049 with SMTP id
 46e09a7af769-7f3a81df61fmr3244650a34.7.1786466625164; 
 Tue, 11 Aug 2026 09:43:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3b3209115sm270654a34.8.2026.08.11.09.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:43:44 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:43:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] boot: image-fdt: suppress spurious error on expected
 reservation failures
Message-ID: <20260811164342.GJ1160436@bill-the-cat>
References: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
 <20260810181637.GC1160436@bill-the-cat>
 <129bccc0-d5fc-42b6-bcaa-ba3a34ad9afe@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OJjgHAEeZw9SV4cL"
Content-Disposition: inline
In-Reply-To: <129bccc0-d5fc-42b6-bcaa-ba3a34ad9afe@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786466625; x=1787071425;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AtAmtZ9CreVoOeeN9dc78p+VRkyVq1e7aqNaxL4Y6C0=;
 b=cufJykZF1lhVmTHimB7n/DgZT72q0V8I83pinstG7bJxVs/1vaRhGwGP+jzLrPMAi5
 UagzUue6t2uXHpdABNO4/Co1jkXUFUCG2/8YbyjCT4g3xBWeQUT9GzCw3NM3dEHPgAID
 GxRisSFZfongyJd1sjGiNM74fqG0a0trPytXM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cufJykZF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--OJjgHAEeZw9SV4cL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 09:57:52AM +0530, Balaji Selvanathan wrote:
> Hi Tom,
>=20
> On 8/10/2026 11:46 PM, Tom Rini wrote:
> > On Mon, Aug 10, 2026 at 03:04:53PM +0530, Balaji Selvanathan wrote:
> >=20
> > > Before commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb
> > > reservations"), boot_fdt_handle_region() filtered out -EEXIST and
> > > -EINVAL when reserving an FDT memory region, treating both as benign.
> > > That commit added the free/reserve toggle but dropped the filter, so
> > > these now print as errors.
> > >=20
> > > -EINVAL in particular is expected: when a reserved-memory region falls
> > > outside the available memory LMB knows about, _lmb_alloc_addr() retur=
ns
> > > -EINVAL. This happens when a carve-out described in the kernel DT lies
> > > in a range the platform does not report as usable RAM, so its
> > > reservation fails with -EINVAL and prints:
> > >=20
> > >    ERROR: reserving fdt memory region failed (addr=3D91a80000 size=3D=
80000 flags=3D2): -22
> > >=20
> > > on an otherwise clean boot. The region is still described in the
> > > kernel DT and Linux reserves it itself, so U-Boot failing to track it
> > > in LMB is harmless.
> > >=20
> > > Restore the old filter, scoped to the reserve path: print the error
> > > only when freeing, or when a reservation fails with something other
> > > than -EEXIST or -EINVAL. The "free ||" guard keeps free-path failures
> > > always visible.
> > >=20
> > > Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.co=
m>
> > This is the same as:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260627204851.1151419=
-1-jonas@kwiboo.se/
> > So I've added people from that thread to this one.
> >=20
> > It seems to me like the last message there wasn't quite everyone being
> > in agreement on the next step, so, what is required next at this point?
> > This is clearly a problem in some cases, in terms of "scary" message to
> > the user which isn't meaningful.
>=20
> AFAIK, lmb_alloc_mem returns -EINVAL for 2 reasons: a NULL addr pointer, =
and
> "the region isn't part of the available LMB map" (_lmb_alloc_addr()).
>=20
> In boot_fdt_handle_region, I think we always pass a valid &addr and bail
> early on size 0, so the NULL-pointer -EINVAL can't be hit from here. So
> -EINVAL could only mean "the region isn't part of the available LMB map" =
in
> boot_fdt_handle_region.
>=20
> Maybe we can give "region outside the LMB map" its own return value
> (-EFAULT) as Rudolph suggested=A0and have boot_fdt_handle_region() ignore=
 that
> specific case (to make it more clean). That seems like a middle ground.

OK. I think a patch doing that might help move the discussion forward,
can you please do so? Thanks.

--=20
Tom

--OJjgHAEeZw9SV4cL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCantRPQAKCRAr4qD1Cr/k
CtJ1AQDimfeMbpeWCZtuvdI3w02Co8nHn0ip0EwfWpxxfX/YAgD/V+Tq9wk/CXHz
cXAAaBeRqV2n4HOwfJS1evu7eAsj2gs=
=5Kpt
-----END PGP SIGNATURE-----

--OJjgHAEeZw9SV4cL--
