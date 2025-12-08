Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B0BD3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F107683B30;
	Mon,  8 Dec 2025 19:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="joexdc8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F3A83B1E; Mon,  8 Dec 2025 19:54:57 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A7C83A57
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75b829eb6so3379132a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220094; x=1765824894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hijcxUn7eiwgdEMvVsVwIfZYelLqa/VtPrtiAMCqDT0=;
 b=joexdc8YG+xdpfvbt1Bu3vW/ZbD8Ihdj3YoNSh5LZ0f7kk/eCewbO9PUvewH5d+dtn
 I55SwktFT1/ZMywloy12cou3yZyW9UaBb5NIVm6tZQHVx2ti97v0MD0Mdf+QFflgEDK8
 wUthOUm6p0Drtp7iOkw2XDSoXT3DzvViNao5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220094; x=1765824894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hijcxUn7eiwgdEMvVsVwIfZYelLqa/VtPrtiAMCqDT0=;
 b=qvC3RyQF0MFEIHPtP3PeeUS86QAk1M7PfyyKyoP0sUAbQ7x7iFETaT9wqXhcjwyF/y
 1UkXXLfOtkq3AAgwHVni78DaxBAVXToGRL6U1Y5f8tYRYZye1Y7gsWMJRjlAHBto2/ha
 ndGPzoEsvMjOEuq0FVlc8epZvC55rxs6II+778ei5FxqXXSKtj8UYwYHzoU2rFyywQWx
 BfxNrUKOh8D6oDvqE51Xlkg7fKzmUutvInxzLd64jfNbmAR/O9dSbb6kKFhS4PqNsbuZ
 DEa3PRZNWg7iwpBfii7+wEGs+vljKhHF8oCJIgi7/B8X773VRPOxXQFmuaauEZpou8dd
 qtkQ==
X-Gm-Message-State: AOJu0YxPEGChMR2+67+JRdSCXlU2e0HlqL+cqkgiW1VDF+6As6VcG/6u
 bf6MKKyX8pp7XgpTkgMaCt66pzX7jxZD9bmnDt57mu6MaFZAPmKHtYzgmkXwbv93PsE=
X-Gm-Gg: ASbGncv+wvUr6MmrYew4CEdnIH6f5yco27xZ0ANwEr+AIXSuc11P7JSAZLUFBk3j6mH
 YnZYBP9LL1zEWb9QtcJr2ZCIqqvo6yqn1JAtnQxniS2jHio3i7AnWDwuPP6ZKjiQSuUvGZ2V/5q
 3kJtPsN4wC8smiGMkVxCwmwTa1q2MIqyYszb3dUohQsVm73VGge9by4PSmddm/ew7nSMTpqepY5
 q8YF2fO0ba2cNrp32OK0ET3ZluNFQJ705xmoIsi2KFPn7Royn7V+u7CsUpKklDq/n/zWHqhK+mj
 imMw+a4L9PagM9vqmJA5qU2RzaSGk3Jy4lRdwekdd7yB/gkD7Rxvcyu7S7h8l9xv2n4BPldR17o
 H7V3oZEn9kmQVdP0F9iSv5MDoCAzhoNkmNUORdyyiiHCH8B5/aK0CSB/A0ubGUvZch8sRyUyxiF
 t1hMm30/jJ8dYS6fSiRQLs3lul8FM+64MpJ6fWVZPy+Zx0YsJF
X-Google-Smtp-Source: AGHT+IGB2foYQkbolklCZVWdx9fqHoDX4sy5Z4zH/ok2NNonkin4FMZo+q1drU2QK+6Ij4TJBVIKQQ==
X-Received: by 2002:a05:6830:448c:b0:7c7:64b7:83e2 with SMTP id
 46e09a7af769-7c97083d179mr5253933a34.31.1765220094486; 
 Mon, 08 Dec 2025 10:54:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm10890864a34.11.2025.12.08.10.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 10:54:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Derald Woods <woods.technical@gmail.com>
In-Reply-To: <20251207145028.2902758-1-trini@konsulko.com>
References: <20251207145028.2902758-1-trini@konsulko.com>
Subject: Re: [PATCH] omap3_evm: Take over maintainership
Message-Id: <176522009388.376851.711306281833134864.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 12:54:53 -0600
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

On Sun, 07 Dec 2025 08:50:28 -0600, Tom Rini wrote:

> After talking with Derald, take over the maintainership role for this
> platform.
> 
> 

Applied to u-boot/master, thanks!

[1/1] omap3_evm: Take over maintainership
      commit: ae184121e00b131b84c04885cecfded18e320a8d
-- 
Tom


