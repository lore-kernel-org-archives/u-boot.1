Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68082CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002878486D;
	Sat,  6 Jun 2026 10:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lkQBtoQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DDBE8495C; Sat,  6 Jun 2026 10:48:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A237B8495E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 78CDD445D0;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A133C2BCB0;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735671;
 bh=h9A/FItWZRP0QG6TIv5J0iuoFHIKsOult5yTw0ng8gU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lkQBtoQxcMeDPJfsd/AX2ZtAAYaLt2pwNmfg4OliBZpe195yiDIMS1KzwXooOvUpM
 Nyl0blUyl7lokuAcAqUepmIzHpkVe22NRTQWZ+WgS8IekiNdkoGIfsNP5zU89qhVS/
 dn3WD12MCeEbmatDkvBJGY9NHaCLwOD5cPzMFUKVYpffRYt9YKwWY15SRiU98+K2Zv
 QnPWEDffas1IULHEqd33er3u5ogyhNCXk4sYShY2eBICK8Mzou+bvJG2/w/B7O+OYp
 xkrFGReMfmhopXyFPetXffxqlN2F90wvbMJjjU24JvYuXJeKQm5idoQ6JuoU2GeQyy
 D8gl6fHrXoTQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 51D2DCD8C8E;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:40 +1000
Subject: [PATCH 09/11] reboot-mode: reboot method activation support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-9-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=2348;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=d6hNRTcjuOCe5Y5dKLR7z3oIjgEst648gdAhzCuHvx0=;
 b=cIre5IKMI7/rY/2w0xAl/6KcrF4SvOnWmSWpWluTR8AX4BMjvDOqVa5bUJBFruX/fpICOzFzu
 ssSuQwBW74iDb13BTTi2dFPsbqAQu48AsCzeU6yI083HVimWl8OOc8K
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Until now, the reboot-mode uclass didn't wire up a producer path to
allow arbitrary changes to the reboot mode. The current impl only uses
reboot_mode_ops->set to clear the reboot mode once it has been read at
boot-time.

The public API is expanded with a dm_reboot_mode_activate method, which
will instruct the given device to activate a particular reboot mode.

The first producer, `fastboot reboot`, will be introduced in the next
commit.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/reboot-mode/reboot-mode-uclass.c | 18 ++++++++++++++++++
 include/reboot-mode/reboot-mode.h        | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 7cbe02eb4ed..c47d11b681e 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -9,6 +9,24 @@
 #include <exports.h>
 #include <reboot-mode/reboot-mode.h>
 
+int dm_reboot_mode_activate(struct udevice *dev, const char *mode)
+{
+	struct reboot_mode_ops *ops = reboot_mode_get_ops(dev);
+	int i;
+	const struct reboot_mode_uclass_platdata *plat_data =
+		dev_get_uclass_plat(dev);
+
+	if (!ops || !ops->set)
+		return -ENOSYS;
+
+	for (i = 0; i < plat_data->count; i++) {
+		if (!strcmp(plat_data->modes[i].mode_name, mode))
+			return ops->set(dev, plat_data->modes[i].mode_id);
+	}
+
+	return -ENOENT;
+}
+
 int dm_reboot_mode_update(struct udevice *dev)
 {
 	struct reboot_mode_ops *ops = reboot_mode_get_ops(dev);
diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
index 5fbd7c801af..6510141ff89 100644
--- a/include/reboot-mode/reboot-mode.h
+++ b/include/reboot-mode/reboot-mode.h
@@ -53,4 +53,16 @@ struct reboot_mode_ops {
  */
 int dm_reboot_mode_update(struct udevice *dev);
 
+/**
+ * dm_reboot_mode_activate() - activate a reboot mode by name
+ *
+ * This will read the given @dev plat_data for a named mode, and write the
+ * magic value for that mode to the device.
+ *
+ * @dev Device to write reboot magic to
+ * @mode name of the mode to lookup for magic value
+ * Return: 0 on success, -ve on error
+ */
+int dm_reboot_mode_activate(struct udevice *dev, const char *mode);
+
 #endif /* REBOOT_MODE_REBOOT_MODE_H__ */

-- 
2.54.0


