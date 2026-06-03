Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13503CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 20:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317338486A;
	Wed,  3 Jun 2026 22:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRMulT0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FB4839A8; Wed,  3 Jun 2026 21:43:30 +0200 (CEST)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954BB83314
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 21:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso1669949eec.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 12:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780515807; cv=none;
 d=google.com; s=arc-20240605;
 b=X9lKIdHrLx4n4CczeQVFqDmwzg+3bZ5x10WlOkQLaRX4s61t9PD+dGi/7EtBaoK5CS
 8WgahjcjjKVCVQz7BWx7gBWXyBkMn+FX3RW4oYybcFiVx2xQ96D6oGnW0Mc66hBGjf0h
 e37woaKQhdGg080OJwJfrDaR4AzUuWQG0vPYHul2d7A7sFCJ84jXWLFe/5AJ7Y++0572
 KRFDodgiObHue9krNafZ3Hdz+bOaK1goyfYIPZRthhf46F27mS2cNxGCVdqMxG6ON+ct
 jRk0KWJGfhTJFrXPfiZqEorRl0gxfFFnFVFXAkOYeb52YrbVs2rBtkwZnfAIZBi92/CB
 ANbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bbxyGqSKxsY23ZY99vPiVf8fKg0wqW0abM1nzaKXzEw=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=P2ZyH9lRRHC1TBLDiKC+01PCbpr5acJtOxaz+p+hPk7/7CZS0pE1LfXsATa35Xmqcb
 qq8LjpEXXpGJr1DeIJpxHnYy4lvYmjcxxnRZgSsJiIfvSbmBZ2lRaSN7Js0A2G5yQI2d
 n+waBYASowKQylQNntraYuSsNwY//a9SJZIqBeqwmnOmK7PDIZgS41u1qufxeHJ+baDX
 MACnNHQizoPUU+56X6GNR8Wfj5TvZmjRO7tXN258u5Fuf8Nhhq8x2896ITuGMGDPsojr
 pPMTu5XTdUUOM7EsIYxKxDZ99LRURa4w/1cGJ6HKSgEz3eZxNhkrBmllui0SixrGc1J/
 t36A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780515807; x=1781120607; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bbxyGqSKxsY23ZY99vPiVf8fKg0wqW0abM1nzaKXzEw=;
 b=kRMulT0mu0tT0k0LRbmnXd/f24BH2udoYNd3xH36kG6xgh0KgIvHudu9j2LZuhpHuZ
 UCKAMN9QTUMTiI3IITchJebqxN3tvA70dSHYfDtT71eC7QvGLtsviTzbaSe3B+9w8dqW
 JIxDfnVHnqal+R5LnGBKC3Qk8o4kRA33MboIq8xMTw92OqNkVS/p2EQ4U9v8l0L9cxpy
 86sWUzPL70K5xnY/Tnug/H5OpkE+/Z8mFLeon9qdjZNFircQBQFXa3mV3K89fCbKco0x
 9YG8OIQz1v3g1YqkDBMEaVTcDnScHbRsCFFBGuHx009stgBLh4Zx+QSbPkZcuo9tFtGT
 3bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780515807; x=1781120607;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbxyGqSKxsY23ZY99vPiVf8fKg0wqW0abM1nzaKXzEw=;
 b=DecnP32YB8kwc6yvtop8oaWct26Uz69VQXYa4hnzQHXUvAw1gfUaP57c03CmYAE9J8
 pHSh7dA2KN8hNMebdNumePtedsSVbM67m0RQx/yXhOFhb5yVRJvunkhNlFZfwD0rSmF7
 73Waw3zj+jlWC8AaLwQETBMybXlnLGj89bSUp4JckicQ2F7SR9FWGcNPkdWqVQ0WM7km
 4+bIQ3H77ikDgHr/ANJkVCbhmNTuN7BxzdKquckdi9cAzfnENcflGj0lo40JZlKWplzo
 fbvVUoBPZEKD8rk4r/r3JHlEOujk8FaysLoLWxKWDoGGpm68Bvwt7xnMmIsWGlvei/9i
 XwpQ==
X-Gm-Message-State: AOJu0YyUMOQYtJAthqESn0Xcf9C35k2IjKnJ/Hlg/jzv3bs0SpnqGQe7
 MNHMtKHFyeCBcARAwTUZOyfpgeZJ/zxLdOKHZ1bcAvTAkbETWfwOky/tVTszPo09E219R6ZE2CE
 D8uPnXwS3caiPn/ZplLeZ9LLzrr5Dd3epNJBs
X-Gm-Gg: Acq92OGa9Y0epP8gPpH1rJ4y1kMxKvEsevzHI8JwNZpGuMVoQtMe2oCKmuIu+vOsDfy
 lUKwMh/yQVxUxWbqG9UOk9BKahImRglMRysI4xXCheux+z5jaa5C/9i8tl6wIJ+lN6f+bi5JUl5
 FhriXH+vrNV06UrLWt8MXN6VcxcxE3JTB1EraOvUrQ3HSCmVe1uUkDo6N8OBJxC1jI0wqI3RPQ5
 Qd5ine2KwZsqtZvLghxhXcn2I30O1SdnNyTUN1S2DI+MZdj7D2Yez8eHO5AxYmUAHcnv+2SYRsw
 qmGqDNM2NwUAzTuol9HsLaS3L8fxcANu9dG0zdiWZ500NsiBkZTTpwkb857Q9tOOgfLp10ebOke
 yUS/vBDA98salTR9NR1ETqJY8YznpQVLxWYqqVr2fmlxE
X-Received: by 2002:a05:7300:6421:b0:2ff:c84d:44d2 with SMTP id
 5a478bee46e88-3074fa889b6mr2721705eec.12.1780515806751; Wed, 03 Jun 2026
 12:43:26 -0700 (PDT)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Wed, 3 Jun 2026 21:43:14 +0200
X-Gm-Features: AVHnY4Lt2MZqTAIw6yfA9sMvSKntLbk8NdP-GzBh3bdxxHDTMgK9qfukIsfEAg4
Message-ID: <CA+DkFDZfJp69HCveNxgEGjUn8K5MDhq15BWtMkGJYBF1WqfYrg@mail.gmail.com>
Subject: J721E A/B boot with tiboot3 in eMMC boot0 and remaining firmware in
 UDA
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 03 Jun 2026 22:19:44 +0200
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
I am looking for advice on how to implement an A/B update scheme for a
custom J721E board.
The BeagleBone AI-64 eMMC layout looks close to what I want:
eMMC boot0:
  - tiboot3.bin
eMMC UDA /BOOT:
  - sysfw.itb  tispl.bin
  - u-boot.img

For my board I would like to extend this to A/B, roughly:
eMMC boot0:
  - tiboot3.bin
eMMC UDA boot_a:
  - sysfw.itb
  - tispl.bin
  - u-boot.img
  - FITImage
eMMC UDA boot_b:
  - sysfw.itb
  - tispl.bin
  - u-boot.img
  - FITImage
eMMC UDA:
  - rootfs_a
  - rootfs_b
  - metadata?

On LS1028A I used a fixed, non-A/B BL2 as the early boot anchor. That
BL2 contained the A/B selection, metadata handling and rollback logic,
while the updatable A/B slots contained the later firmware and OS
components. Basically the boot process follows the PSA Firmware
Update.

On this SoC I would treat tiboot3.bin as a critical anchor component.
It could still be updated when really needed, possibly using the eMMC
boot0/boot1 hardware partition selection, but I would prefer not to
use the eMMC boot partition switching mechanism for all boot
components.

The missing piece is early slot selection. As far as I understand, R5
SPL must select boot_a or boot_b before loading sysfw.itb, and A72 SPL
must then load u-boot.img from the same selected slot so in needs a
place to get this information from (e.g. FWU Metadata like on LS1028A)

I also noticed however that FWU metadata does not seem intended for
SPL use in the current tree. For example, lib/fwu_updates/ is guarded
by ifndef CONFIG_XPL_BUILD, and the FWU metadata drivers also seem to
be built only outside SPL/TPL. So I am not sure whether reading FWU
metadata directly from SPL is the expected direction.

My questions are:

1. Is there an existing recommended U-Boot mechanism for this on K3/J721E?
2. Would it be reasonable to add a board-specific SPL hook to select
the MMC filesystem boot partition dynamically? If so then based on
what excatly? (Related to Q3).
3. Should the slot state be custom board metadata, FWU metadata, or
something else?
4. What would be the preferred way to propagate the selected slot from
R5 SPL to A72 SPL / U-Boot proper? Backup registers / I2C RTC RAM
byte?

The goal is to keep tiboot3.bin as a small critical anchor in eMMC
boot0/boot1, while making sysfw.itb, tispl.bin, u-boot.img,
kernel/FIT, and rootfs part of a normal A/B update scheme in UDA.

Any guidance on the preferred architecture or existing hooks would be
appreciated.

Best regards
Patryk
