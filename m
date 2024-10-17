Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242C9D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52EC28907B;
	Fri, 18 Oct 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7NrrrBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B831890BD; Fri, 18 Oct 2024 01:11:36 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FFC89059
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so9653356d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206692; x=1729811492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PT10qKgUwnNsrKgoNoNCkg+jpmwE9+nvcFwPSfpWcQI=;
 b=N7NrrrBa9SDFLPiiwv8veQKWxSBpHOHQy+0MrJfr4n7h2QScRbe9RWKKxAXbzaPBTS
 tEOwaNa7v7jTb2w64Sn/dCg5WqMBT5Z9RoLVKUHGl28yK9t0r/NXjrizgjx2QFzWHVWN
 jb37OHp16S5zQXZERj5xwnKSMi2kJLwfS2w2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206692; x=1729811492;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PT10qKgUwnNsrKgoNoNCkg+jpmwE9+nvcFwPSfpWcQI=;
 b=foGhfnP9tm2xy9FxcwFGQAGJVfG96Ps3XmqCun79u71ggiS0HjDfEAtmdAMRMwPl9g
 moKIQYX7BxgUDVy1zD9rqYqqSSFrUykCzcjCUpPmNjX3PgJtDQSkw/gjcylg6Udu2Pzc
 BgaJV2ylfyRLC6phsMMl5LRNIr4ul5Zv4Dlb/FhBLIgR4huYP7br9CjNSFBomed27fIr
 1C5DvhFHZvr6s/JVobTUbtF99SEWkvp/px1HYi2Rc5mTOm8BJcKNDEDGaRWwz9pHHKPM
 DPGK6cFZfwMHRF18SnAygJgVojYoAhguVQj4VSmn6qdHbogmVhb2EtWIT9ex8ZjNLDV0
 rixQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXh/uj660Okdz9HrBAiCZ8+/OPJa83mtZUVwf3aKci8XJDZIzciv/ZaTMEKG3X+MOmbnrGV3c=@lists.denx.de
X-Gm-Message-State: AOJu0YyKjmiAq5tIgEFk76AeCKAKTIFi7bAFqx0+MEQHRTk71XOTNprk
 xHwP29LBJjP8qU5Tr2QVNlSuQe6YNJntaqZktXoePMzOFmbqgzUxXq6mtkILz4uJv1hlaioAOxI
 +xbbPi6WzjAtbyy9A9cCeuBAMAXXg4F9WUKdVe7utgjFTAyg=
X-Google-Smtp-Source: AGHT+IGGnLmblqqQp7PcK7twVhOBLwoZepRih/JQRfDYZIhuV3w3uSEv7vUKOX5bI1R9mAr2OzPL2NR91+tKuHytDaU=
X-Received: by 2002:a05:6214:2f05:b0:6cd:ac54:7991 with SMTP id
 6a1803df08f44-6cde14d26dbmr5553466d6.17.1729206691883; Thu, 17 Oct 2024
 16:11:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:31 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-15-sjg@chromium.org>
References: <20241014223212.2212442-15-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:31 -0700
X-Google-Sender-Auth: 4yHqR6L6cp0lUf80Lt_1DsZ8DfY
Message-ID: <CAFLszTjqg4KDJU3sVovyot_eEvy-j2V12UUDZZfv_gRSYJS_EQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] doc: Update coreboot's CI information
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This is in the Dockerfile now, so update this section of the docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/coreboot/coreboot.rst | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
