Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B525EC87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2DA83923;
	Thu, 24 Jul 2025 23:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ol7xPoVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71164838F0; Thu, 24 Jul 2025 23:30:40 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414598391A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ea080f900cso566662fac.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392637; x=1753997437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdp492rnlDghAf5U7uvpQv+oa1O/rdUaUhqY4WeGI4Y=;
 b=Ol7xPoVF8sS3y+qnOP27eMjr5H0kGVIeM7CNdJKRbmhlHPFOwi7JHPApaN4TDRKiZa
 9JzkAD7wC5xwc/tImrYGj80kIHY4epetnv3+1D7QbGBKBGhLxg8jul5CvuKVXRmvFuD8
 QOVRFTey1q04h9/oMSdXbzPNCQ/7Z+7qqoZk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392637; x=1753997437;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdp492rnlDghAf5U7uvpQv+oa1O/rdUaUhqY4WeGI4Y=;
 b=qBSs/5c34Sgq4Yaqr2oTAWJPUqwxwqs3D9kqMQEOcA0DJvGhNLD8R9nGm5JlhMHi3e
 82hx9T882pKoTSGYV7gnXSuAkp6CCTO8/2RoXfb/OWkJiG/QXI10EjINQkpH2d/6DU9d
 vZ7va1w0ohqD/ztPrNTDC04c1hw2FCiECgfFd4uuKoo9ASCjyO901dnzkzDCNR6YJrt4
 8eVnKl971XwySizDbH8QzrFPsjQMGZ0UD4TDy7w+eUGb4xcG7gHTdH79zatpQSJdCV8q
 YsE3vWvUMk1RcUMw7Ncc++q1AbZG7g8GTEaXjsEsSI5sRYPif4X3+AdCbEgavZQ0Cwl/
 /F0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IsFeAmgO7TWh7EhicSEpfwOL2culY5LFDQ1XbtStBnakMqT1g99K1hNc89anEYVcQ115pzI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu6CUcBOmYrsF9Xs6bocy05duZDBrjSWWaUoO6MWE1RmAJgYGb
 9s1fyhFUdDZUzWNIkUbpHOyYVnSG4hinWuIj+r3NodtvJhqYo21t8739MU7HMlpjQPo=
X-Gm-Gg: ASbGncv/R2g16NgZtgQ2ym9PQp4k2+S4IUvFE5PAwLILU7epP69YSQFGiUVd+QFd4Hb
 dg+XP11HnvFIFNx9IwZktdmPavDT11IEVh4MAF1f531hld91XdsWOHVbtZjbKgDOYZTqrn2KpOS
 SPy0bpWmE1MwdWa70eI9o++RFx0nfqh9yn3CCqWZcHwYgAIYmf4ITTZISBHw6GPNNQ2CfCzJpC1
 C7V2I9s8rzo062qBwus4gc1wVzpKzZnJZKrNh7jTtT03PVF83LUNp7gKDNb9LwNEiGaGrxwu1a2
 HYY1TI5t5kAus6HQ7WwMe1PosoUxs+j3z7nSUHSULDLGFoKzdXrDvtnWf1knExQ97qiCX+Xnq9h
 4cUeYiYA4AO2JGQkP5LvdQS0DmZbIa5TxJE8prm4LrodMtQJ0or9R4vI=
X-Google-Smtp-Source: AGHT+IGJjhF8TdX/ISJP3Po6xaiDywyWNan3VGMol9PeoM4+fnJkUqIO3KDF4Cl0CtA/SWsxyAfTGg==
X-Received: by 2002:a05:6870:648d:b0:2ff:9e3f:dc8f with SMTP id
 586e51a60fabf-306c72013c8mr5438007fac.18.1753392637002; 
 Thu, 24 Jul 2025 14:30:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: b-padhi@ti.com, m-chawdhry@ti.com, afd@ti.com, hnagalla@ti.com, 
 j-choudhary@ti.com, bb@ti.com, nm@ti.com, vigneshr@ti.com, j-keerthy@ti.com, 
 u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250716062156.2564297-1-n-francis@ti.com>
References: <20250716062156.2564297-1-n-francis@ti.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add support for K3 BIST
Message-Id: <175339263585.1899261.10790388987992429985.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 16 Jul 2025 11:51:54 +0530, Neha Malcom Francis wrote:

> This series implements a driver for the BIST (Built-In Self Test) module
> for K3 devices. The BIST driver must ideally support triggering of BIST
> tests, both PBIST (Memory BIST) and LBIST (Logic BIST) on a core. Both
> tests are destructive in nature. Please see links [1] and [2] for
> further information regarding the two.
> 
> At boot up, BIST is executed by hardware for the MCU domain
> automatically as part of HW POST. So BIST has been checked only for the
> MCU domain when U-Boot comes up in the usual U-Boot to Linux boot flow.
> To facilitate the use-case where some safe firmware is intended to be
> run on a safe core, it is best to have triggered the BIST tests on that
> core. As an example, we take triggering the BIST tests on the MAIN R52_x
> cores. The triggering patch is kept as DONOTMERGE.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] drivers: misc: k3_bist: Add K3 BIST driver
      commit: b56066e03ca942e5b647476d894f00e99ec63ed4
[2/2] arm: mach-k3: j784s4_init: Trigger LBIST and PBIST on MAIN R5 2_0
      commit: a7ddab97aae511977860f756a8e25ccf81d0699d
-- 
Tom


