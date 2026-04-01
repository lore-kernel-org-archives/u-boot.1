Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA510F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B1B8408D;
	Thu,  2 Apr 2026 00:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYOa2akY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4416A84099; Thu,  2 Apr 2026 00:48:36 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6294283CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9a0762ed5fso34473766b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083714; cv=none;
 d=google.com; s=arc-20240605;
 b=PxGtp0hSonDKcC2OQI+TO25NMrP8ezRsQiD5PrAyPgz8NsP/6qi2kObncxXt4WFKP3
 /S9PRrmlarH+lTjWW05adv8oMveaCasbQ8pdq2ABLevSQjkuJfgs3VHWjl1oz6FQsTQa
 eIx22gbCgmfhuGmEKLk3DIP3+TybO8+Lb57G4ENCk5i/I9zYXbhLgouolAWc9l/r3QB7
 s90xN8xKbG+EVEVAlVvJXVPkrhnNBYxiVpXrMLrKkz/yk5Dh0vNxrVExUycizMj/gAov
 bMdaOovSC6r6rQji1HR4L7gBZ1Rf6HTy/8+FX53b6LeRkXdJjAyQZp43efV+q34yrFVC
 XtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ohBZJ92oSqcpw2xUbf+J6gATVBGROSegNGtAZikH7mA=;
 fh=neYmhNWrZLGsSVRYTFQy/Rz5XVDhyOuxqtZl6TX5ZAg=;
 b=OxsdG4t6OrWU7MRJo+RaaCrYTWngLnuapn6VokMKjrvwhoQygisFN+rdfLnywdBtHR
 lsoRZhpgJYPduUyUTtxMXbQCwnYqAyzxeweqkBbwVfaB6y/Vve+SHYD34Nu9SndLf/mL
 YFi2vP4/bXGmOANvP22xqZfuvTxHvK6taqQasW3WRgRsLM45ewuxX1Ln2QWGYXby7kx3
 bQXDy8bQ2D/fL1NgGLou3hF6Ze9W4rMiqoDiGcK6ENh56+fhLjgo1BwMUNf7o9RApVz1
 49pJ1cTlscYIinthhgxHZaUbKIcZT6K14AW+kamwreaNIk149+KVSGu2S3EGqbbGyAD+
 h89g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083714; x=1775688514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ohBZJ92oSqcpw2xUbf+J6gATVBGROSegNGtAZikH7mA=;
 b=UYOa2akYvDKW9NpxZaS9G8034BgId9O22IQ1JAtvl1iB11BNIOWgviG1BO+FGl+MzT
 GSLEJivULhip/N0mdaCFFEUDqX1ULvh0twmg/PyhaotJ4GzP3B2tD+RQEp/365j//h02
 xwsTnO7BAH6U9jrMvCPGseKIAsNMrNjkdZovo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083714; x=1775688514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohBZJ92oSqcpw2xUbf+J6gATVBGROSegNGtAZikH7mA=;
 b=KAdRsGsSTNwy0eU24HArdeNZiUHN6xFHkfocgyXI9UYqiV6FpsnhJY1so7a0iWb4Gi
 M6qPSJ0KVCqvgwwW84kcbKjkSOFK3cspwhO8OZedq+pGcj57VoAp8T3UiJuEbZZEovpq
 /QY1hHGFgeQFQKFvUR+lDMLlsiYg+tdG4fntzUqkIgQ8PNexyGlHnzvCFG5TUWg4Z1ps
 WD7VQbDQ33B//HH010SKi9jrKZLoHqsYQzSYvWOXFcMCibVKc6t62Bz2CGht+tTdNLBT
 8pVESMYCXX6Oun1jyNwE+mCFFZ1O5Yb6E6F8/1wn5LRNdqEpHelXV3bnWCS2ARJsfJZq
 MmiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnQrVXnSx7khWhvNK2eTVqzjX67yaTrCKv5D30oVTcgjuWca3olxL/NrZ487NLLEA/Ubskf1o=@lists.denx.de
X-Gm-Message-State: AOJu0YxefoggS/du4xrU5jTpXHtnnbjhAhWUWX66WdW5JVBlXqURMF+J
 wFN5uX2aqc+UqCeYk+E7k3F9sKDQq4d3ekk0HAxPGjfU26jgqwpdUwGTEnQPcSdS6t0Qa0Z9LGP
 Obgxb+3Zpk6Gf2x2TwxXrONgCQpjLP9fmQpxwFZN+
X-Gm-Gg: ATEYQzx/sXjxE9Y+nhIHBlyO2xxmuRELnHApqsidQ+Z/stbblA+6eZ9739Hqh+o5qls
 kPg/FnWxfknmpBUG0dcKo0XQ05F2yGvdLSaHAKqqQ6bJ5a6dECQrzolLq8D11vz5DN9aGxs4u7W
 5Y3bPu77LLRChTG1d3UrW7bkapLqvzZOVRRAYS6r9fROr7GM8IJGTMh7tRBpSvRlMEkdXaAkafe
 Nm5Q86d5hfIOBiaa/2vhtrSb1Ew407VB2yOwff1Hd2JHfDoLR80BQ1vH4Q+xOP3zCvmKci1Zst9
 YGv8ug==
X-Received: by 2002:a17:907:96a0:b0:b97:b149:4e72 with SMTP id
 a640c23a62f3a-b9c4713a360mr7777666b.28.1775083713794; Wed, 01 Apr 2026
 15:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-15-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-15-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:48:16 -0400
X-Gm-Features: AQROBzAYZwmTJYKTiNNALZuO4vH-E_s-g9pG4GOhquuAqlAhPhfoVOh9HBIgtzE
Message-ID: <CAFLszTizQH6fsCj+B0dU0o-u3ZbYVT4ucr5poZSfvGVY9WHC_g@mail.gmail.com>
Subject: Re: [v3,14/15] test: py: vboot: prepare test for glocal signature
 with ecdsa
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: py: vboot: prepare test for glocal signature with ecdsa

global

Regards,
Simon
