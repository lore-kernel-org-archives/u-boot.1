Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE94606A336
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zv6LJR/R;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=plLhdRD2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34B4340695;
	Mon,  9 Nov 2026 18:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqKX0mKcC5DR; Mon,  9 Nov 2026 18:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80EF9406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794248205;
	b=l0fwePJvUnV7i6AikWonpLiGN2V3nDwtCbWxwEAS5lBjxRoFR+oaI3NLTFUrUOKRqCNb
	 m7Od8WtGgggDHrEMcGiH21O3WJXoAb8raV/FBckakXxAvdeOx4oJ9gxYyxOeRifjYTWkE
	 +5APHshSdklWMuMyTVu9VjngTSaB0e0HWdSj/6IUcM+DNIKZEetuFdf7lPcsmelzQGwtm
	 GboAB4CQTU3HslrwhYSQOqTvloxL7KrTVxHdJUQ15mTc1sbe54vhA432cXKt7Fu5njxXg
	 PU12vnDMMhOC3UB74xGJMyRGJehrfTwk0HRLh8IqUCHv2wwckdXrhlCTsDQaB1/1c5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794248205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2C7jJkUtbJsnTFX+0nwLHCEaFPtLKUiUuFguqnxtsr0=;
	b=oucPNIS12mFK5sP61WJOJvhCfYgLM6rFlbx1+ENd8/uyL1v3yyqlUQ/54fsmmrDQDD9O
	 Pn3A9E7PeKYtL3RDr7mjErpEUnaaDzWxAkd5w434hbtXPe0rTXKBNNVBzxSYQb8z6rPs7
	 3iMAtmvVmNtImnvqMqSue/NMrGNszcR2mi2Dt6xBFAt/g/rqxK8hE5ykYxWAhAY0tBnwf
	 9XAWoBEyGC6AWevuhUNjMnW5CHsqJ6VSrHe1bmc9iBQ/Y/x4z246GTFu8FLRJ9NwTpiE/
	 N9NHgkNFrWxXY9RuuRxDgF3saj3rQqEtUx9jxTWnxa08FtkqKU16mqJB0K4ySTNlRcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794248205;
	bh=2C7jJkUtbJsnTFX+0nwLHCEaFPtLKUiUuFguqnxtsr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zv6LJR/RfvqZ+pAZc+tLCbq4TZQ56KlChpPVtws/3FGOEn/bRjHFSCGD5+OyRXkLY
	 Mg+jzBRf/g2hxQsgNLoZB2NdAVFZAzn3zXAkAQFc5cn+50Vdi3B6f8TmY9+QTK5e/C
	 evxLJ4Nrrv7wmLDL5bk8dB7qfAReb6xxZ1/45KhjXtZzqURB86+AeqtRe/adK8wF8j
	 x9VDGk6cloE77ptFIzGuLN7luoF/tD5Y1W/U6o8k5CZ9LLce3+xxla49urkfxlFfGa
	 R+p5hzEc5AyEOUXD8UNPH8uQWVhDomqwCyh3ehaSjUFv9cFyKtVaA23HsUP5xVoEA6
	 Z2+E50XFRNtnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80EF9406AF;
	Mon,  9 Nov 2026 18:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A6B220B1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3E5980E1E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkFhBcoB19TH for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3443A80DBB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=plLhdRD2
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3443A80DBB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:16:42 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-84621d8c7aaso492722a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794248202; x=1794853002;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2C7jJkUtbJsnTFX+0nwLHCEaFPtLKUiUuFguqnxtsr0=;
 b=plLhdRD2vJhwSO6SMY9qVDQWLnh5vsppyK7Nak4Puadnk+SUhET0AX+/eLFG6CJ/NV
 KyFodOuVKDOYJ+WC0D8Mi+xobd9NNSFv2UPJYumacLVfpcGMR63ZWxdYHjiaPMOCzVjX
 Ex87p4iVwRJNJtz2qFdMzsSpVJYtFRXq1NIpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794248202; x=1794853002;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2C7jJkUtbJsnTFX+0nwLHCEaFPtLKUiUuFguqnxtsr0=;
 b=pxISZ4JyQwUJ169DLKoa6u6/Mqwj6kFtbTJePrPnGnit+n6uU1f4JP+T1JW5VzKPzq
 +4iCV8ILxL6lFaPbFbrsvlI7QWzjC6SjNXQxxAOqF1lPiAKuMVI7JUwz3A0a4Ckkb9zr
 j1pDANkbXp4BNKrQ7E/AtIkdddyX/6TWtRPtG0ML6ty8BvPwtA9c1QkbQA4/AV1+6UL0
 tv4u1VntBdspitippZ80Tv0THSovJ3mUEnVQw9zolWA13/4NgsJiL6MtzHgFppDyJ9d1
 mkocZjBePXyabkdwlj/SuB84fxXUcHLh3fVU/LB5WVwVuL+NB5e5jX7G5S4ni+Stkvcs
 2n+Q==
X-Gm-Message-State: APuU4Z8U/PppgHsLkeWyocs+NPZPfXKeLokehJV6IS0vEZYWvJ/xCEPi
 TtVE1iZ04MSQq/I7GFmrCZtAvfemBxg9y3YalM1Bs5pqssF9ikG2Pa8lUCH6snxnSFg=
X-Gm-Gg: AYBFou3DioJBnSESRYGHgaBe101rpAIOWBLL95qWijPisJq6URGZR/8wRYEMnk9b5oN
 0IdUxx7YKTjahJPZyh6igGU+D0M7t+rCoGxuLnb/yAq5r7MxogbonwVZzdqsTvq7n3uKRDvmLQl
 fIJM48uYM+PcOKvaMB58oyis5ypTP8TvNVySw1Xhj+Ce0KsBhjWf2wKqKHRFFp3RyhRsihBjDC4
 l8e1MCkMr2Uj5IDxZpkrGW0X0E2e/PJ6XWwCXyqIK0C9xcqMyBE0N40o1VfrFjfDF11Z17asA6K
 pQbyiG3qyWVaXpt0xZf5b9Tb1CaiqLaLGPXiMVE7f4gAeH9FVpz3haEu3s1xrHLaO+inD0zHAQy
 TKSpRZ96U4pkVrWjpIWTsbm4itR/jwXv73ElQ1TBlWFsbWWPaNY3GQzyyscOLjLKeg8lqaw8zJz
 3aodZy6Y5OPOv6Bftz6bG7A19PIyZStcm58t/dJrRgkcm4H9OVoA9y6f3Iuce5pFPCgmjiOpMNA
 b6RP7d8cxYPY8qJR7zwGUJRN0zBcX5G+H00Rgieq6YF/WhYXTF5eWRcJghmaK1MmARb+V+GTYFs
 4S01ibjKLnHFu/F5AMGNGOEDt4jc97yLBBxWQynTgr8IQCVsIgR0NwBcOM49lOxhnDF1s4ZnrUX
 AqkS+AxxhLaas4509d1OkhjZc0KWd/11eRMiMX8DYhrj8uXWnKJOOoyrN9Zy+xF4ObW/CRjlKOy
 QDMf63K25RqDynbyfgbhoYeMBIT94rIr6Bzzm89YIyqax1wl0pmnE=
X-Received: by 2002:a05:6830:b13:b0:81b:9d18:75e with SMTP id
 46e09a7af769-860dc606f34mr82820a34.4.1794248201874; 
 Mon, 09 Nov 2026 10:16:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db84824csm295396a34.16.2026.11.09.10.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:16:41 -0800 (PST)
Date: Mon, 9 Nov 2026 12:16:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>
Subject: Re: [PATCH 03/11] edid: Leave the timing alone when no mode is valid
Message-ID: <20261109181638.GR3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <76cc4bd0-52e7-4362-8aff-489f17df1466@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2rqLwKBjL29vXOG"
Content-Disposition: inline
In-Reply-To: <76cc4bd0-52e7-4362-8aff-489f17df1466@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--J2rqLwKBjL29vXOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 05:29:11PM +0000, Ana Bobillo wrote:

> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> edid_find_valid_detailed_timing() decodes each detailed timing into the
> caller's struct before asking mode_valid() about it. When it rejects
> them all, edid_get_timing_validate() fails but leaves the last rejected
> timing behind. The Tegra124 display driver ignores that failure and
> uses the timing it passed in, which it set from the device tree, so it
> ends up with the mode that was just rejected.
>=20
> Decode into a local struct and copy it out only once it is accepted, so
> the timing is left as it was on any error, and say so in the header.
>=20
> Add a test for edid_get_timing_validate() with a mode_valid() callback.
> It goes in test/common, as the code is in common/.
>=20
> Fixes: 1c1ed441b0d1 ("edid: add edid_get_timing_validate() variant to fil=
ter out edid modes")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>

I'm a little confused, sorry. There's two drivers which use
edid_get_timing_validate. The Tegra124 uses it, and falls back to a
hard-coded 720p on failure, intentionally, and seems reasonable. The
MediaTek driver sees the failure and then turns off clocks for the
driver. So I'm not sure why any of the functional changes here are
necessary or a good idea, can you please elaborate?

--=20
Tom

--J2rqLwKBjL29vXOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIN+wAKCRAr4qD1Cr/k
CtbvAP4iVckWNZSaF4Hp5HIcRaAjeBqEbo4mfK6fzn27L7hv0gD+LBoHdLmTibaU
WK2bMivlJ+51mrgxAEkRcHBVZjT+HgY=
=WoDD
-----END PGP SIGNATURE-----

--J2rqLwKBjL29vXOG--
