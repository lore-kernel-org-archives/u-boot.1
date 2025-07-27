Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E0C87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 12:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F53583013;
	Sun, 27 Jul 2025 14:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdIZGikq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050688304F; Sun, 27 Jul 2025 11:49:32 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F15483045
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 11:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baleswarmunda0.1@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4e80edfa06fso987212137.2
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753609768; x=1754214568; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cuPNHl+ca9dPGpqrCDFZfcGJy9+49Vpeev91I/OgO7E=;
 b=MdIZGikqi4AjysWMu5MAr9CZDlu8tU/GsMSaojcGm3ndOkktAow+VEkLChgJ2ypp+M
 i0IPR8Jayhh6sjbTmAr0JL9Sb/z0IdWg0Uxepk9Bn0UqNpqSvYm8ULPN9tM4kakoVJqr
 NexqPD1fujjYQNJV1D/T6st19L5I+7yM8SwDg7+UmBCguEGM8jngtCUZ/8g9iREJZY9h
 j7qLmE/d9hsKc476FVwa95F1DZXLD7/IhJll0MERH5hldHutziSDSQd/LfgFccvQYgiL
 LHPZ8xo/1gPUDTwalLiW1SLSsCwoWB44H4Hp8Nd0N6d1RgNEcb7v4Zdoy6/7ir/CFGAK
 YSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753609768; x=1754214568;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cuPNHl+ca9dPGpqrCDFZfcGJy9+49Vpeev91I/OgO7E=;
 b=SgWJD9zuOf55YPDpN97+K+IvUydBC2tlo+aquRYbE9r1I6J8ASiu/gRXbzCbqDA6Ac
 HX86RYTRXxrulAchorCnbF7M4qmb/dSMi+6EoQMVhAezKUVHUK3GJdkd0odzc4kjiYnN
 8MaTdv47TPtNAtJxXgZ1AtB0yJrbAmoe/SNQwOWs3nMnTEx0IsbzarZ6K+pIw6cXTXx6
 tkvyNbzLMQZw46aeraAWA+OQGzaE08D8JcMowts6mAz132ROISHA7A3x/qaUX8hEtpu9
 lsqlTGNuULT7KfB8TFfBukgrDl2tjwVN+/r7Y5F30ncRrExRksEUWeYhId+F4zgz+jyj
 GOpw==
X-Gm-Message-State: AOJu0YxjYQyDMZvsr2+YIhuoVJIhRSXZOSVdSxGvcUFRzmEi/WD9f6wK
 xZd+WEHiINMdN+oMBdmV9zaVRLnPXIoEPjVMab5Kzf4PYK3y3WnPTvqH4ub76+sHGwcc3cvUZGH
 3u9/mDl1gud/4Rthz0ExDzka4VCvychWq6g==
X-Gm-Gg: ASbGnctNIZnnZR14kfi2/gnWhjWfwxt/tT/g5tAEoX4kM9H5LVU/dQY0sNPE0Fi7Hpx
 fxJF/f84u1b+YN6RcVgaSvR041JBlHOKsXqRdMH8UO0svttQCfiIrqdly0EZwzQdm25TxPunkkS
 Cmb4c7rlp+ejz9eXJmOPYDEcao8paUe2xA2KeAU2EDdPn8sdwJ8Lg6rMcSjfYhcbCSO5WC//dHy
 UBD9I1tk7JZtZAiKU5ysb776HabsldLLrKPVtVO8W1QWv2Khhg=
X-Google-Smtp-Source: AGHT+IHeQVg3qOHoVHiVmwNFGb+DRJMN5D+86zDt8YRP6X64d7t6g1K4+zXybS5L72JAD6UVnOZo53hGmLGfIGrhBkU=
X-Received: by 2002:a05:6102:560f:b0:4e5:a394:16cb with SMTP id
 ada2fe7eead31-4fa3fd6fdbdmr3143173137.7.1753609767752; Sun, 27 Jul 2025
 02:49:27 -0700 (PDT)
MIME-Version: 1.0
From: "Baleswar Munda0.1" <baleswarmunda0.1@gmail.com>
Date: Sun, 27 Jul 2025 15:19:16 +0530
X-Gm-Features: Ac12FXwn6CHQVTXmwlTO9pvGCW5rhQjavgCByVMvRCkLQa4xBGI1zjYHB3FfQeA
Message-ID: <CAFqA1iLNiakzVq_TXeoAi7kq=61FypEfA6gOGQvnJe4oEUg1TQ@mail.gmail.com>
Subject: [U-Boot-Users] ATAG Parameters
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 27 Jul 2025 14:43:08 +0200
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

How to remove frp lock
