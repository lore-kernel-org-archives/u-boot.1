Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2E3C79F88
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FB6F40BF7;
	Fri,  4 Sep 2026 13:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tASqxgWKOt7T; Fri,  4 Sep 2026 13:50:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 05DEE40BF1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529827;
	b=rSsFZwO3QCJ27zMC9iWsiFhOz6AjpkwLmCEi3wwSmS/qAfa145B5el1pWzK0uRZ+tCbZ
	 5vBNKPqDqutbfV7woddZHgr8lrBrkO2wGvLGZATNv4oqvQsrhpQ9j3T+DZ2WH8ocsk0LA
	 0FHa5ss/xNhkDZ0SJgUjiPi3obYvBvCLcnfFj+Vl/BvOLah+iutdkppxWI9Lcl0Eruip1
	 HmRY2ATh9Ufq9sZoEMrlru6RIw/pdYC7n7Nz/V/UGehrSe8+1rLuPxKtuLp6b9X2iNrNx
	 scSTdxjMie+euzTCArgQMlnKKfTfPd/75nQ26/jPbwheZTw812sBZpeESRFVSInk9eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z42ktJto/chtI5y97oQWgDKhUy7R4QAGVNaS9RVv+yM=;
	b=kHmFo7sK+PEXOOXWGAzszPX3VgyMJzY0mXIO/rj4Ff6+26ylzVXTHqGHzyOorylvYYKq
	 viiRlrR3XUyRLcKLQbiOPA7IEkYpk62Fq3KxRiP5sxSp4z1l7sFx6CVRhr4Eq1Hp51WQp
	 HN6vJw3A/2WGixbtYr8GkeOCoPcCJecN+dIjEwPWzGYFr2kEIMiNXJ9GpUu7Br2vREV3b
	 qBl3wk4s25Ah+Z0JDIbRnLlIX/fGMMB+BLAN50ccfCp+XFYYxn3FEwT/aQREqcQ6Sna2z
	 UZETQ6/nNLVgy6+yoDaFMruuVZ7u/+ZliJ7m1QGXdE73Yq7cE3Q3xy4Ax7mQNLGF26Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529827;
	bh=z42ktJto/chtI5y97oQWgDKhUy7R4QAGVNaS9RVv+yM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QJRA2yvyLOpBwxWo3B3qV7fjrZKOSrGRjANPo66bPS3s2Q5EdczbPp8x5IhV6M9NB
	 9QXEp3TE/CGiNJDG9Q3tWqOpHFU00UBNMVFqNa9fWt2JC6npEllq6a++eCE32TScGh
	 Jku8cvefoifi3V/E94C7z153iVRNTL/Notb/KvB+r63GfiELZu+4VqW6elwkVjD+dJ
	 scTIEv23Lk4ymRLiNW5Gh34f819d4/WSDyCbIe4FUZ5+n1YMJFsmOi3LaVK4bB6+Wp
	 FmGY+IJYNdv0ID/1bowwNbPwlb0gFr5uVu+Y9hw8jo0wBFPQ+pqkAGe1ANIoEXUDTb
	 G14p0NKW9JuzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05DEE40BF1;
	Fri,  4 Sep 2026 13:50:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DCD310E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0423A60BF3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWBM3EZs2jkx for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0A6A260BBD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529818;
 b=Pg9kMjUcpD72VHbbr9dgYDtsmT7BDT0NyM4RvLTzAdvdODssmS3wAgdKR7mRq28c42JK
 0naB09dMA7B9Wu9xLurBJia5KzYa7bdUqL+2yFUP7I4cn3EFp/ysQazrYg/GJWjpNn+ii
 YjQIDGgpu15VGrGRU7aYglbQSZLoMQeee5W70jS9/C399PdRu690FmglnadSH6sYrCAzs
 FttRkYeLoKXxVgNAIJdgBR2SKEbKmD7XE/o5hqdIa9AwEdnZ+u+xoViI+uihviwIQF2K5
 +Y1cyVfhE1EcPjYTlWa5TZPoxNQQhZ93u9LaNfuOAtYhpYQNLJfvRzG99pdDZ5yroOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=z42ktJto/chtI5y97oQWgDKhUy7R4QAGVNaS9RVv+yM=;
 b=as6Hw04bCW/Xy74C8vb9RtDCDxOa6uvs1HSTwn4POpYi7vMh9s15bZOLT5hazQbFLV4t
 pb5YR/LywK5lU9Gk4YpxBiPvVgYw0XWa5xbeHvnSQmBfRChXe1H96bXw3e4rUMy5xJrSQ
 uTRt0a326Cv6RnjxbvQ/k7rpnNj9wukvB+agxbs8WXm6y1HHIcNNTY9GGZHT5OJpjnpAK
 9X1tDXmjMJcU/c/rFtcddkKVhw7NTs6eS4GCeSMzKXUYxGdtpDovm2lwbb98igwP98sNn
 t30Zdb9p7NbVHt27T3ITlJuGR3py/3mPVEy6qO8x1qS5pPwyo0SSZheQ9/XSDxIo/sQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="Bn4/Rztv"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Bn4/Rztv
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A6A260BBD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4858c1c4b4eso387768f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529816; x=1789134616;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z42ktJto/chtI5y97oQWgDKhUy7R4QAGVNaS9RVv+yM=;
 b=Bn4/RztvGaUK7tjGvoRHWRKmvbhaep5xhR3ehXY7GMvJg18sih3heCjL3ragMf4nb0
 LdeP6P4FNnBdlapSF/AgErqChVCrhv79iB24vI2sBJPBdbSFU4/9Pz3uvsTLFz+cQwJS
 IbcFQfFZ/L2O208eiN6wp/d+bdEsmM5i29XiTTZaYo6lOtN1pVuq5xyKLrhjvwvUhpVS
 MoGM4mJrZVwpqZgHQ3xqige91rJ6gYBfoMvRJ+KpZCUtGnOn8Gt3ajUE+KZwrv3IRA5p
 /WAMwj6CylXrGajqDHZZr+3Kma8OA45+Hk1AGp36AWSdaih9amkbfcMKlgjXVzftMpyq
 sGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529816; x=1789134616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z42ktJto/chtI5y97oQWgDKhUy7R4QAGVNaS9RVv+yM=;
 b=I1sZm6M3Iz4KpHzn49L2ENe/RkAOODFOUk3mzwAt1OupU+iQR7eRCH6vQXwiYn2ecM
 ye/n8Hh/lkL2/zJ/PFvjxRrisl2lHc1CyfJX2cgZyVsJhbxQ3iuwKLpGnMCEeiYbr1vr
 mhno06aEIGgzb8FmCbszn9DTMVviyZIp5XLfNqHNaJvmUiDuYDLMeF4woMme1QtJTJta
 bC396jiM81AAbk94esfPtxb1DCVC4hnt0aWCFH42odTF6gv0dnM+gTZCZDSnhnr/jP53
 1/WUf/7ieQOcp6kK2HEUDkadxUs2cIyiwK3Z9r7AfQborsBgjDHAa9a12tJcKhC3brMQ
 bkMQ==
X-Gm-Message-State: AFuF++lB9Q5sUN5z/dF9xOBhgcuKeShC2yJl0eIGkKGr3rsMkf6sD4GH
 QtF3IKKmPCLirnvAqfg/0/IAMMH4XowGxymvuY/I7HUYmlcdCX1xTB1MkF/qTXEobOY=
X-Gm-Gg: AYBFou2qnqNa9uFaYY+oDtCb0PbEHGGb6ATdsUYNNrZ1Ao9rwaYvGOPYwX/OBPcHjDj
 iLkOp21uLZEhsGg3jR/6Nz0ctbmtQJk8NU0c9lg+sziR9Bm83jHinzUoAK40DGjvUmKNRWz/p78
 I7HT8BlmoV39qNXxZadYX7mOuVC0kJjdR0XFXmU9hFkKhfusLvG7RuXxQ9e0tfjYQTjXbmou+S2
 k+Vdr+thUhBjE+WOa/NW9FgACpVHwhhuOXj7TdKGN2NC3PFpQedwO4YhUGk9DQt/YGmWvseCO/X
 /71s++eA2+4gc8tcsznNc4GYJCLlxKg1z0tY5O9nrEc6E0CNXvUagZWf4y63TG7xxa8aIIImk9z
 0so1qH4ZYnDvjSYz04oF8Aj9B8qKlkvx3vpn612Vb/LqQQY0aqbIBzZAiMomxW3jBW8h58SIIO4
 otyu4XTTVvTR49XHpaSoRQaoOZVzu3kUJZM3gAq/h5ENIqBVmYVcSOY/REuACLaduT/6s0+cjpd
 +eoPK2zq0DL9xqgU7J1kzz1AdeamZ4sZbc9h+dR1astTb+z7SmSv+7E9dHQ5FIURs9Dk4nLREh9
 4t3bw7Z+zt1RjHQW/OhYt2FfemqNSurIbYeqtRc0+5KegN1NZ2ddqQ==
X-Received: by 2002:adf:e98e:0:b0:484:41f5:5b0a with SMTP id
 ffacd0b85a97d-485872bf5a9mr6874822f8f.28.1788529815720; 
 Fri, 04 Sep 2026 06:50:15 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:15 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:13 +0200
Subject: [PATCH v5 07/13] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-7-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding.c | 49 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 16 ++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..ffdba561879
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_padding.h"
+
+#define PADDING_CONTROL_REG	0x00
+#define PADDING_BYPASS			BIT(0)
+#define PADDING_ENABLE			BIT(1)
+#define PADDING_PIC_SIZE_REG	0x04
+#define PADDING_H_REG		0x08 /* horizontal */
+#define PADDING_V_REG		0x0c /* vertical */
+#define PADDING_COLOR_REG	0x10
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CONTROL_REG,
+			    PADDING_ENABLE | PADDING_BYPASS);
+
+	/*
+	 * Even in bypass mode all the settings must be cleared to 0 or
+	 * undefined behaviours could happen.
+	 */
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_H_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_V_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_COLOR_REG, 0x0);
+}
+
+static const struct udevice_id mtk_disp_padding_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_padding) = {
+	.name	   = "mtk_disp_padding",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_padding_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_padding.h b/drivers/video/mediatek/mtk_disp_padding.h
new file mode 100644
index 00000000000..f8f0305dfa0
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_PADDING_H
+#define _MTK_DISP_PADDING_H
+
+struct udevice;
+
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif /* _MTK_DISP_PADDING_H */

-- 
2.55.0

