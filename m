Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B09CC83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8D68317B;
	Wed, 16 Jul 2025 09:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjeqR8pK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27AA8315B; Wed, 16 Jul 2025 08:14:44 +0200 (CEST)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A998313B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 08:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ion.galaxy2812@gmail.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-615a4b50215so41533eaf.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752646481; x=1753251281; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QP/mpQDqJSV0/QO7wO7I+ynvQ0p+EqybGtealVLUq88=;
 b=ZjeqR8pKPC9gyQvJ/7pnbrJUmDcd1hedNXTFlsVZePaMWqHbaM5WDfl6V7A9llDDGc
 X3AKS1Y2h4HIE4ZdY4rSANp//2S9pNG8L65lrx7EtpieWV/WmswMD0niAO1MqQ7nyrmj
 12RxEXuQ4V167JZbNDajzUc7B0mMBbpj6G6Jafe8AQGTih9UdkNg1nGkbfpAQT14Lswv
 2cHTuNbXvgIm7Popgg4Qabj3xs3aQeeGblsf+eGtopmAL74mVVO86A64WUzCukTfYxtk
 hVLJRDoyF46fkN1VHLR75X+DdfUQFPALPQ8Y9fhK5pgoG+GmeUBd5YQxFAb9wF+fCxxM
 ypnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752646481; x=1753251281;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QP/mpQDqJSV0/QO7wO7I+ynvQ0p+EqybGtealVLUq88=;
 b=M7X6c3YEskyG3PWuSefuFOrAtVdHPUExxRn3k2L95Sk1zfhfTu7FXkE6g5Z7UXDfXR
 /xn0AmhRxDvzBux/Dzuq2HKakSpcY57O9y9fH157RTcFiOLltwSb+8dpzJUE/BEZ6Dih
 CC8kyJDnFApPgqHq1VK/BkDV9UCOGK+Kev0Czzeotu2S3ZXMy3fkCjMnpmDQZtfl4tOy
 2vl41mrr8YgCcm3Cd8wuAPDS0U6jMIVWaWlyd72EHa9s+82A77FGR52UN5mH53s12Yux
 O+jfULKL1HfMKPiJURE2dJWvA+zWhAsAw+PrWtZlM/oOzmxge7duNbA3wkS4bZ9vI57+
 zfNQ==
X-Gm-Message-State: AOJu0YwfGxohzzX9FS/+rsJYme3RLk18hy7sW0nmfqvAIJrIvbnXpRg9
 YDTc2yWDmIAqaFAvlSvg2OQpCypILeTvr9P4UTZATfDYmJl3yq0VSlcJPCzlkltqOC1k+58vjZE
 S8NKQjshuqtx7aB5K6ApWmnt0a0ipMH9uVr0b4ItPXIKejvRsj4bmsg==
X-Gm-Gg: ASbGncs8zB25ZG+7aypeAa8IqOlBAo9bb2mPiZ973gjTCH4zlaab96H2JbChtfg0CKV
 qVQqxoTyjBN6f/k1djIMUVwrodh8EwxpDY2SKJD6KVScVXO1iAuo3mUTS5psgKTQ1Z+4aCMwnGn
 SxmYa4eh33y7Wm0U7aT0IDuwp8nCt3Qj6vBDR+aiQEO8+96DpQVSlRxjaa65KjVUQzOaw0hes9G
 b9dc2A=
X-Google-Smtp-Source: AGHT+IF7uSmlC3fQXL40MX9QDlFTCKALcATpM5vN/NZByx1Rr5o2NUURtHY/FoX6j2rcYThUXQjIVB2yPiSxpItIGXc=
X-Received: by 2002:a05:6820:4b0a:b0:615:a6d2:348a with SMTP id
 006d021491bc7-615a6d236famr125399eaf.6.1752646480703; Tue, 15 Jul 2025
 23:14:40 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JjQvtC9INCY0L7QvdC+0LI=?= <ion.galaxy2812@gmail.com>
Date: Wed, 16 Jul 2025 09:14:29 +0300
X-Gm-Features: Ac12FXwvPl2-0aEkxm928osI3sy0cQWJDzIA0f9a3KVLkUZVInPIXfQcPHzgA5w
Message-ID: <CAPvr=H_N0L_VWT5Z7Ch2DBZK3aUGk+fTfrixMATkwKOaLtcPsg@mail.gmail.com>
Subject: Problems with building SPL in buildroot 2015.01
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

I need your help or advice on how to assemble the SPL(MLO) for my b2232
board from St. When building without SPL, uboot.bin is being assembled, and
I can run it via JTAG like this, but I'm trying to run the system via
Micro-SD, and I can't. after reading the documentation for uboot, linux
came to the conclusion that SPL was needed, enabled it in the config, and
then problems appeared:

   1.

   scripts/Makefile.spl:114: *** could not find linker script.
=D0=9E=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2. make: *** [Makefile:1216: spl/u=
-boot-spl] error 2

   I will be able to solve it by explicitly specifying arch=3Darm, since it
   was empty
   2.

   LD     spl/arch/arm/cpu//built-in.o
   uboots/uboot-2015.01/toolchain/bin/arm-starkl-linux-gnueabihf-ld.bfd:
cannot find arch/arm/cpu/start.o
   make[1]: *** [scripts/Makefile.spl:211: spl/u-boot-spl] error 1
   make: *** [Makefile:1216: spl/u-boot-spl] error 2

   The next error, which is not entirely clear to me, is that it cannot
   find the file and creates the file in the wrong directory.

When assembling another to another SPL board, everything is assembled
normally and without errors.
