Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A5FC44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B96F83B0B;
	Wed, 21 Jan 2026 21:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTQOuFmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6EB83AE9; Wed, 21 Jan 2026 21:48:47 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8D880077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfcbe7d176so103032a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028523; x=1769633323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHpM5i5SZUXu6YBMRJjJjrDqyUedFOYkOZSEP7ILbg8=;
 b=rTQOuFmyoLaUTxgw9C32xP858D4Iv/tlTZp8GdbEDDzN9FdFmW3+rp3M//Gsvcpc8R
 W3LlMOYpQAFC/RlaYEOmyqB/4B/J08hMlMvRLnQbWjv6P21dtoYZlZvfekgrFMwtL5Rc
 WvVxI1ii3wdXJqm9bMA9HzFDeRbPyRTwp1RZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028523; x=1769633323;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UHpM5i5SZUXu6YBMRJjJjrDqyUedFOYkOZSEP7ILbg8=;
 b=BQ4i/m4Vg2Wi4D8+GW7JWtlsuuBx0X6aAc1W3Pfgzp9hEnXhY1AXzsNiDy8dS5zhe7
 juTs8ZxGo4R9XJZHD4ByXpq4SLdYJTbGjvd4unV8aQZFa5YuhlIZ7dSodTILcl3Z8RRh
 ONOxObVJR6stjvO5S4yPhv4FJACH3e3itsoclYu434nVBcyHDlaa4I10iE77IkQTtbcD
 IJZmlyQ7v/yj23aT3y/UXoFc84npxCg1CYQKRS3jXVnLeSyMp6xT9jVKzJvrUT2CAzX4
 Y7OVvD+BbYyz2j+UlfA17Vc88F0zBeYFumVhvrGA/2vtPtiOBVh7lqwdxMwBUp6sJ9eE
 sj7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa137PeTRVrJ7qq6l1kXYPN8WEc0roTVJfZO0kpCLVkGPGiEGgCADBB61HvySfhw4/F7jjT94=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2VdwHsynKq4DxM2wPj3O4Lbaa+OdVveRcZecjREVQ99dwnsTl
 H9pgf75IRrJZqfjNXpZseNhfV6AFYbMna+okqKA1x17HjVVppfkAhX1twF99BHLbb873sZnagUf
 5nJxPZH4=
X-Gm-Gg: AZuq6aK06aGYfmvYu4gqMfGS8PLjM2FwsgOdpaQ28rk2bI8EY2fFa84bFep8WGE8gZ4
 LxsZPBcC3frqgRxx6ksS/Rc7a195Zn4tvZDY7IIn8W40YwSSC141ZS8uHcnZieXRHhIiFg4ceXa
 R+3sCWS+l5eMGJ9RxqVvKlcI0DJ5FZQzFiy29/o8yySNxU44032vDcaS6KczSrCKCxqwQe30E5v
 nQSiKydTS4MYsXIlPPpmjVvkmGDyGSt+T9FPHjFf3HEPaPR/ZzBlkRjEdYuTS2RgjBRpWR0SXXw
 7KEMLLcaPWfH9Osja1CkkWrjTxZApQ8UM6W4E9sL5r2/oKd5BglGz3KfQIhqRm5XIlHKlDRKrxG
 XgSFtN87nfr8HUKvtMjS8fxQE5EjHAfQlH+gDotGHfY0lA7XDM+R3ASUkvhNzxL4Dw4Jd9pof9E
 BgQMdqlEK7A5OprQi2QuB1exNORLGh+e0ARuu2TXdPOF4nX0IXDLZjG3cGG61OGC34gpqwjsX7I
 KEVmg9oSNatEVcrEoT93zMNu8dpfkNauSnwgQ==
X-Received: by 2002:a05:6830:6992:b0:7c7:b4e:edb4 with SMTP id
 46e09a7af769-7d140a3ddf2mr4514358a34.8.1769028523359; 
 Wed, 21 Jan 2026 12:48:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260113-pinctrl-mtk-fix-set-bias-v1-v1-1-eacf0e88ec7c@baylibre.com>
References: <20260113-pinctrl-mtk-fix-set-bias-v1-v1-1-eacf0e88ec7c@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: ignored error return from
 pupd/r1/r0
Message-Id: <176902852253.661474.16504936358654999783.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:42 -0600
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

On Tue, 13 Jan 2026 19:48:31 -0600, David Lechner wrote:

> Ignore the error return value from mtk_pinconf_bias_set_pupd_r1_r0().
> The PUPD/R1/R0 registers only include a small subset of the pins, so
> it is normal for this function to return an error for most pins.
> Therefore, this error should not be propagated.
> 
> This fixes not all pins in a pinmux group being configured in some
> cases because the propagated error caused the configuration loop to
> exit early.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pinctrl: mediatek: ignored error return from pupd/r1/r0
      commit: 2d665b9cd361c4b6d100d3b1b5bdb6e0d1725486
-- 
Tom


