Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D263CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52FE040708;
	Mon,  5 Oct 2026 17:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUm8cFj7CfOz; Mon,  5 Oct 2026 17:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 62BA2406EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791219964;
	b=HTaM6qra1jsZKTGU+t/4sOPxNEi9lXAPB5pKLGtKp3/7hNIvytDfExe7ex7aEEx72fSo
	 wG2Z3BfK4uNEBRB6uj21j29gagW/qbT3ygekXkOJ/Yk5mL7duWxVzbxEgj+qldxZujFqb
	 rnCIESEGE+WWyMjG9rcdhFKK2ydQRocHsK6w9wxeK0lPjJ6gf7P/8q/WFr9i8JwbBSGl3
	 AMdKnpdryyjuuCN4UO2ulIL2fotWGgJgnCcPYEaFIzBcSz031LWaBuBLANLmhEfChK5cw
	 Ynq6IOpW/7smXWj3GXaYRYAJLzsKWJpn/uUJQJeM8Q+ALMrlBq643lVMC4ojucID+KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791219964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BQjq4W75dMvRSItL8ONLCrVTUP1G9yLlWLsqJhEESIg=;
	b=HSlNeunlzmiZ4ePc0bX2l7gmTHycu3TQFRAeiodSG3LBTFS80lWnLK73/jMG4tMafetc
	 YL2Md34eVhakz9lIqAYJipgwi+jRdKf+l2yXKGIBuXv2UMoKzmQpTmznaRNwtQRQavn7o
	 Llz/2cPN79XvYMEUgqjKXirBY1cvpTezrVhXPP26WLg7th06xnGOptyjqXtA9eVrhky3u
	 sFw/v1NUDW7HbrR0dQGPa1UJ9Ng9uzkiza5HNYSps1712lApjwySy9J8w1JndsBS3kwKf
	 vDmeXv4UJ7tAAybmGVyaqH5uXDNVS6FtNz28jpIelvc3j9X1SPSLfafeVZ292o3+lEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791219964;
	bh=BQjq4W75dMvRSItL8ONLCrVTUP1G9yLlWLsqJhEESIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ljyvxMAnlEdPZMIB7T/dAtzSh0fJM157JGuuhyksK23XUzQMYeTu2aG6sSFXVgD3O
	 kfFNOJnO231KJJBZv67TxTNw2B8anIahGfa/JUmEi1yl/BdEIgnLaQJoS4woTRkUvB
	 WdWEBUj5hMiq0z6AEq4FXaUiFvHqPHl4A71jOcathjRARXnYK6KNQtzvHC5Rn4mgEP
	 njzJnyUz57o6+qR570XUsYwVlhEL8avomXvyTihWbIy3wpZvLdWJspPBFWVj3cSxLi
	 kMWl9xgnnLvdp0gZ2fU1GVqt1zkh3QUBpT1H5IrHCuJFj/0e6vmdDKsogNq2bbV6Ih
	 BAuSyqTfiDHUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62BA2406EC;
	Mon,  5 Oct 2026 17:06:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A247534E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 940E340201
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TrUwjEfFFyjG for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B308A401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791219700;
 b=kDbXs6nEcFNBCUrfvIdfCs/Gu/D07pCv8YWIVKJNYjxvbkEjFj+N+EhiDB6uNiuplRCv
 S9Vv0miVeFYo+tt/SXvf1laNTR4Ai5l9C4DoVHWNoT6Y1aQpa5pOMca8kzyX+QM9Dervm
 YAGgCkHfQ/6ioh4AqppEPF6PkouRv7KaTMu6uNgni5mGzpL50qj+7SFs7myf85rUOB9O/
 LL7UA8QFseynwIRrMzKn9TQBSHLyk31y4eHziezM8+4SkNiViYeyiZbXv+xxwoQy1UugZ
 7tp9y4WbdFLBbtymBGNBN4O+V2J1S+n0jU7+b4mXDN5MIoxMyJ81ij2t724h4DgSV8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791219700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=BQjq4W75dMvRSItL8ONLCrVTUP1G9yLlWLsqJhEESIg=;
 b=PqKcVNI2Btbr3ry3SwyVm6BUWj7+ORWLaSoTXE4yJFRLdnERurHosUebIS5202PERmfM
 TkbFOFRU+MBYkyDiwU0Bwt7ygDpPn938cZIootMfuhBm3VCSQY7YeuEX7uWgYXwQqBoN1
 VZNV2J13Acep8odWpDjRLkfqVjiyy8ApDZ9oTh4kDDSt7cd8CYpCik0xhZlLxq2cjGVUb
 DYu1Hau6Rgs59vZsbqy9i5VhVL+bGsefOzqYkEDFpADA1sPwWgvCsl3xQ0H6LhjNaqz/Y
 vEPk9FsxU1xG7lUTP0JWdO0lHeEqOCw0vr1wwxUZfXFakZS+tw+bq/oyleR4QXokQ9g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c7R8eAgh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c7R8eAgh
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B308A401EC
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:39 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-6dd0c06cee5so172722eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791219698; x=1791824498;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQjq4W75dMvRSItL8ONLCrVTUP1G9yLlWLsqJhEESIg=;
 b=c7R8eAghsJ6zcUgMQaLU3I9LkZ+zOJ/TATlN4fJMcbh/gdZdr4HvLNG1vbOIA57HTC
 hl1GffMYGeOzKyvDfMB6YsOgey+kQtY1M6Ico1x0SAosXB0ORoULrucTmiWNh+NCJeb8
 TfGYAd73vCTu86O3BCY8VvVgTPFtxMXAehsN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219698; x=1791824498;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQjq4W75dMvRSItL8ONLCrVTUP1G9yLlWLsqJhEESIg=;
 b=J9o4DZ1dNFi5i8aoNT5fcEHL4gFGlEq3tcKufDcGQabBI2wTHWeyT/M6Isih8II/hH
 GMpTKS8XCaWjlAgRMTxsefx3Uw0FYUrMJnOGfBuyZAKaqG7/9swX1XySkLzZO7TfEnBU
 ANaBdbJ01zi8uWKz0F9yAb8lrHHwqGzcwxZUm04P19J7T7vZLsWNVvMLUSAk4q/BFS35
 Uwo4Pr91+fEG81LMCrEvSJ2iAj3GNI9QqV+5TSALs8RuDxIC9cqypG+KME9/IEGhtKW4
 NhjF5RLjmLxnO63F3/6ibsZ8FCmC4Ad7oI6ZGABump+UqnuPC/VFKiPER7wIZ7Qvw+pH
 o4gw==
X-Gm-Message-State: AFuF++kDpV2/sFzbwEOoqV9GcQ0KWXcp2R/JvbqmGduu+ELy6AXWHwuA
 fWFld0cVS/OZRHu83YXJySTTWoqY8SdIoL0OdysIZKOH3hKSMXVUqLlqJwYjZBrQxvs=
X-Gm-Gg: AYBFou1QU5OV3MPx/omt7CWT0fzNgnGs5EbUEY88xquqOP9vy1zWyHEVMWMA14TvWCD
 iSMFNxnhHUdVU2IhJ7ZGSkcMd0smukmirW0cKXqt2dObJXOWfUtb631DSb0QBzT6DPDx3taL8+b
 G6CmnNDSYGoO2FrjIeGTDr7IlCfoJower/mqZSJjnz8hBdhds3TNxVMbKoYfJjt03Qp5aDw8a3P
 S98xlhDl4hFPV8R2cyhNhvpN0INhX56RNemy6Xm4Mh7Sskwtzm01DPmnXDUJF56iAXgM7DEDPan
 1ykTq9a/UZHaXDObHvMxUbO//eGAABQZtcXpdJKI2DzwtTaREYwpkXD6HYUJxoqkLL+h+gg8CLi
 hC8+96XSRR4D5fe+8+P3iqZi4RBfW7J3lN3JG4B3m78bMrAXA56mBB6LTUeP6EIIlNmKu4NX7Hi
 byLy3ZMPPvUmaoxMwFTo9eIOoWyV73oUKcTJZpHZ+978Bzcq0Jiwa64ElQw94KSIuzdCR4k14T+
 Nqekhz3rkw6rRP0wGkcURcZYU21q7jshJ8TTky352nZiaVikAjfXPkOpUg4U4lN25VdnfN5f42D
 /dakRELVUYZ7F6AHPDA=
X-Received: by 2002:a4a:e848:0:b0:6e1:f7f7:5336 with SMTP id
 006d021491bc7-6e1f7f758aamr4665031eaf.56.1791219698336; 
 Mon, 05 Oct 2026 10:01:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3a7bdc7bsm9415314eaf.6.2026.10.05.10.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:01:37 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:01:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/5] lib: add memzero_explicit() from Linux
Message-ID: <20261005170135.GA3724959@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-2-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ezjoifiY0Hs7mKzr"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-2-18102059357@163.com>
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


--ezjoifiY0Hs7mKzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:10PM +0800, Xiaoyi Suo wrote:

> Import the helper Linux uses to clear a buffer the compiler must not
> remove. include/linux/string.h has it as a static inline with a kernel-doc
> comment above it; this is that code, copied as it is, so a later fix
> upstream can be picked up the same way.
>=20
> barrier_data() comes from <linux/compiler.h>, which Linux includes from
> that header too.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dbec500777089b3c96c53681fc0aa6fee59711d4a
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ezjoifiY0Hs7mKzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasPX7AAKCRAr4qD1Cr/k
CrY+AQC613Z9kJXQmzJG0LfmfS8PdbbzD13hK69+busAHTutVQEA8CAtqtcKQFpo
zKQy2hPkM7S/uQ67JDd3ELaLSMa4sAw=
=gYlS
-----END PGP SIGNATURE-----

--ezjoifiY0Hs7mKzr--
