Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D0BC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD98831D4;
	Fri, 18 Apr 2025 19:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SP4Zhcm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A685283212; Fri, 18 Apr 2025 19:19:45 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1229483190
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so348826766b.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744996782; x=1745601582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=boFJM6dzsSeq9PvA67hY5LWa5+beXW+l5eBvLAOyfRI=;
 b=SP4Zhcm0mPgLYfPzKygKGhO35eds0hUhWEnfq5BzFcftX4a/ToUj6yKSR2DAOQyYq0
 nRm2q9T+7qHNc/l/zw6d+0eMFa2OqXZ97LcmxJ6EI0wN/5f/k8WD/0WGnFfSmnn+e5JV
 QPFnSKRoY66YBVa67qtpMd+qbpKAS1ZnVz6hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996782; x=1745601582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=boFJM6dzsSeq9PvA67hY5LWa5+beXW+l5eBvLAOyfRI=;
 b=XgnfSVwWunAN2IWbvEqZtM22I1sfpavTYrMOe16uCHCBfxEJWAwGwGa3gE6zkWjxn4
 f9CKPUHFPOTVUXlA4rozghgGQh8KLtAv9EMJL4FYePMZc/ucRz1TIts4Nuzp1fo1xxzB
 BpB7lJXaA8NepQzELqPgxHdYyh65NnSYJ9ZO2aPUw5q4L8QbeHYnHV5RFv3BfwhK2JAt
 lajBjl7j4MqZofPJNSfCkkBqgWGAf4A8Eu5uO9aJ2sPN6CNJIYDYwoip2mBWKh3TV9NY
 9x0BSp9ygMz8smJ8C3N5GzW3urcCmzTtRJ6WThpRNTd+OHtAHIV+PUUJ7BxTNM73bmK/
 bOHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHIqTd5FbR52HOdiCxOW0FkLSSuqT0tpnnRAwWbcay+gAszV6q5cQtNIaCV0DZGFYABye8CYM=@lists.denx.de
X-Gm-Message-State: AOJu0YyPBVVc73UaTI1sE3ztcH+Ldh4O2Gq0MsU+rF4rcps7/KE08tFQ
 aeA18JJ51NAR/lNHt+Wd1LJcbdQxEG6cJUw71+oPLgU9sPnGUarz0ISvs+wGjpupUuOw7uDpTGK
 hFxcw3hQGi2dAHM2Qed9cfUsp9e+e6YnFmhR7
X-Gm-Gg: ASbGncvgGJAu72XBGynNnKQW3oXgJstyGLyLjvt/CIDzOShO8b6+b2SXiC08xtPkan4
 Dds/EMqpHRhHn2lc6HpeP+mHpVjhiQNm3qQBt9ITZsuDIMuUlWfcKiVTSJDL7GeqcN4jYHHj9Vc
 vgadO9LR0RoVYDEi5nATUS3dM7wpAuMR613g==
X-Google-Smtp-Source: AGHT+IGiPIUCvhxtrPWEN4XCwZ1Lsu6GpZaJJTAq90NcCxFdkwne5KItStHTl+KiAx1lW/CUCf7fs2NWznYeMC2PV9Q=
X-Received: by 2002:a17:907:2da3:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-acb7534a1e7mr273080266b.20.1744996782499; Fri, 18 Apr 2025
 10:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250417115311.1905411-1-w.egorov@phytec.de>
 <87mscendw3.fsf@bootlin.com>
In-Reply-To: <87mscendw3.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 11:19:28 -0600
X-Gm-Features: ATxdqUH8jTG14Jw2l-O9wA2YN8YRm0lNpBZ1byaasPXfy-chE2zp_NTarTNjkBk
Message-ID: <CAFLszThLdBepQ+utC33iOJDO0da3u7o3zrH_nFKkJt8aPcpbdg@mail.gmail.com>
Subject: Re: [PATCH] Revert "power-domain: Add refcounting"
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de, 
 trini@konsulko.com, jh80.chung@samsung.com, ilias.apalodimas@linaro.org, 
 thomas.petazzoni@bootlin.com, ian.ray@gehealthcare.com, 
 dario.binacchi@amarulasolutions.com, aford173@gmail.com, seanga2@gmail.com, 
 nm@ti.com, francesco@dolcini.it
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

Hi Miquel,

On Fri, 18 Apr 2025 at 01:10, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Tom,
>
> On 17/04/2025 at 13:53:11 +02, Wadim Egorov <w.egorov@phytec.de> wrote:
>
> > Unfortunately this change breaks boot on K3 platform.
> > U-Boot will hang after:
> >
> >   U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
> >   SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> >
> > This reverts commit 197376fbf300e92afa0a1583815d9c9eb52d613a as
> > suggested in [1].
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2025-April/587032.html
> >
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>
> This sadly needs to get in, there have been 3 or 4 reports already, as
> many boards are broken. We need to find another way to add refcounting
> (otherwise some imx8* features will stay broken), but it requires more
> thinking time.
>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

We had this discussion on your patch and you ended up with a
'low-level' function to provide the base functionality. But it would
be easier if you retained the current behaviour and then added
ref-counting to two new functions. Then people can migrate.

Of course, people perhaps won't migrate. This sort of thing is quite
tricky. But I still think this would be an easier route. You could
perhaps even add a Kconfig option like POWER_DOMAIN_NO_REF_COUNT which
uses the current behaviour.

Regards,
Simon
