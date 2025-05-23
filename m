Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1726DC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FEF833CA;
	Fri, 23 May 2025 15:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MlcO7RLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602B2830B4; Fri, 23 May 2025 15:19:28 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE97833BF
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so1653901566b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006365; x=1748611165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n2IDdXucl5DZBTmSbcYyChFMlnuvj0A6QF/oSDOtDxY=;
 b=MlcO7RLY2NT2/5e/4C7OMn65WOiQyDKaFwMmPBw4cnA5YF0m9iqON4f2wbZoG6wEY/
 ER/dJtoTkhtu1KQFdNXa3EWdHe/vrEvAdCGGqPJzRNx4RWCDaBA1q310Ljkgpys/ngXU
 OGU5j1gKDTuTnKg+qwtQY83B2uN17DXt2H1oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006365; x=1748611165;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2IDdXucl5DZBTmSbcYyChFMlnuvj0A6QF/oSDOtDxY=;
 b=KVKmaArsrgPhjbvjYQxYO3rQHulJTQksLcoNmVxH42C74b0GzaU6rO/9xiEAZ3rxHR
 JYCzT/lF3yjd+4gCXOdwNINsWtC9hIq593u1CFF0DvoXwAUFtDfPVF5QYIUV8Sd00Anl
 ztOTf9YgBMwOdqjSMUfAXNu1X/T8DucW5YOqL7Q+CRj26WJw53ZKYA7AoVgJyF/ULMsx
 zmSy9/m6uc0XsPts9u7/7m5mHzKczIfec6oclmQaOAQ4qN8gcGmW+XfNIuV/qI5WKWMV
 2JHUViRclHz3A5PAkgqzHTkklRGLXKfkeQf9rj64LYHGj5NDJqJ4RNZdGvbRi0H+rF96
 c/6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVnmI9JsCSOxNih6f65yTRnc8Uf+/WMbgEb/454adgvj2Lt/psICXoVdSvIeryeo0H2WR+nzk=@lists.denx.de
X-Gm-Message-State: AOJu0YxHiOagNRkqqSEH81yJ3Oze9BxmEBfhXtw0nKZh2MViw0UByJ9f
 0MkM/Vst3HfvTYOHNjX31/1Thk19D0rImcnzSUblbsyELvTtu9+EJG8jUYXvY9SSstI+CfX8AZ8
 UqXqFWZetcXmLvsr8Oj3nJ1BVourgDeoFOprlj0u5QEA5Ng1vzN3hd3lT
X-Gm-Gg: ASbGnctgufWzL8IoVL+NssrlJcTkovEHO6TOaO/KzGcghiN61i6PNz5UcfD6pnfjkI4
 V2ElnDbzcAKg3jUS5W65mdXgyGkhQqSf/2M9DipFtdYRmbn13tzO8+6P1L039ICvM3L47VC1bbe
 77Szqkgj+WAoz31vX14ImnIrF6pOMHcga1xg==
X-Google-Smtp-Source: AGHT+IHEM1UGVMxWKwtiNZahkuJFHB0a++WGSuHCTqqDWzeouXojVcpX/FDQVZ6nud/tuFMjBxb1P07X3Gxk/0++7Lg=
X-Received: by 2002:a17:907:c807:b0:ace:cdfc:40aa with SMTP id
 a640c23a62f3a-ad52d4b2782mr2200636166b.19.1748006365212; Fri, 23 May 2025
 06:19:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:22 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:22 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-5-sjg@chromium.org>
References: <20250504132356.2317305-5-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:22 -0500
X-Google-Sender-Auth: A0O7TX8T7lkP1u-zcoS0i_EXGZ4
X-Gm-Features: AX0GCFvTeB5QekLGAl71L-NkyH6mFyFLEEFNbgKdhmcj-u4NrtJVoz4crKBE9vA
Message-ID: <CAFLszTjd6N5o9O1vHSySSYpT-8oyrTRF9k2b5YupvvnV9nPQRg@mail.gmail.com>
Subject: Re: [PATCH v2 04/30] u_boot_pylib: Allow control of capturing
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

Tests often capture output so they can check it. This means that if the
test fails it is not easy to see what the output actually was.

Add a -N flag which writes out the output after it has been captured.
This is not a perfect solution but it is simple and seems to work well
in practice.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/terminal.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Applied to sjg/master, thanks!
