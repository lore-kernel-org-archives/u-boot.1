Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3443606A334
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tima5SWQ;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LWGEet00
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 559096064F;
	Sat, 21 Nov 2026 22:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ew52il4l--yT; Sat, 21 Nov 2026 22:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A4CC60622
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795298981;
	b=UdZ8PKqDs2z/ZvD0PO7qQ/R7UM/xhiX8kXzNCDNBSuoXQctU2m6x2fWeQ0imhAAqys0L
	 ONWEvnp64cffT4cJuUvecLj0UYKLA1rGRT8udW/Nk7E2ONHn7rKiDuzqInigaPnum3nh+
	 H+ZOsO7tEh7oMk/6Pqn6hadLK+juDOyxc2czifchH6Be93SGjR8SvTfM5SmFC3nm7CD73
	 tOC4FZ0HDg9GOx15ZgMOmTXD3hqfpZA7juAQtYHmeBockHF+EdbNuXJaB9g6HosPXteCJ
	 b05C7+f3yZAijYqhKXUJvtCGbA7RrmcGUOonAA/Vudp3r1fqm4ieYNvhfoRrKK7B9dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795298981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KTlBZ7K1WKOTTbCZKSdr6e9ugN5/YAsyp8x2xoaS2p4=;
	b=FzNbqFjvOqqgXspY7enWC+B5H5d1drWwT4OSfZX2/TUw+T11VmnX8E6PSUPCaE71ttcf
	 jM3d+jwkO53WGL9L2gZG9DE7NTEyj/SukL9Cdkjwcd2A5qlO7grRLdO2zv0nZVlobKpGC
	 LuPho4HA/+hZpJEOs6pBmQimYfRdE9aG70gdE2oXSEUvkUWisvtYKUjkfWHbSoOgaLMPf
	 B/LpKP4XMG/puoUmo+ncIPXiQ1TQmh9mV6+T9C9ar2aVqJYcVHYzYwy5HjYuQtiaRwn8z
	 sm6FC2Fo5ZyvvmO+vSGxP5ifDzKWDQ8S+lPf3TF2FLt/DFfXGGF0EThA2lJJWExH58w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795298981;
	bh=KTlBZ7K1WKOTTbCZKSdr6e9ugN5/YAsyp8x2xoaS2p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tima5SWQJsjutwjNfJ9RzAsODh0IMeYIEjCydXQIIOfBMNWJlVxmBAn3ffWZo9PXZ
	 LRv6XWsVn0leGGIRSAJLjsh3UPj5uGyQeqV+lyxMXdWFrwNtJoe8M0puCZ6NPsJfvE
	 2PyUrR0lvK/zEh0bgVALd089L4cnTVSNO3VAevLQjXEKC+DsdsQaejOHjfgy3cdzGs
	 +knH/hq2d3d4mL5PK6NSxCpjkdMKj2DmOxfHqBreQJZmz4g4PLULm4fq8tgQXMw7gX
	 SB4eGa2DE0F/NlE3GVkEUm1fmQQLa6B2Pq6k5h03tQYDMeXsW6MJHQrN+19jQce8bY
	 A9iZxPV/EM39Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A4CC60622;
	Sat, 21 Nov 2026 22:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D5ACC465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C719380E18
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VI2QMufzcPdE for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 22:09:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D96C980DCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=LWGEet00
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D96C980DCA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:09:38 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-8633b750a19so79112a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795298977; x=1795903777;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KTlBZ7K1WKOTTbCZKSdr6e9ugN5/YAsyp8x2xoaS2p4=;
 b=LWGEet00XBWaWbn95TMR04SCbQckQZUo9mqL4/zWS92KyudyWl6Tbw48OocvMKIzKk
 pWLF2wlyuCMuD+3UT1WSRjQP75HH2cEuMZmvCJ0BO3saKaKdv+RERb/NRYzmTac9At24
 KkWtd/5v17SRB1D2w9ikDL6xQip38oYLcnD3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795298977; x=1795903777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTlBZ7K1WKOTTbCZKSdr6e9ugN5/YAsyp8x2xoaS2p4=;
 b=GBz98rjKVtFd+Q6hjTGdovdnAJWoLcGBJq+yXFT4h20h/q9GsPU6zBnxCuwCUt5IIe
 KIuDujTKSgcmERMORJkbbEO+XkE8RKc1eUNWfc5XP5peJhQ0ClNq1Zf1RjjCQ+CIh2N9
 LxM6rTGXEhrU/IUADa047ju6ARRHKHtgW5ezpEjmczyHDSSQiHaU1rKCDCMFRlpVg+km
 IU9ijFfXxw4mPqsDFrJLVmF39b7dqHuyQ2fRLCg3IXFh4bVs2sFtYQ2E4PQivaKE90OI
 9yAIbxhnWwNu0hDFnPtq2c4YlqvoRi5LeoM74NEwp551Oy+g8e/rjp6QAHMRRh8QSPMG
 3F2w==
X-Gm-Message-State: APuU4Z8AuDhTPWwyV5Y2Hz5WJPcTW8ReHuFkt5ElEiaFZ8pUPAHbNM7p
 8hUhqMBqOVyDY2UrWJveGYRQgaCfcIKc3LYnzCFad71ofLVmDz7mSU1qwgY+RNCNnljJkTqgXLk
 9J5QmqQGpvg==
X-Gm-Gg: AZFdTZc2+EMWnGh9ipytjLbmRlxcJM/343P1CWvA8Jo/ugVe/Fuoz4fNCnCK9tlnKDJ
 GO5TIvz/Qcxx6mwjxHzMNmBIq7/1fHj3WMrWKQIiGXjDkbOJ+54Rdb+pb2g4NxKx2346ZvrvXx+
 Emtdzq2HaXzaFjf+ooVUKaIYxHF/puDUvFto1hvCn/k31HAvAevNp0/tJnPJ1C7mrVXq/39K8oh
 Yl4viout9ysnMKeVmKjGKS1vR30wB67kkMtDNP6fLpuNm7adGDpBjiy55EQRhJhFPT3mAUe+uZo
 2L6WvzU7snl3pL6E7AeaHa06i56w0we67wqmx5vYIuwoWYDbWBhWrzET2X1/PdxAm0JcGL/OxAT
 Y4uxAYoR3Xx9zypKHsRJv5eQSttcDpGm4KZovjs4WZHaUPSHBhYdGSaSiKk9r6RbVyglUG3aya9
 7ShyuGbvBVSeBuZ9LI59iZzRjhxYXJroYdX0E9kjoApyaEOLS6OdjSPqCu3EXGneINLREOD+oDN
 ruE8AIkCE1CisFjZ+EpcOcHEnVISsuAt79fr7DxtDZ8kL72IYAdLgd0Nk/nJGXm3bKDk9CtUBbd
 b4zwn1n9bQXBulS938GBnZmLDpKeTVxQ0lW2liQMS+yK1lcEAiYadLc09YVcC73C9syiElmUfYa
 cyqjk311NmWaihmvS6J2AMYYGtCii1N04aKabxfKSsedHq0x4obe32bnZY8qbNsWvTFtaOcRlgn
 woGL4bLdGfCZ1FZXUyXbAyl86gMFecnCA=
X-Received: by 2002:a05:6809:755:10b0:57a:e9d5:f41c with SMTP id
 5614622812f47-57ae9d60120mr3453364b6e.53.1795298977457; 
 Sat, 21 Nov 2026 14:09:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34252987sm5303351b6e.4.2026.11.21.14.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 14:09:36 -0800 (PST)
Date: Sat, 21 Nov 2026 16:09:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PULL] u-boot-sh/main
Message-ID: <20261121220934.GJ3176972@bill-the-cat>
References: <20261121171549.948391-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wqmBIPae3UjNpRJV"
Content-Disposition: inline
In-Reply-To: <20261121171549.948391-1-marek.vasut+renesas@mailbox.org>
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


--wqmBIPae3UjNpRJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 06:15:29PM +0100, Marek Vasut wrote:

> The following changes since commit c1958b5f6cce03956d309ce422b5d9f819955d=
4a:
>=20
>   lmb: Check available space below the allocation limit (2026-11-19 09:44=
:39 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main
>=20
> for you to fetch changes up to 4726f0adcd0847b960a99ebf0c008c0ea4d85577:
>=20
>   doc: board: renesas: Document Renesas R-Car Gen4 Cortex-A76 start (2026=
-11-20 09:01:02 +0100)
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--wqmBIPae3UjNpRJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawIWlAAKCRAr4qD1Cr/k
ClS8AQCAafvRY3J/W9Him04K4sJczHTnTeOuLg/IpmJbVWxS4AD+Mg3Duk2FA2G0
6hkgxlYhevKVbaU5N9vekSaxEbNaYg8=
=SxZ3
-----END PGP SIGNATURE-----

--wqmBIPae3UjNpRJV--
