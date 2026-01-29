Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB4D61033
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896F5840A9;
	Thu, 29 Jan 2026 18:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RWViyZmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FD084081; Thu, 29 Jan 2026 18:19:06 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246A583B72
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45c838069e5so795707b6e.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769707138; x=1770311938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=496GyNRINlSUqIpkEFwlH+n7gOpORUCF/jake8ysZVc=;
 b=RWViyZmI12GPDGZQr4hy9n+skNtA6aDqfpwRTcWwpBi3rRNHnZlgsSTMPFJe5JoHky
 6c3dmbLS7vm3S3b74xk9YDapKYtg04y5iKD0quBnekMpdT9Q6Y+67OX2bNZEqIXOftbP
 iPiAqd2ZL5G7G++yyb7kiuUAcylCCfBfVWmDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707138; x=1770311938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=496GyNRINlSUqIpkEFwlH+n7gOpORUCF/jake8ysZVc=;
 b=QIYGxEiAjZSvNuBU9YlRqhxpsHVAxrZUSe0OXbNCaQtXLTJdM0x0MWTuLqU2rn/0nn
 ooXPcB5Q9TTOmUg2K7Flg6BRz3v0KyYtsTmCwIC84AVANvvQEHaTmsn7ljt9Uh2y/GDA
 f9K8gAbMVJfTBsP1AAlsPhDr46NPe+VZhlC0jVT+ztejqPiX/x+5YvIhJnuGKYY4GT5P
 +o+ukHKfrlTeCBUuOQkl84REtewKI+3Fv7aAFZ26uIZP+xrYiEL9jneA5hZxDPRAkKgW
 f/sRAW+Nh3InvtpS9UkLsGkn2U9Bcwst5ZioQY+WAJT+bVQAwa9Mn4iyY8Iux1AmIqip
 eOiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6nrKwkiBmjLeID5dUV+Os1vvtGAwu5c/ZpBCfMryArihsuF466o/VTJi/7LJzyi89QtT/4t8=@lists.denx.de
X-Gm-Message-State: AOJu0YyNr162gU7hZ6si2WjDQg/wFT3q3jkbCLNWc8/43NWefBJ4QH0W
 +r4B/sxf/OIL26qeye0e+LoHAAGAYWXBFvAGWy3l1Z0N6z8wtTIK0odcAg5cQ1xb8Mg=
X-Gm-Gg: AZuq6aIGB/ziQfmpKLG5XvitCp0s26lR0ME8ivVMUUsu0aFz00HTjQ57G5tQKYSp8zj
 qXO8yZvy+MZu+smimvJnqf2Vj2x4RVKOMkbWV9N/oVIw95vsbYup5yepv3veTdbppHyd8mzIqhh
 OAHTw5DZWp7sZRp7v42AbHp5HOAuMOVAlkQqicfnKChs1Ws8A3RVYomTJAi0LNGDzYf46aJdBaJ
 UWMfP/i1rkapETpZrVn5sV24V5ZJt1O9n6y+ehe9KAO2G4qqwrm5yN9j8u/YQcrNFWhCxuX9K+l
 +SHp/gOIZWVaTDT6qqjHe12AyZld/1WNvg9GQkxE3ZQAzHFyJ67cugo2kSCqFzUIvqAjrmhWTuD
 lEZnaxvL/IN7iLCC+96rwaui5eZhd7qNXxjlCihiO9Lla59BBmsEbKJidUcd+2VuITPf7XRaGky
 yUqqfrMC0hAeX8y4+vpY3F6rDxTDphb43ybWnTAGJDWOKIbMk/RkvVsElT14U2D58b/MI12nO0D
 qZhlwWm0kz/kTFCN6bWFBZ9pW5y6geejj62Og==
X-Received: by 2002:a05:6808:c29c:b0:43d:365f:be86 with SMTP id
 5614622812f47-45f34cb3f37mr149121b6e.33.1769707137786; 
 Thu, 29 Jan 2026 09:18:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm3413822b6e.5.2026.01.29.09.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:18:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260121-configs-mtk-mt8365-mmc-v1-1-abcbac0492aa@baylibre.com>
References: <20260121-configs-mtk-mt8365-mmc-v1-1-abcbac0492aa@baylibre.com>
Subject: Re: [PATCH] configs: mt8365_evk: enable mmc command
Message-Id: <176970713701.2054445.2908200781811194202.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 11:18:57 -0600
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

On Wed, 21 Jan 2026 16:46:05 -0600, David Lechner wrote:

> Enable the MMC command on the MediaTek MT8365 EVK. This is useful since
> the primary boot device is an eMMC.
> 
> A few partition commands are also enabled since the mmc command alone
> is not enough to read all partitions on the eMMC.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: mt8365_evk: enable mmc command
      commit: c287c6900aae6bca7730fa2de5fcfd58c9cd3b03
-- 
Tom


