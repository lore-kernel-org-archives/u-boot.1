Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189AFC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 04:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36434801F5;
	Tue, 21 Jan 2025 05:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hCQC2CEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE11801F5; Tue, 21 Jan 2025 05:49:31 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89530800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 05:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6edb82f85so699031785a.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737434968; x=1738039768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7VIXpRNOCtWGYA8F13JKjXQJlR7f7dzBpAu+0UaLhlA=;
 b=hCQC2CEi1AohoZt2SqvyOIVu2WdjNfuQEh15wJ5Iw48Ivsm+OD4NCzVSt+A/qPWDnk
 xYbM7yBtZR+z/xhYQBzbXWiN6vDcWweqBtQO+r3EWv3v0d4GTdMpTR0UUGqWxBSKNFKS
 58QAo6yvPsU7PCYN8hx+2Ypzoq91SrC9Q3cCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737434968; x=1738039768;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VIXpRNOCtWGYA8F13JKjXQJlR7f7dzBpAu+0UaLhlA=;
 b=Z4r7hLg0k00lVJIPqKeJZvjucCG9yPORMHakNT6YoBu3OUtt0jtXb74O7FQSOzhXYj
 BY98cdOK9arjddXoE9VSjihzQqo8UnvI4Bhs2C/bpdGrB0o4usfn81UUzf2XD9ftp2A1
 Kqrb7iT68aY9E4UHutkTC2C3FgS4fXeOKiKHFSg0xccDwWSWd1oojq+aCGH3iDNVXNLu
 wkO5zTrMaj6Q4UDfbki58mtoBS0AskvR5oQYqfOjMiv0T6LEcCfggC/UPoDdZ+DRjWti
 cw5KIkMHaLFvmcwK3Ve36R0/TWK0eWPF8eEACjs/wkuA9GLqN5DS+WJwJ1mbu3YFVm1S
 1pEA==
X-Gm-Message-State: AOJu0YySrJFj3uIiRG0Mm0fCnZOAB1BSDUorGJvry6E5ZQqiVIxZjaPG
 HjR54wFHDMHRUuna94S3u+x9R+dmXRxByFuI2gw8yKzSdv5eVk2iWAFWcLq1fSF5gYvrT2th9hy
 e
X-Gm-Gg: ASbGnct0J62JQM14W0aWo+Q4mR6YRq/XHrND6SMyqRzdFpgSAjr6m8h2Aobsza+6gFk
 1rzLqjznsPTd21A71mPY+OVr84L/HRITqloOP2s+cFSmwKalcb/DGgjltPMk9u9T+gayWdGAIPN
 115KrFN7fkh6nWGDkfQTe2KSU3BCHxVo1fTym/2Aou/4MbZRYMW0l4OvIzt5Ak+Nm66yGAZOZci
 cky/+ZNp52Mo7G55hbLUa8PgrLEh4w439NFXhOFiXsknngy0+O8A7pf9ylp8MmkVQ==
X-Google-Smtp-Source: AGHT+IFQec5DYDK4EU0V9Xi1+gY7zXV9uGMxO3fIzrgG/EcYz+y08lzmcRL0VSMab/B74tgQO1FnuA==
X-Received: by 2002:a05:620a:17a5:b0:7bd:bafc:32a8 with SMTP id
 af79cd13be357-7be6320234emr2272533085a.24.1737434968422; 
 Mon, 20 Jan 2025 20:49:28 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61487e0bsm520090885a.59.2025.01.20.20.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 20:49:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250115012322.215243-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
Subject: Re: [PATCHv2 0/6] Rework the BLK symbol usage in Kconfig
Message-Id: <173743496658.2923241.16951608849619908447.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 22:49:26 -0600
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

On Tue, 14 Jan 2025 19:22:07 -0600, Tom Rini wrote:

> Hey all,
> 
> One problem we have today is how the BLK symbol is set and used in
> Kconfig files. Part of the challenge is that we use it as a gating
> symbol for "we have a block device" and also for "enable block device
> library code". What this series does is move to always use "select BLK"
> by block drivers (a few were and a few others had it the inverse) and
> then "depends on BLK" for functionality that needs a block device
> present. The end result of this series is that a number of platforms
> which had disabled EFI_LOADER now don't ask for it (they have no block
> device) and espresso7420 has a regression about MMC support fixed. With
> v2 of this I've picked up the review tags from v1 and also reworded the
> body of the commit in the first patch.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


