Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD23C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26790605FC;
	Mon, 14 Sep 2026 20:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtNMk54mCawa; Mon, 14 Sep 2026 20:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 709646062A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789417723;
	b=A1iBYzOoMWD/3X9DS11Sv/se2zSaDoZ7iq1Nr1eJA5uA3ekOHjby/wawd/+PRhxV0CQb
	 YhgDxZWXA2UszbyUD/bi1CJkuFIchFFxKzciTxukGamgAxPnJmlRLhOgxM7RrO+lObbIJ
	 kq4f4A8bd6vg+tqDGQ3vvGVqOm/t4/tSv77/jWc9PH/ie9+fJ01kLzZ/6iTNOBXvzS4M2
	 JCcrHgZ+OMc2aI5izqknLJe9d0qxsOvHUWgU5i4NkcTIdCW3Y8iiJJTIeXp7YynP2wsIY
	 dSvG7z6z1IIdvSlymjyaAiX6I2rM2q1IqMOv+okm4+A0KyAQs/sptXM5CAkdkxcjemA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789417723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zBHlLS/PA1iXJAmfZErUXQPpax1nDr5lenlxldwL51o=;
	b=fEJNFaBvTbFoRpOqxTIZ+/PGrHdShsf7jqvwDaqbbul3gOgG2Qt7e4blLawN0IoU5xw+
	 w8T3WA5xvQps72LxAoJpj5aGUx19zCMPfS+g2ItTBeeuLqRzEC4icG68PoXDv6/gBg9Xa
	 DrOBXgd8Zy/TFAbyuB46KYCOy0lBSWXJe0Uyw7UVOTrZ2cpssjqiHXU2PPDzSQD4OTjy+
	 9cLE83Y9+dF+NLSKe3UMv4CXIkUKGy1qViccDTcQbP6oW6fAnc7NEc+S1RH/iM51jk3yT
	 wfb6GwE6ewoL4uJo7+p/LhNXeEAmNbN/DiBkflcur8t4JY0nsSH5HxfKRczUGputXjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789417723;
	bh=zBHlLS/PA1iXJAmfZErUXQPpax1nDr5lenlxldwL51o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NoOiCtvXaD1M91oxsS2jdpz5wxAV1WKJRepv4jB0g09kLjFp9YYNZsCKmEZN0XDuc
	 /n/sjevJUKbOO4/UR1PnGMoL/uS/uHUJbrTCS4xHWgZ6dLkA843+bEnEulSyc5PBZH
	 C8IQV08nQZ5ppuSuETiEXeMErkhoWd+6IlhkPOicIZ9UlbcZCAySYRMoPYcdUwKbsV
	 0DrtpfvHhUkqde1aWgTifoa+X+WZlqojThBS2/0Y6HWI7SdhXRERbzE24iw9DYArlY
	 6IbQBcnOKup0D7FBrSM1JNW+FSoIDBOFAS7HFeY3sPlGph1Bncs6bNqWdZKhxNv2X8
	 RCujyStW/sQcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 709646062A;
	Mon, 14 Sep 2026 20:28:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B12AC493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBBA18083B
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HP2XhNDwIk9o for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:28:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D7F98081D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789417708;
 b=cUAe/NcOTbQJMJ6pBd985gE28owhgEMZuc4uqHflOdy7bqdMguVfRuV7fey/2xBI2Tiq
 0DxTOpHGyC1c4YHSM/zpih4OPO5LaOY72GFbVajqvfJbJcFGc9HNTn83LxNp2iYgUrerg
 pgDIydTtEl2Xq+lTxSkoWNnu3/sdCsjFhrEd/jmmPJFgxiK6XMDnML4gkPsaJ+htSLg0v
 WCKDkgFyDMaZv5SvPQtpBDR0R2FyVLC1xSnMJ9Ar3FLimVhJNPaMOMK/LrbGSV8gs9muU
 9x1x6myuIaifsntu/QxnKCdJuT3vimdlBKDYZn09g7S8cM/T/waNek6HZmr3pdE0fAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789417708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=zBHlLS/PA1iXJAmfZErUXQPpax1nDr5lenlxldwL51o=;
 b=P+V7rPolGE6zdUoUrGI0HYNXGyC1czeIjlo/A5MvZVR82xe0v+MSHYZtuAAxaxsG+ydl
 f5j2cPzY4o90Cn2NUD9Qk7fQfLJgBBuijtfzcMgCyAGEYI5rLs2kdbV5RnkZN4vO87Gc0
 T7EF1p9HkKtBXaBp66AuU5U8RYXCj9MpyxmxfZ1UDOVkXpLSitiQrPXEv0mRUDs6oOdTm
 UlmnqrHBwmm5srI0ya32c6oI4KUqviGiR2pz6jlbR1fJWJ+iII22lG6plf4yen9vWP9Da
 /dFTAR4DtC7ozpkRr7058M93DpyirAUWdvNjesFe2V/9g1WfgON9GY6VGbvoJxB0A1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="fYZ/oUU1"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fYZ/oUU1
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D7F98081D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:28:27 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0dd550aso651042a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789417706; x=1790022506;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zBHlLS/PA1iXJAmfZErUXQPpax1nDr5lenlxldwL51o=;
 b=fYZ/oUU12r47Fq27JctFJm7KQpCBSxinK6BvcmQxG63s7b49o13SnRmj4BU2s8xCXX
 nYNc3AB1/vS0cnEnTgHLpgQ9uIRAL9tZBCNL3eYN9TTzInEDVmgXyqCA0WzCaMUFLDUP
 aDxbFC18BvskdzQiMyORv7UzotOvueUEBsBr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789417706; x=1790022506;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zBHlLS/PA1iXJAmfZErUXQPpax1nDr5lenlxldwL51o=;
 b=k1IX7euuJBbD3pcXakdr30/WS0p+PIXauQl+6LNJKermhNo/RzP2A2RMr8hOrj7aRf
 PEP6vDfJ8Mx1jTL6YSxMiL8aOmtQSM+V1B5HQ5qHSVL/B7QYki/iAINc1MVIoArlBlxw
 Pq4Q91/wB9R/n0cHUPmuq+BPBK54qt0cxMw5+SXlzFoc6OKMbLXtGQxyF1kCEp7Ba3g1
 Q2W6bt74UkTSFyYdLSYBFQ6q5+LJ7DqzyTpm7QZ+vmT6GyRvdJKLj4Z2zlASSg6HzRTB
 C+82sTfIDttMo/9oVWh3AW8uMRRtrXi/Wd0uFWRK/lWeh3YNsBnN5PMqxK62rs3L7vuw
 u4NA==
X-Gm-Message-State: AFuF++k+POmXg57/IbCSSpHeu4gqUf/Bry6g0AXfa6ZU2JWnuufEQffF
 Qe/t6jR1E2kmW5rYshZmTRikCaTAC9HuVd7b/A7YCwMInnJn9PLwros+qB759V5vGUGh8UNXbjx
 R1GN9CpoNvGJm
X-Gm-Gg: AYBFou0eU8TCFtkDvZq/9/EG84sEAQUGIvuBZwq7QwGDAtQgi6kf0pxmLik/FCSv04d
 CeA+e/JYaHz3Hh94L2GT4vKOdjtUxikMULknnpYh2Lsj6HRTOqWwXeSbmmMAKAwtpcA52wht+D0
 7RVpH66xa05lDZMuygwGfkYKF1LAL7DyEz84p9Oe2sqT7K4lZ41LC0C/brchlWTsYbbOt6r0zu9
 65zbKRLXKgUS/vy7Vjx8ouc+u6ytbufx7wvBfPmiqzeHD/X2xKNFfDmnlzZRBAIH4I8FEpH58A/
 ye3tGwFFUmbUNf42WVIkmOLIH0aix4qXPT0/X5TC3C4lg6+PWgc42KC1rOeXT2tDoFJ+aDR63Xf
 PBP0brtyniq3ttc57iPkVewYTWzrySV8pH+O/OayOdvy+2OLigTjzkk1wnJLU3oOIzTt8rLasGi
 Wk6JTXsmGsMJk3t6rhJDDGQB2pM9iTffOGB6GmybHexeDAXrP09WARk6SZNVlDfD9IiRR48xVyO
 Ji6CHBHssFNlHsLoTAdnC84Zsn//BwULRGV7UnbO62BbbmbNuqxdu6dJBwSMKIHSjPCK88LEsja
 76Hn3P2Xk3srSQPAHl5PIQ==
X-Received: by 2002:a05:6830:25d0:b0:7fa:ab72:9df8 with SMTP id
 46e09a7af769-808992661a4mr3164215a34.16.1789417706659; 
 Mon, 14 Sep 2026 13:28:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm12083289a34.11.2026.09.14.13.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:28:26 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:28:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>, Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Denis Mukhin <dmukhin@ford.com>
Subject: Re: [PATCH 0/2] bootstd: rauc: Fix stack overflow with over-long
 slot names
Message-ID: <20260914202823.GF1764417@bill-the-cat>
References: <20260831142800.25966-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5rBFCh20enKY1jr"
Content-Disposition: inline
In-Reply-To: <20260831142800.25966-1-aristo.chen@canonical.com>
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


--G5rBFCh20enKY1jr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 02:25:38PM +0000, Aristo Chen wrote:

> This series fixes a stack buffer overflow in the RAUC bootmeth. The
> "BOOT_<slot>_LEFT" environment variable names are built with sprintf()
> into fixed 42-byte stack buffers, so a slot name longer than 32
> characters from BOOT_ORDER or CONFIG_BOOTMETH_RAUC_BOOT_ORDER writes
> past the end of the buffer, and even a 32-character name overflows it by
> the NUL terminator.
>=20
> Patch 1 builds the names through a helper that rejects slot names which
> do not fit. Patch 2 adds a regression test covering both sides of the
> new length limit.
>=20
> This series is based on next, since it builds on the recently merged
> "bootstd: Fix crashes and memory leaks on scan/boot error paths" series
> and its bootflow_rauc test.

I'm hoping for some tags from the RAUC folks on this, thanks!

--=20
Tom

--G5rBFCh20enKY1jr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhY4wAKCRAr4qD1Cr/k
CnDWAQCsooen8kdoiMvV511eI4yh4xV93NHkid4rddlpRSJq7QD+LJPgw+fNNLQ8
5xqD5IZYyPCpfNfFf3cdVc352c7sZg8=
=UA+3
-----END PGP SIGNATURE-----

--G5rBFCh20enKY1jr--
