Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7ADCD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 13:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E838341A;
	Tue, 12 May 2026 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="wyfwFzPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA578836AC; Tue, 12 May 2026 15:55:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFCF803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48374014a77so51224715e9.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778594134; x=1779198934; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qcMJTrL0M1Cpkn6R37EbAiiL8Qk0CKhYLfZWPNEeai8=;
 b=wyfwFzPC4/1+kXj2A0kJcomAKPYxb5Vjh7ndN5OrDnb/GdS0YMGhtvjmVDoSKLxAuw
 ggPFP+UK0BYRz9q6if6KASFxBdF7yo1tl7eKSwOdSfq8GEEEZDhTjqxNE8KXthxtg19K
 Y/iCAXjnj7fFl7XMYJxNgtsO1wuPZn6m5arSGBylVZUjYjsfxyWkZP2GzU49lXOVfxce
 1lGZ2DLiiFOIfJlh7VMPKmT8gLFhV4p8A1xygr8hSUdw1Vgw+XzKfHgAg42NAJyY+Gaq
 celIjePAAaDHDaVuGOCndgVYE9O79c7k14Zre100tcb+HogwymCR4trpxMkMidff2YAV
 OX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778594134; x=1779198934;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcMJTrL0M1Cpkn6R37EbAiiL8Qk0CKhYLfZWPNEeai8=;
 b=FOtxkUU2l3AELPx+GDbv0jVQN8QlhGqaE5jdcHkFMoM/K3uSuMbwa0963ShH8NHOus
 aKXXGIJJdhIYxtiCJAv1mUbbhytyTEOr46NSgP7q9uPDon8rAlLXAoyiDyq2IBBhDwbF
 9EJotC7CEt0X7A1XgwQbNwTeX9Hrm40Xg/4fKeYdkOcppZYdrxzEtH7jMZ6vLlxRW5Ls
 qqH3iv7dfb5AJ7uF72ogLss6zbMJuimY6x82gav5jJQRhN/V4ba26C1NSU5UTS6BqRSB
 /MAximOCBv/k3/J3RKTefHOrsPuQDQCVmtgwzbrtQOKuWb2UPmUwW0JhvrKqo2NpxI5B
 Gm1g==
X-Gm-Message-State: AOJu0YxIe96Cp88B23IZS02xFoxx/BqWeulkCzh9XWkWi5op+DKtHerl
 6l10PIoiolKpuxxKzqY/7QNyK+28ZjumK4YXwUMgFyqH/78uoMcLp4ej/4sDj5pnf8U=
X-Gm-Gg: Acq92OHdXuVY25zk8NqXigNqvCYh+tDqF47i6Hvzm+XUsYYINkyDH5mrEuIuJrLqhE1
 GFMq5TvwLeP389idpJzY1L1xNJiJHLN5dR2BAZWFIi/K/qPBWfLv8ZJNgBnu4bNrHl10bD+jX39
 C/Dq8OyVEZFMzPkMz+uXVmA16WQPqdSH9fbGbwY7DimKblM/LJeCz6XoGUveqryDsP7WFYHHcxw
 gDSQYpF/1vMnJ4b5WVliTS4JySoRqSeT8ooEqfxfeHMcNzFg+yXWogWbO5pelPPKTIYdb9wzUes
 ekfamucpGv//OFXW/nVgzQKqvl6GjBoURiadxpHlhzRvOlyhXVXBY8X1G1Cvbg5Q/KSLGaEac0k
 rlC7xnFdKrY56EfOlbTvBTsEiM8aaSiaeLutKXn3C8c/1TCp8vKpa0KTvP6gO/P+yoQnoNQue4v
 EeovX8OR3mwr1UUs2iejETRVZ07tLM+85GpFDFIPp6Ce5oba9xZ2ewhRR73agh3qVfRpAT17JfM
 trDXn3n
X-Received: by 2002:a05:600c:34cf:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48e706f35dfmr236125585e9.16.1778594133928; 
 Tue, 12 May 2026 06:55:33 -0700 (PDT)
Received: from alchark-surface.localdomain
 (bba-83-110-135-253.alshamil.net.ae. [83.110.135.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908d2c0esm43854865e9.13.2026.05.12.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:55:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 17:55:28 +0400
Subject: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
X-B4-Tracking: v=1; b=H4sIAE8xA2oC/2XMQQ6DIBCF4auYWZeGoWLBVe/RuCA41kkMGjCkj
 eHupW67/F9evgMSRaYEfXNApMyJ11BDXRrwswsvEjzWBiVVJzUqkZbu1qIY78YaZ6z2LUE9b5E
 mfp/Qc6g9c9rX+DndjL/1j8goUCiD1nm0JLV8TAtvG8VroB2GUsoX1Pwdtp4AAAA=
X-Change-ID: 20260512-sl6341-d7898a895c4e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Michal Simek <michal.simek@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=alchark@flipper.net;
 h=from:subject:message-id; bh=UJIDPBx0NYBvlMCrS4LZZ68m4BMw3sxUCuJGWcIEXQQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQxGwabzo6IeDM3gVnx+dQPKzetCylpz8oSUcz4slafP
 c6VV8OzYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKnmZ2dkuLSJT/BsqqjOmdfe5UF29rPnZB59c1ovyPUyR2Gy4rfOawz/YypZzsh
 Pi37kYnymacuXWcfb4tensXjd7ZCp3iZ4N28CKwA=
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

Corechips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
requires external 1V1 power and can optionally use external 3V3 power
(or alternatively it has a 5V->3V3 LDO built in to derive 3V3 power from
VBUS). It also exposes a reset pin.

Device tree bindings are merged for upstream release with Linux 7.1 as
commit bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0
hub controller") [1]

Link: https://github.com/torvalds/linux/commit/bfcb86e58f3a58d05b95970d81b94cb011982780 [1]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Fixed the comment to correctly indicate the USB 3.0 entry
- Added an upstream commit reference for the DT binding
- V for volts in captials (commit message, thanks Marek)
- Reordered the compatibles by lexical order, not hex order (thanks Marek)
- Link to v1: https://lore.kernel.org/r/20260512-sl6341-v1-1-2819ac19e050@flipper.net
---
 common/usb_onboard_hub.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6fc34489a98f..0684f7bfd479 100644
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
@@ -285,7 +291,13 @@ static const struct onboard_hub_data usbhx3_data = {
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
+	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
+		.data = (ulong)&corechips_sl6341_data,
+	}, {
+		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 3.0 */
+		.data = (ulong)&corechips_sl6341_data,
+	}, {
+		.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
 	}, {
 		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-sl6341-d7898a895c4e

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

