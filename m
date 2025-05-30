Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D3C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 19:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AC28343B;
	Fri, 30 May 2025 21:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FeYvb1vT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C6282B72; Fri, 30 May 2025 21:39:20 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49BDF83403
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so1523147b6e.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748633956; x=1749238756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdhJAU66Kw0maP9CLzzFGWR2vCB8SL3Q9dflq/P57ug=;
 b=FeYvb1vTIbOtS8uwSOkzDYMJxaK4zSTnZ62/HPGxhcUNjAK1MMBg2znDRiRgJxn69t
 lMXwMPluNiob3+xoMry2hd75NScSvZhKNa34eAaHNVVjb+pib2fyBEF0FMyV0lcRwyja
 bmK9U+6TQnKx4GQYbipv5l0BDUaO7P9ovl1h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748633956; x=1749238756;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdhJAU66Kw0maP9CLzzFGWR2vCB8SL3Q9dflq/P57ug=;
 b=GbrjHNY2c3oyVhKkfnaCtCzld3ixzvEkWBz3STsdLsrMbMlbGJ1AYu7VeG0tTqXd7U
 +TYQhgOwzlDTfCU50amrOzdjgrH/K8J+z2MyKELvUxnbCml7X5Scy34yq9Y2hy7sNaQL
 vFTuK4iB7xIQhfHYg/6JAvE11K1GO4AUmTSKVLTdBPFVqMx7PXSstaAc33+yfY7kQG7l
 S7umxkd6XU2j0RFz0jygGbX14GEFAmJ+A3Z3A8q70pC+fGMa3beLoB7L/bYNkQSqGdFh
 dy70myGqYxoswvJ8BiUrYlsgjuNCI1M2raav1056ezfDsOgFfqo24Pty1bBRyKHCvu7q
 jvOA==
X-Gm-Message-State: AOJu0YyCEsPABAjA7YyCHcOAbTD3CWHYzcQZNjJNbTFDG0YIfsxUIGrF
 RDcppCXCGsZTx0yQuJm0xFs53fg301AmXZ+iMoeXdvmedvBNVLZn9sGYyzsxFwiUS1h6Jr7Ot9z
 6K+O5rB0=
X-Gm-Gg: ASbGncuPmvfXEcBAMYiZtVwsttwqC/QclXD/CM9ElCmB/CbmYckvQlrzwyfaxHZzTPe
 mtD29L9Y5mC3NGpeTxSm+3/NO9lD+QqbASaI9yecFNcse6Xnvu5V11m+CHCCcfcJ1yuKmCXNhhh
 3r4FjBeuFXjBFZI4bFUXHwgpOwTakfIW4Vr2tQwcV4Dfwr+ZllWfEh2zbGbIVbsnNhTElcTz2Gj
 rteE6+hSrzZmaxabe06b4KwtjFaJzw8VgPHv/HCVVsCEAPE06zDMvQPjFQI7qlFEAaWJWWw6s/j
 xR5Bd/guQRpqsLcx1O0AF/xqEsc/ZytCbXsIav6F7jt9SpCHDndwiP5VibIPQ8YRmkU5o7O0WsD
 yReR8I1eGm+s=
X-Google-Smtp-Source: AGHT+IGMEsSUlPr9u428yJoXUvhXMKVocsmId7dQnLeaDlB9u8Q3/N23GjYfHrNu+03CHmObVrHSmQ==
X-Received: by 2002:a05:6808:3992:b0:406:7af5:30f2 with SMTP id
 5614622812f47-4067e6e470bmr2148048b6e.34.1748633956709; 
 Fri, 30 May 2025 12:39:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8267sm491805b6e.37.2025.05.30.12.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 12:39:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jerome.forissier@linaro.org, rfried.dev@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
In-Reply-To: <20250516085256.30386-1-adriano.cordova@canonical.com>
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
Subject: Re: [PATCH v4 0/2] test/py: enable HTTP testing
Message-Id: <174863395540.4062885.7106047673561454534.b4-ty@konsulko.com>
Date: Fri, 30 May 2025 13:39:15 -0600
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

On Fri, 16 May 2025 04:52:54 -0400, Adriano Cordova wrote:

> Enable HTTP server in CI to support HTTP tests in pytest
> 
> QEMU does not emulate an HTTP server, unlike other services like DHCP or TFTP.
> To enable HTTP  tests during CI runs, start a simple Python HTTP server
> on port 80. This allows tests that require HTTP access to run.
> 
> The HTTP server is launched on the host. For QEMU environments launched
> with '-netdev,user' this means that the HTTP server runs together with DHCP
> at 10.0.2.2.  HTTP testing needs to be explicitly enabled with
> env__efi_helloworld_net_http_test_skip = False.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] CI testing: add http server to CI tests
      commit: 3e58991339843faa87c28c7d4caf4318ea2046c4
[2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
      commit: ec1d9f3fe81708ef7e5e45a46564f286404a7aba
-- 
Tom


