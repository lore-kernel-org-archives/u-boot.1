Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9045C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0BC88206;
	Fri, 12 Apr 2024 04:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l/IdrJ53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1A0881FB; Fri, 12 Apr 2024 04:12:43 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B8B88080
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78d575054c8so25151985a.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887960; x=1713492760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QDTkJTElcu7aVtK4GPNxCf/nRZI5HPQPrAx0FptpdM=;
 b=l/IdrJ53h/pQsJ2ijbfwQbyG0moa2uLypveQ1kqj4n95Qvfo3RcSSw/p38yneInScI
 76r7Dkf08YKkv+hmhEJY8QQWcyTTMYrwVZu3pJoMZB3H883gn2QFXdQT137+mTp1ZLBC
 KMuCwDSDw6BNHIZMdWFSmcWd0qVcF5L8Smmmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887960; x=1713492760;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QDTkJTElcu7aVtK4GPNxCf/nRZI5HPQPrAx0FptpdM=;
 b=tL0wrRYlcGYpyo3XoTmhCTRKr9d2E/ws7+X/lFIMA2/DuP86xG4YW00SAAs93PqUwT
 HmTL+xX0pAstXyvPXv8OCRwq6qcQwUlKHUEOmAaYnwOuD+Jx/+guXaDdvjVyAV/OGzT+
 3cdqG1EwOQ/7k2jEgPXMNfATyebJb3u/T64tWuforVo4nw/Tsr4PR1SlRCuO/00PXbMR
 VP9vuY5Id5ZV6DIMS3H/LrYOA5/GP1M/9BQl/BtbIAmSz/44tdqPYsWJarUhfa4pmJA+
 7G5F5eaAd+9qOFOeAiNp2cY8WwqBChy7CAnihHI8rpl3QWRcfuQqWj08cU0C77fem3PM
 /7fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZSozHW2Gp/RIEpKEgR4/HXIM/HgPViCGpHuUcbDkQoU96LODnimWe2DYiguVDDeISDoEUyseHdq1sROHVvzGUt7SagA==
X-Gm-Message-State: AOJu0YyMiZwaTqA7oV2M5qXon3PgfL/+HdId05uK4xsLknycKfCZkYT+
 oUZz/iRXMsFxpg7pk7LB6kUuzVzu2cb4ajuiMvvsnN5FlFIo50qHd/Iy0fvGCag=
X-Google-Smtp-Source: AGHT+IFlKKJqu1sVw8sA6+kh1FoRc+BpuT0MS4H9Nix7B0gwWlQD5+R5PZi85YcqfcfLIGjaVFhpmA==
X-Received: by 2002:ae9:ea03:0:b0:789:eccd:cb4e with SMTP id
 f3-20020ae9ea03000000b00789eccdcb4emr1568742qkg.36.1712887959989; 
 Thu, 11 Apr 2024 19:12:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
References: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
Subject: Re: [PATCH 0/2] arm: mach-k3: am62: change a53 clock frequency by
 speed grade
Message-Id: <171288795912.897536.8167739270175383736.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:39 -0600
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

On Wed, 20 Mar 2024 09:16:30 -0300, Joao Paulo Goncalves wrote:

> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> This series introduces a method to dynamically set the AM62 A53 CPU frequency
> based on its speed grade. It adds a new function to retrieve the A53 frequency
> value by reading the speed grade from the hardware. Subsequently, it adjusts the
> Cortex R5 device tree at runtime  with the frequency value before initializing
> the remote processor.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


