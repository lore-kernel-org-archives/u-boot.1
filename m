Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF12CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 19:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5290083FEE;
	Mon, 18 May 2026 21:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lsYSkg0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A8E8467A; Mon, 18 May 2026 21:33:41 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF6180433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 21:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de7c57b52cso2611117a34.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779132818; x=1779737618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1EVagP429OnINgW+JYAyZonOjWsycEyq+VJDUbETJk=;
 b=lsYSkg0G5EjPk9UqOqH4VpEYkqWbGnGiuETJ+cf5TyIlPYLtbNdG8KuejvDBIfmXZR
 8SvCwjGDfpZ38CYnkvvcOL9RJJKldpqmmACjLLHldx9QuqsJyHtyvFfNW8YlZa/HezM7
 2ZicWxj6uhqmKJgoUpqZxh6EkY4HPAfIeFBkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132818; x=1779737618;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1EVagP429OnINgW+JYAyZonOjWsycEyq+VJDUbETJk=;
 b=DmAXQfziGwdTzDP672WE0b7OBMPBOIDU7Cc6ZQCa4z5ag2qyxxtYBmere7222FxpUv
 1RWEVZlcgw0Ln2qK8HwXKkGnfr7EZHKCN3It0DN/F0Uwk5iwSQk47HG6JCYHjy0+gpAV
 uFdSzcXdh/gDcT7JMyOMW6AA4QK1IGUwZ3TmMS4opptHC8gbKhxHHTP3tzdPgsSs3vr5
 uARybteAILOEUvo461cNx31q9ncNWyPyLQVFIq/FkvsGf8378FBYpUsp0mZGVQUxwDZm
 X/xQJ3COXqI6S2Z6lf8MaetNuy276BkxhQm8XaXRCZeB4V/S4B1EB773qAo8yh8PBs1A
 SxWg==
X-Gm-Message-State: AOJu0Yy/tsihPOOlFkMgd21efsPTpzGiUum46wMyaRAiBRVkeewVi2yQ
 9Ee5nGy1edP3os+W/ceyIdKC5BZMzL7ybZSYcDZRbUPw35ihLrBXf69BJzOPefJ6J8Y=
X-Gm-Gg: Acq92OH0r6F4Vv74r3c6/WvmM8eWHDB2ASl2EETl8fkmIhXH8pXIAgy2s/FekYjQ0q6
 V+lA2/jNB26tHJ/p4a2Wqz6OHbOSDoBGFUCpVEfqUWMmFcnVRrlbtYhia8URxqA8XH89iRwDqkJ
 Kp+0q/IyeTdMZuIkk5fUut7lcKHDJiGsd145m46GMYjzSjYD2Ao6m8LYJrJKcXnpb6NneXtwz3X
 sKYHALja5XyBTmZpH2yCQhX/CoWKaSgoFTO4vIURBFyZS2AeBmgf0bH+GBKlGRu0FQFiQyu/LiY
 HseQGT93wXJ58Ge5P28MtMNq3C8mR2APn5XumA2nixJBsYZgaZp4hJScPcCrqcdnVZ1ku1uVGV0
 OpaLXfZZQdQcts2XzXGxxXMkcs2wNByuTzVfQk2K2qkbJARZs5qgpgs8FRPbEqcukZbgC2uts/S
 KocVc3ohmU4hxI8e2eADG3XEnnJCM0hlaFGqtgN0C2noLPJKkCQbeRpjBLOVWBngLXUXUeh5pYy
 vG5abzPBMEmNV9Eo903ofc30JFHjyp5dQ1SLUq4KbS+Yh185o+viYs+q/yw
X-Received: by 2002:a05:6830:600c:b0:7d9:b189:d938 with SMTP id
 46e09a7af769-7e4f2a43a18mr11457246a34.10.1779132818395; 
 Mon, 18 May 2026 12:33:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7805603a34.8.2026.05.18.12.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:33:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, antoine.gouby@toradex.com, xiaoning.wang@nxp.com, 
 fedor.ross@ifm.com, fberder@outlook.fr, ping.bai@nxp.com, 
 Jacky.Cao@sony.com, marek.vasut@mailbox.org, peng.fan@nxp.com, 
 simona.toaca@oss.nxp.com, ye.li@nxp.com
In-Reply-To: <20260515233022.2898860-1-festevam@gmail.com>
References: <20260515233022.2898860-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260515
Message-Id: <177913281613.438611.929424347182929768.b4-ty@konsulko.com>
Date: Mon, 18 May 2026 13:33:36 -0600
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

On Fri, 15 May 2026 20:30:22 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 88338f9d147397c42bb996937b1ce31bca096626:
> 
>   gpio: Correct dependencies for MCP230xx (2026-05-14 15:54:17 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


