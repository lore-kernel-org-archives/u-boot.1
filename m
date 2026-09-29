Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5CCA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 298E2606EA;
	Tue, 29 Sep 2026 00:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSOOYY2cwFGU; Tue, 29 Sep 2026 00:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EC16606F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790642957;
	b=S4C1a2opeNLj/PFYjEfZ1VTFUlwY6gU5FivwQBLOvpWz5d736qE+tY8x0dZkcGK7myaL
	 /FDXCas4jnaLbj6r9w29NAtYphtsPmijfvHidWcqxVgW4CmIcEIDedEkyw2f1NteYEAfr
	 4QYKHcqbs1OAEpxvPTim7rOwJG+45+wwMopAEv6OSxH3wteBQ1+cwud1GKtjANE6aTd/E
	 /oGcaDihrJMfZTIS+WeEwWzfS5rRt56XD1CQxPE1FXMajsnoaY7hxAStRYA7ce2rfl5cz
	 RTn9wnxt/lEzsqJ4ginMLvdbFNIXBJxgh4IA2e/z3ebqJpnL2vlb1Zci7o241rv8jFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790642957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m2KbS9lc6HOLjQ0JH0hgnuId9ZoQ0DcAe/A2h31xI+8=;
	b=Vd7oJy8PaugRRNEoKayrVq4gMEi9jCkdFV6q3S9MjkQwfOQ33h1IMbg9V+Gd6VT56Ntm
	 bPvO43Ton8R3eAG7lWyy8pECSsxddIjRoDtKItPxG4X/wipYuOlibf7b47vJ+lz48l+9Z
	 baaifkOC1TdpB6MLeAIBd8lse3uVXWsc+YwTquRC0kk13ngDqqEFRs/HQaEltSC0hte4l
	 eqrwwzPssyTT7zjLBNFsJzIx3NxKT0Y9wj+fgyT6KQ6csyQJj4gr2uMtQqVsFgr8nuung
	 EB4crE7kMpJYoH8MyDdHHVQdCmVZdZvBQiAMfU2wxMtHQ+c1hsrBzCvYpmp/PzuabgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790642957;
	bh=m2KbS9lc6HOLjQ0JH0hgnuId9ZoQ0DcAe/A2h31xI+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y+A7RGRm7yhRzkVQilHo7NPDoiPqiBLFre0dekBa3Io4y5Za74ek6P2S0EkntMfA9
	 YueFrAMFMJWlD8ZGWxuSXKgD1zyfN8YIQkTvMOFFl/NfCe8dIXwKZ2nOrrXWcEbC7D
	 psXh481fxN+fBIxT/mk/KKN/nXIjLy38GqeH97eYrg3xivlyujECwceNo5oxA0DEPL
	 URVEPVEWi8X7OZFpXacRG3nUKbi7chNlKaEWmOm97QePg/TZvg44zitrx8CUxZhLgO
	 MtKRTecSKrukmfyU2SgwsR1gyovD/6SrAdfLRptipRuupAC/w+kJaEuI9KUqT0kP+e
	 oZrnUHRYOqf8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC16606F5;
	Tue, 29 Sep 2026 00:49:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 150C9335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEE4F4024C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FX_QKPZWm-8B for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:49:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 20E9640247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790642955;
 b=FFl48Tfu3TXxBAoC60CbvFw6Gotxw8a6cIHNXBc4RjTHE1jpt7zG5deNfnNJZN988HoJ
 NT0dyIXViMQ/pyHtOI58SG3/jP3bfqxaXIezpa4xHg66XnLRfDYdv3QYLEMx4EUhh+Xgu
 iAMYN6aVTtlaNtm9wUPjGmykjBPpzX/kHpRTFIkuHrxe360UjwkYOzRFt+T1AzvL0sjot
 ZToNQVIUxOODyRKPVE1CB7iUShRSz7X0tK2gWumwHyE3bkLsTHJPJB/DtbwqU9FHWN5uS
 rDzZjO+34NW2yeegY7PGCN0yPLNoUqrn5PK/LURNQxqS64Jn8tJL+NYFIHYsrPRN8Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790642955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=m2KbS9lc6HOLjQ0JH0hgnuId9ZoQ0DcAe/A2h31xI+8=;
 b=jnrAvHuAYoTs6QX4d0XXoEqtPqt4nlIlgTMcHLeBQF1nKtO5v1A6j9jKI7zjnf4HDKSx
 WZlfbZ5TXI3JYALGujSxSlt/IYNvc+ojqvJXho5C1BhVXVLgJ2XNxbLOVWhaE+HKCSD+D
 IRfQ4GDbysQslneJo/uDC02+S/dUT1Y4yBSGRZgLWYzocFNno5io+Tj4v1YSaW9Z5UYM6
 SoAwKPcyiKl8uHjIMYLutxWMG6annu4iWZUBal1UJ94bejsXNc/HPYVIv6eTVT7D5Lz5+
 RsZPahZt9rTKTaa9zUQM/lIoOB50tbNBb3M/q/ACrHn1m/tYU5WN6QbUupP1N451VyA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="L/e76J1u"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L/e76J1u
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20E9640247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:14 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6d817a94745so1242203eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790642953; x=1791247753;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m2KbS9lc6HOLjQ0JH0hgnuId9ZoQ0DcAe/A2h31xI+8=;
 b=L/e76J1ugKTQyexEY5M9NS8OgbS3HRVjeOGzx2yODLPG0usUc865nPfiP0xbbUofAZ
 QQHtC8laHzJ4hxwNEd8aMry8yQB5Sg+NeOOqdq7ZJEc05M1BNTCIyV/rIQ7tW2pHLjTZ
 mmpzl3VElv9eUJ/gDT5nqJ5JRDbeGz1tyxdBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790642953; x=1791247753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2KbS9lc6HOLjQ0JH0hgnuId9ZoQ0DcAe/A2h31xI+8=;
 b=dmcOu3od0OOuT2+uHMmtjh9mV9Z5/H040LAeZcJHrEOFEMZjVsgRgYO39osqhR4/74
 574HCxub3OkBz4aoqo1jEJGfl+15G0Jbjr7DLlSpUcWuulgRsNaz2mXtkRVpv98mgkZX
 dHC3ug2Vnruw4OY3cZGk1ntYp7tvI01t7ngj8hqcRsK39UKr8ZlFjCP7RkcDAoO6tTs8
 ikNJqxw4wDoeYOpqqGzd/eWgezyo6kjAMyErHtleXB3FKU2pz9VmGfYNLwQT1i6Te5WF
 0MZNMgumu7bHmuomE6kB63FxUxJ6WxECP3Y6dIbRh6i1it9XFtkPVqIgCT1rsMR9BTVF
 Cbwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxHxUt6msfwdj6qPxZ4oovlJw8RxdcMwHVFUu1Xr+P+73/3puqkPzAKv5qxpfneNaMB2EYgeA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kKIKHW339/rcSSlkSdptVEtEJ1N8xTquShztFrhTB5xApqD91F
 nEqE8QrlG7A/eo7Bmtv2EHlcLirxg/1rVYbL9836fEHjHIlT2Ih6CicURd+X7yvy4f4=
X-Gm-Gg: AYBFou2WqAhr/a5Fn0wfSWP/uySXbkmVGHcwkHoE8q3cM3FcjOFLdPcTIIzHpIncBSR
 FlYprPEw3KkPAYYGmcz+7/3f9DHsJJJD+ip7jU4JGTNgNbmk9lHASmH90JbNrTLc+b4f3RkPw/g
 bSEW7BHp8iz2RXzWfOqdLEA+uWzWqM/hTW34k/nUoqHpuA8PuL3mHJQt982lKHt1cB7ZhRN+pG7
 LXo+tUTTQCd8ePrR4gGLaDI/79611MG07o93NT57voyRfpuua6hcoBWG5BWKOyQkDImSzNSfbwn
 tiaaoGAcrUbGlXlZUNckPCXwcbIEZoeBBP/+4hLgFvhkB3EW0tyYDZyqostXUYWCFgkN0rQWR3w
 5jsQ40/4VHnGsz9Z7EVcK+ppuoLOxNLC4phywvyXk7tLEK8IB3367ur/UdlqQEXXtdKiviQM3Ys
 SFEyvavnVUK8Uk9gBYj/GvVTjIW4WN3HfMV1vfCur+wUkO2LS+jaYH24cARyqpM8TEoD1LFUtCU
 qNhBSPNUCqUjm+v480eTe60fbcO0yRC7kadpcz44alcvUZhdZjd4UrPRdfpMMixjF21GapMMWpN
 efwcnL70fbwxsMDxsms=
X-Received: by 2002:a05:6820:4c82:b0:6b7:46fa:169a with SMTP id
 006d021491bc7-6d43ff69796mr13149169eaf.47.1790642953455; 
 Mon, 28 Sep 2026 17:49:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d583f8d80sm3263130a34.11.2026.09.28.17.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:49:12 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:49:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: dwc3-generic: Fix ref clock enable error check
Message-ID: <20260929004910.GZ858934@bill-the-cat>
References: <20260928064053.620519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jjtPm0IANzeVq87R"
Content-Disposition: inline
In-Reply-To: <20260928064053.620519-1-jonas@kwiboo.se>
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


--jjtPm0IANzeVq87R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 06:40:52AM +0000, Jonas Karlman wrote:

> The commit 84de44e5e71e ("usb: dwc3-generic: fix ref clock lookup
> indexing wrong clk_bulk array") introduced a clk_enable() call for the
> ref clock.
>=20
> However, clk_enable() may return -ENOSYS when a clock driver does not
> implement the .enable ops, i.e., for most Rockchip SoCs where most/all
> clocks typically are un-gated out of system reset.
>=20
> The new clk_enable() call may cause USB to fail on such platforms, e.g.:
>=20
>   =3D> ums mmc 0
>   UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3a3e000
>   dwc3-generic-peripheral usb@fcc00000: failed to enable ref clock: -38
>   dwc3-generic-peripheral usb@fcc00000: failed to enable ref clock: -38
>   No USB device found
>   Couldn't init USB controller.
>=20
> Ignore -ENOSYS errors from clk_enable() to restore DWC3 to a working
> state on affected platforms.
>=20
> Fixes: 84de44e5e71e ("usb: dwc3-generic: fix ref clock lookup indexing wr=
ong clk_bulk array")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Applied to u-boot/main, thanks!

--=20
Tom

--jjtPm0IANzeVq87R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarsLAwAKCRAr4qD1Cr/k
CpRUAQCRDsDlZAGxgC0WfxDiSKxNW2lu7F6KxGxIVEb42EgmiAD/cAAfU/OOz0NI
XBJjUndlylQB3Tv9Hjn94u9M0eA9+QY=
=CXIU
-----END PGP SIGNATURE-----

--jjtPm0IANzeVq87R--
