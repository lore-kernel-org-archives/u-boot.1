Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCBAC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 20:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169CE81120;
	Fri, 28 Feb 2025 21:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oW01NSDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9935F810F5; Fri, 28 Feb 2025 21:23:33 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16648810F5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 21:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2234daaf269so3092405ad.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740774209; x=1741379009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMgGRjDgYBACPIpYQ/vGMdvKi2rVE2MSyCVr4la4H1w=;
 b=oW01NSDbMgv+g2tC865Rn56YzBN4Xx0gcbicF7kRKq0XI0d1q1LT69W1Q0hKIFENeU
 V4qRFQAmsxjklHIaiNV9ppw/DW4P0HJhI2oaJYwQhhYvL+azoqIm6W5vi0dEF6O2zKuu
 OXTSWdiEHUHVJEs2pirn9/UOITQ5Vir2CXRdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740774209; x=1741379009;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMgGRjDgYBACPIpYQ/vGMdvKi2rVE2MSyCVr4la4H1w=;
 b=cxicjjoH5pghhxNzj22vWuyzab5E4CDk2rQbmht29HRhXSDLpJXwmY+E1NH1Suwwmf
 A79l39LI6l1TFeJHPp+yGp8AsyfKjnjFG2WFlNQRWeoISh/QRIFdfrTx9Upk8T4DHsp8
 P4isS4JEXOfYjhmKdEfZc2eo5YyInpVz9kMJ+QL58prlRjCKJuJ97psh0ad+rSGD5G4A
 e6uYEDVMHHPP43LumImrEwVtQf8s1A6F0S8ZeW3bRFnZwNRPha6OEzIZr1kmqr+LvjCK
 xkJDvjJMhSlJZQo5OqtXZYvK3DskMTP5/Dk8bnmxDAMboFVuHGgbGPbgKoYNPgZ3mEEK
 UXjw==
X-Gm-Message-State: AOJu0YyDgi1pukijjRsYjiWOMX1jPH5lTicbovwedND7Rp0XlZJHc3C0
 JemuxtLc43rCpRvXA5+aCn4BWg9yeb2ic7YL0wExQ9Pyh5wypbjoGpao49vcuAA=
X-Gm-Gg: ASbGnctoVI+VKN/j3pvrdCAs5UbU2r1Nfw/hH6lAawt3eFYeEDCe4AY8/hRyERwjvI9
 imIFzo7L8heHtWaTq3T3ueEiWEb/AIWGP4MKGK3f4Lr31zEOEDJnXa6euEwvYlU3Hba5HJuKh29
 7MWlYULuPeDH8VImXFtdnvZbZaZaLs3uSt2P8p83KPqXPazu+blpTWXJqmFwo65eGaS0vRFtnUl
 GJBqk1wiinzSKQk960NFpPL+wNqb/49r0sOgqpRFfOK8RhsU9zMxH9gh1h5VFmg0wTKzCjI3MbA
 NwYxIhO1ccUd5MAeWDBDlMY=
X-Google-Smtp-Source: AGHT+IGiD8zAj/fvkSLhrCVfx7pZamQjkHKzCN3o/x0FBqB2xtIB5wyRxI8c3QzdWFibyUKUrocoqg==
X-Received: by 2002:a05:6a20:7283:b0:1f0:e7a4:8f7c with SMTP id
 adf61e73a8af0-1f2f4e01444mr9740361637.36.1740774209623; 
 Fri, 28 Feb 2025 12:23:29 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd19sm4288337b3a.131.2025.02.28.12.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 12:23:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250218-serial-type-v1-1-c05a15bd21c5@posteo.net>
References: <20250218-serial-type-v1-1-c05a15bd21c5@posteo.net>
Subject: Re: [PATCH] serial: ns16550: Fix pointer type mismatch
Message-Id: <174077420890.1188562.13124422333292959005.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 14:23:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 18 Feb 2025 14:39:45 +0100, J. Neuschäfer wrote:

> serial_out_dynamic() takes a u8* addr and uses it for 8-bit or 32-bit
> accesses, depending on the value of plat->reg_width. This results in a
> pointer type mismatch that the compiler may even turn into an error:
> 
> drivers/serial/ns16550.c: In function ‘serial_out_dynamic’:
> drivers/serial/ns16550.c:115:42: error: passing argument 1 of ‘out_be32’ from incompatible pointer type [-Wincompatible-pointer-types]
>   115 |                                 out_be32(addr, value);
>       |                                          ^~~~
>       |                                          |
>       |                                          u8 * {aka unsigned char *}
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


