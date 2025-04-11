Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD100C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B8D8424E;
	Fri, 11 Apr 2025 21:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="trK/158M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5106484241; Fri, 11 Apr 2025 21:16:54 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12DF8422F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f6eaa017d0so1617262b6e.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744399010; x=1745003810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6uJXeDLJGr7OYyNOS5YoyZjCBa1EnW++nCR8AadLFk=;
 b=trK/158MiIhGOt+g2L2GnQ/Pc7UwwXbT2czb21XZ8V/4sWbN/2+1x7b10GmTmhk7lS
 85WTC8hX+nA+4Rj4QuNzIUiBj4iY0K2twCR9KDH7YKBDoGZq7BxbAMCG0zhUIVYyZwHG
 2lyvu0WW4boBJYw1M7AK2mXtn0TKj+3Dxob14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744399010; x=1745003810;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6uJXeDLJGr7OYyNOS5YoyZjCBa1EnW++nCR8AadLFk=;
 b=qVGPLkMtYz2Tehkb32X9d8Y8DxVOr3ATzCbigYS7LkiuAnjLtnPHuXd5k6SIOTiG1n
 TzVK2vNvRf0XdW7+EgGCnHDhbWCwURNOHQEcXxflNUYDBdyl3qryRXS73GWCfimLqOIy
 SoK8TC+kOzfC5MTh/cxQyRo6/PUzh+1jnruXc94+xixNlVa9wrwoiufdinKWwR53xHUl
 zQW8zv9VTcDIlJHVFP0iWRrn/5vq9Xv/Ysy3wMROXUa/RbETX5ehawZ/MK4HmA9eS5Kf
 Vvu/KBr3zhpF/OulL0TZHrc11GQUNI7jpVIPnmrYqMozr9kB6HIVepbYTSQOpDTUJDOb
 bi7A==
X-Gm-Message-State: AOJu0YwvtBYn/sipWCMkrOOPo0nTvdqs5oh5uLmWWp3zP401Mm42jLPQ
 rxdVtYPcO1iIwnAGcZNq1cFsESTzH24aiB5QGlTiXJLz6I/ODOfTvhM1UKp3ar8=
X-Gm-Gg: ASbGnctOZ+xVZ7QB0Mm9xsY/KPIpz9U2Hh6CvfsgUzrwqGYZZwxlA0tFSWseGGr3uEX
 oGHWnHBjI2clDl+rM80KmiwDcOsKetKSfofWslx0KgGqLAtGCp4s+ElKjtaPG2awfOzGIiOdmcY
 kavDG7l/ewF4gVW1g+Pp6TOxjPxOdO1YlDMq0GFkUQhQTX2MyTvQyeIkzNxpOU+3GGHlRKAsxgw
 PTyf1SzSMhdseeyjHa3x6peDACB9G1wXcpHu9H8JKoeQcj/qSLxUKScQqi2Vdi0eYs3+F4pDj0G
 6QvsNalvXRFoebnOuks8eCCsiMNpzflqNVEf6tAAPQVXqoklNqLIGf9hHnUpkMEbaJ6dPjsHHhQ
 b
X-Google-Smtp-Source: AGHT+IG30U3hZ9aJ4/bfbdR6m/iFAeuKAVYGC87E2zE6BvNDPeFrpCf0zeTzs/DOlv2M0xQL2IBM6Q==
X-Received: by 2002:a05:6808:1a1a:b0:3fa:82f6:f74d with SMTP id
 5614622812f47-40085084e6amr2728598b6e.23.1744399010431; 
 Fri, 11 Apr 2025 12:16:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762cc752sm1043970b6e.20.2025.04.11.12.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:16:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <20250404125358.538120-1-vincent.stehle@arm.com>
References: <20250404125358.538120-1-vincent.stehle@arm.com>
Subject: Re: [PATCH] cmd: optee: fix hello subcommand argument check
Message-Id: <174439900930.3262324.15851648643643435476.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 13:16:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 04 Apr 2025 14:53:58 +0200, Vincent Stehlé wrote:

> When the `optee hello' subcommand is called, the do_optee_hello_world_ta()
> function passes a NULL pointer to the strcmp() function while verifying its
> input argument, which results in the following crash:
> 
>   => optee hello
>   "Synchronous Abort" handler, esr 0x96000010, far 0x0
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: optee: fix hello subcommand argument check
      commit: c4b273e441327f74449b3035d61ea92a077c1baa
-- 
Tom


