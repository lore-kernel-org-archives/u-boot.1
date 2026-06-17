Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1419CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 11:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25C584833;
	Wed, 17 Jun 2026 13:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZGkKPyHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE03D848A2; Wed, 17 Jun 2026 13:11:25 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED62846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 13:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8770C42A00;
 Wed, 17 Jun 2026 11:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC4E1F00A3A;
 Wed, 17 Jun 2026 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781694681;
 bh=2slyPIJzXNXmnNjoidP3VsBC6+157OtdUrY9pDuKZyk=;
 h=From:Date:Subject:To:Cc;
 b=ZGkKPyHbQTTRj7WIHV8cyxWrU1vyj+75FWmvUyF3I7PFT0Iy8dQKQcTDyMX00GtWX
 K6umsgWSCBL+4oSaKIDWPYlZ+tw9BBy2zj+R/RL5AjO3WL9kfXctv62L1XB3MFpG8u
 G88DBviC/ZzU6uAESZqOOS5zWZw1EmnQXcDoBbjhCGa9P2yWnLY9ncFDgnb4DGGPHh
 8ABAkhCpw/HjX/cUiryb9OC0ehygkiADQqUHs+W5hAYf3Icn0UVZ8tfMyr6qo30Vun
 aDSfbl44rIp1kU4YFQOHTKyenflVBbJ5bQw34gpFG/CnA0p9khxF3iYD8kBd6wTlnV
 DOxOJe/6CAvDA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 17 Jun 2026 13:11:15 +0200
Subject: [PATCH] usb: gadget: f_mass_storage: Disable eps during disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ums-disconnect-v1-1-a5ff9011d49a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVRRHEVsah2MBIlHUQi7q5Yf
 sl7/wWMnpChji7weBDT4gJkHIEZtRtQkA2GNEmLpJBK7DMLS2wW59BswpZZ1RmpdK4shNPqsaf
 zCzbtb967KUzfCtz3A5fhA41yAAAA
X-Change-ID: 20260617-ums-disconnect-d839bc17a47d
To: Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=/1wyU1pIH1mv65eHQdZT5DxCOirZ+PrjpDIvcEq3nEY=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBqMoDWMkMzpWR99NNagbu2mZt4YcHrnW47WwmwY
 KAmyBzhlxqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCajKA1gAKCRAZDR20Zk4Z
 NeKMB/966/HOs8HvkyVoHs6wXXKdoWSYpx0igiD0KCwqulr+4VzPeD+gchxs9H5IF+s1hC3BNZi
 Mm1QG6M1n2N/4rzRQbdNGCLVxFeb9wY1/ku0o+i7v1vdkhR4NKy/1C7ovOBl6/9sA5cunclJci5
 5XTiT0BubHwjeeepxni0AsRYoB4+VnqIVWLGax7QJyjsIz9TVV5BRRMmLY88Jj1dhhVIGSYCIQH
 uQCnkqcrDrhixEtV7gi4rcaonTCpZrzKGkb2txVa+0F2XEiVDgfdrKz3fz8fzV2pAy1UwhKi4x+
 /g4O++uipeKC8JhZUAi6cwu3gmKmuTXmvRsksX1czMTn+Tvr
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

When trying two ums commands in a row, the second one no longer
enumerates properly from the host.

This happens since commit
59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
causing usb_ep_enable() to return early when ep->enabled is already set.

Gadget function drivers (such as f_fastboot or f_mass_storage) implement
a disable() function which is called whenever we are done using the
gadget.

Because f_mass_storage driver does not disable the endpoints,
ep->enabled will never be set to false again.

This can be reproduced on the STM32MP157C-DK2 or the Khadas VIM3 boards.

Add calls to usb_ep_disable() as done in linux [1] to fix this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fff139aeb11186fd8e75860c959c86cb43ab2f6

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This was initially reported by Patrice Chotard at:
https://lore.kernel.org/all/20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com/

That thread contains reproduction steps.
---
 drivers/usb/gadget/f_mass_storage.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 71dc58da3f03..87ed25e8bb3a 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2275,6 +2275,17 @@ static int fsg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 static void fsg_disable(struct usb_function *f)
 {
 	struct fsg_dev *fsg = fsg_from_func(f);
+
+	/* Disable the endpoints */
+	if (fsg->bulk_in_enabled) {
+		usb_ep_disable(fsg->bulk_in);
+		fsg->bulk_in_enabled = 0;
+	}
+	if (fsg->bulk_out_enabled) {
+		usb_ep_disable(fsg->bulk_out);
+		fsg->bulk_out_enabled = 0;
+	}
+
 	fsg->common->new_fsg = NULL;
 	raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE);
 }

---
base-commit: a7830e87555abfb81cc69275cecb2bc0fbde5b28
change-id: 20260617-ums-disconnect-d839bc17a47d

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

