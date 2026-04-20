Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE107EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8654E8425F;
	Mon, 20 Apr 2026 04:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QAr55JdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C633284297; Mon, 20 Apr 2026 04:12:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C2882BF2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9910707d82so378730566b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651144; cv=none;
 d=google.com; s=arc-20240605;
 b=Bj2ITj8w3kkoZ0+zkO+IOAirbANu48QTxRATOGcG0FZK5GC7EQxYJ4u3nf+HpqhJnG
 22bV03diSiSWJkkmuB1WE9sj5n4pEEOYtqJ33n9v4zrkX60q+vNacBf3WHDLjqK5Q2Um
 L4BWIfbaF3kEZd+0YcQDN+43ffdkdZHkKthxWppkwj5eVMSTLhHfvYp2PrcXomA5xuax
 eZw7atof+E+7RRMS5PdNuxyU0Dzwf3yQYXXJxN/2tXGevvsGxbk0xUjAS19dqMeoo4+H
 tAJhgCwzeERy7fbxcF3BQnLl8y51AhDzoGKHJ7X6fSoVmd+DNe/vbNLcf3MxvibuHTSb
 7QtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GKJKrct7jmiq1kAOUPsEwubOVojz0+bWYL8SONUayO8=;
 fh=ERIzv2E6p98XY+3py7ZK3V+bKncc/D+mGuiYvQmJjR0=;
 b=PnYEJ1lUYVh5qv/QI93rTth6UDXaqOAj/f6ytftR6guAtocE0pfcfSAjZeWjpa1Wsj
 VcviZuka9YuEwyHpL7TDGAeBhYIAlUk3iPt+QTehUrpTzRw4Y3VX1otxBiPloISHL5wJ
 pTD71K/c+d0i5IPGs22LKKBmDRtO4RHpfJKPMP+fHli87D8d4D2RdCaX1PUABpzkP8yS
 PJAW8imveIJ0jPpw6FU+pZfzZs8BWoUOW4HmYb3mH6MiEs+x2/VvxQgAu7FBfkD/V+Zr
 uvoipRycHuGMVus5u6d9u/85sXggIsGfOdQ8vkiFg2p6muOz87ueIrPOhu+L6Ipkpshu
 FSAA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651144; x=1777255944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GKJKrct7jmiq1kAOUPsEwubOVojz0+bWYL8SONUayO8=;
 b=QAr55JdNJxWVokiwBQZph80Jzj4GLLYGhWvltuWJn/zoAbCUvfQf86cWnxQ1oQhQF0
 8+kTqa9CUsCN8AYRmTckvzRsgXwaFrz85b00RlaXidhmq77M3yomZadaxJvP+LeCN8DG
 rXf6cABE/AAZB1asSVQiSaeNNwGzHLivr9FQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651144; x=1777255944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKJKrct7jmiq1kAOUPsEwubOVojz0+bWYL8SONUayO8=;
 b=mvbuwmvW+L8z3oSti9bR3YZuXtQOO1O1+xmWuU1HP22ZgvXBEQplZAS3L/NHnX6Rwa
 7+8Ac1XXyikdFtfharWS57ZxCehos01GH52ojR4KPWFDrQOFfYQe8p/CWlp6jDGL8BXG
 wIQlhIf6ok54OIOkwLvJE2lzegi1yAu1gHoePMIRhFjXXTdzCD4dphcfTB8QprL9a/NC
 2h1waMMUgsM2xiyE6UoSkp/DkNfk8QfYHxEUsR+xmFjgWJDrqberKpXPDGDISvZu/Wv4
 CdH5CzvVnL4l3/pNUjHLtMajFn7DkBACS4RLm5afx3GHMZsq0Yvd5HgkPARsLJaI1deG
 7efw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dYzdzLrIdc5lfeepreNt3zci7SCjv0ZCuUJ0gUAoIkiukOQE/FJILoTnadbBhaAcDfNHkpAY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0OpEYp0fJbjHdrPN0070EoXmJBGRk0i0RhyX3BRO6zGCkgSPz
 wrIg9OkAkq6yuQ4xF54Fcvko7gBnGd8/5lDQk31dU/ZDXMjgX9wU3fPC8/udqAs9ZKhG9OTd/Lf
 /TZ2eIdzYVAn5ro2b8FJfbWCqZUrVCrkysQxGik/w
X-Gm-Gg: AeBDieugFSsMZg9OyZJ6zv3uL/WIIA/yx3r4mVss8gZY16OoQjEVhU3v2lAapzVCHR7
 g+BLMdf2vtG4qj8LVbtqa+vTocIv4SV8BQ6vzR0QCa4rDhAUysHKZic2CxIR5an+4s1UB12hrGV
 Y7U7BNXw1JiatHo1SjEe3z8J48NSQW4xMIfl0bVc5TsnJFBhjzU9CngzwBi2N6XT6KXWnXj8lvi
 uiUxBpvRIOpHfSt8Z12TgHRCEOrhJo2SBKB/fl/sGxvQvq+q1eV8kJZAGzT9oyxIg7EgaifeKSN
 GJ94VQ0G8HZ9RHv1C12j
X-Received: by 2002:a17:907:d40e:b0:ba2:e022:c146 with SMTP id
 a640c23a62f3a-ba41b3e451amr557545266b.43.1776651144184; Sun, 19 Apr 2026
 19:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-6-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-6-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:51 +1200
X-Gm-Features: AQROBzAmEWVbbDpVVbrVDliuTlXf3GW7m0qPns5XWd6aeEXXFBgevxowLsBLsy0
Message-ID: <CAFLszTiUbdORp3SFCr1306tgST7-VjucxhDnTgdB0Zy6ePFs7A@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] ecdsa: fix support of secp521r1
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: fix support of secp521r1
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 54 ++++++++++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 64 ++++++++++++++++++++++++++++++++++++++++-----
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 +++++
>  4 files changed, 117 insertions(+), 10 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -87,15 +121,19 @@ static int ecdsa_verify_hash(struct udevice *dev,
> +             ret = ops->verify(dev, &key, hash, algo->checksum_len,
> +                               sig, sig_len);
> +
> +             /* On success, don't worry about remaining keys */
> +             if (!ret) {
> +                     fdt_free_key(&key);
> +                     return 0;
> +             }
> +     }

When ops->verify() returns non-zero, the loop continues but does not
call fdt_free_key(), leaking memory allocated by memdup() for each
failed attempt. Please can you add fdt_free_key(&key) for the failure
case.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -50,15 +57,37 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
> +     x = memdup((char *)key->x + (x_len - expected_len), expected_len);
> +     key->x = (const uint8_t *)x;
> +
> +     y = memdup((char *)key->y + (y_len - expected_len), expected_len);
> +     key->y = (const uint8_t *)y;

The memdup() calls are not checked for allocation failure. If x
succeeds but y fails, x is leaked. Please can you check return values
and return -ENOMEM on failure.

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -63,12 +83,34 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
> +     x = memdup((char *)key->x + (x_len - expected_len), expected_len);
> +     key->x = (const uint8_t *)x;
> +
> +     y = memdup((char *)key->y + (y_len - expected_len), expected_len);
> +     key->y = (const uint8_t *)y;

Same issue here - missing error handling for memdup() failures.

Regards,
Simon
