Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB62CCD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4275F8063E;
	Fri, 12 Jun 2026 20:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AslOqfWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDF68486B; Fri, 12 Jun 2026 20:26:37 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351D38056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so132030a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288795; cv=none;
 d=google.com; s=arc-20240605;
 b=hC2eWYpVaw4S4DQedL5n7oX62SAgM4Wbie6xMFJEpcXWNbE4jsH8p+fjRGivdYEAFQ
 fsOcf2fUD8KpqmiSWfNgIoDtavHzPIfZHKey/hr+h3FUNrHkylQLtkFa3QJHgLfe5Tqo
 mo/zkhG+c66j9l6ylnHLSOIz7F88PDvqFWsI+dFPeqANufkudhAWd7oHQl0HHBSn0OQZ
 AdB0C0VFWcVxwhijAxhchhigMOu3BraFNKV8TKLolgZ//oDT63ZFGXIWtG1Kc7lkhl2K
 yAZsa36VK5oUxuGwIKfHnKT+jwq1lDgfoklsKhAqKz0GNy0QP7a4ikIOdrSaJ5XKCsHt
 Z73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9fxp3YPqL/fpdQk0iiMhXowug5FDVytq9Syg9Z2FFfQ=;
 fh=0mLvCClsjUmfHqDbYQ3YF0Vvy+65JJ4tbEQ8uN80be0=;
 b=Q8eVw0LFVh2lc1Y9gzatC4+Z2vMtoWkuuUQYZpDu4JBKVEjoTKlBvDYzFQzpB9Iifu
 wL9bK1gIodHUWlyKmBcAqObLvFBp9aSWxm0srvx6tYjGXRHn9gYenT7W1pNDt2MSjQcI
 qNS2HlgZKmTHhi3SRztcFnTw4E1ro7fu2xoypLsKQUsi+ZQ4aKHqJA+8eaOWaiAdqVPK
 1xfaMefTa+1jORJqGcnhAXLEWvTVpz8gr1f0WD6k1EqJ4SlkLFEwMFPQ22BfR2KDTt/S
 UKsT/5sapP8984QFcC/RTSNCttQZsIEJEvLTgrRaoUyJVFMT4p4bVATlrme9+laCyB57
 j1wA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288795; x=1781893595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9fxp3YPqL/fpdQk0iiMhXowug5FDVytq9Syg9Z2FFfQ=;
 b=AslOqfWFe+T+Rm+rDVOsAjZFflFCbGoPAQhnopEnNPL2WospeKf6kY4odN/Wlo42lE
 PZKUBhn1nI3KZvXNvft5XW3wnaQDvAo/v1ICRvHTIWRq80lFcdHfnto/eaU1GnYgpWPI
 GyxrBODJ3ekVYld81A+v5a5g79ln32jGOGjw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288795; x=1781893595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fxp3YPqL/fpdQk0iiMhXowug5FDVytq9Syg9Z2FFfQ=;
 b=sge1f8++/cq3NFMDa2EOLRrbgFiEbkSPnJaEY3xN4AkA8+a814fWnbBM4awhLbP1NQ
 Gn3/M3bM1PHoWpZWFSRlgKttZoZ7kU0C76UZBqM5fiaR+Mz4wJj90/kwtfOvdtpl5x1Z
 yQLP0N33ReWKX+Kt8FQrQgM+nmrVL3caZYREZJKt7FDt7GcZ3Pe43u6bj3Xj8JoKt7c8
 Tks7eiFAcH0KHTAJuXpQYvejYtxh72XsiCRqy9h9eyKdA5jPIXfDKC6Df6sd7rBBpH7/
 IUV0bqEpiQkgLOfvrjKQslawueNTG99yMvbgCe2HM5d1Jo38vOw3RdxHCjYiNotngdr+
 pGrw==
X-Gm-Message-State: AOJu0YxEohGlbMsPS+tTeIHtQ1lBI/9jtTJnI1J801F8qqmDcl9cRxvV
 M9a+Q1I8mUX/8tAS6JTr0b16eJWw2rxKA0ksL7wkX4ynKCPF4OCRX875DKF7hjiAIpvXwTx2Sci
 an48aAVr4ReD5hwZtsMYz5Vw7VA37Tenti0wDCgewJsd79+5qjvo=
X-Gm-Gg: Acq92OE4ZmznDvg06oaNNlNzOv/8SmTJX55JetpiGIgRLl1YCo5RzZ2C5ida8M1h1uE
 Vudh8hfE8uQdfki57UhbaOHy+efFMO5mag4NpYgT3bzkj151CNs7j+7QvRxOIq4Ps/Q+JMmmF8v
 cSe5okOl+fmHHyezZd0voSIZr3zyCG3L0uZ6S+SPDRiekjmdXuyOuvT3DVvWniA+/CDXDVHBDwJ
 /1FpXaPuwqNGpSOoUFw1Y9dmE9/KPyyaEKnxEJydNW+/5x20Qhm4PPsQvF1deM0p/x8dkk1AW+s
 NHekxA==
X-Received: by 2002:a05:6402:5303:b0:68a:88cd:eb22 with SMTP id
 4fb4d7f45d1cf-69378a4d81fmr1954505a12.26.1781288794561; Fri, 12 Jun 2026
 11:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260525012824.121-1-johan.axelsson@proton.me>
 <20260525012824.121-2-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-2-johan.axelsson@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:26:21 -0600
X-Gm-Features: AVVi8CdEZ4lRCP9m7FV8qE3-fHR_ZuRUljCG7yZJOGXRSz6T2FcsQh63w_TBtuY
Message-ID: <CAFLszTjcHz+OGALFqSdughq9apyNuSyoVhLAjFrJ2_NLkboUng@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/14] sysreset: psci: exclude from XPL builds
To: johan.axelsson@proton.me
Cc: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu
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

Hi Johan,

On 2026-05-25T01:28:41, Johan Axelsson <johan.axelsson@proton.me> wrote:
> sysreset: psci: exclude from XPL builds
>
> sysreset_psci.o pulls in PSCI firmware calls which are not available
> in XPL (TPL/SPL) context where EL3 is not yet initialised.  Guard the
> object with ifndef CONFIG_XPL_BUILD, mirroring the pattern already
> used by other sysreset drivers.
>
> Required so that CONFIG_SYSRESET_PSCI can be selected in full U-Boot
> while TPL for RK3576 (which sets CONFIG_XPL_BUILD) still links cleanly.
>
> Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
>
> drivers/sysreset/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> @@ -16,7 +16,9 @@ obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
> +ifndef CONFIG_XPL_BUILD
>  obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
> +endif

Can you use the normal pattern?

obj-$(CONFIG_$(PHASE_)SYSRESET_PSCI) += sysreset_psci.o

Regards,
Simon
