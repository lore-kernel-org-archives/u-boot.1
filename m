Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333DC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 22:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BCF833EB;
	Sat, 24 May 2025 00:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jOxIwtEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751618340A; Sat, 24 May 2025 00:26:20 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F09E833F5
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-404e580bf09so123507b6e.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748039177; x=1748643977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak80/NmOJilUNEHJeqj8kT03zqwJcK8LoaNssl02sS8=;
 b=jOxIwtEFiKBXkB8Qq1b8HiOGVkNKFCo+CNkhe3sdmkzfAS77RyL+UAqZM5Ze555DPt
 TID7gbOfmYnEH48D/iIMndaAxJZB8Wa8whLlsTUhMt2AcK98C3u5SIHTViqegHO2V1nJ
 J1hgXxAxQvfdPoRPJm+2eLq5CQmKuT4hzlT5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748039177; x=1748643977;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak80/NmOJilUNEHJeqj8kT03zqwJcK8LoaNssl02sS8=;
 b=ekA8qPzc3dXqqiC53FuhhaopeIsohtiMhq3D5VkbdKTMs93JiTfCHbulSlmhOUs2BC
 vfn7c/5f4pUT0JroKsOMs2kFmcOfyO3RWNsOE9k/rZlpRBv5jWZcCcnwwwfhqV4FdAoZ
 CeUNeOprvfa88a2lE7Z3lDpmXZGVcNFkpVx54S/StfPqFf7HJLbY/lZHZAwQjElSJWRO
 q0BY8CbBpIEum6fQr2CY/gYnOFyzsWCQ8MtcEbCnLA6XW057LkzingPehXbf33k5yL6f
 IDQbP1f+3w2+fJRvJ/AJ9/vRLeQA6k4QDKbzIv1vYhPSzoctDAvzCbNH77M1/69S41hd
 /Q0g==
X-Gm-Message-State: AOJu0Ywgj1bgPrKu7auZ8NqBIxBAyPa5YbFMR5lqqky3jBYy/6Ra8uCV
 zTWPNnX9Ca59abe1kcRaSIzRfn9KFDYwHT7jr+zOr7+eDUpaXSdn8pE41zVMo6osMlOEsRIbus1
 zV3sC3vo=
X-Gm-Gg: ASbGncsJ4jkpv0RN9X9rVMqs+nL/n28M8OOBaNtlnq+8EVs9K+rTneO5NF2Zs+FVWM3
 TrQyV5AE9qzCJDApxB6T6gIgcsy0qKUDKRbK/ZUOe+uykzQAomD9ty8CrKPHVkxbU/63HBpoHhX
 RYQwwO2keCqHDXypw/TmM6HrohkvTMBkSkqzNCcV+cY8xJhOAeRQ//xkxCec1sPXt5mH0lIg8Du
 PVLO8B9dU6J+XMIJ8tuZTY5ASKw+M+DE9prKD8UrxdSBf8T4tbTR1tN3ocgAIItgV+oENmAYYMD
 9nbtfp4r21vn5zVeaC/v007U6V9cyPrR6nev0mPoTtu1bYGiKjsw3CUpft0Xn51HiZZ/8E6h0Ek
 nB61BHh8So45xZmo5r6cQXQ==
X-Google-Smtp-Source: AGHT+IGoqwaaTgz5DZysQ6QLyUJvyuZyeef6M0Y9QS9eJDNRbZSeBDGNfOs0h/+oQeFSVJVLm/bM3Q==
X-Received: by 2002:a05:6808:3a19:b0:403:529d:fd81 with SMTP id
 5614622812f47-406467f594cmr533437b6e.17.1748039177160; 
 Fri, 23 May 2025 15:26:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4064522312bsm194029b6e.34.2025.05.23.15.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:26:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>
Cc: u-boot@lists.denx.de, gss_mtk_uboot_upstream@mediatek.com, 
 "SkyLake.Huang" <skylake.huang@mediatek.com>
In-Reply-To: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
Message-Id: <174803917570.2369538.2389638563668693983.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 16:26:15 -0600
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

On Mon, 14 Oct 2024 15:06:11 +0800, Sky Huang wrote:

> Remove unnecessary CL22 phy reset before ethernet phy driver
> probe. Lots of ethernet phys requires driver to load firmware.
> Before that, CL22 phy reset may lead to malfunction.
> 
> 

Applied to u-boot/next, thanks!

[1/1] net: phy: Do not do CL22 phy reset before ethernet phy driver probe
      commit: bab54f5942c428be698216224fd10b91d974d4da
-- 
Tom


