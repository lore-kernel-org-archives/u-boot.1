Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CECAC54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D388588A7D;
	Tue, 27 Aug 2024 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EUk6V7bC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653CF889CA; Tue, 27 Aug 2024 20:35:46 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A8088A4B
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a60850so633357b6e.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783743; x=1725388543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfInauW5+nU4TNn8oUJnhA+t7utqqvVlcqW7X2oAF18=;
 b=EUk6V7bCNeCgpz+Q8nXe6pfzfcNIeXAYJRw0Dj9l3yqHwiTMC145AywhzrPtSpwo1P
 4n52edSmobSCIVLD4lQtVc8xL8AJHnV1r0ALWjDyBAGEJME8mjOOsfHJUznoe1a2zGiO
 BS2C2T7CB+fYxTVlmUkIddE5SFyBZQUmp/TgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783743; x=1725388543;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfInauW5+nU4TNn8oUJnhA+t7utqqvVlcqW7X2oAF18=;
 b=tYFtkJdyHz2947pm2nTKiJnNGXvyEKHXmOgnIsngJFTsA9rnsVjlt0OOdqNqo8vJkg
 cm9choLKhVN/ek0dXB/liNvemskZXAWvSVTcDWwlKpOoRQvbtbblNpVk3hzHGBxjlJPj
 dtRr9D2Uw+w1Lhf/Df25KqI6f877cizaSPA5E8H/2sFNac2V2YDR+KFvipJMqjY9UtqK
 T/mgEEMY71H4Ehaqt8CHKcisXb5hboT7qALsX+46DIOETVuufGJNhuYQ70fgpCrPAqAL
 Y3Zrb+ROlW75a/4WN+lbo3G2lB9x0UA8vyy2elBlBpoIFQXZSJeSqar4KlzfyyfeDmbi
 kpsQ==
X-Gm-Message-State: AOJu0Yz5SUItZh7V5WBN7bXaYssA5jHCZWZKm3qd7oNYyllrjLuG4dvl
 2rBWKOA2JhR5Oa/Z3BgmI2mvQxs+/hJ6ONuCdCfMIbq9CfbCTZX1pSxjhFVeYPc=
X-Google-Smtp-Source: AGHT+IGr45QEYTCl2cnqWDxci/+68hKE12HLh9fSwxqE6BJkssg+noGfdeShxVxIrz+gd3GFM2uHXg==
X-Received: by 2002:a05:6808:210f:b0:3d9:29c1:be41 with SMTP id
 5614622812f47-3de2a8734bbmr17377301b6e.10.1724783743034; 
 Tue, 27 Aug 2024 11:35:43 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Roger Quadros <rogerq@kernel.org>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Glass <sjg@chromium.org>, 
 MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrew Davis <afd@ti.com>
In-Reply-To: <20240807090829.530865-1-danishanwar@ti.com>
References: <20240807090829.530865-1-danishanwar@ti.com>
Subject: Re: [PATCH v2] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
Message-Id: <172478374145.2927671.16681625624721567065.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:41 -0600
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

On Wed, 07 Aug 2024 14:38:29 +0530, MD Danish Anwar wrote:

> uc_pdata->name is populated from device tree property "remoteproc-name".
> For those devcices that don't set "remoteproc-name", uc_pdata->name
> falls back to dev->name.
> 
> If two devices have same name, this will result into uc_pdata->name not
> being unique and rproc_init() will fail.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


