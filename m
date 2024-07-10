Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B770C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 19:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C953C88665;
	Wed, 10 Jul 2024 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V97gZR/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B0B886EE; Wed, 10 Jul 2024 21:26:56 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A8788626
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 21:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.belisko@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ebed33cb65so1077731fa.2
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720639613; x=1721244413; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9vVw8T3+zFxHbIqFaN8wOJ4OKK09b7/Mi2C4NQk6PKI=;
 b=V97gZR/pZN4fI37fZn/ACJ6EAIF4tQO331LEe4BNVWXpZjGIsQlEjCoe/9L9AHazz7
 1c3Q3tG2tPw0uRnQpsQa0Qpr8gGJf7cvH4bTdNjVGJfJ89xj8PDUeerPzr5KubFgV2SD
 DFfULzfKCdDRVkV+JKIxbXHWARwSe2DONGPcFglueuwR+Lv6/ka0GmIFYcgqujuTt+9N
 WD20YDWRNgZFe1dU+pnL8cTKuEAKrhC6OviYKe0mbC9Xl8X3AeSPmG/oJX3FllQwRY1L
 BLPHvAhpvjIR4l+XKBmpAUG/vI1ogaLTmVoHya2B0294ba18E6YsExale8vjxxeeu5r9
 JPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720639613; x=1721244413;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vVw8T3+zFxHbIqFaN8wOJ4OKK09b7/Mi2C4NQk6PKI=;
 b=wdCZ2eM108DZFIl2uy6pzeaH/bx/S83B+T4NToTfxISrWAmDffGYo5FaAHeeAPVlsH
 rpVeHczL5C/5eyD8zjFyKU0lq3ZLtQooHT8T3AjryC2yuWVVCbcmMoX6sGzUW2f5utz5
 WFDhc0Ivepn0Y2c6i6EHMRLhex2r0PnuFr2BL22vT14bxdi5s+f9phWvtEfhzU+ha54E
 Ai9UQIP+cQS5d/PJ2cYe4ICqSv5035fqvEP/L6Fp6kVOwlcjqQAvHfgAePqHNaUUtJVh
 eIqVsHJwPazRhYrxWt++yal9CCPwTzfYRv8raEzhXEihgPsDcpc9VlBNUVZmXJd7f5XW
 MVmA==
X-Gm-Message-State: AOJu0YwDoC/EwkHVrmnhwj2EQUFbo/SIaX9looJqTTMIYSHZcftHjMxM
 o3ucT+LbslNMB02YjeiXjq7tmz2Pt7Zne/4aG/kPoxNPRVf6yOgwgyDRKY+rw/RS1THCop7uTHu
 qOstB4uaNlpmpGQfJ++cGJr0PPfU8NUtb
X-Google-Smtp-Source: AGHT+IHxmVTSNND+E5elRGl4UrAOkY4Ch7FTSKsFiso2fQmGeYlPRiwGQmnhDZLuNeGRxjmYJKKqJm+rEoOkGZxezD8=
X-Received: by 2002:a2e:808d:0:b0:2ed:58c4:9579 with SMTP id
 38308e7fff4ca-2eeb30b4d5dmr40049721fa.2.1720639612841; Wed, 10 Jul 2024
 12:26:52 -0700 (PDT)
MIME-Version: 1.0
From: Belisko Marek <marek.belisko@gmail.com>
Date: Wed, 10 Jul 2024 21:26:41 +0200
Message-ID: <CAAfyv37co294aQKffpt0ce=ajYutBrcnU23P=pi=s6YN5gT3Fg@mail.gmail.com>
Subject: radxa cm3 2024.01 mmc write error
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

I'm playing with radxa cme and mainline u-boot 2024.01 (present in
scarthgap yocto).
I realized that mmc write fails all the time like:
=> md.l $loadaddr
00c00800: ff7ff7eb fffdffff fffffff5 ffff9fff  ................
=> mmc write $loadaddr 1fc0 10

MMC write: dev # 0, block # 8128, count 16 ... mmc write failed
0 blocks written: ERROR

1fc0 = 8128 is according to rockchip gpt table u-boot env partition.

Is there something I'm doing wrong or its regression?

Thanks and regards,

marek
-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
