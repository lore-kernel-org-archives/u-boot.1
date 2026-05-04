Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1563BCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E78284712;
	Mon,  4 May 2026 22:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CiAJYvKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E9B84711; Mon,  4 May 2026 22:31:42 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B4C846D2
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-835386ff122so1773397b3a.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926698; cv=none;
 d=google.com; s=arc-20240605;
 b=GIJ1AqcaRpiKgEi6RWsI9pn4YpTgnuwDQ3AeF9vpdKVRYkDb2xSrRPHnQ2ar2/2xpY
 XPDTVkBKWVk1XJwwFoeQSxmGix4ksT5iNeW1DPKrO49heeHgeU+8Una3UaZD91Xxt32o
 aORCVj9sGc1QNEr3TO0aof2fio/x3et7i510SKx6GHPNy63BKq2Ov8PMeWheW8/1qcE4
 KTJPjrFT8ID+cI2Ae2pK9r7zp/kQGGcki6AMAHOeijrGTjOnE5YbienNP4+PROCr9MEX
 s+gFXT9Zv0WzWsTqecBHDZ0D390U+e+mdIo94VTtAXrlDcvsDJyuDDif2zJPvppAw5ww
 QrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k50b11P1Vy1fG5kJUH1JpyTIcgK4t2wGGsHLbf6swis=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=Tz/oW8orsFVc3Wstn8aBaR9e3P1ZrM1bt4fV5ay+B1gGpjD8MI2obDTmMH3oDiZFdN
 kesa7t3c1dacp1qbuOlDxLTQKLLaOQr4jGSgdnXfxaT6qV7FHbnghk7KStKudqw93Hfq
 GXC1eGcxv6vAh32tNuUfMieZJHDs5lX215mK9gQHUAdgkaCJvlQ0JbnaIBtNiYoPDIdD
 PmfZVJ4eHA/M1k7nfmyCFxkRSdoeJixGq/ue8zEKdu5kietSQ5j0gqrOGDrG+FrPDYLa
 qlYrTOLxk8vUdN6uiIbebxEGJnDV9UbiUjIj6peK9h7XGaNsjM8vGXUdPxq3W0vIK/0m
 sYLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926698; x=1778531498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k50b11P1Vy1fG5kJUH1JpyTIcgK4t2wGGsHLbf6swis=;
 b=CiAJYvKrUfIQ1SkYJHYQ32MTmV2Phn+cUtIS+wl4cRpkfjYqFhkArXf3+VoKtCRKyh
 NRDqrS1644Vp2apLsGUEfRV/+oJSCGedAvugNtSaZGWhYGL8zeoktARBbUQErtmzjg+H
 aHnwiJTaY7jL93WNm1m9TbuxD49fMdaf1xMUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926698; x=1778531498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k50b11P1Vy1fG5kJUH1JpyTIcgK4t2wGGsHLbf6swis=;
 b=MojeqeYVZHCVyMHkNPMvc1ZcanvBDWeD97b8huG6ASWWsUJT6ofuXfmIobsFDEPnUM
 ioTrPRey/GcyXsR49XBm/ldPzEfT5f4gz0qxqu+v/Dm3+KtPm1LPImRn2/CyUG8YNnbX
 4WgZky3+wxVV8096OQLlxoddmdSFBfg62+mtsTVh4gdyU6dSiZR9ASLN/rU6mkYPu39q
 j6Db0S9NquGgUEbnQazrZpEW/H2JxbCPAkO8pKHf7ysLnnp09HiKYM/wbJQZiP8kKXWr
 n7BnUjugPuGnS0tbWuxd4zXex4LtpkkFpDNkCNuz1Ay0v7+A+hNNfZqRdwEatbOmTcRy
 Ej6A==
X-Gm-Message-State: AOJu0YzaL1OWy4/izy3F61KV5dafTM0bo8PHtZU/99tNOozjiJz37Qqx
 wOr8jXcyNUPXPUT7O1UD+P/8KjcsIA1AvAcYg4wQEdRgAjOiqn+Zt1cEjJeGZuUAq5v2HnOX66D
 FgXtTsu/NkUgbZMQlROMhjen85o/dcfpMp6qg+NeM
X-Gm-Gg: AeBDiesJO4elgN+gmI6cr+MGtxoE3yF/jUfhuEzROJSSJDfvhDx5tZAgmYkDcReOpB+
 vqsjwSRNfqaUrBVTOqX7t3c7lHsoWsPQZ6JEoyLscN2psZhBQ53Fy5dROaXut7DYxgfrJxqxOSX
 A1o73reOgYLy1PpUrTGTaekdZuFo18y2oyLJfd39e7TjwboLfxn2Vck+1yQXjBmKgekL6xPTftj
 YoDcMXesKYALTLrdPk1tgxmeAaVnCcM/4p0/7hnLkQUQSvONLf7/roFE0dt0VfnAAjbFlfUHM1P
 HNicSo5+XIfI7Lnq
X-Received: by 2002:a05:6a20:94c9:b0:3a2:ecb8:56f0 with SMTP id
 adf61e73a8af0-3aa3b63562amr301231637.33.1777926698570; Mon, 04 May 2026
 13:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-6-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-6-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:36 -0600
X-Gm-Features: AVHnY4Lxx0dwKpQbJNkWpRN5cFBy7sTHEIFeR1oR9bZvPTRfoWjSetDScGBz22A
Message-ID: <CAFLszTjS_yy-5wo77pYGUgaFUWf3mG-36SbEZ5p5Qkoi-yNu+A@mail.gmail.com>
Subject: Re: [PATCH RFC next 06/18] Makefile: move deprecated-non-prototype to
 scripts/Makefile.extrawarn.u-boot
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> Makefile: move deprecated-non-prototype to scripts/Makefile.extrawarn.u-boot
>
> This option is specific to U-Boot and was added back in
> commit 52ee1a0294e8 ("global: Disable deprecated-non-prototype warning
> with clang"). It was added next to other flags which are imported from
> the Linux kernel Makefile. This makes it unnecessarily hard to backport
> patches from that project since we'll always have a difference in the
> git context.
>
> So, move this to the new scripts/Makefile.extrawarn.u-boot file where we
> can store everything that is U-Boot-specific and lower the efforts for
> syncing with the Linux kernel for Makefile.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Makefile                          |  1 -
>  scripts/Makefile.extrawarn.u-boot | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
