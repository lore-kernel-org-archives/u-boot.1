Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2DFC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E696E842DB;
	Sat,  3 Jan 2026 00:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MOo0C842";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8093283CF2; Sat,  3 Jan 2026 00:23:54 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CF0842C9
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f584ab62c6so5248966fac.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396231; x=1768001031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JN7Uzt4wXgs6O0a25zlJcjl2B/sRWYs28NJy5vDKvDQ=;
 b=MOo0C842eV4PgXuJp4XgiFIRe9JAVcywSixYN4rGGxcHIBh5RPoMWAwDyonMkL/LGR
 rTbnKyoxm+FPGCayC0d+Y8QVDUYJSs6sGBp8DWJ/2Nm1q9FfyKnAzUzV9I16hExNcEbT
 LteD15I5A9fR1XVJM5VSJNHkXc956g5K93kxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396231; x=1768001031;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JN7Uzt4wXgs6O0a25zlJcjl2B/sRWYs28NJy5vDKvDQ=;
 b=xHSjwujZcVsIGYc3EEXzaGwno0DD+SF+eIWBXoLTvV+xf948G4hlIyoC+xkkqBvV5u
 /x9SwFK4PdvfiDuPXORiUGbrsLR2gZbOV+IT5dSsDya87pv3KWEaPR0PPLkYzeiotJSG
 r6ks5VGvy29DFQeiWxYGHZOwac4N19N4fFFKuLexy46su0KZ+ha5KV/AkBlo6c7mvgKR
 vD2mqIx3SfPKS3PvyT++rwI5+eIIUo2lO21Vy0Qdp5SY7x8ue/f1q+Z1yX9HQwETT+po
 oLK/GIeskMKlxiiSl2yYMNXjaWyWeH7494XLHE//HGuqFKdHfuJkg2nmvhftQF5bXF0v
 Qu0g==
X-Gm-Message-State: AOJu0YyVxvuxZu4t+v5q02Om3357vS87qYUEYBsbyVrzlwPLEsLr1PNz
 iRBbPfp5zCg5xHWUlN+Ao1q+rQwcFOE6AFhLPApiXhIrnI+cjEAOVkIQvBSNWnoE0zi2l+yVCZ1
 71+8DSQY=
X-Gm-Gg: AY/fxX5QLaI19vQQk8aH47eC7uIh//YUgZ1g5QPvPiU6V1b9ju5fO6yR/BkNcuPCrBs
 Ln6FwPjd+FiTcMyZeeh+o30Kbq+YQ2XPchjLif0Ke8LoU4rStsUi06DttRCOV2ynYyEQBpuz4hX
 P4jDG6NXZpvlKsj9BKo+hne76E7FaCeG4lW05q6MOFuDlomTJUtrio/K63b4RQHtLENlWeefEM5
 XmE7Vdgeb4PELRotWMplNsfvCraDag8jmD7Gad7i/zHk1FlFTKiwviaKRo1WXr8Ad+23w/cjDRK
 22+4PAYS63Am0Xm8s35DPmNqgv/bhS0BmjoivlUGs3/atDF6BxMZC8vsFoFMOu1NwkUv+/COucg
 SdjdR2atEUMtAwpjvZ62vhIHCc6RhuR27TVv8KdR9HofArHBSmT+30uflk4J7Fes5Mgcvaq3R58
 QvAfttpMJogkH+nFZlG1KzXAv6TUJhgWyM26qwLyXqSe3dwKFGfzaAbdm45Qe+Zt8Ia4KaIQVgX
 Gq6KWGMKOUrRazZu1I9j6imSjGZVz49RA/Tyg==
X-Google-Smtp-Source: AGHT+IEE/U5wpBKO9+++6Qfd2MvjG1Ox7d17Rh2HzIrO+bo56si6Qg2yzA6W5epQoP3YMxnc788AAQ==
X-Received: by 2002:a05:6820:6fd7:b0:65d:2f7:6eab with SMTP id
 006d021491bc7-65d0ea4a5dfmr16002261eaf.32.1767396230824; 
 Fri, 02 Jan 2026 15:23:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB28058E0F0D6E468ED7661716DAA8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28058E0F0D6E468ED7661716DAA8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] cmd: onenand: Fix handling error path in
 onenand_block_test
Message-Id: <176739623001.296893.6375286944600113813.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:50 -0600
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

On Thu, 18 Dec 2025 07:48:51 +0100, Francois Berder wrote:

> If memory allocation for verify_buf fails, then one
> needs to make sure that memory allocated for buf is
> released.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: onenand: Fix handling error path in onenand_block_test
      commit: 5e7624979083e2bc163e18165452d8ead462b58c
-- 
Tom


