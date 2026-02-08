Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B36EE0AF7
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 00:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFA683C39;
	Sun,  8 Feb 2026 01:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KeeLw4En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F08483C39; Sun,  8 Feb 2026 01:27:51 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E44483642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 01:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-408199852c5so2851758fac.0
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770510468; x=1771115268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyMNs7Pov0MAxlURrfwUPBVWF0ODNqvCylJvRyr54uI=;
 b=KeeLw4EnHdhRcxW0agsxbDMwo8gsuPoNDcM5Arskfi63NiUlQcXUx3gQ274hutLBsZ
 w6on2he63erYlwF/hUpRXVSjYs4F5NlLaxVlE5PK9Cz4asdIAjzRqwxeaB/qaU/3WZZ9
 2qPRHau0usEF6/4BIutxVLw4ajhS4AaVn5vfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770510468; x=1771115268;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyMNs7Pov0MAxlURrfwUPBVWF0ODNqvCylJvRyr54uI=;
 b=eHP80UCMoli7nFtNXjOI1SyuZ4kH5m+TFes6zXck4s0mag+LUIvO+hZDWfU9H31SC/
 jSr9d4U/BK50zot/PVmCFI+lw+PsaMJc75wAIjwHC039XKzq7RDTeeL22029ROdFYVVc
 xeelVWgXFd+sE3qW39sn2JUucoNgtw2fggpg9wWIbHDwmjLQg0zH1dV/uT9f5ImiaYdX
 z4Otsm+7IAFBiry+yxXXVPr9Qu5DPPRrKiByRlCSVrSRYBAdAKI1omDy36bpVdmJwzos
 gRdY7Id7yRO/YRH+dqUahRhB67TjSlGzSpMjuuIz4Y5uWoupnNLAnswaImjl/knnWTS4
 k3Vw==
X-Gm-Message-State: AOJu0YwqTFanc+YvjM+sqc427RFv5czT/iTwObT5M2bDoZ4EQBEB0wBY
 e1CU8dkveq41OFoIkuIYe82CLKSQDMTFtXywre7nrAU2J67QzNNJyAxQdcFCzP7gSho=
X-Gm-Gg: AZuq6aLFAtETHFK406ytuhUvY7jCZmLmeeRny4orjSIQi77wdLyPu+cnU8LylBVGh6x
 xLTV1ZAo0VcJeAyZ4O1reDBKDeQvoM1GNeGsyOWi0MGDL6LiFhB0ssshQ+GNgkZ4eeWvUZwg5J1
 EJD3rzQ/PDYwA8pTuAs2rwEWyxRtQEkIxhMYmtBzOhqOxjsl9jtwYxgS68ptRf2M2r0sWxgNC3C
 ZZAt5i5eeE3cKFt2YRnc8tijAp6MFQyp15lfzY/WYep9D4M/buj/atx9XGOZ5dfZ01xUeHJWvme
 fj8335351CIsGmK+qdLJSx2PSrnAjoPHKW3cB9ntjXi2hSZZtzI+ueR1YbNX8vGchWO2oUT7iPy
 /UDS679JAS92YSKy8bVGq1d5XbeOdrwLv0KhOU6jAGdGCOPGmmQofyx9IjWwo9q+0jWn0pttxOK
 m2sckhP3Vt70ZLWiKrHVmy3GVK8ptkqzY3BsxgLx6gslIc2USHPup3cBlqpOIANncQP9TU06/Q8
 YdSLR2nxRPQCZ0ZnTTfChYuRKyIWFvNClLNog==
X-Received: by 2002:a05:6820:20d:b0:65e:f0f9:aa7c with SMTP id
 006d021491bc7-66d099c57a2mr3587257eaf.4.1770510467853; 
 Sat, 07 Feb 2026 16:27:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm3552448eaf.16.2026.02.07.16.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 16:27:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20260204163141.2228295-1-raymondmaoca@gmail.com>
References: <20260204163141.2228295-1-raymondmaoca@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for SMBIOS
Message-Id: <177051046630.295305.4561263599212223697.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 18:27:46 -0600
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

On Wed, 04 Feb 2026 11:31:40 -0500, Raymond Mao wrote:

> Add entry for SMBIOS in MAINTAINERS and assign myself as maintainer.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Add entry for SMBIOS
      commit: c9d1fe757df659338a84c9524c9bfb0545aa1bee
-- 
Tom


