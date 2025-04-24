Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5162C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4CC817C4;
	Thu, 24 Apr 2025 18:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QoZdnKVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE56D8056A; Thu, 24 Apr 2025 18:43:48 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AE081D5D
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c09f8369cso457412a34.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513025; x=1746117825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGJGOKTTDRc+Vk238X6SN6nE3z1Ebt/2JFTSJ4CxhZE=;
 b=QoZdnKVgpGY/tEKSU6tx1I1bFv5NrsG+6jzZoEHW0vZRZkuvPxInNhsad73OpmQaJl
 MjCvPL4Kd7sp9e/W+gUOFhvAKD67KZpBdBPW6wFzc6lNQ6qdZ/saGUZ96wecJBhVTNY2
 CVQic1i2YuBS69ZQI0anbLJmR1NT9R1n8rVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513025; x=1746117825;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGJGOKTTDRc+Vk238X6SN6nE3z1Ebt/2JFTSJ4CxhZE=;
 b=K/5qhZqMrUqZ6I926zmVknN9zqs9rE3vLXK84bhJW3T9Se9pVBl0NExM7BL6ncOBVj
 fojeGOUNEncwWJK5CKr/bJOglZcd3fAcbRcYqxCNzn21YvtylrpurFGR39RWI0aHD43D
 7HAnBUKVv73Qyhs0eYGdE7D6BuH6I67IvdeJ6kJsM/EKo7gYhslF+mQGlb35oq/9zl/n
 r9Y2mi7CBZSd3D0rMfSVLC9Z1P/IxwAqNKhIyHjQhGY3+XiKR1yXWvivMNkoDBiGnm3G
 xW8d9jQLp0fKSh6ldSHaDWutMbM2ZpiWc3maVEPNWIrs4byRhb2xIC/mdtCTUlxSaIbB
 pQeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrWuYwJwYoxNft9/u6A0zG+kbD+/tD6p2pQ7zXCGAjpFAfFvxpaNmmILLTtTN1vo9QoTlQdP4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx86/yptY/y6RM3anjdox4j2RFAheRjopowBLQmZ94yQhz4pPaT
 WCyplqowRKvZnoJ0kOjar79R0PUmSo0/o44zusSI0ajbLOAI1MXgym/ckXOeYXOV5qVDL9Yir9s
 5
X-Gm-Gg: ASbGnctdmGxudDzcepqltD1/+1ByG64a+aF9DMhAdtmeUdJtR5RVzjcZHgni5sm7Vkg
 sCVmK1SpESunrgc/+NCY/2rbPw8cBXiklw7Lp++NrVbvhb18a3sgxZTeNBc7LPKpe74yRisaain
 +96ap5ejfzJLNXVDrLbpXiLPjC6mMusBMWqTBAkIUwZg3LNrKvc7gcLCiuPhwAwMbpoYn77FJcX
 LleKPNSSWHOHK5bCrakjuWkzHbSAAJv4MUydajdLS51lV7ZqxmFV8OmScdqVB1NH/V78ex3Sa1W
 aqGc2RackeGoOn/45ePygs4U/rRNa5R6xGSjf6k27sZrthrC+lH2DbQom8ImObE0ZevPppHWhog
 S
X-Google-Smtp-Source: AGHT+IFPTPQ0K1nFa9yHV84nmgOwvDJXJRuouN5q/Qekwd4BcYNaPy1NUaamiE+7AwlrpVL6CQxEpQ==
X-Received: by 2002:a05:6830:3c8e:b0:727:3111:1416 with SMTP id
 46e09a7af769-7304dbc1aa9mr2476957a34.24.1745513025415; 
 Thu, 24 Apr 2025 09:43:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-kumar1@ti.com, bb@ti.com, afd@ti.com, n-francis@ti.com, 
 u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, upstream@lists.phytec.de
In-Reply-To: <20250415151241.3128391-1-d.schultz@phytec.de>
References: <20250415151241.3128391-1-d.schultz@phytec.de>
Subject: Re: [PATCH v3] mach-k3: common_fdt: Move carveout struct
Message-Id: <174551302443.4069373.200840918780371191.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:44 -0600
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

On Tue, 15 Apr 2025 08:12:41 -0700, Daniel Schultz wrote:

> Labels are not allowed before declarations. Move the carveout struct
> at the beginning and only update 'end' at this point.
> 
> This will fix following error:
> 
> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
>   156 |  struct fdt_memory carveout = {
>       |  ^~~~~~
> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mach-k3: common_fdt: Move carveout struct
      commit: 4b1b07e3c6055edd29b98a7a30a5c7d062395df7
-- 
Tom


