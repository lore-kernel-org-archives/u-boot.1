Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF6CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94BC481360;
	Sat, 10 Oct 2026 13:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lTHilb_meLJK; Sat, 10 Oct 2026 13:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB9A18134D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638092;
	b=Ax7cGW/CKAN+P1auzfHFPHIUbe4Y/Q69a4jHaxlYmGGwyQqFAFNbGBuVuiczlyc6TWQk
	 r209R/GqXJ+d0PsfWHt3tL0LROa2G2RKqOWyCJkbNsgF7n4FUsXBh3iyUZvXMd/pPE2+r
	 cnwvB8TiQMyMXrgxgxOr9qitrCbspyy6WjHuC5Relzx0iAtU6h0/ycJPgPxI2QHBcs8cz
	 M3QHoT+mKmhaLCE+q6orqqtS5I/XeqpiqgyIy0QAZwjDH5uIq3UtgBEcD37gOX+2n5Faj
	 9Kkdj+bJAgnaYFDOzPXlV3stVsMe+s0ZHJskcXotXiOWE84BG7BjPo0uIEPy2ZLexTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=imwxiIuBeLYbYX7+A2deOAK3LETHMzubHtrd+yRyG1I=;
	b=pACb8vU9/ZHi0bTem2jnoLwiKG0Lg3FM4l3yQFLcCV1toUYQFPpO0sP83DMOGrOnEHe4
	 LUvay81dq3P3XZYufX9Yl8e4IMVsK5IPNV0lJIlj/4U/BjImczZ/gM5gEUFQURheIrpRm
	 EgWDYDudhf4EFKTeY/8MN823bc22W3xpiiqj1Q7wLvT1A1VmSFnqUX9NXTdIZrTPYxQoK
	 ReBCCuI+YnSrLjXObotOhs9SXzYvJupAlls1N0UzHaKY/rHP75SxqjZXhKIfsavrvRYs3
	 5KUFEfUslD6CL4M99tRkoPeay+dQcd/5jiN4Vtdr/g7gBRTL7pB4vniTdLfV97PXCwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638092;
	bh=imwxiIuBeLYbYX7+A2deOAK3LETHMzubHtrd+yRyG1I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZLvCVH+Rhj3fLYsaYYsXBRPPYJCNrcpjqxRJdRVZUEzc5+FD8kJUDPhGur1iuxlRL
	 Fs7CTI7wG9RTPd9jdRJsL4slv0iqLkrbVJolDA3xF0Vdkrj1h+MRGpTxitCYRj0XA7
	 WNC2qJM3RknJ9+r4kDdBKdQcUlq2jmUN57265xWhlqLX46ruRYA2oREKq0fz7OwA/X
	 x3LjpFxVcSNSgJwHj/ah9zmHCMjUPTK7yKMjHe5kUDQJVeQNVgshQUg0TaoJhHw9SX
	 HRH3ULc/5QpbqohNAb+hcDs8ybQAiclXQjQr/q6HVJMM8FrHWHCJvsIOf8kiK8WIQF
	 0VIfsRDJ69S+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB9A18134D;
	Sat, 10 Oct 2026 13:14:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98948105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F58440061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmR5DMiY-97d for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 10:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E427140004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791627885;
 b=UfWr89Qr2HwaBOpw5Y3fiWh31zTYFX9zn5xyaiSPzIw3EXDdsojHa0r1WmBJdhsi4LuD
 clVb1BRevszGZWD98XZavVi5n5HoJSbuav1v2HgQc9wiPzGTpWCFR8nWtRHvfYBMVvdo7
 Z8kMW/9J9fnxP1pKfZvGeEkoE8ZYsvCky9R0mUcL67rKZLgFz2cdNq/ZC9hNyCs+Tb1UY
 gyHrlbT54hlfqVhgecAGd8MA4gRpsUbhHAeU/hCd7fCYsejvrtBe2yAAlqmGhMDeYI1pP
 r11c/ghONT0VZwsy67aYcCRXfgC+eo5wcknTMcC/2BcjGp4nCvgXySgRlYuj6mGtMyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791627885;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=imwxiIuBeLYbYX7+A2deOAK3LETHMzubHtrd+yRyG1I=;
 b=iC6ckYmapAfwvmPUALbVTyLnUAuMDonjkAfOMMMK06SU8tRRGZMnyJHJOvcbaKjFe8Gt
 rv8oR7TwzRkScBoOU2g3m1f0MOsz1MW5eL6iG68XsJm9JVcMkDMn+P1QvqvzjgZRMvGXn
 8YfN4wHl2umxydFIEkKP1HIiD4MDEUUPXHuwzEoCkodh+gHk395s3YbWfocicdmYWclDM
 4PfzcpIwoZR2Kc3xtMyw75qbIf2zIPvXH4wDHGJuIYOgjb5VNqdQ8xRFf6nRmbTveoW1t
 AflFyJq/wdGT5WNXQ00SUsNz6s2KvByozNo98bXDWLCNU+s5JcNEeV0HLuoSCozPQXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NkKfbu0x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=tsuji.riya@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NkKfbu0x
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E427140004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:24:44 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc4b1f7e8f4so234942a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791627884; x=1792232684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=imwxiIuBeLYbYX7+A2deOAK3LETHMzubHtrd+yRyG1I=;
 b=NkKfbu0xFhZBN0GCHYQGEdquCyP7Dx6xX6V/9V6O8mxj6ElLjW0cCOEowy6obCTQnK
 eV7XHqeiL9dsWEMt0LIDDY0ZZ8nuzmdZ+pEbcr/JIOVmIVMWxGesYbicPX87z6lpTnqX
 iK2BLwUJOB2MlvPquLoKuk1gPml4d2d0AZewNMoc+xKalkRxgizhe//yj7L10oj9Xbwu
 Jrx8mnTBl9rhM0pilpjBV8dq+hatLnZYKJ27leeAU2Hz+0xf/yA/PrJzm86P5iRTaxRB
 OcS0anZbHsHWJW5Tc5NjwZueS8umrgssaHmYJ2pxYrhOcsUSajEp2r7gCkCCsNIAf6Xi
 lQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791627884; x=1792232684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=imwxiIuBeLYbYX7+A2deOAK3LETHMzubHtrd+yRyG1I=;
 b=jWbDCarSYIZi2XDTLRdXxpw/c6N/OmmyEQ++43JcCHmyAYEWZTsybf3Ylxm3LU7AAi
 Eib+BZHvJ1UQDJM6BABhkgRL5IrTwHNr9Gb9lOEbLZQz4g6j83xjJyiWzqDsfjmd99Ho
 SaCq727Oeewv6UMKgTWTWHYJFiTyeKEHRXgYScS4YROczFTM+1zY1p45UjGzCkGXvN/1
 HhElmaXTj7Q1CwY7hK/Cd6n1kVCdhixRSz2IoQU4A/tA0qKgwUNH7l8KZsMavokHYOxS
 LXbyWhqoIo8oxIkXnYn+XRUThwwiM6SRHeMVjp3Ba7ly4A7YP82PGeZ+nVcRYA6/bTHm
 ZgWw==
X-Gm-Message-State: AFq9FYKnBj+KoLO53mU+R1sV/RyqX+FDG8b90JmbdQxYLh27RWkHIKSu
 Gr9qtiAED4tgS7lfvr48U/TIQlM/1Lp/Rfo3WLJoRqNa8+tAPVWt8RQRyZjsW+QuiLNEkQ==
X-Gm-Gg: AYBFou2thS1pmnJGpvSTRM5MXzYi59JNszfmr3wHG0ZsdEZhe3165/sFfIn5r03MLLz
 0+KFQ5spEy2YJw5J8Yjk+gHLSqWIoO9t3PlxZo0EXuMCkmjFtBfQOri0cgxRI/iyZZ8eMhlGjmv
 2CzjGzKp4bKDBPe3dkdIWK8BhR6WzoQ5r/ScdN/r8poORLTe8ybUVtDHBe1eD7hKtygSZPzhyQP
 p355XlMcjUS/jm2aNhTIUvCwfjUxenU8p3wUG/qlr3XE6QN5OE/YYH4Ndy4LpAAGU2vwkhrN8ib
 D5Bt2/rkU+U0T/YRqNK/SJGynU19WGbZOP9+2iRjzOGCWasyoo+ROfDx41E6n1sxDRoRUiX6btB
 mKdILPLRj3/FOajsgbtKyg/BwhSehXYsuJ4nl5RRQ/LT9a0lp3xItQGZHisjwKfE6H3ykCFGgmk
 jGYUYQz0PdzxUeZhlE5+EpSCvuKIzfM7TVwn9sZr7n0TCfHxeWYDjXwymzgU2WuLcEwVgNtpjw7
 Y23eQ39piR2g448z80X7X+JBaUzIosmW4GYPC6AUdVNXx53+J5pAGXZABoVumWW2Ue39nuodEJP
 SOsLrGf1rcyte2f+J89LCP3S
X-Received: by 2002:a17:90a:510:b0:3ab:6ac7:64a with SMTP id
 98e67ed59e1d1-3ab6ac70b98mr1354918a91.34.1791627883895; 
 Sat, 10 Oct 2026 03:24:43 -0700 (PDT)
Received: from DESKTOP-5PV2OB4.lan (61-23-191-103.rev.home.ne.jp.
 [61.23.191.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371e2833sm7827319a91.17.2026.10.10.03.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 03:24:43 -0700 (PDT)
From: Ryoya Tsujita <tsuji.riya@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut+usb@mailbox.org, trini@konsulko.com,
 Ryoya Tsujita <tsuji.riya@gmail.com>
Subject: [PATCH] usb: kbd: Add 2024 Apple Magic Keyboard device IDs
Date: Sat, 10 Oct 2026 19:24:31 +0900
Message-ID: <20261010102431.38936-1-tsuji.riya@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

The 2024 USB-C Magic Keyboards (05ac:0320, 05ac:0321 and 05ac:0322)
have a Device Management HID interface as interface 0 and the Boot
Keyboard as interface 1. U-Boot only looks at interface 0 when matching
a driver, so these keyboards are bound to the generic USB device driver
and do not work as a console input device.

Match them by vendor and product ID so that usb_kbd binds to them.
probe_usb_keyboard() already looks through all interfaces and uses the
Boot Keyboard on interface 1.

Tested with a 05ac:0320 keyboard (US layout, no Touch ID) on qemu_arm64
with USB passthrough. Without this patch the device is bound to the
generic driver and no usbkbd console device is registered; with it,
usb_kbd is bound and keyboard input works.

05ac:0321 and 05ac:0322 are untested. The IDs are taken from Linux's
drivers/hid/hid-ids.h.

Signed-off-by: Ryoya Tsujita <tsuji.riya@gmail.com>
---
 common/usb_kbd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 36107a3b278..25d8a0dff64 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -30,6 +30,9 @@
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021			0x029c
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024			0x0320
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024	0x0321
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024		0x0322
 
 #define USB_VENDOR_ID_KEYCHRON	0x3434
 
@@ -724,6 +727,18 @@ static const struct usb_device_id kbd_id_table[] = {
 		USB_DEVICE(USB_VENDOR_ID_APPLE,
 			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021),
 	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
+	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024),
+	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024),
+	},
 	{ }		/* Terminating entry */
 };
 
-- 
2.47.3

