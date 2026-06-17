Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D460BCD98EC
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 00:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E016A848BA;
	Wed, 17 Jun 2026 02:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBKJsetN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8488491C; Wed, 17 Jun 2026 02:49:50 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6A2848A2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 02:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-69e8a8608d7so3098561eaf.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781657387; x=1782262187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQdFFUiONKGb1srghZGzabjrQ6ShI0ZOrxdWjeJMTxU=;
 b=tBKJsetNOvKM75LTG1ouw1h7X5z1xxbmROfdx+JqMUa+Ukngv0LVbCRVIuaLWfkW/6
 gL8jfoe3ZsXbEa6AEl56cIhbK3fu3Hk9Bp6zXfjHziAHsJAQfpai3HeU551FQADWaut8
 7/bIe3p9udU1HqIM7b9vKKOBUuq5PCmLliMEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781657387; x=1782262187;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sQdFFUiONKGb1srghZGzabjrQ6ShI0ZOrxdWjeJMTxU=;
 b=BaOji1fVs9Um3Kv3F2Ldpo6wbRytbf5W/QLZdrJDPVyCOP2WURh5FnrNt0T4aUUSE3
 HyLE6IpnV9QJjsExngeKbCaRKEf0G/cMh4N6eD3Ca0af18NlZ5ENN7v5ZOp8XIREPU4D
 1X+oKaJNDTu+42XNKZdJCQvzI/cFbj10m1oYV4mr0yXS3CWlf9p3MT8OIn5pIeK4Kuk3
 QVS/7JXcZKx5OnOZqvsolshXu74J2ujuzJ4CD9lo7gFY6q2TGVJgMRUyrG5RF8JQC7UW
 i6jbO89vYdlome8oLW/qwqwvmRXy6tnbzNnSs4/BK+Qm8/YTeY+chKHG8beyoZDZxTlW
 vr+g==
X-Gm-Message-State: AOJu0YzWBKMBV/7HoOpVS02kSVe9Rfi5R9LEFOSwtffcShpZRXz67wyU
 fNEsshKTjSt/oBzo09CEQvPyzzNbNv5/26rtIuHb+Xpk3dVLhL1jDmaNGKBwqbgksLE=
X-Gm-Gg: Acq92OFBhw1ZBJnQcLXNqwE6e7mgSXl2HRB1kJLuJdYJ4lL2YrcsC4lHtYSQO+D5euw
 HxPmcNiPvCtyiW79wOI4WrbjiWETrHe0qhENPHx/3XLgKR5//PCA8xM/5tTzL6Ikx1qJbTpQZX5
 I0VwstbFf8mcna9oRmOb1/m8XwN8ri4mktVBmkOuFFGWpt3qheRuxvl3DaeQadxE21oPMgb7UXp
 Y9xYvfpI4fVRdyPnMaG7fTjiWip1yl0Iph5oBnuNVBcOsRwUdlJdE8RKvTsPnWZN544uQsfQtb8
 +ocfAL9bYE+LwUDOTVcYjEYXQvVHbdKK3iq3os0SYEGRk/49/NhupmXF1+FoxpkcewkJyPt0Ag3
 IIM987f80OgYV2gce6uaSekjh8LiZSIXDKfXraV8r/x7t0rv8KUtT9t1RCiScfVdrUBjk0pAiTV
 xvaIe+1R6oVCg3WbJ48KJV/6OUg54PS0Ls2HbMlMfyFvVRn7DBBxBnlJe0HQkmCYm+1xMf0Llzo
 r9NJQyyLH2xAP4P43lPWECbX2wADeHG7ttn4doOyCQUW7YpYA==
X-Received: by 2002:a05:6820:f008:b0:69e:3bdb:70f5 with SMTP id
 006d021491bc7-6a0b6273106mr1163651eaf.55.1781657387237; 
 Tue, 16 Jun 2026 17:49:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00d232e1sm6065348eaf.6.2026.06.16.17.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 17:49:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>, 
 Zixun LI <admin@hifiphile.com>, 
 Colin Pinnell McAllister <colinmca242@gmail.com>
In-Reply-To: <87qzm6howq.fsf@kernel.org>
References: <87qzm6howq.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260616 into master
Message-Id: <178165738592.1775771.3347444426770509599.b4-ty@konsulko.com>
Date: Tue, 16 Jun 2026 18:49:45 -0600
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

On Tue, 16 Jun 2026 10:26:13 +0200, Mattijs Korpershoek wrote:

> Here is a PR for master with some fixes for Android, Fastboot and Usb
> Gadget:
> 
> Android:
> * Fix A/B slot selection when marked successful and tries = 0
> 
> Fastboot:
> * Handle partial blk_dwrite() as errors instead of success
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


