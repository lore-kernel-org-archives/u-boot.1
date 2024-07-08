Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FF4C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 23:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0646C8657F;
	Tue,  9 Jul 2024 01:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i94UZ6CL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77C4882CE; Tue,  9 Jul 2024 01:21:58 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF5588356
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 01:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-250ca14422aso2546964fac.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720480914; x=1721085714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r174q7bwL6pJ9y7cu+IIDY31Nz9SK83xqxEGAciNILE=;
 b=i94UZ6CLclStgMX7Pm0aG+frY3TTwZJRyPJo8Crd/KGMqbKzZbaW56bGx1tcatkF6o
 rzWbD6DuB4olY8srxaFI5/SqXE6JYMk1GxyeesijIpoIgSZkysB31jUoMdOEWMceNvRP
 FeEFLnNCnxgvSmWJyqFnROIpyzC9qh0uHEyU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720480914; x=1721085714;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r174q7bwL6pJ9y7cu+IIDY31Nz9SK83xqxEGAciNILE=;
 b=TKTFlolT6AUVmbjV2RxxZUmDu4ABxyDSkzhkdRm7aQ3QT6ff/a/dJ5ON+xmKtsF0nb
 szvll6S3Oc++CJhrpIuRM0qV/GuQ8GdhTZUC07VWJoNLdljrwP4NHsqewqAqPtp5rjAq
 dzUWFy5g/TJia/96kwDm1vq99D7Hm26vNWfbEmyI+TSXv4kmbHQMc9uQL/osYcEnDZvI
 ZHupyFDITMKzJzVZSLteWlzt7gYARYaeYC0VzGztJiJY4poumzt8IrwPIMiXGvOlnf6i
 /8ngwcl4Ca9YrrZjSsq6KJaBVPdaI7iqXJgdHHsDhdpnOQdH5s/EOK7ZTA8Px2qjeHkw
 aUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJAye7TcjKRT3uhnNeFCnj4nFkUfr2Y6JA4MVbk01dKZTHy3qalokr6PJwrPVN+DGfB5OrY+oKFaW7FIp9L2oWYwbI2A==
X-Gm-Message-State: AOJu0YxxKG1GnqFL91dFsJJB+s3962t9KjeLRf5wimtP5kRlvD53rFTR
 G17kghEjWJ1TReFn1y3LFIcRRrR4hQg7UEXXio/OGFcGkvPU8Csl3DlXYrgI4uQ=
X-Google-Smtp-Source: AGHT+IFKtXu5/l+C7+rpoKEDqFGpYk0YlXSwOOfAuEZBconyLuPbTYgW6b5r3Gfvp8PHFVEgJWi3gg==
X-Received: by 2002:a05:6870:1590:b0:25e:2a0:a58e with SMTP id
 586e51a60fabf-25eae9c1869mr741581fac.34.1720480914437; 
 Mon, 08 Jul 2024 16:21:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa225898sm245758fac.42.2024.07.08.16.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 16:21:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 John Crispin <john@phrozen.org>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 Mason Huo <mason.huo@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sergei Antonov <saproj@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 00/14] mediatek: cumulative trivial fix for
 OF_UPSTREAM support
Message-Id: <172048091236.2159979.15654004712175120747.b4-ty@konsulko.com>
Date: Mon, 08 Jul 2024 17:21:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 24 Jun 2024 23:03:26 +0200, Christian Marangi wrote:

> This is an initial series that have all the initial trivial
> fixes required for usage of OF_UPSTREAM for the mediatek SoC
> 
> This also contains the pcie-gen3 driver and the required tphy
> support driver to make it work.
> 
> Subsequent series will follow with conversion of the mtk-clk
> to permit usage of OF_UPSTREAM and upstream clk ID.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


