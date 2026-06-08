Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B83DCD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 18:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E878407D;
	Mon,  8 Jun 2026 20:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q3FjeFSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADC984701; Mon,  8 Jun 2026 20:46:49 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E5E8405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 20:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-48633190849so1848917b6e.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780944405; x=1781549205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njjPJAYh4BG7cbtprOCzX7HRR2WFIdoe0sMK6KojmiI=;
 b=Q3FjeFSh++bRFlsTcmFHdGFAs+XYRf3rm0RPYFwgvfV6lSArgzAMDfBUpQWvKeGjQJ
 K3QXFK7uPsTIqUs0T8nsGDTHxRpNYcm13JGkTVoC7sC2XND+J3tqFtLeHLvdH5IeIKqm
 GwMU3Pqt2qfeVAbb9tMqhV9XZboOzwqrKHlXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780944405; x=1781549205;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=njjPJAYh4BG7cbtprOCzX7HRR2WFIdoe0sMK6KojmiI=;
 b=pSzpJOBOS4KkEba6D232QmysehT//AX8n6A220TxUvlVcigVZnW4vxleQIU+k5IPIf
 G5I0KSiw/GpkE3qVQhn4T9W5qo/tomMoujK5AZ17xVB+a7C7ohw7UZEeda0nt3RDjViI
 dqgrtcoK88R2VTm0iemJOTqQhz4FhhTQYNPXf4gO2K3Nkvm7p/tUxkim2V2XcqXUeUZz
 u1IpsFJMMo63ElPls9rCsxiTzPfD0mga+0Mzbb5Nu8Y1+3bkH5LFrbZJrHcZlFGWWm6S
 nC3LBt15utO4UcE2NgEQi4al2ve8Ip2FDIgKFE7NtcRjRO12W8nSByIAbKLBPr6AZimq
 LSGg==
X-Gm-Message-State: AOJu0Yza3YGIZELYSBlk3gEsBePNh9Q6cALaG26urwl+xECTr1lchlpN
 A0fyvCVD5dNI/ZzeU48FrzuMvJpbxy/nOMvYGJ7sbK/S4iGGicz9evXzHtwEbUx5lp4=
X-Gm-Gg: Acq92OG7v1t0nr6TN/JgXhur2ErOhDai4lVQKfPrs7FQlM4ueuOcc/F1+EE3QlGA40J
 a01w7cxMb97s28/iNaID4SCyiPIIBTz3J3oj6ofxCreoTWbBiqDch73OcmOuQcsP3Pz7xjgU8c9
 j3xVKoE73Ipc9fMleXcGIWAC9dwF1rjafccItUPiVaVitqZAOMDO+gysuaG23uoVQAy0eHYuV6k
 BPAcXJ0vtyzADvw//NGI3/wVrfatT9siC6PXMoUU4U2vi64AAFCSuYa8ZuFDMEPouAlbPLi4Cbr
 rPbREOoDn9qUmkcEzguD76iI6nuKOOi/8usBzXkdZ4xlaJUy17QSx/jisqUSOEW6KYhFMZNDw6c
 0lOONBEZDtvwrur7AV+YWlafdQdBlpGHOJYOy6NwmnOwLaUNQv0V7rc83BINwzYOx3yM6UYbJKb
 Gfe0+YScWKV4/kJKeMMX/1lMQlRvM70kf8V+VjHcE7Dl4ySKyHoZUHvep+qUAnuqVozwnEUpXG8
 Fgxa5rsGwosCJ6EarDf5/wFz0QfB1FB1W6KCkxFkgbt8D+4tLN6LxRge+JM
X-Received: by 2002:a05:6808:1185:b0:486:37ab:e80d with SMTP id
 5614622812f47-4868dc45c00mr8456335b6e.1.1780944405690; 
 Mon, 08 Jun 2026 11:46:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a53bcsm14318969b6e.3.2026.06.08.11.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 11:46:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <b1468ad3-a7bc-4a41-b9fa-547cdfc376dd@amd.com>
References: <b1468ad3-a7bc-4a41-b9fa-547cdfc376dd@amd.com>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.10-rc1 v2
Message-Id: <178094440488.667963.4063168310533496749.b4-ty@konsulko.com>
Date: Mon, 08 Jun 2026 12:46:44 -0600
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

On Mon, 8 Jun 2026 14:51:14 +0200, Michal Simek wrote:

> please pull these changes to your tree. (Apologize that it is marked as v2.
> I have created v1 2 weeks ago but it failed in CI that's why I didn't send it
> out and then created new tag not to do force push).
> 
> Thanks,
> Michal
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


