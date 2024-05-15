Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15911C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA2E8835E;
	Thu, 16 May 2024 01:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EKIIEr4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E3B88369; Thu, 16 May 2024 01:29:00 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A3F8835C
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-61be4b986aaso83725517b3.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715815737; x=1716420537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xu7c0BJqsEKSSK+7a0SFHtjmJkNpBcB8s6bYsqCrK0=;
 b=EKIIEr4Aq6Q6W7BkjhUyYR7CdD//tGQ+1T5uJFqNqBD+xkCa4rThmXIZpAg4ZsPDkg
 EqxzJ8l97EPMOTNuj9F1chXYKD5uEkUpcUtJiBVGJt0n68hL7OVjSjdXLKlyw29nfWqf
 to1/D8j8fr6AjezRVhF4YZ5+lGdWIQNtw/MnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715815737; x=1716420537;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xu7c0BJqsEKSSK+7a0SFHtjmJkNpBcB8s6bYsqCrK0=;
 b=Fs+KUP6723R3Ve+LT1XzN4pGiWI1pGbCFWkxI3Fi+/H8922YHsKFiI0U0ySPD1SYP3
 4HbAvLHg8t6fc1v4bScyzHq2b3hMm7dQdK9wub0XRICf1JsNTvz4y8hOq7K0xyqPiOJT
 xILjRyh3eIrtVdwmxtS9RSZXV2mTkBG7Ny+/aoNu2MQQxDwgUKOrGkiFeTs9dHinIyZY
 XNd/mx5frT/CIyPlbSxnj5gkjswQ5CT/9ulJZvee672iHLDAHP98Xu1zjRvG9xeQ6KZy
 MHDk9igaZoeoWWrkA3dLRWVg4kQpTq994xqhzWyDHSE3SxeY+8av8vRZ6fpnU4y82HT/
 k6Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh/+mumvV5JEHhNAc1yYBKt8lBARFqcEwdBXkiumCKw3LaKsHriBMDusCKwjbU/qIM2YOrVtbWpcAFTvsmPOJ3wFHQHw==
X-Gm-Message-State: AOJu0YyuOu4AyhMPvltcYkCAiLiHGPaeRACoWxvbbFhBUzbmd7zDTD4L
 z9zAGIEZDO5akJEm9GIwx5WRmfi5BWNkaZ8Mx9iXtcS6I4q4KCoTdQBudEysbwU=
X-Google-Smtp-Source: AGHT+IGEBpzJCKKEk7OzkZrh/GGRIEyQdd7lNxwH3P8TXDYpifHI1C7gpxZL0xC3xRa3/oSv9v6h7A==
X-Received: by 2002:a05:690c:88:b0:61b:2b7:27d8 with SMTP id
 00721157ae682-622affdc90emr196830407b3.23.1715815735490; 
 Wed, 15 May 2024 16:28:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e3935af58sm7978291cf.65.2024.05.15.16.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 16:28:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, devarsht@ti.com, afd@ti.com, b-padhi@ti.com, 
 u-boot@lists.denx.de, Hari Nagalla <hnagalla@ti.com>
Cc: u-kumar1@ti.com, praneeth@ti.com
In-Reply-To: <20240509142037.32064-1-hnagalla@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
Subject: Re: [PATCH 0/4] Add remoteproc driver for AM62a SoC
Message-Id: <171581573428.812585.3544471980053898090.b4-ty@konsulko.com>
Date: Wed, 15 May 2024 17:28:54 -0600
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

On Thu, 09 May 2024 09:20:33 -0500, Hari Nagalla wrote:

> This series adds relevant ip data in remoteproc driver for AM62a devices.
> 
> Logs: https://paste.sr.ht/~hnagalla/5e20838705c1d688bca81886dad56451b56d3913
> 
> Hari Nagalla (4):
>   remoteproc: k3-dsp: Enable C71x support for AM62A
>   remoteproc: k3-r5: Add support for R5F core on AM62A SoCs
>   configs: am62ax: enable remote proc drivers
>   board: ti: am62ax: Add support for remote proc load
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


