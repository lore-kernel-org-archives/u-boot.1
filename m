Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F83ECD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 11:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572DA84833;
	Wed, 17 Jun 2026 13:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mVDvMbZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B98848D8; Wed, 17 Jun 2026 13:14:56 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB84846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 13:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A064843B3E;
 Wed, 17 Jun 2026 11:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045441F000E9;
 Wed, 17 Jun 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781694892;
 bh=vSkSUQCBSmR/Nwdd4mrEpAAN4OqJSL3bSiIFZD8fLrE=;
 h=From:Date:Subject:To:Cc;
 b=mVDvMbZPYH8/g9QpCqhoxmyN/hs8hXx5ahqYD4SSa/0Tm6r/2Ws0oyYOg1P03dF0t
 up2f7Y4MII9KyIX/j1iLJI0qdGOrXFoAFC9BuF8Hsx1mRNwGJyMribK9NkH3NZGh7y
 Y91LJKVlgmOMZmhkJA+RWi+4XY/pY83hE7sJkp99wsSKU4ovIH8UpugyLtl8dB0XIw
 hXsjQ0IRwckvSxhAhv90eS21dMn5YoX3TUzQcHJiEn192vMMs7J10dTbreWlf4s46O
 ECbXz8x7dwI1Lunydpg9t7YKvrDqid74vcHwblV55sl4y31f0UdLt7PS6nq0ql4lde
 v8oy3j+nF0sWQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 17 Jun 2026 13:14:48 +0200
Subject: [PATCH v2] usb: gadget: f_mass_storage: Disable eps during disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2hoGEcSV/2FYlHaA8dGaDhAN4
 d8tuHZ5knPPnUEoMAmckxkCTSzsXYRsl4DptetIsY0MWZoVaYGlGp+iLIvxzpEZlD0dqsZgqfP
 SQhy9ArX83oLX+scyNreorpXV6FkGHz7b44Sr9zc+oUKlj21bpYg2r/TlTsHRY+9DB/WyLF8zF
 2AEvwAAAA==
X-Change-ID: 20260617-ums-disconnect-d839bc17a47d
To: Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=69syM2wctifWqp5CsLe3UAt06r1K5T9/u81p0RQsBHk=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBqMoGpHHJmOL0nRlY5sZpx0zZPtgfSgGK0BrFSD
 nrL4+cAIluJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCajKBqQAKCRAZDR20Zk4Z
 Ne5PB/9HPbtThrCcJaNiR3/4UkGy+ARfZas3kS77Nakc1E9iWs+CujhkZJFCtcT6z2Kh/u59zz+
 quDf6fJ2bFz1T9gwhujAVuzTpTcwyTyMgAPd+yVqHrxE7BrW01xSlA6H+BUaieluaxGIyF4IWT9
 g8mQ4Mk1043FhROffSDd27RnZhZ300lODt4AcXlRQs/pzBCtBTN4u+VetftrcLNwVHVrv6o5IEd
 dPRPr6SBcf/jxIvWSG+sMYKOM2btThH7Ep6+8rCF4FgIdISJLScLDChcWFEc5d8k1vK6kb/URqr
 X9EU2YXZWAK8Ou98IzahhF5w7t7/P2ktTZzCVfrme9rgSvxa
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
Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This was initially reported by Patrice Chotard at:
https://lore.kernel.org/all/20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com/

That thread contains reproduction steps.
---
Changes in v2:
- Add missing Reported-by to commit message
- Link to v1: https://patch.msgid.link/20260617-ums-disconnect-v1-1-a5ff9011d49a@kernel.org
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

