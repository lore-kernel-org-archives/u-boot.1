Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E1BC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD1980EBB;
	Mon, 10 Feb 2025 21:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FeHaMe7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8481380AE5; Mon, 10 Feb 2025 21:38:58 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E7880C7E
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fb0200b193so10810617b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219935; x=1739824735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLxNUDRJKtlfJNuWw02vAcJaC6FWGa5FFCWgnEhzsUo=;
 b=FeHaMe7wfJSrO8eyQqp4y9JSXgSYZsO9mZfOAGkzufjYBzHV3ZdqskrwK19xGLj9Qz
 kyibHca5yc4BM4pDRkOXx81OApmQ/JoPPJ4134fsCSqDFnFrb663HzrIWYUg4q1DO0KN
 jJURytVEVzstHVQmng8gSSj6slggkMOYUCIXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219935; x=1739824735;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLxNUDRJKtlfJNuWw02vAcJaC6FWGa5FFCWgnEhzsUo=;
 b=dDUesUL1kj8FqAB4CqrlC2r4b29knPl+2q+VPfgJXcO6ABx9qY7DtpBQDFNe+sUqyW
 bH0GeAm2lnWIaP7UlGok8cPZdywMYdR3xdgWe8adHgW0P53ka4+vqQieW5jRtQ7HdnI2
 uU0myG5EzfI/mrZc666JVYrDCLb1TIkcz0OkGdGtuyi1WObTNggqmB10rsGUGd6wg3BR
 6ntClZ68a9uBTE0x76n12WZkWxegD/Ho32z2rWWXguLvjEnIFEln2n4BagLkQF7jNJxD
 AD2hHU3SBRe+2AtjA5+wwaBj2Li2bkpYTJBDF60JY7Sdg4t6ada0IAU4r99eHOkmCsrD
 GV/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFpwvoAsXZH9Y7eh8h7tGRFE5nMSZ7ndlSbIq4lQktLXvs6uJaCsY9zcttoLLncMpfr8DpPI0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyis1p8TaQMAXaZHHyry5a3FQCDaw/pULMGhrmudtsFhKnJursv
 Sjft5pj6OBHO+GCrElAjKfrgsb37AnDvz28u3rK/oD2A0YntpojHSC2Xzsv5T5MEnQzLB1Q5nSu
 k
X-Gm-Gg: ASbGncs0tpfOZPl+RZQ82hG0hqEMYfelVKBTlcSCoXBycC4I7Z1szf9PVSRtwdXueDN
 60/7vifMMUuXLftpHuwGHBSynjRJXN77jEhPt5Krj4I+lzCiGG7pAb4KrHTLEAvJEIddDqq0bmg
 tJJYB4xYqPeLDQvF+1Jgc6sOPS+WscdN0jVl2q9F2tvF2R9yrZTejn1GDAbnZ8eQ+bwZbPOftQy
 2J8oEufijTHggLg4dbHSH/e6J3KCeq3IJRvdC/9qrHUAaAj6z8YAOEoprLBrBvuAk0WgayPVmS+
 /pNUsJfnoW7CIQ==
X-Google-Smtp-Source: AGHT+IGIxglfeaMY6lUbnNSn9mOAs8ZoZ6eOKLdRhKDhyMTy8wCFMuZidDTHUmcwbI4t9S0iACsZBQ==
X-Received: by 2002:a05:690c:6886:b0:6f9:9e25:e984 with SMTP id
 00721157ae682-6f9b280e44fmr160115467b3.6.1739219935312; 
 Mon, 10 Feb 2025 12:38:55 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250129234403.574766-1-jm@ti.com>
References: <20250129234403.574766-1-jm@ti.com>
Subject: Re: [PATCH 0/2] Enable MCU ESM reset
Message-Id: <173921993446.2921783.13361681556766145279.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:54 -0600
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

On Wed, 29 Jan 2025 17:44:01 -0600, Judith Mendez wrote:

> This patch series enables ESM reset configuration in board_init_f
> for am62x and am62px devices.
> 
> This is necessary in order for error events to reset the system.
> 
> This patches are tested using watchdog to reset the system via ESM.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


