Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B562CCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00537848E6;
	Mon, 25 May 2026 19:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEtWE3kZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2C3848E3; Mon, 25 May 2026 19:01:23 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26ED847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4824176bbbeso3251433b6e.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728480; x=1780333280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaKFhBMQyrRJkgR7Zt2FcsZ2CPaQHN/P5Sb0g0Goevc=;
 b=UEtWE3kZpOcjf+aVV3zg0EhcPubhs5J6PJXN9r8uyYCJNz6w/BXKJR2JBra13BoeoI
 shRmGS+gVP8cdFbeA0BYdfT+La0/l5cYhwv5qrgjl78h2RbiZAaxLrd/J5T/XcSQulir
 SHrFjltyri+EMUPdZpV92IjMmoNAVZ/noaWK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728480; x=1780333280;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KaKFhBMQyrRJkgR7Zt2FcsZ2CPaQHN/P5Sb0g0Goevc=;
 b=IuOFkvvw2xsLCWd/t+0fw4hmPXRuDE2L5nTpqeB8qrOVSkAZBjIfLa5BYTfqPuXuKH
 ExlDV3LcH1O3fhf3W80/KMRmFkw3mvlRt14OPeTpL5cTzBaf034REdPpYf0Lqz6pfydh
 rAtBIXxFE9b0NWixNvKmW5xZLRUBauEV5itAhRKGoM6sWX7UufpwuroZdZd++dWw7AZB
 S3hf7Xa/lnOHocjzjLFkf+/YeJIx53PHLB63wqp+j7LqTTjxWLgkVtRaMKt09GthNial
 GIz+WAX8lTB8v2ak3LjmZ7tCINtXKIozRPKxkTu53rZ3Dw4pwDOemuLz6uzSdAyQmG2R
 EuGA==
X-Gm-Message-State: AOJu0YwI9JKSHDG7+G4mNmHvasoruRLb7JniECv7IXuFQjzaNZexrVwl
 PNi4iB7VELc46QTD4X8uoPV03o604kHM2OBsZ282/k8tH2bvjetunYQpE870ONffx0r7BWj9Hog
 1sTC7BtM=
X-Gm-Gg: Acq92OG47m1krCxnXaDGZgL0/ngl9/b8Bqrff/gRm2KMC2L7TlgB8hsNB2hvlXu0UAt
 npYhXg5wqdf/CHrGARf6SQ5wPXxawOQB9T0+bINhIW8FStf+L83txTZc7FrwrqsVo/fV68B9G6I
 Y0JUTEu+B23e0LyaDM0oAAyQ9iGSaRl38Iwyda+CiluzJwdZxuVJE+ImsTbsf3ejxpUBm9nT4eb
 NC7Qm/9/l1859sKKjD8OoPYC/PQxqsARo6iE7pbHm7y5+iWF+OK/0zUA1ES1CGpq/8JBY1XAXwz
 D8Guv7Gq09vBLszckod5oWEuEB/yo6xXWZ+NM/y+o2tc8/3VRiklsmDU9ulefjbcJWyXxLcHIrc
 SZgJMz7aLJtLU9/KquCDB0srfHyrwqJtpkzDcpl3Aih1AhRQmAsTb4t4Zv1/aa4n/DZoJKvTVgA
 p7gP5/j+H9gIdvZacdoreGODAFbTIhRkk9+TZkfGP17jjqXAeLOvzTuDLWd1qEO6Z8RtKjefqOs
 bwTFPdkYRa9mtSVVMjiZlAO61rp6uYgoGG3JxBkttqe
X-Received: by 2002:a05:6808:1508:b0:479:fe0e:e83e with SMTP id
 5614622812f47-48549ee400amr9804728b6e.14.1779728480223; 
 Mon, 25 May 2026 10:01:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm4993136b6e.10.2026.05.25.10.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:01:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Moteen Shah <m-shah@ti.com>
Cc: m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
 gehariprasath@ti.com
In-Reply-To: <20260520110032.2659321-1-m-shah@ti.com>
References: <20260520110032.2659321-1-m-shah@ti.com>
Subject: Re: [PATCH v3] am57xx: restore bootm_size for ARMv7 HighMem constraint
Message-Id: <177972847889.683406.3848466563446639077.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 11:01:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 20 May 2026 16:30:32 +0530, Moteen Shah wrote:

> babae80169d removed bootm_size from ti_common.env to allow K3 boards
> to process images larger than 256MB, but preserved it in
> ti_armv7_keystone2.env for ARMv7 Keystone2 boards. AM57xx (also ARMv7)
> was not covered by that preservation.
> 
> Without bootm_size, env_get_bootm_size() falls back to gd->ram_size,
> causing initrd_high to be computed as the top of all RAM. On ARM32
> boards with more RAM than the DMA zone (e.g. AM572x IDK with 2GiB),
> this places the ramdisk above 0xafe00000 (HighMem), which is not
> directly accessible by the kernel after MMU setup, causing a silent
> crash.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] am57xx: restore bootm_size for ARMv7 HighMem constraint
      commit: 7e11adf05488c64195c8031299ff65c1a4fd660a
-- 
Tom


