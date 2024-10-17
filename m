Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAC0D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C83D89104;
	Fri, 18 Oct 2024 01:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n4VzoByt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E18B890E4; Fri, 18 Oct 2024 01:11:46 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7495A890F8
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso8163386d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206701; x=1729811501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JSHv9tsq/zsige5tf7vXPEaK/raMSkmeJVU42qVRcEE=;
 b=n4VzoBytVja0eKi7CQOaP7F4MDWZYg/zeqa5Cw5BM9baut6Of9AVDVuuK8nVe7DAb3
 y89C9FQx7aVOjmSvvfxbRPOjs+f019DBxs/h9WEp3/hL3XhANkr75XKQhP4PJmsdCxRA
 l62S5r8+RHxqYRy5IoDew+ZI0pc8wr1NzkOv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206701; x=1729811501;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSHv9tsq/zsige5tf7vXPEaK/raMSkmeJVU42qVRcEE=;
 b=IJi2llqy5zvGPxdUIcKgxBRPpsv9WpEvYp+hwaXidFZVAWbu1lKMXXxgEiZa2Mhj15
 TEzm76c5zjAImlrKYpPrFrP0ABtxmLpVJDeH9geGR2NDdNuI5eGu/M27kgkxPY9NDeas
 AT19Pkn6m1GdBHHTHqmJSzYtFZcXE9QmpBNwwOqQ+DqMOBRgDvIxJGDKVpO7E/5Eaig5
 UyxJFkXlYJly+YUPXrgtzErfiJYdSufFyO2Zd9NHS7QXgw4DVrnXqRAlxZkryVGfrHeH
 VEo1eHN/D+WrsC5v7QoQzJ06d7jU+CxngacXMvfvXPYxZAh8LNDjmDFCT156lca+VgNr
 2pzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlEAAL6/pnu9ZQhQYOUmsaIMWY9rLSRnS0GIiQQEiDon8DtFTaeFmJzmPhnCpWknLB0Gfn8tM=@lists.denx.de
X-Gm-Message-State: AOJu0YwfXcBZ1nxgzESuyCgsrMMilZHNLTPaMvDDddwle4b3K7oHVhpy
 JGyY227WepYYe63scptr5f9h5TgbyGBg6LouHCG5GxArey2xFcUd1t8fxGp+EyJkfSAH3sDjYfs
 gtgx7XjI8VTkRcx+jl9/aAVULcdSe1S0omnlt
X-Google-Smtp-Source: AGHT+IHNKvWQt3gK8u+5KB2bbSAAer+/h9HhQNHE/SF6DFQYg1Hud7jV9P89AsiOhTODx7gnO8oErv7HoHXh2zqqybE=
X-Received: by 2002:a05:6214:5c03:b0:6cb:e770:f505 with SMTP id
 6a1803df08f44-6cde1635d8amr5547406d6.50.1729206701390; Thu, 17 Oct 2024
 16:11:41 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-7-sjg@chromium.org>
References: <20241014223212.2212442-7-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:41 -0700
X-Google-Sender-Auth: snrAMbRIQBHw-34z7XijVxL_mW4
Message-ID: <CAFLszTiFDRzkKHn_uHHg5K561wZtGfH=1vhycJ4PwY_HkZtOWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] expo: Allow menu items to have values
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

At present menu items are stored according to their sequence number in
the menu. In some cases we may want to have holes in that sequence, or
not use a sequence at all.

Add a new 'value' property for menu items. This will be used for
reading and writing, if present. If there is no 'value' property, then
the normal sequence number will be used instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/cedit.dtsi     |  3 +++
 boot/expo_build.c               | 16 ++++++++++++----
 boot/scene_internal.h           | 10 ++++++++++
 boot/scene_menu.c               | 17 +++++++++++++++++
 doc/develop/expo.rst            | 10 ++++++++++
 include/expo.h                  |  2 ++
 test/boot/expo.c                |  1 +
 test/boot/files/expo_layout.dts |  3 +++
 8 files changed, 58 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
