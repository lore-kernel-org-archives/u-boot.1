Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71847C5473F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410A088AFA;
	Wed, 28 Aug 2024 01:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="if7j8u2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB3688A9D; Wed, 28 Aug 2024 01:22:53 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF0688A74
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf6e17cc2bso29217966d6.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800971; x=1725405771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lO9lHJ70DJ849ai2HZU6ThnRAkmLa/Y+TwFXvLMGGXM=;
 b=if7j8u2XS/WETfVCOshtpY3G2K1cHdzlIIPv45u71hcr07EeL+7fXNLPhgDV9K1/cK
 Fu2bTFpkHsKZC2unmt51LLYB/neeQAwRzge5RHntemT4ptPd2/MMYsVuiDfptRgkAoF6
 7COAIs5lj9RnQLblXxrGW9TcZGXewcYLQFosE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800971; x=1725405771;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lO9lHJ70DJ849ai2HZU6ThnRAkmLa/Y+TwFXvLMGGXM=;
 b=cqGrucoJ5p01yAWQJ37lrvvt96+CwHhVYGAVeVLSFz3yt0kqWX1eos5vkKwxac5wp2
 sSg9mMxy+quG4dxRKnEuzu0W4JVnhGbxK57TNWVfBKV/4NKajDIK6JTuPh3UsHiXEaRa
 ZUmfnY3pwkrxs69P1io3zhIgeL7xWkz9Edu3Yvsl/9ja4OvJH6E/IrkPZaz7e1MOZ3eB
 msbzL9Ow3voEtziRYrcFgs6ZygSMdtlZ+5tQ6anfh34IdUQFvVO+X1BO8uu+5SV2HFt9
 lUH0xaXqQWua2jm6PwY+oHxDvIL1rAWSJcP7buTKGbyWZxczP5+OuiZCTJRWnfa0HN7K
 q8PA==
X-Gm-Message-State: AOJu0YxEUUoIIet1uV8DVyj8MOjbDidKmr0g1WXgtkwYkSky0FnV5n1W
 eY+1mSTZv3K3mrsBPxEzvsl/1JC5tIfsvvLDiEefKTtK8Xq/tPAda+5VFwglKBqgZ3dvbfGF5g0
 lWDGFZg==
X-Google-Smtp-Source: AGHT+IGgjW0JmIcZOCsbCiFY91wPhpNiKBY7krRXeVndhjp3zMFcYBQJX6sK6wx1tmKB74wHacSncw==
X-Received: by 2002:a05:6214:5bc9:b0:6bf:6127:98a7 with SMTP id
 6a1803df08f44-6c16def9c61mr158510176d6.56.1724800970707; 
 Tue, 27 Aug 2024 16:22:50 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <d70c454ba91405d025ca276f7c15ec68b0f24e1c.1722417794.git.love.kumar@amd.com>
References: <d70c454ba91405d025ca276f7c15ec68b0f24e1c.1722417794.git.love.kumar@amd.com>
Subject: Re: [PATCH v3] test/py: spi: Add tests for SPI flash device
Message-Id: <172480096947.2972894.13549233812563942578.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 31 Jul 2024 14:54:12 +0530, Love Kumar wrote:

> Add test cases for sf commands to verify various SPI flash operations
> such as erase, write and read. It also adds qspi lock unlock cases.
> This test relies on boardenv_* configurations to run it for different
> SPI flash family such as single SPI, QSPI, and OSPI.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


