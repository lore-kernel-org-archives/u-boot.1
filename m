Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE47C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 20:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D363A8792D;
	Mon, 22 Jan 2024 21:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IMmXuQea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C939A8793F; Mon, 22 Jan 2024 21:39:52 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5230878BA
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 21:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff7ec8772dso28043567b3.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705955989; x=1706560789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8KtVandrZkU7bU/uhTgPoisvLhn4oNZNMQA0uH0AqIU=;
 b=IMmXuQeaHkAO42LBtbHGHM89EBfdrKHXk6aZz/zGqx9OEBXvh7sTK9H0Ubqc4SIwwl
 mzSnEBvvTYPw7+DP7xm4uUXiXI7BAynAqNSFC9JtqECzVf3iV1PoSVf4JVrNru/wx75r
 AAR5HIH7bUWc8Vy+qhamqeraxcj8dHtFu/CQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705955989; x=1706560789;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KtVandrZkU7bU/uhTgPoisvLhn4oNZNMQA0uH0AqIU=;
 b=EZhOEz2ORpigPhD0nCG1CuqvB6LjnF2pRcXilIoQqPXiZ0kOmBD1SF8ARxZuUaLPnI
 t6EsuxWg5VMvupThmM+qYTB9BuUJ5/lA1i19viaWVCRtJ0+K0U9amN85BqA2ok3vAVwp
 2DsrGmxGdmGnYwwjbMlrKYxIlws3rfBDEjJJzGP7xxf1adD48pa8hyu9N2aFcJKt3MSG
 2eAZWc8QDA4dcA48yJ/XTM0PomUOyqi34ugjfizUM5yCQm5ojO18mD8g66dsgbbTSKox
 z81ukBeB0aI13qBDciSS0wk2q4XMLfHvwMVy886niDQIY1JYXXzkMMLiqmR0uxvlVeSj
 Owdw==
X-Gm-Message-State: AOJu0YwngpFfhBdOWrQsXNJzi/0FaDz1b31gmDd8CBcES+7X+VU7ckla
 a8UmBSQVcPzjeMWHwczzsNlpcWbKRseUXQkqmkugfkqR0zNIqDHroz+zrBu/DaYVS3bG2OOvU4G
 w
X-Google-Smtp-Source: AGHT+IEacSUaG1enIc8E/xf29LGIcJseM+NCk3WLRxLD+Kf3BejEBkZZ6D0srRQc9bt0NvztzFhiVw==
X-Received: by 2002:a0d:c785:0:b0:5d3:fb01:d880 with SMTP id
 j127-20020a0dc785000000b005d3fb01d880mr3879503ywd.25.1705955989120; 
 Mon, 22 Jan 2024 12:39:49 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 g141-20020a0ddd93000000b005ff9a21d042sm2851497ywe.46.2024.01.22.12.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 12:39:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240110184610.3909763-1-trini@konsulko.com>
References: <20240110184610.3909763-1-trini@konsulko.com>
Subject: Re: [PATCH 1/5] omap3: Make SPL_OMAP3_ID_NAND depend on NAND_OMAP_GPMC
Message-Id: <170595598773.1572668.17990226622185263823.b4-ty@konsulko.com>
Date: Mon, 22 Jan 2024 15:39:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 10 Jan 2024 13:46:06 -0500, Tom Rini wrote:

> This specific bit logic is used to determine what NAND chip is present
> on a board in order to then know what revision of the board we have and
> so what DDR chips are present. We can only do this if we have a NAND
> chip, and so we will have NAND_OMAP_GPMC enabled.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


