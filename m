Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323D2CD6E41
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CC3839A8;
	Wed, 27 May 2026 07:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nUEUZkz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F850846A5; Wed, 27 May 2026 07:04:27 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC4580433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso20664387a12.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779858265; cv=none;
 d=google.com; s=arc-20240605;
 b=e4w4Hh726FK0DHQkv6NGJgGWGcxvzxaUgvdZh8NbE3qdWWse1nWXk5CdFjI45NrH6i
 mjakz0Scle5e8QOMHruiJOheGuiKG7dAuj3IZebs3k+LHQKNs5YyUSKgYyo5cLhgh6hL
 nTJ+IgJpo4vgOUl8fdDOxRWjTEi2RNS7g0uhkEgE2XKB2XO2Agn02mebIwG4EN3R8kU1
 kSKS7B65h3WG0lzxXohj+ebqoD9O60iye6fBG2DPLsKZbCMxPJ+52hDUs82UYtq03a6q
 s4C/MbZW6Etu8JUCEczsJcjibPuX+dp/sw/Ct8lKuir43XdV0oXiPOhr44XhzhlbgBm5
 t+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iQkAMG9AXuEtIsaLBy/jZDfXK5yaW3qEE7ts+8JVYIY=;
 fh=PeEydQ2hvwtp+1/k8K8imEwfaH20KPrHght1b4v3g9w=;
 b=AlbE2bwtQPZ1mptSQ5Q3K3NQNSidAogxTsR8OipYO6Sp752odOOdFYvGRFQwB+TFqZ
 UYBTNyT6Nn9Bobt+rlQLMvp+d6JOIiN5pk7a5oLqgPYl4JiGil6YMY0KNssYylbl2zb6
 k4lJ3Oi4wYdnNg6RhC7qwckEp5jZeLQiZAZ+3eUaiIZI2IxEmKpHv7w+I2RdFuDeFE1k
 F/6S1CnzhJIMHAu6F0U1Hv1zUuC7o5hUkHH3iTUYBl7/PZ6CsOZv/c3EKXxuAeRFa6/K
 8zcbEa0ZaARLSbBdI2Fo1loiXwhDYTH8VkFYr+Iq/7IWWEUX2Kqev2yMRFljXdceXhaz
 nrwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779858265; x=1780463065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iQkAMG9AXuEtIsaLBy/jZDfXK5yaW3qEE7ts+8JVYIY=;
 b=nUEUZkz+35vpk+9fE4FdPs/WvvYxUInhe5+JSXCcb/D/VZ6b48escvFGeFAhBJULZo
 IWmQ2e6f3FTrdHRfPirNFnidWrRSwEWsyogOIGLBks5HhPiVGwdfDwjrbY0iVoGhMejh
 3NJjhUaxTL4U9K6MSg/CpPN/ZNbf3IBD4zdNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779858265; x=1780463065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQkAMG9AXuEtIsaLBy/jZDfXK5yaW3qEE7ts+8JVYIY=;
 b=dOh8Q6oYZ2DX8Dvpp3EDrcnBqM5ER/iYWB+y/E5B5NuMPAKCfLPEE06vsOhdMf4Xts
 D7VoCcq2RD+WDO8ezHBsJFFossKqA9EQbJ1XPfgaI2V4JhOwMVmVoxehszSSjNc5fJ1j
 W2ymvlM2GeCT2a9n0dpms6qN/2sZd4vlLl8lRExamk7JTmksVfKBR+K+XRfDOXX8I/V6
 TPA95yR9aSUg7jNF2ZFPjJRSb8khP1R0V86BUu5OlFYJQ69Xo7lYKPI955PTAV8u4JDK
 UyM3WGN9pfVL1NQIb7kJWKeIT+RZxZpBx+ocgarzikZjOAFOedeZUsSE5uvhSu6w7u3d
 mLyQ==
X-Gm-Message-State: AOJu0Ywg8PsXF6XGMJzmzG39Oat1zlhQ11UEWfQXsab2UaAkfUQ6LZ/d
 Re2FfAOyuFPkgVA5RyJgY0xQPqBpozpE/oVxfIgjwPePFoKIzTUHGhZKteV0Gl5P3yIvwZ3N7Lt
 3y6114XSBUfgDXo7vnQcxm2L80gTaKLVDOmWoUQUZNsb4uL9ZncUjhLFFaMP3nA==
X-Gm-Gg: Acq92OEnBRBwx3MaQVyzrYateJy6I2Z+gPH3YJCcBUi0R3gZ3iz5zPERVVBX3pBkSmf
 WWZiwwAmVww7n2H88fh53iHJ+XERtMXjJ8gsqR7cy5+PbNGLjK7ClCVhWSHPCph8aCs1w8kROZ8
 oWPKK5sDurLm6i9RTt75yraGjakNJfuW8/i5GHPyPSIj3gTp/cFk24jgYdJ259A47X3oMg3rV/6
 Rdjja5LoaQwZZ4TMiGYTOj0Ji24jWuPKaG2AS6642S0aCFKdxm0udd6AOoZx35bFuWu6I5iTw2c
 r/Z/DKspNvkAqVzg+w==
X-Received: by 2002:a17:907:1dc2:b0:bd5:156d:e99d with SMTP id
 a640c23a62f3a-bdd4a0983f5mr766786866b.11.1779858264601; Tue, 26 May 2026
 22:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
In-Reply-To: <20260520044554.15373-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 May 2026 00:04:11 -0500
X-Gm-Features: AVHnY4Iutw9N25a8y0BP0R2JuC4nbt1jpB4K9EK_6Q6sYofw4tNrA8qk090SVJE
Message-ID: <CAFLszTjUxzcQFD4sejk1=CPdnagSsva+EuuqzUOkonVYCBG-pg@mail.gmail.com>
Subject: Re: [v1,0/2] bootm: bound noload kernel decompression to the
 allocated buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de
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

Hi Aristo,

On 2026-05-20T04:45:49, Aristo Chen <aristo.chen@canonical.com> wrote:

> A 4x compression ratio is at the edge of what modern compressors
> (zstd, xz) achieve on real kernels, and is trivially exceeded by
> crafted, highly compressible payloads, so this is reachable both
> accidentally and intentionally.

In that case, perhaps we should have a third patch that either bumps
the multiplier (8x feels safer and still bounded), or makes the
headroom CONFIG-tunable, so users with well-compressed kernels do not
have to bisect to find out why their board stopped booting?

I believe in each case it is also possible to find out the decomp size
by looking at the header.

> Patch 2 adds a sandbox py-test that builds a FIT with a compressed
> kernel_noload image whose decompressed size exceeds the per-image
> buffer

Just an idea...you could also perhaps add a test for the boundary -
i.e. an image exactly at the buffer limit.

Regards,
Simon
