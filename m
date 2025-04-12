Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A52C369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 18:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174A08215E;
	Sat, 12 Apr 2025 20:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oz4Q2Vq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1560782E71; Sat, 12 Apr 2025 20:32:28 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D9B82D0C
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 20:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3feaedb6670so1998270b6e.1
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744482744; x=1745087544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnJbOlxq3YH1fbvbdel9kExX67XGO+j0vbZnOaLF1S8=;
 b=oz4Q2Vq63e0eGv6eHfvyS06BlHCZG3njFntYEZOU3r/m845mPlxMB4b5ptgj/vY/5w
 9HiqvfR6PXKm4atXu0aL6vA6PVLH177Cz3V3w5E2F87D6UUyxzitF9KD+tuAx3Vy1Vmn
 MwbPvbiaaOVZfnEXwzp2CTwVy8v6T/u/4AscI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744482744; x=1745087544;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnJbOlxq3YH1fbvbdel9kExX67XGO+j0vbZnOaLF1S8=;
 b=ZXEirhron8VUPVAlD3qp+pLDbvzXHDNYH/mj2S7aT1SBgchm2rtS8RZkVk2Ey0sGC6
 9ZxK/XN8qN6ZQX+hJ6cwQ7azngK/X/VUgkVt3SJ1f9mNCbC/2/sGJ7LcjzEyDXRZjb40
 Om8ts/QoxVbM1TVhfcMeKeojJrinx/PwVE8BGn0y7rT1qLfHZb6Rrd6s3Xmqv2PhtBtw
 k4lDp7v6TbsNK7hIo0Wc7lO9dRa/QrSeJRZeQUz20r8qYvZkz5Kto/59OIM65mgaAe0U
 IIkECsQD7JByq9b/GDqSUfcwqm6V9HBULS15QgvRNfqw825EgeoGCYFttEAIdA9Nog1O
 zt+Q==
X-Gm-Message-State: AOJu0YyxwZnGW2bkgIKVBdMmF0unwyzuS5nXOunnTq7v1YhxdD8m7swL
 /Ssfx2NssEA/iem0Y/4esd7O/yWBDfPjenws3SzAmaIL8a/penqIZ75nTJ6YO6o=
X-Gm-Gg: ASbGncswza5Dyg7u6BAj5QEHz+AsoN/rCPb8/5mlRlCMevcWPygPSoVDAlMYUZ7SqTz
 Ejz+yqXweNi9uyYKX90mojfij1rhwbn/AqDPAfPlCwtqUbyqH4G6RgtbyIW7g2JSynDxcuQSNXx
 VUPz3PKb0VxMUXA/6R8Xm8+LZhtf2FmK5c89wPFtV8iXPaBjNzfGAFwGeKBC34RKEag8G/8xNRc
 Y/ML63y5snuhnqPlTGezqosMkRSPgpwl4mQuEJC2mtvLIDJ5iPA+Y39XGJ+qNhXBjosSEdb3YOw
 iB5oktYm//DLZVCujGYo9GAbJcguifGz+K8lb0UcoAy8nUcvKu8QguTFPGbXTSZW4XHWLBLVkPv
 j
X-Google-Smtp-Source: AGHT+IFVEH2woF78rdKb79Z78dS4LeQxseMnP1GIYWDgDbtnufw8mCN7Xdv5wNGEA2kP60PG6XoyTw==
X-Received: by 2002:a05:6808:180c:b0:3f6:7fd0:808c with SMTP id
 5614622812f47-4008505cefemr4250125b6e.16.1744482744487; 
 Sat, 12 Apr 2025 11:32:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639c9e0sm1333376b6e.32.2025.04.12.11.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 11:32:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] binman: Check code-coverage requirements
Message-Id: <174448274259.256398.1892331563087478873.b4-ty@konsulko.com>
Date: Sat, 12 Apr 2025 12:32:22 -0600
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

On Thu, 10 Apr 2025 06:42:57 -0600, Simon Glass wrote:

> This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> are still not completed, so a work-around is included for those.
> 
> A few fixes are included for some other problems.
> 
> Changes in v2:
> - Add new patch to add coverage to the requirements.txt file
> - Rebase to -master
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] binman: Add coverage to requirements
      commit: ac964c099b5a90076add8aef6bcd6eb3d96eb458
[2/8] binman: Exclude dist-packages and site-packages
      commit: a876295e1bec85f8318807424bb9de8794a4d7f7
[3/8] binman: Drop GetRootSkipAtStart()
      commit: 0148be7cd49e8f801662e5af74203e2cdf93a5bb
[4/8] binman: fit: Drop unused code
      commit: d664c29ec37964db5e191debb2cafeed3a170255
[5/8] binman: Drop algo check in CheckSetHashValue()
      commit: 702b7a3e2eb49b144936e061c0107518544c4b1a
[6/8] binman: Workaround lz4 cli padding in test cases
      commit: 06a0d9eee835b5b6242e773cbab34ec9aba19443
[7/8] binman: Work around missing test coverage
      commit: 2911f2c1ee83760737dc162b1852b0e3b414e6ac
[8/8] CI: Run code-coverage test for Binman
      commit: 6f875290eb107106059f4edfcf8afe31bed9a378
-- 
Tom


