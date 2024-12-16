Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9CE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 11:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B358005B;
	Mon, 16 Dec 2024 12:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fK+paGcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BA680104; Mon, 16 Dec 2024 12:42:39 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D268003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 12:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21683192bf9so36601275ad.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734349356; x=1734954156; darn=lists.denx.de;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otHc2+h5CmGK6mHNf/rxOMqn/QuTz+4OBqm7mZu0oxc=;
 b=fK+paGcra+BTgtCJAwBnkbXg9GiWQCcUKnJRg6bQWpK1qU792vrwMF4UbxNHI88Gg4
 UN5xhZN0NjZXUWEU1P67PpVadaIK2Qg3h8V07K5QF1uKSPd4M7Bie+vOAoiDKcAsceo9
 wM7SiQyJKklibD2NxKNSj/7uLcmTEwOyiCD8ZhXRk2kXuBZgcwJ8SF2XkQYR32kJgiBG
 S5R98x5e9UJAynQNNkIHnyjwBEJeoSdVzZnrX5+3xVUASHvLXXPHnjR8CJKH/fesYa9K
 7JyJNKqd514FE13tkgiASz9AtIo8bdixgPEc4e3zOnQ0BTlGNG+6fcwLnY/pa98UGGMZ
 AfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734349356; x=1734954156;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otHc2+h5CmGK6mHNf/rxOMqn/QuTz+4OBqm7mZu0oxc=;
 b=h1wu98U35KdVx1+7cHBGDnJIeqvuMT8UxBcAB9oU3RxOrJoZt0N2Cot8Cm/u5u5rv1
 wcI1Nh05wsm/LL+0XrJlSe3yuTqtYhUEzSZQr+xriXohqxWcjiOpPI8CE561VgMHivHQ
 AbmjGUXt6iEWJC+TEPYXRpL0qruN9hO6TVWQ+fweSfmNXnylB/lnK8Tumq+0abUZ2TOZ
 5yR8heyLoSS1I79qerfapcMvVC/2g6xtw7mD6Bg+/hQZlPObouIE2sx/590zVGiOfuwC
 vJwCSoBRlj7g8iHmTxghpg4hgIiq1izXeCrYgT5yccxbvfqfTvo02UfgyNyVgnA9H4G2
 DH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkjdmS6dRbFGk11cSASAXyQLOD0Dw7TdiGHLIYWmSWQYxpwBvWraZYm9HU7yAX7AMpcjUDh7k=@lists.denx.de
X-Gm-Message-State: AOJu0YwCIHXGLKqPqtRmIGsoPYiyHgNuHjB+OMmkEn6JMNADetYoWT06
 3SOelXonvS3dkEWFPj0LjGkjto7UgyeErYLm2+BjSUh+Lce7KU03
X-Gm-Gg: ASbGncsV+aISvQZp/wbb8/AcCcgp6aGjWOJB0vjjz5R6vauiM+YY/ezdYydnTo9UZdP
 /TIYkaLD33XGvSLEmnNv1bFnq3scsMSMiQg+Wwyd/hQfN7OPqWwr9RibfMLrOdcdkpKBLFH+4Rm
 RgKlpN6NAaWher8pmyK0V+wrbpjHpTgQiZgfbjEjbn++DfZxJfnefXWUbJrID4A0VQ2x/yZc2ef
 20mqHj1s7G2rvBszIqyNvB/vDAOVL5fdEpDm/L7gzYaRzaHjGJiyVGyGErDk5NIAoS5rXfQEpLd
 0w0A9xaU/OH4jeI=
X-Google-Smtp-Source: AGHT+IHKCPoG9o1FrmSWf4WDTbXfhF1vOAt6LQ9Bmr+LqgtF8//rY5fBUVZHpRd57jNkJT7D5Jpt0w==
X-Received: by 2002:a17:90a:d2ce:b0:2ee:d024:e4e2 with SMTP id
 98e67ed59e1d1-2f28fa4ef7emr18484963a91.7.1734349355636; 
 Mon, 16 Dec 2024 03:42:35 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a1e80a35sm4475053a91.4.2024.12.16.03.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 03:42:35 -0800 (PST)
Date: Mon, 16 Dec 2024 08:42:31 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hello,

U-Boot is not able too boot on imx8mm and imx8mp and gives out of memory
errors:

U-Boot SPL 2025.01-rc4-00041-g50334151c020 (Dec 15 2024 - 14:02:46 +0000)
Training FAILED
DDR configured as single rank
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
Find img info 0x4802f000, size 1116
Need continue download 1024
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.10.0	(release):android-14.0.0_2.2.0-rc2-0-g7c64d4e86-dirty
NOTICE:  BL31: Built : 10:35:32, Aug 29 2024
U-Boot 2025.01-rc4-00041-g50334151c020 (Dec 15 2024 - 14:02:46 +0000)
CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 24C
Reset cause: POR
DRAM:  4 GiB
Core:  183 devices, 31 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
out of memory
ERROR: Out of memory
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... out of memory
out of memory
Adding partition for mmc@30b60000.blk:1 failed
*** Warning - No block device, using default environment
out of memory
out of memory
Adding partition for mmc@30b60000.blk:1 failed

The regression was introduced with commit 1a48b0be93d4 ('lmb: prohibit
allocations above ram_top even from same bank'). Reverting it, allows U-Boot to
boot again. The issue seems to occur on modules with >=4Gb of RAM.

Do you have any idea what might be causing the issue? On our boards, the first
error occurs in efi_init_early() and then in initr_mmc(), and it happens during
memory allocation using lmb.

Best Regards,
João Paulo Gonçalves

