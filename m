Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62989CF397B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 01:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D07F892EA;
	Fri, 20 Sep 2024 03:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hr27R6Tq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6E2892EB; Fri, 20 Sep 2024 03:20:54 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E88892EA
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 03:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c35334dfb1so8773236d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726795250; x=1727400050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlFW3/JTAx+L2uzYwLj22ahkZdL3OqMFB8dAgq2h4D4=;
 b=Hr27R6Tq88f0xiah6iroRl1tLyDyAEZy/sL9DiDkBylcYle6x4CEe9Hhe7q9PO/wHU
 z9PU5dHDMSl9dxns8xyxWDeCVIYXUTBYDIo8x0u8lxZD7v3iGrF3mrqbaGOnxQh1gqiE
 qxdOM+998AatAmHrd+lCRnW3HoGglBxZmyRKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726795250; x=1727400050;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlFW3/JTAx+L2uzYwLj22ahkZdL3OqMFB8dAgq2h4D4=;
 b=TjwUMmAMuh1XlAOcWYlAh6pdgPoe6+f5LoxgyAor+St0LZ7kakY2w0PMy25aphodCz
 Onk0mqc7v9Pioc+2bgQeuqtsev171xeS2esVW0oVINoQP34vmeGCvpjoNMyoU1wh5NtG
 EkMteXWmbeRVwk0erRic9qKloDTCsV4Jm6BvkkpQe45JiMwJbXusuDbjBB7XYNp4M5mr
 GxA3NxCDCB1sOmI6NrcS2rBKntILD5oOTS3cHeSY3ON7AoLxrKq7fib+QIxRC+Z4ynUl
 4pZnHsOHh6tSGX4DDreB6+tRABZWD3EIez3cYlGnjeT7a93rT+XbhcybUQbG/Ct3DUm/
 AeNw==
X-Gm-Message-State: AOJu0YxBnnVikpkZR7ixdTJ1q5yxYPeS3snhsJsceoBFZn+olLNhXTj2
 QQ2iXBFu9WBnwAkdIqxSdDYbuIXVDmXX1zkhdvtOVPwzDOt6G8b+7cW5WKugLIbq7GVpptbAKvM
 f
X-Google-Smtp-Source: AGHT+IGyG4HKywjXGVJ+rFCgMokTEmykHas0su9tqpqdMrV0T+JJF+RjvS+n6lRjdvm0jySS1if/FQ==
X-Received: by 2002:a05:6214:434a:b0:6c5:8cfe:d90 with SMTP id
 6a1803df08f44-6c7bc794107mr16356326d6.35.1726795250657; 
 Thu, 19 Sep 2024 18:20:50 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e44bf33sm12459726d6.4.2024.09.19.18.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 18:20:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, git@xilinx.com
In-Reply-To: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
References: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Message-Id: <172679524864.2340630.3492151296831089166.b4-ty@konsulko.com>
Date: Thu, 19 Sep 2024 19:20:48 -0600
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

On Tue, 02 Jan 2024 18:23:03 +0530, Venkatesh Yadav Abbarapu wrote:

> This patch fixes timeout issues seen on large NOR flash.
> For full-chip erase, where we use the SPINOR_OP_CHIP_ERASE (0xc7)
> opcode. Use a different timeout for full-chip erase than for other
> commands.
> 
>  [Ported from Linux kernel commit
>                 09b6a377687b ("mtd: spi-nor: scale up timeout for
>                                full-chip erase") ]
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


