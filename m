Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E4606A32F
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oGmqQVju;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EHl+PaQg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2C3B60AC4;
	Fri, 30 Oct 2026 12:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqHjsBI6ZUqE; Fri, 30 Oct 2026 12:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C881B60AFD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365196;
	b=JaJvlTaHgEkct8C9Eu62nK2OqPkVGML2wnsinak3lxPT5Q9kjxIYx+5SR0wPN5xCAETw
	 bJK4xhAKRjmZDt40BmKPbhZ/u7D4M2xpAGgNgfHJtq5ReAIND2ptVeQ333Hj4q5jGEQ6h
	 jEe166suubOLHtY0mlBqHGAvre6So2+eGDoQoZKd3iy81EDBjxdecFPfU4fv5AZjF6Lal
	 jCNhQdltVEzbIS6wucQ20ZH+NVBUxfZHjJt0GPM9+lrtj2xDq+iQm2qe/SJ+t/weviEei
	 zM+HQmLi8NSjLl4cqqnB+OtWKN4LSEKSrch9oXNi3hfQVsk9/ki2il6uQk1H/PM+mPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FDK4iAoF0F3VJ73KuSgv4m1rogTK0xZagPaVteexcqE=;
	b=NhIx0eMN7bxB/i2Ek1ms2BXEYMAIq+0dxFHXolXQbBubvzi0Fxd6T7HvIcou3vZAziS1
	 wU1dVuMlFKBgLND6w0QCoB2vPjZpFp8FyjGkFAWRnTa3oOBn/glodUES4X2pPAbwHrQxK
	 1FCxZ0UvEJPPNroUxtoDu7y+Gzdx+JLCQAYa8G+RHzGiDpzKs6hm2oscuuYiFUTDy6aYk
	 9KciTeExglG6QZqm1dnGiq6ws1ZJXMC0ENRBnJrzWF8t/cWFZBKsRLGi1UYwGXaYJnPno
	 pLHAgeWpuucZE1UqizprlhHWSvEut4t3VliI/ph7+0oTmL9xvY9AYGBmNYIQX4c7c6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365196;
	bh=FDK4iAoF0F3VJ73KuSgv4m1rogTK0xZagPaVteexcqE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oGmqQVjuQUPdTueVWanj7EYYrYKgK+tMWSyYmgbZlwNnjdGmQxVRDbesjTJQnB8HT
	 Sxi8ahHiZWmP7X3joIqFjtBOXaAoEotinGZsRqLfG17amIkJx7km9kxMSeClolCSj3
	 7h1/eQ5kwkxriHPwfXfy1ELoCoaVyt2ufdQ0NO4wKw+w8UNikCxLP8ulvuw72q+GNe
	 J4m2NA3J+dt89U9KoMv/xgFhGM0n59cQLExMSdMyIGekbJdJSMatv6e+86u6mQWQ4d
	 TYmby8Gb3gc6S3+SXUp9DxM03x7S6UcquA1qquQ7m10JtNMv9KJXCK2GUqhiU5vInH
	 BxCyWa3tbyeuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C881B60AFD;
	Fri, 30 Oct 2026 12:59:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B2531DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C54740AAE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uk63DzAP7I87 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EC4940AAC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345878;
 b=GkxzfUwbn0my12lDPigYx0qEPqUYd3eXWylbnBUiMz7lcsoUKgJ8NvXd3La0yqLCjV3w
 fRIMYyL7ATjriRnW357JSiOCjjKxa7//fjl/wQbVyExK3TKiCQVsAp5C8NrOPXWqzEjVA
 WUm7Gy5eyaHfemsuTmNrRwPwvlCB0JNcK97OLg/4A0sIBU6Lc/xh112aBSnWC94dFPxF4
 oVxFOZSFChjOyZG7uVENjTBrE/ZSjdL2NxHMr3rlkItco8nabucZLsuShuEUxMRlkpmlz
 EREgScU9a75iPxrumMb005im27IvwvP4Ab6/LjKjITe8TM/w0KNOOUE0GEItB+O5ucQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345878;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=FDK4iAoF0F3VJ73KuSgv4m1rogTK0xZagPaVteexcqE=;
 b=HB8eaNXL4ufKl2AajDCNNHbe2RZ8UGo0AuCvIKljbWjvRt7CWC0WK+f7pG0pEsJ0Zihs
 7G2iDIz5P9cvnYywHk6G6gJ6xMSiplX16tikBLHAuoEQLJNk1QPq+qoahH2lSMpoXhwQ/
 DBvYnOjfbXw4yodD15cgO/edcf72uaJdSGr2lhSYRjFDAGKZlHzEonKwEnjnzAAuUqR3E
 qb/BSxqyv217NiwhSJD+Ub7ev3y834ftIr0PfZgASCZkqHUZNVl7sCOw0f3JShI11bkoe
 iXy7fKtKr3b1kUHqY+X9KWbgHSBfHsGtqcBd4ShBm2mtNAUZrh8NMBGxhHQIqbNso6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EHl+PaQg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EHl+PaQg
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EC4940AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:57 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so2254985e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345876; x=1793950676;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FDK4iAoF0F3VJ73KuSgv4m1rogTK0xZagPaVteexcqE=;
 b=EHl+PaQgMxQ+qLYCHws5AJzE4ttCTgyJX4+nU583lJDMvE5DkfgYfQo6rpSTfy0xJ5
 Yy8+aGDhjJDw6DqNasarOKdd5FREdxf/55wYAeLbjxBhhL70pYfysNQRlNCBNf9R7h+4
 8QqQFmttOy7p5DbSkGVlmuFyQSigbhGMnL5Ig5VkOJTEbHC2CuTOVI/xLup8cb3l/TJ3
 3LRNuvnucAHXrUXmNfbtLWvf5yIjk9D1AxAGm914k6FG6xhtWm+LnJVwc9G+u93XWE0r
 qu3q1TwD6UnvuLDUIMsZVnJvLbmxz61mWoFSAwM82SvzJCotebKaR+VEI86AXS3RrZA1
 LXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345876; x=1793950676;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FDK4iAoF0F3VJ73KuSgv4m1rogTK0xZagPaVteexcqE=;
 b=FbeakHaJUUlUPNnMWyw8Vmi/CwSITYyBKg/1aNzlk6hkTLlZrpX+74409pfdgulgVd
 xY8qsPmt2lF/gMbYWGSUhrez1tmZrLLoOgmW+AnogIdfcXkWrwL7QDJmLm3DUxF/wG8r
 NbE74xTJ8DVt76ognF+EPOZUNm7xJKQRlojLZ0/+AYVMMRwCLf8LnzoPSPJyFWUJp998
 va4/Fh3KHJeVYfFHMjviQuj4xp8zvuVSUJUXkdw5PugBa4ydQmWCLe1lhszJuFkeybV5
 yF9TunnB0RvCwkT1iLzi19ekd+VqrOxNnZSZeS/qtK/O/8OBhXKfNxSFZrVlvaW6fpQy
 oJmQ==
X-Gm-Message-State: AFq9FYKRGvgZwamoJbXXEEEVS0K5F2dtnDaJregBV+bhEGN2nqVpskpx
 qDdKOyWjeqMblcHGodItu7kufKjw6ZJyj70rN/iYTOPThvEJTaQH4pYdgiWUjF2nUiU=
X-Gm-Gg: AYBFou2qqNRfBLIzj/MBCDUv9vxGtU9QxDJYGkFN/iIbag7q5cCcjYQ4RCJnqFLJ7da
 YpWmEmZN/ZZ1Sk/4mF14x0H6YUygtcWytMkb+1ZOIWDBYG0KabNrLsCTyLe4Er0No4iInIaszJp
 sgbqbs6c0NjmQykfvFsMFZ5IXEKojT1T/Bx+IexsDkmefuTI1XeYAvsusV7PKO8RgJs/Z7Wlt8y
 POTAeRovezvh20T0kNFR5FzW3uqnK4m9wJGic6YiQ0IIzDkB60QBuKTlevIHJk+Go+uCHQaWs2q
 Buao0z3hpkKS/DLjJS3hPFC3gpWhSZ2sioJORLchNByqU9s+HAQRBZxsystYTxCvvRPnqnW1T3G
 0qK8AAhyDusGhD7WNbt3dIm7F6O4hRWbmSsO3VPSdpoIletEwH8GEBJaKiyNtL+r+/CeQ0mVeV/
 yV80q/C93GdKt/JR2lWdRAlV3LFuoMscp2TRPTQckaRO0OG3qpeX2b9fZYChOFUy2i6y8+Wykcy
 TLLkWi7Efebfw+kR+5jKGLqu1cq+EpuYWpEwiJHr8CnLIqz97W48baJUZoF8P6MMot4oHc7qPCQ
 ozRe2OT4E5LsWTW3X2xs/qIAPdKoRuj+cuE=
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4ac19234a06mr27451975e9.31.1793345875712; 
 Fri, 30 Oct 2026 00:37:55 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78c10sm1583328f8f.25.2026.10.30.00.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:53 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: gadget: dwc2: find the Rockchip USB2 PHY for the DM
 gadget
Date: Fri, 30 Oct 2026 10:37:46 +0300
Message-ID: <20261030073746.165207-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rockchip_usb2_phy.c's otg_phy_init() finds its register layout through
plat->phy_of_node and calls hang() without it. Only the non-DM
board_usb_init() path fills that in, so with the DM gadget (USB ACM
console, fastboot, UMS) any gadget on RK3066/RK3188 hangs.

Look up the PHY from the "phys" phandle and set phy_of_node and regs_phy
the same way.

Tested on an MK808B (RK3066): USB ACM console, fastboot and UMS.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed34..e982709f 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -20,6 +20,10 @@
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
+#if CONFIG_IS_ENABLED(ROCKCHIP_USB2_PHY)
+#include <asm/arch-rockchip/clock.h>
+#include <syscon.h>
+#endif
 #include <log.h>
 #include <malloc.h>
 #include <reset.h>
@@ -995,6 +999,25 @@ static int dwc2_udc_otg_of_to_plat(struct udevice *dev)
 
 	plat->regs_otg = dev_read_addr(dev);
 
+#if CONFIG_IS_ENABLED(ROCKCHIP_USB2_PHY)
+	/*
+	 * rockchip_usb2_phy.c's otg_phy_init() finds its register layout through
+	 * phy_of_node and hang()s without it. The non-DM board_usb_init() fills it in;
+	 * do the same here so the DM gadget (USB console, fastboot) works on RK3066/3188.
+	 */
+	{
+		struct ofnode_phandle_args args;
+		u32 offset;
+
+		if (!dev_read_phandle_with_args(dev, "phys", "#phy-cells", 0, 0, &args) &&
+		    !ofnode_read_u32(args.node, "reg", &offset)) {
+			plat->phy_of_node = ofnode_get_parent(args.node);
+			plat->regs_phy = offset +
+				(uintptr_t)syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
+		}
+	}
+#endif
+
 	plat->rx_fifo_sz = dev_read_u32_default(dev, "g-rx-fifo-size", 0);
 	plat->np_tx_fifo_sz = dev_read_u32_default(dev, "g-np-tx-fifo-size", 0);
 
-- 
2.47.3

