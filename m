Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8478BCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC95841D7;
	Wed, 27 May 2026 06:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tczb8rDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2C484671; Wed, 27 May 2026 06:41:33 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E8B80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so887622366b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856891; cv=none;
 d=google.com; s=arc-20240605;
 b=av2ok2gAYvNb3Ze+tVs56EjQXdIRF94EsUNsXsw5B7OoIdLNWQL/UL3nWJfqtR1RxX
 WJ3x2337RqKioRlC/YjU5osh9Y48enxJIzdoUjUO2rxA3OcDwiFT1ULpcvCrl/NGXbF3
 hS5T/AT3WDsoqhFgsJdEoANAE0nak9QuU1jfgZ8qS0HISQyDpsxxtRb9ldUljAdIAdDy
 BE60qOoeNnenh/TfjowcpcQFPs3Ba3vqIZMSmXVdmSIQ9YHJ4Wds7cYMklHwpUUkNsPc
 gXEx8qmEDX5cLpy76RddO6PmE5HcRPU1opSyorTDjRpJyIds01zKJ9YysGqZa62fpc52
 KaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IdUfPvzAyvI3jHWOoGACePFvmbMJNysOat9mNd1l5eM=;
 fh=dF1r8TcFC8WpmU6ie9flbb4nUWAT8O17IykatCYVKAw=;
 b=DosT7fvYptdUwuzLFgkYEtOJIRV0gLEHQWoWcF+/7sgHcLod8JbFz3kQgxwAEyerqg
 TGSO0rCGARKUy5bf1d3frFXfdW9XUFxLECMXdSgS3IJ3k1+gQHru7r3rHLiFPNn6IGvN
 OrhryB6PvdhuxjowsrjonBo/Ovq9D+oi03pshhpi/hvIt5rzhnXJL5JQ484uUeQ+FxTT
 dsfRBO67ai8dqy1sOlQw4kR2SpB40AusHilN0revFVmVTxKe95oC/t5Iu0Q2W4oyB8nt
 IRUdOormMJCpXqGDprb5vWL6aPKYr8+x3zXUixs0jPvNysEBhAeRij3H3v5lsXoWj21u
 EoUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856891; x=1780461691; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IdUfPvzAyvI3jHWOoGACePFvmbMJNysOat9mNd1l5eM=;
 b=Tczb8rDuwziFDNsxHuJCJAASBLy3+LPck/cvddIJkrHiu6k+IiYhRs252szX6rpVLd
 ljs605HZlacbO/dPr0H+vs7bBK2Me/08R86jcI8lY22Cb4CXgMZK0jFzgBC1p6aCc1pT
 w3Akt6A3nLUsvL0u4A9G5y7s6VzFs0XSZOd14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856891; x=1780461691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdUfPvzAyvI3jHWOoGACePFvmbMJNysOat9mNd1l5eM=;
 b=FtzKPa6eI/q5BH+0FraZaDDnsxGCRMib5jSj/G+66cAa0tFQJ2aYQyxeeingIE120K
 tOGjAIVTn2faExwDF8Md/DIcCwPyvSB8wsMVllLClQeCXnQZcefIeG4spntZJ0263qdz
 TtFMOZtg3VRFzpyOiT7XWo5C7DEfzPUX060QtA/R8apYSDwxPtWmbvVOgenSTaKF7eDb
 9HZ5cMZ5c3Yv5i6bkg1UeuughvnZ2vi/kFcr5YL177oh8NEDts7yTgnscAmvk0g1EU6j
 1lQzpONBGVPSPKtyhayDRmuqa5e4Dhf1y76UD8/Mid/PaQ3J+LKD5DtLpEPeUQXYq3Qv
 CzAA==
X-Gm-Message-State: AOJu0Yy2FSBuL2aM+ga1mBlOXQYfk/+MIekNkbV5+IcYpGwUY4IjWCyT
 /rUVeGoAvDI0BwjItOklfbFMDkkWRjbRr2YpVQbPJh4H876JPN7qlNYTjhhknlY6pXDddxaUqBg
 1ndTTW1jH2DzgoYujuc1HrQusIV1dHMAtAQz1YPvdb73GVtIAB3q3Qm9YCGZz4A==
X-Gm-Gg: Acq92OHxgsO+TjW5UdOPkkL7WGdgsYZtuI2RukU7nYt6BF0UPon1SFWinQUD6dcFP1M
 uPyOOREtNIFGNDLFWmuG6EjNfksHelxfDDH78g/7WNv7gXa+eG4IxgBtcn6/WSeNqaLB9u2g9be
 m+1Cm9NBUJcQJJw8O7M700TiJfLAWeRgl5v1vqVu77PC7NDTVYrswaQ+sndB0vma9jSBZIbWvBJ
 ZyP0jfeFyQaIkweazO9u7CjeZrdvTmxesg/hPtnoQRiz34sxccjKTCWEYRxQ//vvY6JC4qZU5T5
 QJGiIHhN7o5q/NQo
X-Received: by 2002:a17:907:74c:b0:bd3:7c7c:b817 with SMTP id
 a640c23a62f3a-bdd2542d81emr1282930466b.1.1779856890817; Tue, 26 May 2026
 21:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260526202218.4004070-1-trini@konsulko.com>
 <20260526202218.4004070-2-trini@konsulko.com>
In-Reply-To: <20260526202218.4004070-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:41:17 -0500
X-Gm-Features: AVHnY4JXk93woRkmPsvu6x8mrt6lpPNucvl50HVk_ygw_DofB75frh2fHRGT4yE
Message-ID: <CAFLszThLLG6jTrL_qcWvpyECE2OJ=zCL_C6y-_FtJjWeY+yCfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dtc: Resync fdt_check_full() with upstream version
 v1.7.2-35-g52f07dcca47c
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anton Ivanov <anton@binarly.io>
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

On 2026-05-26T20:19:26, Tom Rini <trini@konsulko.com> wrote:
> dtc: Resync fdt_check_full() with upstream version v1.7.2-35-g52f07dcca47c
>
> In the upstream project, the function fdt_check_full has been moved from
> fdt_ro.c to its own file, fdt_check.c. This file is not included in the
> Linux kernel copy and so has not been synced over. As we do need and use
> the fdt_check_full function, bring that file over as of the current
> upstream we are synced to. Remove our copy of this function from
> fdt_ro.c and add fdt_check.o and 1-liner fdt_check.c where needed. Note
> that for now, this will increase size in some cases as upstream does not
> have a size reduction method here.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> lib/libfdt/Makefile                |  1 +
>  lib/libfdt/fdt_check.c             |  2 +
>  scripts/dtc/Makefile               |  2 +-
>  scripts/dtc/libfdt/Makefile.libfdt |  2 +-
>  scripts/dtc/libfdt/fdt_check.c     | 96 ++++++++++++++++++++++++++++++++++++++
>  scripts/dtc/libfdt/fdt_ro.c        | 88 ----------------------------------
>  scripts/dtc/update-dtc-source.sh   |  2 +-
>  tools/Makefile                     |  3 +-
>  tools/libfdt/fdt_check.c           |  2 +
>  9 files changed, 106 insertions(+), 92 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
