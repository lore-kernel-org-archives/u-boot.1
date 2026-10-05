Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390CCCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E906C40680;
	Mon,  5 Oct 2026 21:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVrrhZ1iKnun; Mon,  5 Oct 2026 21:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3B12C4064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791234288;
	b=TKclPY2dIcCjsFN+umyw1i8P38mfVD2hMbjrOzKLwPxZaygE0C4SzCjFGH5kLeXnmDqJ
	 r/1i1twyLtS9Db9kuembQHh+yuGyixVW4wsScFL7rGGVQyqKt5mjA7Lxh42V1dGjaoWIX
	 nMGMVhZB0BbAXX74mor5Mw+w5RKt5WC86dHYvuqRpFPkj/zOqIwijKX5d3WN9mPnXuLKX
	 e/wXu2uokUftpL01aikqeXQo6bTZkK8yd8g7/kKGe/uLzSrBvTvX6Fk8cYtS9DI/9ex3l
	 el/da7EDPpBFqPG1HSGa1Th1hakVdSNBvTA+y1JsF80ZgqLe+woZfFqzts1pSJteoaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791234288;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ATUexWf+aDBG+fev2DU2cLnTP9wz99omzHwNNG2SGBk=;
	b=eVISx71JXuuOQRKeclwWr21qxllucsKB8H6uC2bFKffBNOIZKWwzi8fU8hfL/flYGfwk
	 c2/PiFhzJWyyUjWT49rkzrIsEETeMWAdFmxbldZXXJ35BJsMSDFU6n0J34dkhHi8jJT7j
	 8fiMJa+Fa8ZM6wccO11CsdsDFTicyvBzNpKfjmYWV2kaTKsyxTf6XB3/wIIyluHYemBU4
	 UKncLwklmIEvybfbiDLZlE6dZM18QwkMFuH61g7O5aFRUX7MFZmYh/IhkkFhxo8517rW4
	 zfeqQtFm5UapwC/K7mIFWX5gNsFJBlPbqwxs1JjiAxQKBMCqkcwFJqKt8/O6DUijl6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PMoBiCA3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791234288;
	bh=ATUexWf+aDBG+fev2DU2cLnTP9wz99omzHwNNG2SGBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QufLAmM1j84tZrC7f7XFJAhALEGzhGJwfeYc+zyk9bZYWOHG2J0Ktz74PgJ3bWtPy
	 kPCCND+dphm6XVn8qjg4NBzpdGVhE/PXFCxtc6/D1850Y0JiZ6ciYiIRTp/5KMs1W5
	 q2HKT38WAJl3ISbqe8AlOvwSjzpaaGFCm9C6dzu6uj2En0HNK1/0RfQ94REcu/HyG8
	 oePHpOUjbBsas1Bn8Vf7ly0MpEZcczY6386/v7Wg2G8GoiP2WoTr65jKMHwAXbZ8Sy
	 Zai5ytVkPq5qwoYVJ1jbMrqC7qK9OF1hdbBohbRXJ1gMxJAj9+Z0L2rMwhVomY+5RT
	 GfnzqSfZIOEFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B12C4064F;
	Mon,  5 Oct 2026 21:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4755922B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CD9D4062B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrlaKoeIqSqd for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 20:59:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D6094059E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791233969;
 b=Zp1BTZ07zMXEKIHQK3bLt2q46Nf545sqvr8Jf/sCB5qTOGd8aH6Mxda8j4u7HbmFHdkA
 USFtqp9LBe46FW/OuY08YHxMVXm98hVxIir67t4pvx8JVCOCus1Sxo/K0OAdUa5li2igq
 zOOwSS1EQf0ShVzsOBl44ZuOeTx8mCMBoQslYnhBFwS4Hk3kBM59mPBQY5xdh3Cg9IAUi
 Vy98gVwtod43ehxluAEmULNF+CNjau3w4+gAfg4U50JokhEmc7PtmKSeyNdHrGkU+udem
 AOKE4VwM5MH/skfpdPv6QDTeetrH5Hx07Bx5Fey8Ax2iUy99zadSHwy2xADffTZLKuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791233969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ATUexWf+aDBG+fev2DU2cLnTP9wz99omzHwNNG2SGBk=;
 b=hSh0vzcZy6pBIu6XnxnvaqUkdqWAMmbn+qei5Hc/WmjFHBCO+gYMgmPfesfm888qpC5D
 gEWvDilNy4aPNlh2MG+W9VVq/tlWNcNCM+vF/gNhotvl42ihzgakSQC+OFRfO0Euk1Edx
 Vyfec2VV7EMPGeujA7mKCHjXHf2TYiFz//bt1E2MYmA72BZK85u1TL7R1wR3vLnQkiDBC
 oEVFcj8GYUA6tNQYsMP7el4aAYZ6kSOSqPYQzP9tBSxlNNTIJTIAkzRvGewtnQ8bodqQH
 KsPR9azNTxUG623pF1PdvbNDTlCWTuJwficHlDDPD3Vcr4Vgd5DSpVueZIgz86QuJpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PMoBiCA3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PMoBiCA3
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D6094059E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:59:29 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-82478760557so1796561a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791233968; x=1791838768;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ATUexWf+aDBG+fev2DU2cLnTP9wz99omzHwNNG2SGBk=;
 b=PMoBiCA35Ybk7HmQdX5musyHgPitonyCkFtxMXzpYLzxO4VkKJCnVx4J7mkSuUi8nO
 KXB3I8RCfLPRSFermR0wwJYcbTiboldwJsrNn4eaRa6IJh7Gm9uaOJRl/hbqwnvLXhsM
 7tCBf+ndQAi/S+41tvxDy3bepeyVYK70qIY4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791233968; x=1791838768;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ATUexWf+aDBG+fev2DU2cLnTP9wz99omzHwNNG2SGBk=;
 b=kAUnyBAetfyPvG5CGf+xSWgGDp/PPLDDhnw6BknGjYZLmLUqHfy6JgC7+d+4z5j+wr
 9gyWWmEc7NkdNiR/okDLKRnxDRnO1JmQU0FxIDI6zxaU5daxVvjgqPP8NbIJc17AMYtX
 sL0ojdDIZ0A2pbG9lH0Azh0KI8kpIKBcVAB5rKld3z88CIMFF/YrNLrSRT63j1iAwVdC
 FvpmMthXEO0EvEATI2Ar5ERuB4RsDMOOpBz6DVK+25KAcJQSn+KcXoO9OtmIU9iOoP0C
 gX1kyj/muGRkdawi6Xtkhb2vmW2gxD4b03VSxsDF90dDeEHGnpDb28ACRvR/jirhDS+j
 fWBQ==
X-Gm-Message-State: AFuF++lUrQLWyW9W1hZclGtWfNmRChDTbOj/Gro5vehlAjhVAAiBWR6J
 sbC6zf7LRv3Ajcp3dE/O+CiEZ9wUvCoU+8Q3sVs0treaalkmM32r6UR+b04Pq2Jitzk=
X-Gm-Gg: AYBFou0yUPx6OgP8otX6NNm7qb+VzbQIDm6LwZ23Fb9lr44XNz2DpfRbRJ1x1/PgoYD
 ZDBT1CUsAGnUfttE1LJ71CYBxdcJsAuO4FteZgf72D7F2LDlDaoeneIapY8wAEcYyOmY5VIb5B1
 5gkKJT6znYCEFVJjzmAjAiIg+Zjwerh99vDHMQNbKLrw2uYDmL3FYXeem3Do9QBL0vmTkcF96a4
 sWgBvTg+rjQ9LEocsrHDqZ9zvqvUcYpLi9VC1KrZ3FbCAz0pcIKcU1ciNNFGeNPHFESy+1DQH9T
 UIx0BardGV9wpQ4oZ38rSUZBRn7d/Jr1e2JF2E6bRLq+TE5xfsQGxD7Yr2sNEa/eYYdo9rXmwQp
 4tShfM94vs9sTyBA4SbVzC0nCVkcgXPgg+ueD332iQH6gGXioNJkwfyrFbhHRGQRUTRsQptPjWV
 t7H3d/ECJfCfmSa7pgC3coQVzXJR56wOSJqt0nR43H/VznWUWaMPtCSPv1qMPY2sOG+rZbbisd7
 3Em/xEfDk/N3VKEWR3dgdCShK1R65Z/lM7JmE4G1TsKsab3+5n5ugsa1mO0/ARfScgyLc0IAzpq
 /poq+TLmXw/tCmtd9cM=
X-Received: by 2002:a4a:e917:0:b0:6d8:d3d:de6c with SMTP id
 006d021491bc7-6e09db97021mr7298145eaf.37.1791233968131; 
 Mon, 05 Oct 2026 13:59:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16d6b450sm9400544fac.3.2026.10.05.13.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:59:27 -0700 (PDT)
Date: Mon, 5 Oct 2026 14:59:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?iso-8859-1?Q?H=E9ctor_Or=F3n_Mart=EDnez?= <zumbi@debian.org>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 "Rob Herring (Arm)" <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Vagrant Cascadian <vagrant@debian.org>
Subject: Re: [PATCH 2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
 unless supported
Message-ID: <20261005205924.GF3724959@bill-the-cat>
References: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
 <20261004061826.1028380-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DnNtVLUekabGdy58"
Content-Disposition: inline
In-Reply-To: <20261004061826.1028380-2-marek.vasut+renesas@mailbox.org>
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


--DnNtVLUekabGdy58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 08:17:43AM +0200, Marek Vasut wrote:

> DTC commit cba90ce82064 ("checks: Remove check for graph child addresses")
> removed -Wno-graph_child_address command line parameter. Apply this option
> only to DTC older than 1.8.0.
>=20
> This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
> using system DTC:
>=20
> $ export DTC=3D/usr/bin/dtc
> $ $DTC --version
> Version: DTC 1.8.1
> $ r8a779g3_sparrowhawk_defconfig
> $ make -j$(nproc)
> ...
> FATAL ERROR: Unrecognized check name "graph_child_address"
> Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.=
pre.tmp for errors
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

We should just drop it unconditionally, both to easier match up with
future kernel re-syncs and also because the DTC commit (as I read it)
says the check itself was flawed / not useful.

--=20
Tom

--DnNtVLUekabGdy58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasQPqQAKCRAr4qD1Cr/k
Cj3iAQDGgsa/ChSOjzHKP8vsPc1o5hnkoPwbNYfJvBDvQIwtqwEA0xxj3+8qMASr
KAG3nG+RIeVyZYqtl6wE6C/qSJ1dOQ8=
=Q/rv
-----END PGP SIGNATURE-----

--DnNtVLUekabGdy58--
