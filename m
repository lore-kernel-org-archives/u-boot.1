Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209C4CEFD03
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5BC83F01;
	Tue,  6 Jan 2026 21:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mU70TnAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580FA83D9F; Tue,  6 Jan 2026 21:16:36 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D39583FD3
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7545310b8so702188a34.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767730580; x=1768335380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3FbcV/l4mlxULHnFQcesV61MNRluKMLGFaN/8MCsbM=;
 b=mU70TnAlOzfNuSsE79GscRH+dvmmjET0pYokIxL+3T76xFonm8pAKopNIWFR0Lz39t
 IDGXRU+YClCG1cf2h3H/F65xjIElgmJtvtdCJCw2kDnFtwmOMAS0KAKd348DK6ZCwQDk
 fv2AyQDu+kO4aDRfIeY95GVc886nWfrAPjDuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767730580; x=1768335380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y3FbcV/l4mlxULHnFQcesV61MNRluKMLGFaN/8MCsbM=;
 b=qMA951fAUJ1f8qfrnrxKZwoQ0QxiKQbL2OocNxQxdn/EsYkRvExdJlJk8elBhTV8WS
 YQEmw9LPY1VDeWGSEzOvsZyAysPsREDW5H9Eeh2HVRaWm8xy0ASvH4WvNwpkOuVkVraP
 ndFx8Lb0HkSE86hG47YuoMYRx4M5AlZVAuJMkNvBBQb50YSJOpPP6OsKB92koS/A28EY
 a+vSNWuDFVZWJ5dz5CjzK+25biwWaCMztPYO5LPJNilTFIlG5swQk7P7w3ddP2Qpx0t6
 B/ucczokLDWuXJ9GJDH6UZV+UZdmrCElMsTjCVzL9mHgYRkqd51xGtbioYOQpqlUdiZ3
 46bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXduFi1hv5dOHbsy7PjOWERrLz/tPaqxJYvPptnSASnsKVPzQ2IZomD3lqS7UEwBavseLWtA+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwfRq9dxMfePAal2DAIWAsCNK/UMH2rfXLfoTjrS4HkShZSCeqW
 dZz40bwVkB0axTncq9CkKcxNSqEPkawPuw1h5IFilJNl8+qmcMaudObgEvuYRKgFvSE=
X-Gm-Gg: AY/fxX6IsxLJQ4yZCsi07ZNbFZpsrWuVVplnYZ3YjzL9U1XjJtcSqSL+95jIHQIw7T6
 jFw7yBrHEqrbIkaFi8q5WlFZkOj4FmHbeiu7oFyar1rWaJnk6gTfOuJ+OhJLDNzhcRF6fEb7Q/z
 dzM8hu8N+vOGRjVaYOCYF6YrqpgNDRlMqwr1gkRM1Z7SMBRelsAKxDaTD+2Q8RVNB+01pLr1lw5
 qyafTY2ILxAgt9uCcqmuAU9mIyGmxcKJfCi5qIKIbqcBhKN4DqDFhLvCyt7B9o6CA++uxz5E0sy
 /2+eK0vkbLWBWTj914vhJE5sHIpEHjcG6Cs423fcCb4QTiPb2imC0yN9tefhmhHj0kMf15bMStO
 pyDtdGy+uKeuT9qUBPmnPkpfPIStMcncb/6BMejD0iMjzyDRf/KmDGRmxBy0uPvkpBLkA34b1Ck
 ac+wZl0M4rtyPkWkEOAKEfYN/Ludult7guaSEZUgiBSaEpsBBM5xOTso7zODDB7ZPyozfqIKvbr
 xiBae3x2pq1YY54WzKGJU7aPdRb8TE8aVxHRQ==
X-Google-Smtp-Source: AGHT+IFJpnpJQE+QLU/pSDPdCtkMuJ4Vuv35sxz1wr6fG60l6ThFG4+qKEjY4CiBGMcWfpGpsokXGw==
X-Received: by 2002:a05:6830:448b:b0:7c7:4bb:dc06 with SMTP id
 46e09a7af769-7ce5084e2e0mr241196a34.0.1767730580297; 
 Tue, 06 Jan 2026 12:16:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1962355a34.16.2026.01.06.12.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:16:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Javier Tia <javier.tia@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251229161045.177883-1-heinrich.schuchardt@canonical.com>
References: <20251229161045.177883-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] .gitignore: add vpl/
Message-Id: <176773057940.3765597.7253669634107876428.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 14:16:19 -0600
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

On Mon, 29 Dec 2025 17:10:45 +0100, Heinrich Schuchardt wrote:

> Directory vpl/ only contains generated files. Git should ignore it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .gitignore: add vpl/
      commit: 75a5404a588938d2803e07acb9977e3dfe29693e
-- 
Tom


