Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C12CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 14:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA56E83642;
	Thu, 30 Oct 2025 15:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LVONfjkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D2A836F0; Thu, 30 Oct 2025 15:02:46 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4794F8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 15:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c531b42dbeso708953a34.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761832963; x=1762437763;
 h=content-transfer-encoding:subject:cc:to:content-language:user-agent
 :mime-version:date:message-id:dkim-signature:resent-to
 :resent-message-id:resent-date:resent-from:from:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3VHHdE6ZGloZ+XS+fZklAus64krYPhouX4lqFpySgc=;
 b=ncCBkgBfzM6vDKLHR+TSCoN9ZIt3/CfkBjMVOSD7I2FBfastF49FfJZK4DrSKXosLB
 BwYN2I9A+Xh/OVKYzvSjSPY0XPAFO/Zpa58jrNb0ZrqKI0YorwuQJ8Hd2236RMcc2KtZ
 G4We5bcA1ZUDI0l3vh6WfM3iJAbGzYaXEjfhrvb0JBTrrcrU1CVtFDDzG6ZTAYG/bZuM
 GmjVOP9AsrNyTZFBsukmVZOMIY5WwBTa+NEllCh5/neBWSk8yTaLri/Duvq6gfqqne32
 ezJCS9kYb8dSUzdWUQcaheLwwNmSD4TRByoBWbvRKzc2KfzPiJKM9097hsO0cqW6nHsI
 n7pw==
X-Forwarded-Encrypted: i=2;
 AJvYcCWkP10GEzlzRTVbiwgNAdGcnSBR5fvOowEHIbAAmcg6LL6U6eDMI2cbodxI4rd3MaZhhx5/EQQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwUtS31XhcY9eHlhVbtKsGgdWKPZQTlcfTkqRUfPuYCsLQuHLCM
 cW4OhIPHG7kSuqg+hfGgF4EzMrSo8hrdILXni9xawbhIUl+VAHyDJHz2aCCOaHM+/kH7oeqxFVc
 eWthyfCuehw==
X-Gm-Gg: ASbGncvQAzCrUQ6++26TMszWNJedncmjWb/7tiYUcq0gDuYZriADGbkowsItjQP7ofQ
 Dww7OafOa1OVR7LA+7830Qt9RqkDL64SCv8k2rZq5jyt+amQt7CKqm4fRpsXijhA8DBRQEFGxTR
 YmR3fzHKM0bgjXJ3bM+bvTGqvATq9sO41ekppsFWXrLn5atrSOVR36dpn9eW494z845eDT7FZ2b
 u2xIF/f1Lc/mbWPKbhNFND6cTRqQzCG+cYot1LxpIjIuLDsljlKbQPCtDN70qvgOxHqlL1zKGaX
 +8IdBWKH9apVTPPL/xDJcj8zWb7T8mMBjg9dA2nrbJcCxrlruYowZ7/K4cM4JRV82B3gkrM1ePf
 0fI0+LEHkdNky9BaFttM7olmOPiRmbLxo8oPVyCYFFtnRYuz2ukYFXjRc8br2FGwb0KTZkehcYM
 aj4AQE4GsKYhOM28vx56w5p3jyw2t7rfRJELtdqR4=
X-Google-Smtp-Source: AGHT+IFw2ShxEFYpR4/Ga3mxeZHJ09m5m++M90olU0KtuMRhS2LiPcwyWtV0n++ziQg2qtd5oFDPqA==
X-Received: by 2002:a05:6830:410f:b0:7c6:8c73:ab0c with SMTP id
 46e09a7af769-7c68cea61b5mr1704471a34.4.1761832962377; 
 Thu, 30 Oct 2025 07:02:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068d5sm5126057a34.28.2025.10.30.07.02.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 07:02:41 -0700 (PDT)
From: Heiko Schocher <trini@konsulko.com>
X-Google-Original-From: Heiko Schocher <hs@nabladev.com>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Thu, 30 Oct 2025 08:02:38 -0600
Resent-Message-ID: <20251030140238.GT6688@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:32b:b0:ba:8f80:e1f6 with SMTP id 43csp946846dld;
 Thu, 30 Oct 2025 05:08:30 -0700 (PDT)
X-Received: by 2002:a17:907:d29:b0:b6f:198e:c348 with SMTP id
 a640c23a62f3a-b703d5392demr612201566b.46.1761826110665; 
 Thu, 30 Oct 2025 05:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1761826110; cv=none;
 d=google.com; s=arc-20240605;
 b=FLftam67/hRCnsSiqqMusHxwj5yfYEPjw4+7cQ2B9uxiejz4e4bgi2wi1xieQuvMU0
 4XcHVfKDlPtGY+P/1n1KDDi51xk0xYUp4x9xAShTaLO8/eifS5DlZmiobqc7kFV5uGMV
 wu3c/kyEDhwyXriE46rFUX8EyaLdtjqWam6ujzB9iQT2ZpTr4TWrWqimOmXazvH3lTW8
 FoIDc3DBYY70pB1X6+8ZgQB0+LCOlyWe1P+hzHdqJQ8U3Ub4Ltfbu80matDVSdzmqox4
 Y6xEUQHkrIoX8otBComnh17oc7DEwxRqPAhDG26QPbCdxtOKCrxiImvA6ko+rsnUYAng
 cViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:dkim-signature;
 bh=/3VHHdE6ZGloZ+XS+fZklAus64krYPhouX4lqFpySgc=;
 fh=EegZwyrwIecF0z4NTMUN/qdt2e5XQDJysXXeJK4IZ44=;
 b=JbkDY79Zqgi7Ia34Ibzj+/XVs5cX8KPSLRpOwCdi4F1+XmMMnPvXyPao1M+meEiISV
 N68ZY0GWmn3J7n+B7wtfJB0xdQ4An5TPY4yWbqnOvIoNtCJ+sCbjDRvPOzswZXwaP55z
 c3AoHQYGJucdIoBlUyPoCopk702NYF2V410/K/9H4OdDI6mXo/PO++ztUzDTcDYFIBaa
 OaRx8+5bosMH1cgDFVE5POTjz2ne119Y/AYPkooTJZajRQq+zDma1acBL1ESOnKl+0rt
 0oUXG19GYnlTywqbKT+gkMvvl4qLIb28HESnOqAoaQefLoPfPcyWsUeTGCWTlWTfJWhW
 x1Og==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=LVONfjkw;
 spf=pass (google.com: domain of hs@nabladev.com designates
 2a00:f820:417:0:178:251:229:89 as permitted sender)
 smtp.mailfrom=hs@nabladev.com; 
 dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=nabladev.com
Received: from mx.nabladev.com (mx.nabladev.com.
 [2a00:f820:417:0:178:251:229:89]) by mx.google.com with ESMTPS id
 a640c23a62f3a-b7041c713d3si238956366b.401.2025.10.30.05.08.30
 for <trini@konsulko.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:08:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of hs@nabladev.com designates
 2a00:f820:417:0:178:251:229:89 as permitted sender)
 client-ip=2a00:f820:417:0:178:251:229:89; 
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6BEBE1092FC; Thu, 30 Oct 2025 13:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761826109;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=/3VHHdE6ZGloZ+XS+fZklAus64krYPhouX4lqFpySgc=;
 b=LVONfjkw+X6PyXb4DzduggDKjBrSBOE+mVLB0210Bjlab5ydYOklxaEwRz/vRB2+0VUCaT
 +dg3slWC715gZzhRycaX0mOPXZTPLp6Z2YkvvV8O2EG7eFg5mYq1osUMHnYRPQSV7TY6Zs
 wyxQw5nj9vRp/xPtiMysiakTEXd9QGfJHAgwA0KDxkz40e86eK1wwWctr2qK///MQdQdF4
 i0JIZLNPjZ6+mt/KzM5dK0Qk+EuPRU5RcJ2rM5w5r4XK/ZQHvf81ZGLd8+NN4YKHTCaq+E
 74ISza10wjvHMPCdOKaNQ6tXj4wIwvI/i3Gx+G9d+vVO30r5HwL56UZfCQZKcg==
Message-ID: <c720c9ca-22e1-321c-4762-74fa37f61e59@nabladev.com>
Date: Thu, 30 Oct 2025 13:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.01-rc2

for you to fetch changes up to fc7d868327439c4ea6c640d2e8fead7679c0b86f:

   i2c: rcar_i2c: Add R-Car Gen5 support (2025-10-28 09:51:02 +0100)

----------------------------------------------------------------
I2C updates for 2026.01-rc2

- add support for the MT7621 I2C controller
   from Justin

- Add R-Car Gen5 support
   from Minh Le

----------------------------------------------------------------
Justin Swartz (1):
       i2c: add support for the MT7621 I2C controller

Minh Le (1):
       i2c: rcar_i2c: Add R-Car Gen5 support

  drivers/i2c/Kconfig      |   7 +++
  drivers/i2c/Makefile     |   1 +
  drivers/i2c/mt7621_i2c.c | 374 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i2c/rcar_i2c.c   |   1 +
  4 files changed, 383 insertions(+)
  create mode 100644 drivers/i2c/mt7621_i2c.c


Azure build:

https://dev.azure.com/hs0298/hs/_build/results?buildId=189&view=results

Hope I made the correct setting, so that your b4 command works...

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
