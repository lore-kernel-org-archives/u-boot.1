Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB529C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 16:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1239087F5C;
	Sat, 11 May 2024 18:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RITXWWws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6702787F6F; Sat, 11 May 2024 18:23:50 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416C487D43
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 18:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5aa28cde736so1818616eaf.1
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715444627; x=1716049427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1c0ytrtMf+G6hA3d6y4ZJlofiSAddoCaV0kDAvHqc1I=;
 b=RITXWWwsVcP0ehsMIG326Wp3F1zCDizKXr9aQxNkD42A8iq/DK3i1bbtI0Ss766+dn
 tvi1jgz7YG1tq7fp1yO0ItYzVahM6TtdXy5xOz+U8lY0zF3NRghnnIDPmRfIE8vY1d2n
 yIoMpN9Q6+vm9lrY21xT6f3169bvert5Ko7GH/YbQrYQNt3iOIilk4yM131fzKjFRiIS
 ckdCC3xSi+FC+I3RAH+NXhVAQ+BCORCsTd9Kcrx3kbeDlwyOpxfGzTXh4qDunJucMC3T
 RmINNnzM2evjhqzo2Qh/05/LxLr1RS1bv5I9lTa5lLyx0fdX3xC3vMP2hBX7fvM5PbfQ
 mbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715444627; x=1716049427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1c0ytrtMf+G6hA3d6y4ZJlofiSAddoCaV0kDAvHqc1I=;
 b=Hy35QcM4yRkBNmjfn++oWjfBt+iDZ9GqctvAz8L6geeYXu5q2T8fHXuYDmWaRTuVLJ
 8DUeps4z2XjPXvL1tZ8vj77AqSO57jfgHsujqZpxyMqaFbueHY3JLme9XRKIJzGQDVI2
 W3Ad/+wl9cgS2w7/k1G2iGAtTyjgLanGrEpDlSzJeBJtQeO4v25s8tMp2XT0JNY75PXF
 ey5vu8RTsZYp+eXrN1TdNnIohQWwTfRPK6AacVIkWPS45VnPDmFk/xijzXoVhaQnmeO0
 cQI4UCElGYJvaWKKSxxqRD+s7kwemq050oQdsiuz9OFhGFhEhz1YFCfOo+9ZiMkYA+MF
 l89Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkwCiyOfrECP1oC2Hslp/EZu6hGrZPzQHHcQaUdY9xh4PDhKKOwF0byW/yGfo2EDagZ5earAT8B6ObszbCQ85SmyQrpA==
X-Gm-Message-State: AOJu0YwRe2jntL19NIYxQq9deK39wIu38/T1REC6fFTqThUv6lCGl2ne
 ZWV/lH4nOmLati4ha9z0fDVKqEtYNV3+w5kw7TJWAI+wGGNlYlKCNpM8e5SyfGVgQdOv31CLJIU
 jFy9zXiB82ElSOtBdBmuzqOe6nQw=
X-Google-Smtp-Source: AGHT+IGYgYNq1QJ5Y0x+cw0Cc+A8WU581rmS/aK62HmKQWEaSoT1mFpbnuxe4LOAZokRDDcF6Pe1W9FLfGni/AGAUMI=
X-Received: by 2002:a4a:5141:0:b0:5aa:396b:6537 with SMTP id
 006d021491bc7-5b281a1b4a0mr6276173eaf.7.1715444626990; Sat, 11 May 2024
 09:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240510044347.5303-1-linux.amoon@gmail.com>
 <63dc4af7-038b-492e-bf9f-08608be26330@rock-chips.com>
In-Reply-To: <63dc4af7-038b-492e-bf9f-08608be26330@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 11 May 2024 21:53:32 +0530
Message-ID: <CANAwSgS_tZVQQH6DyTXr_7QZ89hXFLCXUBootdFeWeGmiYPT6A@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jagan Teki <jagan@edgeble.ai>, 
 Tim Lunn <tim@feathertop.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kever,

On Sat, 11 May 2024 at 12:09, Kever Yang <kever.yang@rock-chips.com> wrote:
>
>
> On 2024/5/10 12:43, Anand Moon wrote:
> > Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
> >
> > Following targets is migrated to use OF_UPSTREAM:
> >
> > - rv1126-edgeble-neu2 : Board is an industrial form factor
> >                          IO board.
> > - sonoff-ihost-rv1126 : Gateway device designed to provide a
> >                          Smart Home Hub.
> >
> > Cc: Tim Lunn <tim@feathertop.org>
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>
It looks like I have used the my personal Signed-off-by
send v3 with correct Signed-off-by with edegeble.ai id.
can you apply the modified patch?

> Thanks,
> - Kever

Thanks
-Anand
