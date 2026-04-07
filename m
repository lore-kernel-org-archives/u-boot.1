Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC920FF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEDA84189;
	Tue,  7 Apr 2026 21:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EL5+b4+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3308412A; Tue,  7 Apr 2026 21:50:17 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E3384154
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso3306412fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591414; x=1776196214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXrFR8IV/pvKWJgEY09kw2c1GIfNhRfaFziqcgk+LIE=;
 b=EL5+b4+U/rMbvKQr6iRf+4PHRm/7fRoR3uQDegrSHz1MbPrxie560FhjeXLm3BKJfY
 Fdht9A2r/VUq/4irIjmM6eXB/Ud3DrOoJgduh4ZXRU8XRHyzctl1lcjEfDgZPAOfUYrX
 5KVW66h7nUbIYx6KoveBeO+r6Qcd24rfnSUOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591414; x=1776196214;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXrFR8IV/pvKWJgEY09kw2c1GIfNhRfaFziqcgk+LIE=;
 b=eJLbhLjTKTjJgSAnlh3JrfSz/p6QHx7LVgPnu9otdrzXiq1+NVyW27gr6xkgMrWpUz
 JWBITCfNHeI1ySgAqAIBTs2NqJwmgx4Bh0UZobIKAP5ErhUOTk+NipSYXFt3bOWVifEm
 z8Uq8sverinRV+OASLJaeUaxumzXgbWY/T7SYo3adwsz0HQvMaqm0yjoxJgZ4h1LqZmz
 pDmbSqCmK1+8yHdbZ0z89w1MOKMkVAq+LYvvuE6MBnSq7RLZhfVV1aUkFQuCjgZ9XCqz
 cesL0P2/X0hgH3rNu0dr5Q4JerXKKwH94tBQumuVFmbbrvO38lr0LbsURqb/UvnhW4Ui
 RivA==
X-Gm-Message-State: AOJu0YzvyuFfXxAOeNsJbPQVDWSm4g/ih1bg/RyEmUuZNCSrjDsk+hFN
 JutBu5ZPvK8gZmq8SFckGjry3cjBh4hbgZ8pKRTD9MBqysW7lMzEFVMou+Ok1rlV5LQIAEUnDC3
 /54ZIv0k=
X-Gm-Gg: AeBDieuokAgMusRSUi5k19UBusqPjJQhbXGcJHmUmuO6uE8KGphhHuVifVK5B8B72zU
 DdhfLJiBOl4Yo3u1COMETL/VXLNFZbVGIOomESuqahEvge0Sdz943heSK6UVaqicI6KzKwVzs5O
 7ZQ8a/1fN6OBw8zzR3t3YUeBKMmiDbNQ+78eMAmpco92R94QnKnHixEyv0lkEYkgcmEey9S4rio
 p7NqfoRiZbIAjZnTYSqKxBYV02+xT/nZUwzLkOvydLlr5VtwoNsjGeZZhZRgD59yvJXcXhCxC8a
 bomHUFn0VcFNEYF8m1yX1RzBpUmiycPbtERteFxbcHXlTUv6wgHnVOwImwx+NLB/DYELacJNOhJ
 dcBDn4vdSYzuydLqDAHr15xhB95xXoOyl66HvTPgyHRuiuhWBk3ylxXnEky3+f3vJ/CX9AzMqKF
 13jFtM8tNAR2Q6RjDi7NWy2n8z0mvweXdq1sVSRR7tV27WarsGOW9/8ZYFOPXPhe116sQb9VKUy
 wYsO6CVTNArm7lGoB8qqqnNn8P5LIfsRLceh+2Bk2ATgN0=
X-Received: by 2002:a05:6871:791:b0:422:e938:6b4a with SMTP id
 586e51a60fabf-4230fc898d1mr10599126fac.7.1775591414474; 
 Tue, 07 Apr 2026 12:50:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260323195251.2363468-1-trini@konsulko.com>
References: <20260323195251.2363468-1-trini@konsulko.com>
Subject: Re: [PATCH] w1: Correct dependencies for CMD_W1
Message-Id: <177559141385.2108693.16397675844859574781.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:13 -0600
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

On Mon, 23 Mar 2026 13:52:51 -0600, Tom Rini wrote:

> The CMD_W1 functionality can only work with both W1 and W1_EEPROM
> enabled, so express this dependency in Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] w1: Correct dependencies for CMD_W1
      commit: 7289867a8d73525da169e0f340686b5138b8e50a
-- 
Tom


