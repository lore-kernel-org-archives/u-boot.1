Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45774606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZoRJldzx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GwJZE2EO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6CA40985;
	Fri, 23 Oct 2026 14:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bn2k4HmdKbHt; Fri, 23 Oct 2026 14:01:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0168440978
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764065;
	b=bAQZq7qyIARYLSqexPlBqdJIufWAV0Zq1ndhEE0JCcewBf1QEmvBpptzoyw4s/GGrMKm
	 tXDgCjCQZpwoO1PPabweZMNU0nuCJhc0qR2Z9FzPvHeD9Ws/4uBDwXqEXQYeo6SkKTKnQ
	 aBCsQ8XL8IPrX/f3U6AgEjyota/QbAQJL7PlUK3ClXZhS+RMUPep9mqNzBDpNbusIUgHN
	 qpO0M9kBHUunJpd3FsOxVjzXmvJryGwv6NcwjIeJcF0Tl9X6uYmlawFSZq5JL/ucXH5Md
	 6qR0OouPt+pbvLF2shxQ82e/BMTfrhO4Bmv4nwoR5PaiU8a0wQ6b23x3i8AAtE1lqbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792764065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y++2jVSCgCkgNlDaNg7NO4Z3LSzI/yTCMIqxSb5Y7NY=;
	b=OmCCHS/JTdhrCZCja4Asiu6gmQhGHnalz+jdDe2XU3xt/Q71pr2z/zSkYN2Z99XtuGln
	 vcXsHs5YXav9dItnw03m8W6cMHCS1ELS4fh6twWH+/05wBhfTH50IYPwyMWBhX7X6+QLm
	 RtexpdS9j1aDW3zQdRS/wMa/wWx3skBT0ws4rx2YzqIr2vFyWf7mBuTyItLJ1vUO+g3VN
	 VOif4B3KLvfY+qeU6Ol6Q+Oa1KSEN0fSW4xYhyWnw9WygBXEpeQCu2Bh52r3ve/G+VdtS
	 sQoCM7n5Q9xY3zEBj9uggHz1gU0ckgfNeK976K6bA8nIUyUz7A7y8HVIgH+iLHkZk3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792764065;
	bh=Y++2jVSCgCkgNlDaNg7NO4Z3LSzI/yTCMIqxSb5Y7NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZoRJldzxpyEHovJ5B7VMZ9uk9Kxo2njinJRUpHzcE0Q5ePTbViYQq0CBKeiMwb4gR
	 /7JVrMOr/TByRDEnd/3egBisOxEgD66RTfZIRpYXCH2L5DPtzFWS0KIogtdqQrl+ck
	 FUhf14SwGF9eIykt8QL8a04qULy/zAY/KCxuxCYuaVldkpuFTIq/9Aw+WqTVMgoGtz
	 Dh9JoHnvTtcNTqD362PeqnvKX1YbGq/VLh0epH36cFo+QvlejjM3qN7KhD8+Hwgnt4
	 aiO3wYi29N70N5RqvWPtUinkE9hU6OpzqxGL4uQ0UwCba4EeftQfjB7QkQ7vazE9eR
	 1QT2LJaomCv3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0168440978;
	Fri, 23 Oct 2026 14:01:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D719F371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD08B60660
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3Fi_eRzQTVS for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA4B560657
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792764062;
 b=cEYObLNw/AyPXuAm6nlFU3scLUmdQo1l9xrIstSiHxfSL87o0CryqO10JhKPmCnELK4E
 vbMjxvwDulND+WqGJjZRhF42xlm83BkJVxdaRCy89fGTXyt16XOTX+UjAeXl2EZ5fG2Me
 Rqlg5G721iaiJjoBAQpgSME8d2RS+IOvbQLBO42knMQANysnxPXOr+++H8zoCBGnjRqRz
 xay/QDiWv/5SEM9PxXRSSSYqeOXWdUjZV6hixnalhNKU+IZvCgcIBgxBuX+Jgu86BmQpu
 Jl9u8vQzEyaNXUQ3/GtNQnQJeTybsGgu+6e2NGBJWysxWGZv/0w//rY33bNAMpZ+qBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764062;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Y++2jVSCgCkgNlDaNg7NO4Z3LSzI/yTCMIqxSb5Y7NY=;
 b=gZcevrF+OSFUr8ZZrEN2swfgdxHwAq8o1VluADhStgYgJj4T4qQ+5KF2j37qdm2P6Ydl
 6a5t4A3Aeh6pHOKN3BSoIj4URJsfXaN2PFIXAFi29XdM6dNZWqH0VNWJIRgru0MGXJDKS
 kbCFQyHlSH8uNjhABBe3sXwAQ3peZiiJo0ovhgaFMdwi64mW95YefpVRWKBh3tcgdphQN
 1eUiPIQz44HLK+9VcV58gQwcZ996lwNCjnZPPqO8UsjzzarnW1ZKv3l1SsbeMRib7Qxmg
 7ghmc1tcfKKlIJTJoxCMsC+SqP6wAQ0oiUmpzVGQsZhAbAe4ruSMhDKtA4RDpvapUVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GwJZE2EO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GwJZE2EO
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA4B560657
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:01:00 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-6dd3bb640bcso44782eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792764059; x=1793368859;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y++2jVSCgCkgNlDaNg7NO4Z3LSzI/yTCMIqxSb5Y7NY=;
 b=GwJZE2EOL3EIbXTsFKHfozmLQncUytCDb/Yp1Oq3jSqBEXy4+NMfszQ34m/2vkKZS9
 YtQU9Vd3mNPVv09Hpmht7J09uT9siApP8VbSr8WCXC0xei/sccCqo7UfZHNePg25c+aR
 zdIY82FNZjQnEkYa3ERv/0gDRgZxTPsSGdUUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764059; x=1793368859;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y++2jVSCgCkgNlDaNg7NO4Z3LSzI/yTCMIqxSb5Y7NY=;
 b=dO5TjFGKOS8p4ROJqkIMW5JYhYXgX+VUToh/URYSewgqyaW9AtH2RTyfzOL5K/0hP+
 o1/0vKdAj89hsHbNrxWcdz/cWtfZSbZx4Vd55o6VUIuXYb84XKl04PjhKwc5OyUCkpzq
 v6Ma40LK6xVe1xCCvuqi+4y+672M4joq7xy4Swo5j+WKL2GSStf9EesL/0CoJ9gEEgs8
 Ch2+Xnckg3VXykeKnbPUexsO0vTgJm3QTm5UsJTybNDwllVp0l0rVHwqE0IBKBTlmLZh
 q1ydlp+8wVrfN9V+c0o46bok85inEQz8ilP4EdhqWNrG8J58ds7ET2r99gs1f2FA0Peg
 G7EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5K3K+wCGJGH4le81ovgRZ2u27mT9005d1pBoN6Mx4lMvRxI9B4cfQ4PSnPtJ+PWbTMPuunXw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKwetY+BByy8Mz1IKCUlrDbO+AlXkGVNzcnQVaZYnT7NZQq14GC
 czTH5DGrUkykx5MEm6NF1BVof5J0wTaP1qy2MKTrXsiBFPdjcPFYkCdYL7Qxy4JkHV0=
X-Gm-Gg: AYBFou2AtXfsshP0ihZLWT5OVuieQ4gb2pI9l1bTPVGJfDPNd1bIwblPDWuDokpmNe8
 AuhyJXmKyBIkki62CjVqMSD/sy1cUA6Svc4BWsL3Q3p4vz/rxf/1z2y0wcsihW6cGU/9fO16ZXS
 6NkYwu28oNDecRlAYvUTZ8rs/XXB0hCxxs5MjdDH0tSRU62iiLQ5cZEE1iVibBCP+woYoqJkGB0
 No6ynL+4ySzuQFqkuHimCUJpIgiug/Ek6A5F5+i5bLeoFHxq+uW3ruGto8LpALX3OY9EpwyWkwf
 dN7O0ukSnROq8OIkCX/LoO6JjZAkhHkXMHy6dQUCyS2tE2MkdDO6nHsJxVnFQjK33PVVFUwYEdW
 D3KD82PqwBT0/6xxnrDUDf3Mr702SwZ9cyHi1y/25GtSWSst6PfszSMrdxbRlS9qin0SG9lzN0V
 C5Jt7tGcoLxB0SuCC6NelCmycnZl/5jPAs9PzOPZdrAvUrtniChloTmO2YMMEiH2cR4Nf4yqsMd
 +RLM0ZXS3j2idA/K7NzfbeVAK3V+RUr6xxJynzaLvePOrxZ/JcEAlCs0hzBNzCAdY652G+zUtVo
 YDr0uZpZk1Q4vbQqMyN5gDzzOa7+aUbywKlBUMf1tHXl06+DTLvZx9qFV+Tr0K5GjJLOb2kSN3E
 e
X-Received: by 2002:a05:6820:340f:20b0:6d9:8fed:b730 with SMTP id
 006d021491bc7-70b887e0447mr875464eaf.6.1792764059291; 
 Fri, 23 Oct 2026 07:00:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9ae63d9asm82466eaf.8.2026.10.23.07.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:00:58 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:00:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] qcom: spl: enable CDT for shikra
Message-ID: <20261023140054.GE3596691@bill-the-cat>
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/QbXGTSSGrULDeLI"
Content-Disposition: inline
In-Reply-To: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--/QbXGTSSGrULDeLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 01:40:17AM -0700, Abhilash V wrote:

> Add support for loading the Config/Chip Data Table (CDT) from eMMC
> during the Shikra SPL boot flow and registering it with QCLIB via
> the interface table.
>=20
> Depends on:
>=20
>  - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss=
=2Equalcomm.com/=20
>=20
> KR Sowmiya (2):
>   cdt: enable CDT for Shikra SPL
>   mach-snapdragon: Kconfig: add CDT configs
>=20
>  arch/arm/mach-snapdragon/Kconfig            |  47 +++++++++
>  arch/arm/mach-snapdragon/board_spl.c        | 103 ++++++++++++++++++++
>  arch/arm/mach-snapdragon/include/mach/spl.h |   1 +
>  arch/arm/mach-snapdragon/qclib.c            |   8 ++
>  board/qualcomm/shikra/spl-shikra.c          |  11 +++
>  5 files changed, 170 insertions(+)

This should be one patch, not two. Being two makes it harder to review
if the Kconfig portion was done correctly or not given how the dummy /
fallback code is written.

--=20
Tom

--/QbXGTSSGrULDeLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCattojwAKCRAr4qD1Cr/k
CoW0AQC1/7gM3XzbQe34FTfP1hLH9pQqZpmnMagM2yp1Oa/HDwD9FTvc9+9FJtFE
wPrAQ7wp9+nsOAukG/V+9K/ogenwwgc=
=FuOE
-----END PGP SIGNATURE-----

--/QbXGTSSGrULDeLI--
