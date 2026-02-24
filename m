Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD96FF4BB7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 20:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4E183DEA;
	Tue, 24 Feb 2026 21:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QkcSAqOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E879183DCB; Tue, 24 Feb 2026 21:02:20 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B627382BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 21:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45f0b597eb4so3815551b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771963337; x=1772568137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ataPTQaGQ09iAfiyOMyqBS0lKMKKZpBguE8YIMmLGgM=;
 b=QkcSAqOjLcT8yW/YgZ77rKK+cGPxIeoHDw0iibgdUxyjRLWusoqI2Y0w9Sn+EHXnyV
 Q70JKP3AtO96lgdXzrgkOEwsUc7n+bE55wWR0r3FWpDPC+t16Mnf350Urrel/71SRsup
 lqSrQCoJ5ILJpO6NzlaO8UXCuH+mrfX5mtiBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771963337; x=1772568137;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ataPTQaGQ09iAfiyOMyqBS0lKMKKZpBguE8YIMmLGgM=;
 b=Z985SeMVjoS6RqcC5OSaV725x5m7j4p+O2Ml3JQoOLWrWevNWtZodfNwPEemIT35ei
 FvctaWk6W3Bkt2YImi/Xj8EPyppVS3WB/fTrU8DULto0IeSeygG4bUuA2cgwhaHgIXpW
 NLwsyFzyaZmTWy/Ir+b0K7C0x+o11sg5PcZ4kUKS6Bbm8x3VT9xpkZBGOnaFbHdLSg6C
 S1XSqaqUu3wjExNr+VlLsdTlxlW2qNKI8CPW7p6PrPQ/J2FV3bCuwbQpapzr7ThYtiAu
 jJV8M2vjFf0va6hHAIlDN6v9z2PtoDYnD6kerJrcxq/JSx3GPiJdTT0ZXalDczXGUAYQ
 fOAA==
X-Gm-Message-State: AOJu0YycJXL+naJnw4RSnbLDtCOwGvaU2TwA9gDQIKfpeqeDM2Cyayre
 XDsf/811dn1W47zbZp9PwYgTZNdtGH1JCOlLSNEr6KiOENcR4sIWpztMNK0mHCVfmkE=
X-Gm-Gg: AZuq6aIlbAmJpVVb1wzY+fRQJZMNf0uUFT6dHpLpPLumfkBZi40+4XguFcGOqwXOx9o
 HK2gs7ztG12pDPbBdE0jGON7m7mCBaDRQedyhaD2PZWexSjbqpUnKM0kgj4rb60z5oj9ntD4MlB
 uY/2t5XjicnRubXvCpxbHKRzo3H5RMOeOW7qj6uFjFhxak9aKUC5I+X8qvoJYYShUCqkSX3uKA3
 lWUOUom2BRYwhv2SagJZeWCuBdP3kdbifVTke17wZFPMWZomfC2wzjaCQqJv/lCgIXfee6mMfke
 cAmZcdiBaxw/YfxRJ7p0DMyQpAYuWgb2s/eetPh7preC8dbsMZolRNxnwi7XcPawK9wmitMgzqn
 yILhrbcn+fA4pSe8pHypXL+OOEcREvmsLIzleVcoWcKsWklbZI9RIJ3omY+0Czt94zGXGxwQsTR
 cg9tZ1edVtm8tPYVeYsCejqixaXmUJy/Gs5epIpejzrrI9yK11AMFZRrPHDKqs6OMma5ELI8Bov
 nxctyD85SvOjxnEynBQI2Z75stSUW3kJfLu6Y9Sbp73KXkqCA==
X-Received: by 2002:a05:6808:1996:b0:45f:16d1:8f5c with SMTP id
 5614622812f47-46446260951mr7500504b6e.28.1771963337323; 
 Tue, 24 Feb 2026 12:02:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm7621369b6e.6.2026.02.24.12.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 12:02:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: ilias.apalodimas@linaro.org, anshuld@ti.com, d-gole@ti.com, 
 casey.connolly@linaro.org
In-Reply-To: <20260110195610.42068-1-kettenis@openbsd.org>
References: <20260110195610.42068-1-kettenis@openbsd.org>
Subject: Re: [PATCH] arm: armv8: Flush TLB before enabling MMU
Message-Id: <177196333614.158215.3546149316972836827.b4-ty@konsulko.com>
Date: Tue, 24 Feb 2026 14:02:16 -0600
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

On Sat, 10 Jan 2026 20:56:10 +0100, Mark Kettenis wrote:

> Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
> dcache_enable") broke Apple Silicon machines in certain scenarios.
> If the MMU is currently not enabled we need to flush the TLB
> before we enable it to prevent stale TLB entries from becoming
> active again.  So move the __asm_invalidate_tlb_all() back
> immediately before the mmu_setup() call.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: armv8: Flush TLB before enabling MMU
      commit: afa8f076db3e4ff322455e4b13b796f39c30eb14
-- 
Tom


