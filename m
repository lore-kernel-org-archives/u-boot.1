Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEBBCCD18D
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5938312A;
	Tue, 14 Oct 2025 14:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="rVMSh1SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA408313B; Tue, 14 Oct 2025 14:46:06 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA35082FC7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type; 
 bh=SkQ/5n4w+Vb5cf86sNNw+zR/Fu2s66dI5d3DLwsvCMI=;
 b=rVMSh1SN4zmBkxurodAyC1SOeRzPvjVbFWgw2l9yy1kfDteublcEdG9NR/nNuiKDSwvx3nt4WMUHIIARJcgGAZ+JNVVDZad5c15GaiNQTIqMzYjelWZnqoAj/cTM3bc0zn7CcjDQpO+9CWZ3uhZSV/jJfqMwqNYTXTnKWeIv/m4LzQhXDP0uTXOf5utzjCy9ssOLvshaGRR8kWo75s47G5Lj7Fg6IxvuKYrkIRJp4ISnDCgjJ+TCwYzH+Y
 MkIGl4cPukGgH69Zbr0DYJxYONBvVuUIim7sl/oiIXP6wdgJNJm/62us60gd3UsnV3rUrYdF50w/lwxEhM1L9JOYcOGQ==
Received: from GRAPHRT (188-24-192-7.rdsnet.ro [188.24.192.7])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 14 Oct 2025 12:45:40 +0000
Date: Tue, 14 Oct 2025 15:45:47 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [bug] can't start watchdog on RK3288
Message-ID: <aO5F+z0n5ETHZZGt@GRAPHRT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi.

I have a bug to report. I tried starting the watchdog on Asus TinkerBoard S
(Rockchip RK3288), but it's not working. I investigated a little bit. Here's
what I found so far:

=> wdt dev watchdog@ff800000
drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: timeout-sec: (not found)
drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: hw_margin_ms: (not found)
drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,noautostart: false
drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,autostart: false
drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
Can't get the watchdog timer: watchdog@ff800000

It seems that the error is generated in designware_wdt_probe(), after
clk_enable(). Function clk_enable() runs on branch CLK_CCF=false. It returns
error from ops->enable. Struct ops is defined by driver: rockchip_rk3288_cru,
in drivers/clk/rockchip/clk_rk3288.c, but it doesn't have a .enable or
.disable component, so there is no ops->enable.

The solution to this one would probably be a stub for .enable. AFAIK, it's
always enabled.

I also tried to enable CLK_CCF (drivers from Linux tree), selecting the
watchdog works, but if I try to start it, the board immediately resets.
I have no ideea how to troubleshoot this one.

Thanks.
Marius

