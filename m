Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4C9E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40601800D0;
	Thu,  9 Jan 2025 13:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="brHkPCP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF1F8005B; Thu,  9 Jan 2025 13:37:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C45B8060C
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso377941866b.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426253; x=1737031053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lKk/uTYn3D3JSLCnUDCYtRvAG/j8AyZNG5hDVeCWIeo=;
 b=brHkPCP1osUwylPdFvc58Zj6olT4Z+thChPHyVgeoAz9ZXC7TuwOMYbmt+iHh7cs5a
 EQUYJXGlZk9/MrexbP5eHpLNzsLyETmeU1PEqWiNjeCnlaOnU5kP948sNGSwVp0us+tm
 /TxencN/VNPLE2maSEp7qh0mDGvTG8U7T7xY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426253; x=1737031053;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lKk/uTYn3D3JSLCnUDCYtRvAG/j8AyZNG5hDVeCWIeo=;
 b=smonxYsVHxh2QS1agYxIdTSg/FnFEOLUhIdxLqCRdZroZa3Td+i0L1ZYBxXYkm4a9X
 6QphpEr/KS807cFkSscTVTr/fOZa9z/fIdbc7cBCEveUF42j6r6z3N9583vO85dGkD5R
 bZ3VeESrLNCkFzfS0VCS0KdM7dV/ET/ihhXh7H3tzFQmQ5kCOyUiy9S4C3+pUBPH1BvV
 XI2EGmE7rB5sv278qRmg+NI7xzFM1RJq3qLUbs6csYAJWR3CQXcEOiR3REBxGb8v5Mc4
 C6EX7Y/DxgDSbfwpeBiV/2B9WyfplZ+9yhg9iOMd9AvagmYxg/7/xo33L5C5L+VEx4b0
 +l6g==
X-Gm-Message-State: AOJu0YwwQ5gf7txP71mE8MzNzHJsuHjymqM9vD+5z6nYDas4ezfzCBL3
 D41UHiDcI4Fie1z9D92brpKglxILIEfZeDvkOq6bJpJZUM0qcDeMaaCtZry6wT5UER7p4ARwG4E
 YjqGyfKd4KJ+Ujzo16ecduR13zyhorXq5qxbAFQAdkKJ4HEE=
X-Gm-Gg: ASbGncu639uejEaAeB5ikrWtTPBAF+JyQL3zc11wN5FFcAgGJd02RzO0QBhNFp9A57b
 LOSUh8lF65J49fqCwlaxWtzR3ULS2GYLy7qMw67o=
X-Google-Smtp-Source: AGHT+IGJfvPJZSnX1YyRJt9RP+2Y5tjJGsaILAVyEibj/5/FcyIWj8emRottKT/OZwTVnb/rrZnR3FZWK7SsTHKlrDw=
X-Received: by 2002:a17:907:c1c:b0:aab:882e:921e with SMTP id
 a640c23a62f3a-ab2c3c63988mr252123466b.2.1736426253532; Thu, 09 Jan 2025
 04:37:33 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:37:21 -0700
X-Gm-Features: AbW1kvb3xfhhYV4VZqrGl5Ht87dYGM2KarI9lH6Yl1WEVUz-pqCCFVRA1P_2seg
Message-ID: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
Subject: Lab failure on JH7110 (StarFive VisionFive 2)
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

I am seeing a lab failure on this board with the test_dm_compat test[1]:

=================================== FAILURES ===================================
559________________________________ test_dm_compat
________________________________
560test/py/tests/test_dm.py:20: in test_dm_compat
561 assert not bad_drivers
562E AssertionError: assert not {'starfive_gpio'}

Would you have time to take a look, please? A patch to fix a similar
problem on another board is [2].

Regards,
Simon

[1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
[2] https://patchwork.ozlabs.org/project/uboot/patch/20240611200156.2245525-19-sjg@chromium.org/
