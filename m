Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A303C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE5C81F95;
	Sun, 23 Mar 2025 13:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLlFgBdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C0981F95; Sun, 23 Mar 2025 13:23:34 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BBC81E13
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso32617935e9.2
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732612; x=1743337412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITGzomHGqlNZ+3M/Bf4Vq0obByW5e55Dh93nE+DdX8I=;
 b=DLlFgBdUu25WW/w8mF2T+ZQ3s7fgnXEPdMzd4H6RFa6YIg7zNzvWULbbtohGUGbomn
 +4zd625yfGUOHzIsfGxCRyivHqZ35l3mPlMUhlsSwanuTyk/s8lBvPaFSWEoMRR9Ir+E
 yY7HELGXnkTRDa3JnAca5sZRcSmIbAmqic8zB2rPTgGKcXq0aOaG+Q53qfiX+q+KLhYt
 7cwA097m/11Hj4dvinL2k2ofa9O8GpBIKkQWBmN2LaQkT4DMJPOa15GZo/vCrDwZ7i9x
 DknRiBgbxMYNoMqACwZRyMZXzuYBqQEqicylXwCUbHJdh61CrM9OZD9p/Le7LH8CGBNL
 e3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732612; x=1743337412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITGzomHGqlNZ+3M/Bf4Vq0obByW5e55Dh93nE+DdX8I=;
 b=PNeQxzBB7icVe0wvDi2LYvPXltAFuOqcDGL5B+CAU5oQPZhGkOInYzOwR9tr6FAqqA
 VdPqDGSSDVEN0j8lvvMQRovkE0TXkXfWwaxJPkCAsCVnk24xSPd3B2t6NzmPXnBxupuP
 io6WDyPEYFZj6PSc+qFjau7waDLqz9m2qaoKxxrHvFRDDy9LO1WdMdryFMtYap37UfnZ
 5clDGFsJ2zDy7jWvDnDz7vrnVWb/31CenFDA3oMfQkWF+v3gnH+LP2zEo0fYF2j138Cj
 uT8TcGyXBUiweGkWVMfsw4VY48Jco7ZtQ9+x4DwDDU4hQ2XZ4cSe5975+AZNl+2/zTCn
 ZdCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKvhZdMuxWXloH/MoMvChSpBk5rgPMGK6ZaX+WhkYXjXM9f8XuFYFyefuUMtkNUf71IlIHBxs=@lists.denx.de
X-Gm-Message-State: AOJu0YyDlMPHDfdFaP5IaN1l4FAtUp0fYb/luKlKXzuwb4JIwHV6TlRX
 NhYgOP5tSHy4DOa1qG/DT6nS8gOlfVVkuOO5IgKEwwxPuyPa0FxL
X-Gm-Gg: ASbGncvewmtOtgUf3Dipj86WZ1hDps8CVOPc+wdFSN5q4MYvhTUMxH1D0LUn7nl62IA
 HO/M2LzXsJ+/ofFNJT4mpyylwL2saWt6aVtFr8I1iGlUhpaITATpbzHtSlptQGevBoWtfT/jC1n
 0KdIyH0UOndtZ9teQIBQ0m4QOek5MTPPCUHwOgeHOpv1sdaZ95BMnWEsZ/rMvjmVAlR6tSLQI2S
 K49mjFWBR3P51hgaMZ7Rjr+L365+oCoX93M6ZJXVhyHqmSXlhNraJPeWsTkUTE6C7tNXB3nAS7P
 rD9Aq5jOdUMwlekI19mBZmPYpWghqOqS4KfcZL8GOUBBcEzB0bKxVI/8pitJ9y1j77ZKN74y5+v
 hvLnZ72q8f1Mi6BB+zamWA4wQ3FdhJPA=
X-Google-Smtp-Source: AGHT+IFdTpMYk1hbEnwfk3GGoCnQQoigUura2Ouq45WN4gxQRkyFCNphUBiIl6z1NzLUpK+pWIjlQA==
X-Received: by 2002:a5d:5f50:0:b0:391:47d8:de2d with SMTP id
 ffacd0b85a97d-3997f90ff8amr7922895f8f.23.1742732611795; 
 Sun, 23 Mar 2025 05:23:31 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceae03sm87764665e9.8.2025.03.23.05.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:23:31 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 24/34] sunxi: armv8: fel: move fel_stash variable to the
 front
Date: Sun, 23 Mar 2025 13:23:30 +0100
Message-ID: <22634483.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20250323113544.7933-25-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-25-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:34 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> To return a 64-bit Allwinner chip back to the 32-bit BootROM code, we
> have some embedded AArch32 code that restores the CPU state, before
> branching back to the BootROM. At the moment the pointer to the buffer
> with that state is located *after* the code, which makes the PC relative
> code fragile: adding or removing instructions will change the distance
> to that pointer variable.
> The "new" Allwinner A523 SoC requires more state to be restored (GICv3
> system registers), but we must do that *only* on that SoC. Conditional
> compilation sounds like the easiest solution, but would mean that the
> distance to that pointer would change.
>=20
> Solve this rather easily by moving the pointer to the *front* of the
> code: we load that pointer in the first instruction, so the distance
> would always stay the same. Later in the code we won't need PC relative
> addressing anymore, so this code can grow or shrink easily, for instance
> due to conditional compilation.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


