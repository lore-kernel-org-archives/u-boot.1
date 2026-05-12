Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BA3CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E80583E76;
	Tue, 12 May 2026 21:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oqI+fUPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BFF83E76; Tue, 12 May 2026 21:31:52 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0139C83FEC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd689829eso5273353a34.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614309; x=1779219109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEUQ5qJM5UWmIXeB/lT1MQiQWjlVpHROMJMEjcx033M=;
 b=oqI+fUPIBkyRW95qWJ9Y9KFgWA/dRezxB0oGS9O9xos/MNwof+y6Roes3ksf1Ydngo
 T3hlqiztsYzGt5t2SH6FVvT29JPBcRrEjYkSqy4rcI3uVTGizydAOc0F+vHZqBFLbpMs
 2fyVFxZKMJfbWwH/b359Iyu5+I0MdTDO/qWKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614309; x=1779219109;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fEUQ5qJM5UWmIXeB/lT1MQiQWjlVpHROMJMEjcx033M=;
 b=BPKO551So/k3wq50T0drHIxTIVeMfrVA+jWdzW18mNclK+qNFSX1U9Wh/sbgcREJwJ
 HRpDSsZJX8gvSLY7sItZDnRAqMl2+exSMiarPnasbXJLUezptue9x8LGXX3jlwqPnTlU
 i/nhVDIjHfw7p2GjigOV6If/QrjkXNsrFC2PARs9NPkdcxGGKCIToVjcg463/XapLA/v
 oo3sHvJEH2y2imUE4+2Nf6PT1Bz+iFMU6PFjs65a6poEN51ydjn8ZS/lmYfDwGSo8k7S
 PtS+hFZRL54nVzEKKF0kEvOqbMyWmjt6NMS6LEbEmVxEuZ4knqOg4kCndzs3RTtp9I8s
 zdHA==
X-Gm-Message-State: AOJu0YwkyA1uwEs10HITPrgLr0rDmZz31YgzKaKBxdXjjpOp6D6nxnRi
 C5p6p0Cb2PRa9BpWFPqe3+xTsR2MQSf1ZNWpWXBJ3ovMPUXzhTPfMuIdH6NiNIRZL2c=
X-Gm-Gg: Acq92OFxo2sbjfyIhrxs/tYtj/JxQCYMnbuxk8Uij8hps42lvLv39LukHJ9eQJSk4w3
 iyQ2e1vYFgY7m09AOxmERM0jS6fktXUaE4BJNq3xHIVa2SbpyWl46xh/XEU/ikHV75/xEcO7mtJ
 zMmr22P3RplecSxzi7SXwUCl5Fmbd8D7W5Jma7P5OytM3Elva3t7IZG/pwHMaioF3J1GQSBhCUh
 oIgPEcVBDoAYeKPgiUudQvihMZghp1XhFu+dJFNErQDZGWtT/E/Z+wutxBsvyst77BmQj7fzQUc
 5PpJa+wPBuJ1+IC8uCifRnyvbN1QoEmAzUUrT/QsHK0Oyb6IcPTLanmNO8YJNVND2Cyvr+OGr3w
 jFe1TrlkSmetK2BW1ETrQZB9xKHLiUjRn2xZQSLyNfcMhGvHFGDaFx5XdD2wfXz3GNLJyWfCL5p
 A7/JNTIHovZWY3/xhPVItcJLjTwSN6ajBCTQfNFyIgqjWO7mdkYI7hea7ekLUFvueJ+/do4KHwp
 HRc+8gvwzUYTCWAUbLshnmX6TyJn9pNsBPgKFnyuMM6xPNmDg==
X-Received: by 2002:a05:6830:6612:b0:7dc:a256:5e2e with SMTP id
 46e09a7af769-7e3da14a45amr46079a34.1.1778614308769; 
 Tue, 12 May 2026 12:31:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
References: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
Message-Id: <177861430812.3279584.11341898838004874732.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:48 -0600
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

On Thu, 30 Apr 2026 23:34:43 +0200, Janne Grunau wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,wdt".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] watchdog: apple: Add "apple,t8103-wdt" compatible
      commit: 74471e0e181b3d240a41204e01591a29815d69cf
-- 
Tom


