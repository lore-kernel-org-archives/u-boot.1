Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53535CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED5A849ED;
	Wed, 24 Jun 2026 22:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="seJyou3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7324800AE; Wed, 24 Jun 2026 22:49:25 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FD68460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e6e41cf7aeso791849a34.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782334162; x=1782938962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8WWY5Tw2O3f+tCNdlj9yBKW2W0RbpMhEzNh7cjEBLs=;
 b=seJyou3aRUtaFO5Sf7gfb5qAZq+LhHOwv8md2X2orVtS4xgi+wJCrHVtRP5l9v2Ndj
 n/060YVyLYn+z7FkqD2CsoKXy6wTy9GLNeGqdXU+B/pX2jmbqp0FUpERWi56LmFV42xY
 0vGaEX9U91Iud7jT0I2BOxbBado4fcQr0bbUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782334162; x=1782938962;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8WWY5Tw2O3f+tCNdlj9yBKW2W0RbpMhEzNh7cjEBLs=;
 b=iv9Ahl7HQaX/lkVOgp0ybFDqCaXMEsyVU8AGN9Wf7/sBzw7nv3E56DQq3goRGNYvn0
 zbAe8ZDak8OeKpyPx/UD761gSuSRJlQ2BJXHIUo1gyfTektB7zkNdiOu3HEnCJ2x3J9L
 TbyDPQW01ja4OZElAPcJHT8lhvdXmKT3Fp8BcyoyXuIJ1lJJwmHrp/36tGiKZ906fwEl
 0KA5W88Uft4yyRaymaWY9uJ+MeirdxX2x2oaEZBJCD0PjUGteZPBgkOHcnLU1rHg3eIE
 h7Nx3NgFd+H7uLCzDsoVt0mHtuPumtjYM15FbAD5QZsuxLDfyR+9XakbO+BQBmqeHahk
 t1dg==
X-Gm-Message-State: AOJu0YziafvP33vIFWkM3E5AXTmtr/whwo7z498GnSDGi23YBPpgTVBS
 wlyeiwNdyyLIAdUS6qkgp6TdQ2KunvQHG58KRlPvsOS2ZmMS3p13kU6grZkKTk2szovUNGT6c7d
 LmAcASR0=
X-Gm-Gg: AfdE7ckxtrCOD6zBIQQnb+0EHHhJ5htpY77X/OjmP98uP/nr8u4cXS4LDGnipbLVvQ3
 YC9x38ND15Wn1w+nPwMbiuN6NBaJs0DIJRzDPbOzv2sJPD5q2JSBiSuf0Ld36UalqDV+80x4LTx
 /EEQ96/1RjEU/tvX/nCNRtmUf4wslhYKBY7qiF8hNJbtan49JR/nKoy8OxsJDYoL79mXMs2gWva
 PmxLfHO3rJp43y5To4586X29NMBBSiam0iFVevWiORc4MjfA/WGNAkvNKqVyMse3Yufs1nYlFma
 NcdBoHOkLUGHbmbL8biBVxlnWEHtIRyoeoXlKjh3RQS7PptvBA83Bs6ALn03oLaZm+F6AWN+lCo
 iIJvkUzSdtr09+COO/K+O+6quQ4YDGyIvHNex5Rfcyqn3aLCosVkjKYOqFUHkL83Ajog+P6str+
 9Wf5hBZ5F8/Oq5To/9/p/Xi/MU4lvVkpFnHduyESLHpIa4Px/86xZWGl9df5uIHZfPQSUh5CA=
X-Received: by 2002:a05:6808:2381:b0:489:47d6:eea with SMTP id
 5614622812f47-48f27a2bfa1mr6088090b6e.11.1782334161800; 
 Wed, 24 Jun 2026 13:49:21 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0e5e53sm9020733b6e.8.2026.06.24.13.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 13:49:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: alex.nemirovsky@cortina-access.com, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <wsktuup6zqzu7hr7f2asm2gqkoo6pksdft7f3ff3h5ek3slyw4@3dtswkklwpu7>
References: <wsktuup6zqzu7hr7f2asm2gqkoo6pksdft7f3ff3h5ek3slyw4@3dtswkklwpu7>
Subject: Re: [PATCH] serial: cortina: check RX FIFO status before reading data
Message-Id: <178233416129.3662130.894471981259282612.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 14:49:21 -0600
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

On Sun, 07 Jun 2026 21:03:43 +0530, Naveen Kumar Chaudhary wrote:

> ca_serial_getc() reads from the URX_DATA register unconditionally
> without first checking whether the RX FIFO contains valid data. When
> the FIFO is empty, this returns whatever stale value is in the
> register, which the DM serial framework interprets as a valid
> character.
> 
> The DM serial framework expects getc() to return -EAGAIN when no data
> is available, so it can handle retries and call schedule() to service
> the watchdog between attempts.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] serial: cortina: check RX FIFO status before reading data
      commit: 0bef438428ca0118da2ebb44493d5d2090cb05a2
-- 
Tom


