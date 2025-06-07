Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC33C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697BD82B3D;
	Sat,  7 Jun 2025 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WMMGRrrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1B982B0F; Sat,  7 Jun 2025 16:09:15 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A16480E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7387f21daadso1410344a34.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305352; x=1749910152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nca9NYeyCxzD3aJwtsYXAKEwlTb42I53CwcBbg1xrx8=;
 b=WMMGRrrlNKzCtmWMfD2vJknp1ITiAJF6IOkPCatPa0cJy2AfkZsL0tf5b+NZWmicwW
 bratVGp/69080yP7MrLoNmltsHiWyAjA1OvwDTFTsMvukCB+qbvt+aapK9/jhKXM52wg
 7WqjZmLthNLlTfFqL3ndwKRtO2Twhc8pe9IJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305352; x=1749910152;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nca9NYeyCxzD3aJwtsYXAKEwlTb42I53CwcBbg1xrx8=;
 b=HyKa3FN41Gt+8Mx3u2C1IdpSqEYdTrhUOEgP2kP40lzN/xvks5ihcLptzu8GfDtSvd
 sGxz+jPDDqdCXtZvSVEEQ01MWSIwNy+FpsUhKn5U0+Gb9dAGUlsgLNCcXXygswTLwICA
 +iNrYb7prHkwc+xQ9e0Rd6Fut9TbVUyJJ+En1FfJGJjkQcsQUL2wxFxzFni/DNF/OlnM
 tiQbfjEy8abKRSzrSoW+3Ng2nU1Rtcij5Gf41ZE5nCXmM2wIl69ZiS6FpNCoT8PqiiN0
 8RD2RrZBzXJoHY+LZgTbKCbi60h0MCgTkZUdnM5BIQJG6Nt8JiVqRvomeGPDgqZ/GBx/
 k0zA==
X-Gm-Message-State: AOJu0YxjfP0esqWsSyzvlvQferkDzQu61IBxbCvRVtU8H3enEn6p4Vev
 x0vpM6XFnsZzUUWX5yZf0A7rh+eByVHjCZwszJa+FBT+GFZ7OGk8rdjMgICkh/ykp4iONARx/hN
 CYuQ3Mx8=
X-Gm-Gg: ASbGncv4XzTq0g5tvlc31QUu+wav5yJ7+CJXk7ZXji3z8Th0CfAV8oKVKThn9sCEl37
 M14CFe1YDYz6lIUrcFpVJxA5uxsszmVaO59yfOjU9nvVZpSt9VRL4wxlJR2IYVh6NnHDAY5BzRq
 icG/Nu+d+ZmKZ0OXqMutXYz9bRbuUcbzEVKIPvGwHnicUWgIObAD2vYwGQzU7UoleSI8V+5ZaJ/
 0K/0bSgiQrYaPKaceevyLXIAxLVTQ9xvIOyX0ZyX8H2CqNRURWss56b8mFBGbDqkT0+6nSTPbYE
 g6ngEP+vrt4SOvdGsaXcquRI9832E3N6qD6A1W5NpboYiqpsVRMpu2N6l/Vd67/xc//CMKG91D7
 PGN5A/vFzGvE=
X-Google-Smtp-Source: AGHT+IGIxB0rfKNsyr3twE5wfwiCk7RK3MHlTcVOypOmqV+e7cOcLwKKFFdKp4LDDsZQ97W8yfVxDQ==
X-Received: by 2002:a05:6870:7811:b0:2d4:d9d6:c8dc with SMTP id
 586e51a60fabf-2ea2442d64bmr1575662fac.9.1749305352055; 
 Sat, 07 Jun 2025 07:09:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073407b1sm954067fac.38.2025.06.07.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:09:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250528000302.3003129-1-trini@konsulko.com>
References: <20250528000302.3003129-1-trini@konsulko.com>
Subject: Re: [PATCH] include/dt-bindings/reset: Remove local version of
 bcm6318-reset.h
Message-Id: <174930535061.3446816.6328687960525550957.b4-ty@konsulko.com>
Date: Sat, 07 Jun 2025 08:09:10 -0600
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

On Tue, 27 May 2025 18:03:01 -0600, Tom Rini wrote:

> Aside from SPDX tags, the only difference between our version of this
> header and upstream is that BCM6318_RST_HOSTMIPS was defined to 11 (the
> same as BCM6318_RST_PHYMIPS) and is now defined to 12.
> 
> 

Applied to u-boot/next, thanks!

[1/1] include/dt-bindings/reset: Remove local version of bcm6318-reset.h
      commit: c8612ed98eb6b459e5a5174cdb980a83763544b8
-- 
Tom


