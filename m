Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A7606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N7XdH6D7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PFmWigWn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5867481328;
	Fri, 27 Nov 2026 18:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BI7qqtBBhRtz; Fri, 27 Nov 2026 18:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB4008131D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802552;
	b=AhC4vfY+FayYHYRTG/EjStAhMTm/6oFYXKREJqNoDDU+0tkKMiPSqKigNJz1i0do22Cs
	 QX9xaYTLYG9lB+h3se2DCtBF1zOExdwfxCRJT/tW4CdbVEvpwp6hjt3oNWKGYITe2PqN2
	 wt4dvbQm/dQO0Ofs1w51aiDcnWkjw8lstnWQjrW44Nn+IaKiixaxU3/Q/lMhPLzXTmDDk
	 g4YkL1t45IiHTm2GIw2AQNCJY2zOlEFs/FWQBULGiRwU1qFtqHidYJgG3NuVlrADpicoS
	 Ugdx7+wlDrf9tHnfKzoc3T0b+ImEEeNypNvkP0kO8HNzdLeEqrx3p+34vfV/Fwcy46g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=E/TYLoGIuSTcAsOCPcDzSbLg7K40sXbMT1yoLwP2aFA=;
	b=IjYyX99W09oGcdoLOKODFeleBm1YNCCCUKAjh9in5U3lp3oWiIPXJcIr+Y/KFXjNR9S5
	 HxllzniDU8tqjeskTrKJTr4/EcYOCD9PehTm6GGoR639I5Gj0SpBd1ohTEsL3qDBqmiJ7
	 i/v0L6FzXz/wqJEYs3+nrMtkBqXYWubiBt5bAzQBW5ByAcdmKqBexTc0B04oUL0zDk2oO
	 gVKshC8RCCebzJkFJeQ0GA5fOE5um1JZjGNTnFCaDJ/HNqlvQoI2Q+WC0V0/AzZ+ziJvx
	 mkKm5uxR5fn/KI6mZSDiwUUcHmIkXGjHiqixeJbtHeriOHbmnILzjSbuP0GhK3g5++Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PFmWigWn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802552;
	bh=E/TYLoGIuSTcAsOCPcDzSbLg7K40sXbMT1yoLwP2aFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7XdH6D7VuLu12A0FOJ1YVlCwhJtsMAJXfaL9BeK6uaD6KVxNQOPt1eIQ4+iVhky6
	 Pyh7ZkMBC/fzneu1vieBDq4SXxumTTR+vinb5fWtKAt2P8/Y22qgPlneMDi20ISSBw
	 ndJEXX9keOHdMK+FO2EPnB5B0K9immLB1c+jnFf7PJCJkVyLt6nR5JG8CyE9u/5XF6
	 FXFXBNdAmrgIG401+MEPPfFSjHUBarF/O/6D7EWMzUQlvtY8QE7BEMoJvQ6p81eiHL
	 izUDywe/ngUt+lph/qwVMTdKH/p+EaDn/PT5nnugoMfBSr71Qkog88VkXgXEtOzDem
	 OHZlEXpeTRduA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB4008131D;
	Fri, 27 Nov 2026 18:02:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D1CB26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 212FF81309
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfV8nM5YOZ6N for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2308981307
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PFmWigWn
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2308981307
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:27 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6b1afdf5196so3235961eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795802547; x=1796407347;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E/TYLoGIuSTcAsOCPcDzSbLg7K40sXbMT1yoLwP2aFA=;
 b=PFmWigWnZZyLNua6VR1h+iGU4oKvAf/nvNHT2xxKQSkAHRaszV1+9U1+sof1/XM8xL
 bhVrlC1V9yEnxdcBBI4gmliHqCqiPrWRoKjRogsGqcMGmChr19tQDnalYXRwCBVRmsPf
 o6k/MAJV8ZnV8bjkt5LE3GG9w0Gp90VOKp8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802547; x=1796407347;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/TYLoGIuSTcAsOCPcDzSbLg7K40sXbMT1yoLwP2aFA=;
 b=z6ytwhx2ewz7qz2PDeXpEQ8YET/m9qIy4B1PVp/ddkIh1BZn+x5thDWipUmGRoLpPD
 +wClJ7LdS62zkrakPVdR1g8VmH1py9IPBy7Wh8WFNiW1TLzMpaSLDrLmOygjayDh8G07
 UqtuN2avOGgOiOpcWx7mTEX5iayahOP+R84vj+aQ9J5Yr/uP69KWIO7SRhbmrUvTIYsd
 DfMuChE00fl3osaWyETdotlrPEZ/9YxN7KKM+K0m3lkVyatecxPrh39raG1y9gasJGlV
 LYcQz1iHidUQqTHgVIZY/Zq+O59hUu6CyABN8PbwUaNpk9YphKAl6nqT2byjk5NJnfyR
 z8zw==
X-Gm-Message-State: APuU4Z/zsFvhCbOm7phH2o07kkyZJEDU+XuxyfEST+uujnwTBnbnlRol
 VXEBEnaNezJy9uy+TsAtTdG1VPZZSgpMNjLUoPYgbPg4X9tpvpGFNYeCLOT7hb3cfb1XhaIBrUG
 9l7BkbaCnCjmL
X-Gm-Gg: AZFdTZcRFZFsDAYjuz8lvfu9/w3FBOQeslXT3Y7NwRTsRbiuA5HrBzr5h5MfRe6luky
 aqMK4BHWTTHgRr9nHDQu8UKu0LxS1PmwM65UyzjBXrsSS4VBWaZdv3hl5iT8U7Ba6xfye3eRS+T
 U/+B9fJhH8trLjkpV+qPTyBEJt2VpvOMa+s9yAIi7N4qVnWCqnDhJWdjvQBr7X6G3muVWW2jJtu
 mFwWQ2M5RWdYM7sMo3AwxjSDZ+H4I/zcx98f3MYm7LfogXQONQhALU56OUk6zScy0I7A+G9/Oc+
 aRtWhRaFxHsVj7lkz2atIGDQNStjJ2Cs133RuW0qOeeZWIRlPCKjP+Hvn6ANLYLIrMZk4bSZj0l
 +0aSxd847XJdi4FSXodH5XRGjoTZdfo/fTDLTl8c8FCmH6iNR+Ni1ac3BS7hlGXLcF11qrSnaV9
 y2luui9FKXdpPd29CBWJXdZGjaAKHRipAs7yr+D7FTBYpnfbMGKpPX5otNA2H/qvKKGmheOaCKu
 e/gYaPUszdVFTsdneNysiUg1C1ixI95j09hv0vYVXtJSSDd/DufNwLkprxfQx1T/UhEM2QWwq0+
 WcisfI9x0hCAKK9gB/tDyW7zFgQAV95HU+6z956UVE2s92M9Y1mpq2zFPzrLL50EABtbymyJfMW
 XM1Txlw6w/Kk38ViGY0X9/WnfBEt28rR7EtFZYffvI5oruET6MtI0QeOWygApl+6MdNxolisoaK
 GH2qgCE/GWcXIz3Hj2Y9DbwdUT2FYAWSyi8mKTROTtnGAAP2fdVKEA
X-Received: by 2002:a05:6820:340a:10b0:71a:e4a8:beaf with SMTP id
 006d021491bc7-71b39539c62mr14386398eaf.62.1795802546708; 
 Fri, 27 Nov 2026 10:02:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm21572640fac.2.2026.11.27.10.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:02:26 -0800 (PST)
Date: Fri, 27 Nov 2026 12:02:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 4/4] Dockerfile, CI: Update to the latest Ubuntu
 'Noble' build
Message-ID: <20261127180223.GN3176972@bill-the-cat>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
 <20261127162927.3545062-5-trini@konsulko.com>
 <0f72e884-5be2-41a8-b18c-b5e2b16b7fa8@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PlENobBEJw/S8w/z"
Content-Disposition: inline
In-Reply-To: <0f72e884-5be2-41a8-b18c-b5e2b16b7fa8@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--PlENobBEJw/S8w/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 06:56:01PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 11/27/26 5:26 PM, Tom Rini wrote:
> > This bumps us to the ubuntu:noble-20261110.1 tag and also brings in
> > recent changes to our own Dockerfile.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - None
> > ---
> >   .azure-pipelines.yml    | 2 +-
> >   .gitlab-ci.yml          | 2 +-
> >   tools/docker/Dockerfile | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index fcf7aafade6e..46509eeb7df6 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -1,7 +1,7 @@
> >   variables:
> >     ubuntu_vm: ubuntu-24.04
> >     macos_vm: macOS-26
> > -  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2=
026
> > +  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20261110.1-24No=
v2026
>=20
> The image pushed to DockerHub will not match the one you could be locally
> (you can see the layers are different in https://hub.docker.com/layers/tr=
ini/u-boot-gitlab-ci-runner/noble-20261110.1-24Nov2026/images/sha256-feba8c=
676839085d4afd52fbd88409be3836f73a72ad16a01a5114e3e2640b63).

Correct. There's both non-functional changes (using bash for everything,
for example) and visible changes (mkbootimg is a smaller repo, but as
you noted on IRC nothing uses it in-tree).

> Do you want to push a new tag maybe or maybe specify that you're using an
> image based on the v1 but that there should be no logical change between =
the
> two aside from different layers with only impacts at build time (the
> resulting image will be the same. Or maybe there is? Can you check what's
> the shell that will be used by default when running the container (the one
> you pushed and the one you may have created just now to validate the v2 of
> the Dockerfile)? I'm wondering if the SHELL instruction applies to the
> running container or not (it does say it applies to the ENTRYPOINT
> instruction).

Historically, there have been times where the Dockerfile and container
don't match up, because of changes to make things build (timeouts, or
mismatch in requirements.txt files). I had intended to let this be
another instance of that (I did a build, I didn't do a --push), but as
you note the SHELL change does matter. So, let me push a new tag, lets
that populate and confirm CI is fine.

--=20
Tom

--PlENobBEJw/S8w/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawnFrAAKCRAr4qD1Cr/k
CjoOAQDl6cjildBoM6tmecgCl7YznqIxWl0+Cnz5sZflGdvfLgEA37W1WdLJ7ECr
+MTl25ml8TSZTJW/4R8tVcG6pzshYAc=
=xFtB
-----END PGP SIGNATURE-----

--PlENobBEJw/S8w/z--
