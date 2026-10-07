Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D086CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D8CC60837;
	Wed,  7 Oct 2026 22:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz2-dQfN8ObZ; Wed,  7 Oct 2026 22:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C327360869
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411384;
	b=LrsWfEl616nw5n/su94AYYo2HHtFDztD28p0rwObDwm0K2WqhFmNsRruqBtFr2WHM/ma
	 7J5JiPgs4PmrwImgtdW6LUTV66xMX8he6erjBg+0Ugsgd4sfwXRLymM1m4Gmx1xXv3Tpp
	 t1+T8/dqzwL2c04xVfwxMTJgmK/VPEBv/2PJtv45tloVWX8RlO1dGXyLIaT44fStaIqNX
	 nyX9HjbuSVZ+3RqsVY2nVu/jfUkt7hXSAuUF3Zok9G7wIJz1QkoPgs4FtrwHGlKn8XdrQ
	 +5MOgzYkPUzNox6XvCwj3VcFtRruKYIiVabCrofQPGQEqLhgEgTzKfVJT1IyhWd+4tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9X2tLprg1D3bvV94GSMzt0W6fzS93RuTtREcNa+eGTI=;
	b=MKMZ7GlzALvKbCEx4qCX9lvv7Sm5MnRyWfA1O4dJhKESAe5XivmA/6NlS7zZDcYMsJV9
	 svZI7S4BgZ7xMrOSTet2DCH1FfkdlumxtI27OquTC1oQyUd+/Xh8KuVHXMibzFJ+VL2CF
	 9QkSERq+mFcWSr2iXQUxyVWg7agBsCxxiswGsHJAt/FqUTPiVpewc0MCXo4aTroyKkBN4
	 cCJorpNdcQ7zzNgnUN0vlbAAmWlTk1RdDASZWMsBhdTEPEcdSMbT4qV48bO2X6FYcLLYs
	 /N9yym3b46fDqWiuWio/rXP/pcKlWjwUiOO1LEywpqPvmgO3f5mkVQJTuuhHDdX2HQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eiWjPZAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411384;
	bh=9X2tLprg1D3bvV94GSMzt0W6fzS93RuTtREcNa+eGTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mUZPc0ThDNQHCeTTRtiFsTTRGQ85Kh+B0YZ5VrDFGiJpkTfGUwTTuPWiQ98S9uRQn
	 NgytlXilYaq25WhNslvlhSA/lIjWRCIfJFoLy/ptcsh1jWl3wmBMJBOpZEn1V8vVrW
	 3+ALaoPC7e2y5+K95ue5ueVGCiRKtLg9Y1S9XYqBJyR2Tt3Fiu19USkZ3CPuiqK/2i
	 DS+aqpT892B5ip+H9UQB8bFRBBnmr2M8GtRKJjKiiqH6is9oDfE3Ae4ebyyowu0aTW
	 Ub7Qjb1W0UCWx8qS5qmOmN8ReJOXcA9s8grYK3iENbaHYSP+gqEa/Si6XaCPMZ0gCf
	 zXc9WvfNinNRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C327360869;
	Wed,  7 Oct 2026 22:16:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D85D222B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDF6B60887
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIj1bjf9R4-f for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A3CA860883
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791405095;
 b=PBIBh+dY2XNUkqzNWQx0Zb4x1QUWTCGf/HgRtpv+f8Nq/0w0el1V8s4VjjNqRrCkBOkR
 2OpIJr3DIXKHfqKyO8G2Ul6X+jiub5D8XEH0UwxMJU1GURZImTFmZfmfiVqQHdADNqA8r
 /OYYnA/fT4V7tl7zUDy2wHQhUd7JVvUwxnJjGz5lSCZVjVCTEJsbrOJKjKlSW+ka2/dM+
 wfWKjZ8B9xwh+m/xuwpjFt+RtMxxvuS0creM0+f8vld63lBOefkn3D4Bzs7V6U2S3lc59
 Zswm5Rl9GHKrF70zguiM0l3iRqxkcoeFs/v2JO7LXpMx/rIACD+4ayvXwD6JQmGLI4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791405095;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=9X2tLprg1D3bvV94GSMzt0W6fzS93RuTtREcNa+eGTI=;
 b=fNAOs640nt6yeCCdHtppAusSiEP3upg8I6DuUgdyigEx1n6wgdVLrk1nKO/Gxm9CTo/x
 Rbv5OtPApNQ1lrbaP28mrfRJgCtzM0rvXoypg45gb+PcoZ/iIoe84tRvixHZV+W/HeB45
 BWhYEzkJ3SMwuaHlbq37DFau7rD6Dj20G/x7b21mZkjJ3OJDiUFf1x6o5JHQvKT5BQECp
 F28zXe49T7FU57y14E+s0xZBvV+F4xsNYke4hp+FHxUfEgAKY7XICyqZgf9ZQm0+tvVKn
 pTRobQB83+n5mgj/urYW72Zjl2Dkdpnim/siQ//dKGSO1wiPrVikTXZTS9o5S9upDPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eiWjPZAU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::7;
 helo=mail-oo2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eiWjPZAU
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3CA860883
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:31:34 +0000 (UTC)
Received: by mail-oo2-x07.google.com with SMTP id
 006d021491bc7-6dcee5a2fa8so279304eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791405093; x=1792009893;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9X2tLprg1D3bvV94GSMzt0W6fzS93RuTtREcNa+eGTI=;
 b=eiWjPZAU3x5h/rmCEvOt/A6fEWcfXAm0F9eBju4H/mTnDYfyT5Qzh7qSHwU6CXpwcW
 RKsQIchDzCUVMgOenYtTOvrkeN4P99e+4URf2J2uBC6RJNEITFUCSGsi32w+gp6vc0qp
 zt1WeJTUdVQYJp0shpcJfAGfJ9dwAiBsaWaYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405093; x=1792009893;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9X2tLprg1D3bvV94GSMzt0W6fzS93RuTtREcNa+eGTI=;
 b=JAcewafgLekMuyo3CFsT/Nbc3CjgMB/eAfnPxXq2L6XwbOP0pRxFHSYOhTTF7UV+Gp
 s/qalq3MaK6xw2oEs+/U2a6GTpPKF+E/jA+MBxFVUX3cGofc6AIZKKrMvf7i0V99UY9Y
 cKZYxpGrnzFbAbQtBLr09qXqOdJ1PiHk7pmavpq9Vn1OPLmuINYIJi4rIxaBzZTwOgDP
 MmDVG2tvuRFoijzkzUXp2OC9hQPyUlsyIm2eiQ2MM7m+w6Ra0CNqmMYL0QQYlCpsTLbp
 J+hV7R734ilABbqoKrgxPaf4+Z4TdhZC/fJBLvjdmwfZV7NvvSET7oFXlmcMWCdgm5J4
 LeHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMzva41yGQziItrSTWtxEuOOiEOZM+JXOOTidycaJwtolcw9sI2F6oOAUTsgyXpMKyQRbyPTM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kPS9xrYrE9ivdR33SRT5k1yJejUodOyjhqWFUMsX4o001TRAIa
 K3FLc8aIbIjb3aQhjdAUuomINSacCvrKBm+Mj1I2Rt5hGxtTfzAfKRuMJeY8z5xEw9J6g28tqnR
 B/lu44ACnZ/Bu/8g=
X-Gm-Gg: AYBFou3uOs+BVaCL87XFr5J8ZBOC+BhDm1KKCrN8ylDouWCQqSLI/K49UUtxqRowYxy
 0SNv04FlcpZySeOdf4zYTujICanF2ar750uYvpJ1OFRprVyzQa+9XzTlK3vXSwiQVoeuEku9auX
 vXFSgSGrcWXTk0wftXvuwsBmuSkEc37GU7SyW8okXy0fQtEfjdmHtlMnUuDhRHOttHUWZD1KXko
 ClRQT3OaKK8nqIHsJsz91SpV6Ph1L1Rq9Hhy61ExI6gYWLZ+90mYV8oe+wxTjun0dMm078zosTy
 O0DVfwYvKvuY0nj6FZoGSuCodXO8jOb+m0wUVX0lv5/HTeuZjPnwdMOycEw9tDfJNd3+EEEq1We
 MfeeaYST1Fe3iaV8uepzLOgeugAC1tpUDIyuagXEBcjjFhMMGzHbbVvn3IclX6eT8tNUDdf96M0
 +oKhqzjzGQK2KTei8IXz4ppjHpqCX/byXHLrpg9IPd6j0KRGrIIshf+D98508Mswan0JFE6+Z/S
 7tXUfPWV0tpJjPFAzYy65Ysyb4AZrhqTPY6oo5K37tzs0HIiWuoaG/Ajv2VrQsuKVj0qqSxwmiN
 tfi/HNFhR632CcrC9uU=
X-Received: by 2002:a05:6820:1790:b0:6d8:b10e:dd7a with SMTP id
 006d021491bc7-6eb1ace8b49mr247808eaf.0.1791405093517; 
 Wed, 07 Oct 2026 13:31:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793c6742fsm3020669eaf.7.2026.10.07.13.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:31:32 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:31:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Message-ID: <20261007203130.GF3079290@bill-the-cat>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
 <20261007195951.GE3079290@bill-the-cat>
 <asan7VeJ7QoRDWKq@google.com> <asar1Es-MIxmnyM_@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IW+L8HzB72WzwgcR"
Content-Disposition: inline
In-Reply-To: <asar1Es-MIxmnyM_@google.com>
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


--IW+L8HzB72WzwgcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 04:30:12AM +0800, Kuan-Wei Chiu wrote:
> Hi Tom,
>=20
> On Thu, Oct 08, 2026 at 04:13:33AM +0800, Kuan-Wei Chiu wrote:
> > Hi Tom,
> >=20
> > On Wed, Oct 07, 2026 at 01:59:51PM -0600, Tom Rini wrote:
> > > On Wed, Oct 07, 2026 at 12:42:03PM -0600, Tom Rini wrote:
> > > > On Wed, 23 Sep 2026 21:29:56 +0000, Kuan-Wei Chiu wrote:
> > > >=20
> > > > > Add 9P network filesystem support to U-Boot.
> > > > >=20
> > > > > It allows U-Boot to directly mount host directories in virtualiza=
tion
> > > > > environments via virtio. This is useful for loading kernel and
> > > > > initramfs images directly from the host into the VM during develo=
pment
> > > > > and testing without having to rebuild disk images or set up a TFTP
> > > > > server.
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Applied to u-boot/main, thanks!
> > > >=20
> > > > [1/6] net: 9p: Add 9P2000.L protocol support
> > > >       commit: 48bb83195682d189273bdba813fa67f7f2760d59
> > > > [2/6] fs: 9p: Add 9P filesystem support
> > > >       commit: 9e14f904f8f12cd9df07e99a679453c8782e523b
> > > > [3/6] virtio: 9p: Add 9P transport driver
> > > >       commit: 09e668e32b4c14ce5c929d6cebfac75d2aefb90d
> > > > [4/6] doc: 9p: Add 9P filesystem documentation
> > > >       commit: 7d963df1bc38f5ae070ea8b96e03afc1ef7e23ed
> > > > [5/6] test: 9p: Add test for 9P filesystem
> > > >       commit: d446ef40b87d53ef7ac59ac9b1d79a16f0a065b0
> > > > [6/6] MAINTAINERS: Add entry for 9PFS
> > > >       commit: f6002d5e8018714ca80dcf1835c230c99c5090b3
> > >=20
> > > Are there special permissions required for 9p to run? This works in
> > > Gitlab, but in Azure:
> > > test/py/tests/test_9p.py:46: in test_fs_9p
> > >     assert test_file_name in output
> > > E   assert '9p_test_small.txt' in "9P Error: No matching 9P transport=
 device found for '-'"
> > >=20
> > That's weird.  In theory, no special permissions should be required.
> > That error messag indicates that u-boot didn't detect any 9p transport
> > device. I'll take a look at it.
> >=20
> Azure currently points to the github mirror of u-boot-test-hooks,
> which does not include my previous u-boot-test-hooks patch that adds
> the 9p device to arm64 qemu.
>=20
> The following change should fix it, although I haven't tested it yet. I
> can submit it separately as a formal patch.
>=20
> Regards,
> Kuan-Wei
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 015fc15d5c2..93bdbf4a4cf 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -251,7 +251,7 @@ stages:
>            # the below corresponds to .gitlab-ci.yml "before_script"
>            cd \${WORK_DIR}
>            git config --global --add safe.directory \${WORK_DIR}
> -          git clone --depth=3D1 https://github.com/u-boot/u-boot-test-ho=
oks /tmp/uboot-test-hooks
> +          git clone --depth=3D1 https://git.u-boot-project.org/u-boot/u-=
boot-test-hooks /tmp/uboot-test-hooks
>            # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with=
 NET_LWIP enabled.
>            # The test config and the boardenv file from qemu_arm64 can be=
 re-used so create symlinks
>            ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf=
=2Eqemu_arm64_lwip_na

Ah! Thanks! Yes, please post a proper patch and I'll grab and push it
out.

--=20
Tom

--IW+L8HzB72WzwgcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasasFwAKCRAr4qD1Cr/k
CmuJAP0QQxlOiYWA3YES4WUn/mChoGy1o7ks5xr9M7TmuTBXQgEA3mQgsWmLKDx1
rpYq2mO2IHV8KdRLfy+nt7H2sOzaQAc=
=ARBb
-----END PGP SIGNATURE-----

--IW+L8HzB72WzwgcR--
