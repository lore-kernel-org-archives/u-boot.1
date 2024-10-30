Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF87D6B6DD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 23:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1304A8928E;
	Wed, 30 Oct 2024 23:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GHHc6BFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BC88929B; Wed, 30 Oct 2024 23:59:42 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FEED89245
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbceb321b3so2404356d6.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730329179; x=1730933979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNygn4tsSRcymWeMp8da8j6ORuDkzfHuHFddbwJeym0=;
 b=GHHc6BFYsP/fpcEoe2TNofr8vufEU5uvCKqepyUOBMkWOn02OB12IkdmIF3YG2V6K0
 OlxmmGIJCHlwXTc0DmsNCCN7ZzmbwPTyhTejfEJ2IWyRAfIySfNs7SQob0M/hbvNn+4j
 1iCcXxVFpzRrHHX/EWBmWzuQKkUIc4KbWtxmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730329179; x=1730933979;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNygn4tsSRcymWeMp8da8j6ORuDkzfHuHFddbwJeym0=;
 b=Ygzc5PZMqMZZTB0xFu5LYv67g+9zzrlKplvmj+9pfF8zgSosOj6lHwxmgMsws/rt3B
 ch7g3FxilJGNTvFt9B24fgHcDDCLU3zTFYeV6ccQn8NBBBrsCu9lmgxx0gBB2WDux3gq
 RGzlTFVxNh3YCwX9GLXhsDdGOt+sB6h34qFLatxFX8KVhs39Zak6sWPylXUQCe5rHe8A
 1TeokRxfJ+duk2ak1CqzqzdfmQz91qmFJPdmx+QX7yy4AWiu6o+Bj4Jhy1kz7+QzhnL9
 fMEH9eBL1DZdJHa/jGRKkfOk9QMj9kF6ZubzWzknO/YYweo1GontSt4QV4093bYH4VAz
 elfg==
X-Gm-Message-State: AOJu0Yw6LfDuFpNcRozrsGn/c4a+IH/SrvjdGiWDp9Mdd8e0iyryBeVT
 20pDFtRFLkVdx6oZSN+/ai1VP4otd1NcLE3bf9zOfDf9/LBfIu9ZJdXblsjXL31/A7nzHGOYGur
 SoBSgtA==
X-Google-Smtp-Source: AGHT+IGKa6FA5aL8Q82aFKYH4WW7GK/KmiOvE9MLiC0iDxtvnA8STgiJWZsTzrfsht/H/hFAfE7ZsQ==
X-Received: by 2002:a05:622a:45:b0:458:4fe5:b307 with SMTP id
 d75a77b69052e-4613bfb6abdmr246329141cf.10.1730329179138; 
 Wed, 30 Oct 2024 15:59:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0896e9sm1257861cf.11.2024.10.30.15.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 15:59:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: u-boot@lists.denx.de
In-Reply-To: <a65bc69d909e18b9cf138f8f97f4b16b4a4d4de7.1730133875.git.baruch@tkos.co.il>
References: <a65bc69d909e18b9cf138f8f97f4b16b4a4d4de7.1730133875.git.baruch@tkos.co.il>
Subject: Re: [PATCH] boot/Kconfig: correct fdt_fixup_memory_banks name typo
Message-Id: <173032917791.2233801.7346568464786030466.b4-ty@konsulko.com>
Date: Wed, 30 Oct 2024 16:59:37 -0600
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

On Mon, 28 Oct 2024 18:44:35 +0200, Baruch Siach wrote:

> 


Applied to u-boot/master, thanks!

-- 
Tom


