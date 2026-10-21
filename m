Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE86606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RIxeTR1Q;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qF2jcx00
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D341405B3;
	Wed, 21 Oct 2026 18:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVHR9D1n6neh; Wed, 21 Oct 2026 18:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A4D440FD6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792607039;
	b=BgD/aYr8Ug+GvltF+apkKlDkHPcFfEZhvoocN0QWEtqkalHwrWRiiU/ZRSmned99bZ4L
	 cu1jxxnGQ7MiYGlrvHddgOST/UjA1HGpXI3uxzAB1e/O0U2dPto5VKtCob+LlzpvBQk09
	 KzM9QuMFuz8R39miEqHhzMpjRjgshLGn8Epzl+jTJSIGn3kerQa9nmSEIXjLPzbr3o8ka
	 Amq5yFiNoj+2mJErVsa09gwnXX0HI6e8de5/Mu8VUuHYCkF09FFFzFcDylkCKQ/SJFl8e
	 RMGFkM1Zsl/84H3U+aHyz2m1+Slx6exzGOSjvY+W1Y58sBnpENtL3FzxNkybDTZm02g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792607039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aDy2p5vy3dy5ELJGdZFdBPGIfJqX5c63wj5hFKVtaK4=;
	b=neYQor0uM4dUNCdy6ODlIcOdZ6aIcccZ68LWHgEIx6oZaNTIWnB+FyVa5pkB0lKH1yCo
	 uHjFwn7Yf6bNyt5eaH/3ZH4rDJRx203xmZZU2Y169wiRmGkL7XJ5aGB3nzm/lPYgPyNhX
	 FBDd6ukW1xPmtmWjgu47vivQClZFFI9WIIZA6jA77Y0nAqMU0Qob1Jcvmfk9vmhgLsewx
	 3hTH11LNuh/KWoI0TBCLhjyKEPj4WRf/7XNmUiwuS7mj2C4vH+5cXmcubeJ4fv4yAImW0
	 /AmBHQDqTWTb1aN9zaFBVe45jnm3u+1y7re318rZaI9XPq85KzSkFZ2R9aDdR82kjVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792607039;
	bh=aDy2p5vy3dy5ELJGdZFdBPGIfJqX5c63wj5hFKVtaK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RIxeTR1Q93iMnSysAd//LujXZBqgTBOs+L+kEuSRHoCNxUXMwOimrKt8OdnvKAM6o
	 pLviYolHttU0jXvqZ1fMSnXi9pvDOaDRm3yGfJbdJCY18YnDU3XBvpO46unNqAJcB4
	 2xNGFMSEXL5Sfk0x2p9SXccZ9HOA0HIQhQgw4b1SpvuBVTihpAmpsllGEEQ/74QVBQ
	 xvPDxYgNsKLwRgNxksg7QrlSKdxBT1vN1KivQfOvHMdJkVb4IFxjTCKaohrj2v9aBG
	 C4Sr1A/nNvsd/CJdj2CWfXYMv302pedPmC812PErCH1T4nqmIYINTqkxk4Je9wNMru
	 xS3mknlz+EVoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A4D440FD6;
	Wed, 21 Oct 2026 18:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B97003A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9606860B78
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVYNJcFrv_Rl for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 18:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 809576F4A1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792607027;
 b=engy5CS/EqEbeHvmznL5t41d+uvyS1wuAk2wHXLck6Pt4C7eMzGbEUetKcfrNCorH4A8
 ci1m0i6Go4fHr2oeoCba7sg+GJKorN6BFupspWcYL+bbVEm2RGgiPH8ImeF50RNlp7Dtc
 R5yvBvP0mNLaKknK+REPmuubf1MW7UXMsLvJYiwTxQ3xvV+UpMC4XhoKDm+66kG0h0fNc
 bhpU+Kxq4MGJAcEM2oPIXAnzIEO1wnCDqAlgJha2soWyhZuPElAzz+sABKaKwxpqqpcle
 pfBS6Nc4egcgXoq9X/ZawpAEfSx/7YGPPOsNFsknfIQJwlBsYv1aP64cKrd4xrR7tsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792607027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=aDy2p5vy3dy5ELJGdZFdBPGIfJqX5c63wj5hFKVtaK4=;
 b=IqJYSFydmm479RLLKhPkWQHen3X4+NtqMCJZpdpHffJiIkahkOLlmF5nuftyMooCw+G+
 zcXyhJdhL8AlSvZujZe4EQ44HKnFS/nZaQnaKhrNHCjM8q45Xrm7oi/5v4Nxues6lHSmo
 JdUuJppO7xYnIufJ1TxCZCEVyM2Ex/JUAdV6bRcDNzwH5fwiMW5jF0oDKCQxAUBQI4S7v
 tdNkoJjRRWVWhHuyih/8s6AJQ1+8cv4TgzzYirXqk4yxJ8gubFrPs730+8kDwJ4kKvD+N
 G4rRffmy9R+tmS/nicaqaWWlxB4ieiez4MGYgb/ntTSqJa0+Rxjajk9GyKI+WVpth2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qF2jcx00; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qF2jcx00
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 809576F4A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:23:47 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-847ac7ccd85so730661a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792607026; x=1793211826;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aDy2p5vy3dy5ELJGdZFdBPGIfJqX5c63wj5hFKVtaK4=;
 b=qF2jcx00aPvirz8oYKkAd9l8bAd29B0nxPrLsFRBY5j9tOBhLfBeCcmfUH3LtJxeH0
 zGDiMGcIEIDGhttp+W94/P4/cF6aKI9iDMTXwQ4UBp7fQWKj7W5POuEFoZCIBouzJepo
 2nTnXmZDGnoyx6iIXmiLFgyYYVD3UB9JxAJo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607026; x=1793211826;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aDy2p5vy3dy5ELJGdZFdBPGIfJqX5c63wj5hFKVtaK4=;
 b=DLIn47hbc/lJBBQGVVtxGzeBQWHAYAipZWfhiLc9Q4ko723LgYGf7P4601Vajl5HoF
 SuzfwGrMsyrvXoR4ZdKjjQVJlUt+4pKYpO0D8orLlH2fCofp0HnYf52jxF/usD23rs2h
 q2s6pEz6/wPJpB2MdTO+NCIWxN0l7gHlQgC0svmYQyadAZiQC+pCkF4o6J5432yWrnV5
 gG0TWID1e0kg7K6s91iJTzfspL2kMZYaHmhnKzrciVbAg8RSXhtHuj8WOGQNz9q5lTOJ
 Mu01b4nKScl3VXPSrvyZOPrcqQNuIibdO5KJmjT6VONPaSe9mcxNsnG4Du8u2lscVE13
 GJ6w==
X-Gm-Message-State: AFq9FYKfVxgs2b1vp1U3hNgsghpq3AKXxXvYr3g1t0oT14a2cFiFdyWe
 nMVYIQ88jpstFEYsNVMSzUDPelRkC4IC9Tjyqm6EUXqDAqovDMVKgjPP4/z40D+mtMU=
X-Gm-Gg: AYBFou3HfcpMaUMkaZIV4uNVvZREhjZbF6v1hjZFH3zfa8Hwk9QXE/sTHf04gy1uIDb
 WVXe4iReTLrRw6iCSfTDeZ5xkaUcbQ7n96W6uM7UQRQ1lPLtfKymGohMgrn9Y1aL4mstFF56aJf
 ki2Ud8/hI1jBcDKFGLqyPaIa+Lu5txnn6GYSUE28oETOK79i97fSGqZKOAXyQp5OiKNl2kjgPbW
 bIz1JdJfbT/gcDsvk3kfQpzL44Iu3UFgfGVufi6bfsK6NmH2csTu+2T1YpHL+CUrj/5qC6fK7E6
 Uw5U1ayGvjTDFVHOcfHX9pOE6gI3g6J43J4nkOMRo95VclBwRCb2H84CSAysF9sKBzwGi6lEGan
 9ZzkSZ6EczlA5yfR+I/X3JyYEwOGlFgH1TfGurUlj2yYXwMKTeHaMykE8/gANnAIUqhIax5DtDb
 rVqWkXRwz4yQv5WMfPXl6KNDAglGa9Zz3qMD9JI0WgOxk4zvqS2mSOVbh+O4fxj4r3w5Vgmn0qs
 qjNxF6hzOOHUxBKBV0pyW75K/0xMc+Al/Ew0WShU9E3YnHB6TWS1iWZuHMDkDluHu/N69ZJl9/q
 P6fUXoNeWtxh+W/hK8di2wcSY5VJvcTm9KY81ThlzrsSzDALmmXn+YbrYW2mxkrGVaPDsshMzzx
 9/A==
X-Received: by 2002:a05:6830:2a8a:b0:824:df9:971 with SMTP id
 46e09a7af769-84d08501e91mr2096158a34.10.1792607026250; 
 Wed, 21 Oct 2026 11:23:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbcddcd41sm2943970a34.13.2026.10.21.11.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:23:45 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:23:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com,
 padmarao.begari@amd.com, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20261021182343.GA3287961@bill-the-cat>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
 <20261015044923.206217-3-suraj.hanumantkakade@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eJmsfOiGLq7GOBkn"
Content-Disposition: inline
In-Reply-To: <20261015044923.206217-3-suraj.hanumantkakade@amd.com>
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


--eJmsfOiGLq7GOBkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:19:08AM +0530, Suraj Kakade wrote:

> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> path) in the HOSTCC command. With a long $(srctree) that command is
> too large for /bin/sh -c and Make fails with "Argument list too
> long" while building a .dtb.
>=20
> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> HOSTCC/CPP for dtb and dtbo generation and the DEVICE_TREE_DEBUG diff,
> so the shell command stays short. The flags are still compared and
> saved with the command, so a change to them rebuilds the output, and
> the file is only written when a rebuild is needed.
> dts/upstream/Makefile uses short relative include paths and is left
> unchanged.
>=20
> GNU Make 4.0 is now the enforced minimum, so using $(file ...) is safe.
>=20
> Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide DT i=
ncludes")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>

This seem similar to, but not exactly, what's in the linux kernel
currently. Is this based on a change there, and if so please update the
commit message similar to part 1. Thanks.

--=20
Tom

--eJmsfOiGLq7GOBkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatkDLwAKCRAr4qD1Cr/k
CgF2AP96us2Zo6LliAUXg4aU9Fz8ohuorxxBgy99elfrsn5PSgEA4JBdBx7vOvET
H6Rn3AacbIOb5iBdu39WYJyGZWgKBgw=
=pd1h
-----END PGP SIGNATURE-----

--eJmsfOiGLq7GOBkn--
