Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A9CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F0A8483C;
	Fri, 15 May 2026 20:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="syzWtbbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDAE38483A; Fri, 15 May 2026 20:14:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BF7846EB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-439acb393f7so144735fac.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778868861; x=1779473661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyOZXDEuGnFgW9ho/WY8BWKuNqYpsK8eGfn0HQbUYfM=;
 b=syzWtbbDNry5X7wOPy9qCZ8Q8VCURggUUKwO9qtv6vWdEtS/pKndYw49buTrhkKaKp
 ukPfRrL4kEHzysE5dEg7k12d+8TR3NlBHB95LlsNkXIiTuEQnw80tZ/U3fJ+NPxFZRKe
 ANgtDu58WI2/+knYlJ++XQvNcOwYfOQjxSm4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868861; x=1779473661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyOZXDEuGnFgW9ho/WY8BWKuNqYpsK8eGfn0HQbUYfM=;
 b=l58Eu3Lfz9fG2Kgz6+cPQ4+iC5W2GZlm8MfwzEohJAgde2PvDC/HPLl+nf5oC2wjWP
 AzFooTB6HHQS5KgUkPq7Tb3ZojPsBOSizCPrlBXUYosl800S4CA09oDodpXcjiXekDBh
 KHOxh6Z7IKKkNvm496Stjhst0lqgGgBGyKfi9BP853VNbDnXoXrkWEFs2yiHgM9wkAqU
 SAp4OwXYLfTHx4OUEuPjSzxhIREjWOe8ABWCWJ27X4gK1PLZkj7YsHFuEtfl6mhiEuMO
 M7qLTctWbPZPKKhQz55ofsKh8rHm1mMACjAkUeiPFwhw7+ya8jBKtD6Yx4J64e7f8/Fi
 D5Zg==
X-Gm-Message-State: AOJu0YwFvYNgBbH/fd2cbWIklQNeFFKbX/KYGiIZP7pxS/vBRa6KJ64E
 Bei1yMRYeMHRlVF+epPnjJ4bx5wnTn+HahSOpeN1dMLeOIKevOwWByt/eupuywpgxh4=
X-Gm-Gg: Acq92OFn7/c0VtmgE1lz7DhJWbYuN1PayQfBH2YO9fHmiS5bLc8YrUOBDsIin8jH3J1
 BSHxwHHhUcNmTHuG3nXJ7wGy/zhXZwH1cZgtc3EpuBS1tFL5fPZgPHmQamBJ39gMjAKczi0YLF1
 1q++/afG4raErr0r5QZ2d+5f53fTFCvLiHD9vuXZFFm3Un7u9+dwhzsz2VxJLFICthsjYA5J5YH
 GJkPW/GkKIsDVRSfhFC5I2kOaKKY+8AnZubRrAmBVCJFGgkQyd0YVhT2C1KyGihfnWi9kWQqV9Q
 VHQtN+nTb+UJFKw1+Wi6KmsJpss+vDSuGkpDFOnBX5kFbZ0P81RLEWUlZN4Z1NQz70UJ/SC9bYB
 HZfj4VCwzVJthQXqVhVeiqxPXGDl9Y+hTttg63IPit1ZQm77p1Ghxa1eUQU2iIK/jUrajwU/EFB
 X1cXsVHsLEIdsapOY7nZzaa9XOGB28Ws7YFvTuo9ntoNt3/vd70kmBNvXRksqN+vshaUosarK2y
 C89Xahrd8/mjKcPUZzWVmsWSt0NPYrlqQ+zK5WLVe0qGGTJkyoxkkHEmpOP5gjb5NQUG0o=
X-Received: by 2002:a05:6870:31b6:b0:42c:24e7:f074 with SMTP id
 586e51a60fabf-43a2defc241mr3668072fac.17.1778868861268; 
 Fri, 15 May 2026 11:14:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc1fc14csm4678982fac.6.2026.05.15.11.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:14:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>
In-Reply-To: <20260509203136.46745-1-kettenis@openbsd.org>
References: <20260509203136.46745-1-kettenis@openbsd.org>
Subject: Re: [PATCH] smbios: Do not fall back on devicetree without valid
 mapping
Message-Id: <177886886042.657307.13496734434434902855.b4-ty@konsulko.com>
Date: Fri, 15 May 2026 12:14:20 -0600
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

On Sat, 09 May 2026 22:31:36 +0200, Mark Kettenis wrote:

> The smbios_get_val_si() function may get called for a sysinfo
> property for which there is no mapping to a devicetree property.
> Avoid a NULL pointer dereference in this case by skipping the
> read of the mapped property from the device tree.
> 
> 

Applied to u-boot/master, thanks!

[1/1] smbios: Do not fall back on devicetree without valid mapping
      commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
-- 
Tom


