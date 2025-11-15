Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8282ECEB2CA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 09:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF8083F4F;
	Sat, 15 Nov 2025 10:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mr/a0A3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD88840B0; Sat, 15 Nov 2025 10:05:52 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1998B83F4C
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 10:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d18422565eso1944292fac.1
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 01:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763197549; x=1763802349; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fHWR6ajM+ybEvprshCJki1037FgsTnA1V6F4AGJaQwE=;
 b=mr/a0A3bSpGF8a1ybqdHIMXNw4n5fZtJGJttnQvqcOEXX3BMj/Gb1cWxb9rS2zqZDR
 yGafklLS8pAgwNC7R6aKkzwJsd2c+9E7unZLFYGIEZUbDx9ca+lcSatbsUOEujxsduVd
 0DVW4IiI1vcd0ACSPp5Y5XFcaX10KKYjJIgaDaRbeAHreZ15x7WXMo3Idow/Orca1rcI
 +phOuQSavdBVVFbqo0u959qQ6oU3rA/QB5cyMlx0g66CRvRBIGsTJf51n4BEr2LqROW6
 kjnsUaYgowOynSxxdgcW46uT/ZUVqYLaDEx1UdAac6snE6kFjL3XkVtwspBtenu7Pbon
 L26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763197549; x=1763802349;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHWR6ajM+ybEvprshCJki1037FgsTnA1V6F4AGJaQwE=;
 b=to+mdNC0gA0FQ7nUrY7QEYn1lRWSYehZQRVDUo+xz7a4jk76O4KQ2+1XS9zIU1epFO
 e7b9Jw5Ve4ElFl9GISX1Jw6ZkKVA7nQzcCQAloqa5LEm8sGaKsueVPEhMYHRBbjFZU+A
 qilRP+c1e9hartcb7y0MmG7JZUphUC0f7qxBCaSbR3Dy/Ic+lJeC2JGj9J+rUVHpxlhz
 9O8vPABFLK6Q61ciGp/4lROy/pNZSt8s/fnlWwKKHt0qvjbVeiUJD47Fd9WJ/vExQoK1
 lrZHj4SU9MxfsnOLlXS9bicmh3KTT18IOH/nNwJOvPrs/AHnkRb/bGMP5TA9tfybKKId
 I1xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBSvK4RuUCmModnOStaRHcZfRM2aTBTYuDETGzwNrPhyzXxMr8+o5l6QPwtlQ63UF619TXqMg=@lists.denx.de
X-Gm-Message-State: AOJu0YzyFlNY+3WFlnyc3z60uzGjg1cjz+zWJRub8UKQSKcVxdCPyKF+
 5c2TNRI8+WOfmHmHo4SWmlLRTzcKBaMYLVnY3OyPizmyFhmMlHwQWGi+03OD9LUSXBMT7yFTTSY
 Jjo166Hxrv9di8ptBdGY90rpOn9j7tIU=
X-Gm-Gg: ASbGncuK4eKlj3JllahVm0pexEGNHlrg6fwOoG1BjCCyW2iQhSEIabomutHc0MzrJmQ
 FsjYvyl2KjrahZHIbgfjkN9Ia8qx43Glu05TEYNBSq2SOmcW3POWb1XuMEX9NmAqEgOpwSSxqvt
 GYZM9iwB6UfCqVvy/sgJ7fbHmrpBZAncCf5GidIRTWeFFDwGNtvXYHBiyz0RoNb2fGRhfMBAMXA
 mrc9ZGyK/odFw4wOH53UABQW5mPIs9DfulqtbQSOLbg1TwnT3OgTsuFAMi86Q==
X-Google-Smtp-Source: AGHT+IEC9lnUTKQ6nl4UYpsCFOOZOn+dy7J/XO251PATQ4kt4MPGnRPmUc2gCG91X3ZZeHQv1F3tyvpUuC3ACvuwAhs=
X-Received: by 2002:a05:6871:6a7:b0:2d5:ba2d:80df with SMTP id
 586e51a60fabf-3e868f04817mr2685090fac.8.1763197548664; Sat, 15 Nov 2025
 01:05:48 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Sat, 15 Nov 2025 17:05:37 +0800
X-Gm-Features: AWmQ_bmX1bl0ZwGaQtn52oXBk-vaXf8aPjI01vosJaPkN3kJz4wQHsaGW7T7u1o
Message-ID: <CAN7C2SBxZ2-A9=akV3z4dNdzqUtq_Sq8pq7WvzVDtVub50cabg@mail.gmail.com>
Subject: [DEBUG] U-Boot SDRAM Calibration breaks and unstable
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Dear all,

It is found that the latest commits had introduce
some kind of calibration fail.

1) Seems like ECC had been removed or not even
introduce to mainstream U-Boot

2) Code diff shows no major driver/ddr change before
the calibration aka sdram_probe.

Based on the above simple checks, There must be
s.t. to do with

a) reset
b) clock manager

Please maintainers have a look and resolve this trouble.
Issue had been reported in altera forum as well [1], [2].

Meanwhile, rolling back to altera uboot trunk 2025.07
shows no issue.

Both 2026.01-xxx and 2025.10 also can trigger the issue.
Master reset can trigger a good boot very unlikely.

[1] https://community.altera.com/discussions/soc-system/hps-sdram-calibration-failed/337594
[2] https://community.altera.com/discussions/soc-system/sdram-calibration-failed-/337648

Brian
