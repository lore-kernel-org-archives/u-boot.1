Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAC8D3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0FF83A8E;
	Sat,  6 Dec 2025 15:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EK669AZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAC0839DF; Sat,  6 Dec 2025 15:11:03 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A13583A41
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so2641708a34.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030258; x=1765635058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x4+M72aLDpwBnoKfwJCmFEFRWPch7f1FBEBgtlA2Vo=;
 b=EK669AZdUGnwdsUtOqatTwLOv60ums1hjjJ9yTJ32dljah66MxTeJzXjTJRiDQll2e
 EIUA9Ngpz3UF07FCmrXZg3q85UtNr4bh5B481x9nJcHZ5a35t4smEeID41J3w5Vue4OL
 l/3tG5JiUZLIFpAOJmkTQPT8x+qwF8LYo9A5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030258; x=1765635058;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7x4+M72aLDpwBnoKfwJCmFEFRWPch7f1FBEBgtlA2Vo=;
 b=JXwCjrtS/+P/vmeNwTi94ESVXD+rifljyubqWPvjWlOalrT4RQeTMmK3PZmeilIF4T
 lXq6W0trFwa8F4X6utiNGGZy0GdWUYpGJDhy7QRQP1GH7YeGG1bi6EZvoJIOBZNPzroW
 +bypfJeWeaBJImUPrhyFkkHrSaHoyALiaA97dnzwKrWn/aP4oe1qrwq3Bl7FeHOZE0ds
 r02qS09NmgiUwVoFPUUAPmml1iDcNPsEKUeIB9b9kIAjJBzn0oPNtiT3Nft8HuaNaGkP
 hNZhEDs7+POqnbHny+l5XVEKWdaB5qGSQnPgo8hF8qmQQ88ub7LydyAwaDVJogAwlTfd
 /pSw==
X-Gm-Message-State: AOJu0YwUBYvMDuf13lwqwdWFj+pOYcNNR4DD4d+o3PZAbyvChx7e3RLV
 pTpApHMzY6Q6q7AYqIdgpztA/0CoOiX69td/oaETyo2ksEVy618J/sgWGKu89z1XnwI=
X-Gm-Gg: ASbGncvcDU129V90BgcSOQghIhOG3GuKOybhQaUs+gZvYAWAiGt1pIYaU1pw5pTg7L9
 V2BuxqWuxjQlFlw3r7V1vQCtLxrApGfP2B34/J9PTpt7jdlsZAsh66hXGvj/si93xk8Z4aMISEt
 3l+a3sfC0+pltwuan1/Ji3QZZue1R2zQFh39dKiNbcJWtvYsOiIf28dFjg64WJF3YpZWhVaf2/2
 sHiw+gCoML56LtEbbKwVg88dQdn9DRZ189YXoPrepHYH4QKEVRO8bPByGOe3f+p7hoaRwWVSwNy
 7HCkdVDf5MsGO55kPDbW0bupBBXzjGqnbYXg+qNPfYcE2tCl5mWBMPJcngRPV67lpsmLZVTQl9p
 2hLWVRRO+ZM9A9ytjbF3XFtykofi4HPOepO0MqVAtGFWrKjENnt7OObMBghIVOB7o09RPSU/iUe
 fVhhKYYR0vIhFr4K03ajSGmmOF0/On87jQcWXUVLz/IoF7A9/R
X-Google-Smtp-Source: AGHT+IFFPmUc8D0GEQewmpW5UY/HvXZD8so+PKyhFpvWli3s3wtN0EMXAxbbqnlZ9WTy2BihW96cdA==
X-Received: by 2002:a05:6830:25d1:b0:7bf:6dca:2055 with SMTP id
 46e09a7af769-7c97074e97emr1428014a34.4.1765030258083; 
 Sat, 06 Dec 2025 06:10:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Judith Mendez <jm@ti.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251120-gpio_fix-v1-1-50ca8963c7cd@ti.com>
References: <20251120-gpio_fix-v1-1-50ca8963c7cd@ti.com>
Subject: Re: [PATCH next] configs: am64x, am65x: add CONFIG_DA8XX_GPIO
Message-Id: <176503025703.2523567.6390067132783596688.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:57 -0600
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

On Thu, 20 Nov 2025 15:01:27 +0530, Anshul Dalal wrote:

> The DA8xx GPIO driver was not being built as part of the A53 U-Boot
> image on AM64x and AM65x. This meant only i2c GPIO expanders were
> accessible to the users from the U-Boot prompt.
> 
> This patch fixes it by setting CONFIG_DA8XX_GPIO.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: am64x, am65x: add CONFIG_DA8XX_GPIO
      commit: d3ddbc1cf8ed7ed3fb63620c93001e55a1f480cb
-- 
Tom


