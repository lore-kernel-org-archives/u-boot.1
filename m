Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A26CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF7984704;
	Mon,  8 Jun 2026 15:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nrdOhcTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F8C848A1; Mon,  8 Jun 2026 15:28:13 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED148405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso4190236a91.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925289; cv=none;
 d=google.com; s=arc-20240605;
 b=QnEKsAo4t6ZkZ+TYDkS0i5V5GOF7lQztPA8GAi+NSu7gezCoCT6hYdQ9bveCumfGHn
 UyMPjMiBuOGZ5+rLSMcRQT8Sm8z2K/HozkO7CCCDS3x+BcBIGVwS9RvSUk4DYPK6xd8f
 E25CGlUKdGJSO+78D3Ly/9b7rHb5+6v7T/G8lih3KvBq8I1qRWwxcpdMnoOC5hZ6un7t
 zaaaQVTSFn0gZskoAltAygi0AoO6hThP64GsbvUI3+n06BajMNE1DZkGYufuKj+WUnre
 1I8/sxI7rBZEkTRZoyLJWc9cZ8+ZYLnHWPCGSkFZMah0cr1/zhB511LZiKGa6Slo9o02
 4B5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CzbOBUSqOUbZAh7zDCmAcfeKNTzfG09UtjAGVW/J1zo=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=AI90XMmg/nrcHkYxEEAYlgYAzFr43mR+AJDZP6PHYzKWOqQTFeFKPy6JPVZNwwBJCu
 P4cUK6TqvAm6tRisl70NYK4717tUOhuGMos5sev94ZsoxZfC6DzJ/0Had23bNu3dvft6
 X3m3rNZptr7sWIVFZUnehwMZsthL5gK8fZ5lDuwqVM0E8tE4cFkTCbEB+1b1XcC+l1QS
 YnprzaiQu8MY78t6VlJK13w1vYMOaUVTmM/ns3JLHU0xiJwEEBCjB/C5ipJ70YFI4RFG
 wR8EHTyLvMGEe5hdmgEMtNFdp7w8MYsRuDWdZjo97t6Oodw6GwRvE9l7pBJzZw0Imy9A
 wwBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925289; x=1781530089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CzbOBUSqOUbZAh7zDCmAcfeKNTzfG09UtjAGVW/J1zo=;
 b=nrdOhcTY/Rvf2WXMC6hjvm2cmmF6rgJPQRN/HUIo3IxB9Xa1Hkyhsr/cxs8ByrUWvO
 wH0q4DSBU+B2Ink7fFkrBWY/fjHLsukbLxA1+PS90ParQFcaI0M+03UE+0321SVje2nf
 KdKQrTMJkeJ/nEpDMRnCv/+BlMzqlPYnFm7rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925289; x=1781530089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzbOBUSqOUbZAh7zDCmAcfeKNTzfG09UtjAGVW/J1zo=;
 b=Z/dMTvaMwNUgOHDRbBSrRA2f3ME/AGg14ln6MAfsxJSA6g30ThYc3aBuBtjv9ug6VW
 E3KOSIJy67+785jRO215D4a2goItFAROkeiN/vV108XZpGFDTd0oKlaN0W6hOvrwQQkd
 DoBAA4mhfmRiSG3WkedpzaHrJHl1j//w7SHgEhxb9IbC7fh43mWBwZym2MSWCepR1q7B
 X4rKK97LdfafqgODQ1OvaOcZuug/W8O5YENxhH+CH27dL0ftvyN9jGJqa5ZDF7IGGJLZ
 5kpfP0UGQZ5twmnlXWbi7puiRJY9vfjZz+mYufzywsvYo7e+zm7UH9U8fO08AvtVbs3D
 /HwQ==
X-Gm-Message-State: AOJu0YxlmUPsX2QvnTW0VJijlw8axNJ/sA2XkC5BOMPcULX2otXE3Aa6
 b6Dp5j7Kr5PpOjEhmrWw+vM4RaqyZe503hdxdq37JwOPdY4K1a/zRVr9bcUf5MDjJLdJH985l0a
 69EwYsVBt3vihRx06TnlyBNXlC22z349oIK1/RVAj
X-Gm-Gg: Acq92OHmt6cWR5dsR8x7YmTILVKmoz8TmeEP8ku92OA+XIxFz0wC6lVu6Dod/dqUHqu
 gdkz28eIfA9m0QRYbuMCnDsVYldMm5ggMpyHRt9prz5pd2y5rwHJDJ737eI95h3iQPT8ExYw1B5
 At2JvQyBEutdTVUQO7eMZyG6CEM6h1corU7tHbxxzOfLA3NBksUmaP3pZmUENyitctCz5YR8q83
 F/YLz2l5XHx4Lz7KxRajuw6/9n8nwkhqqIujoXNhAnerFOXfBS6DQz71LQqNc2MFHfLtBvW6Gln
 Cyx44Qt0qHIZso9x
X-Received: by 2002:a17:90b:2742:b0:36b:4d63:4a96 with SMTP id
 98e67ed59e1d1-370eeb1bec5mr16786597a91.1.1780925289611; Mon, 08 Jun 2026
 06:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-8-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-8-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:27:39 -0600
X-Gm-Features: AVVi8Cdh9IJRDwRCKdgNSAZiUFQbxCgmdcKYz-AXKLQSFkfKQp_SWyZ4KTPOPkg
Message-ID: <CAFLszTi2PKwpoZ6Gvs1JD=YDx880xGmoqv0H5TynwSt89SHGOQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] configs: exynos-mobile: pull in BINMAN
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> configs: exynos-mobile: pull in BINMAN
>
> All Exynos7 mobile devices need abootimg+DTBH wrapping to be bootable
> from the fused S-BOOT bootloader. So we enable BINMAN everywhere.

binman (subject too)

> Ideally we'll have full coverage of these devices with binman configs in
> the overlay DTSIs but, for now, we ensure there's a placeholder node.
> That way no existing devices will regress their cleanly buildable state.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> arch/arm/dts/exynos-mobile.dtsi | 5 +++++
>  arch/arm/mach-exynos/Kconfig    | 1 +
>  configs/exynos-mobile_defconfig | 1 +
>  3 files changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
