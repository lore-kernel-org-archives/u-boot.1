Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6F4EB2717
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 20:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EE483A5A;
	Tue, 10 Feb 2026 21:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bCddjGdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119CF83D0B; Tue, 10 Feb 2026 21:57:45 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE80483A47
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 21:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40945a682b5so2327762fac.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 12:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770757061; x=1771361861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+fg3kWgwPNRsVfAyx78GPSLCKGYy80+4mRYFDSjOr8=;
 b=bCddjGdKarB3uyAd3u2TAHv0y5izf4f1TR1Xerl7wJQ2eb64bWbs04jskD4OLzEaoo
 W9dDQi6rgVVY742HhP/zrRaYwYDOnLlrL2/ninGVdkeL5DZL3aq4yarO19W+n7ul3rxs
 JHg4USYp+jTfgZqldJVWGATvy1HM/s8nzDtjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757061; x=1771361861;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N+fg3kWgwPNRsVfAyx78GPSLCKGYy80+4mRYFDSjOr8=;
 b=D8UqWAHKBP/+uAX/sqvqIhiAR5YH9yjo3wXo8iZ2OgFU3GeN0xV4+srZZe2x14jgT7
 QAuij2edgWRsHd0EATdHpeME1sxKhBISC5XuoKZvGg3xCs02HP8oJNuvgBi4LYquMgd7
 bjeKwbHpB1Jm5BuHzKx0l4P1AtX5WlOMHI226F5p+RZ8cdhh5/y/SGYetbe/QpXLdf1j
 l+Y/Lao4Pqx0mwv0l0mpdaazjgXLEDUxifJicjgm1hNjwan/dLoKoUsS3UHNoRTs/DJI
 mFqtB2UwsJ3OOE/b1opw6+yRvt2opTl/857jBV6VPBRtXQos/tjLPoDAQgCAQ+GMD/Fk
 yPbQ==
X-Gm-Message-State: AOJu0YxU+GaWuAX8QsC+pebQGAUHeX0gRRJ+XqI4lYjc1phoudf1QNbt
 CCRqn2pJgKG3ciZJTJTLc0mF2lUVFRv0yU8A/K58DPyO3tHGm1oEugOMuRqZpbQtlS4=
X-Gm-Gg: AZuq6aKpbV4WQN4ePWkK3llXWtncXOTWvYCld5+ptBiGueaeTMIRzMJwDIVtk+f/y7Z
 mnor72fv6W9r2pGg3lVaVtNVH1Ldl1OjgqLhKVdU5KWi03tvDPqGxa4BNbFxedF9V7rJoWPXMu5
 ef/OBz9prLTb9DyDcaUJ57z57CHfjEZvE0K98iacCGcGn81rqCXIQHvWDWYpecJv5ie95Gqtcuc
 ux73PEL9zy3bIgSr5XH85KzbMEu/+4oQEkyAI9+lOmxgGhPJ4GrLJPH/aFdSpyRiz4cfGGbjfpS
 Y/tyezNpjw2ILu6hhkAJ/DzlO6WwsQLo+l6JePGF/PLKVg+SFrk1bHi/RRYUIzv+xUsEml/yBAP
 a/hpbRAByxnvT0TYgdV1qil4KTEnQH7VUxCWT7OAOhud5ybxgN3m8XTzrQzq7PnU9v4/J5WbKm7
 eIZhj5uGGMULw+YbcX1XPoWgA4poMLS/PeutJbmjNQcVLkEMOfrQgiN7T5SLyBiKgSwrr6jTgy4
 alZRqEfaiS7Jq2HSxBMwDp6opVBVMpGfywGWFVglVWMU1i8ZFoh4PzWJ25L
X-Received: by 2002:a05:6870:a2d1:b0:404:15b0:4602 with SMTP id
 586e51a60fabf-40e51448dd9mr1823763fac.7.1770757061535; 
 Tue, 10 Feb 2026 12:57:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a992eebd1sm11140192fac.2.2026.02.10.12.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:57:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, Santhosh Kumar K <s-k6@ti.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-Id: <177075706071.2780230.538631349378262125.b4-ty@konsulko.com>
Date: Tue, 10 Feb 2026 14:57:40 -0600
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

On Tue, 03 Feb 2026 12:05:24 +0530, Santhosh Kumar K wrote:

> This series updates the DDR Configurations according to the SysConfig DDR
> Configuration tool v0.10.32 for the following devices [1]
>  - AM64x EVM
>  - AM62x SK
>  - AM62x LP SK
>  - AM62Ax SK
>  - AM62Px SK
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] arm: dts: k3-am64: Update DDR Configurations
      commit: f5ef79fe651a5f5b4c5b8b95553dae1ceae60f43
[2/5] arm: dts: k3-am62x: Update DDR Configurations
      commit: 9ce3b50b8d53fe912f5e1a34258a20ff8d49f19b
[3/5] arm: dts: k3-am62-lp: Update DDR Configurations
      commit: 92f1f586c2a5cb85b3966ce326337e8c5b50f0ec
[4/5] arm: dts: k3-am62a: Update DDR Configurations
      commit: 4f5fcfcea7ea5e4b685c7b1b288089d97d61afdc
[5/5] arm: dts: k3-am62p: Update DDR Configurations
      commit: 3391e5ff15ef21cd9bfdb7b2e32038f622bfd493
-- 
Tom


