Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8919EC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7139882ED0;
	Fri, 27 Jun 2025 19:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MHJI/NOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FA182E8E; Fri, 27 Jun 2025 19:39:57 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD44482DA1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40791b6969bso101990b6e.3
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045984; x=1751650784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpIXVlrNwiIhoys7NeEYA1wXl277wfxzDeGfZ2c8CX4=;
 b=MHJI/NOuoJtKZOlVIEAmd/0pwCRE1Stq6vZ52Jm053TyFnCi8roCMjT/I6m+5cwM5r
 7c9yC9Z1giV8q1qJ2UwnbmNHWFBE565qeUFnva5wVD5Ah/vg0sz8EEdnmv0OWxwGc0BS
 dgM2/qDJ1pndhVdtv9kR3833rPrC8SzXxRrbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045984; x=1751650784;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpIXVlrNwiIhoys7NeEYA1wXl277wfxzDeGfZ2c8CX4=;
 b=p+3rxmVrygldldBWXKlr4ixHp64tFB+do2EeCwnE871dYn49VQGxtPvrRZ+21DEfoT
 RkDW+U6+YJVXiQW5PSBuR2t8K7gS/jH7CwqdSxTEj5iQkR0uWUl6UffZK2AWH/Cmono5
 BhaOHi46xF4VC38DH3FSECkoLfm8IeR+fHexxIjJYNhaWEc9SdjryQmykoDK1JXClwMk
 z27fG0IcA2NRU6BQmwJu1nGfu4PpfjjRwe53Z7EfHnG6B/cZvv1fkYWBJMrXfhTvs/Pv
 emXOhSgXjhKvdlw4JNpso04gFmlyg2vsi8ucu1pvNYZJKeD15C9qfYI9AeI3ERdapTwm
 x7bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrzNcN8xTSNfPm0ypvpyGYp7azWdyMoDSan4upuWHP/W2209MTG/TmYoQDR3K68LufLgoNK2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/YFZUtAGKe2TqCmPZmKMy4y+NaXrBnA66KB8r3Gr2zpplA+2b
 /v2I7k5ftLGdxkWej4uzSafxOYxTg4xCzo4OvpV7nNIOASHkxNTGOkZt3WDVDqctH3AOlKuqt3C
 mykzqCkA=
X-Gm-Gg: ASbGncuJ+mTbuDVbnP7Tj/JBLpTvBZr+64BZRReubpX+m+AI1LP40suqopV4aJQeO56
 XehzpXqSMdJHrAdqBftGUls+vwh8RSWOwtwv2mPrH/BTBnaeDRapnJJRM+A7Ik85ZjpOeYYeWee
 EmieVuOv+KTbCsFugMi3Wk/W5pco4hNkdK4L1NKhX3wzKlXTqyn3PtGZ8BuA1n2L4eLoO+7YNjl
 yY8e7J6EcwMQmDfO4DcAK1syUrVSzom9TnXfi1IHtCehZiiS/Dd/ah/WNbyRV9vGHYMyDFMcMYN
 sZTVo4zT1bnJJmVUC95Pu9Z5YVlPmnCuFyQWAcH/TCHgnEcyoRBjXgyniQaTB9RJXjEQoH+1tBQ
 ozEMrFh/TYxakMpLx4FwUig==
X-Google-Smtp-Source: AGHT+IFk2wve9A276fm2QivnoLE//QDI1qxvDWxWnbF1VHTGWriNm9D9gqYeIq7VCNy2NpW8WMXGWw==
X-Received: by 2002:a05:6808:21aa:b0:40a:5356:6569 with SMTP id
 5614622812f47-40b33e1800emr3027903b6e.25.1751045984551; 
 Fri, 27 Jun 2025 10:39:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, n-francis@ti.com
In-Reply-To: <20250620132154.1982902-1-vigneshr@ti.com>
References: <20250620132154.1982902-1-vigneshr@ti.com>
Subject: Re: [PATCH] mach-k3: am62ax: am62a7_init: Drop write to non
 existent register
Message-Id: <175104598386.3877702.1427138106688279377.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:43 -0600
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

On Fri, 20 Jun 2025 18:51:54 +0530, Vignesh Raghavendra wrote:

> Per section 14.2.1.3 Kick Protection Registers of AM62A TRM[1],
> there is no partition 5. Delete it.
> 
> [1] https://www.ti.com/lit/pdf/spruj16
> 
> 

Applied to u-boot/next, thanks!

[1/1] mach-k3: am62ax: am62a7_init: Drop write to non existent register
      commit: 95d303f7e56688fde6e50cb0a49e8cbd140b2fb2
-- 
Tom


