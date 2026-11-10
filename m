Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC7606A321
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vkQh1w49;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=c7o+ZCtg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BBE2408D2;
	Tue, 10 Nov 2026 18:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4lj2Y-32oxd; Tue, 10 Nov 2026 18:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 241D74089C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333686;
	b=OsRqWBHkejw8kiPJYgdFRQCKGCidFxaYlR/0FgWkQTTEEslU86+s8WEKKXL1SGiWhgDs
	 DR/tEBHoEgq38uHqHafdCVRT2q5dKexZRDl4/6vD3izryug7E4scOuuY8QSs3X68OLyyK
	 ICneG9ZFE0llMBlAm7626EuE7wEgeaa3wD3Iuw6KOC10wvJVXVET/BRwM/fn1KNosv7xS
	 OTdH1bg4t8ClTZphQjuUUefQsxynpTPgMRRR7j8dVb6qU6e2rcxa79LLcryFg0/8vf9Pd
	 OlIu5QYa9kCRlvneRbc0gYTzczI4latrL0VLm6oEuptAh4Lx98eFOkQHrRZ/SFTSsRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4BmfWqEUt8i49HkamjLIo1tcddFzBmchiu5OSxTFPgo=;
	b=AQKy6Bk2icfPff7K0vtv1VRdDlptIh4mWPOE0wgC4JnPhYxkqkmLJ6uc2YQ67nI0KA2T
	 Q0SVWqdSeUvxvsD9/cqENARMNHirTRTJnre/by45RPg1ZI8h6chXYU4tL3W50MOqq5l9v
	 w/GqIZqJkyoi+8uqdO4QiTkMYafCVKLJ4lk205k41d4mDrVjsNQPRfl2Guf8q9fPQ/3Ut
	 yrX+5kKQEjmvWlkYTpBvmX9lLlxNSsnes0/okGEbqKJxSWDAlFKwH6Z1+hXAIJCLsX8rt
	 zVjm3a+i3YlNrb599Pi1U9Sll09kgXefh+KA6fd0ndnb61P19kM0KqSawcTL8gjf37A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794333686;
	bh=4BmfWqEUt8i49HkamjLIo1tcddFzBmchiu5OSxTFPgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkQh1w49xR2c133W/WQhJDtJA6RJ6iOLZIaVLLbOQKEZ4Vxv7bEQBqrTdJix02aWS
	 jHMnQOO6vrXN28o/BT5CuPjSe9wT8n54qytPUGgomoGtmH2JBBq8gKy/4JaIuOJ8Gi
	 q0cv6frgVPTwq89QA1l6aiFPQp47bqMEgv/WSj/ioG8utVnkhd+aSSayyRP4+o+bKY
	 nG1l01lz895Qr21WSgV9TVGLBOzjdBPwfBDAv8LqKEH35mcI7JtbL+sC4v78Vv2zHZ
	 kB8YrWM82fSvONrF+K17xubV6O+b0IY7e5lae2BsBPyr243q9R1UCGMkQe5Ps138SR
	 PPpvb7n5K0Jvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 241D74089C;
	Tue, 10 Nov 2026 18:01:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38D16388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AACB40328
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDo3prVkc2lk for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1F4BC4030A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c7o+ZCtg
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F4BC4030A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:01:23 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-70399d7f076so926972eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794333682; x=1794938482;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4BmfWqEUt8i49HkamjLIo1tcddFzBmchiu5OSxTFPgo=;
 b=c7o+ZCtgOvXUXOcPAVYkTOT9ngkEBO2ANU7TWibV9TflD8Ey+ExMlzABj7Zeb1XHD7
 pxEz1t0L4kaNH5kT6KbF5wk4ha/JS+Mt7sMpQZgc0QHF/U8adkFnYQ6HzdWIek1bttqU
 9MJES8EcOnVgVw5YkGifHgd1gjGw/gRXCsxBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794333682; x=1794938482;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4BmfWqEUt8i49HkamjLIo1tcddFzBmchiu5OSxTFPgo=;
 b=ZBCzkzplYEsaEE4AzJEiCYqZVOKC3obIaJwP60Fee7fmQpCy823a8mDbtJxg4lqkI1
 9xEIErNSDEkSyt4RMPnz1eGZYqyuruuGUk7OTtSTe2U4D+JxQj/xhNEq8n53pegw8zOU
 rpjrvZwTUK+PcLfu6X2CqRBuJEv9hmB1hst148II3wlhn+SGmtXBh997tSdpPviYFU8E
 VI0RBY4MDa77oqnEOjrsaQlkKdpGt4Q9c0eRcS6uxndV01j2HUgHlVa0mp8+TW9PFG96
 j7w6SYlHyqz0Ayse49QSPkAUaA3rKnm0j6XlVBd5Ox1NlvB7jMlhHZV7m8I5wjKK0AhI
 RdLg==
X-Gm-Message-State: APuU4Z9xpeBr7mw9B8H6B3Pc/QWJE8AYD/OgkNnj2uUnTvFGtqsyMev2
 XDK6o4dHCqEHlvZ3EKqEWEGyz5BnYHCPQxYov9386ocjgSUWMXPYeg9p99x8qqJq2UVU5f8DGPO
 WeQeDxnTECaE2EO4=
X-Gm-Gg: AYBFou3xk3NAoMQcSv3vZuioSYhKICKj3H1FKcRtJb0XoYCIkd2jCIzUaiUa/QULkkU
 GBgnclN2zMi8I0th6Fj5ObYV5TF6fYhkkwG9DTRbgK4MxDjDQulA5N6oLwrxBIWdkOPVN7KpI0V
 7eXW8sNT/wy2WWw3m9UIZkOx9RkJ4E+4OAPdxcbI57A7tLWy5o219sV/qy027dC0+pX2XufOprM
 P3rC/+VSS0kMfZQU+2Kr9mkRa2XvfblKtw1gy7u8R+gt0X4bbFvKVXSwsPFQgYVzSS/vr2cNqUa
 DZDZqd9QOtxw6sLrofGKGrDrhD/2QgqFWuVEMri4oz6VVsSMF1ZBKvTO2bzMx8mg0nOANzdhYvO
 4F0KJGwbDf3WAQAnHxlOvfhQNONJffGMJU1WOSSHKqbK2Ea6XKf7+IT57mbajdMzX2+73nJ75iU
 Ch8bHz0yRh6In4Aj3DCXq879aQv/+ck60ksMu43HhFQV6yg03nQm+6xUWxOeGHYhIdGlQCNzafl
 oxmlA3TeEw1KywAD5/RsNDZlaOnxG+yeRW87aUOT0jHbqhdaXhmqv1f2xH+T99f+f3qG1SxFNHd
 SaMRzsGi/g6aek3/HR1LLE6IIXwv+FJH8zfK4T6bAad9yhEYagbUpPi9pcGHDW9hVCBzpkZ7a02
 iaE52rJzCe0hov4ZLe7F/PS0b+9KAfRXUpUBxm5lGYjmxm8XfIRGysYCgleWPTHU2JCIWTxCfU7
 UyR1IV8JxEOHlnZbcMNOp/0oUi+FyHuGw=
X-Received: by 2002:a05:6820:603:b0:6f8:92ab:bb3b with SMTP id
 006d021491bc7-718a6d2c19amr1731846eaf.79.1794333682380; 
 Tue, 10 Nov 2026 10:01:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a9a468b1sm2104164eaf.10.2026.11.10.10.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:01:20 -0800 (PST)
Date: Tue, 10 Nov 2026 12:01:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>
Subject: Re: [PATCH 00/11] video: Keep EDID modes and DP lane counts within
 what is reserved
Message-ID: <20261110180117.GA241351@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XUynRr7U2ZUT7QDC"
Content-Disposition: inline
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--XUynRr7U2ZUT7QDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 05:28:36PM +0000, Ana Bobillo wrote:

> Much of what U-Boot's video drivers set up comes from the display: the
> mode from its EDID and, on DisplayPort, the lane count from its DPCD.
> Several drivers take these as they come, while the memory they use is
> sized in advance: the frame buffer is reserved for a maximum resolution
> when the device is bound, and the DP link training code keeps its
> per-lane state in four-entry arrays. A monitor or panel announcing a
> larger mode, or more than four lanes, makes U-Boot write past them.
>=20
> Patch 2 makes video_post_probe() refuse a frame buffer larger than the
> memory reserved for it, for every video driver. Patch 1 first fixes the
> two STM32MP2 defconfigs whose panel is larger than the maximum they ask
> for, which only work thanks to the 2MB alignment of the reservation.
>=20
> Patches 3 to 9 have the drivers which take the mode from the EDID skip
> the modes which do not fit, so that a smaller one is used rather than
> no display: edid_get_timing_validate() no longer hands back a timing it
> rejected (patch 3), the display uclass learns the size of the source's
> frame buffer (patch 4), which rk_vop, sunxi DE2 and Tegra124 pass to it
> (patches 5 to 7), and the sunxi DE1 and Tegra HDMI drivers, which read
> the EDID themselves, check their own limits (patches 8 and 9).
>=20
> Patches 10 and 11 limit the DPCD lane count to four in the Rockchip eDP
> and Tegra124 DP drivers.
>=20
> Tested on sandbox: the two new tests, dm_test_video_fb_size and
> edid_test_timing_validate, fail without the fixes (the first one
> crashes sandbox) and pass with them, and ut dm and ut common otherwise
> give the same results as on main. Built for chromebook_jerry,
> nyan-big, transformer_t30, Cubietruck and orangepi_pc with no new
> warnings.
>=20
> CI: the series passes all 91 jobs of U-Boot's Azure pipeline, in build
> 13732 of my CI-only pull request, on main d1d45c926a5.
> PR:    https://github.com/u-boot/u-boot/pull/1064
> Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13732

I would like to ask, given that the project AI policy is "please,
don't", are you using LLMs for your series, and if so to what extent?
Thanks.

--=20
Tom

--XUynRr7U2ZUT7QDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavNb6QAKCRAr4qD1Cr/k
Cgd2AQD8Xaqkcoj5YiVcKo+KEZpaFYei95uJi8MPIOu/IVa6ggEAgBdRNVc2pQfH
UGZ9jK7zh7Ba5P7rnxk2dwHeqOmfqAQ=
=zvdH
-----END PGP SIGNATURE-----

--XUynRr7U2ZUT7QDC--
