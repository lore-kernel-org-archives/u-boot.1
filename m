Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19519C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D1D88232;
	Fri, 12 Apr 2024 04:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YlBo7W8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2628821A; Fri, 12 Apr 2024 04:12:46 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB3C881D6
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78d70890182so40897385a.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887963; x=1713492763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJYTXITRs6Koxp5Gq8D4TjYuWUZbxD9IcGqfJhvH8Bo=;
 b=YlBo7W8Jbzb5vszB7Bro5pN/xO03qXi8ayBfb3qI3zAAPcqdvLMsKDZVJXprmdi8/y
 TcXCwZ3yQHVXxnLjPaXCaVGuqC+nMGwoSlY4mx1TO2PN/FyviLXD9+lsS2M+gqQE5dDy
 EbChBuiqF1/ak8vvpwhMNT970xlur7/oBTIj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887963; x=1713492763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJYTXITRs6Koxp5Gq8D4TjYuWUZbxD9IcGqfJhvH8Bo=;
 b=YG33+fqmfNMoolyvRTod/SYIQqyED6csEWTw5UIESd9xQMmoFpcrAELdOcUeX+jws0
 Xly5C7r43E/gsKJHcVZ1tOHBPwUiwBQCYhcFtiIyWlIS7JES52xD5z8i43q7xfV9MN9y
 yohS+SVAZWovq8Ycf9eVM7wSansItMqyXUTRVGaZm7JiktX1slY+pe93AJn40MPJV7nb
 l8rHE74WDruJUdzI4QZXVhJqpw9mWSchq6Y2iUKoRP2q+WgMHrVmaFmF/zXhCdCgvlPT
 kQawRhzq/q8yuBgb3OH8lnukS8Noj7UEiHjuTCz5FY0ciI94GLTZGz8QeuEZ5xpi0ipF
 kqYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGV2LOnIb2LOFTSxWkYkVqI/cGoAtaO6ZII/wQOKp7ApjbrFB81vbaP73FGh9xy28uOnbEV/PCq+E6EhhdrJEypxLXGQ==
X-Gm-Message-State: AOJu0Yxj+bBS5CqBLYqQ1Y8eWbi32coEDGv3X6IfGwztTu1WHaQpn4mC
 YmelUjpf4YZ6s2YLS4SnCC8wAxhQI2U/Lvk54Ky3TdI0/KiI5dk3S2qKDel59V8=
X-Google-Smtp-Source: AGHT+IHAkqftnd6vrZ/Et7UuvN6VkG+T73iNRMp3KefLxTzMMCpy0SNZAvxCdYyN+mNK0da5GWkYZA==
X-Received: by 2002:a05:620a:f05:b0:78b:ba77:5df9 with SMTP id
 v5-20020a05620a0f0500b0078bba775df9mr6582506qkl.22.1712887962918; 
 Thu, 11 Apr 2024 19:12:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240326093934.2167180-1-mwalle@kernel.org>
References: <20240326093934.2167180-1-mwalle@kernel.org>
Subject: Re: [PATCH] tools: binman: ti_board_cfg: improve error message
Message-Id: <171288796178.897536.5315222952122361668.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 26 Mar 2024 10:39:34 +0100, Michael Walle wrote:

> When there is a lint error the user gets the following cryptic message:
> 
>   binman: Node '/path/to/some/node': Yamllint error: 18: comments
> 
> This isn't very helpful. Improve the message to tell the user that the
> number is actually a line number and also tell the user in which file
> they have to look.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


