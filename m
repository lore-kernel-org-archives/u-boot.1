Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08399C369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 17:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AAB80F9C;
	Wed, 23 Apr 2025 19:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kcvW0Gy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16652805D7; Wed, 23 Apr 2025 19:34:14 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA9A08082A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 19:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72ecc0eeb8bso93133a34.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745429650; x=1746034450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX9YWZY0X0SNrp4Raq+xasVK6G7b0mawNQlJSmQU4pc=;
 b=kcvW0Gy0Ki+K6kJXpJhIFSLmhTkUmuKVn57rSUz3rkB1vbIzrJcETNQ+2ESlq8bHM0
 K7rpW+8t9O8L1y/O2kZy1kLK2IEePyC3gCvluL390Xq7wFtQxseYt+kD/baASQ5JVSuI
 cb2hXAX+Zvuo1LumPrQpi6/YyyHvgp2/Pcc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745429650; x=1746034450;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sX9YWZY0X0SNrp4Raq+xasVK6G7b0mawNQlJSmQU4pc=;
 b=XOlq9CAS3+LNPeijfG0zvWnuK5l/E1yJyIBFgjiqpZBcG7qf2HYLpfGE3yLc/Xzhr8
 +b+ktvWlvtI+/qvMSmT2aCU6Cgf1+nZ7mJvLetDLwsawB2qAtCu0/9774vxpq1XVgD5p
 R78kuxHQ1M0uIz4Oj3uKsMWSKuLiVyPous9xgQXmWaiF4d+ufAs8Z1Cf8Hgft+MoGcPL
 3Onr9/XpqpADSFjebIqm58jNb+faiU2LOsAHF24iWwu+8y4oxtMrstZOQrdbykrea5R5
 GrCRVFowfPmtVYUs7nk+lLeH/tu8mS0r6m4c0Pmb8SNBEdLHjHy3LGgZlL7QADOZopaT
 46iA==
X-Gm-Message-State: AOJu0YyUiAp9/FMQWSx832fPqPvRyaN+V2iJXzhNT7D55HdOvDzjcZfV
 aNozr1iNdqiNKgWuHjQqmP4h9AXGVu2lHawy7X0ehtYJ0WkWbO4C5jtBtQwP4rAWpSRSiVOwFGA
 pilg=
X-Gm-Gg: ASbGncvuRvVAQnAeUj6+NTQZzXkbhSC7B14zRhPJIR0HAY2K5saTlkTcVUbUhH6IUaX
 wx35cA75qXzUy3PDxfOAzEBbraZOGy0hoKqSkrvVHqwZCHUf+bM4g7ADKOzX3G7dnLg0aqVkSQt
 MHfcL3EKQLxizjHWaMn+ruwATOnHto0I0jJ9f3ZTKpOVHEXWmouDv5FPCQE+CylO0q27q0uwJDR
 cB0C0JRDq/5FPkIUY0mJtMT1lPNawyIUfQsYKw6v2DdwieSYSNHxXV/iwORodHn3LUkKRjq745Y
 JpiHmr2hYNn/xpwUbEPUs5Va4VGhpWfxfxrpsZlMwAgkQ2MNEJzXzMA9yscH4+FsMKxSxaramSs
 /
X-Google-Smtp-Source: AGHT+IG/TSwaMC/kEPaOdX4mk+qknsgBH0uCEN5wR+5e5ODKrE5YU1qFKcwQqJQWemx1il7kXZCs3A==
X-Received: by 2002:a05:6830:a92:b0:727:3439:5bec with SMTP id
 46e09a7af769-7304c8cf14amr195493a34.15.1745429650665; 
 Wed, 23 Apr 2025 10:34:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73004884887sm2572933a34.45.2025.04.23.10.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 10:34:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250423160155.GA30338@nxa18884-linux>
References: <20250423160155.GA30338@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull mmc-2025-04-23
Message-Id: <174542965008.3933035.392780568008144912.b4-ty@konsulko.com>
Date: Wed, 23 Apr 2025 11:34:10 -0600
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

On Thu, 24 Apr 2025 00:01:55 +0800, Peng Fan wrote:

> Please pull mmc-2025-04-23
> 
> -------------------------------------------------
> - Introducing back send_init_stream for omap_hsmmc
>   to perform the 74 clocks cycle sequence
> - Move scmi regulator subnode hack to scmi_regulator
> - Typo fix
> -------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


