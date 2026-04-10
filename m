Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC36F459F7
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 730C58416F;
	Fri, 10 Apr 2026 18:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="g+5F+D5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7764284181; Fri, 10 Apr 2026 18:07:10 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8AA84118
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 18:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d9e22176a7so1158802a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775837227; x=1776442027;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLAUykl57moEeCMIFNyJF6+s4Qq3ZPKR1TPN14wKuyI=;
 b=g+5F+D5XBFLsG5wv78hoMSZ9JPl7I/gj29C8QCzyw9KaJwhMaSxPoVyUQkb6ursGGn
 yqyqhjSzn+LAj3+Umw2XzySX3dbqu1AAEkF4dGSu5LEqqfzYBNZYkQ4AksQlZlwQFVh4
 tUc0taq+2+B5kabp2ph30Gbg1Aux4CVl+9GoJZHzbCfxgmsJi2Twn7VLbaMsgO9xNLpo
 RH1UM1uIQpJvX7Jl4NKUuzxcRQXXrXeyZn8C2alb3gw0//nxbriUra2YlQOZYTklUUoG
 qMJ9kXbRZiaC6KhSfRgt8yp1jhnUO54LuJxx2LnXjk4+dRJqHl29HTOsTkx1cQ4TwJko
 P/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775837227; x=1776442027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zLAUykl57moEeCMIFNyJF6+s4Qq3ZPKR1TPN14wKuyI=;
 b=SfJcIXQdWUeG6mHSf7IF1GxQzzeOoAC9KCn4cFp7ET7YMTtjXjZFWHQcZCFoTTt2LP
 aopwa1fkzxpPfK+biMy5bFE1jIYlsdQ1HOPKnmLipGbfiEs+nO8AF1F5prVef5/OjNI6
 qMtKCX67WpqVwRbJ2AMb191AQRBn2OnC4P5vgqyZf7ri7OimVs6pIhRmCH5KkJs58zbm
 TG4ecHCyW0B0PidnuDn31SaPdsODadYpn2Y0LVWEMcP8v81T8J//s2aUmBLrgN2XCcl1
 bibRFXzDLhlUQNXsa9m+gwA5yq3IQriRAptVb+u6XlEHEf0rviCo1aMMNlvlC6H+aVyc
 cUoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV/ggwqHOGRMYunU8gCF5PJyEnAl0bv/aAUjaEImTrDI3D5jhiX1UQ1ZvGq7tmyKyQ0NxCYSc=@lists.denx.de
X-Gm-Message-State: AOJu0YyVEs0OeaooC/ng9LuPelLNumIlT9qHfuYJ5fL6Xy/6vS9Z7D2j
 GUCv7hO7E+ZSJ153tF4lIkdGXHpnXBZQnzBO4WXDKvjN/fiqezSR50hXb2/OTJ48M8I=
X-Gm-Gg: AeBDievzknec7FMAg1xL6KaZfKnr8bceh2TKnXCk5GZo/Siq8DcWdZbNi4y7kYUwc3D
 42oPvuG5EBFZi3FoikP43CDBTPrZI87kJ/ozN18I1Oek5LOrzpvHLhwfvHc9c0TJ2bK/0xB/jTq
 PB6twnur8X4xKAfToNSUEu9gcX1md1PIlK6vLUg/g26jIwbf7NYb507hyTrn7v80XWcBC/PHDZb
 ArEj2jaaepS8gad5hVSzFsxTUI0/K/0jGGq//6leKUoB4J9KghSW1djm1FI4r2+wH/7rTsBYxI2
 bgb9Bwr/+8MkKVsPRA+bc247oIeOGYTE+52e6eICk0Q7RmBcEl2NNQgsBr9shAOGKH/VOLH+xxj
 3RSkmyHI8qovTg9+9I69EPOVYL5Ak544HvcDS00AF7zE02Fv35BboZcFb0s0dAQ9j3t2oZe/FJ+
 JrfKMBwEFXvvkzIsS1sg3OJGMOfoyn7OW5B39L3RgIaQeI1g2C0aAf6rSsFHFZTNqddVxiUUeZ1
 w==
X-Received: by 2002:a05:6808:1441:b0:467:20b0:1c2d with SMTP id
 5614622812f47-478a04fe118mr2325523b6e.38.1775837226717; 
 Fri, 10 Apr 2026 09:07:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b?
 ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddb9c504sm2558014fac.15.2026.04.10.09.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 09:07:06 -0700 (PDT)
Message-ID: <5176855c-6d04-4361-8d94-ac82ffc2c4e7@baylibre.com>
Date: Fri, 10 Apr 2026 11:07:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: mediatek: remove redundant forward declarations
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
References: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/9/26 9:12 PM, Weijie Gao wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> The clk_ops structures (mtk_clk_apmixedsys_ops, mtk_clk_topckgen_ops,
> mtk_clk_infrasys_ops) are already declared with extern in clk-mtk.h,
> which is included by this file. The forward declarations in clk-mtk.c
> are therefore redundant and can be removed.
> 

> Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup functions")

Since this is just redundant and didn't actually break anything, the
Fixes: tag is not appropriate. We can remove it.


It is also helpful to include a cover letter when sending multiple
patches.
