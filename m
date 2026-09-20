Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F455C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 293FC810D0;
	Sun, 20 Sep 2026 15:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmqwaaoWBLat; Sun, 20 Sep 2026 15:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BBF180E21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919374;
	b=T7+azmMoz/xYd2DbUpKWw+wXyGxgiV/IvB1Q9zQAqEDfZ728n7jcV7FcVQyAA4VL8jXE
	 pUYRs5F0E8+hKedO44ptgKHwP8P41KjBxHzhVId6Lo94NRwr3jXZ3rpvRFsmGtqLTRpd4
	 vjovJDGMXo6mQvimaUD5VTX4JgsJv4UhffAeWGtGkDgOEGYsD1kYOHjlZLJ3ZfO2w0k0G
	 eFUb/gZH3u/zx2jteAwJRNIsd547xhtCCge1Hzop0hzsq64ZBKqECLUpI1sXuV32MrWTq
	 Ufh9oJUFSi9FvfHa1HkCWxr6vByPv0fhmbDYvVcei9j+E/BP3nCsnEyS2cLxBnGzuQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FkCr+6jnN4RYfv7vm0HajohfZMtkzx9SOnItfeNUdpQ=;
	b=cb8UBxrHIwmyepltio7amV0DxmjdcfLsBIEX5or6qGajuWH1O0GxWofJ0eC4rSnGNJ0S
	 uhw6rjLhRO/y3r91MUyX+E45vEOHuvNa2iCUjT69CO6h9/cd3NTip5xC2boxck4l5Fk+L
	 rBVMRpGhGwrhdkGMMcHgFsafAYLBzX5+TJwrKA8eyMMnhyQnnutliJp1LUWYhwPLR2rdt
	 M6kGtjHCuta1ioRdwzPV+6WYeQg1dyCfK6TRunHG0EdMfFcpa7lnyGmhKlJ3IFIP2QLO3
	 oXAv7vovl48Tb+uX27QEr/DJEZ3ymcKggX6xOjuL306FCuXbN00FKqYvLlVBKDIaHGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RVhFPJkl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919374;
	bh=FkCr+6jnN4RYfv7vm0HajohfZMtkzx9SOnItfeNUdpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXGQ39vtmLazSwOFdbRgbHQIDk1/L88aerpwMUkSznZ9p/Haj116vbKRQSRAyRZMj
	 8G/wA+dtuV3Bb1ZQG4URK3NEMs2IH22wpFKz7//x5UMmeLnNX0PgPW3NxJVZ72obHW
	 DkNNzC2Pu1h5EaHsNhueFwnXZZCgcqzsIKlwq8jpZ4ajxP+9oinDWcs1Rpxsilf0vP
	 dOp+qegVEk/AACd4eee1lIXu05A12pwQEkMzHj9VHmYFHwoGTi0w8ayG11p/OhM7Ry
	 MzIK0G7CSdAF4QIMAl6KqZ07/rHMJCeUcz2r/4gDb5h7MxBfN3J0K2FkjIwASSG5gq
	 jdK1UJMONk41A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BBF180E21;
	Sun, 20 Sep 2026 15:49:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C6BC392
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9999B80F19
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqyrO1XTOatz for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7717680F15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913787;
 b=HkAviJrCSLtQxb5BjRcWSR9Ov5aOFTwA9Mzoz19ZZfg3qygON0tXGcPC87g+it8Y1k/v
 /wFMpUGVHxhXiiYFhawSeFXB5Xj/rzJgA+1tsdCY/PNB7XdR1cXvK2kcT1ViSubXeISdH
 bO8PbBUvrcYD6pGWxqu9DjARhv33tXir69gbzndP/GAIujqg6VOGRU99j+7giQQUC55yz
 5fR7+jDEEt0IxBUF0mUEYSsp7xA1aDUTf72tsjIUhVoVg4TLR6yX93JCj4J7NzTBI1X/i
 l+b/UaOBvtoEbQSNZmsBRa2VP+kq0FD4qW+jT6WgTTFIaiFUuVaVBHrv7NR5qE54cgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913787;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=FkCr+6jnN4RYfv7vm0HajohfZMtkzx9SOnItfeNUdpQ=;
 b=UZ27nhiGSaSAZcY1iiX844sFATtcIE/ghiGR0EC1pWqg4gv6kYLysoKQLymTDx73MTIx
 CKOL5jaRtQD96DOa4Hy3QMI/i0vcMBKb+aCRNFhzcGHi+HpfYW7zNhhM9j+aZ0ZaDT0/g
 cFKt6cSFuZNGCpQzNoDhM2PKXzsOvVVdrn+0OV9tg79GE6jr0puqbJQot9OgzoZNf1DJt
 9PbJx6T38SifWvb6WpWXPOQNXDbL0LwUsrZsK2mcU62opVIOIU7/fHNlNuB5esQKOUagS
 A+omXuhPbpE7TxLkSZkxlBFtsBRKNGe/WDfXiPlshQbWQuYn5g6ZrrPeLjcGnxrkXeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RVhFPJkl; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RVhFPJkl
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7717680F15
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:27 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so21418665e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913785; x=1790518585;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FkCr+6jnN4RYfv7vm0HajohfZMtkzx9SOnItfeNUdpQ=;
 b=RVhFPJkl3xkTI/Zd0e3P8Z5wHXX5fjjgchzFaFy3EB25M0/XIQ2x9IgHhUr8Ch/kjh
 /u7PcgsUvcN9FKy+Z5mTNqVANWtnUxgyVs1BXmmNHFbViFnZn+7xyQSnEcSNfbSxiefP
 96aXpYgpDbOD3BKDFn7QyhtUF0ITPahfe9IktZ0Mjc7mA39C3B0FnUS5BTZYYVNc1Ofs
 0Q2rlDc4+R/f9XW7nGB0uvikovUlxQVklUEi61NOSVqDv6OlmNMUFO/26otwSosC9kgl
 TNkiOYtb3dwcj38QWQyfUdbupyIrmq1v+vcX5mpWsUUOfGoEXLJLF93UuLBIgkY0afi8
 Y+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913785; x=1790518585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkCr+6jnN4RYfv7vm0HajohfZMtkzx9SOnItfeNUdpQ=;
 b=Z4xiStqdqeBBDjzKKseg3kg2tIm7fqr70j3QOGZpoFDMnVyMDJWEwI2lXXrGZ5x5sg
 l81Mg9ZZRMm9rV1PXztjEwsYQnMDwk5Q05BwKRwLsRczbs1Sl/b6exLqu7uYgSmKbC8w
 BjCCLc66KgkXbpA1XAQm3LIta8BJI5dxPSCAZS3P9qZjFlnhPHctW4EU6oCpETUZ2vbX
 6qMxaFTiT51KG9ASWEvawDTBmpJhdM5G47ofFwZ3OTkzUnMpPLKZ/eWDeoQOtk4a3XQL
 SHu9HIfFGZAsgWpl+gBe9uhO9ZOdx6N4tncPICpTzgvuBKf59I864xf+Xscq8xv1zmwM
 kq7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf3F/71RjixSahnLcBiWNm+dW4EZfYNltc2C6jFXBIlPdDkyJYfEKSGSe3sRyWG8syS5L5Qxg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k/AgIWj5/h5pd0vIp7kwjgm9X6ttmQ5k1zskAV8Woab2et3bi3
 hZklpAPOjB+lGgQIFHOI0mcZq12AhpJVOCQKCzQ00HV9bwRhI7wuJEKb
X-Gm-Gg: AYBFou2Rc8vtApXYssA+jVrZew+LVXV62W5WFp9iLia/Q1GPtYEeU7l5TE6bILvl2lr
 ud8c1Zn5dDx4J/LDZoOHir+fEan3tJqtW2wAwhVozdHKNkw8KiOZy0vMlXgtf+i2ZgiR3WdrwHt
 lIgC9D9tMYtqQdV0TAb+wHI+gVczokA9evXqsjefJnvAXATFjIgE9fHugqRZk7GbrcDLTLCtZfk
 UBX1461jtomy/2nbrc1b69Dx1C4TiXctBMRtuF4NxfGwjKb1zDTcyq9zAqKzl5Wctp5Or4prSJ5
 YmEFuy49OQCA5HkDlq81OLRj01rFfTECvkwjcTQeaw5o8Ixu/afqM9VaySWymA1aQ+itUasQfOe
 28JJCs11N88mRbYEL0fs4MiVn0+b6VKKK28m6acD+CytJ4RMKOQuLejGUR5uwDOrleeOSkB7h0w
 6VznswLzOYI4MXXuWQMQz8DMPoLvdtm41sZQa0aex223mq9AvLShBNghmxsU0jY7isATiOLOWJy
 P/NzOqDlg==
X-Received: by 2002:a05:600c:3b04:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49fc56aab52mr107166765e9.9.1789913784953; 
 Sun, 20 Sep 2026 07:16:24 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:24 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:49 +0200
Subject: [PATCH RFC 05/11] arm: rockchip: support DISPLAY_CPUINFO on all
 Rockchip SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-5-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Move rockchip_get_reset_cause() implementation to SoC-specific source
files, leaving a dummy weak common implementation in cpu-info.c file:
an effective common implementation is not feasible due SoC differences.
BTW the existing ones for RK3568 and RK3588 need to be fixed/improved
because their CRU_GLB_RST_ST registers differ from the one common to
RK3288 and RK3399 on which the implementation is based.

Moreover, now all the Rockchip SoC board configurations can select the
DISPLAY_CPUINFO config option and compile cpu-info.c successfully which
provides print_cpuinfo(). Previously, boards with SoC other than RK3288
RK3399 RK3568 and RK3588 could not have DISPLAY_CPUINFO selected.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c          | 44 ++----------------------------
 arch/arm/mach-rockchip/rk3288/clk_rk3288.c | 35 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3399/clk_rk3399.c | 35 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c | 35 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 35 ++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 2ec96a20c3d..b6e3d9ff964 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -10,49 +10,9 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
-#if defined(CONFIG_ROCKCHIP_RK3288)
-# include <asm/arch-rockchip/cru_rk3288.h>
-#elif defined(CONFIG_ROCKCHIP_RK3399)
-# include <asm/arch-rockchip/cru_rk3399.h>
-#elif defined(CONFIG_ROCKCHIP_RK3568)
-#include <asm/arch-rockchip/cru_rk3568.h>
-#elif defined(CONFIG_ROCKCHIP_RK3588)
-#include <asm/arch-rockchip/cru_rk3588.h>
-#endif
-
-/* CRU_GLB_RST_ST */
-enum {
-	GLB_POR_RST,
-	FST_GLB_RST_ST		= BIT(0),
-	SND_GLB_RST_ST		= BIT(1),
-	FST_GLB_TSADC_RST_ST	= BIT(2),
-	SND_GLB_TSADC_RST_ST	= BIT(3),
-	FST_GLB_WDT_RST_ST	= BIT(4),
-	SND_GLB_WDT_RST_ST	= BIT(5),
-};
-
-enum rockchip_rst_cause rockchip_get_reset_cause(void)
+__weak enum rockchip_rst_cause rockchip_get_reset_cause(void)
 {
-	struct rockchip_cru *cru = rockchip_get_cru();
-
-	if (IS_ERR(cru))
-		return RST_CAUSE_UNAVAILABLE;
-
-	switch (cru->glb_rst_st) {
-	case GLB_POR_RST:
-		return RST_CAUSE_POR;
-	case FST_GLB_RST_ST:
-	case SND_GLB_RST_ST:
-		return RST_CAUSE_REG;
-	case FST_GLB_TSADC_RST_ST:
-	case SND_GLB_TSADC_RST_ST:
-		return RST_CAUSE_THERMAL;
-	case FST_GLB_WDT_RST_ST:
-	case SND_GLB_WDT_RST_ST:
-		return RST_CAUSE_WDOG;
-	}
-
-	return RST_CAUSE_UNKNOWN;
+	return RST_CAUSE_UNAVAILABLE;
 }
 
 #if IS_ENABLED(CONFIG_DISPLAY_CPUINFO)
diff --git a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
index d725730f5bd..a245d865a0b 100644
--- a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
@@ -30,3 +30,38 @@ void *rockchip_get_cru(void)
 
 	return priv->cru;
 }
+
+/* CRU_GLB_RST_ST */
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
+enum rockchip_rst_cause rockchip_get_reset_cause(void)
+{
+	struct rockchip_cru *cru = rockchip_get_cru();
+
+	if (IS_ERR(cru))
+		return RST_CAUSE_UNAVAILABLE;
+
+	switch (cru->glb_rst_st) {
+	case GLB_POR_RST:
+		return RST_CAUSE_POR;
+	case FST_GLB_RST_ST:
+	case SND_GLB_RST_ST:
+		return RST_CAUSE_REG;
+	case FST_GLB_TSADC_RST_ST:
+	case SND_GLB_TSADC_RST_ST:
+		return RST_CAUSE_THERMAL;
+	case FST_GLB_WDT_RST_ST:
+	case SND_GLB_WDT_RST_ST:
+		return RST_CAUSE_WDOG;
+	}
+
+	return RST_CAUSE_UNKNOWN;
+}
diff --git a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
index 170071d243d..afd57b2e354 100644
--- a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
@@ -51,3 +51,38 @@ void *rockchip_get_pmucru(void)
 
 	return priv->pmucru;
 }
+
+/* CRU_GLB_RST_ST */
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
+enum rockchip_rst_cause rockchip_get_reset_cause(void)
+{
+	struct rockchip_cru *cru = rockchip_get_cru();
+
+	if (IS_ERR(cru))
+		return RST_CAUSE_UNAVAILABLE;
+
+	switch (cru->glb_rst_st) {
+	case GLB_POR_RST:
+		return RST_CAUSE_POR;
+	case FST_GLB_RST_ST:
+	case SND_GLB_RST_ST:
+		return RST_CAUSE_REG;
+	case FST_GLB_TSADC_RST_ST:
+	case SND_GLB_TSADC_RST_ST:
+		return RST_CAUSE_THERMAL;
+	case FST_GLB_WDT_RST_ST:
+	case SND_GLB_WDT_RST_ST:
+		return RST_CAUSE_WDOG;
+	}
+
+	return RST_CAUSE_UNKNOWN;
+}
diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
index 1c6b2ece602..e10bcef727d 100644
--- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
@@ -50,3 +50,38 @@ void *rockchip_get_pmucru(void)
 
 	return priv->pmucru;
 }
+
+/* CRU_GLB_RST_ST */
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
+enum rockchip_rst_cause rockchip_get_reset_cause(void)
+{
+	struct rockchip_cru *cru = rockchip_get_cru();
+
+	if (IS_ERR(cru))
+		return RST_CAUSE_UNAVAILABLE;
+
+	switch (cru->glb_rst_st) {
+	case GLB_POR_RST:
+		return RST_CAUSE_POR;
+	case FST_GLB_RST_ST:
+	case SND_GLB_RST_ST:
+		return RST_CAUSE_REG;
+	case FST_GLB_TSADC_RST_ST:
+	case SND_GLB_TSADC_RST_ST:
+		return RST_CAUSE_THERMAL;
+	case FST_GLB_WDT_RST_ST:
+	case SND_GLB_WDT_RST_ST:
+		return RST_CAUSE_WDOG;
+	}
+
+	return RST_CAUSE_UNKNOWN;
+}
diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
index 250ec423bd2..5698b16db58 100644
--- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
@@ -29,3 +29,38 @@ void *rockchip_get_cru(void)
 
 	return priv->cru;
 }
+
+/* CRU_GLB_RST_ST */
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
+enum rockchip_rst_cause rockchip_get_reset_cause(void)
+{
+	struct rockchip_cru *cru = rockchip_get_cru();
+
+	if (IS_ERR(cru))
+		return RST_CAUSE_UNAVAILABLE;
+
+	switch (cru->glb_rst_st) {
+	case GLB_POR_RST:
+		return RST_CAUSE_POR;
+	case FST_GLB_RST_ST:
+	case SND_GLB_RST_ST:
+		return RST_CAUSE_REG;
+	case FST_GLB_TSADC_RST_ST:
+	case SND_GLB_TSADC_RST_ST:
+		return RST_CAUSE_THERMAL;
+	case FST_GLB_WDT_RST_ST:
+	case SND_GLB_WDT_RST_ST:
+		return RST_CAUSE_WDOG;
+	}
+
+	return RST_CAUSE_UNKNOWN;
+}

-- 
2.34.1

