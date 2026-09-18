Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6E8C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67495812C8;
	Fri, 18 Sep 2026 17:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXL7sJvOK8q4; Fri, 18 Sep 2026 17:45:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9094E812FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789753517;
	b=AK3Oz5bOWXwqE5pCpYy3xYqmX+Vxiei7aJzX08LUZL9UxtGRVe1uK3FYE9br/sWbl5eA
	 CrSxgTHVCm9hUdkr0Sf149ksGxFO9cvhy7kOAe6qOLncbcTnVP53LeOi/LTuznsVbWRvO
	 Zjibs0p9LM4AgMprEqIc7IS3q9kbVhrUcy/JKW+oijRrORBuD+7zq5a9drjqtn1KD80Zs
	 GvdWxaK/spmjopIGtOh0CGCF5o62i/mLJ7xAs0MpbWhQsuycTkSuKmuOsY6n6uZzeCnE2
	 tMUVT9i/LyxTiWG8vjXAlrNOh0OMqv0HBXUTU6rAndaj39tFi135jBvVPQTxmSE4BDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789753517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZvFU+4lRY4j6vDBB5JF/XRf6cKv/pBr34pWjQxgkqVI=;
	b=Tovo1pCf0r7XHSzSKlQy4spPkJlvQTpXqtszB4z8xHSb0ahHHIBCgr+V1xWJ+QbQ9AiU
	 xFJI8pDqTXUttu38jBPSAi4OLFsI92fLmmjFPuE0sDE4U3BwqDzAY5UdrdpPya0izXo+T
	 G3IIGl9diL+xNQ6rYQU01xx+X/m8KEwqBK/PxD++O0pEvmySMz/j+aae63ANBtSUVrocM
	 0Lzr/k3yZJ6SA5OeU1mHKdpC09mxF3VqkrPc+F0CA8uOZ0Hlx10BlhfksnhuZbl07IKMd
	 43IXyH8O8mnvkHQ90mda+qi+L0u27rjCtPsbK0f+Jwg1PYRaIissp+fImz7Kw/CRKgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789753517;
	bh=ZvFU+4lRY4j6vDBB5JF/XRf6cKv/pBr34pWjQxgkqVI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0c+dzRpO+46h8EM96KF10dbGjMjUNGh1ToAT57rf7vrYNxwUrBfVU2c/xLL0ZBtK
	 Q7kdu7dOjkkaILep7Kb2WBW9ypk+RxG7gSVtGl9vs68+12QROB11R9n7lCN5HjIpsR
	 Qn4oaycUsOxQHe668x3MTiL5dg4UCPpVto4cxjntBuxswLaiOeQOhKddcro54h+j2N
	 4sCScZMskeeea+OPPlEdLPaRZSprH0acGNOywbUGdiIv4RT25wabF1aX5AdoObI3E/
	 CULZQxSMVO3LMyuKYiRerGVM2RlyMXS/fp9mc7v28/OIoJvRpb6BhYhak8eW45t5bh
	 +NPPaCuYChgTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9094E812FF;
	Fri, 18 Sep 2026 17:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3462B25B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A91F60D56
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WbhjZ77rkoJi for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:45:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DC29060BFF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789753515;
 b=qR3wkekp/Snv9fzKoR9XgDXj99J8PxEYif8BAlRPKJwsegVBdXRdovU2orO5tT1VH0AE
 KvsyipT4aCylOZSuD2s4CxmUKgQj3vlCq8KW9t5cjDdmtATY4EBA4QVV2zRaGHDKHxXGw
 Zr7ckkdUBspm/plCcUcr8WkATrZ7+Xye1JPb10SoQXG6VnlKRdiDL0M21ul0vGzE8Uq9f
 Bm/OfGC0rDFKy2SBznZbrmHm10doEiJIB1rTO7jXf1OuRm02t25v5iT5sArVpXkXHC7wH
 doO4owjjQUQn8XTWLFzYjXecdBb1C/faRFvghO1b10oFKvJglAgjiL7NkpEh1AItNtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789753515;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=ZvFU+4lRY4j6vDBB5JF/XRf6cKv/pBr34pWjQxgkqVI=;
 b=XpLpXGr3ivEh/mMfqTn6h81WsNsLtR3YsawuXAKHdNwlagHLegaAg0PQewZVLD5XQeMO
 Pd1k2ZfNnK1ycDND26fq62IExHszisF2VjAVG9XjRp2wI21dLCOch9vozdZOLPPvSrrPp
 zLUWK7HXoA3DV37W9MCKP1V+igZR+g2l7RObxQBmCmlAMLA1w1D2vFTWJFfp7D86BUdfP
 1Os/2Qdu2jumygv9Tj5lyzpXR08Jm/uaXXnVWoHT+2KRro+UeLgUkEsJibYwdjgYoa3MA
 aTGMjWa5OUOGHa+Nu78s6VHVFLRp9ni0Z1k9ie/S25Q8vE8K3RZYZrlZZKYAVs6dtNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="DFcid3U/"; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=DFcid3U/
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC29060BFF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789753504; x=1790358304; i=xypron.glpk@gmx.de;
 bh=ZvFU+4lRY4j6vDBB5JF/XRf6cKv/pBr34pWjQxgkqVI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DFcid3U/BkLVJ/bSWhiDQSpkvPr4Zqu9vbeHFpYHZkC4VPrkRdHhwzCPFlfEBos+
 wYv0xJUd4eEF70I9DYskIsXjXmgFauP+wXW3I8gVhgh4o2uLng95Dde3bOejoKRXG
 XZSsjZvGDgeGFMMH1yTl0P4cg6nk1RqJFIW4It3RzuOm/xnAue54P6QEfcBAwPN8f
 bJWiCf0BVjq4DLpSLeqrWIcprri/bFdzz8M+UFLD6pd7d5Zyxbm/DNb0UTCJDQ8j5
 hVefKqcry9zzc8VARqJNw0V4CCs/2nT9JXga2ezfDbUK+dXn2P3diplp8s5KF4D7t
 kXLjtX2o6DAM3iRxSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1wUz2j0Hoj-00anji; Fri, 18
 Sep 2026 19:45:04 +0200
Date: Fri, 18 Sep 2026 19:45:01 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ayoub Zaki <ayoub.zaki@embetrix.com>, u-boot@lists.u-boot-project.org
CC: trini@konsulko.com, mkorpershoek@kernel.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 heiko@sntech.de, raymondmaoca@gmail.com
Subject: Re: [PATCH 4/4] doc: describe ML-DSA verification
User-Agent: Thunderbird for Android
In-Reply-To: <20260918172127.66014-5-ayoub.zaki@embetrix.com>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-5-ayoub.zaki@embetrix.com>
Message-ID: <ECE3740A-001A-4481-8471-5157A934D25C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LIc4D39w11S9yNz//p8Lw5s0lqaNo8kLv2Y8c8F0shoGHaT6fum
 roVxyJmpl3d4GyvpKrUj2Y76NBK8F2ZPNcBi0xZUEP+KGMSI5MgA/h6XgxGADFc1WO5c3R5
 k2BNeEwQCeb+EPNOnsRoytSRcv075lkBDKBPs1+viYEJYXdU6qf2f46PJSKv7i+E5lX0aRj
 ElxFbd+qQAEENAIoDPBfQ==
UI-OutboundReport: notjunk:1;M01:P0:VMQlDgFXV0Y=;Z9q96y+pAcrddd44RtD6xJhQj/N
 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
 0cgdV8uWzyO0tU9lTxLS9G
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

Am 18=2E September 2026 19:21:27 MESZ schrieb Ayoub Zaki <ayoub=2Ezaki@embe=
trix=2Ecom>:
>Document the verifier config symbol and the raw FIPS 204 public-key
>and signature encodings accepted by the public API=2E Describe the
>single per-parameter-set workspace allocation=2E
>
>Record the exact Linux file revisions used for the port=2E Explain which
>kernel facilities were dropped or replaced by U-Boot equivalents=2E
>
>Note that the initial API takes one contiguous message=2E State that FIT
>and mkimage integration is deferred to a separate series=2E
>
>Signed-off-by: Ayoub Zaki <ayoub=2Ezaki@embetrix=2Ecom>
>---
> doc/develop/index=2Erst |  1 +
> doc/develop/mldsa=2Erst | 67 +++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 68 insertions(+)
> create mode 100644 doc/develop/mldsa=2Erst
>
>diff --git a/doc/develop/index=2Erst b/doc/develop/index=2Erst
>index 51fd68fa04b=2E=2E61feebb0bd5 100644
>--- a/doc/develop/index=2Erst
>+++ b/doc/develop/index=2Erst
>@@ -16,6 +16,7 @@ General
>    docstyle
>    kconfig
>    memory
>+   mldsa
>    process
>    release_cycle
>    security
>diff --git a/doc/develop/mldsa=2Erst b/doc/develop/mldsa=2Erst
>new file mode 100644
>index 00000000000=2E=2E371746edf21
>--- /dev/null
>+++ b/doc/develop/mldsa=2Erst
>@@ -0,0 +1,67 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+ML-DSA verification
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+U-Boot provides a FIT-independent verifier for pure ML-DSA with an empty
>+context string=2E ``CONFIG_MLDSA_VERIFY`` enables ML-DSA-44, ML-DSA-65 a=
nd
>+ML-DSA-87; it selects the generic SHAKE implementation=2E The public API=
 in
>+``include/crypto/mldsa=2Eh`` accepts the raw FIPS 204 public-key and sig=
nature
>+encodings=2E It does not parse PEM or DER and contains no signing or pri=
vate-key
>+code=2E
>+
>+Verification makes a single heap allocation whose size depends on the
>+parameter set and ABI alignment=2E Targets with 8-byte ``u64`` alignment=
 use
>+8800 bytes for ML-DSA-44, 10336 bytes for ML-DSA-65 and 12896 bytes for
>+ML-DSA-87=2E This includes x86_64 and 32-bit ARM EABI=2E Targets with 4-=
byte
>+``u64`` alignment use 8792 bytes, 10328 bytes and 12888 bytes respective=
ly=2E
>+There is no message-sized allocation or copy=2E The workspace size does =
not
>+scale with the size of the signed data=2E
>+
>+The initial API accepts one contiguous message=2E Its Linux origin does =
the same=2E
>+There is no FIT or mkimage integration yet=2E A follow-up can add a gene=
ric
>+incremental API that lets the verifier absorb FIT signed regions directl=
y=2E

Can we add the api header to doc/api/ and link the generated documentation=
 here?

Best regards

Heinrich


>+
>+Origin
>+------
>+
>+The verifier, SHAKE code, APIs and test vectors were adapted from these =
exact
>+Linux file revisions::
>+
>+    include/crypto/sha3=2Eh
>+        f1799d17285ca99243328cd92133a9f84ee3a593
>+    lib/crypto/sha3=2Ec
>+        0354d3c1f1b8628e60eceb304b6d2ef75eea6f41
>+    include/crypto/mldsa=2Eh
>+    lib/crypto/mldsa=2Ec
>+        ffd42b6d0420c4be97cc28fd1bb5f4c29e286e98
>+    lib/crypto/tests/mldsa_kunit=2Ec
>+    lib/crypto/tests/mldsa-testvecs=2Eh
>+        ed894faccb8de55cd755e093c4b0971f190d384d
>+
>+Each imported file header links to its corresponding kernel=2Eorg commit=
=2E The
>+SHA-3 library was introduced by Linux commit
>+``0593447248044ab609b43b947d0e198c887ac281``=2E ML-DSA verification was
>+introduced by Linux commit ``64edccea594cf7cb1e2975fdf44531e3377b32db``=
=2E
>+
>+The Linux SPDX identifiers, copyright notices and algorithm commentary a=
re
>+retained=2E The module boilerplate, symbol exports, FIPS self-tests and =
KUnit
>+harness were dropped=2E ``crypto_xor()``, ``mem_is_zero()`` and
>+``memzero_explicit()`` were replaced by local equivalents=2E ``kmalloc()=
`` and
>+``kfree_sensitive()`` were replaced by ``malloc()`` with an explicit zer=
oize
>+before ``free()``=2E The ``WARN_ON_ONCE()`` in ``__sha3_update()`` was r=
eplaced
>+by an early return=2E
>+
>+Testing
>+-------
>+
>+``CONFIG_UT_LIB_MLDSA`` adds unit tests that cover all three parameter s=
ets
>+using the fixed Linux test vectors=2E It also adds FIPS 202 SHAKE128 and
>+SHAKE256 known-answer tests::
>+
>+    ut lib lib_shake
>+    ut lib lib_mldsa44
>+    ut lib lib_mldsa65
>+    ut lib lib_mldsa87
>+    ut lib lib_mldsa_invalid_alg
>+    ut lib lib_mldsa_use_hint

