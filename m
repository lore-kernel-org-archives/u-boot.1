Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFC0C982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B6083952;
	Fri, 16 Jan 2026 18:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W29MlNcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F7083952; Fri, 16 Jan 2026 18:32:59 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84118367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40427db1300so1426806fac.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584776; x=1769189576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WMzT7ougYqLNFNNoqGHNTUCJxv0VZPLmEiDIjU1wFY=;
 b=W29MlNcWZp8DZEHDVjknn9Ac0Py1DsqHtp3vC2FmzNRCBvE1ZcKefXDpoIAtztk7hb
 9YPEIKkksXhRGsPmo9EOdlaDXmysvTVyZRAVaQIdmw2Eb9rw6eLk1EjJMhq+CZeZiEY9
 rz7lkhxh1cZuytuoj7KHjn1jpj9f6n3NtChW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584776; x=1769189576;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5WMzT7ougYqLNFNNoqGHNTUCJxv0VZPLmEiDIjU1wFY=;
 b=hdeJkGUc9Id9Jc1pfZMVooumDg9d/DREXHrP3fSzNVomdyw4xJEyFG8navKz75a8gb
 Do3b60eCcHr3bCyeXJy0X7EC0DwR40uzZ5wbNObWtvG50nmZK4z8rnOlrB6vWXFT9ggY
 4K0U/BMHdT8IrgxUMqvWZSz/BHNShY4vLSfpG71HRXtxxAibt5YVhHQuTLLphGl17Ad7
 4TWmeWL2LOYUqo/eHwwrBVzHP4cl1pS7RSn6pOzAfvfVnxGiYfaBbUuVNrE84sPASKLQ
 5H3eB+uQTExquFujkLT60KpLOdD0Qcys5oNCu2Xopv53+YOaEnAeNUaMNlj1R9+l5WHk
 XTdw==
X-Gm-Message-State: AOJu0YwnUwPWLZLV/tWSlY1QeabnyqLY8POogjWQjVsiABLgZ2pTwasH
 smTwQspPCdY191r9+toO1mjmaoRZY9KNrEpMNw6lHalR84BAi7paURynDhrNEB78LNw=
X-Gm-Gg: AY/fxX6Qn6vjZMobT5EUuiLku4HBTn3y9gtFKjiN6/9MwFDqgMmYarJmhk4tT+AyPkR
 P764q43SeV0xW6W3yoOHkrdkS8bT81asXadKiM/j496zn5mbiylkN97W+0l16+NYXJ90YtINitx
 S1G4XxePV+QHZMxDZvSNO5h3njaduU4Wr1Pijm+mChygkrl2FTDsSNgJLtYLWkgs4fxaNmwwmn2
 7Yt/HL63afdlVaO+GSJA1Qxd7jrNTQ9HdH1zshEqBo8aA/eciXVZAdpajCHGnQ7t2fxL4zJ43ka
 D2CanAO5gXTI7TwpkQiYWPYyBa+346ucuZ9YMAP4eYuHBBWVShQHSSfNcIo33eaqAv+Cy8jZ8JP
 nOVx/0tatjh5MOLusvP0w4BZBfn/CKZvWfr5djSsjx9A9UWWzgbCas4+ZxqtkK/YfVTo9NtGiKF
 QdBEwIpynsUTLEq9B9ZZJ9Xr9OQo3GicjpO81uPpf8CtjSmFBsX2fZ13iRO/Q6zrdaZMv1MrJAD
 1fr/tcWpohhhkbJv0BBQZQEx4s/mnb90hlJiQ==
X-Received: by 2002:a05:6820:2218:b0:65f:3d1e:690b with SMTP id
 006d021491bc7-6611793a7dcmr1648690eaf.15.1768584776413; 
 Fri, 16 Jan 2026 09:32:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:32:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: ansuelsmth@gmail.com, Ray Liu <ray.xy.liu@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260102132500.5794-1-ray.xy.liu@gmail.com>
References: <20260102132500.5794-1-ray.xy.liu@gmail.com>
Subject: Re: [PATCH] arm: dts: an7581: set r_smpl for MMC in U-Boot
Message-Id: <176858477558.4075554.2775114830481271619.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:55 -0600
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

On Fri, 02 Jan 2026 21:25:00 +0800, Ray Liu wrote:

> When booting from SPI, the ROM code does not initialize the MMC
> controller on AN7581. As a result, the first MMC initialization
> is performed by U-Boot.
> 
> In this case, the r_smpl bit is left uninitialized, which may
> cause incorrect sampling timing during early MMC access.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: an7581: set r_smpl for MMC in U-Boot
      commit: 7cb79f8d3d55aaadff5b131aaf29aa176828a57b
-- 
Tom


