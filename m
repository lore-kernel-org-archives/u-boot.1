Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A008AD1037B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2379183642;
	Wed, 26 Nov 2025 12:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dn4dYDHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4F8841BE; Wed, 26 Nov 2025 12:17:18 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BFE8352B
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so4597241a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764155835; x=1764760635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TI7COMMFfTVnAOjM97FlnHo/OCmt9ax9sWngXnB6tIA=;
 b=dn4dYDHZh1Wz/uagE/nKt5PKJZTV+OeigeGHhLaNLKky+g0R9sLC723O3tY3uPURHh
 JNzhJT8dzb3Gai0VGlK8NhyzmMEWfY+/UQ10qGAJol6J+/VFZNjEreoj4n/bSoGPARWn
 kVZVnZCIJ6hLHkBmQmUAFk4x2/vLRHN4j3UcFT1kve7SgZ658WJpeqZNU7EL3JCcmMSH
 GS0lKM6BXnW4im6XffhkFCZ0lhu3XXtWXKSfK39eNmkSFueSDPhPjIhhTlC6At1i7rfv
 n4jMSoIg/pQOYv35zfN+s2meo6dzwJ8yxv95XVYXMRbqLZ5qmo1deQifPSo9fGaCVkCc
 PUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155835; x=1764760635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TI7COMMFfTVnAOjM97FlnHo/OCmt9ax9sWngXnB6tIA=;
 b=U90zLaLnGm9zSZ6qT+/MI863iPXz4x9VAIvNDTd1+sXyj2uwliBCTN1WoHj0/O0zbw
 TdN8YCSz0499j1+98d6mt8/euwFTNjNoFgMuje2Ps9hOJKFKhr8g44P7lWOWTmYDwyDz
 scTCZwa8k3UuM5oPrWvxRBVqwuK8uJDpYP8NptSC8hu4QaDPJA5U/OzJGaJtXNpUzI1T
 m2younytsbrOYCtWdtE90ZRZJcSJIEOQowM0kAkpXsNCyzWVpLIIeMLT/apmXYr9i5gT
 nEcmgdZtAe5Aqatj8X3TxG4cdy/uTNIap21eA6sRW9B8ga1sTlyc80i6GRDex+yPTliU
 PN3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBnzaSQxmuUbXH+x//oZtHO2mbZ4iH7e5R6pvTCtUpHShXOz+F1/fAU3nR2n0qWqSxXccYChM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywkb5+dJyNN6fWKwInrwc4qBuoAcluz1vpxFbUVY+H5cBFxx7xG
 oSsztjnpTclSXLT8PdfYCoZgIQcXBmcF+grWnfIsEElTQRloQUq86+uDt3KkYvBpxH0CdNSrnVe
 8hgW5UL2lfuR5nCmEYlBjrvz30gSTjTjOd4bqkTmtVQ==
X-Gm-Gg: ASbGncvM+6TQ53MBJX9MEB6pRTJlT1+gVrZ5fy/aDzM+nFSnkVsnhh+pUGQ82RyFArR
 fHrXFYLTbA2z9jlAQCUprQ6I3P+aVazW6MopH5KrYoTwlMKVf+5aaV3ZvMit0wOTxyPF2QWwrje
 kWKY9LQ0Dew9By1FwfH8t0pPtQaNcOC9gVTI7h0UBxocd46a/Bb+LjINdbIOwVMWnZddQVvLuK5
 NEHJstr1gvHQuiyJvPsYIyl1kr7ATKfhtEi5K4qcqKL45GCKC9IE76DBY+pLXctXLL5TQ==
X-Google-Smtp-Source: AGHT+IFwu5E517JqGf+/Iiif5uDPjKHW3SdfQ6MDzqP1X943yJj7uSr64jaIKeL5j7D2LBFqggTrjmTH+7ZBTjBDQX4=
X-Received: by 2002:a05:6830:4424:b0:78a:8b0d:cd54 with SMTP id
 46e09a7af769-7c7c445d9dcmr3267139a34.34.1764155834742; Wed, 26 Nov 2025
 03:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20251125123847.307-1-briansune@gmail.com>
 <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
 <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
 <54428bab-5189-48d1-9b96-977487648327@cherry.de>
In-Reply-To: <54428bab-5189-48d1-9b96-977487648327@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 26 Nov 2025 19:17:02 +0800
X-Gm-Features: AWmQ_bkpKlYUaSPVc0EulCKSjJ3M-RZ7xFgbmzjtsUBAsX-mWycnepjVBp1Mn3U
Message-ID: <CAN7C2SAnGjfOba6eet11V8HLH1bn6owK8ROBuvTUz753+aTbEQ@mail.gmail.com>
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> So, this does NOT enable WDT or WATCHDOG. It does force SPL_WATCHDOG on

Comment on this.
No this is not the case.

The specific turned on are:

[] Enable U-Boot watchdog reset
[] Designware watchdog timer support
[] Enable driver model for watchdog timer drivers

Save and uncheck those back in order.

Never touch this setting from the beginning.
[] Enable driver model for watchdog timer drivers in SPL

BTW appreciate your interest on this issue and welling to debug.
For my case if any issue is fixed by a solution(s) I usually just leave
it as such.

Don't really worth it to spend time on s.t. had a tmperal solution.
Unless it is really broken to the point that it is unbootable.

Brian
