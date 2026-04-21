Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57355F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 19:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF5F83936;
	Tue, 21 Apr 2026 21:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XG3xU/92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F34839D5; Tue, 21 Apr 2026 21:09:08 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E630983693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba545100a13so133114766b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776798546; cv=none;
 d=google.com; s=arc-20240605;
 b=CUAYs9OEKMsTUQRDfmXQNyRKHH0fGu1TBiefGDtxJOdP9O8m3tiZl7YposIA460AKp
 JfvvCKQLXJh1qgR1ECPtJZlPs9DaDQ5bRa9y7QKu+jiUt5zeFJyIgdUa5904KwWKrTf2
 GAVoznV57H/gn5VX6UTmC3NLhkO6mIQI73iQaAH3kVviLSlQbs2gSaOlNKEwLq74mg1i
 VPdXqAnouLxJgJxBMHtrWzUAXZpPg4LP2QUzTeEYmKD1pL3k8gFgm7ntU5XBiJNVd6ix
 cF7P9tmODoo0HfBFJIPTQ7deIkuHLJS9tWE64H4r0U1AfSFfylT1kln2C6XdkWWOEGKU
 pL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dLW6e9a791vaDY+ll444uTKiSgG3t6j0vz8Cv89UBes=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=MlYOAGXBVWdCLegPIZ4hXdsChl7GXpWtQDDy1qkoLxgyjoAcos0qb4Gw/ofWLTnHmP
 eY9Q+JasWsLHm+TPflHhEIorbpvG7dpSNzn0mLaXxtKOhY/G6Evp3/5GWe+hiQtZCGGO
 1iRVMWOhZxCVqpqcf/ZgzNDm5WM77KzPc4NHZGXkcE5htcpIbYYdeGukJo/9ySe4bg6O
 2dY/NRQMyIr1gZSwA9N7FoQ6RImLLtkKQNI7FC3f0V8AyB1DfjW/kgnGjGcWUvYGTJul
 h6uwDt0Sd1QLwV8UX0OzTSzpvQ7kGcCIDc+ZswzaR1QHouq1E5XI8jFy1NP8fTKc73s6
 OPag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776798546; x=1777403346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dLW6e9a791vaDY+ll444uTKiSgG3t6j0vz8Cv89UBes=;
 b=XG3xU/92UvsSZapO3Qxu4HYBEaJ48IGXSSwV15mQyC6TtnY43A8y1J1mrkzpyILOxb
 EU4+z9yJnImHDdaR1X7BaQR3r1KMJ8n8c/B6B89UboEu+CnCFhyrjM80OCbiF00eUVy/
 9ntLgDvg/7byF8abctUSu0e62osPfw7rG9Vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776798546; x=1777403346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLW6e9a791vaDY+ll444uTKiSgG3t6j0vz8Cv89UBes=;
 b=LFYU4aOp90WHasWXY/VvhvNudWO47i9RDwkpOXzvcXNIhkgCdlHTje+CCJuV8HSvYD
 X44gevWvI3kgyDroZnX2JcqVzBYv31RUncCU+97obG6guYGn561Xaz09pEPZW5oxGiq3
 g/37jA/60u+RvCsAJbYmt1xDs1oRwnPAe8Co+WZaQPQt4Sq9RucIAnjMI4u2bDDPia4h
 6jjIp2taNjabxiO9Ed9fSjJzH/noJOXCFIB3L36mzPB6w3RHx/mZFHDKeD/W1gLGbBCN
 cN/6EhRwB5p/+w2xSq98MBQx0wJvlJXIvPD0DdHeHtgA5vJh1OwehJzgrSkJcRtde0Rl
 65cw==
X-Gm-Message-State: AOJu0YzeuCxHSBTuNlXpUruSvWb6jckcxSbBTJDO1cAHvVbz0Z8s4TMn
 j+wun0BdIa0NQtJIaigdcf40X0dMaM93jZ03WriMpP7Qsp2Y4cs2kyoru7yFjow3sx1Rgcg/xwY
 yS5IzUJ/Dtmx0vn+4merhxMEackJ9c56u854dqNEu
X-Gm-Gg: AeBDieukR27K0H9R0ybQiXdUU7EzflNUC+iyWMlSXc+bFALm9uBbH87luNHDO2u+sX7
 kuNPXi5rUzhntCUTFB5JG4C1/pqC34Xsr6qsLvhV66GC/UAPEpZyPlcb6AkpOyIgdB9vmYLNZym
 a2WHkUa32QfjY18XcUGMtRayyAky2MdQz5D/9A8kssmLJXRnjp5Z7nbKkAgFNRaMZoDP+XParWI
 PpRg7AxiHOsPg/2LZepnI2OFg0KTdvFH4BWonHrGUh8GRb0aKKpo+AcvLZfIDPjNixi2TydohTF
 5khfnnre1CWrG/KJJZ17
X-Received: by 2002:a17:907:9719:b0:ba8:e7b5:1106 with SMTP id
 a640c23a62f3a-ba8e7b511a4mr360410866b.43.1776798546277; Tue, 21 Apr 2026
 12:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260421075439.16696-1-ravi@prevas.dk>
 <20260421075439.16696-10-ravi@prevas.dk>
In-Reply-To: <20260421075439.16696-10-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 07:08:53 +1200
X-Gm-Features: AQROBzC22vHYWjKY0InwdCzj8SwW499ylTBVjR8Lz6YDlHbJ5EF9Pd7eofafTp0
Message-ID: <CAFLszTgVt=5GDZRnDYKC-sF43+KipXoERpm9hkFiZdETd7L+_A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] test: lib: add test of memdup_nul()
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-21T07:54:32, Rasmus Villemoes <ravi@prevas.dk> wrote:
> test: lib: add test of memdup_nul()
>
> Add a very basic test of the new memdup_nul() helper.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> test/lib/string.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
