Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE17C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A09040707;
	Wed, 26 Aug 2026 13:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFOR--GE7YKn; Wed, 26 Aug 2026 13:09:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749792;
	bh=TiqgM1DBgt18vfJMKylyY1+eROTJuhTN6VmTO82V90c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mv9zvBIbGPWgbRkHqTzB3eekf2CGEpHtjv+V2bEK05aNXEGMZbDd5EiomwZxgMsM1
	 q0TATLoRmOGMcr0+7RQYfwCXBrwPMxwukle6zNBlIeDxxhEbVzxkx9tQiGWJtVLytM
	 vOiE+Pectwk3TdLybdiKvFgewGUyRUpmqBZo48HurIACnukYi4jkCayPc82mQbzXlO
	 Watwiw97dp3ehvF4DSsH9e+Hr/Cyae3dHogRID0dOR7+mkmNOqMZmovhUBmkkhrKs7
	 +9NYOGzcxBHtON1zJZFIdyu4qkzRb2s0ytUzlki5tUBWKBaUkst9X+BkxkiLU6qP6f
	 mSq+h1AAMmORg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C24D0406C2;
	Wed, 26 Aug 2026 13:09:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28BA73C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ACD1400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCiC7kzoVlpV for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LKlgSlbK
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C34464005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-482e2904915so489264f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749783; x=1788354583;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TiqgM1DBgt18vfJMKylyY1+eROTJuhTN6VmTO82V90c=;
 b=LKlgSlbKVZm7eRifBzaae6jNnIlmkVlL52XxVW29Es+5euU/Zs7a/rIXNIabUij9CW
 V6szoV5LQzdIiOghiw5MY/whIVeie64ti0tKrzm8DGkkwh02ELALv80CREEBBZ+nzv+E
 1VX9j5ryHzOhYtxfViCDwJY2zyo97TOWaLab0ETzcHJND2WqIiQUrwmvCiXCU88F9fbR
 TDzIPtTxx6GNOeWryaolA5zQ2+2p70t5FZGMUZRfokQZaK5rgi9NmFjnjz+RdHERfrwC
 74bMzpq8+y7cvj12QbciBBxJi2Ytut/vbABOzvFZDWNnGS49jIYQRqEnV5GXQ35E8KbS
 OTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749783; x=1788354583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TiqgM1DBgt18vfJMKylyY1+eROTJuhTN6VmTO82V90c=;
 b=hplWOHZTy/Wmy3Q+kZMlV9LMDa/eq3qnpvsa+3w8cqaYe4u1imfNQ2858KNSRzoflO
 qA1TaqjU74X3jrE/DXLG7fIsc0Y0vJzUlwRsqAK58At15iyjRX9J6YjgcspR27ED1fc1
 K3FIjU3MBaMBJVTFhF3K1xWLKQIroKwX8roipGJPdYkvTlgxH7HZskuzy7C6qlYw2wz3
 z1AvUl7cTfBBaef+JBOzViWtEtiBKnUwAhUUQF0uyEjFZe32Au4VJCWRLRQMq86e6vn1
 7p91VQRUNqC4XKYexLd5Ymu4Peah8hnrE8J/F8XOzXp881sDef5aTfBx82Yy/bgsVV/2
 k4ww==
X-Gm-Message-State: AFuF++msbRkDspYIJU4hDFcUH0WmUw8FA4ITVJtONyys8US3g9JTrpC2
 zNi7liabIGDvlrGjZ5KbI9IUfGQ5kCE1T76weoWBteJIAzPcS4uKQmdah5QAtdK9E/I=
X-Gm-Gg: AR+sD12tyBouHiNxn9mkJVgdOpLoEfUAXtYiWB/z8urWPu3P4zeazAkRuH0pjxWh/ap
 Y+Z2SDEWnkMwpyf4bpB0nlpTiExA23+7ghqreI+9irBGq9JXyOQFgquduKynQiJHVCmyE1HqJO5
 8EoPDlOreI3TL/m56UPZFZT/D4BzsNKqe6OkowVkLTm+EXovbI/jNG2tFV9vjNEwzMHaR+/3UQE
 kuCvsq0ZezWTaHbqT6Q6s/cYnmj8dl11eJ4lyeUndGHhjdxbi3HvV6dVGRdvSN82dpU9aEo073q
 Xd+5ybLmOY7gQN6t1stwCFuOa/ufupXyyYsJWPah2uUaw2MiKTxU3lClcR4juOS5e2aHoe3Gawa
 vyo8sQ7uDT8NAeVpzukzR0x3OuPUvFo6bYtb0SbMM1ySC7l5dVyul84Zolnn/xV6P0x3yhX2f09
 sxR0aQEWc3oH1LDLdUxdR009OJA7LKGz4SroUaBCb4yVK0yTkJS3H9oVkv4m5GcUagZpqYBv00i
 ktji/r/eZ3B7iMzDzLowspSzrkcyHmTa8g1KPaUdRvjM+flPBWnawv464KJkk2D5cAPDuMmt+/T
 h6cb/2QKMgf6F5lU9/GKxxogvOQeUXgI/DtQ3pwLOZb/I789SjWw1sdy
X-Received: by 2002:a05:6000:22c2:b0:482:e658:bb7f with SMTP id
 ffacd0b85a97d-482e658bdafmr2909253f8f.15.1787749783256; 
 Wed, 26 Aug 2026 06:09:43 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:37 +0200
Subject: [PATCH v2 10/14] include: linux/hdmi.h: add HDMI colorspace and
 colorimetry enums
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-10-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

Import the hdmi_colorspace and hdmi_colorimetry enumerations from Linux'
include/linux/hdmi.h. These describe the AVI InfoFrame colorspace and
colorimetry fields defined by the HDMI specification and are identical
across HDMI transmitters, so keep them in a generic header rather than
duplicating them in each driver.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/linux/hdmi.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
new file mode 100644
index 00000000000..dee862d2a63
--- /dev/null
+++ b/include/linux/hdmi.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Partial port of Linux' include/linux/hdmi.h, carrying the pieces of the
+ * HDMI specification that are common to all HDMI transmitters.
+ *
+ * Copyright (C) 2012 Avionic Design GmbH
+ */
+
+#ifndef __LINUX_HDMI_H_
+#define __LINUX_HDMI_H_
+
+enum hdmi_colorspace {
+	HDMI_COLORSPACE_RGB,
+	HDMI_COLORSPACE_YUV422,
+	HDMI_COLORSPACE_YUV444,
+	HDMI_COLORSPACE_YUV420,
+	HDMI_COLORSPACE_RESERVED4,
+	HDMI_COLORSPACE_RESERVED5,
+	HDMI_COLORSPACE_RESERVED6,
+	HDMI_COLORSPACE_IDO_DEFINED,
+};
+
+enum hdmi_colorimetry {
+	HDMI_COLORIMETRY_NONE,
+	HDMI_COLORIMETRY_ITU_601,
+	HDMI_COLORIMETRY_ITU_709,
+	HDMI_COLORIMETRY_EXTENDED,
+};
+
+#endif /* __LINUX_HDMI_H_ */

-- 
2.54.0

