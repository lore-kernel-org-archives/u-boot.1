Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD5ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4957F83E76;
	Wed, 11 Feb 2026 19:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ifAHnn77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAB283E1E; Wed, 11 Feb 2026 19:26:46 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A8B83DE4
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40438380b88so1482855fac.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770834403; x=1771439203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDU3xdSDfI+HHyCvxTMgXdCFUCqLiARocaNK08YjK7g=;
 b=ifAHnn77QKi4wL5jXb2LAhSSGg4fYafNJ1QDnuS5ylnpuP70ZRAnEnzr/tDNptibk5
 bhSyw2gC/0fgSJ5ATOspym+JPoeU60WMm04FQM9mguX/jOudVLl0hJIhMlm4m251NoyT
 B8j2tUt+S55ac75jfKPAtZgo04z+o2DeTpZYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770834403; x=1771439203;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fDU3xdSDfI+HHyCvxTMgXdCFUCqLiARocaNK08YjK7g=;
 b=Vimp/j/go4OBNXgFvv3UFyX5Vgoezb8RpsOpVmcCZw2JjeWslie9ru3htWSvBSL1kp
 aB+8py50OaQEGl/l1vumJeLFGJHgQ9bvOOlqURT6czdgyiPXUeuvX2p1CpeCADU0Vl0Y
 A29GLvG4/mUk7UX4WBTyuogLvYTdB8Java+NvxSQaQBCYYB25s5ItksVW/UkTwX2r8gM
 wZmnjQXm75W/CwTazvnsZ8mcF2BWd6iEameUIvIyzIvOZFCFGH8vF11q7JV+Jc84cWQc
 EityR7+ONVqzRMXG7N5tyeBoBRUerVX+y4/F6U8xdxa5eSFC7gSIOpji8tkO88H8bQWW
 PvuA==
X-Gm-Message-State: AOJu0Yz7caUy9ucBOMfHbK7VLCLAw76rAGZL8lBalhiVRgRQ6oY+zLZ4
 Usc3N+arPLxfS+hhk0TfSf/4K0C16sLJEdS7ZgNRk7MDQMvl/QkCnhBFBlLsZWJXrwtzLgKPoPa
 H5Wr4xw4=
X-Gm-Gg: AZuq6aK8u2rs+HKGlIZu0WJQs5/sxBKOOUm59K3P9F/4GOFxvuo8KYLfG5odwhvskSZ
 DZkPdFMN26v25CXYBB6H9n9362opYCsE/e20NXwPPIZyRX5oAJm4JFboa89nbXbJy7qyKI8xjrz
 x73fPxNAkgu6pT0+ejtHa3s2VC1k2N3dFpyrcH5LNkpEniXIt6Ny9G9XCBc+rrNnTKPte6aeDOC
 z1PzV3LRDvb7nSDrIfmXbp8hz+vq9hWBEpq4/87SYFTVpnWYnBJlUROe0abAitwSb5aGKroxYp5
 tpYCHvSObfQO0KnaqFpb7HA1IOvWQgKd/MsCxhcoupyhFx6tCWrLPTCC3oFV/mn4wXl5UdISONT
 qyoGnmJwckc2zwdNYr6F3h/B6KAOC7LJ/96oSp0D+DdWkaFhlYbsw/WuQ3ufLVitCSLk4dvc6X0
 beUrq8ZMYIyZjGSYoKAVnfhEUmQkXK2ZlNn8dIVNi8laQJqBsbyqX/kFUiTcElR0uAQ/FtYZdRj
 RcewF9bT7xW1DzNF8iIJ5HB6Mc1KMbouFp5i/bVwhac+g1bng==
X-Received: by 2002:a05:6871:4b0a:b0:409:a1b0:e447 with SMTP id
 586e51a60fabf-40ec6f922admr18796fac.8.1770834403216; 
 Wed, 11 Feb 2026 10:26:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf16c383sm1814426fac.14.2026.02.11.10.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 10:26:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: kory.maincent@bootlin.com
In-Reply-To: <20260211110108.66433-1-ilias.apalodimas@linaro.org>
References: <20260211110108.66433-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for ab-next-11022026
Message-Id: <177083440244.1681814.1244619463346119143.b4-ty@konsulko.com>
Date: Wed, 11 Feb 2026 12:26:42 -0600
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

On Wed, 11 Feb 2026 13:01:08 +0200, Ilias Apalodimas wrote:

> A PR for the AB support from the TPM tree.
> Kory has update dthe code to mark invalid banks. Those will now be
> skipped in acase of failure, instead of trying to boot from them, fail
> and fallback to another bank.
> 
> The following changes since commit b99da05e1538b8fa153322da82917af2aa27e1d6:
> 
>   Prepare v2026.04-rc2 (2026-02-09 15:07:50 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


