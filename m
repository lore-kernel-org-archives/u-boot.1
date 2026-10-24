Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IsVVz5hf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GtT/2f87
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71C92815CF;
	Sat, 24 Oct 2026 06:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ER9Km5eYim3r; Sat, 24 Oct 2026 06:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A05408162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823604;
	b=kkOXEdOlYJSBphMpropAZkAgtNbh4y0H1jljarRTcIQxELUe/Qx2fKm8Sf/NsA/NhKWE
	 vEFMf44Al+mvpDoDNb0EQcxv3PIpnbtiICez5EFrtQWZptrCu66iu5BH5k0tojDXgRFgY
	 3I8H1B/baJoAMswu07dqD+7atCwSFdZBgRybet46mPTkrD4XpltO1a0/qtZGog+/QqC1/
	 mIo/TZiXTyUn+K7rlVLXCeSmH5nTboUrvRqTmwICfVh61EKxPoGic7JwD/jCMdjJhsIYj
	 vLuH1KFjT75R9wVpvis/QFmi4tN9rxIbtOej4HgFylsWQEnGMYKpe9P5QFaIU/gzoZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823604;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
	b=aqk7puhH95HNbs1RcNg67XysJtqw8Ux7C6ofxhZGdlQ2wAY5Z6Pwz/Aa4OyoyDgufiki
	 ZScq3Bg/nVLpoGTJzg0rKg6Ju79KoH/e5MZui182gMmGn7JEpEke0eWmwKKVPsa00w7tJ
	 U6Lo4w5Mgpxq8c6OcQsv0AduJMJQuJ/z+J+hKH1jaggT1l8KHO8N40TmtbSdmWqLuUV2V
	 yPq0ps5z6XdZTbfApTWJRomaPffcU1S1bd25Ce3dA6ddsY9RdQq+Yd1sQgjuHzdJJaQba
	 ejYQxkkVp2bKn7zD+K3LK3FWZftzplHc9aiK2fpFS6bSaUOTBYKoF9AOHx3aOhirN5Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823604;
	bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IsVVz5hfiLdC5zJuGDD8rOELD0M41A36H4wd3jzCa6Kn6wq0IHk8DWjtD2DuSqcKT
	 c4S+hT3nMoZ7oFE2GtgKD4ikYDVuoBtCxHxo5jIvMcEjlBXnv5tEEkPCGo7Y/8eP0e
	 fTWKdjbBqlC4QE/tLX75lZGeEwSN00kXhXCEhSVi56beWDrca/m6SSIl3lXF3RYWwy
	 08Jgqf6TPxsMa2bKll0KkIJjLHT442Dd4oRJdyBTH1DYVugzgg7M/n6zh4DoOab+Ms
	 w0pKmP3T0SJhMa54jLYUE6s6u3goai6xB1je/d+p8Jd+nLDcTF0AUKBniTyK2SHoKD
	 Uq8yDpDMs/XbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A05408162E;
	Sat, 24 Oct 2026 06:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F603C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C279D400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akqc-2dVL4dB for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A700840068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823602;
 b=RYgOQ0ymJPCH4hIRIymj3z8qfnATwa7kzHJmSz6aD7wRcxPS+JCrCIzeqRKgk/kB5mKc
 xdODlxZZ2ZGY2JQlzcXIpOajxcHTm8wA2eNgjm/q+NMB0a7Hel9YSao9K3VVmSgdmMu3R
 P2HsL6H0sacAcZINwTyff+rprx3ZPTH8my34kuf2CmEdPb3+rLZmlesviLCMmhDc6LmBo
 7LsBNFIrMfF25ynp5oU54tnGN1Kg/VhKYI0Tb5gd/h1dTWsBSIj9XL5F6afshIkkOLfQi
 kRXfZ/6wE3OLihR1rY2dX3nTOTEyhjXGkLfaZcFouTmCvjsW1Ieee19fUwxmcp4UTgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823602;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
 b=scocz1y9zUyNJuaPadwtZMgzJdNFiSDpgASXT6j1Brh5CVoDckrV4DusL/V/bMENDQQI
 BWTAgsvm4X6DUD2apYoyCwjqwgfuXXrMM1TyRuAbgHK1qlhdKyrWDwhsrw8qX+K5iilPd
 v+T5fx4oN4IFOYxqJb1BA0iBOlxG+er+Rj+84duwXTdm6z7IoaXw4TWCmTCvK0iUtDXM/
 pTPtNqhBIKGDVBggKavhlMu/ZMKBi4h+g9sOcoHTLHXM9yBqGJsJaWtjGjxbLkY2sBVtC
 5VHxk6DEEtndrjJESLZs2ZgpfwI0ASV2/JiCPQ9W2N9LGIfDXFJzKP7Xf1BfBzLg41g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="GtT/2f87"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GtT/2f87
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A700840068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:21 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so230670766b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823599; cv=none;
 d=google.com; s=arc-20260327;
 b=Jy8Vzm41k06G+jBlTWcKR68LL4FIYvu+ISVJ1SbUTcypMKMoljUS6MF9d1VZOjkpDx
 pPVaGdUUpqYh2yhppAkRNlsEf5W2rQaX80tL3zi+mzKcpWSic29EFulpYKyxRSlUe/PG
 1/meK5KwX55uRY1v7G7kIDroEUIGqdo8q5Y1utbU7gBEY/amdglslYaEzAVLWMs/IH2S
 hZLNHLLKVSEGAnRX50QQ9en6NE1mvtAgMKVDc4CMzt3RHId3/mprdrBMfaW/ZyoSVlOo
 ROXeVXZl29dyLRi0OkFj7AYUtfkxTKVUW4GrPaPzAoD4Fp8/cfai0EFVci9CdghiYqhA
 clDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
 fh=e355Cz4I1/BM+7duu8PCPA4BzbkP1u61N10lKilSgmk=;
 b=anUOz03rIum2K68gewA+d60q745uJhX4Tae+eWgZTqIIUNL30wKZzF7pAW37V+GCbE
 CP+oqjFafolxrfXSz9EwAg2grvVxVrKBuq5fwHfNIW0LnffBQcQKk+/kDzsFhHuURE57
 0SuFzs8bykh9HxmAjzV/UZQgOddvxabCdaeCpKXD4YDq3YfAc4/e50fGlETcBE0tZSqb
 KTj8HY9ms91/JO7TSXi6wLTIfgulu0BQgjRYHeMvfsslDLkVrC/4rJde+Wife60galQM
 AEoArthZwWkv3FG4UHPlbx8CgQI8fAEXzCde1w72i9CySyZRk9NkrCWk56EQgp8vVJKb
 X9lw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823599; x=1793428399;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
 b=GtT/2f877fwXThy3248f6qATut4EXnQhkY341IynmRkv8bIAuPF9sYhbMaJ0S8KIfq
 fu8UBPU1UM/E+RF4KQeFXe+vU6QqS2PlkGUv3RMwBjT7cVUsIV4qzUIzivaWkOYrOp/Y
 cEwXZl3KhFbj8v3/7RZ/O8Rr+oSi9390GQ4Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823599; x=1793428399;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xwo2Y8cd7kx3FfAqNFqM1fvWFv1PwMLIu3VmuZKPR84=;
 b=KG5IrH6sl/96UWuFrxSsCWcOIk54i0PVPpNH6tGjVDi71x+FMZrFkFYaDg5KfYYKtf
 FZMZSPfJVCjUIj389yfa2GweK+XFmZNjDFI7CrBJl+EP1vwPx6xy9YpZkjwWTFFNmk99
 44yDvuOd10MfZd5bLeo5d/KVNQ5DG2onpCDoqexCYOTUACUvUi6yDbQJQTrisCf8cdR/
 jWIL9p3rTGon94cnHZjhQ1WKD+gmN2STvRSzHSMt2fPgZhzBdHJUsGgd15/DzQSI/Hmt
 1ElECA8pbm1TrLzW0DTVVRg25v/dvJ66xJb4Smj1c/EHew6VMTwDRDoFjLoEaSVqPwDb
 vRcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaGgoYDrJ6jJsDHgy3dmVNPE32dnXDe6/R7G+bEehOeelTAR3aS+cqeGQitOhUstfbyJSk7nY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLOizZ1I581aV54+FyafMckQ/W7q0ank+LzazUEfW3nZ9h+k4tY
 SN6FMQVxfzbRkhXDWF35Rho4oq+4oYFXbqi7jDLwm3Qc5e7veAIg9TA6R3mHMw3a95RLvpySfZA
 C6w4NqGuBs7otQBqRufTTXmuRI4Vw5tsXZ+sT30T0FLyryme0i6ExgA==
X-Gm-Gg: AYBFou1kJK29OAuMz6Lk5PnNbd57pL4TitMMIfUrxZEJEozc5t1tkdcBYVu7T4tQJOZ
 VhRW2SVYFu3dYX5OGc60IvM4Q4EoJ1Q7mVpjvZZncas1v0/ApNcyPbukN7WY3SNYUkns62OH1g4
 7uZ7x4yyOzYjCzBHVRqTx4XVfCjAjjPyN7mzTUT1Y1rbYTgXhFHQVugneher00zy9KGoZPxqLSs
 9ETlLCZuVURn5KoKzxpLjcmLe5JmMNkRdJ5Vp6xWlqzfMf5qwsh0jQjHurzbKhom9BOYF1rUxsT
 VioDlZ+ijo2axHFPqRkqa5QTq2zn5xygRAHIVMLFHX6wgq+TOuLs2MB+82r/zj3CjaWF9+6+/QY
 ftOystwW+j2oP/NZgbHrDS0+/eSu6wnO3qiwYkBNvd/zM151EyAy7FRHD
X-Received: by 2002:a17:907:3c94:b0:c46:7645:86e with SMTP id
 a640c23a62f3a-c46bdfde1a6mr112594066b.42.1792823599214; Fri, 23 Oct 2026
 23:33:19 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:33:18 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:59:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023090611.778581-2-yan.wang@softathome.com>
References: <20261023090611.778581-1-yan.wang@softathome.com>
 <20261023090611.778581-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:33:18 -0700
X-Gm-Features: AclHuK-QDT9gRhFcxdc0n1la4coAUET-qYrOtmzIAud-GHF_KL7r_Z1eXK0YVco
Message-ID: <CAFLszTiB=8FQhLJY8ywe5V+ZNz0uTeMS38=xDyiaqGXbO4CQGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] binman: bintool: Add PKCS#11 HSM signing support
To: yan.wang@softathome.com
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yan,

On 2026-10-23T09:06:06, yan wang <yan.wang@softathome.com> wrote:
> binman: bintool: Add PKCS#11 HSM signing support
>
> Implement signing through pkcs11-tool using the PKCS#11 interface,
> allowing binman to use private keys held by an HSM.
>
> The implementation:
> - adds the public method find_slot_by_serial() to resolve an
>   HSM token serial number to its slot index;
> - selects tokens by label or slot index;
> - selects signing keys by label or object ID;
> - verifies that the requested mechanism is supported;
> - writes signatures through pkcs11-tool's output-file interface;
> - passes the HSM PIN through BINMAN_PKCS11_PIN and references it as
>   env:BINMAN_PKCS11_PIN;
> - requires a PIN and enables PKCS#11 login for signing.
>
> Add comprehensive unit tests covering token and key selection,
> mechanism validation, signing failures, and successful signatures.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
>  tools/binman/bintool.py           |   8 +-
>  tools/binman/bintool_test.py      | 497 ++++++++++++++++++++++++++++++++++++++
>  tools/binman/btool/pkcs11_tool.py | 339 +++++++++++++++++++++++++-
>  3 files changed, 837 insertions(+), 7 deletions(-)

> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> @@ -273,7 +273,7 @@ class Bintool:
> -    def run_cmd_result(self, *args, binary=False, raise_on_error=True):
> +    def run_cmd_result(self, *args, binary=False, raise_on_error=True, env=None):

Please can you add 'env' to the Args: section of the docstring, e.g. a
dict of extra environment variables to set when running the tool.

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +33,326 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        Use pkcs11-tool's '--pin env:VAR' option (available in newer OpenSC
> +        versions) or a protected authentication path where possible.

This reads as advice to the caller, but sign() now always uses env: so
it is out of date. My question from v1 is still open: which OpenSC
version added 'env:' support? I believe an older pkcs11-tool uses the
literal string 'env:BINMAN_PKCS11_PIN' as the PIN, so each build
counts as a failed login and could lock the token after a few
attempts. Please can you find the minimum version and mention it here
and in the pre-load documentation?

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +33,326 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +            fd, digest_file = tempfile.mkstemp(prefix='binman_digest_')
> +            with os.fdopen(fd, 'wb') as dfd:
> +                dfd.write(digest)

The pre-load entry never passes output_file, so the mkstemp()/unlink()
handling is used every time, and the ECDSA digest adds another
temporary file. Please can you make output_file a required argument
and have the etype pass a name from tools.get_output_filename()? The
digest could also go in the output directory, e.g. alongside the input
file. Then the files are kept for debugging and the cleanup code (and
the unlink-error test) can go.

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +33,326 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        run_env = None
> +        args += ['--pin', 'env:BINMAN_PKCS11_PIN', '--login']

The 'run_env = None' line can be dropped, since run_env is set two lines later.

Regards,
Simon
