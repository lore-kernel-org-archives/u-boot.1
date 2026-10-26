Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1125606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1L4C5qTT;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uK5x8FDA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5382E80DDF;
	Mon, 26 Oct 2026 14:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGz5kmRxkFKn; Mon, 26 Oct 2026 14:54:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70B9E80D7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793026457;
	b=dhQlPZtyOj2S9/78qDLf59f1zdODuppe7aPqi7DayfAsCnek8KN+IKW3zytjJs4wtSk2
	 KkKDmD56J/OzITpN+8g3u6jn4db5U3XxiZGr54jivsND7Dkl1tv6Q64Li72ZFZOGd/YqQ
	 NUDt2JF6gOp9+L2FKrVFhjI8zc/xVPbE8tWR1UUuFkjfk01Ic3DGfZws8/FNU2rF+o6BO
	 pGze0p6GOnNYApsK9lplE0FPna6LciaI9Zpl3cI4lsRFaJJmbG1OYs6+N2FgzVCKxd9YA
	 jjqZ5mTLLoK86c2bGI/AeciO8YI/7pKZaTI0iW6SH2QvkHhZY+2HghsYWrGwTV0W76g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793026457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=quWYmgTPVtlGKyjWnY5BshdJWVbnRyTCmV4iAef+Q3o=;
	b=A+8q/XS+ugP5LDoCGMUDxq1nNQomAq+WDZYff+NcijIzZqhLhNRZccLzRl/JC3Cvq5JG
	 72x694cIctwzJDmHob+aSLVX5wZwhvwk2o/EiO10DqYfIeLYeWP7WjYcNr4mVRRXy5VJ5
	 w4GeTcrw6vj0I5tdCTk1f/a+MW688RPNcRWdqPlYqosQwsS5WxvIgPRFOZheTfeZotQpr
	 OQTUyljP8iauLsYl+jMRvpoAUS5BaCRKtHXs9cc554527NpeJEDqOCf2N/xcHBI9AEGcB
	 qHhV8/WXO6vza7Edsx9w1PcIJRAxvbWzsitcze7H7w3JgExx7stI3i5IMLtvEVu1XPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793026457;
	bh=quWYmgTPVtlGKyjWnY5BshdJWVbnRyTCmV4iAef+Q3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1L4C5qTTPbbppkK9l7guquzxw1inQUtBYYSx0GlCy+FswGQNJ7Rj9quTCF2m4Rv26
	 TEWLW3BY6smBZicbKTt6iV2NtdwCKh1ngPKdHWDIV4TQWi2v8svYckaKjENldvcroa
	 YV1HDZ1yNi0NoF7oZoZJ8lC3v/uFxypH1YRpRs9tqzvfGlXZY/ufRkfjeHlB+Z1W5V
	 uZkyxNk6HUPq8e0uXW2kRIENnNnT+Y+C14dZ83GGtVU3PcqiyC/FiOx8YiCjcr6rQm
	 qBfK5Zty8kuqyXhpQ4kdADHsKBSZ0O9JmZ5XXnpAmCSMU/lcGYHwCjvVsiM66ssirO
	 PmaG5VbBh5hcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70B9E80D7F;
	Mon, 26 Oct 2026 14:54:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90A8B2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76AF060600
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVIUfdoq2tGa for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89EAD605E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793026454;
 b=B24chGwOpKiCfBU5mG6P/5eoN6b4lGElVwF9I8BclmoHcQhzP442rg/CXdFF553q9n/5
 BQHnX98sACfEKlqI4aItYv/edF1jmA8vcqKDVvS1JvcaBDT5L76LZtkaH5/VeAoB2k4Lc
 VmRQqlSSYZvpYB/gPCJ99k/AuX446SffQo7AWEIPhBtDbixv17Wyh0/2HX5bdal8qsxB3
 f7IGMg4d4nJrt7cwdwnMmP5+kpP/F6mq+M4NLaQ0FlFpIlkCZzU3C6lvdylkgNEVtZMXN
 onFGZQUQRAuuRhyiHBgUR8yGjrFjf8jpuDkpAEyNg2eLN1ZypgP9mGsobaz6bi9r4hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793026454;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=quWYmgTPVtlGKyjWnY5BshdJWVbnRyTCmV4iAef+Q3o=;
 b=ZHaX9Oq+yua98sE70HfpyzrGq4pPKL+i81n/QjZb8omz48UcfTJZYaBXu7NK6+MFs1/T
 hJCqAPifyMq6/mPMR4vtkSyVCd5z5GP/g52E12NjZslLcT5XkrafTkfRwBW5Wgc9HjJ2O
 koQyLYtJA/gl5dYjHvmsuPaP1zVravr8EO5VEHuG2gTesyF1lZWvP4L6rtIQX4DFaI5ZP
 V137UMcuqugqNo6IsuOy0NjUv87XLyjx7Z+X9K4T5SuDrLeF8AcKjVaZcCuW6SHKZBpUQ
 i7GWSrsFc2ft2uYHKSbLplziTFgePB5um997LQKrBh0CR6GW9tr4ADrcfmf4HjkcliA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uK5x8FDA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uK5x8FDA
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89EAD605E8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:54:13 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-8458555b6a8so900819a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793026453; x=1793631253;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=quWYmgTPVtlGKyjWnY5BshdJWVbnRyTCmV4iAef+Q3o=;
 b=uK5x8FDA6PmLOsstE8PCJoc1IXSKuSRuQWD2Yxv/J6h7Q5/Iu2uuhEUFOp1oNcNx4v
 SlYSnFhCAL1TyhwIaRzYaQL1jNY8ur1qzEheuydYf00S+pyISxu8qIMYPyZ5v5DDnPrd
 jq7Za9BgYRwU2g0/lkjLTvozvlb9Njpwt9bBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026453; x=1793631253;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quWYmgTPVtlGKyjWnY5BshdJWVbnRyTCmV4iAef+Q3o=;
 b=Mqh0ikHvz1jLr1erFrG4UMVemoDubBHSIxTLOrltu7BIOnOooLHa9BszZB4xGIt5K/
 fi7410SuEiUg0D1oeOXbGjXlF2zxSe3yDhEY5ZtDm7NF13C2ftL9QfsgqUshX34XR4fx
 /rgjPogAR6u8x6h/LAsiSoa4rshUHCFs5GEA2oHAl+K7bsSKFkljlNxItDLJU093Rbvm
 +6Zi/SL1d2HkLKwzageKNYAoWK+lMVOHDxT8exzcRWZx3U4FafnuoOwkW6YyRP0bs6CC
 FyZKTZTZ+PY40rwAt7UqVO+fquLl10FtKdS5itUSgsnDIUfYRQ4XyCDUJ93J/50wP22X
 1LFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJYxCbfEtRmQcKf1S5RHooJhnXv0Ec6/4QJrJtLbg42RIaszXy7nMHmL3vHBi8lSMyRbWITuA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJm560gEVMuCnmivqac+vrxBGeyxsbXATs53m0/Dr9YoYKf2M5
 4/p9up5fx85a+UTKtAUk3S5B+AHIDUTuDufonkzztIMwI6Yn4k+AbpZNCttAHk4UB4gDIkUc/pr
 uTSQAHxeJQGhjACo=
X-Gm-Gg: AYBFou1zF+AhwRBcZyoUmrvSVlqvYL43haC/15wcVqwgeDPLRMN/ULq9rQO0rNNZp2l
 D7MpDycgLEURMEOHouDZLJPa2YEnM2pnQNZ7CipqRSTNP/1v6wsSvyIkLM+0B6JRFfNVCCjDFkZ
 lf5gUAXail1SssQ7LrGAcMcDURbRfQhCirS9rGtbtV20NAJ22VIe6QxC/kZZg3Cp7RHZUz8cMpd
 BVVolG+7gjA1b80vo44ML+Wn5lI0x6/usvzSBK4obGks9HK/pnvmEmn4nIQBQi1lxhhNcUT+uA0
 hKrpWRgaVh5/J7g8kU4DbF0JiY2hRq6+zeUvS52jS7dvCDFW7Dq/BD2d9UazwKf0ECVv1YscJI8
 YMjcfjF551a0vGkI55WK/DyXkMkX4ZmWMSY2zS2qLx/zWck7sLKVPnEbJeNxil77kF4C0lQ7r9R
 1VQMBsLnQZtDwOV//iUwPbf/WExbZgHw8mjYfppuvG+vrRsdojJeShuaJNrx6DV+VbQ4DGWZZYM
 XGvXUaJmtKfDu3vXHRtBjFht1v1ztRpHNBrgWb4oVzQ33HJISMqb8oqYmXRjHls9O2QQtiGiTZD
 MYmgGC4MfvtP2P7YIw+hrahqvSH5C621/rAeFAXm2nzbaacDxHHQ48hH1gN3tdgJvkbeuY7t92S
 4GGPZKAMgfYZnHavswmbag3bBRdItmvKX3pDlmkOTbJvCkr4P9kWZfz8rAg==
X-Received: by 2002:a05:6820:6fc5:b0:704:b7df:f29c with SMTP id
 006d021491bc7-70ba0b5eb8dmr2489206eaf.10.1793026452682; 
 Mon, 26 Oct 2026 07:54:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70bfa90c943sm4333217eaf.3.2026.10.26.07.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:54:11 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:54:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: Altair Bueno Calvente <abueno@airzonecontrol.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] fs: ubifs: resolve "." path components
Message-ID: <20261026145409.GC624796@bill-the-cat>
References: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <d0dbe72c-7531-9556-2ec0-f147d6c3160f@nabladev.com>
 <DB9PR10MB793033E1A2F0E254B4C53235A4612@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <695a45c7-c3e0-d18c-5dff-15c798d31a06@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cTmMS/pe+lPiO3GP"
Content-Disposition: inline
In-Reply-To: <695a45c7-c3e0-d18c-5dff-15c798d31a06@nabladev.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--cTmMS/pe+lPiO3GP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:09:22AM +0100, Heiko Schocher wrote:
> Hello Altair,
>=20
> On 26.10.26 08:26, Altair Bueno Calvente wrote:
> > Hi Heiko,
> >=20
> > Thanks for the review. v2 fixes the From:/Signed-off-by: name mismatch =
and adds your Reviewed-by.
> >=20
> > =E2=80=9CAssisted-by: AGENT:MODEL=E2=80=9D is the trailer the Linux ker=
nel documents for
> > AI assisted patches (more information here
> > https://docs.kernel.org/process/coding-assistants.html
> > <https://docs.kernel.org/process/coding-assistants.html>), and I believe
> > U-Boot=E2=80=99s checkpatch doesn=E2=80=99t know about it yet. If you=
=E2=80=99d rather have it
> > changed to anything else please let me know.
>=20
> May Tom can help me here?
>=20
> Beside of that, please send the v2 through the list, not as an attachment,
> but may wait for a resopnse from Tom, thanks!

Generally, we prefer people to not be using agents to generate code,
comments nor commit messages (with an understanding that people may be
uncomfortable writing in non-native languages[1]). The change itself
seems reasonable and Heiko has already reviewed it, so it isn't
rejected. But we can also just follow the more current kernel standard
of not mentioning agents.

--=20
Tom

[1]: I am personally at two days since finding my last outright AI
translation hallucination. Before that it was around 40 days.

--cTmMS/pe+lPiO3GP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat9pjQAKCRAr4qD1Cr/k
CvJ2AQDh2IF1ll703SSQi97/wGUyLX2HPq4NxsWljo6VHm0QAQEAhzhAfAKFC1/f
8yBR+kEUKsVJ+r5B1E17YiceGPXhQgQ=
=Nmdk
-----END PGP SIGNATURE-----

--cTmMS/pe+lPiO3GP--
