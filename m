Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E571CD6E57
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 09:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F47584868;
	Thu,  4 Jun 2026 11:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2Readg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279318486D; Thu,  4 Jun 2026 11:59:40 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11C184881
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so893408a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780567177; cv=none;
 d=google.com; s=arc-20240605;
 b=e8i/vXlz/mrTYYSj5C3Ttpj0MZn0uiO8lhwodB87TmjhSxD1Kw6GywRylytJ6WnMem
 vS/He1puOWsmUu79Xr1vap0Z1mkxuheBxPm4w7xW/Df9b1vf4xZkv2G9KuHl+Z4ysFz8
 KwoqViQJb7pTVtXkB7FyNOQlZ3F3BqE0F6JKFvc14N7PVIYr6FPz31dDuzuOQYRw9UPN
 rvDKwgv6vzTemI0F+qd3DxJE9Mb2b37EpedLgoAjJAevqWA3wjNC8yTA/4DiUFtSTzek
 IYgn6Av9+udqW5l+DVg5bFLblfZgwhgIuUFdakAivzSI8qLgs7o6wpbMlBDvGV8JtrnW
 tgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=06Ollbs6Gd+gDqSfMY7xl/xnRDVLxDlafSCIHtaT58k=;
 fh=GfWZakQ1bBMPnw0WX7meagk06YUXvgM3FJU9UUlWBZM=;
 b=Wej9jtduTKqVCtXJDEEeQuJUCQn5CC321RQhmak6Blq73Uv//n5ObuUvYVDPREc7cK
 xSInncGS7qOOaYcPOT/zvd4YzG1PbwAa84Pp3Ttkx0LhVdjbVqJGdYTuXOLt3WhbBVo8
 ySw7SwSZE3wIGAbXL52SwX/wzrD88aG6zBP56yIMYxKvUhQKw1yB02l3fBRkLgvgUsZk
 egCz61T3HIdBCqx2+oVr1L/8sfinUpMAVIrE6p2EeJD2v+k4Ocex0uJLhtaDAy1llSt1
 in+eRjcaaoeyoRIVvm93Fc+O8ea/D4E+cIjhqwn26qelUDQl/AUQ6YWO3HPmJdLs41oj
 pfGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780567177; x=1781171977; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=06Ollbs6Gd+gDqSfMY7xl/xnRDVLxDlafSCIHtaT58k=;
 b=G2Readg+hiUCbyS52RKtS898WHszUnSIgfQi6C19PsMb5HWYXGEf6XpDlTzxe6xcM3
 uKEyLg/jU3ayHWNeROEHtjSzdMWcvT391Lls4crdLD7qBJFhz5P2imTU9vSAAzrASLxv
 f/ttO/JvkOxhomKobmx/nvc7vexA4IiGHWSe1dIpRWwwtNMizHtViPHZACn6yFhTbpjI
 i0XdFFfM1ZTnITynmOn71pzJwgj1ILs/lTHlD5PwwA+QkFGDClyawyUI/eX3pQ6exfWl
 zhM9dXXMYstRqKQrO0TpvyKeKaFSCldI7XOSntD6eb+I+puStFiPrIi/T7RZ+LL8AeWO
 ff4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567177; x=1781171977;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06Ollbs6Gd+gDqSfMY7xl/xnRDVLxDlafSCIHtaT58k=;
 b=KguzjzeMaqiCWGCkCNJGC0WP/mKTZcRu9oJ++MkqiBCRyUfZ13EjI1f5goAoMuhe2P
 GIsMivR/x28/9zkQMbnXQkVplLPY5C2ocsyXVXNGzaar6U/3rQcjD01ZgCH/lIweAgUA
 oyiSkHvj9guM4msNRHqlZolweC0868ZBEvuM31H5M0x77RurSJM6BOfDyPNA06PoxwMH
 vdUOjcrY+quP/maMCY64aFtmMG06UhYnZ+SFA205cypIMnhJCZa8Id/6dRowcn8Te7OL
 uVhRboapyW4VJx2jLp58z0Q71AjwZbrbIL9NS4onzB/jHIk9pFk8vPMFLDfgrFrv4T5G
 fnpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81qBObPi1pNc0E0/M+vc6LogfllGR756eRBO+lsTTXul+G7LmTdHbpUhf1QSxxn0e+pUEAX70=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6l7yQ8XZjQICVTZfVKGGnhgcRAXBSXDaL9j4jRc2mdxcGljbb
 E8A1+0TgPKB+fCD1jdBbAAaEsShyMdjoCHQZsTqax0sMuBvULa4JolPlmT4jlfiDUi5JaF0vgwk
 2Sd0FHrpyfJBUu6YWDFMgL403K9Ud059b/F+r
X-Gm-Gg: Acq92OGhYEuFC21cAL3wd0+E878Iq7MyY4OBGF4Sy8sr3aBumqua2T06FCUUldMN22n
 766VG2lJU3bRWtVwhGwvAaitdftFqPS49M+r/bvM3WU3hP7V1Ht03TZIt7jIMu5+BtehtOYsg3l
 le74nc+CUINOrrawO43ZlA/WMr2mDsP6P+UkzO4IR1/7TbUNzlZqjEI3N3PY797SE5zgbkOr81O
 t20o0kEGMigH4ZofhFkz0t8SS5K3Vjf2lUuCxJ5JGkVJMujSGE8AETB2p9w9WcFJF9S6ZKezB7C
 5HLgJLtus2lqdkSbci3tnM9finpQvOTudvLJn+YrRAWFqC+bYimKbjkWkizNPn5v+L8wGuELduO
 ey8TfSdfyoc347q7U4hgnyuikBYnNRDziQ5UtplMJ8ASTjDC4JErxnBHsjyVLSDRRKJq8BpZt1+
 PYun8VtFvg2DAS
X-Received: by 2002:a05:6402:3586:b0:68d:6399:519b with SMTP id
 4fb4d7f45d1cf-68e6e8346e2mr4689839a12.1.1780567177050; Thu, 04 Jun 2026
 02:59:37 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 4 Jun 2026 10:59:25 +0100
X-Gm-Features: AVHnY4JjapIwRpdrX4zjkQrnIhao1i-hOIoeFTSIVJwBod8mGXM2-Ehc5PBcE5s
Message-ID: <CALeDE9Oj2nfe5PLpjyCpOPr4vOrJTXCnRZgZFD39RinA69C-tQ@mail.gmail.com>
Subject: Pull request: rpi-2026.07 rc4
To: tom.rini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Please pull the updates for the Raspberry Pi.

Updates for RPi for 2026.07-rc4:

- pci: bcmstb: Support for bcm271

The following changes since commit:
76d62273bc8a5dc126ed79ed0fb65e5a97359577

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2026.07-rc4
