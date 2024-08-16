Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A110C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AEF88B4C;
	Fri, 16 Aug 2024 05:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ib+7/aNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3020B88A82; Fri, 16 Aug 2024 05:47:32 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F0288B0C
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5c324267aso971469eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780049; x=1724384849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEkfHy2TWm8KcZaD0OLUVCP1RDM1suxHlpuB9vs9GO8=;
 b=ib+7/aNqwFxmIg1Oag0Dk3UdqHqA1O9CVwtJDppSyC3aHHaw0FcpYFtzkOao77XZBp
 fmHOVnfPTXwQcUMGlCSdgOklBmdQIRfursx/KLE3zbajBMOrODugFxxgAUoDVYsVctRY
 pt6OsXW1SFst6WGCFJ9yKmO/WuAqrEyuOYf2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780049; x=1724384849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEkfHy2TWm8KcZaD0OLUVCP1RDM1suxHlpuB9vs9GO8=;
 b=qs/RMcAKwwoCNZy7erZpf4YOSX1Du8a4fmBtL6Q4JhlwNF8YB5Jo20W7c0Jxy0O8se
 tLELPrZrrtwWDCj/P3iyC/2bykgE/bZfcw0BrBQlZidfjCxK25Nm2+7jRQFzu0fSkiCH
 VLWYUXG7/vJgCNlVxydvgmGWyUfBYy7blxhnRspbGxjiklL4wZCFFWNV3LVhpEUp58jK
 K5X27yRB92idkJr9bq/Rk6vU8ITTO4otJDOEhWUQ0FACowDZ5dsZ3OlKwA8grw0UjfBr
 HGhJE0s5yQQeyckWqJA59VkqR9l2NeClM+ITISJAp9WjCuajZlLq8bzvpE/ygLUNMxZJ
 AOtw==
X-Gm-Message-State: AOJu0YxdW84f5sLBV68E2iBlUEkPis7HH3ZH9ewxW0yzB0Sh/sQyuIeR
 D7tPP7bIDs/Yp/PG52UrhQaA/WNMI3lnzZ06OQvR8yFLUWYtFx9+SnMM0ZgW9p4=
X-Google-Smtp-Source: AGHT+IHBH2v5qpdDbQZh0haVLJLK+MJggE+K7saI1kWkgXr5+T7F5PjzIB1w1TE4jlVxp2oUOh8uMw==
X-Received: by 2002:a05:6820:80e:b0:5da:9204:6724 with SMTP id
 006d021491bc7-5da98028adfmr1921388eaf.5.1723780048894; 
 Thu, 15 Aug 2024 20:47:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: upstream+uboot@sigma-star.at, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, jmcosta944@gmail.com
In-Reply-To: <20240802200509.2471-1-richard@nod.at>
References: <20240802200509.2471-1-richard@nod.at>
Subject: Re: [PATCH] squashfs: Fix heap corruption in sqfs_search_dir()
Message-Id: <172378004801.3540666.17181059756441978775.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:28 -0600
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

On Fri, 02 Aug 2024 22:05:09 +0200, Richard Weinberger wrote:

> res needs to be large enough to store both strings rem and target,
> plus the path separator and the terminator.
> Currently the space for the path separator is not accounted, so
> the heap is corrupted by one byte.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


