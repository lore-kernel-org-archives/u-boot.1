Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A392C5CFDB
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9096608BB;
	Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDOUsGFHorU7; Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E777608D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488617;
	bh=6lIu66eZRApTyIAZ6u6wjznfWy1S6btNFM8zOc2z7Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJNXyriEOed+EQJP2ReYQALvoJCoWM7CpghYpTaL0yYVRm5GejTozAntmzoydM2vZ
	 jet4NYUWmyF8Y+V1G+Wl3BIiGtpC4p6ZaHUk9F9bDGiLIR7bCkpsXOEvD+DTph9VMd
	 zmVmPb7CRU8i9chUwwMcgmBdFhRB0QkJYJlvVOU4HbJqkA7P1WhgpImtYWot5jKzoL
	 LT2MfIMD5VRX6LJgxO6dUr7OA3kFGPDUgNHqf18poni+5I/1FKTpyhT2zmrnNihpjQ
	 58rUx4AEh8qOdpBWWguqyV8bObhzAzxXZiDr0X20ermxHBQ0qsmSk+NLAoP7UG1zlI
	 rNh5kLHKi4WbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E777608D8;
	Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C57B02E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5AF5608BB
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8VgHkN0LDWG for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8DEC9608B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DEC9608B7
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DEC9608B7
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:14 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso263574a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488613; x=1787093413;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6lIu66eZRApTyIAZ6u6wjznfWy1S6btNFM8zOc2z7Ak=;
 b=Fhr/XMMUA2VaiujdhFWfz5eXKtLtXkNy7+Q/QKkzHsmJ8oMwnOuJ1l3hZYSLuowoHU
 7PMR4OZfkylcwkvuWrbpNkElKWtPosjctRXLnq0v3ViUZPF/vt68ZFMQGFXAaWRkjT2U
 Gb5cBzL9iUZF2RlZ6zY0gTVm5iwiDENTfcQ7ZMm4c73v4zPFO61+mhGrtRGx4IeMKQp6
 a9dEeUithTRj9i0+rCVL0fI91OZVt3Bpj4IuhOqn13OfildeKevsZ9Rzush0fE36Uc5Z
 h+N7TN9dP/U1L/TTMqef3v0kh8pZFNMiLturtTU2dn3dMM3/Epf9kbBabUaJUErhFUof
 WCUg==
X-Gm-Message-State: AOJu0YynS+0dSqQ6JUKnDEhVkn0KyneMD5J4quyL3cBKPeCfo5wN/eTr
 3vJAo+0MFH2sfz8WHvfruadaYf25Tz7NEkuykM6czpjIx/vjaPMeZwNyZ7jyG1uYsxw=
X-Gm-Gg: AR+sD10hLYujPHVAYbdPmxTsAoiP9fC5sXslj+tRaXfvl+p9FtcB9AX41xk+iu/iqKm
 z2BdPf9K/KuoLbqZIm2k6MP8H1glzSVc8m9IjE+G4UX50nfO6FdLO95YXguNxxuj6fMWbqluh06
 QMAr/cBHaR4FkzRN9yaY8llGXW3EVFVCg33PGDj/lGv7tEwMtKFlU53s1Ks1kSr29cfY5jalzpA
 pUaOe6fauXHAhlFaSHacW8dltkCR6JV7U9mG85XXbHHuVinIOsYcVs7jHef2NV4niCLTSrXujJ4
 Zg5JKtSVWqQQ6Gg7bC0yw/0RuxfrQn9OjPrlDvGFQGYQN2Y79BxeHz4wvHJTDjfRyui30M40dub
 06G6/aBjvwl+OtSBByOnQgMaRTVhAtSVdZfYrVhH14P7kCe4knDUwIi5KPdoTWgMVJb7gFQONhV
 8jpzOdmf0wc4yLBPcR0jUEqdCjgGaHQIjC4NdbjlJKEzMN/Ew1oOgFURDzXbXjAhA5ObBwnPe4G
 tzijvm47Jrlc1zHZ0ZhZ/UIZP5Bdv4q+xldbM8UMfCngkpElGRZbquMxA1V07K6VyDqB38lbv3/
 Ep/XY7hk
X-Received: by 2002:a05:6820:16a7:b0:6ae:ab01:9199 with SMTP id
 006d021491bc7-6b0b2b5c0ecmr273768eaf.34.1786488613253; 
 Tue, 11 Aug 2026 15:50:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>, robertcnelson@gmail.com, 
 ayush@beagleboard.org, Erik.Welsh@octavosystems.com, afd@ti.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 rs@ti.com
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260730215319.965327-2-rs@ti.com>
References: <20260730215319.965327-2-rs@ti.com>
Subject: Re: [PATCHv5 0/3] k3-am62-pocketbeagle2: add board and variant support
Message-Id: <178648861182.3127030.9409037420226439674.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488613; x=1787093413;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6lIu66eZRApTyIAZ6u6wjznfWy1S6btNFM8zOc2z7Ak=;
 b=I8dEan1G2wJXUtyEb0cSDIsWmjsZwQjEBqXFhQ2EVT1/o2CewkbhHhOj1e2lXc0o74
 AM9qcIbQjbeP2mw6lhAHv6RfUhRHCb0cNo+R1LWoReeD7asceeHrpEk2aVh23Qz8POhT
 tl8yYXETXtbl+JnHzszLouwBHHBpraboDZVWQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I8dEan1G
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 16:53:17 -0500, rs@ti.com wrote:

> From: Randolph Sapp <rs@ti.com>
> 
> Resubmitting with a synced rm-cfg.yaml and tuned diff parameters. We desperately
> need to add documentation about how the rm-cfg.yaml is generated here. And the
> beagleplay needs to get it's rm-cfg resynced with am62x at some point.
> 
> Since it's been decided internally to follow along with what Zephyr is doing and
> make a completely separate device tree for the 1GB + eMMC Industrial board, I'm
> resubmitting v3 with the variant support patch dropped. We will circle back to
> enable the Industrial part once the dt has been accepted kernel side.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] arm: mach-k3: am62: add &main_uart6 to clock and pwr tree
      commit: 6b4b1c8dc4641dc0dfa0aa5c68877eb598cddf8d
[2/3] k3-am62-pocketbeagle2: add initial board support
      commit: c9858573fc9344aef90d03fb271d38964b053a0b
[3/3] k3-am62-pocketbeagle2: add support for efi capsules
      commit: 6a9d070f8bcece0f8a2c323415684dfcac8c2ad4
-- 
Tom


