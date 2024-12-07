Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B22E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 15:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5939D891B1;
	Sat,  7 Dec 2024 16:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EDp5eYmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D4A8919C; Sat,  7 Dec 2024 16:57:11 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0D188EBA
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 16:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-466879f84ccso23695091cf.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733587028; x=1734191828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdQrDUsGyZ1stRNvpbiRFxwmrLkXw2hhpI8HZSLUwnw=;
 b=EDp5eYmMzizZyp1LpsHQeU5VYI5dlbdSGEVQoW53Kh2hyCy1pclv5/bBlPi+vOVEZr
 Za0mhrhNL2/QHeF8fMd1LZJWtXE5M0H0AOMWV1DdG5N8mow1kF0XESJOYzspxU6KAX9/
 B0fTy2DefVh9WdlA2kUDFRBQOwBhzsMJmAe+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733587028; x=1734191828;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdQrDUsGyZ1stRNvpbiRFxwmrLkXw2hhpI8HZSLUwnw=;
 b=vXZ8QP2VlQL5VJ7KSADkkGOyEKLLUGG+2z3LfPLgGYEwpJcPGWIyqpmI6waXQ8aQDh
 cJYE/k7vvqRGET3c9yrEHfdK2pef3hjTEW6wDFBM/KFF4Nq0lpQbQTxMBZgT5H5pBocz
 p6npIMAfdDYqxPIn2HVHyh5AgwsXRXSsrHCUSPgezDcTZUd0kRpa+YRTbxxgP4D/IEob
 OL/iVLpeEHEz5VBvsk1vvdPD53Ka+Wf3V1a3AM3tRQNXxmUI2EYrdLwUVNA3Wym5eN9o
 KN0eQVM6she0p6a7YHA9pRmyyduw5qOOQG4uMWi3MRC2oFi6VYp5A5SOOMNtgKE4bRjB
 YzIQ==
X-Gm-Message-State: AOJu0Yy4VFv89ZRLG5O10uLWcRmFKP+OX7zrR+mJCOJ3Oy9warP+0hE1
 0qsep4wpws5CvwgKyRVBPtEzQSweVy7EW/uSDu2hMEjaKDEmNebTC3VJKkAM2J+X8f6s91U2SSn
 ulJk=
X-Gm-Gg: ASbGncul0Ke9blcfuZVGFH9X3NJ+hJCpDPE4dNCUySdW5K1Uj8Y7eMTJu7uD5gFESJT
 JcvAzXa3Q6k6AD1m/LNnJoBkh3vEHZSDCfD/1JS/q7Tls8a1/rO13oiTMovaGw2X8WvRNprq/G9
 T0CkKbs1UZ+Di/OE4XkLn6bylvzz7cXusZOj5OlLpMjbiygNonlRayHied+Vp9dzy28K/+TfHQd
 r9fU+pxNIwd+QRYSiazEfzDSxMHwGjwHvxYwQ10ec8GCp98sw==
X-Google-Smtp-Source: AGHT+IHvFHUjbtasc5Sav8/ZZBtervpotNb6VuyRX+e/tKqUeS5Im9xxg+Lfevk3v6VF9QpQYcjarw==
X-Received: by 2002:a05:622a:1a19:b0:467:5405:1ea2 with SMTP id
 d75a77b69052e-46754051fa3mr22984061cf.33.1733587027789; 
 Sat, 07 Dec 2024 07:57:07 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d2f15sm32998151cf.35.2024.12.07.07.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 07:57:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>
In-Reply-To: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
Message-Id: <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
Date: Sat, 07 Dec 2024 09:57:05 -0600
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

On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:

> There are platforms which set the value of ram_top based on certain
> restrictions that the platform might have in accessing memory above
> ram_top, even when the memory region is in the same DRAM bank. So,
> even though the LMB allocator works as expected, when trying to
> allocate memory above ram_top, prohibit this by marking all memory
> above ram_top as reserved, even if the said memory region is from the
> same bank.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


