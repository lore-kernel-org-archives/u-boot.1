Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25B4C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D80F836A8;
	Sat, 24 May 2025 07:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lhnEF7u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66A2834BC; Sat, 24 May 2025 07:06:46 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5AC8363D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so76257166b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063203; x=1748668003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3xvovru3P8Y8Uaw9I34NGW+1T0rvSDC/VFxCmqQQv8M=;
 b=lhnEF7u5yR9AXWOynx/GvykAuuzTbIVxPjQPIz9t+6mHNB7tS6U/RbNo1lJGNfn7xS
 oWm5ruPY2bi/cWXSDLBldjtmvbtiNbuFIio3tteIup+/8v63ZPizxdY/GGG5Pk9T3e1z
 vXEOS9/Hfqj68hYLt+raRJwOB55JINQOc250o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063203; x=1748668003;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xvovru3P8Y8Uaw9I34NGW+1T0rvSDC/VFxCmqQQv8M=;
 b=ugK9BkQAA1sIeE75+F/6XF4GtoXbGG73qdSDY0Hj0Jq7ev173kzW2qHNhtdpuYAbDx
 0qQJYoRzcvJXBrnPZ01z9dh8Dyw8WaJ7M6y5R20baQ8xz0N68V/dhc1uu9fjHg50dghD
 eQAI72BxB7Yh6lU0yciE0dZSOsO64pFzChIlrbiqFdgOYr1z1gzf9CTh08Ia5hdAlCze
 2AnjuanBRDClR6FTDTuFz6bU7CG630mfNsrrI4wjC2Vf5etkri5Gwk468v/gC2kaA5GV
 E4boRPiRhgNJhgzzU2aN+Jh+6JNDuHCxxHe/R2xJ6k4B7ZFHiE7N8sWkeRtAUC0Hgf1Y
 pRhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG8K7RLhi6c94S5kjq3uac7rr6CAq0+gfjMl+57oEYXluoamAPXfKiA9fZBR+MSpuPQLSru3U=@lists.denx.de
X-Gm-Message-State: AOJu0YwdSV9FOuJMz7qy/34BbUsBcP508+sbfLVsZhnx+6sC4wb0HEgG
 l1rygzyXV9hi1be1ADp3HOOMH1mNuqbYafX3xxz0B7fZqazg0axsHjPz+2+wDsKrZXhblT6IBTL
 mdDFDVl6av1QcM8JOK0dwrjSpWA8Bp8zJgil4qf9q
X-Gm-Gg: ASbGnctH0treEIWXZpnEy8Va/iE5riJIJ9o8h8y9rPQqW4AROfZCWaqUhOQ3/u5bHZi
 bbhQvm3nkfQmEX4M1m8XHGGWV5Iq2IgLaVAzPf5rX2xOmXFYcQz4O5YRDqr64OyBTRpfHZrOc3p
 Rqdc/SwbPuVAkboHYx6r7efL0O2JBf5dI=
X-Google-Smtp-Source: AGHT+IEauBQO9wxWEejh3D9owNlVmbW6OCZ0erbw/JPHWLR8kj7Lz6nlpk5WXEVcP23v8btcIjzzZWXKXPwQCPPbyBQ=
X-Received: by 2002:a17:907:9627:b0:ad2:595d:dd3f with SMTP id
 a640c23a62f3a-ad85b329ac3mr132629566b.56.1748063203113; Fri, 23 May 2025
 22:06:43 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:40 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:40 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-2-sjg@chromium.org>
References: <20250510110535.1453745-2-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:40 -0500
X-Google-Sender-Auth: Z5SVBm7ROFNo5V4r69ynwFheciQ
X-Gm-Features: AX0GCFs4OLRDketHgTpXiERDw0kaRxkp-erej7oTEhcoENdZsJq3JQ6gX65AxG4
Message-ID: <CAFLszTi-Hi8DrSAa-cVbebybT7A54=HQDSbF5e+Apo3fnZ1zBg@mail.gmail.com>
Subject: Re: [PATCH 01/25] u_boot_pylib: Correct pylint warnings in gitutil
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Correct various pylint warnings in this file.

The remaining ones are three functions with too many arguments (R0913
and R0918) and use of global (W0603).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Applied to sjg/master, thanks!
