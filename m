Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7E3C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04E78810E1;
	Sun, 20 Sep 2026 15:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JVBoI1ofIzk; Sun, 20 Sep 2026 15:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E2FD580DCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919380;
	b=HMV84PZ2U/TU/Bzqw74oEnJ7xRWZ0nP4pQczu4wOz6YMNZmxYEc+LXj33Hxxx6RiKNE9
	 2VPJjUdOKUaX7+EUxj5DNGT8cYB1L43JP/oz5ha9ahQGT7V+amJUpKdxZRsFDult5RW/i
	 4tjIVQb9NA6zj5Ha/CiJrqfHfWHtQb4I8AZn7R/6OwZA8HbRPiFTafBf6QmTzqiISZuZi
	 vOyecK51QxHf5vlk1f4fUp/sdv8y5MYCkR5GOqXDNjAVQEpz8tatHKwS7W4pVKAOAp9LR
	 d7loxY/sAONVMahKt6DN1Q7yG5aFwJZhttFhM4rYxTTDIvWlUnDXEn+KekIcc6z952g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919380;
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
	bh=I47pHHaq2SQWe1fEOVkIitWzADRp9rExfjfmtZuTrs4=;
	b=Ym28Jct8zqZtQT2W0RV9YvzQifNSRnokGnElMgovKZyPxF3Fa2Z4oV0CqmEwsPoBF+or
	 kSgmEDPCsPNad7SRG0pAgnwilTVanF13wso3SVsWxaisn04dHFpdmzeFKMVreG9WAJq69
	 UE3dc4oIoiXHqZSsdd4AyvbfMqSf/o/9UHvsiNQMplSVQGSVd0i76kK/T9vdiA+f8Xf9H
	 dQsLmlWjt8lyP5cVC4Gkj8jHOZ9l2M/6gaJy7mAL6wgGUJrEhoGf4orRRAiutAmxDSNG4
	 6cbjpejZyihtdbM67MCmCHv2IYx9mgtK1AlsapE9JrC92SlnwFBrWg2tmVNiU8DNzbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919380;
	bh=I47pHHaq2SQWe1fEOVkIitWzADRp9rExfjfmtZuTrs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKl2PsGv/G6pCJceQhTFcyA2L/XhIof2BGGhiZtF1p1dXjUqs4KPbSrSlJkmW0I5Z
	 huhpu7hCB1qnR9MBGMDAMpfyKKW+H4C8NX9hwikpLOArxIedln06h7rWWnIQbcI0vL
	 BZh0+qieqtO1i08FjZoh8LZ/uSjMEQwFzqK+rJw3ilceIIOhC4OXcjruGYXv0SEuxQ
	 Hdc1Ghp18sunzeTfUYU28fpZYOF9w+5R9pZMWyOCyk/W/WVkPeMFTqQAG9vdgklsBe
	 JDShrWiEqSWa40IgZtx8pfPwbMEw5BH2Hdj9u3sKG6jioXQNY6OWYvl5GNQY+nuQi9
	 cC/TKS4SevTIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2FD580DCB;
	Sun, 20 Sep 2026 15:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8686C24D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78BBB606D7
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZViEpMiISSq for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1302E60639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913796;
 b=Jtw0aBWR1m/iDRfxoyTZ20XcTTGmWHWm/nnuWpraipo6VnjJ5zXe0wP1GtMhY//ng0Ly
 zBypQmd6VDK7P0lZnqzG2oYV8tx1xi6nf7s0xcVljVMsqlKn9XM5Ylx4fVJwJxBvmBuuD
 /T3Iw7Tz4cpUmhMfDAVsyJ+NhFcK0xQIjbTuT88iKfdQ621hc9oCcXPDn7wg44lqAg68q
 WMYo2yZDH0pWbwNb6xg/MIg1QlWvwHYjoJH5ipdOp1yTe1qY/mI/8YcaauxlvpAdX4HjW
 Ug5HfOlFjOpUoIibytoBTEw7nKuIQl2D0F5fLueTseaxc7LuP6TteMM8MPvHfwWsCMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913796;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=I47pHHaq2SQWe1fEOVkIitWzADRp9rExfjfmtZuTrs4=;
 b=l0cAZRI9VNDW2KjMym8uPnXS9vgmASsj/7RmF8w6yKXNsLnx7BAe4jsXVO0+YSK2iIpT
 YRzsEfukTKifOMcH0aoCxv5NfX6cBCWS17KfzgMFyVDcUdt5i42EMLPKYQCC3MeesXjPC
 scES7GbE2XYTfuaFOrx0qIjtvCQmSxesa1EQqt+EjuaOgx5lC4gMrWCScNhKITaJFEAMj
 Cpd0+SOJ15O+1v5Lj+iw6VHQrsDuefdd6fsMyh8xqoqBo6Eg34IlrWo9FsrgoW60mkAs+
 p4KxOtER0DYyecg31gNMOb1q4nWl/XqFMUSv0IDLhmxlWrD+yNsSnPAUlac1bE84x8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=l98WBPp8; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=l98WBPp8
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1302E60639
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:32 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so18597365e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913790; x=1790518590;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I47pHHaq2SQWe1fEOVkIitWzADRp9rExfjfmtZuTrs4=;
 b=l98WBPp8sNLYIvo8nhTITTCwx5Q1Pt5SqT6Q59IoqwzusEmxrSSLh+WZE+wq4X50xu
 zwAExcuCewyMzCWpO0JXLY3tqopV0sVi1QbNfSL9RofoYvMG3ytyPJy5akr7z6bEXp6x
 JE7Mo6HwEAIDcQ6ZnnpLrwfevC1qd7hOtq3DMjZgthFqKzudEW2ywhmTBfyxlxx6pk/J
 tyIYTha3W7ieSRos9lrchDwHTfR8T8nNjM7zl9JAJTj2At5708SD9tghV73ahcZiHpfA
 UIzkzG4I9DU+slJ+lBtALeMaw0KPfiiDZXQnLCUSASAp89q2FEFW0NBOT/NS9uq+lq11
 YfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913790; x=1790518590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I47pHHaq2SQWe1fEOVkIitWzADRp9rExfjfmtZuTrs4=;
 b=ulVe8oKhavXf806zLJAipwRU0yoK4kONxcpl7sfzMv/wqWekF4T5zK4MM1g9OBPlrY
 qmwSjhVgbwZcJkhfHFgujVmEQgaefLPuNez1UU8Z6/+MWh+u2dqxhSZkTVOPrTNEUmks
 BWHJqlTKLH9txQ+nRzkpiqvHWBZo0eThxHxRTzlrg5shFkQsm3yRaJExHFxE0Jbo/k5v
 MAdfQcS0bded0BTUy4ZVG3effzIhPJGADsKclQX0P6jlEkv29U39etqwReG89dQhpNqq
 tqJ1TZG9WBWiuwCpM/k2zOR4+Ub9w/viCwo9FnsqKwUSrRExNSMZCraJ0hv6HcKqgk9i
 02jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8o5OjfeWyl6FtWb7a3w9ibke9Y8/eYCnXPYBbB2K+WXKtlUyH56Nz6Q6ciF96ZA/izGMD8Dg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nKat4Y31roYQoiDy9Z2QjkUYZKCiFyv2fWXXJfoYfbuY3J/yJE
 vU8aRgB7SuIy7vaMyfcmmfeBJRqFqYvZJtWN4UksrVd0bcC+TiP06kVf
X-Gm-Gg: AYBFou3HzWEau20DOj29cQninAkVs93xgtgRktYGRjPoG2rFNaGUM4aSKhWqifRz3Tj
 7AC9ySuyt3wSCVoLG9xj7lqL5yjVLZ1a0CoEW4E6FoUxAIW1USEROceIxqrhxroMYRmprlbTDAy
 Z0AUM7sLNmJpTCEbhW9KXg4b1nP6jQH2p13taqKnolTab/hwKNuOhfDnRkexB+uqilFYlQs9rKY
 VzGXcb0auT6TFv05Ra4TeuIA3mHN8r1ym1x452H83M/kFd2n2T84nFXuxjG4xlzxqzA6ZqialON
 KKAlWzzQl7xGd4VO/SNqT2t/S1BlYckLdPNt62BdjsfPB0/Yl2ODYfN4Cmap8c3B51brzPbGbOq
 1K3MU5xLcEiw34deGKb+XIqwrfWcntn0AGXVHQCLlsITNAR+0eVauGDq4t0qZIsVxY/2LLj94y4
 EngzD3+N7wvfaqpBsw9WwfU3qNhthPIRO8jiP2u4kulDUdYVHUx+8gh45RHFXrM1JGfB2JjQkNY
 0s4kbem
X-Received: by 2002:a05:600c:19cb:b0:49d:1840:4fd2 with SMTP id
 5b1f17b1804b1-49fc573d965mr114088045e9.23.1789913790312; 
 Sun, 20 Sep 2026 07:16:30 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:29 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:51 +0200
Subject: [PATCH RFC 07/11] arm: rockchip: print SoC detailed info with
 DISPLAY_CPUINFO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-7-42820216369f@gmail.com>
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

Several Rockchip SoCs have a specific implementation of checkboard()
that prints a string with more SoC info than CONFIG_SYS_SOC: in these
cases, make print_cpuinfo() call it to provide all available SoC
information, and only if the function fails print CONFIG_SYS_SOC as a
fallback.

Unfortunately, checkboard() is a special function used to override a
weak dummy implementation and is wrapped into INITCALL macro when the
DISPLAY_BOARDINFO(_LATE) config option is selected: changing it to
return non-zero in case of failure is not an option, it will hang.
Therefore, rename checkboard() Rockchip SoC-specific implementations
to rockchip_print_soc() and change them to return zero on success
and -ve on error. On the other hand provide a common checkboard()
implementation, at Rockchip mach level, that wraps them (or the
dummy weak one) but always returns zero.

Moreover, if DISPLAY_CPUINFO is selected, make checkboard() not to
call rockchip_print_soc(): being SoC info already been printed by
print_cpuinfo() it seems redundant to print these info again due to
DISPLAY_BOARDINFO(_LATE) being selected too.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c      | 18 +++++++++++++++++-
 arch/arm/mach-rockchip/px30/px30.c     | 12 ++++++------
 arch/arm/mach-rockchip/rk3308/rk3308.c |  2 +-
 arch/arm/mach-rockchip/rk3506/rk3506.c | 10 +++++-----
 arch/arm/mach-rockchip/rk3528/rk3528.c | 10 +++++-----
 arch/arm/mach-rockchip/rk3568/rk3568.c | 12 ++++++------
 arch/arm/mach-rockchip/rk3576/rk3576.c | 10 +++++-----
 arch/arm/mach-rockchip/rk3588/rk3588.c | 10 +++++-----
 8 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index b6e3d9ff964..823a2c6b89d 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -10,6 +10,20 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
+__weak int rockchip_print_soc(void)
+{
+	return -ENOTSUPP;
+}
+
+int checkboard(void)
+{
+	/* Print SOC only if not already printed by CPUINFO */
+	if (!IS_ENABLED(CONFIG_DISPLAY_CPUINFO))
+		rockchip_print_soc();
+
+	return 0;
+}
+
 __weak enum rockchip_rst_cause rockchip_get_reset_cause(void)
 {
 	return RST_CAUSE_UNAVAILABLE;
@@ -38,7 +52,9 @@ int print_cpuinfo(void)
 {
 	const char *cause = get_reset_cause();
 
-	printf("SoC: Rockchip %s\n", CONFIG_SYS_SOC);
+	if (rockchip_print_soc())
+		printf("SoC: Rockchip %s\n", CONFIG_SYS_SOC);
+
 	printf("Reset cause: %s\n", cause);
 
 	/**
diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 5a5c119328f..83b430b0ea6 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -453,7 +453,7 @@ void board_debug_uart_init(void)
 #define DDR_GRF_BASE_ADDR               0xff630000
 #define DDR_GRF_CON(n)                  (0 + (n) * 4)
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	struct udevice *dev;
 	u8 specification;
@@ -461,32 +461,32 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* base SoC: 0x26334b52 for RK3326; 0x30335850 for PX30 */
 	ret = misc_read(dev, 0, &base_soc, 4);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	if (base_soc != 0x26334b52 && base_soc != 0x30335850) {
 		log_debug("Could not identify SoC, got 0x%04x in OTP\n", base_soc);
-		return 0;
+		return -EINVAL;
 	}
 
 	/* SoC variant: 0x21 for PX30/PX30S/RK3326/RK3326S; 0x2b for PX30K */
 	ret = misc_read(dev, PX30_OTP_SPECIFICATION_OFFSET, &specification, 1);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	if (specification == 0x2b) {
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 6916f1a2444..de56672cc0e 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -152,7 +152,7 @@ int arch_cpu_init(void)
 
 #define RK3308_GRF_CHIP_ID	0xFF000800
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u32 chip_id = readl(RK3308_GRF_CHIP_ID);
 
diff --git a/arch/arm/mach-rockchip/rk3506/rk3506.c b/arch/arm/mach-rockchip/rk3506/rk3506.c
index 2ed1dcc128e..141a9a9ab0b 100644
--- a/arch/arm/mach-rockchip/rk3506/rk3506.c
+++ b/arch/arm/mach-rockchip/rk3506/rk3506.c
@@ -83,7 +83,7 @@ void rockchip_stimer_init(void)
 #define RK3506_OTP_CPU_CODE_OFFSET		0x02
 #define RK3506_OTP_SPECIFICATION_OFFSET		0x08
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u8 cpu_code[2], specification;
 	struct udevice *dev;
@@ -91,27 +91,27 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* cpu-code: SoC model, e.g. 0x35 0x06 */
 	ret = misc_read(dev, RK3506_OTP_CPU_CODE_OFFSET, cpu_code, 2);
 	if (ret < 0) {
 		log_debug("Could not read cpu-code, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* specification: SoC variant, e.g. 0xA for RK3506J */
 	ret = misc_read(dev, RK3506_OTP_SPECIFICATION_OFFSET, &specification, 1);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 	specification &= 0x1f;
 
diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
index a39cb8be9a1..87b0040074b 100644
--- a/arch/arm/mach-rockchip/rk3528/rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -104,7 +104,7 @@ void rockchip_stimer_init(void)
 #define RK3528_OTP_CPU_CODE_OFFSET		0x02
 #define RK3528_OTP_CPU_CHIP_TYPE_OFFSET		0x28
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u8 cpu_code[2], chip_type;
 	struct udevice *dev;
@@ -112,26 +112,26 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* cpu-code: SoC model, e.g. 0x35 0x28 */
 	ret = misc_read(dev, RK3528_OTP_CPU_CODE_OFFSET, cpu_code, 2);
 	if (ret < 0) {
 		log_debug("Could not read cpu-code, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	ret = misc_read(dev, RK3528_OTP_CPU_CHIP_TYPE_OFFSET, &chip_type, 1);
 	if (ret < 0) {
 		log_debug("Could not read chip type, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	suffix[0] = chip_type != 0x1 ? 'A' : '\0';
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 2b1eafee37c..c42d1982feb 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -153,7 +153,7 @@ int arch_cpu_init(void)
 #define RK3568_OTP_SPECIFICATION_OFFSET		0x07
 #define RK3568_OTP_PERFORMANCE_OFFSET		0x22
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u8 cpu_code[2], specification, package, performance;
 	struct udevice *dev;
@@ -161,27 +161,27 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* cpu-code: SoC model, e.g. 0x35 0x66 or 0x35 0x68 */
 	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
 	if (ret < 0) {
 		log_debug("Could not read cpu-code, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* specification: SoC variant, e.g. 0x2 for RK3568B2 and 0xA for RK3568J */
 	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
 	package = specification >> 5;
@@ -191,7 +191,7 @@ int checkboard(void)
 	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
 	if (ret < 0) {
 		log_debug("Could not read performance, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 	if (performance & 0x0f)
 		specification = 0x14; /* T-variant */
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index 76119cdb1ae..80905dccf6a 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -209,7 +209,7 @@ int arch_cpu_init(void)
 #define RK3576_OTP_CPU_CODE_OFFSET		0x02
 #define RK3576_OTP_SPECIFICATION_OFFSET		0x08
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u8 cpu_code[2], specification;
 	struct udevice *dev;
@@ -217,27 +217,27 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* cpu-code: SoC model, e.g. 0x35 0x76 */
 	ret = misc_read(dev, RK3576_OTP_CPU_CODE_OFFSET, cpu_code, 2);
 	if (ret < 0) {
 		log_debug("Could not read cpu-code, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* specification: SoC variant, e.g. 0xA for RK3576J */
 	ret = misc_read(dev, RK3576_OTP_SPECIFICATION_OFFSET, &specification, 1);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 	specification &= 0x1f;
 
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index f69792670d0..e3a2198cc70 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -270,7 +270,7 @@ int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
 #define FAIL_RKVENC0			BIT(0)
 #define FAIL_RKVENC1			BIT(2)
 
-int checkboard(void)
+int rockchip_print_soc(void)
 {
 	u8 cpu_code[2], specification, package;
 	struct udevice *dev;
@@ -278,27 +278,27 @@ int checkboard(void)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
-		return 0;
+		return -ENOTSUPP;
 
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(rockchip_otp), &dev);
 	if (ret) {
 		log_debug("Could not find otp device, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
 	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
 	if (ret < 0) {
 		log_debug("Could not read cpu-code, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	/* specification: SoC variant, e.g. 0xA for RK3588J and 0x13 for RK3588S */
 	ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET, &specification, 1);
 	if (ret < 0) {
 		log_debug("Could not read specification, ret=%d\n", ret);
-		return 0;
+		return ret;
 	}
 	/* package: likely SoC variant revision, 0x2 for RK3588S2 */
 	package = specification >> 5;

-- 
2.34.1

