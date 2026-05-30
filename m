Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A05CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F9084704;
	Sat, 30 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AHWq4bNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B662846E6; Sat, 30 May 2026 20:37:02 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1541984693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e690c213e3so1542627a34.3
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166219; x=1780771019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0Nyig3lNmEVWoCPgnoCotjMPMsu80kXndN6G3yzgeM=;
 b=AHWq4bNSn0kRcsWJBk2Y9YVwloGqWkQEZpkEyKOXkqgoUK4hXZ7bOFoht4f8fRJMh/
 ZU8lsc+mwaLbmvKagyhqOgIjGKpmICCopyJgGHElTK6TbKg3pF28LfkvP6I7FPX5DhBP
 efnw11a+20pgmNNWsm1hQVnat7GRQeK9TCjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166219; x=1780771019;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0Nyig3lNmEVWoCPgnoCotjMPMsu80kXndN6G3yzgeM=;
 b=P3m7idyurxCb/JwSYxya3gzLAMQQr9S6gvFLeXeFgITp2C7JHiHRo3s3cSGxpxUAOj
 9EFVWXD0//5FnVMAMQlsUh3Mi846cykUXHCI9S9EQTew0uAuLwJiX/A7lAm8w+ERgweR
 GDyZ90lEUZmwB5qBuxb3d4CiJLbcoayb3dD+OXuJNggI8Yl4qMUyRcfEeJfkiufdIkrG
 Bf6b28guRIJdG+4uiW0Rdn3ss0yyoWWsV06AZtZt2PH6Tr7aAcI7+TUxxQE1sjlW6BXE
 nNKQNWZFwtQI8ya7Kz0GnsUiinsTWWeZcL91kfcbOTjE2MEivW0gshf06dXMoQDi4Pr6
 W7Hw==
X-Gm-Message-State: AOJu0YzsuyS3tDb/5LxFawd7jMH41eimHYNyEnbKOoQWmTejT6PPeTes
 03L1dp/MYWE7ZAHQWq9zt40VIdBI4ToDieH10+kNZCIFzu8Y6J57FXaylEc4SIOUz1o=
X-Gm-Gg: Acq92OFpPy+n/Kig2Gmae+va58pyxdCzhFwfvFWbBfEzQsueJL/62fdwapjfRjrv3zn
 vEaA+zX3KGwDeFoPtjcJCjofo75eh/0nGkK+Lodn9B1p+Ozrnmn/BNrQhG6h5oqT0hqW+8Jn65M
 cru8YXJMmm4mxdnK9ybSAp9WNuDQKeeqrYwly1uCtNPwuVOnzh9H7Ekr38HYAJGZu1IYH1lt+Mh
 Nt/1BdxGDK7GNOspDW2hjqpn/rTAL8PpuHJoor4dziKH4w5rKQ+Cz6yNR9G8JBGOcdEoR4ZA+p2
 MivynnIIvQM5xK9ru/Qz+6PylQ+aZlD9B33dQObW6NvwdRuJirZKLSGxt5xZ2CTB5yDKoOqOow7
 aUkMZl6F7sDHMqlyUxkPtm7S1Z25T9cOHlP7tDkDihMxK8YjUrA5AEamhRRFcE+pL3s4B/pEU0s
 nakMM6HtpZI/z+irIyZnriWemy/xZrUVgxAVjcvZDYvbYWFBt4mF+s1oOXOMPNDv90N+s0DyPF7
 uZOoEtBphZAsGKlJwV0hqiNaLEykIoCrvaB9XA2lkvBeTIRS/oBBP4=
X-Received: by 2002:a05:6830:618a:b0:7de:5bad:ace1 with SMTP id
 46e09a7af769-7e6a1dcad2emr3026447a34.12.1780166218883; 
 Sat, 30 May 2026 11:36:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20260408-simplefb-map-v2-1-c0a8dd497582@fairphone.com>
References: <20260408-simplefb-map-v2-1-c0a8dd497582@fairphone.com>
Subject: Re: [PATCH v2] video: simplefb: Map framebuffer region on probe on
 ARM64
Message-Id: <178016621811.1038765.11742842375081490492.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:58 -0600
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

On Wed, 08 Apr 2026 14:04:28 +0200, Luca Weiss wrote:

> The framebuffer buffer might not be mapped on some devices.
> 
> This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
> any other architecture.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: simplefb: Map framebuffer region on probe on ARM64
      commit: 1c8b592611fc7b6bacf10226cfada6620ca19011
-- 
Tom


