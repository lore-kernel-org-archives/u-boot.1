Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA21CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 16:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743EC83BE1;
	Thu,  6 Nov 2025 17:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dJW+ZZc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213A683B9B; Thu,  6 Nov 2025 17:59:47 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071A583B9B
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6d3676455so374767a34.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448384; x=1763053184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VdzALFv0dSttd4I+9/ZwfuDiNSjbvukxIwr5LrhabIg=;
 b=dJW+ZZc2a5gzMNzL1jV9NETxMGmH3gR6u4HTRCMXOCdc2BDs3Ul70dYWwAxz+5CVPW
 T0ISHOSJpfqzZJRZfiyKnG8hMAZjRcrMc73JXParZ0DTWz7zpBMMRQJeo/Fof9DASD7p
 XgCJ0BPKBi7abnjK/OpZmm7vW6kZgqioYanPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448384; x=1763053184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VdzALFv0dSttd4I+9/ZwfuDiNSjbvukxIwr5LrhabIg=;
 b=YH+7Rl+7JADC03OoMtvVi1oC83pAW6w6JpjyU6LYzRc6uX+c24v3qno7IUl209OMdd
 24Z7E0C1YJyKn5i35gfkpbM68Wj42w1veOUI8SWCXmZ8D3cPcDR2vmeijKO3c5tUjWSI
 KUoy5Rp5jA3xLwuEzf+eLh/l+Iyr2dDh2KznCQYwdu3krQY3Wh3qRK/toEy2/0fZeRnV
 88HFvqXDn/At7R6jOP2qCDbzMLkPGlR6oDwqcWxFC0V5aq7rBBV3/Ip5yHg3dQUPX81O
 zpGfTIf/PQv4oVrcFO6Mx3QDWx/ByI1US/XR6ud8Et0h2tPhwBN4aaNJLvml/DRg1ZLN
 5Eqg==
X-Gm-Message-State: AOJu0Yz3MWPJddyWwVXdDCnNn5WHYhvMQtRlgyuo2GZB+El91Ef1LNz1
 MZVQtfqNcuS8kMXa0K+iFT/nOG+/zI2sA4VkzFbSYYPv604bd13Jc9C7DTwGM+Oa28BEFW23gfl
 OBH9FzuIDCA==
X-Gm-Gg: ASbGncv1tjA4rVpNdnZoRsHDfhhVq4KDUAbNrOATkQ6ezgD3dd0YenxM2qWTybw5trY
 7iwCRKkGfmhfb8++uDIrOObB4BS/aJcgI88K19yC7ZAZ8A//eteZuoqSLT4TTGGT4ALbQXNNixb
 7AbM+Ppii75AInfA3DqWBLt50lF070qmKeOr6smnpiilkVbdSLOITLHjsoENJjSnBn7LvMR/yrB
 c8YGwEFZ4k9wiROf/Ic5YKqdpLzO9cRSFb9zfSDFvl8G0qMsHn6kyLK1v1Flnz+PBN1oYEzOurQ
 jap48z1ow2khViLNv/d9p2i55u2lhJhA6yNRxInIUQ8U5fYLF8Xkw2o/a2msLP5zEGwnVUAqLOl
 QQA2LfGxlECCkcNR4JSvj89q9AUYtgU7T2vgMjbupiM4jMhYMB2YYjCF2dVBKfAfwP2pZi0C/3m
 cwWOtiTHQQkIu9bA6XXBDIXb2OZxJz0htKIrHlOg==
X-Google-Smtp-Source: AGHT+IGLzxQ2AVkW7wO+R6oqXYekX50ipgUDlqIWnehznKdayFTlByWOvSZpgNXweup2pDh0oSJB1g==
X-Received: by 2002:a05:6830:2b11:b0:745:9272:4a36 with SMTP id
 46e09a7af769-7c6efd1693bmr249116a34.11.1762448383564; 
 Thu, 06 Nov 2025 08:59:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kaustabh Chakraborty <kauschluss@disroot.org>
In-Reply-To: <20251023-armv8-broken-cntfrq-v3-1-e0f68cdd571d@disroot.org>
References: <20251023-armv8-broken-cntfrq-v3-1-e0f68cdd571d@disroot.org>
Subject: Re: [PATCH v3] armv8: implement workaround for broken CNTFRQ_EL0 value
Message-Id: <176244838267.3056677.11961495026767745108.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:42 -0600
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

On Thu, 23 Oct 2025 02:32:57 +0530, Kaustabh Chakraborty wrote:

> In devices where the U-Boot is used as a secondary bootloader, we rely
> on the device's primary bootloader to implement CNTFRQ_EL0. However,
> this reliance may lead to a non-functional timer in broken firmware.
> 
> For instance, some versions of Samsung's S-Boot don't implement it. It's
> also not possible to set it in the U-Boot, because it's booted in a lower
> exception level. CNTFRQ_EL0 is reported to be 0.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] armv8: implement workaround for broken CNTFRQ_EL0 value
      commit: c9b43591ea5c63d09310713068d9aa7a924ab983
-- 
Tom


