Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD50C369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 18:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E116817C4;
	Tue, 22 Apr 2025 20:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjUxBII1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C4680F9C; Tue, 22 Apr 2025 20:26:15 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7291810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60402c94319so2750203eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745346371; x=1745951171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hft5H1qy87iXgtA+4NHRmIboH0B3pxf1ID/X61vrXrQ=;
 b=NjUxBII1AEgwi2ybZiS9vU5zZeS9fQz2WyKo9IRNeLI3XiSvBoyPYAOA28XqvrbgFJ
 x0hHat28E5YKoNTXwEHEnSXRgIt1glmGxttOOAq3pOItJYO14GYMKCBuGmXe5JOuz3L6
 6GmAmAu+PleSZMepCdjYyD54ds8dSAkZNWmw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346371; x=1745951171;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hft5H1qy87iXgtA+4NHRmIboH0B3pxf1ID/X61vrXrQ=;
 b=skNUW5BqQ8HngRqDcvHIBWhd0CDPMI+A6+2bzeG2uvmXBc0MXWp/4vgGIVDMJ83zcv
 RZqR4teHOPkDO3H59lUvOCyI9yp3Txy8XfOM6+xIvUuOPMIPvpbI4V7X0AcbEhrOwnJd
 LYp+ni6zEVD8iYVZ9AWqmSHku+laPp0Kc2tSnxXhozSOxA9m09PGB9VEnKOSMRHizKSb
 ZKlXoPmHHgJ/OnP57pR8RVYpGvmvWpcpsMdbf7oHAGUSCwlDB9CnkipNBNZY7RM8CXKi
 v0kOBogjx/L6bEJQoQFz23EEv03r9WPQMDvB+2OgM94hikEOSxa4OyStmMsZT7GywF80
 tOZA==
X-Gm-Message-State: AOJu0YyGV/XkSi0bmtNhOCH8D5pOQIE7XXYGoKBFQYSIoNA5bLEfrDF5
 fzENTWZyWHRn6KTXhu0NNEk3aFXjg9cN+8Y9ALimtE3atsQ2jhCy71n5Ovjhbbs=
X-Gm-Gg: ASbGncsjGJH/MDCyOKsEUYYEJ3yg2tdiyWBtV8V8SlYCEngp8Wf+z4PEVC6vF7gjc+v
 KZBw9419Nut64cw60Ir9+OSHXHT/xL0OMm2wrVJJfHwxYemn2Nb1Vqmc2nLHWmQDS3p0jt3nj1X
 pWV/2g+Fum5Z7SLAclre3f8aiV2qfodniFP7MDi2/lww2k21fCY7k61f6iRYs5dh+7TM/ZKoxbi
 WP94kpyx6NEv2UD+rIfSjI/7GD4odCfIeRykY11lsy3NiRuyXuvUiP1wRVdKi8VLf8bYvO/84JT
 EutxFeXcTN8QOV6HzbUZbezLRUW8TfbNq0bLcLOJ1Y33tK3UjlUPURYBF4pHJmht+dVJ2dsGtQ6
 S
X-Google-Smtp-Source: AGHT+IFKN/lOod4lm8lwXKLdYm+nULaghhyrMNOMNzvawmFQ5M5VQCegakMDiIMHclAp63GhFHn09Q==
X-Received: by 2002:a05:6871:e297:b0:2c2:dfbb:2dbd with SMTP id
 586e51a60fabf-2d52696f4c2mr10136415fac.8.1745346371625; 
 Tue, 22 Apr 2025 11:26:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d52134ea5bsm2704504fac.11.2025.04.22.11.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 11:26:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Aniket Limaye <a-limaye@ti.com>, 
 Martin Schiller <ms@dev.tdt.de>
In-Reply-To: <07741b5d-ecd7-7221-8d77-fc5c1fc38408@denx.de>
References: <07741b5d-ecd7-7221-8d77-fc5c1fc38408@denx.de>
Subject: Re: Please pull u-boot-i2c master
Message-Id: <174534637050.504874.2480347654636166950.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 12:26:10 -0600
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

On Tue, 22 Apr 2025 17:22:25 +0200, Heiko Schocher wrote:

> The following changes since commit cde0050618968aae335dfbc930641656d51ff5d0:
> 
>    Merge tag 'u-boot-at91-2025.07-b' of https://source.denx.de/u-boot/custodians/u-boot-at91
> (2025-04-21 08:24:54 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-2025.07-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


