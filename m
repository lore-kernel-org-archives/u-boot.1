Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Efeu9SUu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HItlzqsz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BCA60D7B;
	Wed, 11 Nov 2026 18:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqKBk9oHtPFb; Wed, 11 Nov 2026 18:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4577D608A2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794422827;
	b=UySNsP0cEl2XbPT3upj6wNUrEHeW+26BisEcH4gLQqP4fynIGqCqXgtrBXpUcSxjP2JQ
	 0WDCDM5A+kPf4y1H6pBUkAHTvFP3ZiYKEU5B/yJXq7K1hacv2OFXgwCHc03KkO1fwzKca
	 YYIdpKWIaioPmIyHMbqHqfB1CkbakKI/ynn/K0SUWNMD+cFMLVFDrhY4eqTpgUjJ2X6V0
	 RYVpMLSersM8xVxPnFglQUZWGaponWM1yQmp+97l9iHoyzaJpWYWkYAxVDJZAxZUdG19z
	 tQrk3ZqHT5RZUNVQ/mptEJAJGhJN8r9q6LL2PhFk+79SayulxMLMJGrnKPvoaEHIRZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794422827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wtC3N+KE+8q2MLLy+wWSqNEqHuHQVEH2N73FBo0XUdc=;
	b=Pi5wZE/K/lEFhLtX00Ax/tTVl9hjFZTLnCk3iG2nZGM6IWLndCRaTWD9RjHNq554Ya9d
	 AdDdWRWUAViTUE8L5S4SnnKc1bo79sAMQsJkguriwddYwCJt3R3sawhSsF+vglz6myghK
	 HAmcMfokxW1COgLHFsJ/BCONljIn/xkXoBSC6Jgy7Wci9/5gneb6SJpQoYHso66toqdfA
	 4FeogshX3hrtqpgR3mw7NJPUQadxwOAdHvFCM7XLDpWRh/wbyAaNR4AslxpMLSUHlWmX5
	 cYS/m3VVlhjJB9YfLO1f3pKm0Sld8qdlk9HZChPcbmF4G3p+qaMFuoyLpFy/zjKEOjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794422827;
	bh=wtC3N+KE+8q2MLLy+wWSqNEqHuHQVEH2N73FBo0XUdc=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Efeu9SUuFeSSoHXV3jE1+PKbYV08hpOQDn/Q06yMIW20DQZl0HcrtMRhSKxMP+AQ2
	 3Rp87CpKVbSfUhEIuqLGdrby5WPdTDbi5fbCNYnEEaDAz5s2HYIeACU4DUApi4KoRE
	 tQ4nf5UCBOEnIhjS+aO7V781p6M3DHzUQ528EQnOMbvVA09tc/Qhsyi/3YnA8JAkGl
	 lrU+h4mbYbSz/7OdUMyP4TMrL5+aKvGIPHtOgVSz6opjyScE1AQzJiNoSg5uyNV6JS
	 AuWfXUBxjx3bhOaF/mkQdDzykUksvk5i6VIW78gfh7RTIHuEzsL97SX+yFRhXUnl/a
	 xRnAEw1CjDvOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4577D608A2;
	Wed, 11 Nov 2026 18:47:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEDA2335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E01B4404B3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Am0Y5rpl791A for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 18:47:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 02F3C403C9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c44"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c44; helo=mail-oo1-xc44.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HItlzqsz
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02F3C403C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:47:04 +0000 (UTC)
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-6f8a519e215so144402eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794422823; x=1795027623;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wtC3N+KE+8q2MLLy+wWSqNEqHuHQVEH2N73FBo0XUdc=;
 b=HItlzqszUF7K47BAsEg5cqCdde23vU2QIN86SjXmsGMQqR1ziXMVB6bs+Et6w68sMi
 KyncCD9T7IQ86VUkcLqFAi5Dvoo6CIV+5AEdemY+W5hXn1Fh2H2tFtTtViNDO2Cz3Paw
 Tj76yWiAOxqgpHd0nMT6wnpANqfBERwKIuAX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794422823; x=1795027623;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wtC3N+KE+8q2MLLy+wWSqNEqHuHQVEH2N73FBo0XUdc=;
 b=2pzlXNsjuO9nKRaTDNTCdc/ogehcjqNqzxXWatAs+K93bTKJsIuj2EB/BKKCxvA+iX
 f0Zhi7i17jUakdQA/ZDQtINOs6j8DVE23v7xtK3MLh0p2x7Q6Z1N4YTu3g4sUw+BJCHU
 ltjrbMEaBgD6uEG+UumSVqhk1RzE3liVv3gR9iWRYjJbAa10pSxG7sZ+OGOGRBRtmmgq
 nPhOCmX+nu7joqGmHdqQvH4NJkeYYNeo9mWqd5BPm8er/bfbvNDC4xPGkkgBKWDpX7/z
 R5Fy0wGeptza0unpfirTMHvJtmGRZ9T1sPspE+Hd8Nu456VDSiHFVgrV2PklGvGhCRla
 i5Kw==
X-Forwarded-Encrypted: i=1;
 AL+hErHpTTF3oo7laksqAFgzoS6stJkEt596QQ9KI6P4CrapL0kUNdMDdaZZZOd/Q76srELm1rv2Zl8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+7aUQQk/+4Lcp/ZiRX3z5F5BtNw3pdz5vtzTxTG3EcltcERNOk
 cC5U8Y6sfVv6QcW98hzrtfTJDQTdjWxxtaoiVa8+5G0Wpw91fRBu/2mB7odOLR+bYDAviBfkQBX
 1GMiGO28KTnXlVLU=
X-Gm-Gg: AYBFou2grYDU2RelLZhkLVsdp/OzY4xv6aAsQnhdwBilMXrRpryNn2zjt9IlLwgqd9Y
 LNx7znNXSz99ygdFoDn8GvHVArXa7f+xxIpu2Sf3y2aOkv8+/5ud66HFyfSClRa00Sd4Y4NM3YD
 S6BLue4CGHc32DmokaK2ndhCYNxMqhdZGc9mpY+SDxKWc9QVx0W/9/svIjD0Q0Uj4dqGIEUWkqM
 i7RC4VELUPomD4PCEzoN0LioBqrlUveUa0f9ZqryZbXv1C5yVbAbSf7feKt1ebjhUHl0qhaAPCd
 67f6eTYjuC6YZI0la9hERxpmJmXoffLuxAJmS2aEutN0glDbWGutO53mNCuNDyK7QIUIkYWM9Tc
 FVxUry58L8boXSi5PPrAfZ+wBAcGaxk8ZmCfgKsZ8bYLXpStEXtqT20nUdsavnHcXYqY7Kr8JNa
 Keiu28kE7WlBf+Co7k+Fo3AnMuNBXi+8Q8hIiLbkaLIJmS8jF5CYxmWokCKg+QFIunXajnu7xU+
 6ZfYyMgsXjZ9HMJy08d6rfOAYcaD5QQmsPKMzyd2bsFEfLLKf/Pjh4ELSPrlcZQOX3kBHkr3HOM
 +5knAlZuyEcUySlcGK4gSbWReGy29I1nxW0NsumNHqL+WLGzrRm3Z/F5IDzvFUIUOsPc6L/UGYq
 gjah4Bvx+zlb3PI4UEzUatmM0EhbqQ8tAsk9bR0tOhZcdauszQsMpNv5witROmUUSt0hjNCcSKW
 7WyGdHdjc4mkrRd70PQz8VXf3dBrqeSq8=
X-Received: by 2002:a05:6820:8105:b0:6dc:7513:c06d with SMTP id
 006d021491bc7-7197cf12f05mr238598eaf.50.1794422823262; 
 Wed, 11 Nov 2026 10:47:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6b225sm3461131fac.3.2026.11.11.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:47:02 -0800 (PST)
Date: Wed, 11 Nov 2026 12:47:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Enabling LTO for the imx28 platforms?
Message-ID: <20261111184700.GA554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Rt4qT25oYDT2wXN"
Content-Disposition: inline
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9Rt4qT25oYDT2wXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Can you please test and then enable support for LTO on these platforms?
They're very close to their binary size limit and while I have been
pushing for people to look to reduce the size of new features when
added, and tripping the limit here, I'm now looking at
https://lore.kernel.org/r/20261027-spi-probe-speed-v3-1-33e056720925@iav.lv
being a fix that pushes them over-limit. Thanks!

--=20
Tom

--9Rt4qT25oYDT2wXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavS4IQAKCRAr4qD1Cr/k
CgVVAQDmvRrprjc9inH7r+WHN+4du/rTIxWHI5MTcSbc2f/0ZwEArnntCFITM83r
1Xa5BRRi++iM4DJcIWrYUVNuyGoiCQA=
=PvFT
-----END PGP SIGNATURE-----

--9Rt4qT25oYDT2wXN--
