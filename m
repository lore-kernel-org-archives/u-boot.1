Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA7CD0BB6C
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34004891E9;
	Thu, 24 Oct 2024 09:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ww/SUQhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 270D78929F; Thu, 24 Oct 2024 09:47:04 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF14388C66
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso3756395e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729756021; x=1730360821;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXN1BqHS434dJDr7yRXybt/0IbX9GOU84fRRJ6iYtpU=;
 b=ww/SUQhzZZXDqPa7gywu2OuhfXDRIxJKPigntbFC/3U8TPG0+8ID+4VD1oqbb4cwTe
 8jo38X7KC35io7IL7xynjwbp4+ktsNGmU1W97PS1/gYBNJyA24/xbah5HX/qrNpb/69U
 KT8J8Y6HmMjgfhguAhQRMIEtDrB1mvMMlpvnxjTjFpeqfm6Tg3uwjdfSknLKOSqfe0Ks
 xJ6x2wuV0+fSvOnQhnyr6MiI0b8cuJ7cgHNdaRAg+zxaJ1uc3dxeCvNOxrSgxfo6UaxM
 seMJPaA4gXFzUzMKJrNF37hYQEp3dEMLtTVHVFzu7tH7KMtS7De8vd9U9N6k0UzzTci9
 +1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729756021; x=1730360821;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXN1BqHS434dJDr7yRXybt/0IbX9GOU84fRRJ6iYtpU=;
 b=B826jfslVp6fTTuqWAUW59jtQX/bTjNVxXY8crUfGPnzi1jmCL+x/OZfXt3EHjH/ix
 NeO90ou7xFD0N/vDHG5k6BGGyg/+inq0lusqzRmQZ/X93ZAOpnQxxZr44Qg5e1Ftc8er
 vEGhLpmaHtx0DDudB025hqPRnTBeXhHX/VOGBY+msYXg47aMlPAJCifw3GZqDIH9vNBB
 mFzsJvm2kFnNaLzddY+GBTQZtf/RLgZYBdcs1EVUAEk1tJv6f8d1/Z+u9wrzPqQ/+W3Q
 9OEbCVMz5BfRQjE2EiMYobR7IMwbFFErKjVs0vmNBeWkOSL/batq9aXiLI8XSn/vgvOo
 eoWA==
X-Gm-Message-State: AOJu0YwXVxN7KdtEZF6iFsbqRzzk7sUVIXPdtVRgxMNhfrAAeyAi3ef1
 taIHa7rYoJRgF9NFK5lsoyedJcr2G2QMltRPOK204jlkz5FMK0O/tehtXbsaKoo=
X-Google-Smtp-Source: AGHT+IEIzLhJ77vCp0/QuTV552cPpCGmlRHcdaDFMvdHcqbY8nfwWp3B3gAbH96x7UqoCDjeLjGFHg==
X-Received: by 2002:a05:600c:13d3:b0:431:5475:3cd1 with SMTP id
 5b1f17b1804b1-4318bc96684mr6172155e9.17.1729756021212; 
 Thu, 24 Oct 2024 00:47:01 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f784sm9454765e9.19.2024.10.24.00.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 00:47:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
 kernel@salutedevices.com, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
Subject: Re: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-Id: <172975602033.461875.1463841357229333439.b4-ty@baylibre.com>
Date: Thu, 24 Oct 2024 09:47:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 17 Oct 2024 17:12:05 +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - redesign 'bcb' command to U_BOOT_LONGHELP approach
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/6] include/android_ab: move ab_select_slot() documentation to @ notation
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/01874ac7c06b8c657e7c3fda5ac555f821ef5b36
[2/6] cmd: bcb: rework the command to U_BOOT_LONGHELP approach
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a8ca7d46ea744381185c0bf70cbdf4db7dc734b7
[3/6] treewide: bcb: move ab_select command to bcb subcommands
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b523b4d2c32f07ca0793bb0f926b02ecb0556cc6
[4/6] cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b1bc9a2fc93da8ed25dfc4078e76220ac26eb6b0
[5/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a995084beb6682748002878ccb4b8c4de9fc0136
[6/6] common: android_ab: fix slot suffix for abc block
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/55c876c6f9b787488c7a9f9c678398c48d13db6f

--
Mattijs
