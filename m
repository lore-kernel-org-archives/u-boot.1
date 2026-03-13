Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDB1107BCEA
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4F0843FB;
	Sat, 14 Mar 2026 00:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DqRhyX8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364B084324; Sat, 14 Mar 2026 00:39:58 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C5284376
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7653db148so1976970a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773445194; x=1774049994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G41uQ7ErlOvxyCJueM6Ah49FRrscruwUK3R7PFZJ7xY=;
 b=DqRhyX8qQX1kMpbFmTaA83ExvDwAS9IumD/yPyi5hxlDP9cL79vzUjJcTD5FC7Gxxj
 bYD6yefXgQK4WDiVFZX6oJwOdWN60AN+S13uEWBkrNysCBPMDOYpiM0Oj32DkKm7o1MH
 OwCKLleq6Uy8v8PSk3DQGYiKUItsKdlBqSk1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773445194; x=1774049994;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G41uQ7ErlOvxyCJueM6Ah49FRrscruwUK3R7PFZJ7xY=;
 b=NfIYGu94UrT77H/vAu+lg/Hm8EW5hphpdFCcsIEVlkwPUdD2K02W8IHRbHcEVLfC3T
 Lwi969KflhTjgZH8C1XkfIrQoSM3uoCF3yNGJIBo0FZEc8ohI/8NqpMJjM4WBE9cXw/m
 /bhZheYcJfFb5dFKpmBf+Du3eweZdc0g4DW/9lGBSJ79WsXBlqASCzjEUBWqcqGrn4Sk
 VagnwHwaKtCm+6ZGf57Ypnx+btj2YgXLC4RhgN/QTE9Z2/BX3WF3jZssp1mp5RzefONc
 mqFlBFjtKdJX/s3PNDvlgeIpFG/rTvJRLuxP8pKS54TwB0CZ+qEYgYCGw9ycqVsBOh5e
 vxdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMO5RfzOF8QpXuYvQAQc/bWZ5Ivuk7wTY56nNxfzVw17tmVQy2cd+eSiwtZqAhKYP0yMAnk8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyECsXdLltiUDkO2xDwUZRSnmW7m+L473Sa4u3X964PENeBTtdf
 /E+eYzbEbKHURClnrl2k49usajr4heG8rAz8lz2vdzhXrPw1KMVJYauj9J/hRe14vkRh6jK253O
 eMdb9Ox4=
X-Gm-Gg: ATEYQzydph1k2Z6q9yG8uzKdn5135k2xG/18tEhbS8EDlJeXsw5k4jHQqGX+4MABp2n
 kM35nTjyraGnnTRmvl+tB4OQS0pvNFKpIEiN7TpLddpHChEj52wU3szhe6htv4rkgy4s9uTX1fH
 CeSaA/pDpx5I8QXNZdi6t00iSvF2iF6usK8lC3WnpD+jIarJ6XvzrzKZOasgh2UrPKOrsZ53+XX
 X+InwLi4y8T4E5UA+iJWr/uEcQbbCpvtuwFQ/JrtPVkJhp5kLGDFed1JvaUWKFAhFzaInoExw7t
 FZ87sPmmfEn0Qdv7QWJRVUmJvZHqImSl+D8kAbF8N1bs8/Ds+n1opwd0xX2rb9pBSfkWj8DK+ga
 w2hZb0yGQyS4T9OAVWZiB+HGijxOMOciQdN8InI5uaRK5Qb7Zc0yst3VO16ep/J6vmJmI62XGPD
 rSx+mwUtzqK0XGUctLrDrFw7Kkd0bbxWJJLt2u+yocPz5u16i6HAnfWGXJjMyaXGUKiJBfgjZxE
 l07dbUYiBy4J9gadQYFTEmwLr25wxrsLId8twMSyxLJcNk=
X-Received: by 2002:a05:6830:f96:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7d782511758mr3505928a34.17.1773445194260; 
 Fri, 13 Mar 2026 16:39:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec4c8bsm8096892a34.25.2026.03.13.16.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 16:39:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
In-Reply-To: <20260309210234.521070-1-jonas@kwiboo.se>
References: <20260309210234.521070-1-jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: rk3568: Include all addressable DRAM in
 memory map
Message-Id: <177344519289.1178192.5893817252414596602.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 17:39:52 -0600
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

On Mon, 09 Mar 2026 21:02:32 +0000, Jonas Karlman wrote:

> Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
> the initial 32-bit 0-4 GiB addressable range in its memory map,
> something that matches gd->ram_top and current expected memory available
> for use in U-Boot.
> 
> The vendor DRAM init blobs add following ddr_mem rk atags [1]:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rockchip: rk3568: Include all addressable DRAM in memory map
      commit: fab3b667b4128fae2d94752bb03088f84dafcf89
-- 
Tom


