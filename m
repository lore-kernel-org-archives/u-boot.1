Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FE5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 01:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D244C84852;
	Mon, 13 Jul 2026 03:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AM8yCX9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D668490A; Mon, 13 Jul 2026 02:17:12 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F8782991
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso5252010a12.2
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901829; cv=none;
 d=google.com; s=arc-20260327;
 b=Bfgy+rYIhTfYMAeZ2Iu4ZCQ4i1ESC1dljedA8g/cd8mmny3qX3vvweWX9szsqUZQb0
 gHIFSr1LyKSl3NuayTDQrSnEyyvB8Pkg4Di5Er4K+hlf9ZqDHpg9LgNzqVwjWOIxMYVe
 uH0h3AYF5LzTvxsDn1O2ho9fqlHh0kZAsnBgO5Q4XFz6g77fllV8pxMBo1QhyYE7QBHZ
 nz41Mzq7M+kPxdz3LSei7/S9vV/t02VkcvDwFyI8s5WvqJDBjSK2PpL931zx5nqrs8L4
 F5sJ9CLfILEr/chNuVlaeZXbdRl5AbomWoNa0CgAvze5VadzpTT0Nafe36OttcTymo4k
 uaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NTrD5aY2KoYiX+ciTkc59qHEzbkYrFJoONxy+OFYCtg=;
 fh=o0sOm2vp2y3CWH0wXZkGsEhY/jVD/FgGEsUTF4L6s7w=;
 b=PznLnQGdmb5GQF7yw1jXNXZjpWkkRXZ9vkpQ9AP03RNPG/BpA+5BH0J9/xBPDm6Hzl
 TH1+s/QpqCzl90vyVmXjd4AZVlz3earU6O6u42Oma/RJDDPjH2YT9d6di527cxUe2Rhd
 oUb9kavhLXlCXmdpfxXu6OgfafBv6V2vflvtzupfmIkKqI4kPUZdwv6dCWmTN96wms3C
 fs0953i0QTN4MWnJ3pBwGuaNKGtePpmtW7Ca3QDvc6AWQ2nbBQrPw/KkfrUQuYZq/m2Y
 ymMZrZaTRiSgXViMlq+8HmvgmdLYDcToe3mDUo6wgGX5oLFFvuxRaxdf//pSwRomCi1W
 YXnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901829; x=1784506629; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NTrD5aY2KoYiX+ciTkc59qHEzbkYrFJoONxy+OFYCtg=;
 b=AM8yCX9Ap1pE+xefl5YOyPe+WkqJomq+28j8QyCbRQ2Fx91vsOOmgLb4PdRrPSImlx
 U5apgdg1lsLeyugj/AGlopPiUNXnDXeJyc3zLPcf1fFaeWrUOVGHHWRmK1pYfcPTqiA1
 4g4msYyLpCd46Y2Z1vz9SsH4ZprNrj2E6bga0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901829; x=1784506629;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NTrD5aY2KoYiX+ciTkc59qHEzbkYrFJoONxy+OFYCtg=;
 b=P+8B5Q7sn4dF4VzFGarsennacz9Ex+AFGf7/qjeuvMgQ6cLqtA+WY3bZtOG7xKKPB2
 lbsyGT9Wum/jGcwgpkc5I6L83eLgHGgglnnktNKlOLYh1eFMrdgpropcvdeHuM254DPz
 shPD7ZlJejv5jXRIouAT+9mi+9WiqK0vxjEVOADDQm29nG5CnljwW45iNl1JpuxZqtVs
 QFY1wivFK6s68LQWIt6D9/KkOy/ZTxHtt9BksxKLMgYW+TpXrNW7DmrndL3dsxlQ0uXG
 OWevrieJDMVb3wDMCDEQVWfn6YAQCpA0vLcCialf8/sVkllsH+nbfZcS3NS8vUsUUwjq
 1CCg==
X-Gm-Message-State: AOJu0YxPyBaPRNh+M1nVMZkgejOYquYd6nE+jVb0im+1tnRqKBXQIO6o
 HXKsx06/kgVOfu6b5j28SX3orGEMvCHCeaxyt7vf5QGd5FxWtdFNkHa4IeKuSGRcVLoy7E/5sgc
 lNiR+BnegOypcJvUG77brY8oZu39zvvzet2Lhv9Ow
X-Gm-Gg: AfdE7clTNrNUZwkg4B+AZbX0WLXOjbs6/URwDfQouAIC+fdBHXRDLIUsLLDYHhBEHXI
 1THTgC+nPZPx78IeS31OsCLtNxDxHK01+TCc8VSVKs+0rFv/gVFhtdGoW2XjyJfoZ8UEwdiAUZA
 8ta3SO+91L3s7GjI9UqzxkYUgsOU0e+Ae3zuz42hMRViFVtWImRENy5LCF4bbH58W115/rkDRFf
 FgGDKDrKiB0NPbqVazzCPI02HcpdbbTHRUKl+UwangED10ocCON6iuSLiYLweJvT7W0Alq5CAeP
 PwwkVQ==
X-Received: by 2002:a05:6402:4149:b0:69c:769d:6eb6 with SMTP id
 4fb4d7f45d1cf-69c769d77d7mr2627222a12.31.1783901829306; Sun, 12 Jul 2026
 17:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
 <20260709-submit-ce-series-v2-v3-4-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-4-5017da8c9bef@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:16:53 -0600
X-Gm-Features: AUfX_mw3Mpceh41g9J9T5ikqY2CokoN_SRCe9G8nvXSnv5nzPaJhuqBMa6Q53io
Message-ID: <CAFLszTjfbXVWKN8RGb1vqTdpbG6QTLDErLLn39gxQxGVvFwirQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] spl: fit: support encrypted payloads
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Jul 2026 03:41:08 +0200
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

On 2026-07-09T22:46:22, James Hilliard <james.hilliard1@gmail.com> wrote:
> spl: fit: support encrypted payloads
>
> Add SPL_FIT_CIPHER and decrypt FIT image data before post-processing,
> decompression or moving it to the final load address.
>
> SPL cannot always allocate a new output buffer while loading FIT images,
> so use the caller-provided decrypt-to-buffer helper. External encrypted
> images are read into scratch memory first, then decrypted in place before
> the existing copy or decompression path consumes them. Embedded encrypted
> images decrypt into the final load buffer, or into scratch memory when
> decompression is still required.
>
> Use IMAGE_ENABLE_DECRYPT in the common FIT image-load path so FIT cipher
> support is selected by phase. Keep that path disabled for host tools,
> since the target-side decrypt helper depends on the U-Boot control FDT
> and runtime crypto providers.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/Kconfig         |  8 ++++++
>  boot/image-fit.c     |  2 +-
>  common/spl/spl_fit.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 77 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
