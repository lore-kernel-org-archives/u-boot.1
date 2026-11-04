Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC7606A871
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jfH/Tw0Z;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=t8OEiw5J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93FE66080C;
	Wed,  4 Nov 2026 20:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BhOYmWOD7xP; Wed,  4 Nov 2026 20:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D4709607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793824432;
	b=sPXuiFYvtP/+N+jto9g2rH4vlvDFNixSU4g70ys3LpmhmjOx50OiWUnCoPQCUy/g756U
	 JrLbWzyN7vbDbLG92hWi4LavxnklmONDQXECzMcDTG5Tfp5yS6WEP4zy1XnIqnCD/rFJT
	 WoHHRpLOfCbzzF8aW5jPE6F3OTnudBSJiwy11BoKZNzS0VfZFlaNQvzhAgt5xV3nvK8hr
	 DEEUN1p9oAfmb2DxaLIGwoMoA9jTSpAKRrWEaBV/sIZNI7CVXI/lhN9oTJIgd7hdXbgG8
	 RDoPX8udD8HrwjVcsCkx6tCThju33qNj6eEd2X1yLTitZkqZlssUgdE3HpF1HM9ATOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793824432;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+1/zvmGorkB1Z+hHwOB/l65IAlf+pL5cBCFLgLWiWpo=;
	b=lhWOdhIgVND1UmVH8NZr7a6sn7E5/FqL2W9WyFJeuh4pW9246gjQxLXCCFRXg7Q/M5II
	 ylyVGCt43sg68s+CzGUKm+u3uLwduW6LgTf6ETdaxytRVuWnxX6f5If+Tqt4oDpxAExrE
	 AggZL4NmEUPJD0iWJYtXrhuu9Ed4x9hpHfyCZ0EwqsnSDvv0Eeh+5CSpdbcN4BLyh2unS
	 /4qDjSm+VcX4l28D1HovfX8ugMwKPrKrHWwVA3MPy4uuN49I+6LhHKEswUC0fU2K4x1m/
	 kn90LZFPTGYe03cNd6Cj9A8j33o9fAnNZiY7nF6nBUQ508bLZG7mFgbq7zw9hHnNUoA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=t8OEiw5J;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793824432;
	bh=+1/zvmGorkB1Z+hHwOB/l65IAlf+pL5cBCFLgLWiWpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfH/Tw0Z5NXgxBF023HwotWnq1YR71VDKbWnfxD9RqzEGvHI2dV4bVomLNnm+R8VG
	 LnB3cibgCz2icvOIiq5BiutWzR4tymU4VK4jQTrlp/Q/z7Ra976azVIYpTbP1R8E0Y
	 xnN08kq2UbnFUQdehYO+LV82fLlxTancLLQFeXqcKjURHmQFL0GdZ5iSGQxwpVrdoo
	 L/6GZQ5Z2wuTXCDYLrlDmeK9ywiki0L2QWdVWR4l/9LDTwX4pfbYZgAnk8M7g0bd6c
	 gcbz72Q1MMP55GcAAucGuUSuseARl88AS5xt5Gh6XtFeIMQUTnVqU2EQVuYgxb427r
	 YCCm8/44O5svQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4709607F7;
	Wed,  4 Nov 2026 20:33:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8548B1789
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74A3C607F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qciB6UNz8ZQ for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5D21605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c44"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c44; helo=mail-oo1-xc44.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=t8OEiw5J
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5D21605F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:33:49 +0000 (UTC)
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-716c0217635so888442eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793824428; x=1794429228;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+1/zvmGorkB1Z+hHwOB/l65IAlf+pL5cBCFLgLWiWpo=;
 b=t8OEiw5JEOXVBur0IgqO9v+iA97mXe+7yJEKk8tlpULb+OTwUYixFseUCvrFV3MX0S
 wW+mmi9kRV1cZjfce7hHX//qPKF3rTivgP4OR8m5mFYmIvF9OY2OQKUgOYqfR0Ik9h4Z
 I3Hf8hC4P5cs1z8BL6RW616EeTzJI74GSyq3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793824428; x=1794429228;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+1/zvmGorkB1Z+hHwOB/l65IAlf+pL5cBCFLgLWiWpo=;
 b=Rbqy17Nvnmoq2RtFXnDoztCzLeiO0JpLAkvpJwzaRtsI2DB5biu9aLzdM4BpqkV03U
 t2gkv9O+6qTcivdG/VlenuF2LmFg1/xWmgDKrVXsrypC5PhFlDJadTa/1WNxMZgQ2yhM
 Xga3TFuJIm7/3tZVJAO3REcd+RZxcOIwV2y3WQvlHk9IOlEIZITaopCFjkozlNWUBc3N
 5+03xK10ChkOLpIJ2qmCCtp+l2VztlHklrZ8Nu9b9N/COhk3UA0CnGO66VzKCdJyGxV2
 0lDxMm5kgPI+rfR3c+y2JrsyOQxJNw93OICgUGWToVEUu/e31dq1T7aXI9zIMAti1oeR
 eBwA==
X-Gm-Message-State: APuU4Z+BDK7IibvD28bA+pJKqIpX9P7LTSFSjPlnIZz04Xid42rO0S/1
 1eLDq+xuvJr0+j7zrrCx0GwTUyIYSFoOvNh5V8wKwBZeEwyu2eRMSC0iSBiB8LjxRCj0hgP4n9/
 /fEzCgFpWUy7fw5Q=
X-Gm-Gg: AYBFou35RRP9Bd/8fPYU0jjO0chbrl20mJXZVwUA6x+wOE+aE7iw7bZb6wvC8VM37AY
 Pau3ORiuaOxjjqUaN2LzhHTAZl3T2Umg9bd6/3n9fWHfaQ2H1fn07hQDWje8VNGwjuuixIczScX
 a2Vj7HIBuzTVV/HkydWCpd0B6dqJz6OB4/hQtWz0cmG11rL9S8/i+msgNn7z/3oJf7xxt4VhNyh
 gMu2zyHGWfjtdrsi73aToxgQjGggU8xLEcc5mLBU88HSfduyfMXR4YYDqyqHtsAzW8QDenAQjCe
 hnw44Cg4RIRul0oZztamSG7vqpnWBUfPJ8DIYD9ZYpXKtKEs8/PKbit+6UqR21BDMEviUKibq6X
 4pi1RZ0V5qRyOJzlaoI9+8e/+uX6s5+uyB8u7g63dDmU/wUCLQnnX2Xa3SNqBC5xdEkmzjwjCpg
 41XqO/Zf06S8I8EA3Ab4p2WSBLkUIYzQ8X7Q775y64TqWWK66iF3+4pjxm9vEM0c53SOj9BmeWR
 1Gs8uS0dK3i9yUlUfkd7EWUPib0/g1AsVdAOsoX+bA/9MeE/5NnjgsFUsTtF8tvP2eSkwMV/v7t
 86QMsk4vEY4hC9DdNF+t69icnAGTLjBiR2i6gIG8ZKXhKM/wf3jNQsnL9EoTbJ/37uSxvYFtuvJ
 MMlefyLpTYhBuUghHgCiM1KtlqBfIJ7jFq7fG9nw+cHcmB55Ey6aGSfQ19WCbuPQx4D8MQ3yH1b
 wT0Dz4ouaEv2IPKYl2nlsLN8y6nJqKgA==
X-Received: by 2002:a05:6820:98b:b0:70a:347e:4ec2 with SMTP id
 006d021491bc7-716d234b581mr384277eaf.68.1793824428207; 
 Wed, 04 Nov 2026 12:33:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad58d37b40sm1798491fac.11.2026.11.04.12.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:33:45 -0800 (PST)
Date: Wed, 4 Nov 2026 14:33:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 0/2] BeaglePlay: add ITE IT66121 HDMI bridge driver
 and enable splash
Message-ID: <20261104203343.GA1190865@bill-the-cat>
References: <20260822053237.12169-1-ssrane_b23ee!vjti!ac!in>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pphtje/caRBtFGrF"
Content-Disposition: inline
In-Reply-To: <20260822053237.12169-1-ssrane_b23ee!vjti!ac!in>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Pphtje/caRBtFGrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 05:44:35AM +0000, Shaurya Rane wrote:

> This series adds a U-Boot driver for the ITE IT66121 DPI-to-HDMI bridge
> and enables the display stack on the BeagleBoard.org BeaglePlay so that a
> splash screen can be shown over HDMI.
>=20
> Patch 1 adds the bridge driver itself. Patch 2 wires it up on BeaglePlay:
> it marks the required nodes for pre-relocation use in the board's
> -u-boot.dtsi and turns on the video/splash options in the defconfig.
>=20
> v4 addresses Moteen's v3 review comments on patch 2. Patch 1 is unchanged
> from v3. Rebased on v2026.07.
>=20
> Shaurya Rane (2):
>   video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
>   BeaglePlay: enable IT66121 HDMI bridge and video stack
>=20
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  36 ++

To be clear and sorry for the delay, there's an expectation that these
dtsi changes go upstream, first, as is normal practice for the TI K3
family, thanks.

--=20
Tom

--Pphtje/caRBtFGrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuWpAAKCRAr4qD1Cr/k
CrYuAP4rHEzZJ04hc70c6cepdnyIwhDigLBosA9R30+X4cDwqAEAkAhCjM5n36VC
UeRckm5VsGyyTx9ZA/gDYFvu9cu3zg8=
=VCqo
-----END PGP SIGNATURE-----

--Pphtje/caRBtFGrF--
