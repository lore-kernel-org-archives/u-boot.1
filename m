Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC7DF483CC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2C88422F;
	Mon, 23 Mar 2026 17:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JADNvF+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B678410D; Mon, 23 Mar 2026 17:49:22 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AAF884180
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4042fe53946so952478fac.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774284559; x=1774889359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMq6M5Ye/IOKMSF2Vk5WKr3kr0TD3KJOaOnr4zR8aSU=;
 b=JADNvF+2VP0rvRede+NeXe4Sj8UZkH4KOI/r5FHyCbZJDGEaum9IOwRDsnwwB+yd2b
 76V7E3xxcfTqZZu/Y0MJ9m4UX1dblVEOaO6Db+LwFLDR3gltB+XRliZG7eYHyF0wVWV5
 8hTB/L501ltCpJnypV1855Uvnd4hIoU3pDqKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284559; x=1774889359;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dMq6M5Ye/IOKMSF2Vk5WKr3kr0TD3KJOaOnr4zR8aSU=;
 b=oNzWncziX4o3FlrDZsEt9BSCvQhhKPDxGjPG6TTIYgxRh53sDGXfSZO65TLAu41lRH
 CD+L39dDwhtHrf/o1L8VEyE9P4fnJeb0RnjPty1y4FLkdHExOYWBeugistXTnwhGZ+Gt
 qNwehsRDvvwswTq44Csk1OrBXRO3HOsNSKICyuVTqfWKPcD5D3ZwVhdzYblqztaHwsJD
 NiYsUgk2gCBfOes0Ukq8XMaJBe8B2fwc8GYrznj/MxxutJfdjzeeKq2yTODI3Vu6FBMK
 M3UpkvPZPVP9ZvTsSljv0FYCxa+JMZlwwERl5jmL30g1hfAZXPf+C4BNcknSYBJG2jGB
 th+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwL2JBBnEsYQqPW0QgSlY1aY2xk5QoxghK3P1+D/ulg5FIfbRdVww970lJEEqUdO9ySQfdGz4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+4lbcJSQwEZfufZk4XeuM4NxtMG7G04U6BsoznlzRaWuSTcgl
 Sd/wyfMcFSdLmlfCCMBFNowfASAPqs7Lk6V7yT6P16Z/jEMyxQgtwmPJVzIrR/EuV7o=
X-Gm-Gg: ATEYQzxgkouRhRmHwB/0BQrehh6nSjhMViXmEPkrg7svrgl+kqPXmRNyvj2Nn3sBc3I
 Kk5fnb384AoeBOVIJ2zyuFYb1wUAYalhzu+eaRk3CI43shsJlFiEq4PDhYSxu6shUO4Wxkq4Gtm
 d9/xwHVqHkJC6uWPyBlIPdVw0WAKul3xh5pn0eew88ZnsUt1Qoi9uKPbGXIVy7dxgO5xxdSYLYI
 3l3Jx/qr6bnqpZysp6f8a7iNeVABKWbQFKr6XbTrNE8q8j03jD9pMDDd3RyPVcMsjta2c4N/u4B
 OzyZuOS47LHqxLSs9jVtqVXNV5fYyvdEDC8RlMD6Yn9NI0bhXPbuGIG2qZnWDs5EUcN4SmOHm15
 yPHR7o3esZp7m1TVBBQinX4su7nQo3v65LONGA4SIb6Eh2Nfe2soUdGp8VLwmuEEDfYjmTR8OTT
 2sbQLJvAndls6ZoDqkR5xlJheR3o0P6+1QWRQJds4eSO33finVJDHBqIsJOA2mfIFiTmoL3AQXS
 Urkwte3DLR/vZnrrEp/QANxvfUGKZX9sAHq37ORpRRMDBI=
X-Received: by 2002:a05:6870:70a0:b0:40a:6360:2db2 with SMTP id
 586e51a60fabf-41c10f8de90mr7818388fac.21.1774284558982; 
 Mon, 23 Mar 2026 09:49:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d73a19sm10016158fac.11.2026.03.23.09.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:49:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
References: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/2] DDR configuration refactor and 16GB dual-rank
 support
Message-Id: <177428455826.2303875.3345667036165113500.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 10:49:18 -0600
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

On Mon, 09 Mar 2026 16:53:06 +0100, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This series refactors the DDR configuration handling for the
> Toradex Aquila AM69 board and adds support for a 16GB dual-rank
> memory configuration, while changing the HW_CFG pins value to
> DDR configurations mapping.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] board: toradex: aquila-am69: refactor memory configuration
      commit: f1fa4221485822317629f4d2c5d7087170915c66
[2/2] board: toradex: aquila-am69: Add support for 16GB dual rank memory configuration
      commit: 39e014f43a15e79b82946922ef7062ae0969ac99
-- 
Tom


