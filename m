Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E3BC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77A481E3E;
	Sat, 29 Mar 2025 00:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fQcyXpB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F44981DED; Sat, 29 Mar 2025 00:48:09 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3C081F00
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso6912631a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205684; x=1743810484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dK+LGiHwQRiTtK5h8LRn0BKwWpWL215oq0wnFBHaFjg=;
 b=fQcyXpB2BLVv28+Msf6dkFQa/dX/Rgwu7f5aWy/oSM4MRYMXmT7uO1Ds4okj6TVo6P
 5Ipyzlv52TfdJ4jcqaRMitD9tGlK7jiZuCglgtH6JlE6tw3sJwZ3I6Q2lyEVfGed3VUg
 hRKEZS7O04EUHvcOqopAXLa67BqWThqO2/C60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205684; x=1743810484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK+LGiHwQRiTtK5h8LRn0BKwWpWL215oq0wnFBHaFjg=;
 b=dCvWP2/pWgKlYOujP8nxfyd9W6oD6yiwvSeqPHvVe79a5Pw5Nwdg265g6cHbBySJ2l
 GtmOaR+mJyRflu67gfdvddniVj019pwV80yFjAd/meVrsloZZxd/ZWBD+LbUP0sJrdWA
 ipPD2nArwv0lG3eqB1un7lK7u/EzC04yOx4/XYez5tmrb7g9EMEY/ByYL4j+UYNJxYXB
 9JiWibBwMuXCLKQ8ertXIsXbb6d4Tv4wGXXQsFmaSjTnHIC/QAxTGFKsWKvPwjroHOeA
 jO9htOGTmvyj9JS8BoRwN7iSTe8S9UNQuaGFNRH9DDj87q/qzcfBhmSnWLoVXVm/2rCZ
 ZVWQ==
X-Gm-Message-State: AOJu0YzCyoYB6Fg6RslQrSDkaDHZaxuBvJVHN8+IWajkXZqWVattNjZi
 icTTuJG1pnxJy/T1WMzJXlhcG7ywQYJrKIq8XMMm5U+oP5uho51sWpjRnNqF7TW4DGxwVTcosGq
 rZYb6/KR2RdL2EsDlFHtCu4S+Dn7J6Kf0UJEbplS/D09Wd4Y=
X-Gm-Gg: ASbGncsd80VJTe4oECO2Yiw9qU8wJdWL7Ok+Ij/HqSpQfIDFcOXhe3bLGV4WbT0lEKl
 H44yoYn1oFRzsHqtoF30xrmxNiy4J6vqTAJGzKCRm0fJthL2nGoZU9oMeLiTH7vnhyLgssxwfJX
 r/8gGNeT9oSR0w6uksIZ4+fOB12ZM=
X-Google-Smtp-Source: AGHT+IHgPUlNzc6xDTWdIG7SmYx18hNi2oaqtbtuCD0dB1uN5YE0tfvsf6JLQ5gb8RWySMg2qopFgu5avP4waezQSoY=
X-Received: by 2002:a17:907:948b:b0:ac6:b80b:2331 with SMTP id
 a640c23a62f3a-ac736709564mr104128766b.4.1743205684441; Fri, 28 Mar 2025
 16:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <af0f0e52-2891-4b56-a7dd-0804f86770aa@linaro.org>
In-Reply-To: <af0f0e52-2891-4b56-a7dd-0804f86770aa@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:47:51 +0000
X-Gm-Features: AQ5f1JoIwZpu21HJkreoU0q-edC4E6SiZBaM_sqagoKEqnIp3JBeULQfTrIyKEE
Message-ID: <CAFLszThWxbLGVNy86w9S+kRg637HyEEzaKhqZO5UMrCZGWgHyA@mail.gmail.com>
Subject: Re: [RFC] memtest
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Andrew,

On Mon, 17 Mar 2025 at 16:16, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> As far as I can tell no one makes any use of
> test/py/tests/test_memtest.py. At least there is no entry in
> u-boot-hooks that will enable its use.
>
> This is not surprising as the code does not actually work correctly. It
> will construct a command line for the 'mtest' command with some decimal
> parameters and some in hex. 'mtest' will interpret all parameters as hex
> and this makes the test fail for almost anything apart from the trivial
> cases where the affected parameters are 0.

Oh dear!

>
> I looked into this for a while before I found the documentation that
> describes memory testing which states that 'mtest' is deprecated.

There is a mem_test_alt() which seems to work quite well.

>
> So my question is should I submit a patch to fix the test even though
> the command itself is deprecated? Should I then enable its use in CI?
> Alternatively should I submit a patch to remove the test as it is not
> used and is broken?

I think you should create a C test in test/cmd and make it do a memory
test e.g. at the start of memory.

>
> If the test should be removed a follow up question would be should the
> command itself be removed as well? This will be harder to do as it seems
> that some boards are using the config default values in their board code.

I think a bootloader should have a useful memory tester.

Regards,
Simon
