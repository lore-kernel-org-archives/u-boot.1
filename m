Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F1606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bdoSgiB2;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EehF/3S2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8254060AC0;
	Thu, 26 Nov 2026 14:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gctejbzsIr3K; Thu, 26 Nov 2026 14:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB6FB60AAE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795704668;
	b=gj0lGVGYy77wAOjXXe9UcG77kQrjO0XscgUtOC6mtLHP8HrLm2eigXgZmFC+qomgZ/eW
	 L/1p5W7O8AkfggxrSGRDEPntxumIDmOwy8Y+fxkygtD1OD51EjYRI/1GF88LelalyWWtH
	 +a5BHuc3lr9gbTSV3J2y7y/beyhcDff6EGv5JM+V6vuPbNkRpiw3wRnP1yf+xfdpaWZiO
	 SYcvcINV1iq+dSIedw3p/HfYorHycnClIgQtsp3L9BxE4Jz7mhfVffEulR+k+uFWVOs6s
	 SEIqesXPRY0MUFb5J4VaSVRhmp00rcyuv+27nq0QmSKp8NLKgpsPmIA4LGqLuqMl5og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795704668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iFmEYLIMt8518a0FFZO+3gy+JmLEOjAER28t91j4k3c=;
	b=g0w3zt1PJLWod78614i1GLAApaOf+uu/CWLGnHRibCnht9drgUEzgKge6HJoYCkP/ge1
	 AEQ5HEvd7j3XVi+OM1eb/PodLP5pMD4tr7kfOxxyAK4ir1siXuln4N0F6Q9k14+Md+BUZ
	 t+3ZwoqA9F1KEU6ltaGpVYbUVrGLKkc+Niw8kdqwXVC6BNLqjKfcFikfD8AF7C7OsZ444
	 o8KAOJSexGRK9DaTBWHzCenBoWYYTKfZ0eoEtV8YkSE1iwtsJrm1mnBvldOJhXb8ls1FT
	 iexp14bv86dbKUETb00tSiOn86p424ENXHKIIied4a9GGkoQtrzdcFMYrZVxkdezfww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795704667;
	bh=iFmEYLIMt8518a0FFZO+3gy+JmLEOjAER28t91j4k3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bdoSgiB2o5YCQLvkQ7FKe+MZDAsT4YCuynN6kWlV8RtFMtOgSlUSFevPiQOZHfF7J
	 tbOwxK5bUCWIrdspOJulJspwqeU8Axxq6qivq6bJaNVGLk2tyWbrrdomUgvRsFEe6B
	 VX4ULq3Xcrt2U0WaFjHH0Bq4tn0OmSGj6eAHCrpKB4xwzNTo0wb/WGmk5CUKCPVywX
	 1EAv4as+6h/Gr8gcc62gszv0K9A3CdLGEK8QfLlNARcLrCtJDpBnEdxfc0GwziG0u0
	 USl9grLjy4iQ3fUgLWpCAqq/j8vHqdv+nfeysG+G8obTiF0kyrI/EP+EfkZrz6as5k
	 bxAYWPdMxvRcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB6FB60AAE;
	Thu, 26 Nov 2026 14:51:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CF30260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629E4811B7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sb_B5PlYn_Sz for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4D36811A6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=EehF/3S2
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4D36811A6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:51:05 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6b19e291cc6so6084999eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795704664; x=1796309464;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iFmEYLIMt8518a0FFZO+3gy+JmLEOjAER28t91j4k3c=;
 b=EehF/3S2bmGXQ2ZqD69aPf891x2g03T93TB8mbuAp3pSnNkcodnDpKZQU6ZW65ZHwp
 l7XBLzmYSyONfNgwGOIbuzi0EJcWeHXonarEDaJ/TV9pqgHwXBlR5kyR9e+RjE8jgYrb
 iJx9DMEHPiwZypbNF1hKrQQbnlsF5ZQf/vpF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704664; x=1796309464;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iFmEYLIMt8518a0FFZO+3gy+JmLEOjAER28t91j4k3c=;
 b=TpO3JhaMhcvb/sw4IBdchgZUENdAGixLDrSSh69cNZRR7F+B4QJE2igEAdaSH/vfH6
 aX6ocdtFwzGW5KpBE3vnP+TBasHDfZCbWKnEpG25XG2ofInZroCp5g8AVH9wuR/9/CAz
 KlQhghdkt2lRUC15PMOOYqRlU91C0/PFmFw8bJzi9g4zAqIJuy9GMvk0YSntvhhCVR7Y
 FAzoXCMeBx9cjNxknjKD1SdUbHaVpG2E3urYZqUqEU4u5k62P9e9ypPzdpKElwmdzGJQ
 hhzq3PlY1j1NDB3ou01gQPNxgozlgDzQF9p1WKBQif30i+7WZyETiAcTsZXjAYIQdZ8S
 jzdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmIVX2gCwBPiIt5Z3aObKcZXNwfQ1TNNECGkRuq//a9HitxvFqvdFpcmOFB6zQlpfPcqrWvYE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/FzPf9gGgeVrMpD0tioDhUph5ZzQbdj4CJWS5CofZL60Trf89P
 PG8zhEDMk5WdUhmvTbKVyojaCm3sPE9HTvjxMfkzHmXcBi0URaTpyDy6ahQlPl4PefcO9zOE0jS
 mimoz/LlixU4k
X-Gm-Gg: AZFdTZc6Bv8OBJCOXXnKJ5bjh8PsbUnScBS6HShHVVL/K04i3Hq9ONj27iY4V218sqt
 q29lpVGtyzLoDUFZFVKLyX2FJ1Qyva8Uzz6nXz0iGrytcJD3Fgnqxeib+8P6MlRWHPLElLyudDf
 24KCSAzb7idEBlGgRa6/mQk9QrAyaxkYfmaKx9dBfCAHzHQCd54moq6aUlLzTR1BDFF3g9PwXFo
 XMkUjWhtXkqywBiK8j7tFsCTv9AOUaOn+RnP33ef+8Yy3XSdnCuIC7gcGU24Z3sAICQtYsKAhdH
 tVacMnbS4HQuxRVloiogcTRrt6GhG+c9Vrw2Pg48ggzyEto1alQMFDYJ4HqmtitxfcwUHwZOJwV
 VfpxJoYseW3jNCZ7PPUPS9vjc8P7vnKqMOGbOKAF5/+GEKzzmODvDQ4UH/cfVeXfYWdHrpUwRwo
 fFMgLD3CNjavytlANL/Yote7l5Mr6Ra3/wzoV2EagynSIZiWtL0+J/edtucacS8LGf5z+Y7d/M1
 1F/zib0Zj6LTPSA46FM4/7C0oxqW5fYTmk63i9CNKBXY+1KXLeY2Fp1SV2CQLtu+8B70r5DjpKK
 dFxVVakjKZ3JD8vvXSYHeBqeikfkAXjak8YPZVtvvwjFBdo5py5v1aA20IXW0RGUzrL9h6/kjOx
 e0iu2FleGI3zVm3r9FRN48iv7sfMO7TaNYa1hM4KPIVwHvwAqy1INWQa2hFOabc52ozTRtUvhNW
 vP6wVwmekfv0DELI4Z54f8Qfy40x4djhY=
X-Received: by 2002:a05:6820:a64c:20b0:71a:f583:67e3 with SMTP id
 006d021491bc7-71b394f4cfdmr12750321eaf.36.1795704664235; 
 Thu, 26 Nov 2026 06:51:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm697215a34.21.2026.11.26.06.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:51:03 -0800 (PST)
Date: Thu, 26 Nov 2026 08:51:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] armv8: mmu: sync emergency page table attribute updates
Message-ID: <20261126145101.GJ3176972@bill-the-cat>
References: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjJO7Xi3RrSnQw4sALirSfjS85PV6wyfyrupN5npC9YY4g@mail.gmail.com>
 <179569778695.130558.12289369126356468678.b4-reply@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fxwDdbcFXcOsybGk"
Content-Disposition: inline
In-Reply-To: <179569778695.130558.12289369126356468678.b4-reply@b4>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fxwDdbcFXcOsybGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 06:26:26PM +0530, Sumit Garg wrote:
> On 2026-11-01 11:31 +0200, Ilias Apalodimas wrote:
> > On Sat, 24 Oct 2026 at 20:41, Aswin Murugan
> > <aswin.murugan@oss.qualcomm.com> wrote:
> > >
> > > mmu_change_region_attr_nobreak() updates only the primary page
> > > table, leaving the emergency page table with stale attributes.
> > > The emergency table is used temporarily while the primary page
> > > table is being updated.
> > >
> > > As a result, speculative accesses can reach regions that were
> > > intended to be blocked in the primary table, leading to XPU
> > > violations.
> > >
> > > Update both primary and emergency page tables when modifying
> > > region attributes to keep mappings consistent regardless of the
> > > active translation table.
> > >
> > > Since splits can now happen in both the primary and emergency
> > > tables, double the number of page tables get_page_table_size()
> > > reserves for runtime splits.
> > >
> > > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > > ---
> >=20
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >=20
>=20
> Tom,
>=20
> Will you be able to pick this fix?

Yes, I'll be taking this for next at some point soon, thanks.

--=20
Tom

--fxwDdbcFXcOsybGk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawhHVQAKCRAr4qD1Cr/k
CvnHAP9Bt7OaXlpMHAP7oV2TTX9dmn5IV+hZrkNgu/xTNzGeoQD/b+m6CQ68v4iz
N6TiUkF0mQ9R91V1byt6JdD0sggpeAI=
=Gi7O
-----END PGP SIGNATURE-----

--fxwDdbcFXcOsybGk--
