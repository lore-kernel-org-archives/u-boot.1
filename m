Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ECE1061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE6884090;
	Tue, 31 Mar 2026 01:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RMvTwg5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565CB8352B; Tue, 31 Mar 2026 01:00:23 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69D384010
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46a9ae3f857so977657b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911611; x=1775516411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ez8lDKm3sISn6+Km2kHkGS+j7jfvqSl6aYWxqFS2iws=;
 b=RMvTwg5gZYBEt7okHQz28v2cZu7qBmPHPbhAMo/xm/OWqJEWMhZneVYkuiGNW4kE24
 unmSmaq9OWcJ/QcXUxGcISSzusVaxGLQJ7wkb+k0IhxH436kh1nMdT1sFvPitT4RqSwQ
 214o85CsW8FBgSgHnKDwBQMd2yQkCdIMCIHUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911611; x=1775516411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ez8lDKm3sISn6+Km2kHkGS+j7jfvqSl6aYWxqFS2iws=;
 b=YMvF4bEKWbhitCbDugmu93A0CiWLXCXzmyVZdkiEBzj0jRPkX2OeOHn5XWftyWy836
 fISwt3FG6GEWsmHwfWGe9mUNaMwdqBLF7Fz3xxeV1KRQElDIoy+s0yqzoO3XcNOkIZOC
 8RCZDAq0e95ywtoTeR/cgJlrd5PUOl1lcSrZQhUU+tIJbN79/P7daD8LWgoA0tUHV3cv
 NkfbFglTvV6hcsA9KvgHtzlYxhm7VWXcIBIYZaazU5wUmONFgBbjo6Djl9N2g09pxoFF
 BD1TEI2HSonMssc9kHMKtuOflQmbqVdC/zuFLziDg5jEGkbM5AceZlFhu8dWtfI8V0nu
 iMpA==
X-Gm-Message-State: AOJu0Yw9ON/JLV5+VZUK+9RR5HMnSGe4B8d1uYS5ZDNGr8YEDbXOlrUP
 eEY+1EJpURvpntbvMoTdprv7p6Qz1BqwynBWEkD/kt6BG4sR9XcguCciicT4Kq+unrK0owfOfxU
 C5oh1pAE=
X-Gm-Gg: ATEYQzwLH21U1EwZagvcQ+JGjtFceYu9BRRd6A6h0R+Jir11UlO4UzDsjF5v7eGcr1W
 efN8DDjw0cs3kfAT+NeAQmTbYJuaD6/d3qPwYoWVJNS3ATB0zORtiKx/oNhs5YdGO/bTfYnepqb
 MIoYlk9JWRexsKICOKuMyvG395qhvNikP5oP2tNjauh3F6eAfTJhM7L1Lqb12f/NU6N0nUH3S6+
 gdk+oU3QmcpWWUdSl8sUgliWBNSjACbpmz9TaYKe6hqIEmeHBnx7nwK+7cBIoA0nhCMXtZH+4q+
 S0jkZN3gceLqsBf+T3iLRF96CfHmZHk+rQ4M8pBqmMvB3zrYooLUJGMo6FO1iZD3T9X7UGhpO+V
 qgbkNPowMBlEzow5TOYC0sMaH1oF6/Cj/PAYnwKP7g5X99wRAuHY+Nc4vMmtBa90F28GqhCislh
 K14vsybRhEQG//9WEQmtxFBdAn7+LQBFRD0mw4i6Zv025HeEjzDDWtx92KEmpxKusNhAkiZHwBt
 9GFeiFSdcF6sC+VRbPJjkdVFJAxZPOSVRzNAeJ+E420nUA=
X-Received: by 2002:a05:6808:6b98:b0:460:f435:2aa1 with SMTP id
 5614622812f47-46a8a5dfcf4mr6219318b6e.46.1774911611311; 
 Mon, 30 Mar 2026 16:00:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012428.4162476-1-trini@konsulko.com>
References: <20260317012428.4162476-1-trini@konsulko.com>
Subject: Re: [PATCH] boot: Update tests around network symbols in
 BOOT_DEFAULTS_CMDS
Message-Id: <177491161069.1028292.17793447288988542807.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:10 -0600
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

On Mon, 16 Mar 2026 19:24:28 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issues around a number of
> symbols in BOOT_DEFAULTS_CMDS. Due to the nature of how we currently
> handle other networking related command options, we need to be testing
> for "!NO_NET" (which is the symbol for no networking stack) or "NET ||
> NET_LWIP" rather than CMD_NET alone. For consistency and clarity here
> use "CMD_NET && !NO_NET" here.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] boot: Update tests around network symbols in BOOT_DEFAULTS_CMDS
      commit: f1e978fd54d934260c58be85470a4a1f382f6f44
-- 
Tom


