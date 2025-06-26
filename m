Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DAC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEED982D21;
	Fri, 27 Jun 2025 00:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pc79pOCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F164582CEB; Fri, 27 Jun 2025 00:15:47 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA16180E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4067ac8f6cdso1057512b6e.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976144; x=1751580944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77BRhGaARGZfQcn6rfYKD7xhTkpZK6Jg6hZEvvSZALg=;
 b=Pc79pOCwpbbasdhnFURUeW+E1CzrNTJ+VQSym/vIYFmAFzMw4WxA9iMbO65rlG/w0G
 bIxl433zhR8CtbRpwe4DGbEPSk/paw50lF/Tl7JmaqRVsIMTogyW28IK+rp7gw3mrGJ9
 2ou3nLAOJnvOER36puR++ueO3nmysMAdCcLN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976144; x=1751580944;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77BRhGaARGZfQcn6rfYKD7xhTkpZK6Jg6hZEvvSZALg=;
 b=FAPKqgZgtBaXi/9p9H4tg7Yge5LqZaEt9/T+LdsRnhLJESTkNHEcT/eqea7WUUT6MG
 s9sOrl2kIZgYl0XBnDnyyJhC0lv7sLHm6XA+M/svqkxFJOU39ciAw2+lzUA4Nk6imli2
 Jlm7FiYs3i+7R9Fc03sJVabLAkEiiuhP21//OZlujXQZYDXTHai+ofbh7S1j+lHDh4k3
 xh8DBJyW0rLpy64UPZxjtUGav4GwTw8GfuozcaCeDEXwmJfZrH4d07sRCiVftEMDvoWv
 GPmZcsRo45QFwYDp1x232xcMCFy9GoyPT7ao0fhFd9514nSRT/EqQILrEM8BGtVLhBdm
 dNdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx7vs8ITGN7ekjkLc3W6G6B1toAZqpTGZnl03FdTuOuKpkuEvapILPQuORQrQc1Fu97db57eU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0kF9zSw2YKORktgFOFjAOuDmeS2hTe16+rIhx8updqlCWmWPt
 a4+TGrWvikBvFQCU5gfAAs5asgo2ym63tCJpBFK5lnzWryGPRSsRMVrxm2Q+lqpXkpduNgG9aZ5
 lzgG0CVQ=
X-Gm-Gg: ASbGncvBtN8mIqbASONKUnvDVM99k6vAnxA0EqFRpJ2sPQqszxOY5UZtGtIbfBXTCmn
 xO+OoEk/yHknX33wY1Rw5amOtXfQhdbO1YiO754YWR1TXXcVFGvg0LYiYHJH9ViCtMBcOhrkL7o
 RdwxEG53dkNPjup8pQWyJ9tB3iUNoZdnWc1OQ085/l4tHlx2yc13PfitPzQxirFH9rITPptwebU
 U/T55x+AS/Fy4sDVfjkaadZ4NjZaFY/grSyXLKKFGamaA4xUhMhHKVRHMBNoAWJc+Hu1rsFCprD
 FVp0gzO7Fisegm9fdPdblqE5ekLmY+gg0Cfs+jpqlILJ+09ORdzDaDD2y/gEc4OTLDgoesRQS2o
 KBylcNXlccMuwCExDKDqy9g==
X-Google-Smtp-Source: AGHT+IG1E764LiDxwEOKBUNd1pkmEGlHPBiACqtzsjvPGkG1CG4HuaTELGr2v2zLno2oqx+6r82Rdw==
X-Received: by 2002:a05:6808:2385:b0:40a:54f8:2ca3 with SMTP id
 5614622812f47-40b33c30267mr738780b6e.3.1750976144509; 
 Thu, 26 Jun 2025 15:15:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mario Six <mario.six@gdsys.cc>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 0/3] sandbox: align LMB memory
Message-Id: <175097614333.1909185.13269465439648212977.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:43 -0600
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

On Sun, 08 Jun 2025 09:54:25 +0200, Heinrich Schuchardt wrote:

> To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
> memory.
> 
> On the sandbox LMB uses addresses relative to the start of a page aligned
> RAM buffer allocated with mmap(). This leads to a mismatch of alignment
> between EFI which uses pointers and LMB which uses phys_addr_t.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] sandbox: fix dram_init()
      commit: d50fd7f91168576918d1b4a6394bf57767ed7cc4
[2/3] sandbox: align LMB memory
      commit: 5c8de1bcfb0024993d902fb5dcfe87546116799b
[3/3] test: unit test for efi_alloc_aligned_pages()
      commit: 788df0536237321efcd443c74316d37451bde31c
-- 
Tom


