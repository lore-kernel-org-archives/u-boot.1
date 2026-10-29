Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yfEZpAJu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bY5JECME
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3958280F61;
	Thu, 29 Oct 2026 14:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEsWFaFiRe_r; Thu, 29 Oct 2026 14:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 943D380F69
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793284038;
	b=Rrjjf2BG356RpsQbT9FHPKktppduHwpOA0tPHn6Epzv0q02wTAqoCSSpH762+qt4NFEG
	 YwJUUyrW5zt41rh4jN6M9vCvanIj5q5edKgnGNIOAxQPWtByyPYtYWd6nKYDULGL2Dhnk
	 wVXhTbcyCXdyJVTheNYnRi3t1il5aJYgS0YqB+XwcvjIbaZlznt2yz4v0Xtm5sqMEwvzs
	 9/dpXU57GCfn/aDGAmashCXMoB5/SvpwDCtL66lKCEDnPExX/2YGg535NUZliKtay4UVQ
	 8WWtKLzALylMb3ZICF3YVqW0GQHQmiLrWQr5U0rki+QsEKRzBtakUbZK9ZvFBrt4qMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793284038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9twJ9V4opt40+at/tn8GgUJ/guli/Lv7ZPCKHPBo+Kc=;
	b=gXHypgkNLss6bjljKXm8bwDiS/oTFKHAGNhYmhGb6HyUZrDY/jebGIUYKlACNMNicw/+
	 ypvxAGZH5vgEGuK80qFz/kFIT7HcElwBp3w4EmEIDPHIZ9YsDcxdJpIChI/+uUaSXYsts
	 TBBCXC70IlXhXfAU62HRaqg1em7xB1Sk0wfA2xVWrpdrL0WopcbS1/6uiEMo2oCa9Uwh0
	 Rn1AN7/PXSszS8zmkw9IEkMSzMLWB+ODMi0NndXYJgXQzltQ12rkBp8rLnvDrA0Q6sIfD
	 lnBVWGbocFtCr2Yl8JQd4PbFYsQW3rH6Z5Tx4PBvbiICWLs1JGqTIpImBOzHdXUr9Ng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793284038;
	bh=9twJ9V4opt40+at/tn8GgUJ/guli/Lv7ZPCKHPBo+Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfEZpAJupC0yxtqJW2vJIkRuNYl2NKihHp+L3qx1jtHw4+5oARVbENlq+iP3dKo8Z
	 HmPbLj1zFpBHDYmkK+TzJAM2dhO6d1c55ia++i/bcay9Iy4khneGbm+/QAGy3yOzC5
	 FtE0OTk1Owk/m3FRSEHIRltJkB/XAeImtv6cz86gZtl1lJ8yNnEWY1T/71/D/I+F/t
	 aTo+hmYiRkEOQNmumDt5CqMdWyWq/9quk9AquXStcsn7OjcEnde3eFSmyTta3zI/Tu
	 miaqrAxlZn3iMTh4fV9vXg26cPQ/n1Q9P/h7sv1XhCStpyN9UoBaVGM4Z6IHUS8NOy
	 +00x+iw1+xEQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 943D380F69;
	Thu, 29 Oct 2026 14:27:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AA9ED22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0084C606D5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkCbqMqgM5KV for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 14:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33791606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793284036;
 b=J0WzXbnIV5yi53ye5vYVQtcYAgE4OdpDdqJgph2WrTd3cqQoBPl7jol3uWHVx7iV+0N8
 RpG32D1jtL6Om+VXvrFyQ3BzEedAhNC0yFf8sl0Gn1FEGF2LAbNyip1gf0DZi65nehxGi
 B5D4hewNIvvk+b27QZ8dosUmlNkmSKWFB5O7PIBBgWTXCL4YyDn2FQGsDcvHlM1OwVZ6T
 wcPB+mWBIIss5uvw8FzfnvFW9HeJKiD4MHYWOuJ6eXe6LcUOD3HTmofLkEVDkLRshAyIy
 E/dysI2jfuqjmxPcIXs2WQ5GJwELCVXvwHdB7v2IoMmx/MMGXWG6ZvrX7mFXoJCVv2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793284036;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=9twJ9V4opt40+at/tn8GgUJ/guli/Lv7ZPCKHPBo+Kc=;
 b=ruxZHKJQZBY+q4fMqMFzsP59Cs2pAcw7mokG5UURxMvO3zf9Crf7kiB37pWMdEWKwwRy
 PS1EGIBXFNuMEisdgfaMpl2tHX4Leppj2vgMi7Ih6WHWHO8H+88qx6tnVEXkp9HDIMBtE
 tJUU2659ysbpuQ6m/ksSAIAvNG5bqmjffdwH+FlpaDvODld0qLyZh65JCJAuMYmiy6T0p
 af/eFPY0xgGgUCOnb29KThzRJ5VcFN8xaxonvHOTLTmpiT1w419uTUaH793z7Y1bU+suS
 GNAc87gGzA0oqoomb6Yptkms8DGQPXWxjWInhiToJo4twwMKiLrdM8dF5VR9ISn93aA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bY5JECME; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bY5JECME
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33791606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:27:15 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-7143451981fso1088252eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793284035; x=1793888835;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9twJ9V4opt40+at/tn8GgUJ/guli/Lv7ZPCKHPBo+Kc=;
 b=bY5JECMEeu99WuAx6jcf3oNXKYbzsciKJTb2ZBnPCxiVaSYP4eCBZ6Zt7N5fLkIMPS
 F+x3cMRCAlJ7XyP8YuT3cONDd/KVqlOuRtw9+p1DpOSo98YKM+wAjnzYF3mf9hjczbBV
 IQ2PuTL+gYCKMif0oG+Kta5qnV76F0AjkPArU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793284035; x=1793888835;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9twJ9V4opt40+at/tn8GgUJ/guli/Lv7ZPCKHPBo+Kc=;
 b=OfLXpTThsZv4oIf/m7ZOGtAxTTIGfo3vnMUh+dMLSPqigbOPPvkJeX07YpA03hRIje
 vsukKiFVGl9BufueC9MTJsb3mAdXywGN/9KetYVWRoJsvQ2URv/nNm9UUE6m/peXv17g
 iVqpjN8rAWzIxoTcKFy7dwZ7Cj/ugVwhxqFudiV3ussUuNjfeAJJD9vORZFNG3p43TnS
 qLPSDALGJWXOAElwL+Lz+vzR8qfWBB3GwSqhEr4lde51MG/909WsqKuQKvTfW2vwkNNQ
 IhnAt7W1iBJYL+FxRfI5agpnFW4t/gfyyfwgRt9Ny/IEWJoh2T5fo265aTfpq00OCe97
 p7rg==
X-Gm-Message-State: AFq9FYL7oWVJjvMpiNWgnzjmYwzbaTRE6T+HTUbozxCzHErwngDYegDI
 Ijxjjg2GrqnkflEnshozaYtW5xEFAWJOKz9DhGjRH8qClCMUOWGxjW73/XO0YQ+z900=
X-Gm-Gg: AYBFou0X/E2nS72HiZ1hR9eXeGPKLnKXxvJqHQG5pup8vaFiHiXHRmWxTxkq0rfK4J0
 FrSH3eafQWhSD/eBvrOIjZwaXynaJzLnIRhVmmYwvCnrMJdURZ92ZoZYBsLqm5liB6WrC0t3pax
 HvrYQBk+fjOrsZjU2HTpNv/j1u8cXyc7mi7K0pZSXhp4wDUsX+VnDGSzMWtAaALRyrrm5wrWTQu
 GVFDXYyqr1AFJ7X0eitWPgtgtg4SkrnPzPonwAblOLng4NRDx7wd3M336GC97B2HtBErQOtqTK4
 uo497WGU13XeMKqGGFrygXgyTj5quwshGyibHfRaNJjgTHBw5lAY/9NyF17ANQdpUVM+EBIOVEX
 uw1HynwHrkeEzOhA8G0a+YdphYq+pWCwqGZb2OnilkxnR/wLh+31qNhaDt7BGl1Oa5eKrtshj/2
 NJkJG2W0f31x779fG4sRICLLHOfjX1N2Ak0FIlSm95q30GMgNVU0ADth1dzgcZKwsBdKG5rXYdI
 hSw8mfdL8w6AGYpVCnzkn4D1qIxLzCnJN34ZaY5cTiWss5N9FM17gXyaaIiaCYQX3EIS2Z3rRTs
 4b7uRcTGnFcWLZrtLOev7PqSvYqZb45CXJev98x1gcIIQ0KX1xFM2/40rwdSU1o1stq2J+KeXvz
 WZj8C59nqHi2jUixvFFBxbwPfNogfLJTXDb0AQK8GkzT7UaI/a0jau1rs7/+sCr4PamIv2qbX04
 ymUmXLHBm3cza5eXrxkTfU2CmlvKUNcypGd4gi7hmVVh1jHvixKJOt
X-Received: by 2002:a05:6820:61e:b0:714:6328:2893 with SMTP id
 006d021491bc7-71463282b61mr2877508eaf.44.1793284034673; 
 Thu, 29 Oct 2026 07:27:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714dd789676sm2310247eaf.8.2026.10.29.07.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:27:13 -0700 (PDT)
Date: Thu, 29 Oct 2026 08:27:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RESEND] misc: Provide stubs when MISC is disabled
Message-ID: <20261029142711.GB2976463@bill-the-cat>
References: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9NgmHa4NstRVrmXH"
Content-Disposition: inline
In-Reply-To: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9NgmHa4NstRVrmXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 04:01:55PM -0500, Ryan Brue wrote:

> nvmem.c reads and writes cells on UCLASS_MISC devices with misc_read() and
> misc_write(), so a build with NVMEM but without MISC fails to link, even
> when every cell it uses is on an RTC or an I2C EEPROM. The headers of
> those two providers have stubs for this case; give misc.h the same.
>=20
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> Ran into this while working on the Amazon Fire HD 10 (2017, MediaTek
> MT8173), whose U-Boot port is not upstream yet: it keeps its reboot mode
> in an RTC spare byte through nvmem-reboot-mode and has no misc devices,
> and with NVMEM and DM_RTC but no MISC, the link fails on misc_read() and
> misc_write() from nvmem.c. With this patch it links and the mode is read
> and cleared on the board.
>=20
> Developed this patch with the help of an LLM.
> ---

Thank you for disclosing using an LLM. LLMs are discouraged in the
project, but this looks fine.

--=20
Tom

--9NgmHa4NstRVrmXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauNXvwAKCRAr4qD1Cr/k
CsRcAQDzQolWUlWAeKbwQFwjNl6lyaQQIY4bCMAlU5dAMGX2AQD/ZEVnKFmBuvij
oil1exhdnLURjJb3E4ngnZTmL6i6two=
=vzVa
-----END PGP SIGNATURE-----

--9NgmHa4NstRVrmXH--
