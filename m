Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D164CCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 21:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83CA6831D6;
	Mon, 20 Oct 2025 23:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJf1Vaeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00583836B4; Mon, 20 Oct 2025 23:38:43 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8395807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 23:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3c8fb195c23so2895826fac.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760996320; x=1761601120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72cNmFx3ETd/vfCGDzqFyB0YXd9fU13DGoI63c+tvas=;
 b=bJf1Vaehca7BO2eN5GVRimspeC/WLoEiLZvbgCjgld7jzSxeap4bhHPS6OxuuKFg82
 5bYeDRZGGwEud1avsevhK0+mxkExh8dpN1pkNz9AcK6GWJtDEkJv/PVNgEYCZ34u9kF1
 zXsXHuD67owXXH+KjGh+b20VWxYIyJSOdRWC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760996320; x=1761601120;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72cNmFx3ETd/vfCGDzqFyB0YXd9fU13DGoI63c+tvas=;
 b=su+Yq3yJ8s6RV0YUR3WoFAGPe8Q7PrIUmcHavMsanah5oO9bFeh1SMEABX57P4bYLq
 O7lZx8aLLzgpGnXyO2ko+3DOWOvmX3q4dklMLgBeSKoLy491SJjs3QZ6xfRyBL1+xTOZ
 j8F04Giqytm5zLzcmspASDpLqqIhTI6ljr+woBnGOdzKz0LmCpQDcN8PnPKIJluKAmup
 TK7DqDZB9H1W+acgoC0Uj39w2IoLE9e3donwkNTsQ5uckr/4lZC6sbqtXs1Zz83CJIQI
 vf4Pi0VV9aD0Bx6U5k/xG/am0e0oTah3caxO86QBmcyCO8/Jy/OICAOHvboGIOB3i7T9
 2qvw==
X-Gm-Message-State: AOJu0YxPWnqG9g/ftWczTAf1SwTv9qpmoQ0x0I9o+OcB+wALqTIB/dBd
 TdFg6xxsZ5/4n9Q9qwBtucjn3S74Sukss9uS/dKg2jIX7tNpIbvX+AqTvlBudB0X58TgvxzuYU0
 6iWk+CFibag==
X-Gm-Gg: ASbGncve/Mc1W5bS+00wA7lChsrPW0VULAwhR6+lMNyZEMDSjJjBZ984P1VxCZgXXrD
 kL97xy4izCiSSrab73NNRaDoF6AtUBgt1f/tgWPVSVPjW5YlgsGrEI+iPUvw0ECi/An7ER+08dx
 O0+NHI10ySYdW0M65iXHhUc3wTABg+Fic6zYw4pBXhyNvrH1g6rxhOwsgQSGFsau/9W9SK6S0N/
 w9tGwNBTSv4nGt+32TaFD7zSXEhkVzBK5xNKlB+SIQx6BsOTf7PjSRXdbpQhL+ykb3Pe+jVdEJC
 /TgrTa5scGHXKrWDEYP6O4Xvac62EhlqC1rNDPFnRDwP1BvCJZp1skXEYppVcB+Io0WfLJogjBn
 2KScyP7sqQn9MB6I4qCbA0KxPFj3nyPHMbVUTOv4LkMjj9Q1C2sjs893Mkw4vK7NKA30YVDybwz
 jS8VWapG4C2bj9dJMKWqBJyKITc/dBucOCVPIK6Q==
X-Google-Smtp-Source: AGHT+IGjUb+7W2E25EEpaVHa5qBZtWGrbpwaL4n9atHL9nQ79cTlLMSr1XxQ1umwrCYjfDylz56jSg==
X-Received: by 2002:a05:6870:3b19:b0:32a:ded6:2b68 with SMTP id
 586e51a60fabf-3c98d11ed1fmr6043014fac.33.1760996320599; 
 Mon, 20 Oct 2025 14:38:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28892cdb5sm2992268a34.27.2025.10.20.14.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:38:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251020195903.3903589-1-trini@konsulko.com>
References: <20251009115846.897186-1-anshuld@ti.com>
 <20251020195903.3903589-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: Restore args file being default in falcon mode
Message-Id: <176099631938.3958778.3662397851207331918.b4-ty@konsulko.com>
Date: Mon, 20 Oct 2025 15:38:39 -0600
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

On Mon, 20 Oct 2025 13:59:03 -0600, Tom Rini wrote:

> When falcon mode is enabled and SPL_OS_BOOT_SECURE is not enabled,
> restore the previous default behavior of having an args file be
> expected. Platforms which are using a FIT image here and do not need
> this can update at their convenience to disable this option now.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: Restore args file being default in falcon mode
      commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
-- 
Tom


