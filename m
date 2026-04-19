Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903BEF99C98
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 00:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B56E83B99;
	Sun, 19 Apr 2026 02:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HasPlpou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAE683E81; Sun, 19 Apr 2026 02:38:33 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB37839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 02:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso1059201fac.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776559110; x=1777163910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCukkyH9Vw1IzlmV9wgPs7ps/l3XMYhnA5KVcsJPubo=;
 b=HasPlpouN8OTdPNOivRzsICcNo3EUSL1UZZTYklc+Agng8nTu5DclI8xvN2K677IgM
 A9tT8Sroi55desKskaPBqNqYpaSYkyqiXydOAA2s1wuDZsG7ngREmj2HRDCKTHVHWuOM
 dG5cLdX7+PcK+JAn5wOV3k+gUyQfMo+/BpP6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776559110; x=1777163910;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oCukkyH9Vw1IzlmV9wgPs7ps/l3XMYhnA5KVcsJPubo=;
 b=dzxCZWUO+hZ4DT8uFkwNTD7u8Pe3OjA7Uq3aauMqi67UhHOBtgQ7SDxfkmz/2TXbFg
 o0B2mFLRtaF+TQ3iph3xin0kRnbJ+FNo0kJZ2p5MLLNcvn87VLInPFZ3aQ+R2LpRdvc6
 sUh9yLZtet8J4l32qwEbIEFRK/G7/qbzYzD/a3l9Fapnh4X2F7FsO3twljkJ7VEtMvwk
 cFle1uRCxZ9WBfdFSqrwviAX1p6tquExQEnMOQFV/oDUz/q1w81civIQDmE4VGnYCoNO
 3/hzzB/4x1oXVflMZPDu9VL3gM4d+tBA7Ju8a+sgt/KOqvmr+uTgeOdObiGaOss3wq4S
 Carg==
X-Gm-Message-State: AOJu0YxNDINrR7+9hJK02xtM8TN9vfiaQtvzcUxY0m6gi0M5+PHAc4/Y
 54ULdzodYRcrZC1hHHvxqu+CmMl6wHQHJR1iPO/SlB3UYLMcVX18k0ehLc0sdrp/n9550s6NH/S
 YiGA2koE3pA==
X-Gm-Gg: AeBDiet0tf0oKNmYdEA5464dh4PpoxlXLb9ujmr+MBuOYg8zjRj2/MPe40hOu0j7yZr
 h3jyq5t8khBrJN+yorL2FPjqB0zhJSIjs6/ByzE426TcsOtWXXtCyRKnr5mbiVCnpi5lynrS/Ru
 /kWocZXuhK5FFYsNQM9MiCCsN+uxvxG7edIS85nUbyFAE3UVDtYBk+dGtouAvY8I7AW9HfYvTZp
 +/2paECfRjJ6E2N2bJcVZfIJ0RhR7ksmZ2jwzWYOSJqh2B2bSG8D2ZDzMRV65ie+npIrD0pdQID
 mzGYeXOiiJCgiZbZ+L4R7AIH8RlRI4zaB1cjg/nu9yJ+/qj6UfG0BxYVt9wIKLBBWLp+3X+vHdz
 jyWgT/eXtM/yRMOykFcABliCjskFU3W2cV+arcMDuUXb87FPtBaOVD2TaNlkqnAowgOT8k86smO
 MSx1/z2BgjGOeUc/SruHIGNKhhADTwlcWcxEuldeiAeCV9LDwWOkDPoz+aAhuVl9HaUDcZaQKrA
 UEoyY5sic1fx3QQTFG24v6KbcEk7fEKlMKuFvKtzEXYkgfh74MF8zFtJGlm
X-Received: by 2002:a05:6870:e95:b0:409:68f6:569b with SMTP id
 586e51a60fabf-42abf2eeee9mr4728425fac.12.1776559109853; 
 Sat, 18 Apr 2026 17:38:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a13sm5423461fac.12.2026.04.18.17.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:38:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260417221324.956193-1-dlechner@baylibre.com>
References: <20260417221324.956193-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-master-2026-04-17 into master
Message-Id: <177655910890.1834815.15692640376749826266.b4-ty@konsulko.com>
Date: Sat, 18 Apr 2026 18:38:28 -0600
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

On Fri, 17 Apr 2026 17:10:48 -0500, David Lechner wrote:

> This is the second wave of feature enablement for this merge window. We still
> have a bit more waiting on review, so a 3rd wave expected to pick those up when
> ready.
> 
> The following changes since commit 30429c8bd2f18d33862cc41fe520f7459fa4bfbd:
> 
>   sandbox: enable FIT_SIGNATURE (2026-04-17 12:29:16 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


