Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8539FA3741
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 12:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4923284221;
	Fri,  2 Jan 2026 13:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p6rnbEPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627AA84227; Fri,  2 Jan 2026 13:56:58 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A20A84206
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 13:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1322E3F2A9
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767358611;
 bh=EkTpwT3MOXx/tSSnmulaN+HGFUd3lkohVbth5vR6qd8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=p6rnbEPISsIPmo4ThGNfmAh8Y6ex3yOMpR0+wKRN795tcOgTUvu0smVM6nKoPlyrM
 ZStTL4EuLr2GrvSd5wn4L6nehGfddxY55kbte2gh//1gUMZ0lNbe9xw/5io+vZ57qH
 M+6RcCPesHlPdD4e8LknZG7MLPsYlWq1t9Ktntfyux1HdlZX9U9m1kU81ayGn/CI/P
 5CejWXiWgtXzGZav0KKJWc+bb4VHWX9bst3dFUnTwn7uhbQ9PBB/DxaZbSxO6A5nhw
 CqHR/mWtFuRUhuEpXmHWRdWBncG1kh7AWXua+h8jhQy2V9kbKnx/XVMRX4fZG9DTYF
 u7AM+xh6ObtUmWou0bweETbS7gEJ6im37fD6cZIJeo2V0JDizseBl83EvTkeMO6wO1
 LLtLkFZuVoELztiWioIuGWBOB8K+155x7DzC6RRLHLm9DZ1RiLMo6GKFeMhoXubQ/f
 PEto3TwtV1aGlk0NQICfayfrwgJhcz1L3264OBu1uV1xpJbbI9s/ljIMC2gFEnRPd5
 Wyg7gXnnph2+3SqW7nvsyqIg4JCbq5tXv2DOYXntYakm6jeuks1Jbe2DcB+pzEWqq3
 Q/K4kWV99cJDozda1bZIPnaBqsprw3ZzjxmcQGSMvMJxIa0yMihl+hqlPL0qrSbEXz
 lKTJvOGEOxkmBQTuUPZAoUfw=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so5437f8f.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 04:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767358610; x=1767963410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkTpwT3MOXx/tSSnmulaN+HGFUd3lkohVbth5vR6qd8=;
 b=R9XUz3Sr1fEAC+U6xxitZ0YFDMGexYpwcUKt7Pd2vhxXBi9Ie6rsYNNpI+eHM1QAZJ
 TArcQPqPCPLBCsSl+WA9UGf+TrwVgtiqLoxAjbNUCf/nsp5ZmBgoXHrbriqgrNKkC7tY
 SY83jpzOft6xRoPiLzZNjYvwL6Q92EDHcjGtVfwLccYvJolFXWU+daHTH9EfUrruGnm/
 ql34JLEMYGXQG25LfPfixLqf8Y1KvimV6YIc5FwwVO/dRCNXc1ILGHRVMR+0oFkP4BQQ
 TAn/GiqxvWyp9S0SgsGZXaEaPDpw58VPCmC99lc8gqDLaTuun2X+BPUq2n2/krnuyLOb
 J5Zw==
X-Gm-Message-State: AOJu0YwQzhVF+7sfrRJZh5rDjLMTjUn/j/wfPWdXa17iO+CNPBYtSVoI
 b+27MYftCe0ju3UC5mXOf4srksTgYEmTko2rBPyq1VjyDBHEDRKB6Z76IepCX3iH/57VfoHDKGb
 Q0P/qUWc0+sDzdxJgXx776RlU8YbisjvPb71O5j7NfylT6u67eGHEBvqCLbyxACDkON6jh+k=
X-Gm-Gg: AY/fxX5vvnhtwbvanxYl+5e2jFaxxnRHWCaGyzxP2pDu1sDN8ONZ2vfLdfbZoulBhqp
 ektARMG8gj2SmWwKpNTjN01d9CedxrvXLi4toSC0lwkgSn3R+clWmrEnXx43Za53w6hd7muBp0I
 NaDAVJUrOlURdQ5OEp/5W6jDEuDozvYQ09tX9+FDiHz1MqVJCs1jqEW/u5y47c9265Q0U1UoPEw
 uVG6tU9TB8gHcSO7Qeiiyd15y4dexW8i7bLrkmk2BADsjGphvcRZ/ho7u4VkjZUkAj4Cw+4DXl9
 QE52jQIc+EsST14wdLLGUksqqWHha/RX1fiCEciAFAHV3ojTDdN+p78DjyugHtju7ZmE8YmrEPx
 HlTJ4ixbvOjfgfvoMEPQd2NC+4Z912J9i4Jtzlex0AMn7fREDG8POR22egET5eCmtRzzQvpBkGY
 zs
X-Received: by 2002:a5d:64e7:0:b0:431:266:d150 with SMTP id
 ffacd0b85a97d-4324e50c2d8mr48930291f8f.44.1767358610657; 
 Fri, 02 Jan 2026 04:56:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRS/QjOZRtJw+H7AxamdmjbtQbbPCvmxEGeG7NvZnxZGMXys0wcoQU31wVPuLjNNNXDc/HxA==
X-Received: by 2002:a5d:64e7:0:b0:431:266:d150 with SMTP id
 ffacd0b85a97d-4324e50c2d8mr48930275f8f.44.1767358610310; 
 Fri, 02 Jan 2026 04:56:50 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm76601152f8f.19.2026.01.02.04.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 04:56:49 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb_kbd: remove match string
Date: Fri,  2 Jan 2026 13:56:22 +0100
Message-ID: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

USB keyboards are identified via a USB interface descriptor or via USB
vendor and product IDs but never via the device-tree.

Remove the device-tree match string.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/usb_kbd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 36107a3b278..29b01a85955 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -690,15 +690,9 @@ err:
 	return ret;
 }
 
-static const struct udevice_id usb_kbd_ids[] = {
-	{ .compatible = "usb-keyboard" },
-	{ }
-};
-
 U_BOOT_DRIVER(usb_kbd) = {
 	.name	= "usb_kbd",
 	.id	= UCLASS_KEYBOARD,
-	.of_match = usb_kbd_ids,
 	.probe = usb_kbd_probe,
 	.remove = usb_kbd_remove,
 };
-- 
2.51.0

