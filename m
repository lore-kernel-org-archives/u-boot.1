Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C4ECD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE255841C2;
	Thu, 11 Jun 2026 15:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bhdiM/uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A46846A7; Thu, 11 Jun 2026 15:48:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E8F83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6b571750bso5974116a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781185705; x=1781790505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W04xTMUrFSS5Xk/G6MqufJF7whfBvWA6uj9u8MmxH6k=;
 b=bhdiM/uvGrpTWDyHIi0lUapxNUaheWS56g8gtaKGG75udKis/Fs9W2vILHAfpAC8Zn
 cwOhB0/zRaWe3FspVZNuBlk9pEQ+Y1A4oxDX7sOLnopwNQIH45sUYum7FcxT70daImcA
 lgC1iNOn/AVZA0xZ6b06Frbb1MQeUeGtTC7JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185705; x=1781790505;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W04xTMUrFSS5Xk/G6MqufJF7whfBvWA6uj9u8MmxH6k=;
 b=Rs/6SZy+7yECqp8JWNAeBFZBSwNbXKQhzlSuV0IxgIyxjs3qz0uZdg1QGaiTU/F81W
 9ruyDXmGst/ByT5Iy1aSoApZMH0zjJCpt6YFvHLlSpcL5T/81iKmizJdih9MDZoy5ywM
 iPZjNKVjmwoA104t4y7QYSgWX/X7gvYxj4lXHef6KH94dkdAooQ1Q48+qJCwOkUYIhvo
 +so6WOrtpwXOblcZ7GR3V1AF9eI519b6+rlmmknvFHywmbSNZhMboB5SJiYVt72aEYzj
 6+wHr2cRADEf5kRckUIOlgEaVA/U9ANlOC6/50uXLQr4uLJL34HqOnuk5Y2J/g0Eczy9
 6lQw==
X-Gm-Message-State: AOJu0Ywe9j2p/9Avb5TTGTX6ldOfn0vKxc2zm69rhW6/PZKk0J1oMwDK
 IYg1n0KTlC8E0RtVzTnRXu3DqmVMOhTfetWGtzrhzPPTCWyKSm3AkaAWG5OyfC0nIdk=
X-Gm-Gg: Acq92OHUXSfFtLCUHUilWvEgvgB3zvQqcl92Y2rxOE93Z197Ymiok2H+dNJxS31bJSj
 BBXqYTQ+wYp9kSKCwOG56DfvEE+hJM6AX1Bk44MoZ5b+h7ckiFXUbqGf1EL+vu0g4EANSL3uTug
 SslwFR9jK+G3s6xsHFCOdUyDXqxXC1i92gYaE+Llt2NkW4oJSrCUUyzdiKkF4plwIE/aVxDAqbN
 cnAm218TEYSiKrMW8hkk1tNI71En3DB2bt3lKv60lTHEMXpv/wfl++1xgtYkC9C0/cIC0qe8G7M
 h4G4q97C+5V2hPw23GXR7/ylmXCSUYeGbwmPn844wUcyG4ajOkqrMsJTgRYCVNx0/G/5Cbt6RVE
 SxnwVKb7xp1HJ2qWHe3Ob+5oz5LNo7apHOPW+O/IFzz5VAyGEP2X+MnE1UIgnexvw6sUsM4cGCc
 wmhiBfG1vrtgidFxiJfnStl9qBqzbvHolP2F8jE2roLwBlBktNTKh8hX/4OYgBe4K6Z0IttYipb
 r+c8UOFOLfp+oX8htRV9RMMltraTd61pFOIP4F39SFvs2OGgjC+swQDPw==
X-Received: by 2002:a05:6830:6f8d:b0:7e6:d0ad:5254 with SMTP id
 46e09a7af769-7e7733d5521mr2272222a34.8.1781185704876; 
 Thu, 11 Jun 2026 06:48:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774988094sm1368249a34.1.2026.06.11.06.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:48:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260526083729.142296-1-weijie.gao@mediatek.com>
References: <20260526083729.142296-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH v2] bootmenu: fix incorrect menu quitting logic
Message-Id: <178118570419.472730.16560512454155775238.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:48:24 -0600
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

On Tue, 26 May 2026 16:37:29 +0800, Weijie Gao wrote:

> The last entry of bootmenu is always set for exiting the menu, and its
> command is set to an empty string.
> 
> When user selects to quit the menu, bootmenu will try to run this empty
> command. However run_command() with empty cmd string will return failure,
> and the return value will be overridden to BOOTMENU_RET_FAIL, not the
> expected BOOTMENU_RET_QUIT.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootmenu: fix incorrect menu quitting logic
      commit: 1cc0442ede5444b76356bcba9aaeb11750e97b65
-- 
Tom


