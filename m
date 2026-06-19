Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7822BCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7ABA84874;
	Sat, 20 Jun 2026 01:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="snNtvc4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18515849AA; Sat, 20 Jun 2026 00:09:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D4D848EB
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 00:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so1666972f8f.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781906953; x=1782511753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Tf+oqHNcvVQA8SVZRJnT/KZlDw1EdrCbD6z3+xMpdY=;
 b=snNtvc4KWrz5qidfZ79pPLjYLuH2Ij2l1NQz9csOQnBlTzGmhvLFBnKwsJDIGqg/m7
 wgwQsXNbYSBYXCFfG7e9bQMmUwH8Ox+MEV4bAwz0GDnNYVv1WbJzDosDw0+ZNQZGcUNx
 FBP6dsc95dbK8HH+bOQVM3Rrye0X2T7AV5xt9MKtZoP7xE2fIf9hwlmWeVfLMvbDysXc
 dQILdDJYVvxUq9UuDnSX9ldMr+ET3YjSX3H3ZjWRvai+3Ll1jiQfyoKcJ7u4hPqtpbCW
 hbXw7vj0jIbvMMQ4uWws2OwlwD85B+hJhXLtJyUwsmP5b7i83Afv5LjSs31stVisCCZA
 P/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781906953; x=1782511753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Tf+oqHNcvVQA8SVZRJnT/KZlDw1EdrCbD6z3+xMpdY=;
 b=YFAV4oNvvc97+iMNOZxAJcx7ATXPQecdVuDhGcEwK55RPbcTvGHEx+FlqSh+G9s7xo
 d/1AnIz2gIXstvT8g2rHa6FW48HpovbxZwXFesrLsu1PAMqxNXFMbQh8JGoABwMhDqz1
 Oa11F4d1a501jVZWnaChgV2IS5ig80vp7KammQriLMPDHzdw11DWYDQN5jVKUvG077KR
 BngPrSPTmGTGLDH6hracYCctiOQsLFbkmhJW0JiPwqbSlSLhz9eoywNahv5WFNY/dg0R
 GcJxIYq/BDvIhBpcZAUNxQHfK0kXhNmlChTCDLHE0KI76f1gWlo3xg62VpMduX5OUvkk
 YBsA==
X-Gm-Message-State: AOJu0YzGzQeXl8BgD57W4DJrCBPiJNjX+9lAJdrNOTpHDogIxIVZ1qQF
 Rxky5SuLu8/CY01bz787Gafs7HiGsCCBWv1+ZoWFIamCfYXu4LsKLBRDer5r74qV
X-Gm-Gg: AfdE7clS5ndtkxgzpRGYVg2tSCv5YVjCLTo6JDpqi1UPOa9YSH8UC4LKCu3KqF60g2P
 2y7Y+qYgpsNryCYsvHoHvtAz2XdFcItax/Y+yoR0vR2SAnOdWzs3M3CsRH9xUyYQYQr6b3hSyAF
 nkJu40kQgh1rB9T/1CFcnh4xQRxmT87yClQEIG1mil6kzQvoXxLpxfmBC9TE5JYM4Y1sk/4HQYP
 3Zdbd1FzHxE4YP7D4RpVDL+Dhtd55F8CsMC5uZEEU9Qx7fVl8Luge5J99PHT7i2T7ahtxwsbDXb
 /qov4AuoTijQ2G9vOEUbkgun/0l9Xu1HM2eABwrWqKLaLLXLjgSQr1+2fcDH8/CbtrINLPYvc0l
 ErerYJFXxSSpc0ie8G/9jdo+5m31d5SuSfWizoZRSgoXF4whvIbpNCuk8IqKqmyQ7ybAErTyFkr
 IbVOOaf457Jkzy3I0f6Opp2XQViVXkp7H/Q8V0viV8+KP0R4iEgryAiJ6IjGW4tfA=
X-Received: by 2002:a5d:6652:0:b0:460:e00:121c with SMTP id
 ffacd0b85a97d-465097867c3mr7619455f8f.28.1781906953337; 
 Fri, 19 Jun 2026 15:09:13 -0700 (PDT)
Received: from turbine.fritz.box (p578499fa.dip0.t-ipconnect.de.
 [87.132.153.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4d9csm2176698f8f.4.2026.06.19.15.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:09:12 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH 0/2] rockchip: odroid-m1s/rk3566 watchdog support
Date: Sat, 20 Jun 2026 00:08:18 +0200
Message-ID: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 01:29:08 +0200
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

I experimented with the Synopsys DesignWare watchdog on an Odroid-M1S
(RK3566). On current master, the watchdog is present in device-tree.
After activating the relevant options in .config, U-Boot tried probing
it but failed, aborting at a failing clk_enable(). Current next branch
already has a patch for that in the driver (d62801d09441) and with that
wdt query and servicing works.

However, a timeout or wdt expire causes a hung SoC. There are two
possible "global resets" the watchdog may trigger, set in the CRU
registers, as per the TRM. Default is the "second" reset.

Unfortunately, the TRM is rather tight-lipped about what each one really
does. Per experimentation: Setting it to the "first" global reset fixes
the hang and makes the watchdog work as expected in U-Boot. This is the
first patch. As the PX30 does the same thing in its arch_cpu_init(), I
believe this to be the way to go but I am curious to hear if anybody has
more technical insight on this.

Second patch adds watchdog support (per wdt command) to the Odroid-M1S
defconfig, which was my original goal. I didn't enable AUTOSTART and
cyclic servicing to not break any existing systems. However, I tested
both and they too work as expected with the reset fix.

Andreas Zdziarstek (2):
  rockchip: rk3568: make the WDT trigger a first global reset
  rockchip: odroid-m1s: enable watchdog support

 arch/arm/mach-rockchip/rk3568/rk3568.c | 8 ++++++++
 configs/odroid-m1s-rk3566_defconfig    | 5 +++++
 2 files changed, 13 insertions(+)


base-commit: 298d44464dc63a4f3f5489150acd7958f359f9bd
-- 
2.53.0

