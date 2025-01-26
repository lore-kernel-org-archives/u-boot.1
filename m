Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0744EC0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FED80F98;
	Mon, 27 Jan 2025 00:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PaO9CV7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D77580FDE; Mon, 27 Jan 2025 00:58:51 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7234180F98
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d88cb85987so36205646d6.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737935928; x=1738540728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfAwo/C2NcZx3XFcS755KilsRyXD7oa94JlphBk2NwQ=;
 b=PaO9CV7L8NQa/SbSUHUv3WwsqX44Yr5eLrabp1tXlTfkd8mraKJ9Ex8v8Nd2CYylbZ
 LSbIbnCOl6EvfxPZSiU9p6Np/3Sez5JWb8oaZ0INnnuHO7MMFQfdyAnfEaTMkimiO2MR
 hVR4dsqfvSQ8VTF4f5WCUS+BDn9IbsRnksNUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737935928; x=1738540728;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfAwo/C2NcZx3XFcS755KilsRyXD7oa94JlphBk2NwQ=;
 b=HcCfoah9tA7euR7w/Zo2tCd4Bd3JfMffa/yqNz1bC1uvSH4O+fnijxmHckT5AZu5ii
 dae95aqtyMmyzKHahHxbpWTx/ayI6nmke5yMFHHgx8kp9PAjrNznio950Ydq51JQxAoH
 mayfkHCmk9oFY9ZCLJSnjoFKADmXa5E+zpPSU2V14dfkC4b+OQB3PpposVvzWvDgtoCH
 MAHqI/AsfuPRZwNpQWvwvUmcsXdFPRPzMSzqE9Vj1LaSjumRbaxaDzd2iL8XVG8vGcJl
 iOVh9iO5zEryGvejL4rsqjy1JU144FPldijB0b46qejAfKK1gyMrHlG+qiFYbpZbK9Ob
 i8rg==
X-Gm-Message-State: AOJu0YzToxBR6/qeAT/K9Djg4RcLuXd/VGK2ccLlCfZgxwOLqxLV+QL3
 Nmcnm6DmOMqJ2/BjIAKRz3WYqWS42tRMG1RP3o3TiMF0tH8ruv1iE3DprY95jbfVFwLcQOHwlin
 p7y9FUw==
X-Gm-Gg: ASbGncsBkEDJVz2+1bB+fi71flNz0nqLKtWRwpyk3kShN8/3t0l1/pKNz5KvGEaEgbC
 rNq9ArNuO9Zd/BBtxYYZd7o0vHynmqCTsN7RbXccyIBM2ZvGur1QC0IFRCEMjaa+DnxV4kl4+cL
 Z7htK6bZSJcydurHfDLk6U0y7ENjo/+9KhDvIl3WPofz/Sl4HhhLUAAiik/U2Ou0ELK4/Li24Ty
 14yKc4G3HYfXrD9USZ1u8KKxPy3M0WS6j1oANY0cj4TGQfSxetPxtvz7dSyRyCtExhg6Ht+aYQ/
 nuI=
X-Google-Smtp-Source: AGHT+IFoDNLGxhAA4NEtXuTGn1r+6RsEI0CQWTipRJSFdEeW2zGSIXOmMf3QiHxbWxI+DR9rFbbBkg==
X-Received: by 2002:a05:6214:3112:b0:6df:9b3f:a782 with SMTP id
 6a1803df08f44-6e205df33c9mr184778306d6.3.1737935928386; 
 Sun, 26 Jan 2025 15:58:48 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c3332sm29367206d6.111.2025.01.26.15.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 15:58:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maks Mishin <maks.mishinfz@gmail.com>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
In-Reply-To: <20250122161505.74348-1-maks.mishinFZ@gmail.com>
References: <20250122161505.74348-1-maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: check result of lseek
Message-Id: <173793592642.1408499.16597271712324038278.b4-ty@konsulko.com>
Date: Sun, 26 Jan 2025 17:58:46 -0600
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

On Wed, 22 Jan 2025 19:15:04 +0300, Maks Mishin wrote:

> Return value of function 'lseek', called at pblimage.c:211,
> is not checked, but it is usually checked for this function.
> 
> This trigger was found using the Svace static analyzer.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


