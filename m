Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C7CCD194
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BADA835B3;
	Tue, 14 Oct 2025 16:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X+ObGE+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A9B835C6; Tue, 14 Oct 2025 16:20:38 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422FC835B0
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6502b1085b1so1385360eaf.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451635; x=1761056435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wrQKCcZ3VP1T8hNaMcttgJw5l1XKPR63XKuxNOrcN5M=;
 b=X+ObGE+chegtPrvTWanV/niIZiZrLkTlNtEu0E5eUF09LuyQudArOubttqcnsLowId
 dAkqVhM2cyKfhfLO/FtqMXOIJIu/OznQ9s3qmTYjwnm77IaSDXIDJmrzY57ti9WXSpGm
 s164HfqIGEJUN3i0CjaOaAOpPuDbGammduYwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451635; x=1761056435;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrQKCcZ3VP1T8hNaMcttgJw5l1XKPR63XKuxNOrcN5M=;
 b=RFowSLRfdU6xwYGAUlAH7fDWXPpejUltqRhIdrRkTw8/+fPuu+5VjMzfs/dw59qGWs
 a6yFPfUWrziufNV7W0R+omDMdKJJAKh8Y5VNLexsYIQWg6SX0LKGFNpLSSCRISG+VUdR
 MHSxtWGPujLjks6sw04JUHal6MQJ3T8BjmusANxsPq2J4W2NsPFRxolT44ALnkULqRSx
 z9EsPpWL3Esl3xJxK+GJNJdv+38XARLrG/5RkebTsUc+uZI6EYe1UUuR9tiohxTQ8oRb
 u5iiph9/4GCUtCB1EnN+BlUYKqqoyZan5d9OAVetybB7VmSLGYkdngoI+GV+M50IYUgb
 VXdw==
X-Gm-Message-State: AOJu0YzTuE1AytWVOPbPyD5GPAhA8egaCRYSaSu6u1hrRvgYsfBQ3Xjl
 LrL4f/pARYwfQGEpB9CI5k3Q8OebzV4sn7S3vWpSLA8ToaVDxiGBPflK+ST5MbNs3CYSaR+wgrC
 ySqUrBz4=
X-Gm-Gg: ASbGncu3PrM3JX6MPkZVmfgRh0elA2ksRMl3QDvVOap4ujoXMbBg2sGsGNFngGDOC1c
 oTMqJ0XZK27L/9RAMadXQTqmS/Vnc2p3uVM4cb5bKJKqulfun68ozpJe9+FZ/BUAi4Liciy4Tg4
 y6AL7gUWxJbVnjYCGeYrIsMYdOxBMtoAIy5eemgxZcV9LMIL13IdXKK6qoz2CDIJEOA1Uwz1Pbj
 p5V74w0HwhaVh/jvTFt2IYkyuKR2gf0957RmmSbgNbIlb4Zf7ZUsMCVfUjAreAYISyXrkK/qzU7
 4QCKL6V/i2rb5gIWHp+U/+c1F6XlWtLp0/SbSqEEKOJeCvXPdQB+jtlIbwDAfPoDx56+L4xkESi
 aGWgA4cpnnYFOFoDITLUpCxj265Ooii9L3vH+dJsvJX8/Qx72hHBSe5fwzp8WRjX6zf2M8BZgLb
 YKZG4wDFjYBi7RqQ==
X-Google-Smtp-Source: AGHT+IH/2bbHfWYsQ5Wc4+8YiiwPEY1L6HvoFQ0cN+CDpKsTQUHb/opVcgSbxiVi+9TuVaIiUqa5UA==
X-Received: by 2002:a05:6870:8112:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-3c0f92a84f6mr11807686fac.23.1760451634871; 
 Tue, 14 Oct 2025 07:20:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251003203932.1030103-1-trini@konsulko.com>
References: <20251003203932.1030103-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Make SANDBOX_xPL depend on !COMPILE_TEST
Message-Id: <176045163425.284655.13703248964768142837.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:34 -0600
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

On Fri, 03 Oct 2025 14:39:32 -0600, Tom Rini wrote:

> Given how these options are used in the code, it doesn't make sense to
> enable them for COMPILE_TEST. Make them depend on !COMPILE_TEST.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sandbox: Make SANDBOX_xPL depend on !COMPILE_TEST
      commit: 16b0482a7430554f150dfc8134e130d40fc72ba2
-- 
Tom


