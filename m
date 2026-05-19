Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0398FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB25847E1;
	Tue, 19 May 2026 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VB7K/ljB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06F7846FC; Tue, 19 May 2026 15:35:16 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966E4846FC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so3787939a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197713; x=1779802513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fe9nLJ+nS2XkNhsFtxCgqpLL0MojDnQ92HvU6ejO4A=;
 b=VB7K/ljBu8MPtv47sWyURSDwky/pGt54qQV+2fzVd2DoCXWGGw+PwnU6glVEEibrHJ
 k+tPu81GIv+57CdW3WYGPfPJut/4UagB6KyQiB3mL/VJr+qvrgDcSTY1hALVg2G7ZS2E
 ZnR+Egn8vpJqFKVebgxtsOV2cJi8w4WOzTT5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197713; x=1779802513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Fe9nLJ+nS2XkNhsFtxCgqpLL0MojDnQ92HvU6ejO4A=;
 b=VoIT7RCwLhIiMv70qPRY1ICj/xdzNh8mSHxJm1XKF9MbWRNTt9K2+T7euFcnmDviSC
 Pvsl3vfjSzQVJWnNvvDkFlKzdWlLRvS0q5+c+v49Xfq0xi3X1t9XVRieXh4v3cv1qLQT
 kvjy7nbSrFsJ+IBc5pHeuUSf6p1S6S0iUi42TUrdY4caxXdLZP694RGy2R8KlLFTyIKh
 jwCiZnQKvNdku7K6dcfb0YO2C7WSVB8G5twkNQxYJ8bAvC+kj8R5jjKskEXkGw0woQV9
 Lwc1MX/BgPHW2kJS91AfKAV/oLDPoE71IbwvE5NHKsU1lHtjERtLdxWdh353ai288nHP
 3FgQ==
X-Gm-Message-State: AOJu0YzoGk20r3MeqaCfFnRq5CzYKqnWZES0kOJlKtnOgKnmN8soognn
 ByciJhdF2o1KcCoqaxwO/V0bq4olR/Pa2cMJuqgLNZ2W6BZiPCkHXl+5ipG87PupqMqpMFPbUNM
 OOt1vnAQyPhPM
X-Gm-Gg: Acq92OGJL71F2wlPYdjhc8aZH9Zv9tqUKHIXEvqFckh5d6Zwm33LPQU3rFE0ZA4tzWr
 On3ZsMgs/G3OTXeXHagKkLMscees6AtRQRt+uN+vM0PAcdeLgtbL9vt1xvbOHmszy1C7Ffwhei4
 uOvk1jb2Fb1IUh9B0babvOtki41xqgs7E65iejHbh0yBWeXdQhel7msipD8cCQvd+8cC7G7EXNn
 57XiFesNauNhFMzsdxJVhkjNAZYWWgUgKTuIMckZFo2yjtQYkHkUKTXzTgHQtyqbfRdw/nlXtFE
 R8X/qMGW+upPKViCDrjhoK3u25bZPftVpxmEdBhYigjcxwBnZ+//V94rv+eVrxoXWft4n0Dh/ew
 0lN2BqhBSTbqztI9rlVS4pXhoQ4xHaNcRnzUe50Nffvu3dhKM3pJ3F0J4KrMnCFScRfZCFUEn5W
 943xdeyz8fHoQ4jNDO0Ff6/9pLP/PRbAVP+OmkAEdA+P/5bG4zzOQRraAor1A19bh/mTIeEZBw5
 nvNAOyEi/zzOwID9lgQ74vFFMTnvBqRmi10KeeEOIVyGPANmw==
X-Received: by 2002:a05:6830:67f8:b0:7e3:bc8c:5ea with SMTP id
 46e09a7af769-7e4fa0e5edamr14175162a34.26.1779197713321; 
 Tue, 19 May 2026 06:35:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260511225918.28543-1-marek.vasut+renesas@mailbox.org>
References: <20260511225918.28543-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: Fix typo in linker script
Message-Id: <177919771262.672258.2694824109669405072.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:12 -0600
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

On Tue, 12 May 2026 00:58:59 +0200, Marek Vasut wrote:

> Fix typo, addreses -> addresses. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Fix typo in linker script
      commit: 21a3b9f03b05467ec7422399a92a43f89dd2b526
-- 
Tom


