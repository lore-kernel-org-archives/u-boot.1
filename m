Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46EECF45D4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980828393F;
	Tue, 13 Jan 2026 02:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fAP+oQS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A64838A5; Tue, 13 Jan 2026 02:29:25 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BCC2838A5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso5096344fac.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768267762; x=1768872562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5Yt4dpuV+iDQBvq3UsJ2kieTHVhcS4AW+t2sGtAxrk=;
 b=fAP+oQS159dWFk7FUsA23oPqn42M0ihPLmuLjvx+5rA+dgjuxIg2MNXhVTWHlY3MKO
 ysBr/bBHSh8cfGIzoEgiifIxtCScG2/yE3u1K0aftR6qU/oANVhK03bP4d/7HwPJUpAd
 VGeUp0QjooAKxEs4+XfmhwMZ3GIbp26nuCc1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267762; x=1768872562;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5Yt4dpuV+iDQBvq3UsJ2kieTHVhcS4AW+t2sGtAxrk=;
 b=L1RoyR8fDVonIlUbwcdGmizq/AcHUXOzxi/f292jhOt9KMUZUeeMy8NQ/bq1LrnLf0
 P4oKRrtxC3wGE4PklRnOAYpkXgWu3nbdQUDczkKuDo0FDFZDhsJ+PYdtIGcQYIRbM+BX
 Qpu4BR4P2txpddjHRi1ZvP3rrCljbJ0BXv62JdP7RAWS9yzdqa3UnKW/CLjoYsrHqGjo
 6PjqmHcW/NUiYzHGMJnQH7YT8ASFTV8ZZ6zQ/hYr26vLI8s4RFtUuODsGj6BWyY58+13
 yfYSOJpB/NbbTCeFCTJA/6/c/h9kC8xFLuKM9b2Ls6qKbd6QB/MVa+qG7zhc0i1IEnEY
 9VSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRFhsFpiyZmkvppZtk9t5Z/2Yzl79/ZDHVUat4UukaYSsou1wYf6q7iDivUNGfAD5Wu/L3XJw=@lists.denx.de
X-Gm-Message-State: AOJu0YzVGUobKTvLXz/6kxapJay4+6WXYCjmcVA3vevnuTedgJm4DvS3
 +Y2xKSG2PQm7ZNjLcmVnrAiA2HZBjsPnwOkEZmyC3LLtw8j6n/lh3BR3F/70tzKgfxc=
X-Gm-Gg: AY/fxX517RTQVYGhDSCzu09eCOLfkZtZJk8hRaE9fOywTdmhVjFZ9p7F+furf5s5C0V
 Om/jef5zh46BVf1YZl6kAscXVFUhlwKAKUFsNfB6VUI8jrGnp9l2Ph1m/hhEMEWk1RzKrYrludZ
 /VY7uUNSoL45/bLplQ/QYlEiXo2hx2TWky0BcSvkwZ8j+qN0CPMSCOPcHWsuttPdqcWW6iUKfrL
 b+cR+WzZ4SxbF2Bjspd+1sXHdsKWdx+fMPL6pN7Q6m6ULGVvLbq1dyw0d3FMmS72/H1DfUfXkNA
 xQfAPiT1Hno/1aXCYaLbwtZ4CQA9YZS9ooX/pO8kKXmHZ1cD+iaMB0uD3pXyAtyQugy59FgnwGs
 XyLg84gpjTHERxzeY9xYMvBYz9uEQ/ptM84i1SKOtGmKWQYimv1Q1TlJ+Eh7LfTi790UWt+3yL5
 9st2FPQVpMo34557uH6XkuJCIxLQgqf0stWFyW2mwqh3b44wxy6JrpPu+XY2cVFmTjSmuJgzceS
 cF9hDHuMdFGutbFuolLFqmhIWBAzuG2CGkvvWLroPCVAhf2
X-Google-Smtp-Source: AGHT+IHU7xIo29zfosMq/NAiiWfWXhN2jKyqzRGYLG8RKpURQWYeo1FdedWVuHy3DWQO1nTfaElb+w==
X-Received: by 2002:a05:6871:6286:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-3ffc0967ea5mr10313180fac.6.1768267761825; 
 Mon, 12 Jan 2026 17:29:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffb279e939sm11992690fac.16.2026.01.12.17.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:29:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20251229051113.2136908-1-b-padhi@ti.com>
References: <20251229051113.2136908-1-b-padhi@ti.com>
Subject: Re: [PATCH v3] configs: am57xx_hs_evm_defconfig: Reserve EMIF
 memory used by PPA
Message-Id: <176826776070.1946884.10917455984122516439.b4-ty@konsulko.com>
Date: Mon, 12 Jan 2026 19:29:20 -0600
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

On Mon, 29 Dec 2025 10:41:13 +0530, Beleswar Padhi wrote:

> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 37 MB is used by PPA and is firewalled. This results in an exception
> and the boot fails. Set CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB
> memory (aligned to 2MB as per page size for ARM32) to fix the boot.
> 
> Note: This limitation does not exist for other AM57x devices, but this
> config is applied in the common defconfig since adding a separate
> defconfig only for AM571x is not justified. Losing 38MB of memory at the
> bootloader stage on other devices is acceptable.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
      commit: 711150fc6fe7a125cc1133841acc802570478007
-- 
Tom


