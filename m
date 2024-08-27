Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFBC54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC258889CA;
	Tue, 27 Aug 2024 20:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hw3i1b6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1058F88A5D; Tue, 27 Aug 2024 20:35:48 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D597588A46
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db1d4dab7fso602151b6e.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783744; x=1725388544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EviIkf1rghqNEWpNFgXiKlQJoB0u40O1mCf5HFw1XWU=;
 b=hw3i1b6Ea3L6rfZYj1md+cCwN83jMIYncUamopbsWGP0oNBn/fuEzWk4JyWYPwVd9E
 4jDNN8JOzGhW5NBzA7ASK/FPWQ6MWzLxPyhMSxBZA53Rg97OhrGaZpYBzLIopuy48riT
 dDGPiO+sZ9zKgBdCgT31mPSxBD0Zv8UQaKhyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783744; x=1725388544;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EviIkf1rghqNEWpNFgXiKlQJoB0u40O1mCf5HFw1XWU=;
 b=W/6UDAH+mjn8UYVov2+3L40NVnn2PC+224prlFdn7n1bmBEVbLGFmmvE3+/CCsCk2m
 JLDiUuk6vhFJil5Lkzs2086q/qtVtqJ1q1shsRp1JJmmXdINIsIBossOY8kfGsfwp1Sx
 W8tT8mp+Ajw+oG7CXX6M4LOxGp1FlsO3TPOICmt8TVpzPRfHbWVmthDexL/mYf3382zj
 ZJZMCGdZ2NjQ5wMUqj8HdcE4lB3ImXHiGWZPKWg12b5mTMgOQHGcHIibliAWyQwA66Th
 wU+VlIkVRbHnj0G/qrvNmQEurN2FHvq2Jn7h/HByjZgUeHSqQxVR4yCwqbslusRLIJbF
 KoEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWctFIULHTJzHrUrMA0fmyb7fdywFDMDJ+xXmbLy74JmedhURS0qkNRTOOcNqaYZmhGbKraGdI=@lists.denx.de
X-Gm-Message-State: AOJu0YxA2Z1ErrS03fb3E/mqgOoF/W2Od1FRq+ympAWxtryhYhOCczMa
 RtVX5N4WjYEsTPfEmzoKzV+AmN/QYv4Su5AixxA1B0IZ3l1hg/oqLUFTUayceN8=
X-Google-Smtp-Source: AGHT+IF2LhiIN0yp4IS0rLUbXpM1ur+lBNITcLWgK+F6XqLDiqDi+5YHddA31sp1c3ThF2t324Zsmg==
X-Received: by 2002:a05:6808:2118:b0:3d5:4256:26d4 with SMTP id
 5614622812f47-3de2a86e26amr17442245b6e.7.1724783744585; 
 Tue, 27 Aug 2024 11:35:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240812123150.20598-1-ansuelsmth@gmail.com>
References: <20240812123150.20598-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] pci: mediatek: add support for upstream split PCIe
 node
Message-Id: <172478374325.2927671.265936616332935692.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:43 -0600
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

On Mon, 12 Aug 2024 14:31:48 +0200, Christian Marangi wrote:

> Add support for upstream linux split PCIe node.
> 
> Upstream linux have an alternative way to declare PCIe nodes that splits
> them in dedicated nodes for each line instead of putting them all in one
> node.
> 
> Detect this by checking if the mediatek,generic-pciecfg node is passed
> as it's used to reference the common address for all the PCIe lines.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


