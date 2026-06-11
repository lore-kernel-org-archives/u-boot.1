Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD56CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 17:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CDF83FF5;
	Thu, 11 Jun 2026 19:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fPLM7h/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA8C84664; Thu, 11 Jun 2026 17:01:31 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E703F83FF5
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=docular.xu@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-842d37438d8so2714b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781190087; x=1781794887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6xRAG9PJH/40m4yAQ66nJHpRKbP4nRN/zqujcawX0wI=;
 b=fPLM7h/YaI8hGiRJZZxm90uxJlv+rpk2lnIMfrwi+yqwN+dEz/lrXS+vb6Yr7bJvbm
 5sc7rLuXq+CMdCfl1RIOM8nJNKSddP/0Vb/YMe16PIxhZstvoIoHb1swHNo/vnJH99i+
 x9rAmERvxAj3/z3u6qDiUe94jGlwoZvUiInLnEPf+zWncfSvWHXS4zQe/pXGbOAT36vF
 JGyH0+Gtg4+Hv1D8HfUakLfQrouvlHcolez3D4JCUau/J+/yZz9C3EHEnbrn7iznE20U
 Z7iigKIAdBE5X/rvCMbZYYPZusu8h5bIMBf1d6py/OVgAnw89j2uAhTvgFmqam4qCq/D
 MyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190087; x=1781794887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xRAG9PJH/40m4yAQ66nJHpRKbP4nRN/zqujcawX0wI=;
 b=rlxiFGhnBL5fH3m8FJnLmE26HzwdgqNm3jP8XquEeLEgaiRYIwmYi68wnwhIubiAM+
 G6G7CEquELD5nE8PlAMI/x5AdA5ZR++TiO7lmLud+cs2L0ByHdsUpGQAFxM6XhfpU+Ip
 oGQ8KQRuKxbECCMBkBmVZgbdVBrBJ+s+MHZeJ3YrgLKph2ztLNh+oLQrSGsq8yIprwrt
 BWB3INjMxf0gfjwULTB0790G73zq5s7nkoIm38ZWi2PJ6R+xy4Fo0q9VcuvMTKR1xrp6
 WrL2+BR9QrdO3ls/18xGxkqT14kKY/ceQZ9vYcXGFbRifqk+bIj0fx9AEJ+zfO/ToSHr
 mf0g==
X-Gm-Message-State: AOJu0YzhnqzV0NeFD5KAEO8yprDSG+jgohV1oQxZUA+gLziUv7kzTujr
 8VHCH4gAWGtZjkRfZyVmFeDpHwXj9jYHM0iUiHsYcFopc+DQpkZgVJ0UyLEAJJ8m5hpSaA==
X-Gm-Gg: Acq92OG1vvry/MJKhYWIWLy7abAveXsGl/6L5xtkXH9AtH47k1HZ3susSwAhjkV6w/j
 pBSjDR73NhzsVu6Oo9UhCrOnudCQ/HRfy4AY4q5kiJ/PmtPDQf9mSTbPQPyfzvQ40k99WODMeyc
 pKaDVY8hGPrfTWvOIzYRGRSWTWOkNLFrY4/sf+MUQzyxwxA/pw4Vl6RI4l8T+fnz4jiju9gTkzz
 bNkF9Ph1wYdRlDqQNa3ziWQ1TaQF9d12+Z2De5TsYBoHPUwFa2+mKCDQlGYAmlgc4iLEznXbkL4
 DuzWJGAmX47mAbbHY5LOeGhO3Sis1giRmOrvaNGhVyoOEgWCBTehV290JMioPtSzRepp93XvqSN
 e59ghzEhwHE1/bTNMRKeRbMrS+A4CHTYm27xjeAz7G69ffR9HtpP0Meycf/Foj1Cow19HdQ7/Cv
 eWiuGa/g==
X-Received: by 2002:a05:6a00:4b10:b0:842:5931:7b8c with SMTP id
 d2e1a72fcca58-843367ec11emr3580645b3a.1.1781190086855; 
 Thu, 11 Jun 2026 08:01:26 -0700 (PDT)
Received: from localhost ([2a12:a305:4::302d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843380c9590sm3088886b3a.31.2026.06.11.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:01:26 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:01:17 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io, 
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, 
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com, 
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org, 
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
 samuel@sholland.org
Subject: Re: [PATCH v3 0/9] Add pinctrl/GPIO and SPI NOR support for Spacemit
 K1
Message-ID: <rwb5ufgpba4om3gxbnfsqfgnan5qjyftpfhkanzecwzzk456ng@d65r26zwdjez>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:04:12 +0200
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

On 2026-06-11 10:18, Raymond Mao wrote:
>From: Raymond Mao <raymond.mao@riscstar.com>
>
>This series adds pinctrl, GPIO, and SPI NOR flash support for the
>SpacemiT K1.  Drivers are usable in both SPL and U-Boot proper.  In
>SPL, the QSPI controller and SPI NOR flash are probed during early
>init, and the SPL boot device is changed from memory-mapped NOR to
>SPI so the common loader reads the next-stage image from NOR.  It
>sits on top of the K1 SPL bring-up series [1], which depends on the
>K1 clock/reset/dts migration series [2].
>
>To apply on origin/master, two prerequisite series on lore must be
>applied first, in this order:
>
>  1. K1 clock/reset/dts migration [2]    (8 patches)
>  2. K1 SPL bring-up v4 [1]              (14 patches)
>  3. This series                         (9 patches)
>
>[1] https://lore.kernel.org/u-boot/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/
>[2] https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/

Just a correction about Link [2], I sent v2 of the migration series [3].
Please make sure you verified against that.

[3] https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/

BR,
Guodong Xu

>
>Guodong Xu (3):
>  spl: k1: enable SPI NOR flash detection and boot
>  spacemit: k1: Add multiple device tree support
>  configs: k1: enable pinctrl and gpio
>
>
