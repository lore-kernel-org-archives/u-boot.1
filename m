Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB2D74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA10891AB;
	Tue, 29 Oct 2024 23:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sIiVdhjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6039A891A9; Tue, 29 Oct 2024 23:28:20 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D2187BF4
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5ebc52deca0so3020699eaf.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240897; x=1730845697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BMpbLfYgXLfl4g3ERDa4beTncKuIGM64Ok6BUd1C58=;
 b=sIiVdhjDqZd43w10NNJjOWj9GfVNFw86BhB7dsJ5B+9lgO5OWnB0opwuNzz/Cj8pSM
 UJMoNJykZ9fs/rLLmkXG4xoiqUOKbFOV0pd4NFC12Z5Mf1WZlzWQWC5XjSDErWIetQzE
 3Fgs0G5IMGoaMNhKWBwNUXWZ0qyEn9vKaFApI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240897; x=1730845697;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BMpbLfYgXLfl4g3ERDa4beTncKuIGM64Ok6BUd1C58=;
 b=V9pX3sLIbXkDDt5eqXbPYDlPhTxy265HQmPRrdeRVK24ISit1HyY4tB/tOc6AJNghq
 g4Ru9/qA59HDRiQNufiAJ8Ep+ajpsf7yaK+NNxEW6CASPQBWEeFiMIGCmz2CzlXO6aiu
 +3MVwDZVDgizDlVm9t7DxncMJ7zkI+CG2W8HZLHNMzhFD4sN0BpP0vCCxFNS+/8kLC/q
 AO2wzSQao3wEIGIK2yn+A9dYyf13bTw3YmlNW1AQWVBkk+t4YfK4mmGjvEEvHug290Y6
 pPnKmk5cZBaGdy6Th5ogrXZeQvyls/fXWhyHOa6683oUnWQc46DWHn81YXlJMCRKL+XK
 Qt4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS6yKUSR4huDOeTTrihTupRjS4OQ6f7U0/S/DBpGNlRo6aGgz58yif9agzV6/cUCgAa6Bpauk=@lists.denx.de
X-Gm-Message-State: AOJu0YzKeUrENO9s/YZM8A67m4wg1SP421eHNs+bj+pIc0b0Ew1mgVFr
 oI/UQUeQwmbPWDLwkfrFITeR3kHqueBBmnxWj/vFAedeozMV6+iktc7Tneb6Qpo=
X-Google-Smtp-Source: AGHT+IHFyjQJhoLvtnfIHl5Z8ZLBrTRHJsHEBHX6L2/BLph81JHX+ohLGK1kSqVkj3EzGmbhBHuXCA==
X-Received: by 2002:a05:6358:787:b0:1c3:698:208f with SMTP id
 e5c5f4694b2df-1c3f9e839f6mr682807755d.8.1730240897086; 
 Tue, 29 Oct 2024 15:28:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241019102445.48624-1-heinrich.schuchardt@canonical.com>
References: <20241019102445.48624-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: simplify network definitions in Makefile
Message-Id: <173024089517.2563570.16989189475634162053.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 19 Oct 2024 12:24:45 +0200, Heinrich Schuchardt wrote:

> /Makefile already adds lib include paths to UBOOTINCLUDE. There is no point
> in adding the same paths again.
> 
> Clearly separate the lines relating to NET and to NET_LWIP.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


