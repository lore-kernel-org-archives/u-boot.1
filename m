Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD7C47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D5F87D18;
	Tue, 30 Jan 2024 02:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iH4PcKp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3543D87C3B; Tue, 30 Jan 2024 02:54:15 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2B687BEE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff7a098ab8so33557007b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579652; x=1707184452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vfiZzKTo5zdc3rAQSZcmfVHbUkb4wAvvbGKap7trJjQ=;
 b=iH4PcKp2kMg1XYUnMSwJPHo+Q4jvaitnJBItTCHQa6y0NMpy2h8brY+2JB260MZMjT
 olGefbFRfkvXyTQd9Pi7CQYknYKfoT92GWMBRq6plpRb89wW1oE7KgAWBeQwt3RyWaHI
 J+FamB4GSnjd1+wEPRvzxwN2YEUdyTqNRJ2Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579652; x=1707184452;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfiZzKTo5zdc3rAQSZcmfVHbUkb4wAvvbGKap7trJjQ=;
 b=JF1vwIPMMfI0Qp/16TXPPWaDKh0L8U1bpy1ao1IgKoPuLIdAwVOoW7l6cLkHQ/7ArJ
 drlZv89KOST32x9yzZ64msfA2lSrBSWxMpGffW55+uuPx7aQ90hLe3q0prImC8nTelUN
 OJxfztNE56kUFWPU/yqbBF/GrlM/AE8YkwYQhomnnDlQdzH0zaMbEh0lqRWZid/OEF0W
 QQoghOwlA37h7cYBq+KUIRgG8XzvbRKl8LXv9C27xhqldQURJSXNW9deCQg9GgTw4tg6
 EEBhDNTZKJ/4aOM9DWohWF8U7dD7PaeWXMlj9dJkP38MkZNh3DO/3jdhDpb2s/KuN44Q
 KzIQ==
X-Gm-Message-State: AOJu0YyNuxqDX2bKUisWfcer57TGrH9RdBtjTXwWwZXowPV7oKH7ArAs
 8++vN10QFJCJTvKU3Q75lTUkQO7TZZKr4YfwWM/XYMkm8lx5tUFsXSiMRnv06Ig=
X-Google-Smtp-Source: AGHT+IGqX5SbujmB586V06ijhzsrR2EHADHMVllfEsf35rFtdKPXHslKfGHZRbYXxrGmASlCVVAg1A==
X-Received: by 2002:a0d:cc04:0:b0:603:edeb:6007 with SMTP id
 o4-20020a0dcc04000000b00603edeb6007mr303896ywd.4.1706579651837; 
 Mon, 29 Jan 2024 17:54:11 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, u-boot@lists.denx.de, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
In-Reply-To: <20240119213216.3811402-1-ralph.siemsen@linaro.org>
References: <20240119213216.3811402-1-ralph.siemsen@linaro.org>
Subject: Re: [PATCH] env: sf: report malloc error to caller
Message-Id: <170657965136.1823400.13403258904847442881.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 19 Jan 2024 16:32:17 -0500, Ralph Siemsen wrote:

> In the non-redundant code for env_sf_save(), a failure to malloc() the
> temporary buffer produces the following output:
> 
>     Saving Environment to SPIFlash... OK
> 
> This is misleading as the flash has neither been erased nor written.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


