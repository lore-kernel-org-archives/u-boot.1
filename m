Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37310606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b6VARcI8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=drdbwrrw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 000D580EAD;
	Sun, 15 Nov 2026 18:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TOepw-R9VYD3; Sun, 15 Nov 2026 18:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BCF980E8E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794765892;
	b=dSoOhKmqcjjtiITXZIMrOUMjscpGI2Uar3y6iHFjietsfCGaIgdA4ScLlXVXbMrkjHTs
	 XFyaZ6dGOOJXNpwFECL7m3ZVsJAY8lMW5URfMvXKPwWKeh7P8xlGkjq7uAIkVlUW+Ow32
	 rM7UYfku1rIUvO0qP+fTA9DNz68lvDtpnRw3gjShXDkgef0+bxiBl75Ge0iHILHplqHaH
	 2XboQQNCdkrOcWQ/BtVYPinMpf+eA64T4YuVKMQxHUZOqU263B7+jGKZnPcrqEqXXAlmc
	 1N6qg2ccmqJoowZbZu7I9yHLxqyMQXnQyTV6aWBPMeM5IMSgsXOV4OKx268Dw/wiTRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794765892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FOSIdzEs5y583MkLZGFYxOL7oljBE/bfFIjMNnLPYAI=;
	b=s5NgVcxRTrLjCjKC0rMd9+W6CNsSQq91qTI415i3O3TAfCQjlPxkjuXJRy9XjdB5aRzz
	 O9NBfLNNuzTpcBuJmOcL1bENqSrsAc83BuStfPF7mN70qT5HRygpeJmW0X/9VRiw0jf1W
	 zViNbi93GKZG/Op0jHqf5PVod9nc5GZ0Az+rehVJD8j4f0AP3Skl5VL6OIX2giBe/5psr
	 IEZXVDsHQ3lA7tj8oXFDRGf8R0tbhl5EuY9A9Q+ALzQyiNZWA0lNtoeMV8tFfl9vxJRBW
	 0SHAy1wH6BHEWxkbPHZTSMw+lwEpVDzDNr6h+GZTDc0i5yUz8Fsd58ga8dR83dHELIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794765892;
	bh=FOSIdzEs5y583MkLZGFYxOL7oljBE/bfFIjMNnLPYAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6VARcI84k/EouPjZtmTNiI3WNkI3tw9wEyFL/T9eSvEk/ciwAeerX7FrZBd0RQBB
	 GlRqBiSruU94kP//uaKxRx5YoM/jkDP9WYXKcoxtnc3xdZaZNp2phbNjws4t4Q6vof
	 sgqYPFddk4j9t7MSurX5U5aH0+hQsM222aBAGoQ2A1808G+cqDyHLPvAZRjoig6in5
	 FFK0zfU3goac6Eq4ASbd2gI49VhOipZKZ9hmJznkecnZIu94shnVqRYpr7W+tm9Dex
	 77SPfZTnYwgxW0AVrsoAlPdn3pJ41hfZtUDtw1cVdk8F53qkx+HbsKkbTKEBMYAw0z
	 Ms97ghkENne3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BCF980E8E;
	Sun, 15 Nov 2026 18:04:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B379F2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F8D540640
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhGRNpCp5Sog for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1E304062A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=drdbwrrw
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1E304062A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:04:49 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6d290b10a35so954238eaf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794765888; x=1795370688;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FOSIdzEs5y583MkLZGFYxOL7oljBE/bfFIjMNnLPYAI=;
 b=drdbwrrwQ2u+oPVvT6cX1DWlz16m9VkibR1fu8rxt/w56VY9t9LLq7b3Z4EwuOEHj1
 4pvRjmXh16bZp0eN0qEKDYnGwXG8wCv/VWedbsKhMGIUy+oVnzdMHjHwN6VXS6DD8PmE
 tK9oO2FtWV+V+xLHAjjnY3nIzZHXv/xy/2KqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794765888; x=1795370688;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOSIdzEs5y583MkLZGFYxOL7oljBE/bfFIjMNnLPYAI=;
 b=OmBUD0sh5WnufGcL6JQWrDn697WIWcYLKbmcEAZidOYOfb5F1oDn5J/NgDeSWdWRW2
 DT5YK/xJSfiZMipFERDVBvVduxdd5IperPjO90eUMjRLRpYVZslO9yVBSnBxj4ersuh8
 vyMC+QiFictnS3i+/m7qihoxzOepxv9uAxrnNM1hgDzIv1b3CgFmBSVxOZC2I2kZo3VN
 2pWaK565DLvFn4uF+c+lW8tc4IHNceQSpPZi8qeAI4B7HuqvGomiwYElPY0RnsgYUwmo
 AQOfpao4NJejLXjNXdx8opTTONbdwfd1LYw+2Fj7DTBHyb1glmEnDkGjOw+HvXSZcfYU
 X3nw==
X-Forwarded-Encrypted: i=1;
 AL+hErETwviZmQxdA6RU+SLNgbPyNWkOQnr96V1xKiKs4kN4upc2CsGgfd7eNbkY74boZfySciZNpq4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9pdMADvqf7KjYrcyPJrw1gRt9zBgpeO2GtlAYKLq3a2VmpFLI0
 8B0nIgugloBI3faqS+zl6DZfSQVssysIunOwENGvyjJrYHSzBD9GgCPzwXD8ecgl/+I=
X-Gm-Gg: AYBFou2t0hxieZrRvHU/goNreWH6o7o4YsnhbF19zuz2stA+ysTPPoDjRxpaKSlfduh
 mrVrmd+hiv+hELL2FFIiF3cYJVde7ksFqZgD3i1FXqXda9asM+HNgUqqN4YUOley/FqsFjYHr+v
 C8v4uSmbiOj4Ua1MGYZUS/7pexOJEruM/qCDFAaar/ROtiiiD1zofnN9D2dzdbjZ/Ghk4/pFO6L
 KOrfMD+1vOiJm5mwRF2yZNUeBmB/th3AyRiVggOvTT+U0FrR5RzQjTSwD7lhKWjR/ZLkhmDFFdd
 3BAFh2iXkWDYwHuFh0Ok4RojkhlOLPSzzkv4Uf05yPvAFIhvIcxeG9e1uIewqmTQP7n3yMkK1mo
 uqGfB4aBP0+XahsjcyCUzoosdC6lmFZ1GzInTPlwELQT6avIzrd0VB411HaQsEtcWKFqITzlzor
 E/mVpfgiZR1pDZ9MjPVAnLS3U1OWNwtqun3j4elY/4EdiUgb4P4W49aKkBRPaoBn247UroJhTxQ
 ECbfS47yDNLcVgOW/jC9det2IRMjli2T5lqeby988NcrBxvNnu+GCgSRl/UoA1tNz0b9QrGWwgF
 T9hJZ2kKAt9woQdjg8yE18IVFw1seFKZzv+waMfkIdHs4B1JgpPxzEol14VE0lPmiNwsWRbup+O
 YnH3+ydevwvBF7RrzAb47YJLLkVCcu7N6P4TdnVlU8ldh8wrsqKPPBdiHm3hjVcXwjGwNOnEHML
 FwulZL8Lx2Zf6vblmqxMs9ifQ2od5d7RM=
X-Received: by 2002:a05:6820:f012:b0:71a:cee1:caa6 with SMTP id
 006d021491bc7-71acee1ce75mr3101071eaf.59.1794765888281; 
 Sun, 15 Nov 2026 10:04:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ae6868fc2sm2467524eaf.2.2026.11.15.10.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:04:46 -0800 (PST)
Date: Sun, 15 Nov 2026 12:04:42 -0600
From: Tom Rini <trini@konsulko.com>
To: George Kola <georgekola@google.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] scripts: checkpatch: prevent shell injection in SPDX check
Message-ID: <20261115180442.GU554944@bill-the-cat>
References: <CAOTQ16Lwp8m_tDTbiuT_CAVj-YByNJ2o5g_XBHwBNke+tuGQZA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dzHjovTysX3kOcNR"
Content-Disposition: inline
In-Reply-To: <CAOTQ16Lwp8m_tDTbiuT_CAVj-YByNJ2o5g_XBHwBNke+tuGQZA@mail.gmail.com>
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


--dzHjovTysX3kOcNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 09:12:05AM -0800, George Kola wrote:
> is_SPDX_License_valid() interpolates the untrusted SPDX license line
> extracted from a patch directly into shell backticks, allowing crafted
> SPDX-License-Identifier lines containing shell metacharacters to run
> arbitrary commands when checkpatch.pl inspects a patch.
>=20
> Reject SPDX lines containing control characters or shell metacharacters
> up front (even when python3 or spdxcheck.py is unavailable), and
> replace the backtick shell pipeline with a direct fork/exec of python3
> scripts/spdxcheck.py over an anonymous pipe with SIGPIPE ignored so no
> shell is spawned and early child exits cannot terminate checkpatch.pl.
>=20
> Fixes: c261fef51ca0 ("checkpatch.pl: update from Linux kernel v5.4-rc3")
> Signed-off-by: George Kola <georgekola@google.com>

Since we take this script almost as-is from the linux kernel, has this
issue been fixed upstream? Thanks.

--=20
Tom

--dzHjovTysX3kOcNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavn0NwAKCRAr4qD1Cr/k
CtylAPwLiXihOGDGkVHyVnDHMSHthtVVlAb+htRFIdX8sH/gnAEAxxX5LFEmxsyv
qC2Xstt+3N6FnXhWhOwFi2guqtwddAw=
=g/eu
-----END PGP SIGNATURE-----

--dzHjovTysX3kOcNR--
