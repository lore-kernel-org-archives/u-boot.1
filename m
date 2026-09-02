Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03053C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF9A8109F;
	Wed,  2 Sep 2026 14:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hiVvh6DrgAy; Wed,  2 Sep 2026 14:16:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358597;
	bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IYwKVXGag6IUvQY0Cz7eCzCduwP4bFMDYWhE7yORqrPos856KIB71PJehMZV13SQb
	 VD2jIkdAJ2JiRT9bYnAr8gIQfS3il3KejF4k/B8LsYKbwvt9O5QyEzmMl99PxJiTai
	 qMYmgGTU28WJAy39eQLiD49GW1MjQ8mOFNZYlRxAQsDZyqTi018sxqVK07YHWp+1F8
	 PcmCa/OcipkeLSZabsyOSdBmui7eL2Sv548hARJF7aUYFbKAnfL+rV4JD202hHYLBZ
	 nr154rfKDBg5XgoIVjE4U0fSAxc4+DHHBaOAlRcv94i3XRTHDFUxVNPuTu9/+cohrq
	 E6oSE802MWIKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEB4180F89;
	Wed,  2 Sep 2026 14:16:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9066C465
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76310606CF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQMo6eUwyRVg for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i4xBblaO
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91E77606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:35 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso1185844f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358593; x=1788963393;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
 b=i4xBblaOf3BeuYt7JwvthglK/ywGyvB555KrZl785U+xOGeTpBrIvoNa5ZlR7eEuMh
 PdDVLGsML0fM+ScpecvWFT5dlcCeZLopNWbYgT6ouf8mVoEK8wmmQLcrNVhSQ3KpXYcx
 +qdn3a5HU+OG9EqrsR6gHSe8Ssg236A5zUrdhRsyXZx012bUYRt49CDOSI+GoVvo+Afo
 wVldEXQeikdiq37N6QYuFTZs0HGdINwlYfR6Q8zjo8Uq0r+Xxmmx6/9ie+Ihc/nkSJgI
 31Z82dqoSfChxJsCaFaD6LOkDcKcxdfIZzV0wszMAkkGEoLOV+eouhpkUclDpcSXPyuh
 dCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358593; x=1788963393;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eS13Q7dxpUJOaeaBP6rTHcOYtUPH9t8nFE8VoufbCKg=;
 b=rRyjbgRJBOWu4nZ4jqABYVUrv27/xtls16YCdLtCSknEQ5edFFzLxC5HsjAa+P/UYN
 fmdyBynRRls4fSuspJvcb8ouwS9DfoB+bPv6cFh/uWLXv+PLiLgkWBpeMC+clGjn/yQh
 z5C+ejXTQap+sr+eye5Qg/OXUbe0fVF/v3l55aVuXw+J0cY/K81kDFYQaFg7FoqGE2Z4
 lUZS2AFizM7Wxzb8Gp/X9LYTiaeIHJUmDTKLkJuwSzOwp3h/lfRnETBU8CLm+kEct2t/
 wfWe5pqF1eKEDZNIipljxTzUXX0yp6RFK+UWKFi8xzFdV4AgxWS1hipydWBZ1MO+/J3N
 3Rng==
X-Gm-Message-State: AFuF++lRAqH1O0fz2642ob9jCNbx6lXuYXUEBeBHwsykExELQc7YUyS2
 ejnJ5rUBpGntj9NVoRdCTro39oaS7sV5T6nckkTyGTuTISCj6QPGt14fXz7AgiPg/H4=
X-Gm-Gg: AYBFou0TsyxI4vNAVUYDCmDzdhgchkck9xt+66OGl9T3nPso8Jsm6482SxHqGaPEv7A
 /asq/VSd6CkZKUA8FWe/8U13d+fkyvTuzrI1CSmF2aA/APht79JXCtlclHnS0uL1v1Qm4TUCMDh
 5vrrxXxe2uEAmawHu8j33DFM/ss73i1W0DeXGN+jth81Ulwq0SqW4VyzM9184y4rI0G/5D1tjkt
 QDGukIpIGW42fpe3752d+BIdwYJkmGLoEC92LDkDczZx61f3GNUD+7UatpFZRpM34nJHr/ekcx9
 OMTsUc1ayfYWI/nrfiCBoXR3yB+q8hUFva+7G1UhSR9uQKXvOuTG618IYGuNaahp0niU7YTx1BR
 0JaBQ+9dcSDfW/xxXwTrwCaq/i6BovbXyKQqcJHkrOUTyRYcBK7IqmUZNJgBnXrT1CX0yHoJ5ad
 AndopEmWkZPORF90FNJNc9JEcPZtCsAS6ikOFTwslNZOppLgE9as6ZHyZqpmsyj8MkIEdAGruad
 o1HrQIedmGlN9O70hb6g7Y0mNlPaaPSZEwuk30dCmvz+VCbPb+dSkVPkA08JTTsfUTBBd0zDLqk
 aaE3V6ESesFbTHakKi4uRmAHM0TZiCqK0obTd4eu4abH
X-Received: by 2002:a05:6000:250c:b0:484:3310:c4fc with SMTP id
 ffacd0b85a97d-48488f24193mr9852157f8f.23.1788358593095; 
 Wed, 02 Sep 2026 07:16:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:16:00 +0200
Subject: [PATCH v4 10/14] include: linux/hdmi.h: add HDMI colorspace and
 colorimetry enums
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-10-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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

