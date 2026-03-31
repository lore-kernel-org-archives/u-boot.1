Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3409410F9300
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 20:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91E38406D;
	Tue, 31 Mar 2026 22:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6GCnMaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE6683AA9; Tue, 31 Mar 2026 22:43:07 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FAA83F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 22:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67bbea1e090so3599635eaf.3
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774989784; x=1775594584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9Qp27a7J86w9rL0LK/+JCloDIYY9M6qhZ4uCZnMxWU=;
 b=W6GCnMaJqA5AlVEsCyK07Bg4BNXOYytTPdAK8fHDk7xBcKQO05hmPZ5ramK1lNzqYl
 7r7ygIuqsBltoS3SYS3kmOfnIK6wwFMHDFb5F94HKUNR0iGseImjmSf/mlfL+HWMmpt7
 +OQ3tHnvZQPFmVIawdz/ASdBBQRFd5E0H7NjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774989784; x=1775594584;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9Qp27a7J86w9rL0LK/+JCloDIYY9M6qhZ4uCZnMxWU=;
 b=Ulk2tgdNLZRF0ygSaM1jFpeoiKS6CWUKrWLUvT6No5JT939tFHRmrAo+pX4g+b3Jjq
 lMtRO+rY9HB1lL/3OZsamwEy7DfZGxE0QocHZRk0DBdeAq9z2h0x/e5gif+uzab3OE5P
 ZW6hBo3immCCHvrWjGnWs1VH7j8PQJMm1l1L5chwxim1IO0RngOxc7f0IooqXu/wid8L
 5+SeLbl300boCpiFWhbInsiPkCLds0dT11Ep07SngjkDli6Ct/xdREjaEeHAE6HSvSx+
 UC/rs/EPtRvwIgLqBcqDwL+kDSHQ/6tgOpPpE2coChjaw+iHsWnUFUGz7+EgtA2Lwit5
 aKjA==
X-Gm-Message-State: AOJu0Yylh1NNv1cU1PSNAjeCuX5eBzUWqvaeh0RxMy5+PStN5Y4kYLfv
 4I2miBl3ZB6gNUafS//2xRSKHXlL1dXYFMi4+4lgEpA+2iZUpuJdbux/bOBzIWviuU4=
X-Gm-Gg: ATEYQzwMBtK/1gZ3TbJyItGhbw2ALFbdIj29A/Hs86bXeyzIm0TqxxlIaNUp3hSuurH
 DvnrF6eqLyNUN6JZ8o0P139UmMi43ImdCBgDWKQjbCSPYjxmMPk5z2iiA8o9MJlIEjhCph8ku92
 ZzX3teAoMn+dkUEYWSTont3tUxJMl5rTt5Y3hlkDVduuqFBOk1Fcz/3T/XnNJ8pEL1+vDr+3Wxp
 eIRGMgJlZbln3gnbLqCgYXV4Y8E3rVYnKFMeDo6F4zubWMJTcXYejZLWNRyoqz+9S7y6vH/Dq7M
 aqAEgO2nvhtHBJC0q15r2egLQQ28X/AQvSkncufuWPOGsy7Jve/y9JRr4eOn8aDLS8zFZGhrxkU
 /AvBhpX4IJjt0ZHnUTRfr/r68kAoaMKg160LaDh20NIXPo1c11/ZdWjoWw3tRju6NUEvVnh1E6H
 qjYXDOT7mXfYLlEEHQ+kvmFCnt7MYVsbdiAQ4jYurH3LPn6dzUIopfQg8MGRZZn8D6Sp9yJYB2d
 eo0Klmc/lHrBB5iwxIEWIpzykMofwiI/pvbtl/2isuBkVs=
X-Received: by 2002:a05:6820:608:b0:67e:3f0d:4238 with SMTP id
 006d021491bc7-67fabbf1152mr440616eaf.7.1774989784292; 
 Tue, 31 Mar 2026 13:43:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04c889fesm7252811fac.9.2026.03.31.13.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 13:43:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260317021756.196402-1-marek.vasut+renesas@mailbox.org>
References: <20260317021756.196402-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] console: Prefer currently selected serial console
 as stdio device
Message-Id: <177498978362.1321462.11340156879389414409.b4-ty@konsulko.com>
Date: Tue, 31 Mar 2026 14:43:03 -0600
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

On Tue, 17 Mar 2026 03:17:40 +0100, Marek Vasut wrote:

> Adjust the scan for default console stdio device to prefer the
> currently selected serial device. This is useful in combination
> with CONFIG_SERIAL_PROBE_ALL=y, in which case the system would
> instantiate all serial devices as stdio devices in the order in
> which they are listed in control DT. The currently selected serial
> device may not be the first device listed in DT, in which case the
> current console_init_r() implementation unexpectedly switches to
> another serial console after listing stderr using "Err:" line, and
> just before showing U-Boot shell, which is not the desired behavior.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] console: Prefer currently selected serial console as stdio device
      commit: 32dc2866e020edcd89b26366ccb8fa7a2ee2859d
-- 
Tom


