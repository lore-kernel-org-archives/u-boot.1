Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D84C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF08C805DA;
	Mon, 13 Jan 2025 20:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Usxy+3sY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D667080657; Mon, 13 Jan 2025 20:02:11 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4178B8061B
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so876740066b.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736794928; x=1737399728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uboMVcsyDHFR8Mt3hVkQEGt4pLRltg8IQ8yjR+6WYV8=;
 b=Usxy+3sYythlQGqxxJGTS4/P5GoHGaUlbHfN23acZjDSY2S1eXZ5vz2HhXr8GtYEQj
 QVt0t4NZQmuzItixLNQAWlAiqUwtiilmZ1L4NHJW+5Lf3lRn6tRnUTVTXkt6+vLS6NFk
 DogkQ4f9lpcDkkubUj03p9sLI1D7mEgwAmYuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736794928; x=1737399728;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uboMVcsyDHFR8Mt3hVkQEGt4pLRltg8IQ8yjR+6WYV8=;
 b=JOig/pHVvZJoyFPFyn/ZBFr6HPSLS4Lb9Yx4tp6uzTaZs/7ZMqDyjiQVst4ZfrVv/I
 SQua5vSKup5J8LKajA6KIxyJlin5iO47CcCqzmSoOeaEofV0ApQ8b7S6tw3vJbC10UFd
 zE2Lvkgr3WcZ1g/6yn+lw1zUVuopidunAKjZ9LzhoQpOHXQOVyLV9v33n/JmGYGUdxMC
 b/N+MC/pzIWQvxHY0ZXcZlRzLfEN3g19j068Zm9kKDD3Mb0RwsAA4Jfb2N7nSUuY0LTJ
 Wy7Pa7Y+Ng1tNzyOHvvjJlqUb70qWaozz4lxOu23o7Ogtm7H4Lrg5sInWqqNVPk8xv7u
 jdvg==
X-Gm-Message-State: AOJu0YwNlZZZbtghF95Co/i01KmHrzfYG8oPNooCo/hOnbHOjOGm76hZ
 i/ZzLbhX9OJC4Da3/hdqhxu4KL8qg+D8SN4ckIYkR/s/dqb8SQok7Gf9bBUfuaiMHXe1vg49pUJ
 Ai67rwWG7JlKuTFqAG3U7p8ueLk9RuXIAveOMYe3075ozZIE=
X-Gm-Gg: ASbGncsABR8ziStx/0aWSybAOxqyydS0xNSNouQxSYZoBtqtUaqVagG1N3JRLXlSZh3
 kYFXWBfEIWLqou9G6LN0wfdK6MU2sPiimBWH+2aw=
X-Google-Smtp-Source: AGHT+IEY7VpsmEja+l7fPAtq2aKFIALhZpWT/E80/hOh9xXcnBKy0IfEmnffFUFFIMm1cFbbYKBFLcg/Hi1rng+oeH0=
X-Received: by 2002:a17:907:6ea5:b0:aa6:558b:fcc3 with SMTP id
 a640c23a62f3a-ab2ab6a850fmr2247975566b.4.1736794928282; Mon, 13 Jan 2025
 11:02:08 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 12:01:55 -0700
X-Gm-Features: AbW1kvbG534dNIF60kPi0lPe0oSGEOhzb2evkVmJmP8tsdzKmaqvgOksiWfzzGI
Message-ID: <CAFLszTgrJvFZyh452SOLpWnZSLA_cK6VgFjXNEMzkOrjQe9Hng@mail.gmail.com>
Subject: OP-TEE test suite
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jens Wiklander <jens.wiklander@linaro.org>
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

Hi Heiko, Jen,

I noticed recently that the unit tests for OP-TEE are not build for
sandbox (or in fact any board). The code seems to have gone out of
date and doesn't build.

Do you think you could take a look?

Regards,
Simon
