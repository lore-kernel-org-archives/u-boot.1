Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D3ECA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1133480FF9;
	Thu,  1 Oct 2026 17:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2fyBCccf-Wz; Thu,  1 Oct 2026 17:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 30F6680989
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875344;
	b=CtFeNXtwlNbD72O2dvIcRGZfuV42nHJDzpYNOXLHcDYtYp/fBQ5fpdRsHRuz7H980iuK
	 rKKsvzZMk37pA65D+SDIs0YOuHMzvfdtu5Vt2XDNkgl0Mm+sLPW2TI0D5Qs5dhWbhT614
	 7LQ2/4UUqsggLP2nsC4wSImuNnAodVPulRFUiqvLj1Ry/hVRT8/gLISfeh0xSzjyNno72
	 fl8m4CSZ2MsFL+pkBiYSwFIiqHKD4TwcyX89LK6S8kiBG8VvaI6RaOIqeJrnCdo3cQY9A
	 XSNI1vLEMkU44a5hywPdR8MMsrTkNo6YoLGCAfNDWlmIKfdguztFcLy4mo4TkSoDD6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
	b=U7qBRYAecD4JRVDdZhcIf1/CwXH7/zefpcDgsF2xYg5VfKHCrFJVP8PfQsTm2sagnVPv
	 hj81ScQbdb0oklFpGmYznb1Q51dObrqFEiPNYQ8kSXAz7kmkwzi9JrEVbfoV6SGGE3RWH
	 FMnu8+STcqm0MiPeSD8aXJsqdkZSEgoQzw/V+bG87Gt1alyMXZUsrWQNPBDegHAWlEpua
	 xcuVjZcC/LjUcCf2ZH6PsvorRLAxQ50cR0S7rxulpGmG/gntj4a89Ou16IQqLPQOUXw0E
	 Oe5pgsqKfMWZ02Vo5yKd2gWNX1SAA9E6B5kV3rupte+8G/7W1XiBVYpHusoDHt/k+kg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y1bdsFQU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875344;
	bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UcznLiR+o/Y0bdQVo3tbCneHhmAKvOwbOvZT5CBRQR7UGYbpbSBMD9Izw+nDRNE7V
	 bA57D+F0RqqX1wO2C/0b0DW8IzKKXHJrqkESvTnA6iL0TNGlH5+d4jtQg4BbNCmfSj
	 XV2PrbIaLtbQ3n21y4GaNZIlrVM7c7FilSMp7FYybKy9YCTTCMsyDUQHDqcR2G/Src
	 SOISoJ/u/MoYQv7odkQbs3jo0wYGour7LpYcNxvMUyENnP2RyuWEWNS8H2soDgoMb7
	 cpMadY2kFmrhGYKtSKmGXirkk7M42cmXtIxDSDiLjOfZDom4OXpQJzId41DvnWbtXk
	 eqkImEcerV0qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F6680989;
	Thu,  1 Oct 2026 17:22:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C19D22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D8AE80F7A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBxt00PDJurD for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:22:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D03B80807
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875342;
 b=sY181vYKWrUY4pxmY8aGMe202Pb072q7sRaUzTrleArLV4gTnpkayAZ//FYzqgFaAk4W
 2WyQw/Yt1f/UsL71tz2ZlZJQg1hPV6mblwc2PNPrAOrRAMFqSaAMkcbo87QV8JmQxVBB3
 buYNnNNzHI1Y6LxoRlaeZrx5y7veYNnVqQQnKhNtIUXYgDlRH0HMDb912j54ONuf7zv/X
 vFRQMBWWySRbGfqWpqcl+nmj/LoCkijs0DflNTnrxEdzlvlMUCqBuua3mme206YSJpAZb
 oeHfn3U3A06SKjWGnTSRiCEiheRjBI37KIcsmompmwM/gep6q4KkffVAXtm7GMik5+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
 b=eYgEAaASjQt2sRMZtoOx5S2WQwrAi4wxUeCyWGMVI44tP4wbIpAJ3/DEhqtMf5JIOu0t
 +Pgl/e+prd637HeSNbe02gO7mi65AOTdCW3DqNu4y3gpKfcs2TdBpXvTwksg5Wb/q4IcA
 ejyBUlT6ndxKt4MfOPrSMrqqAQgQBbxU6xaQ36tMKCi13BSodzpWlysjCjvT65TDeqdbu
 ief0uFR3QfwDnbXdN32MGgUI8kFlNmxhBzfKROero6fpPydNH50SsbCVME0bhQfXqyQHJ
 ECAKdn3x+JULWGFTw0vwM+OvkCCy0DJxL6rFqh8Rb+Wg+w2usMsRJdJPpsLW71doJug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y1bdsFQU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Y1bdsFQU
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D03B80807
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:21 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acaec6a74aso5236424a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875340; cv=none;
 d=google.com; s=arc-20260327;
 b=hSovewej7f2wXuGNR+zxqaEEh9fhzkFsXUEmDpIbs/v50ea6jpiUYaQRflD2/oPb7v
 l7/lJBcaZCABiQ8k+c8wOVOQP2XizKtZYiB8Sg2WK7i79Lnzs6cNSz4HFFsebsqzlX3O
 qVu+Cknk2a/9UHJoOguZccjCgJaA/LcuA4QN7fs5sQIbc3k7bCoogKZs7HtuSt7gynkj
 6jJp2EEaiOtwYsPXbROcOamfGpouR18GzYghxhEaNO8hdN9F2WbWht65crbNNC/jNaEE
 wz6I7N1ZYXzaXWHvCCNtukhYfQAM5009X+6eIH7MEa+mURuWoZtG9IO803TTcs9b72vy
 n9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
 fh=f+3YHrvj6jGhkBhPyVUqKuV+eWYFrOfCOWHRGid3M5g=;
 b=a8hwMqkYbAdJdnd15xHpJXEasF4NkJ6Xz9I8uYPCkiScPLh6FptIzNNfR2zPrNY7Gk
 JpOgEGkHVOUzvUBMiMgqYKMFvzRy3ANBMx6XRIMGzxY3czsjJFzChaOV1sRafH/v7iAG
 dBjAoXdg5rkEO0hPjK9YHpZhwA3z04ZJmN5AO1Uzx2MBdrOTQ8pCcRUBDtT894UqptzE
 h7bA3IjDrONWTqYeIdCsL3mgHsqCJyLIZWdZaadz/HNyXt1wvxJYJLTy68yx6L7/oNmb
 uykfNVr0YHyHNUMeD9bBFzzfQp5fUo0Lz1j5CKNK+RYXRYAOxy9SANc4Cp/cw7Vy1uux
 U5zQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875340; x=1791480140;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
 b=Y1bdsFQUiYg7ri0pGi7mpeMD6wnJhVnQZBNiyN+rEac76z613lav1eFoM8eYPq3lbK
 71PGBETI3z0z6LutOi07V2VPfs/3AME4yImKxFqfV8Ry6FvsJKHNNfGmO4Z+EE1zkXYO
 ygbMIXg5R8IQxixP38hCltxCdFckRKlf2w+cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875340; x=1791480140;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yJDoo1WIPlOYOCT8OcsnSpGfrqI73JRUV9mnTosn3Cs=;
 b=j/hwJmNYaRr1wO402xevJOkUTTfKTafKlzHeGNV9P2dpUkXrOuyVKWy4rPHKpkrnic
 l1vB9qy+dx8NH4uDQnyWvCOX6gmg48d0tzdxVLFMcZgj3JTCyzIz7HK0CqFuZPhN010u
 aEdyvRVHjEcLZmB/khNEFHPBQQulAYB0BoblhLww0fchoarR5wSSa/WZsOwpS/4YiAv7
 AxlCAE2jy2FJ5ww2rxWjXfRa3bXN0jjU1KLZg5l9SJYuO4pRE8eXIPEiEu8rQdNLsTZc
 oggVZrcxGocv9wL88VevyP5EthlPFQFboCNIay5DeTdy3e7ByWQNuYSsRqknuZrnNATE
 iNQA==
X-Gm-Message-State: AFq9FYJxHYEhTsDs1ftVvelbleNX+BpKkYwBb3eUzWooC2ANLQSWaL+7
 XKxZPKbVZnIFQFfZh5P8KnmIZG9Luqtxe/pX2e3bBzT9W25tKtsujUPZrEdBNerm18zbIGJyJP9
 iphpndHjLYaNUxz5VRPKLEILMfh+QajxW4gSe+7r6
X-Gm-Gg: AYBFou3YHGrlDEU1pXpazC7dd8fjDx9bVsUAef+0H29m7ximusG78dRhMYLcvueBUpM
 bvwy0LlUBZjvbD3nP/t17QQVnq4T9lzArt+HMOHdcQDRYMIuwRYGkmobpzdkN4BkZ9aeiDChbvc
 a+RWcjoiGsMt05Sx1DEjTmFFWHn9A3exowxv7tPeLE82gxhJHWnRx8k89hxi1BSkm/+J3FFUMf0
 rqL3O+mj2xKGIolmXFsB9Uu172WGDMRikqVTaoQV1nRA3eyknywF8cIESRyrXPZUBGZY43xkc7Z
 PM93om9V/nHEfplew3xEC8AxhZXYxHDUjoQu3LE8B0CkiwZIIS/7E5zq
X-Received: by 2002:a05:6402:a0d2:b0:6aa:4c8b:6213 with SMTP id
 4fb4d7f45d1cf-6ae1990c83dmr4075820a12.18.1790875339655; Thu, 01 Oct 2026
 10:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-5-ayoub.zaki@embetrix.com>
In-Reply-To: <20260918172127.66014-5-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:22:05 +0100
X-Gm-Features: AclHuK_2ZriAE4PrUzm3Aja6qIOaXtMlADCdlUQyqGuBa5eX_tpzDFrF4n9Q4aA
Message-ID: <CAFLszTiwBt8Y4kqXhvCk0FtSKSabi5ihnmmbqkn=xU==j5CczA@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: describe ML-DSA verification
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
> doc: describe ML-DSA verification
>
> Document the verifier config symbol and the raw FIPS 204 public-key
> and signature encodings accepted by the public API. Describe the
> single per-parameter-set workspace allocation.
>
> Record the exact Linux file revisions used for the port. Explain which
> kernel facilities were dropped or replaced by U-Boot equivalents.
>
> Note that the initial API takes one contiguous message. State that FIT
> and mkimage integration is deferred to a separate series.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
> doc/develop/index.rst |  1 +
>  doc/develop/mldsa.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)

> diff --git a/doc/develop/mldsa.rst b/doc/develop/mldsa.rst
> @@ -0,0 +1,67 @@
> +Verification makes a single heap allocation whose size depends on the
> +parameter set and ABI alignment. Targets with 8-byte ``u64`` alignment use
> +8800 bytes for ML-DSA-44, 10336 bytes for ML-DSA-65 and 12896 bytes for
> +ML-DSA-87. This includes x86_64 and 32-bit ARM EABI. Targets with 4-byte
> +``u64`` alignment use 8792 bytes, 10328 bytes and 12888 bytes respectively.

These exact byte counts depend on the layout of struct shake_ctx and
struct mldsa_verification_workspace. They will be wrong as soon as
either struct changes (e.g. when a Linux fix is pulled in), and
nothing will catch it. Please can you give an approximate figure
(about 9KB to 13KB, as in the cover letter) and point to the
workspace_len calculation in mldsa_verify()? If the exact values
matter, a unit test that checks them would keep them accurate.

> diff --git a/doc/develop/mldsa.rst b/doc/develop/mldsa.rst
> @@ -0,0 +1,67 @@
> +The verifier, SHAKE code, APIs and test vectors were adapted from these exact
> +Linux file revisions::
> +
> +    include/crypto/sha3.h
> +        f1799d17285ca99243328cd92133a9f84ee3a593
> +    lib/crypto/sha3.c
> +        0354d3c1f1b8628e60eceb304b6d2ef75eea6f41
> +    include/crypto/mldsa.h
> +    lib/crypto/mldsa.c
> +        ffd42b6d0420c4be97cc28fd1bb5f4c29e286e98
> +    lib/crypto/tests/mldsa_kunit.c
> +    lib/crypto/tests/mldsa-testvecs.h
> +        ed894faccb8de55cd755e093c4b0971f190d384d
> +
> +Each imported file header links to its corresponding kernel.org commit. The

These commits are already recorded in each file header and in the
commit messages. Every Linux sync then means updating two places, and
given Tom's concern about maintenance, they will likely drift apart. I
suggest treating the file headers as the single source of truth and
having the doc point to them. Alternatively, keep this table and add a
note that it must be updated with each sync. What do you think?

> diff --git a/doc/develop/mldsa.rst b/doc/develop/mldsa.rst
> @@ -0,0 +1,67 @@
> +The initial API accepts one contiguous message. Its Linux origin does the same.
> +There is no FIT or mkimage integration yet. A follow-up can add a generic
> +incremental API that lets the verifier absorb FIT signed regions directly.

Plans for future work go stale in documentation. I suggest keeping
them in the cover letter and having the doc describe only what exists
now.

Regards,
Simon
