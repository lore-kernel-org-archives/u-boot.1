Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF5C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24B982CA2;
	Wed, 30 Apr 2025 19:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SZ/R0w31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9948A82C87; Wed, 30 Apr 2025 19:03:51 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6535882C75
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-401e77e5443so76843b6e.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032628; x=1746637428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OXn8XfF7rxRYwpZOqHvfy8f02PHQbAPWT5cGGVukx+E=;
 b=SZ/R0w31SknI5VYIUhLHCiedr7WMjYakanT/ypbEd6W3rGzZ5cgwIsNwODA1i9Z4sa
 eOvj6bcKsdHu/2V4vuCgTtfKNTbrwGQigRe1Q7hEbcd1QghjBYZL1DnEMzxbxzKLtd2x
 XJMZ+N/W3UHL75/YhEdZqETh7JdvYCsDvVNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032628; x=1746637428;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXn8XfF7rxRYwpZOqHvfy8f02PHQbAPWT5cGGVukx+E=;
 b=Fc0dOi8EJyhc9+M0osx9zXabsRTaQIE6TM0g/9RE7kSiLvCNWmJK4hfiWlnjo6pwaG
 MyWrfM/5A5rKzoS94zbHxjONgCKuFB1tSlp0v975/CqvFixHgtotH3dZ2Di/CahQN8P+
 3LSxb/r1n7GotEeXBopnR3XT8/I5Dl1Y/ilqEh0l37e+i7Vhdven9oGDZSN7ZYSBmVUE
 pJW3fg5O6SxQ/cqMEb8fzx3VR4V56vr65pDxfTapQTXRLzANN/PlsoBB6Fjz64C/7GuU
 is73izW5S8rk0v6Qqq/p7Q2+5cRnOOLBLLEXUganZdp3n8C5vk5Nk23KwPUv8Ksin1MY
 Jt+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ucTinb0nReZpTuM1sqCmjcdmKRUnYV0uXqm2k4jjmCxvYBlk3X1EjcejZn3zn3kfzk6qyao=@lists.denx.de
X-Gm-Message-State: AOJu0YyMXWhpHd3+K20gMuzfJsiyw3QqEkeI+JK9Hn+lFErSiQy9agtz
 LPnzjqdye3vIQAUWoFJ+ztcJNrOf2ohUWHmVb/eBUdL9rwMGGG6F7LCG+Nfx7pg=
X-Gm-Gg: ASbGnctytvb2xV9Il0k1fKBfxZXVLLEJBJrR0jqsaaS3a1UiuPoYleGR1+Dq7u23mi/
 3Zr82HoBrOvYZNtQRi9afKmJLv19iT/3JSVdfCsetLapM1W48nOXnMDlS0pwZZiHiiJ/DDuFgvq
 fKb9G/Tkgutm2ye/cvSWo4JfYThJnKQ3Zd7JcdWr2XNzvM7EwNlS+WE4Be2ltSgCtfSVVDVL4eN
 6BwE6xr4TkquMS20arubKJ5R6Mn/ezZDO2trKRU3UxKZWzoZrW0rg0xs4y7dxxb6PLw6n3Wizdx
 iVBeMKjvJWnqqguExb0eIft3IyhmTPUBZXqNp0Bc/BSnzDaB9WQ1XOod2Ej0ePclJaZukhfIDwj
 M
X-Google-Smtp-Source: AGHT+IE2EAzGa/a6jTkJXXd5g6EL+cz0LjqeivqKXOqozWgimxcY+p+qD8RYcq3S162Aius2TwzyJA==
X-Received: by 2002:a05:6808:6c88:b0:401:e6b9:8e2f with SMTP id
 5614622812f47-40243910ae7mr2520498b6e.22.1746032628058; 
 Wed, 30 Apr 2025 10:03:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tero Kristo <t-kristo@ti.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250315092420.793-1-ansuelsmth@gmail.com>
References: <20250315092420.793-1-ansuelsmth@gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
Message-Id: <174603262710.1760506.16496617185673651753.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:47 -0600
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

On Sat, 15 Mar 2025 10:24:14 +0100, Christian Marangi wrote:

> It's currently possible to make the bootloader crash on calling
> clk_set_rate caused by the loop in clk_clean_rate_cache.
> 
> The loop assume that every child of the clock node are also clock
> device but this is not always the case. For example it's common for a
> clock to bind to a reset device or also expose a syscon if the clock
> register map is also used to apply special configuration.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] clk: fix crash on clk_set_rate clean rate cache
      commit: aa96cda0a58f4d181b81a897b0b9fea3d9729478
-- 
Tom


