Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC3F45A0F
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 22:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD0E840D8;
	Sat, 11 Apr 2026 00:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e3miWF8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2977B84118; Sat, 11 Apr 2026 00:19:28 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4349F83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 00:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9c01854477so419385666b.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775859565; cv=none;
 d=google.com; s=arc-20240605;
 b=DbJUOi+Wc/zO9817JFBYlDr/z/Ujn3xYbAl94cAOdiT7LmCwLIrZXloZoXR8IdMXF9
 HBNSzJ5G905xu4IgFrDATHXfn175ttiA7xTmWf1JbXnU3MdclL4jViHwIEbnWvJSzsDL
 vacDcg0f83bjBWyEd0hXiTpK0CPbHFJob9SYg4z2kHQED/GFMOlQ+bKXX7L14GuwYq2G
 6P0kp/j78fewuZP3mfuxhY7r9tNQrPkm0pRWrL1u1RG6k7b90wwefsYcsbsDfLWKF7qK
 yiE6SiV5ouoxyMa1/145wepOAy3dadWZsFMHuJRBEesVQAoxW4kdZuMa8wNMMoOHkQOW
 YJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LKH0Omp9UVYaQ3nGPHin6MmswQno3D6yXHI5ENpZdQY=;
 fh=I6JHg6vWRqLBzH9Re+ndievaa6qWLmyT8ZwKIbNvq2I=;
 b=I3zhFQrbzkEyyFO20et8NJsOLWw5vXqqC25FBGslspwHrkoNQPp87wzD9CMfvWyjVr
 O1gRl//xrxDb+Mw6SM6aiKAKjZOJIr8S/2gM19DKaQ9OFd69ee2F73I4MclONvqVxnnZ
 wBcTxXrOcEGCV1bw1z4DFm7hfqXBKhsi699msnfMgHMWjWlHuc0vmaHA9yvI8oshqKU7
 IBBT3z8yb02T51UyG2blZCwRBadsm5ZKf84gb6pN5DFNlSBBCZac1FrY9HFnSIpo2cqR
 3uOGCdaPMa2eAaJnLzx61J7eDFHffGJ9isqKcMqPvaMzEIM7PwjnD4tMNGw3U3SyiIx6
 2C6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775859565; x=1776464365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKH0Omp9UVYaQ3nGPHin6MmswQno3D6yXHI5ENpZdQY=;
 b=e3miWF8EFPOkmnQviyCGyqLJhio12XDcihKqBFSISu8RRTOF+3t5QQYKUjAIQsLvYz
 6/d0fs7UYQjJoC1gFZSGZJFuedS109t1b7dSBZjG0/gF9lfM5+y6wV4vU70IjQR8dCik
 /ob/cL2/dAFtaGVIiUJI54yLca7fGaKA08B3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775859565; x=1776464365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKH0Omp9UVYaQ3nGPHin6MmswQno3D6yXHI5ENpZdQY=;
 b=Nj/RMe5jqkcTI4Eu7uCoUxTxKCQsOM6Lz3s3ZUO1q0ijrssDxsVuXEn6xO2CGKGyDC
 /l6O0MA6F/DmybsqyOSuxQ6cgcDgnYGtbA4LB9ijLmgayYz4EiTf77bxaTWUkcg+EH+A
 O4IN0+t8YtxBeh+mJ08/OrbbItfcw5YlQ6wRcJX8BV4r2Nloz8vH3mAVhqvACO2OjRlM
 VrdFeEyCvPS9LUPTwOfO+GPYSPLnDbOn7NgUjL8gRTh+84dypG2gxsSSXP8gePtz4N4R
 Hbb+DqqZa6dC6E+TgL2uGNVYDD/uGNps8gr8C5j8eiD6UH6oQ+6wFPGj0pwwhk59oUKI
 HugQ==
X-Gm-Message-State: AOJu0Yxg9L1s4di9wrw804dAX8KNkhcytbKAnHkIJegndus5J8ZdGiph
 wQqqfs/IhBNNiJ+AWEGfsOxUOKIv4K0aifmt2lds/0Tn4l/OwFdoB33ETwFixmSCv5hDOeAxd34
 1Z5lURBVXbjP2F7e8RK+zkhAEALwY35ljNy8tBBGw
X-Gm-Gg: AeBDieuFwBWPKPeSO+Q8kT01c4DKxqCZ8siV2YnQmk9ePOHQZR5oDvdhz7CQTmlWM+T
 FNwVRyJpcwyfJ9f7RmN0s2csyONzMdx1svU5Wg2RmHp6EYt431tHllf4bRbW3MpbZJ81oetUkJr
 Vs03JhuddL8HRHUl70ZLOvkkYtV+uH8az/IhpaL5vKbwemh4EKlnrgGP48F48ZSG6LPzEIHi8HV
 +4+ZpEG9MtCuYYHDC4ocJpxGaQmJrBfZDm12HEj+jgS913+jREN5xngeXGCGPK8TR8gijvR+eXL
 Ox8SdA==
X-Received: by 2002:a17:907:1b0b:b0:b94:1df4:3525 with SMTP id
 a640c23a62f3a-b9d7243e616mr302724166b.1.1775859564672; Fri, 10 Apr 2026
 15:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
In-Reply-To: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 16:19:11 -0600
X-Gm-Features: AQROBzCrw_4lAI8iKTaEO-KrYuhH-a5f0PJZO08-I722wBOkAKsui4mfi2ExQjw
Message-ID: <CAFLszTiV3s37Groy5aeYPXrUL9474MhtCLq1R+E7aQWb8xve1w@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
To: ranquet.guillaume@gmail.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
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

On 2026-04-03T14:28:23, Guillaume Ranquet <ranquet.guillaume@gmail.com> wrote:
> arch/x86/lib: implement cmdline configuration property
>
> Implement the cmdline configuration property as described in the spec
> [1]
>
> [1]: https://fitspec.osfw.foundation/#id10
>
> Signed-off-by: Guillaume Ranquet <granquet@missingno.tech>
>
> arch/x86/include/asm/zimage.h |  2 +-
>  arch/x86/lib/bootm.c          | 10 +++++++++-
>  arch/x86/lib/zimage.c         |  6 +++---
>  boot/image-fit.c              | 30 +++++++++++++++++++++++++++++-
>  include/image.h               |  3 +++
>  5 files changed, 45 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

(we are going to have to sort out some tests for all this at some point)
