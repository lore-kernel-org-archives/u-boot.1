Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4805810F9300
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 20:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3261B8403D;
	Tue, 31 Mar 2026 22:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fF1nYrt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA77F84035; Tue, 31 Mar 2026 22:43:08 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A9884035
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 22:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so2468856fac.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774989785; x=1775594585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoOsjkHszEw6HVkGpMQkbn0ZaaknLs3bilhppAI86Jk=;
 b=fF1nYrt3vugghnJAjQubQ0X9+dlja566jJGHXLiqywoPbFIdTMofdfINxWZOOds4X9
 lmS9Dz/o4mUP3DWwhEcEXT0ZEYO/Q2R/V1t9xmwaGq7OvQgCNua9iZQ9J3APuwIcVzxd
 lN/lio+bRKFt7kz0zGLis0DtZOsAn3Fjk24qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774989785; x=1775594585;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yoOsjkHszEw6HVkGpMQkbn0ZaaknLs3bilhppAI86Jk=;
 b=OnsGwPf23F3gbeD918Hqcmha3zy5ytCzcNCXfMogA5Bqb407uzpFRwgfocHwRrWs8W
 vhaQHzbIjCYL9QGUON8fKJRjunEe58X6Jh0bSIsC+rnU/qgfYmxRTDwYKVL2s9hMiFD3
 00JGnSoPFZgQ3rX/KYBm22XxgJc5x7JcNO2hiV5E2GKUqSI6sMD3WL9DmJ4pjBLixomI
 zrRhpOLNOXQCt3W9NPwOPZAlNl8XOgrfMRkYdRUrYyX2JwFto254cZgMYXPczU7v67mw
 PsmheLn6LnQGEA3vPaV0GIDi+9udQmdHyLEWvo/NB3CHtB+MW8Y9ZRt0oO6IXuEpmj2r
 XkPQ==
X-Gm-Message-State: AOJu0Ywfsu2CqOtcEK6Lxo+8p+O+x5mjGFCUxO5D+3AVdTjdCBfipddG
 n94bOkudoXeHh7WpT5ZbkAJtPHL4us8b/iARJjL3TyZC5huOcWm/LKuGKpNRdMNumto=
X-Gm-Gg: ATEYQzx11Eswif09Ws6TxDUZ+C4yRaWKc7hd4aEWn+0KvFpb+y1E34KSV2Kp+mHmvsO
 aIyMS62AZNBe8ivxlgqIu/+zxoUAbRIB/cCBnBe21wP9grmeJHI6dkHEMh4sh1YzyE95KsLyN5V
 aGRySIhcYudeVhDqo1zxPNo7nHVTkM42tc9LdzyLws1a8w/QtrAdtax1AmPrKAN1b0NySkww80A
 ++kFcXy58e6+QWHtnpp+ki9Zm/GWa5q4vvcj3xi2XwFrPQ2LkeondJsRakm4VLDBtDAZ6dEcJQV
 +Uj89Lfs+eOBJ2mNuZQ1QktmivzOyje41o3HkI6Po/MqtXy76DBELZfrirWQo1PfeCrtw+tGqrL
 twsbs0N+rjra4qsqrfLUlwAs5oh8z2VVRlvoJk0eDwwkq/G455GmWvMkun3GGekXmL6UMA/WV4F
 mUSn7oG1DB4hLEFd1LeNa5eY+I3J/PgxqPDZdiA7G3Hb/Zju4rmj535efSB9auEU/ohwKAm2oka
 gTVfwdmBAbBdRut/Y8OfGHQv9KfSQQbj+WyR2QTgF+7bMg=
X-Received: by 2002:a05:6870:d628:b0:41c:880:f9b7 with SMTP id
 586e51a60fabf-422cfc04c6emr745997fac.7.1774989785113; 
 Tue, 31 Mar 2026 13:43:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04c889fesm7252811fac.9.2026.03.31.13.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 13:43:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: m.othacehe@gmail.com, c.stoidner@phytec.de, primoz.fiser@norik.com, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260317100703.1933040-1-w.egorov@phytec.de>
References: <20260317100703.1933040-1-w.egorov@phytec.de>
Subject: Re: [PATCH 1/2] configs: phycore_am62x_a53_defconfig: Enable
 CMD_USB_MASS_STORAGE
Message-Id: <177498978441.1321462.14852460218716878717.b4-ty@konsulko.com>
Date: Tue, 31 Mar 2026 14:43:04 -0600
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

On Tue, 17 Mar 2026 11:07:02 +0100, Wadim Egorov wrote:

> This allows us to expose MMC devices to the host for easy
> flashing via USB.
> 
> 

Applied to u-boot/next, thanks!

[1/2] configs: phycore_am62x_a53_defconfig: Enable CMD_USB_MASS_STORAGE
      commit: 2e3a53d1c109b518cc6e25a6cc1764ce280983fb
[2/2] configs: imx93-phycore_defconfig: Enable CMD_USB_MASS_STORAGE
      commit: 87ea2b51b654b616bfcb381c46c8b5bde146607c
-- 
Tom


