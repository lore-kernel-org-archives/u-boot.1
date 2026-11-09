Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63081606A33F
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JtnsNCxt;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MjXJCEA7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B938D80D5B;
	Mon,  9 Nov 2026 18:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8d3SDnnWNzEL; Mon,  9 Nov 2026 18:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03D8980D3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794249038;
	b=S8pvr7txkLw3lV6zIRe/r0CJSnfxAvF3loSiZVSm5saSAFYr3ZguSZV1tBxpUIcYp40y
	 Q6KbKN5QGA9l75g3iQGoekdE9TCVM9lisFRxs1lmJIR2RfUEtNEmBdvM/oOgDehQBXAOn
	 zt7KlwaxxM+gKabkrn+NCyY67sqZ8jO2SEjKC4hqKVq12Co9bGXVpXYCEj+ieV7BzS0zf
	 Toda3wBZycMpwLz85eCrW+eqMYBdrG5cGJrXGJxgkHZh9kaybcYPWaO9Ynhn2YLYGWIkp
	 PT+C4ID/zbjsNmDbLyQIw7lqI0xVdYAiv0nBh9zsbRrTyQ6QKndsKAhq9dASjHBVzHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794249038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ElFTfFnBuBDQd+TaFlYSBmybXZSd7XUlbY341M5WJmU=;
	b=mFPUn62Jjg4n+3fYePzVMTT9r9mQJ4N5CvU7ZSUFUHoxYr0mwbtwoyvETXjAKsLp6sI+
	 g5zfgxy5wxdqKdAW7jTBIcMhAo50fMKumLml0E7VvL2041eiRceCnkWb2aW5d7GL8EWx5
	 s/uM+dmyW7oSYdUJsdhfyxCOgkKUBF3Fpg0bukh4v6ELFec7KQDk7jQZF7nmQPOFcUlB3
	 3rjBJc2W8ttAmlJZgFuQ0+8mCc3gVnmE9wO6q9HKVyyId7xkcv8yWySTf+25nH61Qe5rE
	 OIqKjzNBTicGXnAsY112om1evVY92Ip78NAYz4t4+2qrKsQyygzBNkhDlr3aB3DbVpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794249038;
	bh=ElFTfFnBuBDQd+TaFlYSBmybXZSd7XUlbY341M5WJmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JtnsNCxt7SzD9SAUdZaV29t7FSBCRwlqgluqHhIW69b2hV278yf1+VthQhurEI37L
	 54kjhFhE5N90vAlDIx9xEUn/bwur1Hfk1Tj+fP7typmzdTTjS+CQNRCL/+U3PEXryk
	 QdY5zfVmB+Q2GH3h9lTLQwENDedbo3qA0bExzbTXD/95NK8QEqu2GyEC2540aMprtY
	 +O58lcmdw1Fut8Qdx+ub7ByPf0Eoqz6n50eMEENw06UnAWhjq105DhIDtFkctyHUQV
	 1rsz9e+SWsbVbMfO1cCxudYn2sSfIGzCRPFk2zMI8Rgh6r8IVzmvVbokhsRgkB0OuM
	 QKrJAk/wsiqNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03D8980D3E;
	Mon,  9 Nov 2026 18:30:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FA7E2AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0492160668
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BL-Ol5qmGWZe for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C3C9605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MjXJCEA7
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C3C9605ED
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:35 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b19e291cc6so920603eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794249035; x=1794853835;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ElFTfFnBuBDQd+TaFlYSBmybXZSd7XUlbY341M5WJmU=;
 b=MjXJCEA7UnVgf9XcZOhQ/moCmAqswajZCHXXO7hI5fXPEEbY5/MFzd1Zy0T3ZR7m8n
 4po4isxQJdRa9ogJtAKFKFX4D74dqJ718pSz4ssl+xlIcI2ZBkfqFjcdrTd6JzMLoMNO
 jvaSMZt3Gb55LiCFMLIV6n7qa2fsSlhc7ywHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794249035; x=1794853835;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ElFTfFnBuBDQd+TaFlYSBmybXZSd7XUlbY341M5WJmU=;
 b=YD2xsZQqB/aPG1uPoHg1r3nYe0DNHyMOYGcCHQ8vENsSR9UikcaFZH1DJwC7Ix5j3A
 MWi7N5ibC7w0Nw91Z6rJmb+iqEfHlKi38SYbUsHmN2SGrQ3Jr6LmcVo1IJF2d0BHbMj9
 yKzNuaejoaJLrTZqsxLbjiBvhodpyITOr4v4+HT4oEDE3uQf07fx05t7BY1f/JCTU0W3
 efHxZLkMEF2lTaPG7zgKYa6GvyYjkjQDFTxDaEBKAy7ipzRnbEYpnGUt/Wv/lI0lvGV1
 StNahganceT/AtqlhLLj5eQGTaAkzPpcPwZvSJmksueFdyPDKsxIKCLbAkyvc6Ew6PCf
 KPgw==
X-Gm-Message-State: APuU4Z9vtRtsAsA/E6aD+05qJbExKjxS6XHrYGLuUeY0RUnAJY5Bkh27
 KAYbRkEsB2B9ZJsRvr4E/TglRL9+mUmNcMES99S1brn8fo0SFNHV/z0a0ul3ApA1MuM=
X-Gm-Gg: AYBFou0da34bFJc3O6sD7h1voK012excSI/mWpOe2xzsuOWb4guFUcZric1gE2G1FPV
 Q53CY6o7c4s2hKP9APwLmWiutNkbRMFFXWGfYOqICAFUleFpgYooj5xS5OYZf5BmHyYpRbSXwiy
 4uURHNQqBOXu7eUUSRMi66zc6f8nW/GZggf2r7akAYjv3uQM8ZUs43v7yUabil2Ud4Xw5mH7Yae
 +/B4q0IlTKKr/FcxdegVTlsaBkVZZBSlBv4RUj23U+gswBzrN+jOjd4jO8eNqVVQzOHqiZIj58W
 czYbsiDhU8mZpZg9IwsnuhL8LWn/LI8kqzKX/svBNuVnP93Gq2CMi8MfY/x270VUZ5Y0UP9800A
 luQidmZa+yT481uvtBrWfekaL0Opq7BbATAuDgRJTMRX2WAUVfCdpAniWBG3P3ORH8sp/8VsxF+
 5Eh4M5pRUlSZODp8mKiI/LNT8i676bKP+XQZNGWFA6msqeMVPlB3P+x/TpIKEF+H9AiNd0jmm+n
 p3/Uqpq3mlmy5DstYS3JaLoaNQXiN6hMqItHNL144qvqu7oK6jTLjX4RQ4jVvCEekWYOXqdfh7w
 Yr6sCnShj0wGI7r6SHAaEqw55upB/jvLbAflUHwY/jC+1RrhcSQKenDmcb0cNZzVd8mhJGmTocC
 CwDPGFqF3dg1Lm/3SvEtQXwCP28js125ykPlb9NlnMnrecAZ4lcdjboGAWfCzvDvSTplGJeHuaw
 a387xx+zW37jyhfOXTgIZHEzeANzi1bg==
X-Received: by 2002:a05:6820:a518:10b0:703:10f3:89e4 with SMTP id
 006d021491bc7-7170f25336fmr1634951eaf.42.1794249034793; 
 Mon, 09 Nov 2026 10:30:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ade695a5a6sm6532923fac.10.2026.11.09.10.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:30:33 -0800 (PST)
Date: Mon, 9 Nov 2026 12:30:30 -0600
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
Subject: Re: [PATCH 05/11] video: rockchip: vop: Tell the display the frame
 buffer size
Message-ID: <20261109183030.GT3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <fd719611-e1cd-40dc-b99a-213e066f3c7f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XhAK1mOalxxsHpu7"
Content-Disposition: inline
In-Reply-To: <fd719611-e1cd-40dc-b99a-213e066f3c7f@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--XhAK1mOalxxsHpu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 05:29:27PM +0000, Ana Bobillo wrote:

> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> The VOP reserves a frame buffer for CONFIG_VIDEO_ROCKCHIP_MAX_XRES x
> CONFIG_VIDEO_ROCKCHIP_MAX_YRES at 32bpp, but takes whatever mode the
> eDP, HDMI or MIPI encoder reads from the display. A display announcing
> a larger mode makes the frame buffer run past the reserved memory.
>=20
> Work out the depth before reading the timing and pass it, with the
> reserved size, to the display, so that only modes which fit are used.
>=20
> Fixes: 7b7ad5c31c91 ("rockchip: video: Add a video-output driver")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
[snip]
> @@ -357,22 +376,6 @@ static int rk_display_init(struct udevice *dev, ulon=
g fbbase, ofnode ep_node)
>  		return ret;
>  	}
> =20
> -	/* Set bitwidth for vop display according to vop mode */
> -	switch (vop_id) {
> -	case VOP_MODE_EDP:
> -#if defined(CONFIG_ROCKCHIP_RK3288)
> -	case VOP_MODE_LVDS:
> -#endif
> -		l2bpp =3D VIDEO_BPP16;
> -		break;
> -	case VOP_MODE_HDMI:
> -	case VOP_MODE_MIPI:
> -		l2bpp =3D VIDEO_BPP32;
> -		break;
> -	default:
> -		l2bpp =3D VIDEO_BPP16;
> -	}
> -
>  	rkvop_mode_set(dev, &timing, vop_id);
> =20
>  	ret =3D reset_get_by_name(dev, "dclk", &dclk_rst);

Just out of patch context, we then use '1 << l2bpp' and should perhaps
now use our new disp_uc_plat->fb_bpp ?

--=20
Tom

--XhAK1mOalxxsHpu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIRRgAKCRAr4qD1Cr/k
CrZZAQDbkcVQb08kWVVQTDODhnQoA+YlWJDQPaHlmkA/ba5eMQEAjImLMGkQZfHn
siGI9pCPM2Wlii1+u1qnCeGbR2RASQA=
=Gs1o
-----END PGP SIGNATURE-----

--XhAK1mOalxxsHpu7--
