Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C788C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AE3140BC4;
	Fri,  4 Sep 2026 13:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ko2Y4iZNucvj; Fri,  4 Sep 2026 13:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 474F740BAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788526944;
	b=pu6z/K+dh7E8VgUFCuzEm2kssmp9U4VuyfUnAPJnLQuoKV5hdEKukzJWcHwkpqcGSgU1
	 Kds1HsKSt5eanaakZHmmYQD4HMaa9zBrSXx9kJgA123ijaNNPMLenMFfBltvURDZLh+os
	 i2VrNvigD964eSe6IRL3VT1VGMCQ29g8laxdvL0z+7tQ6I33KtncSXyjQDPeQ0HeEaxDN
	 Aho3+f7lG9zoIsdU0kCV3Uty7abvfx8gjsVZgBwbAtzfUMfTC2k9OusL9W+27G1JJDAm/
	 sjwjO5B5GIid4CWWZCoSyrfyaKLe4D8dSVeAPT9gwnxE/337cXv7pLbstmK45C0V4Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788526944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
	b=JI08kU9JOJUzMTOYK6t/XmqidZdXfXtS/UajhqT52B9qrT0xmIT4YaXP7gTbm9LFL4QF
	 3uPhNevMNQ9QmHuXJhi/q4yzP/MEgimMYRq7fs43VKBs+DihcXCS2rszt5zG46IzdbjcQ
	 X3IT5RwG+cWQeHZcmceWH6uAgYhn/x0+PoXSvsq+25ny9vMlbMzbmpKEmIy3nAIEQhhmM
	 dtnXdl5vHO0zf5OHuLtqPkINKIW58G21XQX3NpVO9v1O6IL9qt3LKzafNtF5LPolC9gJ3
	 +2H0afurMSLT9hIAR7dfSXu/wSQHKM+JNk8HC3hWB1ksoJLMGrrhUd463ha7svQkiiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=lnDeqT5R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788526944;
	bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hg5razovrcb5VWF2fnWHzazKQMObOdddpky/0TuBMhY9HGwNtrT6kmpHp8z7Er8Wz
	 W3VIUIBUnbU6w+7rGXy3zm1wYEqKtbFXUECuBnUYAjvFREBH6R/fu+Q4udVnE+X+th
	 +IBZQGvk8TTWEBR7uCPYK3dxq8TvJE3p0yO1tnZ2kj4qlZPHKhFG0Q5cxS4lys9awd
	 EB76IAEPrKO09FYAr7p+YDa8supP6RgOm9hwrC2O5rqRfGNh+LcwOm1Kxc82wbhcyx
	 itCQOLwSp57XNlvLkEWJJLEiiowWArfX17YxIeJyLCszafGYSQ0sIMhOtZOpv6z42a
	 XvQINCgxKJhzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 474F740BAB;
	Fri,  4 Sep 2026 13:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 620D310E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46AE240BAA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbdeaZ_nzSXE for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 643C540BAB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788526940;
 b=jTIVbSxX46449dkgiZ4/vXzOj2257qq3pCfmVSor5EVz9jR1mEX40TNCkWPMOgyygL8t
 QsfrvZTmDmrJPhesSLHxfqrREdyg7/AaejPPTdoq4TNGdXZ7vzJaF43YJmoI8BcwrpbaB
 yubNSp82XX9UMd3PzTacAWvVpltu3ZUyakDo/9fdxAZ3XaNUF/YBB9F/B7lCcA2ubzYyv
 C/jEtXtRZi0a/X8eF9eRzEby3ia5qhQZNwzr6N/Xz2gFZHuALYk1WKx8uXDAshEzeXbw1
 Yn6w7UKi6f0FI9yv+gVvlRCWLT6Ny+BrdhotovOXYa0aLcIpQrp87UC9tz+Om2KN5cA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788526940;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
 b=bjFn4lP8+s5HJIPaJmTjJsfCkmzpFgZxjRPXlaAH8W9SXwiWyjvGafU/D6P62sb6Zplc
 P8NIG16sNhSoqUYvmPeKELsHi4rR4P3tBNlxykFkGSFcxqlEa8WdTomp2FM8rDX97ixoY
 UpTZuRVtpNft67n5vLsoOO9DlyriPy6lUeoyluveEi6OXalQlhmkAuMAC4+0wiVEC1Oxi
 0fs9MsZj8rIOmRiH79Qvt/I3W32AzCwQZZbbKj12q7k5YSbUwPm4aboL3KHggxJpvAsDe
 wd/SdR7gMwUQZUnbdbgI18ilfkSyg9lmP7eIOE7D43nsaC1NIKILE1lUZ5LsVy6wlyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=lnDeqT5R; 
 arc=none smtp.remote-ip=185.136.64.228
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 13:02:18 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=lnDeqT5R
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-294854-20260904130112ae36541fd6000207e7-1wo0fb@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 643C540BAB
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:18 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20260904130112ae36541fd6000207e7
 for <u-boot@lists.u-boot-project.org>;
 Fri, 04 Sep 2026 15:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
 b=lnDeqT5R59FVaLA7jweiJg2Gj22WgkuvfdDvSsLrBA02XpWP6jbvcFPEVC0uzyriN0Ksk1
 +bjR2+VAxnUMSCOijf6XML8f9ArJd0oaaO6u2YvYKxlCgwkz0fioW6tthQ9Uc3ogDd6+7O8n
 AERscYEL4uDmf9GgPX5wZKgcQecReV0H9oKJx/lq1CVc/ZGmE2ruvofr30YNLR88SNHGkrb+
 6zPfsqhiYmUzt/m+Xe6YIf6hZDWv92MpbpJxaohCor7l5vXIBaRUf/++T4nZ1hvqG1R2SjkW
 xdJzUS0MDNmhyagQD0BYpRtAD4OiiWPQofLogDdOGuffYUcY6m6YFqMw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 2/2] board: qemu: arm/riscv: Probe watchdogs late
Date: Fri,  4 Sep 2026 15:01:04 +0200
Message-ID: <d25423772d51278dae4631f4f22923bfed1f8bdb.1788526864.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788526864.git.jan.kiszka@siemens.com>
References: <cover.1788526864.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

The only watchdog QEMU offers us on non-x86 virt platforms is the
i6300esb. This one is PCI-attached, but watchdog probing will happen
before PCI, so will miss it. Redo this late so that we gain autostart
support.

Deliberately limited to contemporary ARM and RISC-V.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/emulation/qemu-arm/qemu-arm.c     | 5 +++++
 board/emulation/qemu-riscv/qemu-riscv.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..529bffa3e49 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -14,6 +14,7 @@
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <wdt.h>
 
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -114,6 +115,10 @@ int board_late_init(void)
 	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
 		usb_init();
 
+	/* watchdog may come via PCI but was probed too early */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	return 0;
 }
 
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index ce5bc34ca71..5ed21b286ee 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -14,6 +14,7 @@
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <wdt.h>
 
 #if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
 int is_flash_available(void)
@@ -38,6 +39,10 @@ int board_late_init(void)
 	 */
 	virtio_init();
 
+	/* watchdog may come via PCI but was probed too early */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	return 0;
 }
 
-- 
2.47.3

