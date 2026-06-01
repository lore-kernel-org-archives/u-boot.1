Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54085CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE2584951;
	Mon,  1 Jun 2026 14:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EHwTZgnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6153084701; Mon,  1 Jun 2026 10:13:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B4484859
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A662C438DA;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88A2CC2BCF4;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301572;
 bh=7KxpVoSe7khk/L86mEnqSmP4k8Xgx1YhiUKjqbOaIsY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EHwTZgnR/KLaY4/E+t0Q6ke4QXv6MkVMkiB5enCfVjjLINwY3UIeTwA7zsZA7MC3B
 kYOdu9XwMVHFHJVh8yoZ4TwBbtk4IJL0i1CfvjnMhUW0fjQs15EERV2Es2Dwz77sew
 P0VhE7dDaEt5B48Xy/aPiXJByyn7ofQDUg2QFRQxwOu6Q36iN54ymdm99PeBtkYYNK
 ceV4fpS2B13/JVSzLb39qxVoLKgjhJ3bC2GhVa5QWN0OZjsq71eRt6szLz/ZO2q8x3
 cT+jzdl/byO1iIaIFDPqNyGxDU2+y1u92s2+KZ/+ELuzbi9j8E3OmieC+ISYYeasps
 sRrvDxV2W+K8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 809F6CD5BD1;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:50 +1000
Subject: [PATCH RESEND 09/16] sysreset: qcom-pshold: offset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-9-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=1203;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=TxwSM2ajegUQsXtmSlBraUNkwazoTxuWpd5kLnaPIW4=;
 b=PvIFJ2cP06HF8dG74yIJlHZZfnGq+ruzycAEVRimICDzK8fCsnUZ/1aSkEs/t03wllajqeXGq
 tVCPEzr/9XRBimT+snkTmCY7DaKOZhG8/kw6aGvhc0zH5WJsEhb9C76
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

On older SoCs (such as MSM8960/MSM8930), PS_HOLD is exposed through
the TLMM aperture. To prepare for that use-case, this driver is updated
to accept arbitrary offsets from regbase.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/sysreset/sysreset_qcom-pshold.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
index 45290478536..f8be1f2f593 100644
--- a/drivers/sysreset/sysreset_qcom-pshold.c
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -10,6 +10,7 @@
  */
 
 #include <dm.h>
+#include <errno.h>
 #include <sysreset.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -35,9 +36,15 @@ static struct sysreset_ops qcom_pshold_ops = {
 static int qcom_pshold_probe(struct udevice *dev)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
+	ulong offset = dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr(dev);
-	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->base += offset;
+
+	return 0;
 }
 
 static const struct udevice_id qcom_pshold_ids[] = {

-- 
2.54.0


