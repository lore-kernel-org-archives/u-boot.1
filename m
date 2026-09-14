Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9376C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EE9280E0D;
	Mon, 14 Sep 2026 17:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrH0qtn0JTbn; Mon, 14 Sep 2026 17:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6FB8A80DDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789407259;
	b=Ff7PjNMAfBDdM4Q6h7E1B8uenjLRe7KyFAwWIaQMRkn1XjsCMF+GqPIGXNx6+YqN4/aC
	 em1wn+szYoLVrCac3XsaGro9JTKMhl/w/Wyfh8oB1Q0TALi0QD0HLcfh5tfW2o9GGkDA3
	 aydfyoPC5AOg5jfBnkpFcCtgyG57MaOaIW699QrVvfAf/+xlEiNHd4YAuYmb2oNdep7xI
	 4FaVQBgxRE24S3KoFPKiIO8gnV//AS8dqCiCmYeTlya6cf7OYhl/dO7OmY8jtv1iOucus
	 gUdlu+KITzPrPKZ4cd4feGXhE40VA6fugnD2Ogq1WiY/sDsQvAKEAlNnaoeBA7eVTNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789407259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mV+3biq9zwQT1Huw7wIeF3yQxNT8p71X7Oc3cfYRlGM=;
	b=COuSIKAKy+PJtlgSeQnQ4W9uZcSdu0RfRrda69odt3IcFKtK5qTXwrDoYVu6zqD07QvC
	 vKkHBG2rC36y9Ivu86rMqQU/pWVZ+6sb9nFJm3TjCHfhmdy8jo14lvCGCO7maDozFX+At
	 MoVmDUVqZa55F+IMaq9jxYeB4mo9TPpzkPSQ2UkHS5aOubVkege58Aa9YbhQcAfK7iplI
	 ukJa2izJ6mqX6ImnK3kH0/lEBuSF7KJCncjUfgRx0E1qc0ZbUe4iXe1Ba5I1qhLyT1Zs8
	 ZTZ5rKxt9z/F75HSeyV/CyKOoTE3P2InIWKTvoNetHFNcnkucYqOawMuxYl/DtnCgrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789407259;
	bh=mV+3biq9zwQT1Huw7wIeF3yQxNT8p71X7Oc3cfYRlGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTlkcl69+sJ6ErlMCpS/gBkU3ek+Fp1v5xek8FEEmsc2VeG/SlDzx/sSDj238eEKE
	 m3AZFBemQboljeFVlCd786Vo2QWxmTlPy0tOmcBjzPJuQLT/DEZjmq1EfuKRouiP5x
	 xkY4CKeKRLL578dzXSEVAiSSvU21x2FI5GvKgRjRK1333qk8SdQ4Pf0CMwDiWvc9YR
	 chBXQqXo1aWI1qWeJythjgJPSCOlXUYTuEquX1LD16S5/6MM/3khZ8v0VIMgA++VvP
	 QHFWl3YLHQF5L6pvFHORetGByW1ce6mVFON1NSKmx5oOCRxxEln9Uw7OUtJ64Hmi/M
	 YuR2+1xA+8IIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FB8A80DDF;
	Mon, 14 Sep 2026 17:34:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97D8E259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9517E4014E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFhqCRRoAqlT for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8629D401BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789407256;
 b=OYOGbLPxeHquT++0bNms8+iaLPR/bplIZt0yQCeaRYkB8p9fsfPkzoBqFaDPARgslkMo
 4LMZlz/+VzSqQ7hW4Fa9AwtkDUYomxnxm5uZtg15MUoJ2MoQT7CKlIpKsa+TZLn+mEjgF
 ob3dwAAALaICq7nVHFQv8Cz4LJrH6Y+RubdcbQ52dtwh9GaF3Kw8SoGCGphGoGp2TS9j/
 USRruq3vW4ymh2JOVmbrIAqZGr99a0nfufPP9rT5dUZf1lSOO3fat5dlAZsBbBQAwdj18
 koAEF7NO+Q1/r45/ezgqs0RjS7s4ufjlLocAuI58MqjDpOOGXV6OiG70NA8Hy9DHWkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789407256;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mV+3biq9zwQT1Huw7wIeF3yQxNT8p71X7Oc3cfYRlGM=;
 b=Wti2NAIrLOuKN2ND4PdzY1m0WWUG/EBt0AWaxtDQ3/4Uu0iCfDzBcbEOFBiMOOUCKX33
 0o0L3zzba553aF8IdpvksXnsF6fXQI2slU86NL4HhhhdBcg2qgEiSKAGIK4eNWApr073B
 26bqazRR9JqXtzFT1Od+yCsvvbCOBWv7F0R0E71WF0bUSM6SAM8DAhZXvA9f/ml5qCwaT
 sYU8jtSc9yaVwqkVzTyZOMo8nsJ7RoMMt6dpEcTiuxKFJAZ6f4WrHCi0YemNTGeRUdE93
 7NEpO+T22AoxEMWEBcscDF0lhJyGMyqpbkWLuBnyQU8rT+BkKZiJ3ioDSpsLQPXvNmg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l4WqqL+m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l4WqqL+m
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8629D401BB
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:34:16 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 006d021491bc7-6bd3ee01a0dso1361787eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789407255; x=1790012055;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mV+3biq9zwQT1Huw7wIeF3yQxNT8p71X7Oc3cfYRlGM=;
 b=l4WqqL+m6uFeekEWCbDsY5ApnEmEtkr4GkAzqzgB1A4evGnJFaewyngmcQEnSCzLKM
 28LEVIph/SUkaPT1ID3PUlaL6pYemPzSNey/03u+bWFSVbM8WggxcXes2e2ngUBaVBl2
 Fb90Ov10t3Qie1LgJP+l9txk5jcwtzPnurL94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407255; x=1790012055;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mV+3biq9zwQT1Huw7wIeF3yQxNT8p71X7Oc3cfYRlGM=;
 b=OZYTPDFnkdgNDIIFETTqriRmH7fz0BQRI/zJIh+iSMgaivcUn+v5B0YnFD9H4GBE81
 vVdbIwpbgSO9wNW0niSZKXcDCIKFz7oB8L/bLHPETmcuCBDthSNwnVj/FMWsw9v/Ecig
 9WfPjlAkgqN7CO1gfEVpPL92HTF71tkPaPnQaoUfeIBYuzYa0CqxszYqCIM5rU3arDX/
 HsqXrrRzxpqUzXhqcGg8Hp8cSkd2+2IZUf+cIdVthJ5wWA7TQFLh2BsHkESjrT3mcz/B
 6ZFUbEg3nqvlKi6iUY48OB8Tn1aV9ywUyVK6G9+2w1M9vsER2CzlmuEnAqHHHicpuViK
 /O0g==
X-Gm-Message-State: AFuF++lh6r7XBLLgpwRRpEBvz8LwMvQr0BowGpicTjeb7HBMTqZR52cG
 ySpUdfBk4+fzfdPPE2i13/k99sYTrbLy4rcfGzW87QwRgorzTEqMrEE1PaMiL6cboLU=
X-Gm-Gg: AYBFou2mS70E0A4G4Hq07kHYgsNdFjOI38GgtVwC/O5QdpE2hVMnTHz0RjsjHAHmNUE
 X6utnselz2DT9LWpfmooPeZgMotEkJF27cT2sU8y+scm9/Ko2MEXm6cXAMT36cqRJA1/3AagOjS
 eZqc9fp+xod0Ey4vggWY4dOhsY6L5ARn0eENWuF/XnwnCTqc/Ihy4F50EWZ1lEf5NAM898AdfbJ
 fnzFGVTz6ACCQEYhydt6l5PMQZSRqgpXqahElnsi6cIvS8v0r4WpXx+POdI4AuohlVR8eSf1sCP
 p/UwRHzXR4rPh+sP50Bi1QajUOs88WmYK9NZmw/9Ga9um6767TJviKI+HbvJIKxNIPiy4kYcNW5
 onoGhQhbQXdjTQFZNOGNK2SGuQGMrskX0GAB1Nvc4FB8WsSkeqWxiWUcSkCD9VYoP9M66NApngF
 wnV3WnCpgVrtIK7YkHDoDuKgIhhCgvPkafUi4LP/nJ3ZfhS2S5uBaZpHXvUkk4YA5ix6mkqYCMO
 Fld/tInJTiK2Od0IQ+nI9qgsyzw+5dH/ediI54Qoh6QHrMKDipPU5nMIrOV5ovgG0rcnKjtQ3U2
 WJwlj0ELX097BaaP4IkPoE+ajZJtTog=
X-Received: by 2002:a05:6820:61a:b0:6b3:4494:cf2a with SMTP id
 006d021491bc7-6c54214b2d5mr2364610eaf.4.1789407254991; 
 Mon, 14 Sep 2026 10:34:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c0990cc7b4sm11465664eaf.5.2026.09.14.10.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:34:14 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:34:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Eva Crystal <0xiviel@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
Message-ID: <20260914173412.GD1764417@bill-the-cat>
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mg3+6b1ddndw0tsc"
Content-Disposition: inline
In-Reply-To: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Mg3+6b1ddndw0tsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 09:27:03AM +1200, Eva Crystal wrote:

> Hi,
>=20
> Reporting a fail-open condition in FIT signature enforcement. I am
> sending this to the list per doc/develop/security.rst. I am not
> claiming a remote exploit here; the issue is that the verification
> gate silently reports success in a state an integrator can reach by
> mistake, with no runtime indication. Details below so you can judge
> the severity yourselves.
>=20
> Confirmed at commit b4ac71db (2026-09-07).
>=20
> Summary
> -------
>=20
> Both required-signature gates return success when the U-Boot control
> devicetree contains no /signature node. Verified boot is then
> effectively disabled, and the only indication is a debug() message
> that is compiled out in a normal build.
>=20
> Affected code
> -------------
>=20
> boot/image-fit-sig.c, fit_image_verify_required_sigs():
>=20
>     /* Work out what we need to verify */
>     *no_sigsp =3D 1;
>     key_node =3D fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>     if (key_node < 0) {
>             debug("%s: No signature node found: %s\n", __func__,
>                   fdt_strerror(key_node));
>             return 0;
>     }
>=20
> boot/image-fit-sig.c, fit_config_verify_required_keys():
>=20
>     /* Work out what we need to verify */
>     key_node =3D fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>     if (key_node < 0) {
>             debug("%s: No signature node found: %s\n", __func__,
>                   fdt_strerror(key_node));
>             return 0;
>     }
>=20
> In the configuration path, reqd_sigs also stays at 0, so the closing
> check
>=20
>     if (reqd_sigs && !verified)
>=20
> never fires either.
>=20
> Why this is not caught downstream
> ---------------------------------
>=20
> In boot/image-fit.c, fit_image_verify_with_data() the per-signature
> result is deliberately non-fatal:
>=20
>     /*
>      * Show an indication on failure, but do not return
>      * an error. Only keys marked 'required' can cause
>      * an image validation failure. See the call to
>      * fit_image_verify_required_sigs() above.
>      */
>     if (ret)
>             puts("- ");
>     else
>             puts("+ ");
>=20
> That comment is correct, and it is exactly what makes the missing node
> fatal to the security property rather than to the boot: with no
> /signature node there are no required keys, so nothing in the chain
> can produce a failure. A FIT image with absent, malformed or invalid
> signatures verifies successfully and the function returns 1.
>=20
> Threat model
> ------------
>=20
> To be straightforward about the ceiling: the control DTB is U-Boot's
> own, so an attacker who can rewrite it can generally rewrite U-Boot
> too, and in that case this adds nothing. The realistic exposure is
> different:
>=20
>   - A build or integration mistake that omits the /signature node
> produces a board that boots unsigned images and prints nothing
> unusual. There is no boot-time signal that verified boot is off.
>   - Platforms that keep the control DTB in a separate flash region
> with weaker write protection than the U-Boot image itself.
>   - Downgrade of a correctly built device to an earlier DTB that
> predates signing.
>=20
> In all three the failure is silent, which is the part I think is worth
> changing regardless of how you rate the first point.
>=20
> Suggested fix
> -------------
>=20
> Minimally, raise the visibility: replace the debug() calls with
> printf() so a missing /signature node is announced on the console when
> FIT_SIGNATURE is enabled.
>=20
> Better, make it fail closed under a Kconfig option, defaulting on for
> FIT_SIGNATURE builds:
>=20
>     if (key_node < 0) {
>             printf("%s: No signature node in control FDT - "
>                    "verified boot is not enforced\n", __func__);
>             if (IS_ENABLED(CONFIG_FIT_SIGNATURE_STRICT))
>                     return -ENOENT;
>             return 0;
>     }
>=20
> I am happy to prepare the patch for whichever form you prefer, and to
> add a test under test/py covering the missing-node case.
>=20
> Disclosure and CVE
> ------------------
>=20
> I understand from doc/develop/security.rst that the project does not
> assign CVEs. I originally documented this finding in February 2026.
> I am happy to follow whatever timeline you prefer for public
> disclosure, and will coordinate any CVE request separately rather than
> making it a precondition for the fix.

Hello. Yes, please follow
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
and provide a fix and test for this issue, thanks!

--=20
Tom

--Mg3+6b1ddndw0tsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqgwEQAKCRAr4qD1Cr/k
CsVPAQCDKDRo9HZd8CErsxF0utG4kdR8afRgLnP+6QQRTWNK+gD/SYeBHeBQ2oC5
NJnPyg2s5wD5SGcjcg7zry8cykwbawA=
=q5Ha
-----END PGP SIGNATURE-----

--Mg3+6b1ddndw0tsc--
