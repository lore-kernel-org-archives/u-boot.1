Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B81C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC98880F9C;
	Thu, 24 Apr 2025 23:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LRQdnnhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE7C81E25; Thu, 24 Apr 2025 23:32:43 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01DB809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d4f832069bso780115fac.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745530359; x=1746135159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lngGyPPlFyF5Ta1R6BCDVxxCZiKMdX1coYU3FDnlW64=;
 b=LRQdnnhUA0uG2WwA0iTUbIxVoy027TqC/o/LhIH05yMO4k8Sd8yIfQII3ul5DoPWcX
 uug+Reija56XZ5yQYDbhu/m1WITYY4OLRiDcBftBFZ4eIKTYiDS98EMzZhrvqqwW+Qr5
 9oV3K+SSPWazPL0l+cuLDebTyn1XIacHTjsYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745530359; x=1746135159;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lngGyPPlFyF5Ta1R6BCDVxxCZiKMdX1coYU3FDnlW64=;
 b=I4WjsHc7OE2zIKYsw9KAq49luk5ykoGYKo429z8h51dA4E6i6f9qs6aAmPeooBMx2+
 UIJQPfcR2gCXP3C7Ck9ox/tB7GVC+nupt1wUr+kcdyWg1cBRL4gP8nMyMVVg/8vSud/6
 G+DKuFmVD2oWH0AmOohgHflTpuPW5cSh2T5stcX9Qf3WOECotHKNwhw7qqEuOUPaWwM3
 NRNoIc2UtvO24RCcMMcvp+hAneyX+Rj8us5y1W02y4Ex8wE3UTCmthInnStK+1nWAXWG
 I1X8lgZkyK7tOFARgOVAltgOlPLeGqKZ/L/BjfkXr6kOaq0HbczUhuKcrpGP4bdy4irU
 OekA==
X-Gm-Message-State: AOJu0YzTPX6SmnGTXK11k7q+qK6ow7LcgeOglMAVvnSqspopMo/Vz1TO
 sFlsxTAOqTVsCr3iqGyskh4xO7DGkcO9OLEeDJMMB70v8aW7K4L3sAGCQj8Yp+mXisqEHggFkll
 r
X-Gm-Gg: ASbGncu1ge0PGE3YzvZWN/ziRxyYShbiPRlMUD/SSAjSUqyGmns+Nj2buIhnJCJH8Jl
 55uV0rkuQxqQxf2u3cfmI4Pdj0gjEKdUarCs9IaUkika9G1aVMPX23haQH1/g/rmwAkKvFPLs8F
 pweqQmyQZ+B+SvpXWl2MuVlPm+VB2aL1Z9qA9qzHeLDvB24OxL8AZ5r9ncV5Yaw2tRs2HVkwSWw
 461xhStLKoejvzwWxYkcYOlENJkY/JLdqM9jImZKKNXtd46QJc/CFDDOQvo9QhykFG2f8AR8wOW
 HS1pWzO92wIxrO3GV62GU7H4q94XLKR/b5m1miujCxwLMbAmP2YFdZvA7BLKBODuJ1dPfBdZPfb
 1
X-Google-Smtp-Source: AGHT+IECDl+ZJNy+8RPA/e2dJqPxoFHrVh35UVG/aqbPxyqOvTOyttIJ1HTVexKcbOIVFIiryPPdCw==
X-Received: by 2002:a05:6870:6191:b0:2cc:3763:c7d0 with SMTP id
 586e51a60fabf-2d99de8e4b6mr42111fac.33.1745530359639; 
 Thu, 24 Apr 2025 14:32:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9b6sm489419fac.8.2025.04.24.14.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 14:32:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250414-firewalls-v1-0-89090085c08b@ti.com>
References: <20250414-firewalls-v1-0-89090085c08b@ti.com>
Subject: Re: [PATCH 0/2] arm: mach-k3: remove some firewalls left over by ROM
Message-Id: <174553035857.4093791.9095679010688995583.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 15:32:38 -0600
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

On Mon, 14 Apr 2025 15:20:01 -0500, Bryan Brattlof wrote:

> This small series is here to remove some firewalls setup by ROM during
> their boot and clean things up for Linux later on. Ideally this would be
> a simple call to remove_fwl_configs() however the location of the
> firewall is problematic (could potentially crash the core) when we're
> currently executing from the memory region protected by the firewall.
> 
> So we need to introduce a function which allows us to disable specific
> firewall regions and skip others to ensure boot stability.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm: mach-k3: support disabling a single firewall region
      commit: f393beedba7917ef8aaaedd67d143cd7b7440ae2
[2/2] arm: mach-k3: am625: remove any firewalls ROM has configured for HSRAM
      commit: 33b191997fc215e32cd51ffd979c5f6d1189c46e
-- 
Tom


