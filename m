Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F5D7879F
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 19:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5E4833C6;
	Fri, 19 Dec 2025 20:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aIRw6joi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5C183642; Fri, 19 Dec 2025 20:51:50 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E2C8334F
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 20:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-65cfb4beabcso1207466eaf.3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 11:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766173905; x=1766778705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SixjM8LCDtsJOpY/P7eyM3bvC6T+8JwWxE72Agk+4pE=;
 b=aIRw6joirQ8DxPxKc+QtZSwtkzq6VGT1r0H3/BeHo6pAwPYtc/AoblKTs/LUil+a/6
 qIqn6UQjV1pPDByrKw1EUPOnBQM9LjZsByUjVaySq+6EFalhsQnRXi0+tXdgLLUO4dtu
 9yiBcnXYkTz3E+31UXkrp0T+ICm7jZcrM9NGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766173905; x=1766778705;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SixjM8LCDtsJOpY/P7eyM3bvC6T+8JwWxE72Agk+4pE=;
 b=AyKAg4vgqKs3Dx/TeK1h7S7acEvcE69KdnQgepAgoeGQT/PKJmTtfEi0JMAtHdNbPH
 G8H9nhCgmpTId+MseJwcfMkiC1HWAhm9qku16Dw015EF6FZuPqLOFl13xBccvtzsHl7G
 36Uq+xsRmh+bBqzxd5fMdlWwAx4ANrvSPcP2nzyx3dEZYXJ38Pnn6G7M63z1Yez7+sf0
 I4RepFL7vCYPZCvNuNYIQVKSxmKpXt6DIIYNOFrh/h6cn7q4JslMAD2tU6uSJEoa99Nb
 Zsd7wUUIXvJuDLelzvF73gp/Fw/Sph3MRJeum8YWMn9TF2fXuBe1hJxLZhSE/QrsoNA2
 89YA==
X-Gm-Message-State: AOJu0Yybbd8kHMn16jWlqsk4lcJv3PcMaLe98cZkLQb3H2SEWhkxe50L
 xf6Uy3H27jCL9v4i6EiRYM1GxqJpPqh+YNbO3o9x89DVT6cZBqAe/caQLnhbpnXt4ys=
X-Gm-Gg: AY/fxX7WsMiTh036gcPrg4bnfX55NE4L9xUoIonxEl8lenqH+Oh2HUDy0GW00gFXx/n
 OGh2FOSWJZh8ge3WgZ3sB6NAPsQe2vghLHyfB5L4s4pzyFC90H4KhmLpNS+pz4ROZeXs0dyjaPd
 1kto3eKk6OKTdo5HWrd283scjQYSeTOZzE2PodLhk+Sp/LazlNAeCEoXJT5AJllWPPW7cnEBhDr
 bBJuYB4x9YbQGvb21jZosO99Q/kJTfsP/3gyjw8xSdbrbFB+4jMwQ8cp8wdGpzOL2xELqF/z9qg
 PksZu/mdmyj7kj77+MPYvovSaOWW2zLgha6yQNgx1lrDOTc8wtL6xPQ58rZ+cG7KT+6lNrDgjRC
 CWKXWJ7HXhGv9fiBXgw+0s1APY0wCzy5LBiiJG2iE8xjmjvXRdS1ODympc20p4YDp8o4zHf9moN
 eM6sFmZrt6xlPi3bLeo44dVlY0kJEh8F+JXDZt8o1z8p4olb2w
X-Google-Smtp-Source: AGHT+IGdR64yNBUQCs/Zyite4zk959S8Ck9O6fmH26LhavhiS5YKz2qIec6Fc/p0qZoqDwkPPkO1aA==
X-Received: by 2002:a05:6820:1628:b0:65d:ba7:f659 with SMTP id
 006d021491bc7-65d0e6c358dmr1769296eaf.0.1766173905033; 
 Fri, 19 Dec 2025 11:51:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f46c775sm1899236eaf.5.2025.12.19.11.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:51:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <21930cc8-6895-4722-8caa-9d222a4d563a@monstr.eu>
References: <21930cc8-6895-4722-8caa-9d222a4d563a@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026.04-rc1
Message-Id: <176617390438.4176400.3283567478608311669.b4-ty@konsulko.com>
Date: Fri, 19 Dec 2025 13:51:44 -0600
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

On Fri, 19 Dec 2025 11:54:32 +0100, Michal Simek wrote:

> it is time to cleanup my queue. I can't see any issue in CI. I hope that
> removing cdns,is-dma property again is not going to cause issues on other
> platforms that's why I want to also get it to next sooner rather then later.
> 
> There are multiple patches related to UFS which have been sent and also some
> other platform related one that's why I expect another pull request for rc1 in
> future.
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


