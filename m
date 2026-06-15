Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C8FCD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 18:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C28846A4;
	Mon, 15 Jun 2026 20:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N/ufBzAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1A0846B0; Mon, 15 Jun 2026 20:53:04 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401B384105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 20:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4876d5335b2so816937b6e.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781549580; x=1782154380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsi2O40P2rhtpgKMz1PBoZ9Syhd7UmjYT3Rb4dctWhc=;
 b=N/ufBzAlhDctXyyk/nLRVuKy/XMUcodZYgkQZxB94l0fBnsxjGJyhYxhRQZ6+N4BcT
 BzAzmoVEwFK0Slpte/lF8h/hdDsUfJmZAvTSbxOuXtBmtIeVwV3ld76zXg5HAClOLbn4
 ovka22EJ5XgFdSWbFkyfscp17UmJ+JvR/ytJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549580; x=1782154380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsi2O40P2rhtpgKMz1PBoZ9Syhd7UmjYT3Rb4dctWhc=;
 b=UPkf6ZNB+oA/sEkCuGD2+p9heCkIpQbUeHrft/v4LxgTuMN1WuyqOZKHgUW7psUZ6d
 msir1PNU9Y5AOT7baBXMI1sVTZXhMn8rmlipLA1xgrhZAM97U/HIRgiN1xaxRvORCQik
 KIrUsLeioQXFkAnrWm+eGDgVPK/6fffDizB3XM+Zd4ibdqyIXds8KDKTkUsFe3tVNlv6
 BrP2K9jKD4ObA3erfpFspnWWw+nxFqIMYaDsYCxoyWU+Bg7MmdjxRvltVQYFp4JqZdTj
 oefEbbeu5bQkww5iRpqAaYURsAZ0EegbSmDfDcntD25yr7nj/n0eIkLnlSJtbvA0i1oi
 63Mw==
X-Gm-Message-State: AOJu0YxwrblrcF3pOyUpTn9iyMz3NAgT1Py1RDZ3EWLkaNqtAbTAY2R7
 D6d/dlyvV5E2V/vEfxl8BlOo2M7tvHYg5+vBIWlaFCpaJLa2FH8dE0/TURMYLue+B50=
X-Gm-Gg: Acq92OGaagvhI+UV2DmdNFzETdlTaKn2W5NsX3n1Z0FQP466m7ij1hN28LF3F3vhSSK
 xcF0DrlmWEAW1r7Z1L+JvoXEhs7ZnsIl4uB9/yzZjS1KrVw9G3Uy8MR/qVbGeZ7NgqSkzj+VdFK
 GWAvV8GQrvQKhXRAmKfxrmvY5YW7DO3qU07+Mmbcx94AqIXhIqS2UqS4ox4e5X/d+JYdwLaAngQ
 L+9ahThmDGZA1GvjwqNjDZNifvm1h2RJCVJdeK4vYEnJo64/kOd2RpXitSN9mZUTcbic3a6AZ2o
 f1NlaxvAhIF9TCdxMiXVIeGRGpnvwEYFmHe0SCKWsJ0vpej8rQWAdQ9c2GsEtN1uC+DgdW3Tu5G
 D8kjMND4sV9Fc6R3+BA86R2/JpXGaGMpd2Yh5OIXZxCWY0FBfeMto9z6LUxetR47DQjI2qlmobK
 IlHttT2ktSvreTlvcH3mV7XC24gnktGoNtDRIvXXGxKic/uj0uSHUncpYOe1d4GtHEyjRw/EFB0
 bqEZ+FAnklW6ThvUMJhGBaHHbXhQX9uKAPJannbEgNpyxbzag==
X-Received: by 2002:a05:6808:350b:b0:484:d59f:28d6 with SMTP id
 5614622812f47-4884c1c11bbmr269643b6e.27.1781549580589; 
 Mon, 15 Jun 2026 11:53:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6de65bsm4658735a34.19.2026.06.15.11.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:53:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260613130519.1516808-1-sjg@chromium.org>
References: <20260613130519.1516808-1-sjg@chromium.org>
Subject: Re: [PATCH 0/2] Repair boards broken by the 6.1 kbuild bump
Message-Id: <178154957929.120722.3341503077406819905.b4-ty@konsulko.com>
Date: Mon, 15 Jun 2026 12:52:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 13 Jun 2026 07:05:11 -0600, Simon Glass wrote:

> Commit bd3f9ee679b4 added FORCE to several if_changed rules whose
> recipes expand $^, so FORCE leaks in as a stray argument and the
> command fails. Use $< to restore the Edison and i.MX23/28 images.
> 
> 
> Simon Glass (2):
>   x86: edison: Avoid passing FORCE to the align command
>   arm: mxs: Avoid passing FORCE to commands
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] x86: edison: Avoid passing FORCE to the align command
      commit: 895d3c67cd58fee6815d0e2799ea7d22474accb9
[2/2] arm: mxs: Avoid passing FORCE to commands
      commit: 3ac35afdd2cc73db0ac3911937ce75b58a6f90b8
-- 
Tom


