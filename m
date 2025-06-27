Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35A3C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C61281F66;
	Fri, 27 Jun 2025 19:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aGKx48Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD16E81F66; Fri, 27 Jun 2025 19:39:50 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0266080C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40af40aef06so1672455b6e.3
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045984; x=1751650784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu7YcvAj7wO29ivnGDfglGEy+LEyMrBWJACXx/BvAr8=;
 b=aGKx48HnReg8yNJ2fEI1ByPjVNGnFGWq28q7J08iY7+4d1MPm3Ewmlt6i3pK7mcqup
 bs+c9o8zXbSMM6eqHX9k6WTTdLx/yj88YNePpE4D7MRAktfNQS06bD3V2T3nq0RGXbkJ
 wxKfxhzPxaiLEO4AB4pQUUyDCxzEze1dvIXkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045984; x=1751650784;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lu7YcvAj7wO29ivnGDfglGEy+LEyMrBWJACXx/BvAr8=;
 b=u5nac03qz3vKdhLRRlhFJfwXy0Y+2+zljzKGKYEf4HeIUvaJxT2ASe5DScBWdlEfX2
 xiJJ8S7AD6VNQLq/KbMF+0AYCzkkSCM88dy+hXy3RlQvNUl4LAdH9B/2Cz5DFQcu9qjj
 wL5itqL7a7vkpEWyInNgA4kuuJTQT64fTA39/YZXQ1NszcL29+5fLFs4RYfR6F1dc4J6
 /51DEd8wSFb0xeCU4UvDfOxz1QLfSQhW0RJhyQruCBRrAP34tdOaxGujHzMypNpw46g2
 ogQPyr2AJMqX0FkGJUaYK7dLym9Nomw4ORXXXU1Bhn5nzvPX0u7dYJv9hhKjuL+/uSFU
 1suw==
X-Gm-Message-State: AOJu0YzYmjVEFqMb9rgMhxBBXT+1sWYQHC+48DoKmD1B78hvz0OESxEK
 J6MB64on+L2DZpYRjPmfUm3yIyfAnCtU8YftdnaPWYoDqSFNPdlNow78VbopZnWmvXsueeGYXRp
 iw7at/Rc=
X-Gm-Gg: ASbGnctctGex5/bd5r7eKs43NTIM6rIjFJcLMEx4NQSSGAvOwSz/prvARRcrDtcZPjM
 VTOWciPB6uWEN8D4LM0dLz0cNsMY9yG4/vo2F3L+lG4NRgj1ot8SM6q8QgAEhsX5fcd1cvsvppR
 N9J2Pg/OF6sCsVWLUgA/XvX8Iu5xRrwnTELiZBJJQ8zioYp5TkdITjxINL2ZQTxXbZTcgrL/F+I
 DCjn80lrlCrsZgfLdc0itdNzvWyisBAM0kBM5Jbil4ubSTcl/q8H1k9+pFLFylZsZKMQdnYBc83
 5cTD4rm7KMSSPHr4i9uhkDypjhXJL6CdeYs5RGWBA4A5WAdjxewi08qajQcOTqW3os0KFUW1JUv
 ydXcYhvpPOjFgD7iKNC4VAA==
X-Google-Smtp-Source: AGHT+IFoYjCNhoZ/S90Z97HtmvXfWQJogVw0Yi7jmL2m2E1Es335Y0EhO00EwrgDa/E2xA2uyOqJpA==
X-Received: by 2002:a05:6808:2119:b0:406:6e89:49ba with SMTP id
 5614622812f47-40b33e6e4d4mr3018784b6e.33.1751045983763; 
 Fri, 27 Jun 2025 10:39:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
References: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
Subject: Re: [PATCH -next] test/py/test_mmc: wrap multi-argument
 printf-style strings
Message-Id: <175104598278.3877702.15567324233309562539.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:42 -0600
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

On Thu, 19 Jun 2025 06:45:05 -0500, Bryan Brattlof wrote:

> Newer versions of python will emit a TypeError about not enough
> arguments for a format string:
> 
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_dev - TypeError: not enough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmcinfo - TypeError: not enough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_info - TypeError: not enough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_rescan - TypeError: not enough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_part - TypeError: not enough arguments for format string
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test/py/test_mmc: wrap multi-argument printf-style strings
      commit: b14b3de65282e82b1832d53e3ee04f693c6c39e7
-- 
Tom


