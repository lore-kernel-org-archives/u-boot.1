Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E787D2444F
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 21:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693BC88A3C;
	Thu, 10 Oct 2024 23:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SS2L5bxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4958927D; Thu, 10 Oct 2024 23:34:17 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7609689278
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 23:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe9914487so6214956d6.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728596054; x=1729200854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGPubamaesOe0EcVQajpIeyZ83FK6HS9KIHVPD7RvO8=;
 b=SS2L5bxrMVbx0noWfs7y2eRGNDknWECtfEXT8q2LonmMx8iOTZ2yTbmZnp+t3uun/W
 Nq2n5lXNBNiVvLVy0cYS4JGvupaapPUE7guLelqinQlLQubf5j50MPgzwevng6rJIwet
 7GkxMZtOE0koQe8M0nm1ucDvnEEqVXGlZwhcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728596054; x=1729200854;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGPubamaesOe0EcVQajpIeyZ83FK6HS9KIHVPD7RvO8=;
 b=Z8Kgk/Wha8ZpRbMq/gRgwbw49cARt0jMi+HDoCOuaDQ1FVzF9pjCeYcE3nSZGeLmnu
 0gMseJ3zQfV8mCC0ZJhI4VdRQqmkTd3r3T99Q2hNaxR7aEKFvVecYs8Orep9G9XzGouS
 dXbBIFmRVBZUnGWWawY/E5NnhZVUndkNYKXwx6VYl0Zv0azoEsfhOkYqVXZyPyRvpJyt
 2hXmMWSKK83rApbh3S+ZD1Pb4y9Sux9nyFYlpXHI9MtQM3Ez4vdseLZ7cq8i6uA1AB5e
 7aU5j0Qsde9gekV8AVRrMU9B/xqhvEafghxnomv/LkO4GjTJEApS6jUSxv4PSZ05SKyq
 ntCw==
X-Gm-Message-State: AOJu0YxBNpy4EBCxCXgQlWXCSQ4DDz3zWhFdZnBuvNK/1kAwp1l8XBmr
 vjq1CuM9R3HTwFtEZjcCF1aeoCsGi118OHcwTTDUZ7d65HVkv3clxYZZEEIf4ACRskq46VuiH/d
 BItf/zRtf
X-Google-Smtp-Source: AGHT+IHcMfxi+oBjbXp6xiCKPsXka0GgHxhawWPxw2CmR9k14+b7GjhlECl5SizGhbFCIObT5sJxpg==
X-Received: by 2002:a05:6214:449d:b0:6cb:e6b2:4a84 with SMTP id
 6a1803df08f44-6cbeffa2e2bmr5689436d6.14.1728596054341; 
 Thu, 10 Oct 2024 14:34:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85aa56dsm9096566d6.26.2024.10.10.14.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:34:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sidharth Prabukumar <sidharth.prabukumar@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230924223022.313107-1-sidharth.prabukumar@gmail.com>
References: <20230924223022.313107-1-sidharth.prabukumar@gmail.com>
Subject: Re: [PATCH] power: mp5416: Fix LDO SVAL for MP5416 PMIC
Message-Id: <172859605292.435814.12556248001988584974.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 15:34:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 24 Sep 2023 18:30:22 -0400, Sidharth Prabukumar wrote:

> The MP5416 PMIC's LDO set-value formula is incorrect. This patch fixes
> it by using the correct formula.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


