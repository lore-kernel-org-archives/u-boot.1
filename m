Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4480ACD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F8080398;
	Tue, 12 May 2026 11:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="NIzl48cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BDE8341A; Tue, 12 May 2026 11:41:23 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79991801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so3136381f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778578880; x=1779183680; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pQq0eDUtxdIUjFwaO2hk3BpYL+U7uGdG26UE+viWgSI=;
 b=NIzl48clNI7m31l4SMf0zMJyMJ4v3isBGhGzZAR6tKOJjKrAA6t79SbCjs6P/esA3v
 L1o6CAx1W1qT7vNaLPH/uvMZGODG8a6zT0LxewS6sIQY7kKDXWaiYTCMEhvg9GZ5JYaQ
 jqotlSnu3TIdf9Qx2PnmW5AOwVmv5YZ5FMgovwuuBwHSjDdiDo2S5tsVN9DvXHIjd3Vf
 nYUaHUhs5M7tpYYqD7DVZYNCoTO4j5AUcRcXxhR1O5ca9T5gSw/nmQl65PLAkpDCqmZN
 zFUldFsOz1SQKWGyGVGaNAEox7T5RXBtnLiNE5WaP8KWSdXQIGPB06fs+3U1F8DW97wf
 0Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578880; x=1779183680;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQq0eDUtxdIUjFwaO2hk3BpYL+U7uGdG26UE+viWgSI=;
 b=rWKRgUHmYS17c/AZE0zNxP5jXCH2R0rHFvrgLw3Nv2oOFDLTGDrO3slo31QuaR3EqC
 3MmVHzC1bTLjo1+JfCxxzEF/kk0itMheRTVmtJPWF785VHVuJQeYMzZGJDgUlvsDcPCP
 cyZbjv+LbTncwVLXKkYK7pj/AhPVshaqMfriMmXYzlH5UcRBsCtstcw5lFu2gu1GhCAq
 VgX3S3XZtEzmqCzo8EM1nTHOrnnk1AmbcQEkYGznLOpwTvY5O9koErab+8QinizxQa2v
 X3PhKMz0ldLqXLmzxvNabLtCc+gelhBEkjMBu/76l/3WPL8NFgkI6g2mJLtZFlRejd9D
 NJcw==
X-Gm-Message-State: AOJu0YyWyCWrvCuQyyEl8+rni33ny8fxFWRzO+tHMtaN7kuE3RRZapcB
 pA3I41cMhrc3SyAWeKRHkovYSmg/VFvfLSytdcEzYm04iw9NaIClAno4Cn//W3xdAcz6cOVM4am
 BrFgZNb4=
X-Gm-Gg: Acq92OFXu2CrWBqiIpoCc6KUip/bIQ8eMDHai08x4r1amn+z+dnro/Y3eHYGtCXDNI/
 FeTJPsh+sDtWkYPpm/reJG8YlMuNBSardMsTOoB7d4EpAW0PRhdFN2zCONUprTVtnX3j3Vj/SW+
 wdNyvAbKdRXNwUJ1fLay0q6MA2qxpWCKwYSYqVWWI9BOa9/Mi9bxjta90a5AAEtPDxf/Om92nWc
 RTailzyfwdqMwRLb3JB1ANyAlIfMSbRdg42rI9g7cXfZj4rY0jbdwBcRddnFY4LazC9SeP/3UsT
 c4imYdsTvCz5iXQFOv1CBHgmpX5cwsTNw7SBdwRh1q/U+LJGIoFmzS++U/+mtxdAAxVYHotTwGE
 NbmZ+x10T74Pchv51d0p6tE4QqmX92VkV03nPlM9/jBqlbivX9/jvfXRbNdZsygLQVgYoPYsSYT
 73xVD5O4WwDtt9sW5N49SLmyPOJFLkbmf4AlZxOQqLBU0yZ5ANxXe1ChOp4OVI/A8yUieBNwpuR
 uASOqnj
X-Received: by 2002:a05:6000:25c2:b0:448:5ec1:dcb5 with SMTP id
 ffacd0b85a97d-45460e3f48cmr25770059f8f.7.1778578879598; 
 Tue, 12 May 2026 02:41:19 -0700 (PDT)
Received: from alchark-surface.localdomain
 (bba-83-110-135-253.alshamil.net.ae. [83.110.135.253])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491ca383asm30825045f8f.28.2026.05.12.02.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:41:19 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 13:41:04 +0400
Subject: [PATCH] usb: onboard-hub: Add support for CoreChips SL6341
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
X-B4-Tracking: v=1; b=H4sIALD1AmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Mj3eIcM2MTQ90UcwtLi0QLS9Nkk1QloOKCotS0zAqwQdGxtbUA9eC
 hdVgAAAA=
X-Change-ID: 20260512-sl6341-d7898a895c4e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Michal Simek <michal.simek@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=alchark@flipper.net;
 h=from:subject:message-id; bh=hBTCXlKDozXQ7+2ZLJylawazZQtYzEGhk3ARVw5RNzw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQxfd3/+O6qM51rre4unGfbnuMx69zs56WfHjpLJs82O
 mj9o7zcqWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpbl3C8D/t0euTmU4xXDMsTnRxzlmca7ZyVotbTaxKvcbNybUiyQcY/juLP91
 c8q81SOPFbZfQKsngyk6HCgHb24bHN71aIt5gxAUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

CoreChips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
requires external 1v1 power and can optionally use external 3v3 power
(or alternatively it has a 5v->3v3 LDO built in to derive 3v3 power from
VBUS). It also exposes a reset pin.

Device tree bindings are queued up for upstream release with Linux 7.1

Link: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/corechips%2Csl6341.yaml
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/usb_onboard_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6fc34489a98f..d15d7bbff87d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data corechips_sl6341_data = {
+	.reset_us = 10000,
+	.num_supplies = 2,
+	.supply_names = { "vdd1v1-supply", "vdd3v3-supply" },
+};
+
 static const struct onboard_hub_data usb2514_data = {
 	.power_on_delay_us = 500,
 	.reset_us = 1,
@@ -299,6 +305,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb4b4,6506",	/* Cypress HX3 USB 2.0 */
 		.data = (ulong)&usbhx3_data,
+	}, {
+		.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
+		.data = (ulong)&corechips_sl6341_data,
+	}, {
+		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 2.0 */
+		.data = (ulong)&corechips_sl6341_data,
 	},
 	{ /* sentinel */ }
 };

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-sl6341-d7898a895c4e

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

