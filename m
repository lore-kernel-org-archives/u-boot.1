Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB831D46C15
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 23:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6505483B72;
	Thu, 29 Jan 2026 00:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="omeVpD48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1BB83BE1; Thu, 29 Jan 2026 00:05:31 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C916E83AAD
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7cfd6f321b5so189310a34.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769641528; x=1770246328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SPD+Tm9fdv6aw7uvtkuDZKWvgbKVlR7oDZwidAQ9xR4=;
 b=omeVpD48tkCzhYkNbncWMMrsPoVtuX3B9b0Z/gKX5kvN8USKzu7iqbpHfQCQIK3gmk
 zqeJVBN+7rEvpJabyKs097RWbgSs+PhVJYPG35uqR8mUFowuGUuaYiZ7mL94lbiIeG9E
 BFESglt3T/LuFvUE3YP43Br7b32o3bTSL26SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769641528; x=1770246328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SPD+Tm9fdv6aw7uvtkuDZKWvgbKVlR7oDZwidAQ9xR4=;
 b=ltVvUYvLTu6sVv4A05Bhu8TPV7kWxYh+eBsoDbgwT+7xzbU8Nk8h0eqIxbl8jG9RXM
 UNpVq3AFLkzoD80EEeu+fZSrxG7/ffVWh9zhYQ2oxvH+96sPfJ0tzPDHIP3/oU5okPvl
 b+/uO27HFQ5OGEM5PcVOdf4QgtLq04XVDTRf4KoYbiD20DEH9CxCM3oW42I3L2nULMRA
 /FhVAeilHcvGuN7GGxKEqYMnavzfMj6/xdkO4K8l9+gUI6n+06WHhXq0bDsv8fKBLhW+
 zOhk/dgLej9D3nvPJXPL+uyKTM/TNBDmr6b3VVsiE1QSoeZ6TtbWKF1uWj/YWEBKxh8k
 W/vA==
X-Gm-Message-State: AOJu0Ywuy1vzFBzkI2iivuW3Pyb7sUA8AvigIUSOPbV+SBn0jQTINahr
 JrpIdMIzCaUeWLIp7qYqOahRBei4g5NhvPNNXvjqO37jTW8k3x1riidI3M0luFoZIuDBU91ePy/
 DXo5N8dc=
X-Gm-Gg: AZuq6aIavxZOx1nL/Co/chP3T4pKVk83UCkBERNtQGrFAvQtP7c9wJ9GIna2JIF5vuL
 WuKrKYe6vPUkqSOx5we2atWoVSsNFG0I4lUWrUY1BJ/8M5Ies9ecDJBgJDuTUqB/lczx3skHYSQ
 XrT1pZnudoAP5dJb9SO1I8LiAs40eoqvgpoRau7jFXfwH6ew1O3ioReD3Jj4AvTIDyUwXMGpsTH
 yTRuXqhS07jA5CpovQPlIARnbEm+T2BDKtTJLr4vC7+KPJaeYmip7HBDQ5vjuFHvQMZI9ZEi51t
 /1vc5tsrfiQ4t6xx7EAWs7lRWVAdY1BIawZxMjTyDEBsVcDgVqKSvrkqAvYips8acmJt2qmEMP+
 2ved/gYEUEEpE03xP9A4FZauEsmNuMGPs6W7eCkPfhKHXxA0sefUB9M+0IbtOcMigzI1Nyuzfpc
 6JoD5BxKFyExq9aIY04Mx+weW9XzLDnFmmUqFBaxu4M5jH9wRHhmdZjwaO5hn8TuOQosP1J+n1D
 N6MBi71Z1hj78Pvre1Yh6ZAHkuk8jBxq3YSoQ==
X-Received: by 2002:a05:6830:6614:b0:7cf:cc64:7636 with SMTP id
 46e09a7af769-7d1850f751dmr3896693a34.29.1769641528126; 
 Wed, 28 Jan 2026 15:05:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c82e494sm2598076a34.28.2026.01.28.15.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 15:05:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Vishal Mahaveer <vishalm@ti.com>
In-Reply-To: <20260121195340.3041549-1-vishalm@ti.com>
References: <20260121195340.3041549-1-vishalm@ti.com>
Subject: Re: [PATCH v3 0/4] board: ti: Add 32k crystal initialization
Message-Id: <176964152741.1796592.10357694633976440223.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 17:05:27 -0600
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

On Wed, 21 Jan 2026 13:53:36 -0600, Vishal Mahaveer wrote:

> Add 32k crystal initialization support for am62x, am62ax and am62px TI boards.
> 
> Changes for v3:
> - Rebase and fixed am62d build failure
> 
> Changes for v2:
> - Created a common API which can be called from individual board files
> - Squashed defconfig and board file changes into single commits
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] board: ti: common: Add function for initialization of 32k crystal
      commit: c927eefd969d3714d55ac56e7a2ba34f923b9c1e
[2/4] board: ti: am62x: Enable 32k crystal on the board
      commit: d7550d01050c72edc548829dcc4d9a7494bf124b
[3/4] board: ti: am62ax/am62dx: Enable 32k crystal on the board
      commit: b259574e471dd632c31f7a8caea29102a3219fab
[4/4] board: ti: am62px: Enable 32k crystal on the board
      commit: de6b11e27b3a127d6e500e970f6ee7a70d7ab4bd
-- 
Tom


