Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FC3C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB7C83692;
	Fri, 18 Jul 2025 21:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c7KXb2k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE6F8367F; Fri, 18 Jul 2025 21:43:26 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791C983537
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2edec6c5511so1168738fac.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867803; x=1753472603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v8ZzUZw5z9Dk02er1+BtjX4cn73/TlWpxaJGJBHHuZo=;
 b=c7KXb2k3uVjnW02IICXAfTIwBNhw3r5zByCSAFelVFc6ZwS7ECABmy6s1s1Rs+9aGz
 fPavm/bQVaDFO303kBaG2dv96c9q7Ri7AU1GXGnke4fYt2hajSes2P7s2RrG8MylhkT8
 GWIUeACPbfnTV3+fLX7Hq2Q1QMXjvzJgM7+qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867803; x=1753472603;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8ZzUZw5z9Dk02er1+BtjX4cn73/TlWpxaJGJBHHuZo=;
 b=byJtDBS1RT8jiKcjXmT8bAXC8idDb1KSS2ShupP1bX4a1O2XP+59lRrqdJdahEjGaO
 1bZrP2Tx2YtAv0IIXeBwYIZVmdqlwk9I/DBuLMgoi/D3R9n9NIWzn/ZRPkaxFwfs8o/V
 DFGS66j81V5nHIhjnu3pJdeyZes2xwfEMtyrCgUMBktwfaLEprYcQHDaRjtMw27j4r0D
 Dm7Ir+xWkRg9k7+rDBj+5Atvjbkycrk1x6bJ3vxYGQGmLgL6Q8FMeJyxDoDBeFiTdeo9
 EJCvZEyWjHt7k2HJHzgpujgJHV5MOiOt2lyH4wk3QT578rCEL7zC+5ifq/PFnW/Z7vl4
 Xnqw==
X-Gm-Message-State: AOJu0YwV2yC/V9+BhPnRenBa6DUfunn0YkfK8HBPQ4X+VJCcVSDokByh
 Z9n2cQ8uHvzYO8hQHGs0mwrWz3Fm3LAIItDNMMhIAQ4EQ7odbwQr19Vepum5Ba74etBX7W5ZCE9
 0L9JB7ZY=
X-Gm-Gg: ASbGnctTGLaE7v7PMMBkGNgAvN5EBmw9Ak2wnyrzwgTATJBk6BFZCrLTJ3UQ4TWm73X
 YZP95LocDKgams75B7s4cPAxOLfqVVAomZ+VhRAM1FeBBb7Ef7QYDku90NW4ID/1jA7dtmuSrr9
 kpFCJFNXQCcGwnVX4o0ubvZXJErXtvzu3PZJAFvUAikesQDKY3uTiA7rZtjjR4yKfxFQlsBxu1N
 RLQfzQnwzUgg98OixQXM1Qb8GMd03MDOo8zmSyDbLLKlMgV6/iJLPeZWO4xptJRD0oWdjYTGv7g
 Yj3UJsXEarE25jIsU6Y5Yw8DfbCIKeX4Fpm7d7gCKYH0uGccRomzetKK3tcVeJCy5U/8IaY8f1D
 Ye75vMHCUyzPHxfXrGz7B28uTKFdHl5ZyrvnpaCs3d+ZZEDzxMI86vio=
X-Google-Smtp-Source: AGHT+IHxz3i08g3USwkIed/4c6p1HgifbIkkWbEBrAw0qWE9E09OrG4i9+D+gwDICvQ97pBgghuXzg==
X-Received: by 2002:a05:6870:219d:b0:2c2:3e54:553 with SMTP id
 586e51a60fabf-2ffaf54cb22mr9276433fac.28.1752867802996; 
 Fri, 18 Jul 2025 12:43:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152009.2225445-1-trini@konsulko.com>
References: <20250711152009.2225445-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: Tighten requirements on IHS_FPGA driver
Message-Id: <175286780151.1647311.12281259165815236600.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:21 -0600
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

On Fri, 11 Jul 2025 09:20:09 -0600, Tom Rini wrote:

> This driver requires that the gdsys legacy driver option also be enabled
> in order to build. Express that requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] misc: Tighten requirements on IHS_FPGA driver
      commit: 14d20133a85b63215e7848fe9f84bf8504e0df47
-- 
Tom


