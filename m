Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14511C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7817981F66;
	Fri, 27 Jun 2025 00:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EqPdLj/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5B282E27; Fri, 27 Jun 2025 00:15:57 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686D282E40
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40aef72f252so522231b6e.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976151; x=1751580951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6jJK1+wYV6mBjY7lvN/BQpKL56Ee45h3kJY+Rzsdgk=;
 b=EqPdLj/QazR+KCLFh0xDsi7QfvofOldb4R5UHxIrSLUhTp0gsK3XWQcfkcXClA9pxA
 t0eOna3XQXbFVPpZnhMVw70o1TIUVNFJglF8dXeGjOPADNk8q0kS6PgBMs9N/CUAp/W1
 TA3h7OZWDrFJ5ZCvKawRqWVW1ktjT0BjDuF0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976151; x=1751580951;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6jJK1+wYV6mBjY7lvN/BQpKL56Ee45h3kJY+Rzsdgk=;
 b=fKAhPjCpnTUBP/jnoWDo9FPtj1kCo+759PSOr2AJ0r4XjPz9j9ufiZkc4laI5XkbUO
 cTPniXCL+nRvLN72jVoBUqSu3RkqAZFBtGpSisr1Ev3BkEetDxs9fcprmGIsvam6G/vW
 Q1oiezxd67twToHXIekZ7XYKYNFhZsCIcpHhR7NGFL/BM0oATvfsccS3AO0faOf+NIbh
 0UVlJfYUWrBfEJ8/fR+DhsDNHh+MAuLCkOihyY5C4r1IHkDx3FXt0n8hASxkU/9IbPvW
 KqE7v4K01kY7/tR/NWPhaEoaQt+QQeo7aLWI6xWCz9J8mWBQL+N5HT36NoZ5qXLF2rdy
 Xv2A==
X-Gm-Message-State: AOJu0Yw1OIjJiZ+JTMgV0oGHJim3EyrroMPkbY8AwvwSzzXoR8nQFaMl
 iXUvI4G3OBtb8k/LSySDq82XFkR+48f7ns4mR7wo+F98rHDDIFHewHKbtSvLAfk9MGU=
X-Gm-Gg: ASbGnctQqwMuKzn2x3WYoCGAnx8j2ZZP3uZzBmX6YNKPCQIDP0mHjf0420XxPJxKK59
 TIxIb0/oSubZU0TJ5LYe9QMat+QWXk1V3gqpI4bcfRpW8A8iihf6aj5GCa6niwi8K+Cg2KPInIC
 gMHDkLw/40NCJAddZ1jCKf6wIylsGvcK/nEsRkDbW2g0MZT2j+enwaPlj10mg2/tAH64cIqkRR/
 lUvqPko5ycfhDJszmWw0e7JQ2XVH3mGlDS9kUY+Fvd3+O99J8ABaoPVtTAoAsEp9YGcbFK/81rV
 0z5r6ma+zWjYDNIMJgSfmi6rZSHA0w5A3SANb+5yA/Ju/GWmGTUlO+8f7KIuraZxGydOpjNFNCf
 mPprrclYAaS/DIbveZAm9tA==
X-Google-Smtp-Source: AGHT+IEEcub7zuAxF2y0R9cWT9JHKXrymxl4IIsrkrMQhTBnMlkSPZiK6ZwcOpvCLqZK2aBmbxvX3Q==
X-Received: by 2002:a05:6808:13c9:b0:40b:315b:3775 with SMTP id
 5614622812f47-40b33e4bba7mr855316b6e.34.1750976151127; 
 Thu, 26 Jun 2025 15:15:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, robertcnelson@gmail.com, 
 ggiordano@phytec.com, wegorov@phytec.de, francesco.dolcini@toradex.com, 
 jm@ti.com, n-francis@ti.com, bb@ti.com, vitor.soares@toradex.com, 
 contact@paulk.fr, Oliver.Gaskell@analog.com, marex@denx.de, 
 jerome.forissier@linaro.org
In-Reply-To: <20250614093717.2479920-1-u-kumar1@ti.com>
References: <20250614093717.2479920-1-u-kumar1@ti.com>
Subject: Re: [PATCH 0/2] malloc size cleanup for K3 devices
Message-Id: <175097614973.1909185.5305463436081157429.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:49 -0600
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

On Sat, 14 Jun 2025 15:07:15 +0530, Udit Kumar wrote:

> Many boards based upon K3 ARCH overrides default malloc size to 32MB,
> as part of cleanup, add default size of 32MB for K3 ARCH.
> 
> Udit Kumar (2):
>   Kconfig: Add default malloc size of K3 ARCH
>   configs: j7*/*am62*: Remove malloc size overwrite at config level.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] Kconfig: Add default malloc size of K3 ARCH
      commit: e53d46393eacf6cef51f8bfe9ed730568b02583e
[2/2] configs: j7*/*am62*: Remove malloc size overwrite at config level.
      commit: 27c0b05855e0b19452fa0d57997ea5c48d2435b1
-- 
Tom


