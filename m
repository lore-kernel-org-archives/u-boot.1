Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66957E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 20:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91343800D0;
	Wed,  8 Jan 2025 21:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CUPXur8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469AD805E9; Wed,  8 Jan 2025 21:19:00 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DAA800D0
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 21:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso12405085a.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736367537; x=1736972337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x22p1tjR4t1SVg4/LeW7JwdDnt4SUJX09OoC0ERJ5GE=;
 b=CUPXur8RVWPvoVi2BSO4vzsTeR331Zxblut5HVEk2ntvAwnXym1sCqsIJ5MEo4THWk
 XFdrPoCdONU6sudi/bN67Lhrop2NGlxYAVOp+3N4CftDe3UKNpblYB8wt+niFk8MHd3V
 espkdthdRUBh52qa4kirnwV3koYM0QP1LoxyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736367537; x=1736972337;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x22p1tjR4t1SVg4/LeW7JwdDnt4SUJX09OoC0ERJ5GE=;
 b=l7h0w5RzybCrk+3PGCMRitQEjMyFQSgCn9neSKOhbWtJsElHZJh/UZQH5i49eIjm4p
 xdZLBsvGWOql4l+dP/sbUm7mG/4aNtSxqEw7Bw9aUwFUPx56cunjU1KJFccQUfV1ODPq
 7rRs2BFUV7xMmlaO38YtbeJvpipFTvsbBrL+wcwf6eRUQaANo/xq7di9/byBJ/wfSmR+
 JDoVfLkJ7d5cVta13sPQZe/BApt6kHiyW9zxU7T+VXaFvZd8Ppd7ZGwUSdzffg+2LK+a
 QS2h0/ah78WV7IIyMTDVOyRdyUxRB4KBdc/Zu6V9nhrp3/X0PywpNR1wHmwb+TUiUV2B
 6sRg==
X-Gm-Message-State: AOJu0YwGQeW9K6NzlgHSh00vWq6bPDBCw8HnOXb6iW99yMXQHe5bXFCB
 EUk3xSA89XSJPTTjf6/Jz18X3ZNHLhMYobSufmWTjvpVMR7FkKNXFYkliT2Rd5T16b9pqRHvPSq
 1
X-Gm-Gg: ASbGncsdDMn2p6ZpKlMOtzCX5F87clNSmBX3wLL8jPy/9p+E3aoGc21pHp2FZ8U9m1v
 VcjJfdrMXV+Ewbeo9hEn7N+szHrW9DBwu4x0YFOQgP+bDaOxShJ/52zI9Ejblv0IBim+Y9VeqgN
 klpWwcoKJvBmTOSe94TIqvvZmdz4FOL6V3gsuyGh1D0rNSRaeokzziieY86e+cCMcE9pID6lo2q
 R/PkF1fdz52ToZg7dtymH0NqAgCXo3juv7KJrnmEtLc+O7/+nu9NA==
X-Google-Smtp-Source: AGHT+IFk5G9a34QQvHc6k/Xb+jzL1IIM3CTPeYXsPAZ9YDp1MvC6JsTVgm6N/QS0vPrU4BKTYXNxRQ==
X-Received: by 2002:a05:620a:24c6:b0:7b6:f34b:cdd2 with SMTP id
 af79cd13be357-7bcd97a4e6cmr727565385a.53.1736367537077; 
 Wed, 08 Jan 2025 12:18:57 -0800 (PST)
Received: from [127.0.1.1] ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480ea7sm1706521785a.94.2025.01.08.12.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 12:18:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, sjg@chromium.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, 
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com, 
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com, 
 ddrokosov@salutedevices.com, git@amd.com
In-Reply-To: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
References: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v6 0/2] cmd: Add support for optee commands.
Message-Id: <173636753525.954784.14530620844312563637.b4-ty@konsulko.com>
Date: Wed, 08 Jan 2025 14:18:55 -0600
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

On Thu, 19 Dec 2024 10:09:16 +0530, Venkatesh Yadav Abbarapu wrote:

> Add the basic 'hello world ta' command which increments the value passed.
> This provides easy test for establishing a session with OP-TEE TA and verify.
> 
> It includes following subcommands:
> optee hello
> optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


