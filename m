Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD5BC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC9F80540;
	Thu, 13 Mar 2025 12:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLeCnkjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F2980FF7; Thu, 13 Mar 2025 12:19:15 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1378007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso1444599a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741864747; x=1742469547; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LcOGMzqbG9qrir/sELUDkQ8pxCXHysKWkD3SnECYjG4=;
 b=ZLeCnkjY9X+uDRAIwC+vMHA1YeEczuss633DfPtb+3ZRyJ1TmriN0fvl8u5PXFNs4k
 f+wIK7CG9VXvulA0kJfzWtJK+lkbyzoF+gCeLfC9p85TnI3QOYDhxcGRNAkszANMlidA
 KqddqbFfJghqxMOjjpn/nbOUtrJv2m9jQ7QJ9luLyz+yk8nObLFvxsnyVxLEf3LV9sdG
 oUpvLF5UG59XyzwffiVVutoyBSqwhaa5bL3debSK66QytiVlGy55W48SXe4N7hvhFrUz
 3tDfByCqCZgJMiyz926i0ridptcM4WVuxji8zbLXn9vQyvFXDtIXuoHnngMMAMLx/oRU
 Wr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741864747; x=1742469547;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LcOGMzqbG9qrir/sELUDkQ8pxCXHysKWkD3SnECYjG4=;
 b=B6BQddfOtnYGI7v/V/XeEK/sflkJWrSUlEPxn2H74ohLqywXedU/5BVKtXXn7YqKCZ
 m6WJ6vK/SP1ZJUFxJmT8v2jxQAkCHqYoRSg7JFH1SQ1Ng2MJjK3T+ku+ro2XEomC9EiT
 dU3YLHUXW2X4ZdMb8OvXFRoH6KaDArnAEHS1voo9Okgudv9CwgwRvQhXsC2fjLIhw4ot
 m5/82qJAqeAfx15yIPq788RrlES5TVloEUk+AnCKJfwPHwZaY+rMTxeDo3BbDEFyjBgF
 fiGDnh5vildQBc7+/L4jf7I/UUVu0Ao0FNslXbFvPQsOUY6xRgEmNfVica7CWgiqDr/S
 TA6Q==
X-Gm-Message-State: AOJu0YxLlb3hozjlb8nZ035Fhl3MVeIfFOaVw/QwLkONCuWmN4jtOY98
 /DED0XWMwfzImPx5wIj6zpjHKanBc80D85cTnvuiPyYEl4dGwyo9pCdUG+8xFNi/nTasQqEhXuA
 Y1DCmORIJR5mqLZIvB+B4mMVxxdSHhlH3
X-Gm-Gg: ASbGncvzG0X8a9FdN85oUb4z+nnTir8PNANO6NukWyVH9woLCFqifVlcJFfPid3vniD
 acYLkHrQMq9oA1Y7gFAv6Foize7zIl0rSu5mZKQWCQ3dcF2/Zi+kafeP/JuSsEfapv6C1RBU9ch
 Gg29/QwJHi3vSJ8MRhd+bcnfN+tWbaL+5CEnIRk6agxMhTDYFGv2oW5VJ9zoEnWhMyd1ZPmw==
X-Google-Smtp-Source: AGHT+IEHt5NuoruYydy9oIgkir3RVD3BecRib9gG02/rHwddIdBt0v9L5q+yQ38UjgN3D/FspV1sF4uNd1kVrXxtrHs=
X-Received: by 2002:a05:6402:2346:b0:5e0:60ed:f355 with SMTP id
 4fb4d7f45d1cf-5e5e22d98dbmr29784041a12.18.1741864747174; Thu, 13 Mar 2025
 04:19:07 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Mar 2025 11:18:55 +0000
X-Gm-Features: AQ5f1JrhW5OprzBaMKGlLRWNlxNbWBt4xrwibsbEybj4uDQKFqQd3qGewAQjuvs
Message-ID: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
Subject: Pull request: rpi-2025.04
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

Please pull the updates for the Raspberry Pi.

Updates for RPi for 2025.04:
- Copy Bluetooth device address in DT
- Keep warnings from firmware in DT, if any
- Only add frame buffer node if CONFIG_FDT_SIMPLEFB is set
- Add identifiers for the new RPi 5 series

The following changes since commit a383b9bd4d7e430fe7c254297540bae596649dba

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2025.04-rc4

Apologies for the later requirest. I was out for a medical reason, so I've
limited it to simple fixes/bugs because it's later than I'd hoped.

I'll do the remainder for the next release.

Cheers,
Peter
