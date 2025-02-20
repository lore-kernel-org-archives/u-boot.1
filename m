Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E29CC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F71580F5F;
	Thu, 20 Feb 2025 18:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bvZss9Ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4388E8006D; Thu, 20 Feb 2025 18:19:27 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0549E8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2211cd4463cso25259065ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740071963; x=1740676763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Cjq2zEi3r5OJzF8FYXyi3/yri4MuPIUBYQZWi3F2x8=;
 b=bvZss9YmvyeDkaU3Pn7diRsFECESKmNwy3j5ZHW1iR9954MfqvSNj0Exfhqk/q2/a6
 rTmmWb35x1GWl2IhLVZT+Th/bvJG2jOZSAfeQx7MeeUGJLDu2+dBSSqNZaU5c9H+E18q
 WkAQF8v3lpuwO3FiXjOxzYqjCGic7MjpoZj7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071963; x=1740676763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Cjq2zEi3r5OJzF8FYXyi3/yri4MuPIUBYQZWi3F2x8=;
 b=bYQIgT1HunJLD3fTaDy0fd8jiE62yoQc+OEax+XVzneLP69gVzE0NQwDCDaU909KiN
 HM2bevx3FXD8c1EHJ1H8W9wb7mc0+bpJ5oXQjB3pJ/HSKOXobRr0KpbJaDaBtkajHE8E
 FBO3vxcQquDsRRPzdvbacTJ5Zh3zhYDWyBqZ7mGwV17Ih20iVMhDR66nSaUlv34rJMy0
 P3LVRzO+W250cMwa8d1pBJlHB2Lx1f6GWBd++qq3H+3IF4nVPVnW/Y5wcRV+NvkNIrXs
 hQZPyL/b0WyiYCqF2WI7A1tsIW2Em/9OVBpYme7Sh1qFrItd5688rkmx8CRzFVCu8FW5
 esLw==
X-Gm-Message-State: AOJu0YwctGJbb/qNHOZsO/19Xw65D2aTPyBasQz0sG0a5ISSWeOxNKz/
 sYquN91+u7XeidSStSyE++IBYHGN9l/cnNgEUfvWpe5Uy9jwO+x1W40hrruBy/k=
X-Gm-Gg: ASbGncvVV39YAn5QC9ATzd4hBBF4BIUm5mtXQwGBG1tX9Vs9wTba/xPCpexb5Nvfa4z
 fqmnTO6vsL0BLpiMfJSsvbcPxuoq19GR2PdhvzQnW/eoeR+sXs+j55kgf7UKKXMzT2s8BqrdV0E
 U/z9d0CrYskGMlVbXTZRDWYQuHEEiSqmH3M5VC5emQ8/16ai70NWFeNHL15/i8XrdL7S+UmraEQ
 HNEXovb+n5EnlPNV06jqwAmDGfflFmUUl7b6drSfc0qyQX30/kwrHOstWmaKpAImg8bFyq5v9QO
 eGaJmRUByNMk
X-Google-Smtp-Source: AGHT+IEjefOH5+z3bSlMmkztPQYLU3J1KlyYh/jKhBKCxAY9OGFAyDKpHF4Mac/3mcoPqrAxXjUoBA==
X-Received: by 2002:a17:902:d4c1:b0:21f:45d:21fb with SMTP id
 d9443c01a7336-2210401367emr365933115ad.3.1740071963579; 
 Thu, 20 Feb 2025 09:19:23 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d021sm125324105ad.157.2025.02.20.09.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:19:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, s-k6@ti.com, w.egorov@phytec.de, 
 n-francis@ti.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
In-Reply-To: <20250210072834.9135-1-eichest@gmail.com>
References: <20250210072834.9135-1-eichest@gmail.com>
Subject: Re: [PATCH v1] board: verdin-am62: add dram_init_banksize
Message-Id: <174007196212.2923422.16530028038823922874.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 11:19:22 -0600
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

On Mon, 10 Feb 2025 08:27:47 +0100, Stefan Eichenberger wrote:

> Add the dram_init_banksize function to the board file to properly set
> DRAM memory sizes during boot.
> 
> The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> common location and Fixup DDR size when ECC is enabled") relocated the
> dram_init_banksize function from architecture specific initialization to
> the TI board initialization code. As a result, boards relying on the
> previous setup now require this function to be defined within their
> board file to handle DRAM sizing correctly.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


