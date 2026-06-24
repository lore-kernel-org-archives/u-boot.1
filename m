Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BFCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67903849E5;
	Wed, 24 Jun 2026 22:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GlLzJQLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75621849C5; Wed, 24 Jun 2026 22:49:27 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C1C849CE
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-486621f0adbso999471b6e.2
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782334163; x=1782938963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x2E/5cS8I9PO7P7kTkfxi9FoBrWSUxjuwtOGU2S+Co=;
 b=GlLzJQLm5CdzDImiSY/4ZBC8Dg67mm6k7GgQMUo/vNwsNr+v8/U4BIwEP7DTahHHTA
 +zrjfBjDT6znoHD9PlM3sQvPE2L7XTZ9/hV81miE7KcKL5d0tHgZwyRbjFVemmi0apqw
 3XIyuhpWI90kKkGy292mVh9t5Z4NCYhrPw4c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782334163; x=1782938963;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2x2E/5cS8I9PO7P7kTkfxi9FoBrWSUxjuwtOGU2S+Co=;
 b=D7Unv1wH5euW/VLM6TevQlxaqLbpsuehYaify8p7xOuVBY8TCWx5PLcPFAP0bnDGxR
 0ijDf+ECd/bPkJQcFIpsWcNK8WHXm+u1zUnxqNP2Sgvp0rwI3dkCHV5pxvObWv0fn+PT
 QQEV071JfBqj+KJIcGzYiK0dyPdHM53i/+KqD2+KTqJybx+8tmJG01e/uR7zHdUC+F/8
 9ZPefMuFb1d8yAhCqLkmPjBfajmN3nKnoLbOORyUWNVpGlS5LMT85iOCsAcOzVjgGTJw
 2IAdAEPt6jBcMNUxMR97jZAZMqAWYwEcinpPR0A0YqPRwwAoxYRIq4w8jy+KIs2PHjHC
 WAng==
X-Gm-Message-State: AOJu0YwgseCPRzwstGJdGNQklMq/WIFTYg4aOi7GtAVVzPx1AlLHLNUq
 JmjGtrh/e6biCDOac4pEyEZAEutYswMNHRuMjZOohQpDB8S0kvBOWo1uLWWVS/W8/OwB8klVFFC
 RccMWz1c=
X-Gm-Gg: AfdE7ckrYcUoLCF2fCKF57g8KlcRr9T+ZY8vqJvhs2UO8UOcCLJDZxXqud/WuPBa1IP
 nult0dCIHZSCngB0SWD+TCSgVIHK62g1XrQBLssDLuSrxRKz+xQk1X651T7qXfpE85plLfwDHhS
 qN3WQ+t57aGWQI25x3NES5vaoIQ+MAUkJxxDtlfxNTRi/dlphHniPj1Su7IDU6K1ZyQk7Yf9iWH
 Wf2/HT9/S0q2X4Bbmd5uxU4G1ydplIbO2KE4k43uSSjSMHTkiTKz3PJkcUQ5SLRf3Xjba30dmQk
 fPLhMTHKlBFyQnIDnEk0r9TjQB+rR2oeQN4CckMFb2qw1vl9Y/L6uZY/5vDxg3M+VfiIyKe6xi4
 HT35NxPpQb+xC3a6gtOISA2n1OybWAzR6PRXxEoJibkDQ2iaKN/pLsDICFOTITI/QNM2ZEoH6v8
 BkItsXUbCjpOgD4UKHoCpQdRkUoxxgjWWyVKtm1eK+vX/PUiPOTzkQ4iaE2BpP/fygXjF/KIQ=
X-Received: by 2002:a05:6808:4fd1:b0:48a:ddd4:6758 with SMTP id
 5614622812f47-4907719ac84mr3815676b6e.11.1782334163639; 
 Wed, 24 Jun 2026 13:49:23 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0e5e53sm9020733b6e.8.2026.06.24.13.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 13:49:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <aw33sgdo3pwg24enxxjyu6conersjsielblba7oqv4lx25eav6@k5pvk5uhjylu>
References: <aw33sgdo3pwg24enxxjyu6conersjsielblba7oqv4lx25eav6@k5pvk5uhjylu>
Subject: Re: [PATCH] serial: cortina: check RX FIFO status before reading data
Message-Id: <178233416289.3662130.9885296235555316958.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 14:49:22 -0600
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

On Mon, 08 Jun 2026 18:46:22 +0530, Naveen Kumar Chaudhary wrote:

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


