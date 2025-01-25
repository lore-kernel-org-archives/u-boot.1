Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6818FC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80B680F56;
	Sun, 26 Jan 2025 00:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LSzp+ai0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CC480F56; Sun, 26 Jan 2025 00:40:14 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FEA980EB5
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso381179285a.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737848411; x=1738453211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bc9H9+pQsRObj1e1lO+rCSqfvp9YS6KME6/HFGnha4=;
 b=LSzp+ai0POhtpz/dGpzKMJclrJ0ew14fk8TtWdEp8j1dJCA70PN9psbThNS+0Qsi6k
 uRbEEgv8U5IMjQcnRLoglMAsQW7E5cuxgK6y1v9c7dE2a1CgPVv5ejUv3fx28DtPy3DU
 b+8+0Et2sntR56bD897M3hypxKNudbamDu4Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848411; x=1738453211;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bc9H9+pQsRObj1e1lO+rCSqfvp9YS6KME6/HFGnha4=;
 b=TUhMgISkDx10HYfzrAeXt4QesaDMeT/x5qH7aZBYCbQmwtpC5/1SMU+3boDFiXr7Z9
 IPsbgkff3G7tBXNR3ZB+/bXwPs0XDc5lprl0pFCDJJ1SYiovbRd+wDu/v8VT16v8tHBp
 ufiFeSrbfU4OBFTIA3Vf0V1GXlpawC1snXkLRxiNe1cmA/ICQf8D/1EFXSZBwXiQH2UJ
 gCob3l3NElYqKI9Qfvo4A4bdlUcyPzWBtZyiW+0gg6bZkVqyuvHbQ3C0lDErR68UzWTD
 8lfTCUiLG7Nw3A3osbNEkemYV318+xZegLUAEftvzCjKj3kc2LdiZlsm3NXeIUzkBXAZ
 0W8Q==
X-Gm-Message-State: AOJu0YymFqqkFEQcQBn4HEGJkdOhEr2fEC7jMD1Pnlnv3IArj+d15O1z
 jlCkZv79p99ZnVZxLMUtDTZvbI/Q3lVoA5JIq3VA+vpl7slN6s3BxvtjD5IcnIE=
X-Gm-Gg: ASbGncv5l19vsA0arIL27I3EwoIBA1biSJOvxbMxQvgrN0mTKU/tpu1pb6nCz66wTJn
 nD+kLmSWFB1Js5OqmDHkk3+oAoEXqrjGAKGL0nnb3jflIXxLCPKipe6u1aIpaBpbCsVCUNDguaV
 Ikg4FjBYLyb5dcFCeqTDk8ApfWm1voB8OfDp4AQ3HKi0WTxw/P9IiKxDD/C+i2Kjv7WJ9EkO1SF
 WGc89Fo8Wwnfy7+fFP563fvnTKrCgIu8lyyTQLyflZx4zUEu0VA6tF6RO7IRBA7TD5QdVkKvWuo
 Azk=
X-Google-Smtp-Source: AGHT+IGJZhYltrrcHGlSVG/0sbc/iDb4GjfJlLLlvMCJgpFVMJfTKTilOW899FrNCz/hABWDkltagg==
X-Received: by 2002:a05:620a:2416:b0:7b6:e8d4:9b89 with SMTP id
 af79cd13be357-7be63249708mr5199249185a.34.1737848411119; 
 Sat, 25 Jan 2025 15:40:11 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d48csm238979585a.110.2025.01.25.15.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:40:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 0/5] gitlab: Fixes to get StarFive VisionFive2
 into the sjg lab
Message-Id: <173784840883.1163385.18125082031056649443.b4-ty@konsulko.com>
Date: Sat, 25 Jan 2025 17:40:08 -0600
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

On Sat, 14 Dec 2024 11:20:19 -0700, Simon Glass wrote:

> This board fought valiantly against attempts to add it to my lab. After
> several hours of debugging, I found problems in the Labgrid integration
> (not included here), test.py and buildman
> 
> This series fixes these and the board now seems to be reliable enough.
> 
> Note that the board fails test_dm_compat
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


