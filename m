Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FE6C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F063660796;
	Tue,  1 Sep 2026 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8KuDYfZVwE6; Tue,  1 Sep 2026 14:39:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273546;
	bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nRZc3+hogfaPe7mU64pZZ/CkdLhvCBCp82D4EJXEjsc4sDjAlr5Eh85HqfsORWH1J
	 xXifbhCv3Kx1Nu+VhVr/oQN5WnsmwR1JKzGOvYektHqkjCnVGC+dbyX0aeHf5KGV8s
	 W6pDQMXFzwtoDXjgQV0A0LxM+FhmGtN9B2Mns99ymNE+5JFr9u5/Xq+gQKn5AoCRRv
	 1YYhUEJ2OWOe0jeUJlaMs4vGBg727B++lAzLiFT5KqcGXGcVRqyFyUp+PpZ07JK5L9
	 4SiAtJMmC9zjewARZxGkGKV9GoUV3PXf46dywk9LqR6HZMrovNGWU0FeITB7mH/w5E
	 K/2w0ThtM7mAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 265536077B;
	Tue,  1 Sep 2026 14:39:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6807279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D07F401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkYXfQxkW48K for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=R3eO/MJc
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92991401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso34969765e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273536; x=1788878336;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
 b=R3eO/MJcPPFmgmQSAZmioNU9MPqTG2hZhIgllS/yHXPCkTvqPPrfhHxLSv+mXp62Nc
 Q/uB+J6GQ4Y7afsYmUOqq9kVx1c0woPdE7pKiJhhDQ0fc+lDDQm8utHZlVxd7nEck8Ac
 02BgRjn/x1N8BTiUnyrVR4vsU/KZgp6xyGGh3XfiTxD5ZeE9a3I2N4r/xIIXRnEup4fD
 Q7ir2Vw7G9DKmWPJNxddFdsfrWNgRowZ90KeY5kjViixOOckfuB9Avf/eSMkVBVa1sF8
 3NTV8RLrAzOni7sm52hY9lytxsx52zjTH1D42BPksHtUlZWHEqy/h1bXEZTdPXQa6ZqB
 6UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273536; x=1788878336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
 b=IKJjs8udAXXH9TU4jjsJ3pnlEQH05//d6+4hgp4gP3d71wPOzd8cgTqVYMipK0NZVM
 JqI4DRnJS9AU+/Bi1OfUApwCHlyKigUYIhkeeoSqSHk0gk98vVb+uVgWWfNbeE3szSDl
 DNRJmaI3KAkApn7PSZZnxBPpL2ZViQse/XUsu7NJvG5tkkh1VPFJagfkkHw8Rw1e7X2p
 bUlfjtQMWoFrXLsLfXkkxQD17n8KBsZeb7A+bccY59ng18ooG7gM3HmH3rz8xDKblNbX
 pyENmY+q8UjX2005WGZ2u5k0hfNqhm7fWeOKQ/ZHIlKf8/Iu5F1QzAnWCKOVsLLgKYPO
 RDfw==
X-Gm-Message-State: AFuF++lJqhJiVNdOdG20yGi6vnI1zfWWzO74i7iDbIKRAi8S6xfzcHkh
 xc6EW/Ewo23uDafLOLjMEljhw8HUWRfDX8UYWxJbuiNdsYfw+/VyaEyLhlCQ2ZCwFTY=
X-Gm-Gg: AR+sD11w1CvEOPJTcjB/ePq/+eWFZnIxgLACh7xQHkEOpfwOFNxq95H2hHIzj0HBvM1
 2mrTBML5JVRMlDbuH04eBYwdw4DEptbpkIoFIqi4bWGhDI/RaPhJgMufGzzD7WpOEUShfMGinEw
 thSrBAkv2IL82DRxAuBRxahjEeqNCGbuUwKb1saFzi6K4jwaKqC4enN1uVJa3EPzYBznFGYe88c
 wibCyH4spwATAC2roDOIUJya4LdbTzCXuOVEXLKwPTVMfXPKE7Dt1GvOz3cbKvqmWAyPxfR44IB
 4t5eCX4FckI0q5mj2oFDzPnoTWdphEvv7wb26MuhMY/4/+Oz25NvFmAnxaYhhXyP2wBYoDYiyC3
 UPGQHAwW05G6th45fffw4ws3swo+xZu3rnoQsXxw2FXOOae9jvzp7g6EmWFFfB0tdHbJhVWaLMr
 Zxb9qSpSJlK35E0ezBL2LDEEQBCetKiTQ/P/2VH1w+rjIDeudiSgz5Rycf1/6XXwLoU/GoJeQN5
 4eWcZpjfULuGv6akUNLhLBVJLzjcK8XE4gQBGy7McXQz8/mmBeAH+vR5T/ywl7p1SZOYeM+KEqv
 up628BO3/xLxWiDDPr06/K4CNlEKCb9kg0OqZe8ky4S0
X-Received: by 2002:a05:600c:4e44:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49cdca2ac80mr146681345e9.2.1788273535776; 
 Tue, 01 Sep 2026 07:38:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:56 +0200
Subject: [PATCH v3 10/14] include: linux/hdmi.h: add HDMI colorspace and
 colorimetry enums
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-10-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
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
 include/linux/hdmi.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
new file mode 100644
index 00000000000..6e4828eb192
--- /dev/null
+++ b/include/linux/hdmi.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Partial port of Linux' include/linux/hdmi.h, carrying the pieces of the
+ * HDMI specification that are common to all HDMI transmitters.
+ *
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
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
2.55.0

