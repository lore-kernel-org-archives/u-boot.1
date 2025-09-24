Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB6ACAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 00:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C2F808AF;
	Wed, 24 Sep 2025 02:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6r9OJJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5080B9B; Wed, 24 Sep 2025 02:28:07 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE5580107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 02:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74382048b8cso4940672a34.3
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758673684; x=1759278484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyb8PyljkRkYEgaZqobQmrHcwNl301qhzQFG6FB/HzU=;
 b=b6r9OJJgLC7Q6ZiYNS0XggHUuWd7MN4bBRFHPh96V3yRZgR57fOYkZskl8ayiA9Mkl
 vOi/Uou1+JqCOyKtz6haTlHQsSmyNocTNb34ZDMpNC+jVHQ4wZnvBFomr3wgs233kUEE
 TcilNl/swOua0z4SUxlF3Nbg1czT3UcSJbpww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758673684; x=1759278484;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyb8PyljkRkYEgaZqobQmrHcwNl301qhzQFG6FB/HzU=;
 b=gFlYAMXJ3DBlZF2jLvdWqnkvwpq3Gm1OhKX+LKuf6LsFMcQECMALwQOv5juGQNJvVW
 sQJjM/uSqdf9xTdnTku7+ZC95sysSq1nz+bKmXtkKSUG/eQSmvMYIeRsk4z6d09pkge0
 8BjXb37nDbHviyR6+LDirMEjpEAS6QLiZGDasESudCEB5s7PgulzYaAsDvzTWmwmcGed
 b8JYkEhnfq0ECZ70hM1ZOTfXmmmxETopx8Un2GEK4Y1Cd6ejsdf39oYF/H01xMmQyq8B
 4NtDQ7XmrtGCS9LbUSmaDIwNYj/9V/31ps+6q/FyLxpTmUdMpcDDwcZZ89UW69nd/Q4X
 zHdQ==
X-Gm-Message-State: AOJu0YxC+iGQdMEdQ2oKsT2SZc/4cZ2KgHlMHHsBr5fzVYPBULj3D9SU
 z5mk9QKbJmiCqgUht2vKo0q9sTCxFYExe9iIs3QCdL0/oOTQapzYWbUB0uYANpbr80s=
X-Gm-Gg: ASbGncuVlhBIj79+r8lnEM+5Vhusippkiz1hW0Sfb9bpsWL++bmMy2bHm9kusM3i6Nu
 zD/mKAmgN9ZvJZev1nfsGzSQLv1btC2RnooLTBkNx3cZ5hGS2ZzCy6XP7rnCyIcwl7S8bahlFE2
 H9WKjtpJSPFfKRfElITAxhKL8WtgEWgVoqqufz6zn4ldHj0toJcjIdL0u7ceA8Ow7XeeDxNZl+S
 i7rcRFk2WZUHSGhfdUZIGVRfoP2JvyLKpUKLBVZB4rga9YMe7+ds5G66tkkfzV3gR2OO36lkEeV
 NtBlmCABjyU94TjbwnuxTEJA+5HXg9czQcvZTStFUEHyqRWM6PAXiUG5Gb4snUuSZBg688LsoxC
 nkKchod78NwewLG7yiTjm34t/vhWPgdiuWgHVibNM4CRGcBKdwUGHQqY3KdSW3Y9Aaw==
X-Google-Smtp-Source: AGHT+IEaMmsGxsv8tB2bBQPhhSretoHvhsTa7UNAJz+WCmmKwx/eAbm8pcMKc2x2uUEvcB0tD0tIxQ==
X-Received: by 2002:a05:6830:6309:b0:74b:3f2:134 with SMTP id
 46e09a7af769-79143c271damr3536651a34.3.1758673684242; 
 Tue, 23 Sep 2025 17:28:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-78ce6e5d8a0sm1906654a34.0.2025.09.23.17.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 17:28:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, al.kochet@gmail.com, 
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com, 
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, 
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, 
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-Id: <175867368257.246129.3001464313456637551.b4-ty@konsulko.com>
Date: Tue, 23 Sep 2025 18:28:02 -0600
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

On Sun, 14 Sep 2025 10:59:25 +0000, Aristo Chen wrote:

> This patch series enhances FIT image robustness by adding **memory
> region overlap detection** to `mkimage` and fixing existing overlaps
> in DTS files and `binman` tests.
> 
> The primary goal is to prevent runtime memory corruption from
> conflicting load addresses in FIT images.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] binman: Fix typo for the test case name
      commit: 88392a59bf87bf2c1c5aedc0b76f459d702f71a7
[2/7] binman: Fix FIT image overlap issues
      commit: dade54edaff659c4ed6fc40db0b2dd446714c573
[3/7] binman: Fix FIT image overlap issues for testFitSplitElf
      commit: a06733fc83f07dd975a9e220a44392f3455c7c21
[4/7] arm: dts: k3-am6xx: Fix FIT image memory overlap in binman configurations
      commit: cbc4da1dce3f8dd828a2e613676fdceefd87e1ea
[5/7] tools: mkimage: detect overlapping load regions in FIT configurations
      commit: 588094f2c8ec9a4f7d2dcda11ffae8db8462149c
[6/7] test: Add test case for FIT image load address overlap detection
      commit: 8f3d3510e31ebc7b2057f431322a7174b6b60ea6
[7/7] doc: binman: Add guidance for determining ELF load addresses
      commit: 4907a920e8292e9e38ddab4d211dfd5499097a8c
-- 
Tom


