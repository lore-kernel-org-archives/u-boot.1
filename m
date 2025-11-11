Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E5ACCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 22:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2451283B83;
	Tue, 11 Nov 2025 23:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hfoHKgqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74B083BB5; Tue, 11 Nov 2025 23:16:36 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EB283AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 23:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-656b7a2e7dcso78968eaf.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762899393; x=1763504193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp2eZY9iOUIhhqS/jb63Fggrx+r0Id8ueo4HIqSrG/g=;
 b=hfoHKgqgZ84SjW/CicNg/Ex20ePjl6zFnkfBQjGzY8LQEaZLaEkG6OEJcsnLCoglbM
 Jojy3KYeIfIhm+Km+GWWyUwkOJ3CVx5LBF14v5Arcf5MLVKIZJs75AeyAbg+pfwRF4jI
 Tgd6Ol8d4CNTfLXIdTxjMU6fgClRPBX9RqEMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899393; x=1763504193;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vp2eZY9iOUIhhqS/jb63Fggrx+r0Id8ueo4HIqSrG/g=;
 b=fOOkU/P3Th7aj0+7bu29hedm65B50QZHKsWvPkNiMyiX4Mbj3EtYGbymWuGPvFjwjL
 e+q9mEaKV19TLPSTec+sKifdulxl0u1C1+nyjyQw7TPB/C5xjGKcf4tm9oiC5DKg9RXu
 /X0qy31/Rd/JebbEOr9VrusDrE9ao3iG5bid/Adq811CrVSXXSLxWMQtYDLl37IDstxD
 fNzrj0is94me+SemVbcm5d6vQa1XDhmugzG0Ob1ugI9cCzsh4qp7gtNEGLcFO6aMHyH0
 gi6vLYahwRCWmno/60dJFcC5SACI2pfnZIp9bKAAbh/7PWqO8GqgxXojlx7YZIpbwwgq
 n5jw==
X-Gm-Message-State: AOJu0Yww7dkY40pJmkJQao4r2adOS73bPWxvpZd0DbkHzePuItvfdL9s
 wLye+YSRCcmAbHKDmLfUBLSqt0h4amrShUTas93gBuDcSXXpt3suehsSf5W3tyO2X3s=
X-Gm-Gg: ASbGncuBGYmwtqURR1hDf3B0eymuRWWtBwsxth6y5h61q7e9wNSZ0h/ff8wJ8l1AEwC
 YinQM5VRtGw+UWJIAFyNUiHuzl+SApLBLoa9C7I+KThytmcYhAEDtyBDWvg4TDH72RG8j7Oj39p
 JwhTnQ6VxswXiGoEcN1Sz74R+p37KyJUfmCddab0QlHQt0eg4nleMVmZrzmXMfSc9onKPkRY8XY
 Au4V04b55T7LBfsOizEts3uG79afnFH5LkOViA7ECUOzhwAiVzyREJ7Apr/T3PiKUV4ZrNw/w98
 LCj0S3FsYoazNF9F67NEH0UNLqmBlw4yUayCMReuCIrjqoA4LtZ3odvHYo11y1eD1LR2/f4WXdO
 x+U6Ow8EvTPjJXi8nEaogMHNlhYkOGs8H/A/ZR5FmYL7LJjU73j48qSlMbfIdmDyjKCy08wkzV2
 xvjGWy/KXRekKYFbc6X7uztecyQqwoCMaKuhOzrTrBon4T9Kh3
X-Google-Smtp-Source: AGHT+IFrTkhxvP+X/AdR2/DdIKnGEubp0MtUFioJ3L0iXV+NDT0RCdkz6eUTnu0FQUkbF6IgHVKn1Q==
X-Received: by 2002:a05:6808:1a19:b0:450:b14:7a6a with SMTP id
 5614622812f47-450745f4052mr353204b6e.60.1762899393076; 
 Tue, 11 Nov 2025 14:16:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500253ce65sm7448872b6e.5.2025.11.11.14.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:16:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
Subject: Re: [PATCH v2 0/5] rsa: fix dependency, rename and relocate RSASSA
 PSS symbols
Message-Id: <176289939147.812914.10339160350215456166.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 16:16:31 -0600
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

On Fri, 31 Oct 2025 18:08:19 +0100, Quentin Schulz wrote:

> While historically signature verification is mostly done for FIT such
> FIT_SIGNATURE dependency for signature algorithm makes sense, it isn't
> the only kind of file we can verify signatures of. It can also be done
> manually with rsa_verify_hash() with an embedded public key.
> 
> Considering the impacted code is guarded by RSA_VERIFY, let's make the
> symbol depend on that otherwise selecting it without RSA_VERIFY won't do
> anything. The FIT_SIGNATURE dependency wasn't also enough before as it
> only implied RSA_VERIFY.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] boot: fix incorrect dependency of FIT_RSASSA_PSS
      commit: 63686bf6e02b57a259e6e08d6439a7d1e154f5cc
[2/5] boot: remove duplicate config entry for VPL_FIT
      commit: 013033a2f9bd2bc634688bbaa0fbd91eb729d108
[3/5] boot: group SPL_FIT symbols together
      commit: 973019000c2734ae560e5f4f5a58c9cdf85cffbb
[4/5] rsa: rename FIT_RSASSA_PSS to RSASSA_PSS and move symbols under lib/rsa
      commit: 360dd89b361dde2a0bbad65763538e1eea7d3c94
[5/5] rsa: update doxygen doc for RSA signature verification to mention PSS
      commit: c50f6b11b3242adba0c8a3a6a50082a2eca01772
-- 
Tom


