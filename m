Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC08C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA45482BE3;
	Sun,  6 Apr 2025 17:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KYg40Mu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5432782BE3; Sun,  6 Apr 2025 17:38:09 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A7982B6C
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-601c469cce3so766124eaf.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743953886; x=1744558686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zTaXvAxtdgpGwhk+zlb2Bw7nI992kOeQrvmWKyxVPE=;
 b=KYg40Mu+e3tK1j0D7iQ0WKnUmXLJgQgUX3VKau6h0zWGCzoomebMsoDleqA655QpmB
 V2EZ0OUhHa8Ubk65yN7zloeWMGvL+jl/4Yww+dAKnDrUc9iBcpboA/vU/xVaWCKD8Ah1
 NjZrYx2t/ttgCSVDiSoKfqkf6mDHt3lCcTUaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743953886; x=1744558686;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zTaXvAxtdgpGwhk+zlb2Bw7nI992kOeQrvmWKyxVPE=;
 b=BuWqblrDlnpzhITVEOPnLheowwxYFIrg2vVXGI8AyQJHzW+CF1jP50ZY8U34NRoUuG
 YB1kf0WlaOnQcFhGv6cg35ZeJVsqSf9L2qoGQQuZlKjA5RfUu92h23xOVOxEq2pVZrpx
 Ssc0KSQqsZpIImIZqMSK94n/hr2BLfxdliXEIi+mHm/OvG/bRiGcbr/SYrsq/BRdhcoG
 yrLe9WbrCH97MTd8wPE83HjIKlrf9NMSDPZew9PywBjM8bJpeS+0rYLV/gHi/E29P/kJ
 ULoazsO1Nzoi9V9m7twfeA8vYsrc8jjvWO6k/T339cNawGCL59Mn98fkysWmwi0tYxrW
 rKFg==
X-Gm-Message-State: AOJu0YwADRbYCyXaEXX6eAu5nvgwpBAz7FOHjBJPw/1wDHhREFpsadLS
 2T+8q+K9nssrvqSO/D4Jzx5LT6luiJYX+Fc9TVBkVVGZVBU/u1j082GW/WDQYWS4+C67Zd+xTMM
 t
X-Gm-Gg: ASbGncteD1/loMxew7E96/cYvM7dIxi9LiY5twQw2YLUF+MYhxyh65lYumRMEkCKTxt
 Ra31hfRKR+8N6pLQUeYVMIX57YuLfuLALDhI3Yfd3FP1dUa7+s4edmamIycgT7rU1z4nQ5ukzLe
 gJE+JTv+sSXMIkv7P7J08vFppjZ9cMl942UrSMSPJ+DRFlwuTMkR5Qtk1qPnUjYoX49SRUjkAUJ
 H0Lyosb6OH3hvnxX4LGBOHCrc4vAiVBxou8lfyI3qcbiD8CyY6zpN53RJVt40hvFcpHC8wDrgCr
 wEjGHpFtTSN4BxelfAgl+UWstbZB8du4yralAk/FbHbORk1QsdNxmly/9keR4VpZfecKUb741fr
 SIvNR
X-Google-Smtp-Source: AGHT+IG6IXoglyJWr9W/AFL0MXTwHYG8al6qeQLoFj8vWzavffEAxp+EvRqaDaIFWX6F9QlwZMJBmw==
X-Received: by 2002:a05:6820:2214:b0:603:fd3b:aef6 with SMTP id
 006d021491bc7-60415810f78mr4546324eaf.8.1743953885922; 
 Sun, 06 Apr 2025 08:38:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4cddd6sm1447384eaf.15.2025.04.06.08.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 08:38:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250319151550.163275-1-afd@ti.com>
References: <20250319151550.163275-1-afd@ti.com>
Subject: Re: [PATCH] arm: dts: k3: Remove leftover file after OF_UPSTREAM
Message-Id: <174395388449.154794.7248493038317603940.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 09:38:04 -0600
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

On Wed, 19 Mar 2025 10:15:50 -0500, Andrew Davis wrote:

> The file k3-am62a7.dtsi is part of upstream DT and should
> have been removed when migrating to OF_UPSTREAM but must
> have been missed. Do this here.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: k3: Remove leftover file after OF_UPSTREAM
      commit: 42074b54075e584014d6609f9500525bf837d864
-- 
Tom


