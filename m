Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD50CCD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB4C84878;
	Sat, 30 May 2026 20:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sQi45eJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19295846E2; Sat, 30 May 2026 20:37:05 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E01846FD
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43bf94534a1so2843378fac.2
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166221; x=1780771021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPaebpcGHkiGREpfIeMwtnQTjJvJ35CAkXCQPOwLZz8=;
 b=sQi45eJjpTdr0nolP5vt3tlZTSEmJktf1AZmiIO9Gbha1ElyYrRny8fGirwmX2QFH/
 UgrxO//kayD7RG5zaSOeYF/Dud0ehyFOmYgLytpJ0bpp+zMDJw1Gv/TuDoWebSsUPZTf
 hk/PYr9qqCdm8TG9IRaAcFZHAOopyeSz6SSfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166221; x=1780771021;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gPaebpcGHkiGREpfIeMwtnQTjJvJ35CAkXCQPOwLZz8=;
 b=E3p2nZg2PwrL/ycr/4BXx1NBAoTjpfzcqjWE0olbOmrCSA8nmfmKBhGiEAY5xandC4
 DjPJNc43kDS5cH7uob7yXnEweIa/R25sEi0atBAmt2upoY7RBL8Lue14vqd4dt1sU3HN
 zSifmB2LPUY7gDWBQEjsvbr0ujW7mNEua5FkwncK9esolp0PffoknECt1c+iPqp88PR2
 YANDCo905gDQDzXT16Lp2EeTsIsUkFWQ1TImYW6Gi4d86qsoDYXg/BJE9R3/mne1TeBY
 qBBVpuYQ8Xyvv5N1Ejq+l26Ldi4BWqRlB11HYyG7jvbqjx9tZyJ/FB3/fud0iznhcDKS
 +AVw==
X-Gm-Message-State: AOJu0Yxf/ywGVYAzV5U5u2B587LTh5xrQdU/3BanX5f7SrjRFKy2DFhg
 8mOu40t7b9QKm/zocTXl/8dI57mDKbGyStnVhHH1l/Su0CpLcIJXCPlJV0W76THftvE=
X-Gm-Gg: Acq92OGezVUneW39CGlJMAt/6Uyzdplef/Cw6zkqnrDucliweZ0jHKVRTAA4BcCvEt0
 kKVCcHblOSuyxBdTgnWaLx92HQ+T2DzMCRSvtYK539601Iyf8Ds7YlX7Vvw486EooDANMYhB+Cq
 XAxcNORpXf2J+Dj2GHQ6s5GsHwYLSFq8vjkC6zI8F6ubck1CADWM9+KHkWk4HtQCv0tb8gU6E3+
 C16U2FNLTHjg7D2AzAbiP9o2T6WFAzhWAxU/AFIjBlGkPHjdq/deWLh3WesNxRjV26HK730O5kr
 Yud9mVAZ1zuOKCCBXjcdNu6GhS5OZO5lI2NinbS60EbMSUmAEz41Kf8XijRHJwzA7Lq2wuRUQNM
 Qmj3wLY82/VMwERDHMXmwMx/VJCb1Mdj6nWJhHZTpzhkj7LiFqY2RTGCBnpKrN7bjSsbMxfD8LQ
 1JETmq2wIA1F3d8BmLwmHFydGYge0z36FMogoXfquaBdpiGKQ5UjcAufEA/owotJXSx5ATHcjVq
 VxV+KN2JyoxzbMhTnppe+6dfLTPBC3UqjY+iNtHoQHcT7oOH578MTg=
X-Received: by 2002:a05:6808:1514:b0:467:70c:a7d1 with SMTP id
 5614622812f47-485fb43370fmr2083869b6e.27.1780166221478; 
 Sat, 30 May 2026 11:37:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:37:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20260512075410.567751-1-dario.binacchi@amarulasolutions.com>
References: <20260512075410.567751-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [RESEND PATCH v2] video: kconfig: replace tristate with bool
 for LCD panel drivers
Message-Id: <178016622065.1038765.8191429936130527998.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:37:00 -0600
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

On Tue, 12 May 2026 09:54:01 +0200, Dario Binacchi wrote:

> U-Boot does not support loadable modules, therefore using 'tristate'
> in Kconfig is incorrect since the 'm' option cannot be selected.
> 
> Replace tristate with bool for the affected LCD panel drivers to
> reflect the U-Boot build model and avoid misleading configuration
> options.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] video: kconfig: replace tristate with bool for LCD panel drivers
      commit: 5f5b8ae2938380babe1843fba4aebc299b811ab8
-- 
Tom


