Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24C7CD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D7484975;
	Thu,  4 Jun 2026 19:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MctZZPln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DD984981; Thu,  4 Jun 2026 19:13:34 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8DA84957
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-48650c78e09so406561b6e.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780593210; x=1781198010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EqlH81oupViMOHfww/hQy1gBgkg2X4Rngu/9SIj5l0=;
 b=MctZZPlnEpMlHC/RDLkKy3E3NNCDGRXQGdQO1sIkcxBS62xonyhmhS23Syd/vqh0vr
 e43d80QnuEVfPdemO6Qdi41IV4mStv3cv4smzuRnklXH9oMypa00nQ35kTFz9cAG8YhD
 msuk0mq0fMyevdHzCgCJylbGcKxF/hyR2/iv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593210; x=1781198010;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2EqlH81oupViMOHfww/hQy1gBgkg2X4Rngu/9SIj5l0=;
 b=BMRtmIxP21T0jug0XvPt5S40yEQUevUziOl+yy0CptFJziPOcmMWKG+ca3eAklXVkj
 ARVigiF/6s4ek7vl0PBnd4TIHc4OgRVW6yQPn1U7VrWVqMlCt9izraKypjQiAzW0rjnk
 fNtRerIvvcHnLg7Asrk71vqKI42piehL9F2/zgYA28wkMwefG1E7B9XX/QbR9XSq/hcV
 fSz7QWW6kp574rjIXes2anuvYRtrcMimkRwBPqA55f9+W4Pu5chfD7Qu6eBaRD3sIGBV
 5a3TjNqf1DwO8FhjY8+CGXCi3HQKmlNW6NuPk2iuWNRFKzvgg/NGf3R39wLEZQDstpr+
 Fovw==
X-Gm-Message-State: AOJu0Yzoj7YVHMEVNpxdGtYFMrRUrT9HnfnZCjqupZRh+ftw8y7sWhFR
 9/dUFutQV4tQSZ0ScRIFK9YWwEbSISHiqVhVJQIm48GXFE2mb3BD8B3ysBf1niT7z0E=
X-Gm-Gg: Acq92OFUmdm3whuqVyl+Ytzwr629LcSOaGN4HRvfoj0jvYnJtSKVRhvKG/ZqRmLfJRa
 Ru2V/IzRMR6EH0u3zmI0hdWhyMB+AivMKJW/8nEd+hXOefSFak5oXvv+BmmJvN0veTJ3RzMfCkN
 J/vgFafn7ZGoUEne9yI48F9qe88KhZC2376gr7M+hic/yTZ03ZeTuY0uy354aTIsPVQeFILcXYS
 FtNxR4dNvpRy1UDbtn43veK1rxv213KITk4jxAwb/7QmLD60vTBpXJkeuhpWDRaOTS19XSmZZCk
 9LjjLl2ZWoxdH2fISC45tlkW5YiXtyfSe9bwCKg8OZtYcGAUzwhW0IzKQ9mTh5GIft4EwMkweV9
 FrQhh4UaytRYNH/oElbVpzl661laq73/X7Q1ll0TgwLqoXkdbymjH0HX8wj5yccS6F7u5JbqqYo
 t81pBUFSEo3g8c6Vx2NZ/VI0OJm0kKICShOCBNeXKCJH+tGT71hIhI2i1U2iUiyZftk16HTzmH9
 wxPAz1icx5R3/58uGnaCT5KaFkIdL6Vt0ydfnP9bfUQssP8YGOnO8nUvkc8
X-Received: by 2002:a05:6808:4f14:b0:486:560d:aa8e with SMTP id
 5614622812f47-4865ac23f56mr5571916b6e.22.1780593210430; 
 Thu, 04 Jun 2026 10:13:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm4700408b6e.8.2026.06.04.10.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:13:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <069a3957-458b-48bf-b34e-d5566281cd29@linaro.org>
References: <069a3957-458b-48bf-b34e-d5566281cd29@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-nvme-fixes-20260604
Message-Id: <178059320982.3942316.12644633578789953544.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 11:13:29 -0600
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

On Thu, 4 Jun 2026 18:00:02 +0200, Neil Armstrong wrote:

> This a second NVMe fixes PR, with a few fixes and LOG enable on timeouts.
> 
> Thanks,
> Neil
> 
> The following changes since commit 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa:
> 
>    Merge tag 'u-boot-stm32-20260526' of https://source.denx.de/u-boot/custodians/u-boot-stm (2026-05-26 08:22:05 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


