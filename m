Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE1C48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 09:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6C387DEE;
	Wed, 14 Feb 2024 10:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="D5GQgPTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AC487DE9; Wed, 14 Feb 2024 10:55:19 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E3987DF3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so41671545e9.2
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707904513; x=1708509313;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VkOtaXDOOimXObWIFaRUDXcIU8kwUzNJXHOa9AuC1s8=;
 b=D5GQgPTdJU3zQW+PbpqwvVXiOeGbdJMhh4QP077WKOHdvRuUPJvIIbJ/Srkh7BqDoB
 z4zAmZUTt2lsMa6wccGoVNcAC9MNIgUyxv/9niTQ2LhjPxMqaB04gg80s/LhKIlJaNZi
 xm1hP63PnO5q4O6loCZK7YLlOVZ385hvK1RuPHHbeByAR5yMqTCZ7fc4/vY4Jv6nc7TP
 uI1rLe8VDSzHikSgUT5vaLMii3wFGc2RQgQcXrkC8BB3wFdhWaqzLQABTt2VsNj6FbMI
 BU3qAXKeOI/kC//teg9UxD65NFC9TJIlxq4uDXaN0RObX1qnqMXHnipVZhZUDVsYo15r
 96OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707904513; x=1708509313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VkOtaXDOOimXObWIFaRUDXcIU8kwUzNJXHOa9AuC1s8=;
 b=UXmDDVFnM9OPS7aVMShmN2zgotk3gPoRjLhoi4KplpEJSC7X18PFytKTiCA1M56iZX
 IKPXO8A36goJD0uygquhejDGvUJnJdL0cFDlPgLuOq2b20M9e+oviQEgj1mTSTe4I2S/
 ySD1reViLdsBz7vIQqJ9RaGVdTDeO5PDtE0LbSvqDJpwrFTHuHP46fbfq++dDNU2dsh2
 4x2JzcYo6TxNy2jwE13JeJcR238+HbijFm5i6qzIomsX4MuJhonPdx/HcN00ShzcEAbO
 d6W64mxM4TBtQsOOIPJ5JlGoMzVpKrd4tfqk0soFurlkC4+dqSpq4daLUFzZhQAhqoXy
 k0AQ==
X-Gm-Message-State: AOJu0YwX49fh47SZeXQBiwhHCz4yRBZ0aNCofMlHmASqfXUNnqKko2t0
 LGW4h1EUfH8PVepBqF+KiVUR7RD1VrGV98/9FVbO6EfMLBViqHo6P96JzWbrhGOTLoF1zJFm2VQ
 q
X-Google-Smtp-Source: AGHT+IH40BGDsq7PiX6hELZeI3vg2JghFSyDSj0Z2xe21GQ/FSxV5cDaTf0RI6nnYFZzI/mQ4sfD0A==
X-Received: by 2002:a05:600c:1549:b0:410:6cba:81bd with SMTP id
 f9-20020a05600c154900b004106cba81bdmr1721426wmg.30.1707904512834; 
 Wed, 14 Feb 2024 01:55:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDmGAv1/Eui2VLdzM0TBK+D8BlllDvlBcRAUXYq8RQ8cHm4WNVF1XdGTVlnf4dzO0h5o/TH28b8oLxt9r06ScchBalKQT6BjxuHpmwKCUpTCTdheuC98PxprlhpZWFgI/k8wceM2Q0rKTUeWcvk1vAzwj54Uoe7LHQY6yxpPVRWOyX7no0cAcl2U=
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 ch16-20020a5d5d10000000b0033b58cbf3ebsm11983381wrb.26.2024.02.14.01.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 01:55:12 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: dsimic@manjaro.org, andre.przywara@arm.com,
 Shantur Rathore <i@shantur.com>, Hector Martin <marcan@marcan.st>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
Date: Wed, 14 Feb 2024 09:54:03 +0000
Message-Id: <20240214095403.53051-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Additional testing of the changes introduced in commit 33e06dcbe57a "common:
usb-hub: Reset hub port before scanning") revealed that some USB 2.0 and 3.0
flash drives didn't work in U-Boot on some Allwinner SoCs that support USB
2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.0
flash drives failed to be detected and work on an OrangePi Zero 3, based on
the Allwinner H616 SoC that supports USB 2.0 only, while the same USB flash
drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC that
supports both USB 2.0 and USB 3.0 interfaces.

The USB ID of the above-mentioned USB 3.0 flash drive that failed to work is
1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 32 GB
in size and sold under the PNY brand.  The mentioned USB 2.0 drive is some
inexpensive no-name drive with an invalid USB ID.

Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
resets, has been tested to work as expected, resolving the identified issues
on the Allwinner H616, while not introducing any new issues on other tested
Allwinner SoCs.  Thus, let's fix it that way.

According to the USB 3.0 specification, resetting a USB 3.0 port is required
when an attached USB device transitions between different states, such as
when it resumes from suspend.  Though, the Linux kernel performs additional
USB 3.0 port resets upon initial USB device attachment, as visible in commit
07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the kernel
source, to ensure proper state of the USB 3.0 hub port and proper USB mode
negotiation during the initial USB device attachment and enumeration.

These additional types of USB port resets don't exist for USB 2.0 hubs,
according the USB 2.0 specification.  The resets seem to be added to the USB
3.0 specification as part of the port and device mode negotiation.

The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible in
commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm reset.")
in the kernel source.  The check for SuperSpeed hubs is performed in a way
that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as well,
which hopefully makes it future proof.

Fixes: commit 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")

Link:
https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
Link:
https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.manchester.arm.com/T/#u

Signed-off-by: Shantur Rathore <i@shantur.com>
Helped-by: Dragan Simic <dsimic@manjaro.org>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>

---

(no changes since v1)

 common/usb_hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 3fb7e14d10..2e054eb935 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
 
 	debug("enabling power on all ports\n");
 	for (i = 0; i < dev->maxchild; i++) {
-		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
-		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+		if (usb_hub_is_superspeed(dev)) {
+			usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
+			debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+		}
 		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
 		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
 	}
-- 
2.40.1

