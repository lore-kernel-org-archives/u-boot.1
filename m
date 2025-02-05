Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28759C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 23:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323FA807F1;
	Thu,  6 Feb 2025 00:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2XhlbYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF25807F1; Thu,  6 Feb 2025 00:15:28 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68728033D
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 00:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9cd9601b8so409412a91.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 15:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738797323; x=1739402123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llJmszSBs+PsN5wfvpQm8DI5fYKvRLTET++8ia9LWHM=;
 b=p2XhlbYKXZbUkLV06SS8po5crluMRPq3FFlGwT+tvl4bGmca2+fW/abaMjEysYdbje
 6eCjGtNn0OH2rU5HZR5S3yXQB/edJSOfkQf1R6B9zjIX5RvxzqIZawmMsYJ41XN7nlbu
 VmVZ4PXUkLsE8UJLFDPXbFf+AoEjjTYtNQb6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738797323; x=1739402123;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llJmszSBs+PsN5wfvpQm8DI5fYKvRLTET++8ia9LWHM=;
 b=Q8RfpnHixtFch9EQ18378oa5UEmUZe3NZ2ZfHkBmHCwu3F/wNW2yG5K8PDVd/Z6wrs
 ISMW9eR7/dvbDurgWUA3+UuNXoXzl8Qhx48qIPQMnSUSy2NassvhrxSJNDkPBmFDqsmw
 g7haa0dKpnk8VJz3fhSRpp+JICbouYlIjBSS9Mb5Qgabws0wCMbpic7R0rA9SlszDlgs
 mhkj3zJ+Y3KH5d/0hyApLovaWF1IeRhAhfW5SMDi1i6lP4S+Y1/uapT2IGY1y5Tw/vna
 mgZsbQyPeGHM8iviEE5IwmcXzAWCtFhfkZ47LZGU4kV3SHE9uDs2mib9WF8+oZjz3mwS
 rpvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vt9atUdfVwD4+Ni/JC6/EAEtsss3QNG4FGDB0i97ibTum3kKkthto6ndH6+jD5Q7X9fpx2c=@lists.denx.de
X-Gm-Message-State: AOJu0YytwmhAsGdHpbcj+pdmx5mPdQGVNRwNUxcMa3BtIWyL2OqBpsYE
 NgZhDjv8lH4kYtK1vm3hKP5+M6CiFbI04kBxjOHUofaqXoZusb8B3uk2maDqs1BV88VJT83R1Ba
 d
X-Gm-Gg: ASbGncv7LuqRXLSnOT2P7O07953IPl3c7p+Iyd6KEr1KiMPGrHk0CNQaP+ZcUDp5sVC
 JlUVkc4dPZN38FpHcZjsPhqTUDF9NobFz/LZA3Yx9U0b7f4hDLe6m9CGewRcwlXUfy5ubD6HzCz
 uuAvUxE1d6QgBc2HR+T4pfCxGRGDPUc5E4qGiGtH8NmhlAS/aNBnL/cxdmHzqlLMDWYQt4DTR9U
 3IGq9HQ7cOVCuiaBuvwbd2cAZjHGQTd4lfqFTtEAoWDIZplnFhgPIXfU8YBPfBSnahd+GIJAgWu
 +YBeMX89+msGhQ==
X-Google-Smtp-Source: AGHT+IFQX7Ysm4aOOwwuBXFdcYlBUa8FMzPq0B6QnVVoiHuwPWB2mpLY/idVA/3P+GFQFasOdImx5g==
X-Received: by 2002:a17:90b:2358:b0:2ea:498d:809f with SMTP id
 98e67ed59e1d1-2f9e08203e8mr6239646a91.26.1738797323427; 
 Wed, 05 Feb 2025 15:15:23 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f26e5sm2622901a91.0.2025.02.05.15.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 15:15:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: 1425075683@qq.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
In-Reply-To: <tencent_576A82BB81A6305F262F7CF07BE2071BD809@qq.com>
References: <tencent_576A82BB81A6305F262F7CF07BE2071BD809@qq.com>
Subject: Re: [PATCH] arm: kconfig should not display the STATIC_MACH_TYPE
 option when SUPPORT_PASSING_ATAGS is not selected
Message-Id: <173879732147.2019786.15796875191285284257.b4-ty@konsulko.com>
Date: Wed, 05 Feb 2025 17:15:21 -0600
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

On Tue, 28 Jan 2025 21:31:49 +0800, 1425075683@qq.com wrote:

> When I use arch armv7,
> menuconfig shows the STATIC_MACH_TYPE
> option causing me confusion.
> As we know, this should not occur when
> SUPPORT_PASSING_ATAGS is not selected
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


