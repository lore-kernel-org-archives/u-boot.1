Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A21CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54A8F808A8;
	Thu,  1 Oct 2026 17:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oa6r8lTa3I67; Thu,  1 Oct 2026 17:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 76D1A8085F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875333;
	b=gnTFzICw7Dj1Ef1Bpi+VE0zUqBdcTL/5ZEmgKUBq+s42vBrbZxihe4CeyzrDs16TfdaL
	 o6VzYAS8nmVcf27vDvcjMebc7PliTH0nAgtvaaJO6fXsvbziJaBkXk/cNihwVY5Hkwe++
	 nkoI9UEFJ10ld7+1/Y4Kc8mGCP2SFTMIeZE+HLJ8KjVdTnQXu+V1NW68a+FoXd46BH9DO
	 G1xThXt31LNs4Vz3VcTT1FFco5hgOQ4DX4MGSBBajlcyoL6Bh3vUX/DzKMmWSPHit+ZrL
	 SZQFR+L/d6wSpO915QVkmahbOHUKx6qmNadCpfDFa+DHNHuMhSMsBibA0kRK+kHsdXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
	b=KWZwOpv35XE7J7WpVheR+8ZQ33pP2+XO2Ocw4pWc8scS4T5qWNlOvXbm3BPUW2yhcKPj
	 iiDWplsfQIsYkLuGjsazFqjHlx+VrUb08RzRNxSvOgXvUvRFTmJCgl2c+982xCR/BNAfX
	 hFw8g1/H0HYomQA87MVbVUTamuYUv5HzaOnLzYVB15orq+dxfTR6FdjYs5CyE+2ouE9Y5
	 HoQguHXmnPCGW9qI8AzGAnVzLPClhmbV25TItv/Uw8DbhNBZnItTh/yd1WAVtG4P9xdD/
	 t1K0LOXgKbIB10OdE9WfVc38Ek9OKdFLvPGoBxBHlcFOaMckcADS2vEGQgX4WR3/BcQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="A1/tPaPH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875333;
	bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MbFdCqWXiQOiRMz1VJ/cQWTtwq3VG8D6RJqxT9UudG8ggNHExHnNfAu0kF9SXIE2l
	 86HC1icji1LK0FKDBdyiQ0ZHJ/y1rLpgoPvHilgDmtWlo1YfNinMf9U/nq+KknNNPG
	 2Oc/kV80HCiXr89A+HkML0cYRHZJZL7+D3MMoz8Dpd4j5j7XrnyJazz707LK4GI//7
	 DwVHN1w49MPsDComFeQVeJO8BKJELO7pK7VoEp8zc4y//NIDXIt2BJbUIxETnsKK1O
	 fgpwE8Szv1QUcA/K3CuDF3+AX345GWXywusr1EeD6ud2tc84tWjhE4iOhFKKawplj2
	 4/0iTaUGSjbzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76D1A8085F;
	Thu,  1 Oct 2026 17:22:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B4AB1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 311128125B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5okGQ8LKluwB for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D850581259
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875330;
 b=bKO4mSaDdYn6w18GW1oEcfvn3oYDkxF4sw5LCak9tJyOzvEfkx8Yyaq+FPQDvu3S/cnX
 P5GLMUIRy43HMLSgl5u+j2i8eiqnDTFhpRXUIPCCkARZA4X8v2Spwdwtgj3EwmgyEFKbB
 JJyzEcIuosvVmnafFh8f41v0VRVDOycgpXAmJ5suwUqhhQQIsnY3FEadsz3maQtcAmQ3U
 5phjX0KYOT3HQt7OVoR0CcdbnlygKZfbN1JfFDC5gVSFNhJMKx7Lzon5Mql+/YEhE0hiN
 S97stmxVR7Mi5opC3RKHGCIHMUnSHOgLDXpDKvW8rqc9oYzyIFLeT8DHNFUhl7P8QWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875330;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
 b=sf8KtEi4+OJO+Gawxkr4DydF5HdG8+Mqw4G6WS2zyCEj0QOzP1CZ7yeng5HqcBEJTpDn
 pEnCS0kUX7GtCKJo9f6ynkgEOFoif8KmKQYSUhGvTxWlivLJLddtPYqE2ZFAcrPISPaPK
 6/pHHsyVueIRRkGVmfHr4ya9BviL3lq6T1sk87TRiHF+l7hB8wZG6A4n/75s7lSwWHJSU
 R/uxkxRfGjn+uQcItvzc5gEjV54MATsExAzcfA1GPsU+ggeDlJyU52N7OEkTLhq8dBZid
 DNUyddEXMhPXGYbc9whVnXjxMAHcfxv31JRmVQ1qCjigqOBhgNU1ibO47XcQo9CV0Dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="A1/tPaPH"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A1/tPaPH
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D850581259
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:09 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acae8342d2so543305a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875326; cv=none;
 d=google.com; s=arc-20260327;
 b=ZgkKfoTbRB71t/LlBdOJXnk2qNeJI1dE91ot64NoPWgXly0wEVMPK03JGswa6f1f/F
 qzDNyGKoSGfJ2cJ+vovof1WYI+o6Zj6J3F7IcCzGqt+VaalEpzSJL206VH0BPMaNBr9r
 AVSPoCJmm5/OMvFHLfp2zhZSkqmGRdbNPht258css/BR1+ohTBOkd5e8sW8BEjAHCwly
 uih/vHYMF1FapX2UB19lMyhah7AVdZbm2riqu1cbvAT9AHvCiAUak5InZAv2ZqZ8tZyO
 yjXbjLWZjwGEVc7Q/lV6Li5EMMy2e1Wzc1zlDYyNgjLQcDEWdJ6KkzZa1F2g3iRaZG3b
 QV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
 fh=f+3YHrvj6jGhkBhPyVUqKuV+eWYFrOfCOWHRGid3M5g=;
 b=nmnlfB9dooLHsMZdOOcKUOIV7fh3MSiD6KacLBU7Qu2KmkHxar5UfhCN8wWT7Ro9Fg
 wG3prXtFPQQSc5ldEpX/aiODa8Tk9o05G3/UPf+RtpJ7cJa/ZEe/5AxLXdOuinALSvTF
 ZYtCzDCd68vau5ZAOvvyzKC4s23+ynp3mNtFwJm7sRlZXAf4lf7OMqDNQNbS8QGuysTc
 HtJZ+1ITfhHUoJ4N9VTkm164yGqF0QCupg5G4tPDgmFS3eIa8x/OqofGKYYJ32gZZ61u
 D3O05npehj2i6H3vRxFGZxeongoxkWN94WLfLaaLSlI1kDfKTDZnjVpkfnbav8BwvEf2
 9Y8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875326; x=1791480126;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
 b=A1/tPaPH4dje/pbMLp9rND4tIPams2GLVaHwVivfswwI7jifvKnTxAA11j1pwnzSmt
 HuTJnrpYaUmBYV+n4CxlV38dwo6NtVuRkCxwaJc/RcVB1DE9ITTKZO0jwml7s71m60FP
 lN0r5/pPDPTl8TNVKRzS2Gq0LKT40pkG/aHlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875326; x=1791480126;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DhZAdX9rgY+gN1AypYIV7z9zM2WrZ/lvBXvXn5ar4ak=;
 b=NPAjOIJ5MZbgLtrVG+aBd4GF0Z9PyBIYHiabz/CXEk0duawdrt4vnwSTWpXfq+tdBC
 V9mUq5mJhlzbcsoy8h7Fw+1k2dPPWZl12OD+tzaabkzCAiMod2nifcfdnAoFyOKEsvYy
 Ezj8j6oVin47oimNFyr9gb1GBoc7Wkw2D4waLj10FlDB6eRPR4YGfdTY6vYR1qUERXfn
 nHJUTGTpJRulNu7vgUZ0P9ZNII8YQr6KLE7UtedFWPhx+GGba5FIYB90duLutrmuJyAG
 /m0R09VVz+8Vo6uPmThYVLuw4ljqG3Hwg4MFG7jy3e2/PYkjclHnxe+ai7eo3HxyzzYK
 8DaA==
X-Gm-Message-State: AFq9FYJnMOBy0PmG3YDwb83CzRevqxZXZQH083UZny4rl7Zz1jc4ao+1
 zY7u42RFvFv94z5v6wXz4dmjptUoo/ISW02jI1nwPHEgcQ+Iiy8xuS+BEUPpYJKdigdX6M1C6tF
 urA3Trru6VQIFDbu7yUy4J6PbPheAxxd8tokmjhCb
X-Gm-Gg: AYBFou0Ln20EMgwdBYKVa5ugbIH7P1D0c4IMdfkUX3CBDTEQ7cjLapSHvQNWD5w+YE7
 wA5/jWV5Llo32C25JZ48JT0jLk0GG8baRqwmumhT51CET2J1OIjnrPBqr23mrYm9rnLKwws0cg9
 D9pQOVK3/TJ/ion0WLcC6IJ/66ifwYGUzhZVCIQeXcXkDk9bdaNNti1R5q6kYDNFrFdqJyrFccT
 Xd0LqmZJ3BHz9LsbuiOZE75y1hKVZ+T0UlqKE2JPHdbkWWBFU5HxcP2TfI8XT1T5PWy8rRxqGtK
 77Fa5nWibs2yX5oyf2+D/J8t4JSoiUK9e0fJ9sI1TY7ixcJj3qYmRFXqLg==
X-Received: by 2002:a05:6402:1e91:b0:6ac:9a44:d3fc with SMTP id
 4fb4d7f45d1cf-6ae199623b5mr4168083a12.37.1790875326164; Thu, 01 Oct 2026
 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-2-ayoub.zaki@embetrix.com>
In-Reply-To: <20260918172127.66014-2-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:21:53 +0100
X-Gm-Features: AclHuK_b72Y3jL9tOiw-GDKDwyztC57jlKQM2eEFUNncTa7iUR9hKXdu_Zpt4e8
Message-ID: <CAFLszTiyKg9nC_MyOBYSLt8csu8ZxBxyJ=gekfthYGuXAz9kpg@mail.gmail.com>
Subject: Re: [PATCH 1/4] crypto: add SHAKE128 and SHAKE256 support
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 mkorpershoek@kernel.org, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, dlechner@baylibre.com, 
 hs@nabladev.com, xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Ayoub,

On 2026-09-18T17:21:23, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> crypto: add SHAKE128 and SHAKE256 support
>
> Add generic incremental and one-shot SHAKE interfaces backed by
> Keccak-f[1600].

This patch also adds the fixed-output SHA3-224/256/384/512 digests
(sha3_224() etc. and the sha3_ctx API), but the commit message does
not mention them. Nothing in the series uses them, they are not wired
into the hash framework and patch 3 only tests SHAKE. Please can you
either drop them or mention them here and add known-answer tests? If
they stay, the Kconfig symbol should probably be SHA3 rather than
SHAKE, since it builds both.

>
> Adapt the implementation from the Linux SHA-3 library introduced by
> commit 0593447248044ab609b43b947d0e198c887ac281. Retain its
> provenance and licensing.

This patch cites three different Linux commits: 0593447248044 in the
commit message, f1799d17285c in include/crypto/sha3.h and 0354d3c1f1b8
in lib/crypto/sha3.c. Since you plan to track upstream fixes, please
say clearly which tree/tag each file was synced from, ideally the same
one for both files.

>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
> include/crypto/sha3.h | 353 ++++++++++++++++++++++++++++++++++++++++++++++
>  lib/crypto/sha3.c     | 382 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 735 insertions(+)

> diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
> @@ -0,0 +1,382 @@
> +void __sha3_update(struct __sha3_ctx *ctx, const u8 *in, size_t in_len)
> +{
> +     const size_t block_size = ctx->block_size;
> +     size_t absorb_offset = ctx->absorb_offset;
> +
> +     /* Warn if squeezing has already begun. */
> +     if (absorb_offset >= block_size)
> +             return;

The comment says 'warn', but the code silently drops the input. Linux
uses WARN_ON_ONCE() here. For a hash this is a nasty failure mode: a
caller that misuses the API gets a digest that does not cover all its
data, with no sign of a problem. U-Boot has WARN_ON_ONCE() in
linux/bug.h, so you could keep that, or at least somehow return an
error.

> diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
> @@ -0,0 +1,382 @@
> +static inline u64 sha3_rol64(u64 value, unsigned int shift)
> +{
> +     return (value << shift) | (value >> (64 - shift));
> +}
> +
> +#define rol64(value, shift) sha3_rol64((value), (shift))

U-Boot's linux/bitops.h lacks rol64(), so I see why this is here. I
suggest adding rol64() and ror64() to include/linux/bitops.h, matching
Linux, so this file stays closer to upstream and other code can use
them.

> diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
> @@ -0,0 +1,382 @@
> +#ifndef sha3_224_arch
> +static inline bool sha3_224_arch(const u8 *in, size_t in_len,
> +                              u8 out[SHA3_224_DIGEST_SIZE])
> +{
> +     return false;
> +}
> +#endif

Nothing in U-Boot defines sha3_*_arch, so these four stubs are dead
code, as are the __maybe_unused and the
sha3_keccakf/sha3_absorb_blocks #define indirection. You could keep
them to make Linux syncs easier, but then please say so in the commit
message (or the doc in patch 4) so that later readers don't tidy them
away. Otherwise I'd drop them.

Regards,
Simon
