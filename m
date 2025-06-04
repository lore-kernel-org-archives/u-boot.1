Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA50C61CE8
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086508091A;
	Wed,  4 Jun 2025 16:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="saDyHAzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1753781E72; Wed,  4 Jun 2025 16:25:41 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 031D680584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4067bab37a1so4299844b6e.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749047138; x=1749651938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqX92OUgv1qMUJBvkdwKF6dyM6dZebLVPjnJUrBKQYg=;
 b=saDyHAzgoPauxgthlbtmrR8EdAHAM7mVGB/C4Zvqf2TgIr9Z1Nk+aLF/TiHY9iKsJk
 RsTnCHeLbPrdXGQeln6OYmJQnAnDvNxdvDJnvGkNQuVLsiiBW+nQSf1LiLdgnZdCpLBc
 YoBtgBuISGW08Xyvd5gZXIXeBLWR8UhdRrMtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749047138; x=1749651938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqX92OUgv1qMUJBvkdwKF6dyM6dZebLVPjnJUrBKQYg=;
 b=Vjn+pVwOLtIR3d3yE38qHivlzrw6DKYKJdnTdVX2hW8bry+8ZEh5yofEJ/Xo75/1o3
 ABkJlt0ux+pRJrTAOuOa0sDHsx+Vi5qEphqe/ZI0SH6BVmxnv+IJb2E0qwm7s/GPk+2O
 A0c6jlTHIBbqyexz/hFJZ2G3zOyD/fNxMiiDGeHjt7cY/HcySHlqE2ztYqxjcIWrFl0I
 FJVMqSfHtWL9jxi8qlEQ2lfbPJ3ytQefxwQfa12F/lROjkqyQQt+8RP/y5QgQx4p4s0N
 IIoSsLllJEBjD7xz1tvDvDRlzSVsVoUWltAijcexzeVVJB3giPwjq1nlPy+2FKCcmF9J
 lxjw==
X-Gm-Message-State: AOJu0YxvHbPAIHA9kB8uU3ghX7XUSCc1Y0GRsvDPTYMT5+be0JAr/R+J
 O0QoB0s0ldPk4RBaF9FR8tC27JXcpL0HSFG1KR6wU90XHJEdh/b0zujhGZncWoCVJEaJubcy+gs
 ZOTiCZ3Q=
X-Gm-Gg: ASbGncvDK49iDHXyeoKT+8mj3Esk0HEhXT6uxSKHs64HfLBYYQssdTqe9tsq8WvoXIB
 v1PZv1OzkIzxs3bdLkhxaF3IuoU8N37C+mzWD2+DvXK4BExOhF38vq/GKeNAvOMfjd+fY+auzRH
 m/6u0leDoeUh5oI/169ym03SJ05odThLlz0P0FYc9TzUaS6HM9LM3+H3LQmmRRJwhHiZ98JeOOc
 Pj1+5SCmmye4AjWMWboOaxVtuDVmYMlNBmQaeeIjTbLCK7OzrPGD8J/PZhQxnMfszwHjw2s5dij
 0KSG/UJSc98b4V5yZ7XSTXddEgxKdbM7WpM7IpwUNzrJFdiARy59aZu+GIOHSrmSBHovtpdwwdk
 hVRvabfl9xxs=
X-Google-Smtp-Source: AGHT+IEt1og0z1W0ju/t8FZ+ArYi3EBuV+CVbRiL4gyzpUP9s2yGvZ2HC5DaL2Y7gdzxjJ28xfkdzg==
X-Received: by 2002:a05:6808:3206:b0:408:e5f8:9e2b with SMTP id
 5614622812f47-408f0f51569mr2688295b6e.10.1749047137813; 
 Wed, 04 Jun 2025 07:25:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1b276sm2216669b6e.13.2025.06.04.07.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 07:25:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>
In-Reply-To: <20250604130923.1484873-1-sjg@chromium.org>
References: <20250604130923.1484873-1-sjg@chromium.org>
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
Message-Id: <174904713623.1922758.6968311277085505990.b4-ty@konsulko.com>
Date: Wed, 04 Jun 2025 08:25:36 -0600
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

On Wed, 04 Jun 2025 07:09:02 -0600, Simon Glass wrote:

> The condition here is reversed, which makes link and coral very slow,
> leading to lab failures.
> 
> Fixes 6c171f7a184 ("common: board: make initcalls static")
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: Correct condition for init_cache_f_r()
      commit: 4ef863f2d69417df2bd88358bd79a51995ac5bc5
-- 
Tom


