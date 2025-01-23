Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C58C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5049801B0;
	Thu, 23 Jan 2025 15:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wiLlJSZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68C880214; Thu, 23 Jan 2025 15:21:19 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 837DA80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso10356645e9.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737642077; x=1738246877;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znzIMYlUDZe+44qt0fm/tsIrYfaNps8nAT/TTUfqKaA=;
 b=wiLlJSZJRH7Lc1qDXgmH1U53rjVq2ttaVqdPLa/NjGayBNbKTyGNhUA0Jhno1JUjCF
 CcAnociqbH3QEiNlV9+Lkgkv36MjFEJEmyf+KLU4c/1gjZ3QsoPKto2yxcdRVqWiGy08
 moYOgHwX89lMsz9eUJCPXqZBwafqD+L8YBLAuHr0h8RKxY+jh8T5q5x69sBBuieXJz26
 VBVU54Ns8lo2kOYBN0tAfRcXfxOh7zLCmVwcFjg0UDjt9BNxMDFrcctbnWV/ZgX3jXLB
 Bse6rjzcfBRqlDtdOgDogXBFIpTSh3PkA6FIWz5eJE2Bq7BiUb8RLPEWong7XWxHeen1
 8U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642077; x=1738246877;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znzIMYlUDZe+44qt0fm/tsIrYfaNps8nAT/TTUfqKaA=;
 b=Ka5cBlzr6cwZ/kWV7h82KGmGPpYF2QqohBhp0rM6s/R69FNHLc9ze6AYB9GRRfhxvK
 PSoLJQGiSzrVAQM+lEFNQNTWmRB7STwb+IXkh0LpNxqIdQtejLhnOzAuVH87daTINNSV
 hdZ2uHF3jhmu5JVqHPEI2dm9qLEcf4eZYd3fDg3TpZ19UjwOpzV78ZXXGDuQyedXS0xm
 EkDpaDei9B+JDv+xRdhJgQO+6HG742u2FyFmpqlwbz5vNHNzU+4UX8Ys0KfQ2AgcPEFY
 rmRsWBNbQrbWkTzidHJmM1NB9OEAbuIO9CMjQu4zgeJNpK4Qz80BNaZOxOVQCrk7DQQZ
 9X4A==
X-Gm-Message-State: AOJu0YzmvuIDGPTwJqVqAaVA/1AoVk7RayZ5+YRIN/R3H383c79o1jJU
 U3jMBPDw0HIG5R5qr2Xf8dNEc9T4F7CM55dSaXDfzKZhm29fFXLS7G9TcszEI44=
X-Gm-Gg: ASbGncv0dXW3kZFmc5mjlLhHBpUEAZhPNQR8O7WfUrIRQmm8F+jm1ck/AluHAgab60L
 uthk9Sjuuiw8LnSiKYnP21SSsY3ySRr6rOq5sIaWyPqYFviJH9gl/DAtQDYkjpFNt2YEyu1F5dv
 iDuGsSL3wlR+NN2If85F80tUTDcutKd9l0zuCQOlPPJ3Gpn80icPGFMSnwEZ4B4448D9flGxRUF
 lKgqpl0KbsuV39FYw16cdRgMAck8XAecIBUI1rRppjbPT8dXzZ1zHye0qzwOBNzZ2375OJmvNZS
 jrKUPcIcco2QfIOR
X-Google-Smtp-Source: AGHT+IGOz8bvYhlmWvKj/QagOS0QfQuGGNHoHCRJcJ4+7iW+DrcA5kLlMx8DtB7tWpIcGX1KL6fDUg==
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-4389143145bmr250866755e9.30.1737642076874; 
 Thu, 23 Jan 2025 06:21:16 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31c2aa6sm63253385e9.32.2025.01.23.06.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:21:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250109112854.825204-1-igor.opaniuk@gmail.com>
References: <20250109112854.825204-1-igor.opaniuk@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move myself to reviewers for avb/ab
Message-Id: <173764207524.268059.7338662885808832920.b4-ty@baylibre.com>
Date: Thu, 23 Jan 2025 15:21:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 09 Jan 2025 12:28:22 +0100, Igor Opaniuk wrote:
> As Mattijs Korpershoek is in fact doing overall
> maintenance of AVB/AB code, move myself to reviewers.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] MAINTAINERS: move myself to reviewers for avb/ab
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/af3afb70fc5e6cd39ceec70e1224a9a8ff4ab24b

--
Mattijs
