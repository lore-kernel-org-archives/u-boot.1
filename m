Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A5BEED628
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 17:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344B184280;
	Fri,  2 Jan 2026 18:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c1jJpR1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACC184277; Fri,  2 Jan 2026 18:10:01 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204BC83A9A
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 18:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450b2715b6cso7252611b6e.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767373798; x=1767978598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZzIrDSvQVWU//FSHYRdt74gaPj1D+LoJ4SoB0oeg7w=;
 b=c1jJpR1/3E6bUo7ec+h3HO7yg3ZRCmwyT5nmDYqrJQx++sRAqy2Yz2/o5fnWUhJ7Ph
 IF9nyghOjaBQS0XbaMU5ugOUWplJ2QyHVzFO+Jhvf3TZm68G9dY76kLHzFBkvx8jK70R
 nGQw2nq8K8IFsH5Z2LIFW1NfXhn1XtYSfhS2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767373798; x=1767978598;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YZzIrDSvQVWU//FSHYRdt74gaPj1D+LoJ4SoB0oeg7w=;
 b=Jl0hNBTyYHyS+lwBiupVtJzv1oBX5/Y+xvhGeCmGVSbi25/BaJGht9EIZ0Ma8haxy+
 QqUERKi+7iZOoa2E9JIHOnksZaPlQCAUXoqCsuX00rc/zRAuxikXs15wijjb4e7wLq0p
 hAYTlqN+8XWgt/6aOY6grxY/De9dIXI+PEh5mo+9a3ezx2ARkXkM2HherqLF0IWvNCM6
 +0ZBjWpZQ+hYxFpS/9rPMyH0WnUvX6gXuqwl8N3GtDyKc1i9hWGFeVdCjn/Ob4Zq4lgf
 69lPXyc73g6zyMI47JKllp2LJ5sc1vVwU62oF1lUInNrFg4zUUXiQubNdZsFojwMgrMH
 EyoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKCgM3vySN9AVOrt0bAjNPrqthO37mGeJAZdkZ6vdQB37oSkyxMhlyli6A3F9E2aMXmATeHGk=@lists.denx.de
X-Gm-Message-State: AOJu0YyqmqlPur+Qi/zbvfit8Ms01bWNiOuHIr03i65VSO8nR9OtOFEf
 pzeJo/duC67n0iXcvBjmvYQMHyFkS6YMKFmPucaw/hsDplhf+j+nGlvdmjewJ+OQNkY=
X-Gm-Gg: AY/fxX5QpFZtcklA5Um1C5LKEJuoAG6QjyWa97PnoxmALK/4hxpZbmgtT+gqeEJm1UI
 6ikjz9/xO5NpAiJy7YkTdwMUV5e1GPfvR/JcoUKBa/bvdzbrQUQ/bSjx/AdqUBv5lVl1ACwwbXV
 2R6DHF93QjhrO5lPs0CU7hs3yTacp4sY2dha2QI/LDgz7jJCAuNaapGHkAdsQWWSC9drs0BGaAS
 JIz9NflLWy/n2xm+HOBkau1s0nkc3ZS/p1NXfkMirLRsiTlijH78lTVJe+D8Mh1vcy0GaLlwgX0
 O3g8/HkeAYvWH8Vggydm4WuOKQpKPbkaGYICVZhQogsCJns6F5WOVJQhNukxT+bkVZol0VIu8GZ
 26DMZSCsKrvYkyZxYkwUDOdWG8v8Y/Zfj8FmVfJYDk0gXcDMzd3H6dxNZCwvx+C7RELPcYCh9Xo
 gPZwJuOcnsQryzcw8dOYnBi7/Cg6OnzuYX2MWoh2F925iblhztLc2CxnvDef4ubIX7YZ1vcTWzM
 6DeNSy8m7hp5lMSmkQwoMjziaUB47m3kn3/1A==
X-Google-Smtp-Source: AGHT+IFaaVxpv0kT9F8Cc36E7MlDKyAfRUvnAX9CjyQ1zwb0AMkKwr2sWNF6J2+Vq2Y+9V5cFKVBRw==
X-Received: by 2002:a05:6808:1a07:b0:450:aba0:f006 with SMTP id
 5614622812f47-457b2058709mr17537347b6e.17.1767373797833; 
 Fri, 02 Jan 2026 09:09:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4598c356623sm14512228b6e.2.2026.01.02.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 09:09:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>, 
 E Shattow <e@freeshell.de>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Greg Malysa <malysagreg@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
In-Reply-To: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
References: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
Message-Id: <176737379544.117620.2118134858600885524.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 11:09:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 02 Jan 2026 18:18:34 +0100
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

On Tue, 16 Dec 2025 11:16:24 +0200, Ilias Apalodimas wrote:

> Our last sync with the kernel was 5.1.
> 
> We are so out of sync now, that tracking the patches and backporting
> them one by one makes little sense and it's going to take ages.
> 
> This is an attempt to sync up Makefiles to 6.1.
> Unfortunately due to sheer amount of patches this is not easy to review,
> but that's what we decided during a community call for the bump to 5.1,
> so we are following the same guidelines here.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] kbuild: Bump the build system to 6.1
      commit: bd3f9ee679b4d1456d0d3c261ab76788950e6096
-- 
Tom


