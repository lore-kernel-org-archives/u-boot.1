Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D7E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82C1801CE;
	Tue, 17 Dec 2024 18:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GUkMQ0al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A728E8022E; Tue, 17 Dec 2024 18:18:20 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A3F8027E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6ef047e9bso500921285a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734455897; x=1735060697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiLvdqwob+S6dj4vWqyXhy4ni3RY/T9JUKGB+qSTJn4=;
 b=GUkMQ0alivv7PtrJTLM+7ljOi2BkDXHkOeki7PEvrKCcJEe0oSsVMfywRXg6KWBxkz
 uKJor8bYiyhlCi8xz0MCY1uL4ZgP6VD4l8tL7paf0I1BUC9TLGE1vAs5bsGcOUaDtWxo
 4TinZKbNr7pf7TRZRJyHwQHBusw6mUEN8EkHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455897; x=1735060697;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiLvdqwob+S6dj4vWqyXhy4ni3RY/T9JUKGB+qSTJn4=;
 b=bUd4cDU5mtf9Bet6ZFMFHgnSK13JQyWoy2aovzpcoltnmtlqbwhjdbanvzPyt9Ra1m
 3jiL7yBMRVOqpEtcT9mXV4m/UFd+oKmBNAdPkueHNXzF3Yj5EjKqeTCqpRDoWUUg1D6n
 5XGswx0A9wrEjYthhdRHVOsCveOR4nUbUOgkAAGb5po5Qw0KRHCKuQIlIyYNBjnW1SNh
 4Sc77wpUGso2YaOXC+6Ma7yLG8AOgExVCC6BKoB0YHZhzPRctcS6XS4XTweS3VnqBgyO
 yQTrXoxMj1UBbkZH9xw0z/I5HU6OcKbvmDFUrjPdCJfcTcEFBJg+hUVUVuEuXoagVwi/
 LxVw==
X-Gm-Message-State: AOJu0Yye9cmnw3L+qRA7BwOTrCkVJr1jxqtYcCWcAX8HcBINHX47P1ac
 9qmjtrA30y9JhkeLr6KdX3mNAZ2oN1TMRdAaCkSE5LsElnrm/sB2rS1bplzWCfnj/sQ1gaYttmP
 uycU=
X-Gm-Gg: ASbGncs+QwBK7Y8MzRfbomYEvaE7z3YstSmZUoG2nOfhqq7oSKnfDuBwkzD/LW5742+
 HebSuMmaoS/bkTg6NSpwoSqDFLV0H8/yjAaVxJdHut4ukY/cI3lZAsHHAX7repd0GN9oFWoUOk6
 mwPc4LX+4sDIIDRodz4ZZUsw6SwT4mJ+kO9/MAPAz6OM9tR5cevFdq9IyrnLbCQRDeGJQmFSMVW
 fhk4RjLezg0JnmQSjTS7nv5a1ofrygZtwDq3QS2PNmwcEOXVUlb8Tg=
X-Google-Smtp-Source: AGHT+IE2Y+GQKfE6l3htnNGaLrVSlxYhdxY3wEJPQvSRGyfDnQgTamwH/iEANF3RmnLdcIji0FlCQA==
X-Received: by 2002:a05:620a:2985:b0:7b7:12e:48eb with SMTP id
 af79cd13be357-7b8596028ccmr699656985a.17.1734455897451; 
 Tue, 17 Dec 2024 09:18:17 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bbe9asm336450385a.94.2024.12.17.09.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:18:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20241213132655.670837-1-patrice.chotard@foss.st.com>
References: <20241213132655.670837-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB
 located above ram_top
Message-Id: <173445589585.4187054.717117017229929078.b4-ty@konsulko.com>
Date: Tue, 17 Dec 2024 11:18:15 -0600
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

On Fri, 13 Dec 2024 14:26:55 +0100, Patrice Chotard wrote:

> Previously, all LMB marked with LMB_NOMAP (above and below ram_top)
> are considered as invalid entry in TLB.
> 
> Since commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top
>  even from same bank") all LMB located above ram_top are now marked
> LMB_NOOVERWRITE and no more LMB_MAP.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


