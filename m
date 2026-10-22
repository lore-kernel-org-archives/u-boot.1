Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097D606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VHos0xrV;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k8li8fWL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C997608C4;
	Thu, 22 Oct 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nF8QpNCuRVhm; Thu, 22 Oct 2026 22:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A80C608AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792708313;
	b=ny/07e+wRia6gfYqmUaA4qWZ+/zgilONMy8Jgbm8LggRA9inNzR9AR0d19u83br3dkpK
	 sbLDInsua0DCiuTY9ua14Uuft7kKTtSsmC5YkoQs80t0THrK7i1O991eierAInXNDFcjY
	 TOgC7OMluauc/q15bvieZ/AGD0WXRnrwGyYDdRWNFcDK7+ofeClqfroa6tpCMFWj7Tksi
	 79zYVGk31xsjx4000lB/7ggA1vgfq406XMlF9vI7aT91puomp/nXoxsxb7BDYW/UVKVxj
	 ixMTHfav1OT//X+G12nKrg5KSO7/aLY07SrKOmsIW8IJpLxARCJMiQhDF9d6ru6t3Bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792708313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Jc5uubw47iVGFbf6hJLRmhpllOb3Z9lcv1B/TCex18E=;
	b=fwavwF95x1nrPji/lFykid7d1pcpLyQHZL4pzH/6W4d/Vhqkj0ImIQh9AM05tR0UFWjA
	 qHG8ZzpRY6/LOlk4CbdNQY7KThLceG1TtFHFKO2mwO7LIhwkE3nAkm5gNyO8TY3nE1rVq
	 nhVBBwmdrt8d9X514B4lyf6iRRkdyZqqxEIPQs9kIanR7cxld2XDyFhznm1Xvzv37QieI
	 XXME8ceYg+qoJBPrwSqe2ngoDOfU83obG6bSwIF5sVcaIvpGjoaCt+HZ6rv/c5C6thk9D
	 tuyLopfYBwjUG7ijbUL44KeQftSyGkNp7qzl09KbmEi5a/janPI7qjrsNEXGsAsnogg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792708313;
	bh=Jc5uubw47iVGFbf6hJLRmhpllOb3Z9lcv1B/TCex18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHos0xrV7NHcLWi7xlI3/eK+cmcgd95+URZJYv+LJffmeY/6wNKBcs4nv5WKqI+R/
	 lp1fvkl97IxAUXNjC8/FoMnaY5OVCWrFy0JFJRD7fJXZ79RV3EyWVBIBGOjT8zYATk
	 6dcLmMqVJr37Took/a2jUlYNvd6CFvG5Q0oeSVE7WmBvWhIU/4Mc8DzjljPVaUc4DW
	 zvKIK7BW6aLcCIb1c8Ml32q/Dqx9OJqRkmR/IhGr0GFJ0QL5gu2T1OfYqzyNlP3GA9
	 RpWYUn/AkL8lMKgMl062H3xkajazm4ppIVeKY4jb1Wb3YdMLv+TNqcRpLkNhIvmpSs
	 s4K3rnQcAMPwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A80C608AA;
	Thu, 22 Oct 2026 22:31:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 096AF4BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF6AB401DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EeVMj-VzSwMe for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 067CF40111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792708311;
 b=P8HhdN+gKWANXCYev7rO3ZoaNafoil4jOeWQcw7R90T8v/7axkO5iO4lYRrfyVs6uT7A
 ftZoAe2ehKDEpXtZA+kakTKwgeRXnwK4zTVTMzMKLJtaQBUzDzRqhflAm+r8TQyEEZBev
 0CxRpi1CWEm3ZZmLwiH13S2mpIT1JPHnEa8G2/Jjf82C+lQHd3kOgTWNS7M+182BKGwQb
 lHqTUfMKZ7NoKJpiGYIwDbAMJMyZFJ+1cq0c8kWIPNpW3tX727TnDDvw1i9fGL9N7Bskb
 vR3y7h9HMTc7u57T3b0KOMT1/fFw2OM4lUlURXN9NY/nnEF48TRoiClPYthbRfF6Qrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792708311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Jc5uubw47iVGFbf6hJLRmhpllOb3Z9lcv1B/TCex18E=;
 b=ljJXzEq7wzzxCn1jjn1gn4aPUqeMu3BFQxCFq5qvybWSkJV2G/43zoF4cGN4lk+CDBEL
 MQ7EohFW0bqaMdKmoAs5ZBJK7J4cyest3UdydRFCXR8HN4mZwL54czTOHRmo1VsSUXv3l
 X/b71xT4ruPtIe9QFpRzrpINeXKT5x5ZTjFLgOtNg9gSojLB3JcEtxngR5d/yB1t0nHsY
 MiD4rVLz1oxFdsl3Vx/weFVwEp4WqftsLTGN3RQlkccOuPePB9XvFBvRH9XT6G3reJfm9
 XFC+ohqMWMZojYJPahrLmQZd+zy/y+gHghJT7zjXIBYx/N0Rl0Ajss7XEreX2q3c9NQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k8li8fWL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k8li8fWL
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 067CF40111
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:31:50 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4511f6a63edso56547fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792708309; x=1793313109;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jc5uubw47iVGFbf6hJLRmhpllOb3Z9lcv1B/TCex18E=;
 b=k8li8fWLW9nB1HidDdlqoOK3KNUhRUrqtuB0MLOAu62n4c3kEhY5f9VfQWkYJhl4G5
 OOZckn+cV7l4kat4tiJQ/InD2vDqm+N2XldRNCZFBLIUMNweFuNUWEEY+As03nN7TsFL
 KX0BmcvwSaufYrq3CWmK/IyLbhgEhs+cfRSvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792708309; x=1793313109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jc5uubw47iVGFbf6hJLRmhpllOb3Z9lcv1B/TCex18E=;
 b=ex62gwoITrghUaqHUW6m2h19FfjeaNA9ME1C3U3rboztQIimrYFsFJ5ZrM0B4uHpJU
 VvPIPIhdTEQipFAG88pm8U+qizHnJ9q2zj2jtN0beT8TZKplvGrRnKrSxryYWxvIy/6l
 lIPJylNYMDuQygm2fpmYi8WtmH1f8nM8wzG59Yj3DKpsnzHSZw/nhEC/H6bCFX+AsFgr
 9KDZdOith8rqXyj4QlqyTyR6616nXpO6IbsJytYfjQuH7RUK46ZGYcIXxaxQqMPWokKb
 AYFxBaJwofDz7//k3cmBxEVym4P70TPV5m+S1GiUOKWzIPWeOcJKFNfvFhVXSR2MQZvI
 FUmQ==
X-Gm-Message-State: AFq9FYIlgV30fQP5iO8URFnjIuCQdLxqTibvRvg6HlSqH72N698tglrG
 7mv16RA5OSi81UVWpATngSAY8WFdajN3Ybgj/N74W+/op78JPpORGaC/RCVESs9/tnE=
X-Gm-Gg: AYBFou2gGzvQ85Lt+V8Prc1GQfXEp8pw+zUUuvJX6t+UqYPMnEySibhr/O+MPZGWCJW
 8h0QV1ZmT/kCOJ4YEpk7GVGTH760IjUiViieuHJejkLS//AlFssts7cQyhVjQSGunDnP7j5fqdc
 Deq8jDPSklaEBi/6sLVvwGUk89newanyHOPHSZMWZWxqGbTR5z0MouT9034BngI+UfEdSO3W4/M
 4L/egKTvw/MSOqBjFnifkFKMkzYKrCp1YPdTSHKxm6hTzW07ky73s1fiWAf75Qmq8zdq7rUVg0m
 Zn08FNTbvFyFFTZjnUJwVZhuc3difJYGumlKEnWY7afPhAERYveDsa181/OwIzvCeGL0hx1wrCv
 gB7s/4UI9danX3Itkxy2A70SG4YcS77e3SGFjkAuOcNue/8KiQCfG45huWksuPt/YRQCFKAcUp7
 JkA9ME41pOBAMg+l0PL+0EHl+FQ3k1zz4kvrrKBUbuCD82W5cKtcHD+xrFT1DIa/yOJRknc372j
 d3Y65RUThTh5ub8A45VfkEornqRTgqnV2lzYZqfFJiYw5pBeaBdZ8LtuDc9rDQq3xgKXg3VCifj
 /VymZFZ4M0SScsQYIXbznjGJ2t4GGZ2g01T/HLToRdBVXz7nKawA/l9X9TGE2ccVotkM7naAfoO
 T
X-Received: by 2002:a05:6830:25d6:b0:83f:492a:91e0 with SMTP id
 46e09a7af769-84fb0a5b7b5mr395497a34.15.1792708309553; 
 Thu, 22 Oct 2026 15:31:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf62c1fsm346617a34.16.2026.10.22.15.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:31:49 -0700 (PDT)
Date: Thu, 22 Oct 2026 16:31:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
Subject: Re: Please pull net-20261022
Message-ID: <20261022223147.GD3596691@bill-the-cat>
References: <76cccf4e-e4d7-453e-a336-46486f708303@arm.com>
 <179269421096.3644272.12264201612618890293.b4-ty@konsulko.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJcdyJMwVyQw1oIZ"
Content-Disposition: inline
In-Reply-To: <179269421096.3644272.12264201612618890293.b4-ty@konsulko.com>
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--MJcdyJMwVyQw1oIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 12:36:50PM -0600, Tom Rini wrote:
> On Thu, 22 Oct 2026 13:49:04 +0200, Jerome Forissier wrote:
>=20
> > The following changes since commit 62c9805d8d57cad407f0295879cc9a6182da=
464a:
> >=20
> >   Merge patch series "fit: use constants for the cipher property names"=
 (2026-10-20 11:13:13 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-=
20261022
> >=20
> > [...]
>=20
> Merged into u-boot/main, thanks!

Hopefully this link is valid:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13679&view=3Dl=
ogs&j=3D95c151f0-6788-50aa-375b-ff0bad3d60b9&t=3Dfb8cd8fd-595e-53fa-9274-ea=
eacdeb5f2e&l=3D501
I saw this sometimes I think on Gitlab too, but the retry caught it as
it's intermittent.

--=20
Tom

--MJcdyJMwVyQw1oIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatqOywAKCRAr4qD1Cr/k
CkPQAQCH2Fa9dkktpcyjZj8jEVW/d0bL9Vr6q4//ticgJC2WWAD/UA4BYydRgm0J
88bQcjCwjkecYaIwq8gh4DXJCxOBUQw=
=V/BK
-----END PGP SIGNATURE-----

--MJcdyJMwVyQw1oIZ--
