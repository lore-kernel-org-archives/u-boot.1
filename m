Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EE606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZfhdeYNV;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vEV1l6XA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BCBB407A4;
	Wed, 28 Oct 2026 14:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l3fBxrdY3iRu; Wed, 28 Oct 2026 14:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CC8A4081E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198886;
	b=pmtAo9sYdzqDpxfXFd2yZlBNYG1M1n7sCDWvrojq7l/npPU1qH0Mtk5cOS2eef04jiM6
	 gjW9v+OX4h7+HWxEI0SEO5L0zwh/Ffq4lRb6/n7pQfDYZ6tIhSdpG1429UjIrNg6/x8ER
	 zhAHB9dVZ+v4Il6ZpeWzvAt7XnaM1BOI6K7MPhrypuC44W5abQa4iYd/3XcPgatnIoDY1
	 Jex7Y78cZFpdyrtqkNQ0nfEm/cxdv418lYJw5niCtDlRpVX5THxf1yfMj7TgKedLNq36A
	 T9envGQ7sJtTYuwy8Sp48G4tFrQbyKlJ+l6F+GvXlHuRWCHZQxpFBh5DrTiBmVSTHBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PR4RH0TgOp+OIaoUkzOXOnaTIGMZF3wUhu6Yq9QrFEM=;
	b=bTVM0oKM7I7yVua6/iBrTa6V1GihoQR2Oc37S+sXT1F8QsdeAW3U5/XfKCQL9H7o60Ye
	 RbIak8tjnJh8JsjUz+ukAUhKnw4/8OaRhbjovrAay9lNrC9txLOKmxSteYZdGhQWJE5aJ
	 b+naZBYinDfryLbe1vZb3k04xUasJXdePGM2fSGpmOUgpqZSTzLF3252jmQXIBm63gcR/
	 o3WnSCDJeY6HHyZk1Xo0NVbxb9bIeiizVKMsAKxoGb8b829gPngOW95QYmZAMBziBMANr
	 ts4Pnknkbzcy9UESiJ8uG1dZ2b5d7BEoce/9BdFXzcp0tUN5PHL6suPxIqrPGb8gsQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198886;
	bh=PR4RH0TgOp+OIaoUkzOXOnaTIGMZF3wUhu6Yq9QrFEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfhdeYNVB6rrQrE/FtNmFYrWcpuJ8adwMhyF2TCZMmzSWeBMlJAk+2hahbxhhvPWg
	 kuen/TsV9M8va+CGaY7knGBGm51EMrNbMFiqVmmHosL5BiPxoXlsD/XcoIJ68WpkA1
	 /uOKaMkXZ6IYV3RJLZzx0f/ZUsXPW7WHf7nktHOaideMuQg9/+E6DsMsI6YvrFvZGa
	 nNXA+gHevdBhSVzS0EC6AxfFF4WdqdH6/4jscswF5/VLM7+8HyQuv1lIFQ2OA18Lam
	 kLWVlwIOLjJaZPAtdl+Q/R5rZZdzIhjyF674hCHj1SlRNI+FbO8dDou99k0vKHHC9S
	 71+1KQyr2lluA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CC8A4081E;
	Wed, 28 Oct 2026 14:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC774D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30E0180D18
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaK4yMXNziz2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C277980CF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196971;
 b=rAjr/iL0xTzg/4JYDkAhFUv/kOpLGLTaRSJ0c8LYdmzPDQJLpk+DyTdcFdq6rffthIQj
 BEXnVi2mkSxfiRwfgH+o8RVflYAnKsR6xtdybidhavi+MSX+x+5hBjjSZo6ZtICsZInry
 fSiBZKbtnmW+h9KRtNnpyVl5n3FAEq/fJJ6x33T++Y6vziXHjSimySc0qvohToKxd5YTQ
 ZIRskS8twpQCLwTo27zXgJQ8PMlalclKVllzwxbkdueO0I6qC2ZUa6vuwIvm+Asq+K39M
 NCQtPy5jk4sQzCgZJ1MIT3K3Ab35bYrHiWz9OFdzhyhLjrr2WfMfAAy+tUjfLDxNxcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196971;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PR4RH0TgOp+OIaoUkzOXOnaTIGMZF3wUhu6Yq9QrFEM=;
 b=MULnHpuKAPX6wVmKBIym2e4xvh8s+sgWOmto+RDNyq8JYPHpiQPEUX1zw5VNejKNinmn
 Mhn6qsevJqvkE7DcVeiDJZvpsGgT0eI2wDAHDkohXO9ikjM8vo+b+boYVah6SOey8Z5my
 bh3jAQJZR3RRQJcO7335N67OL4IV/cyQS4ssXdaYowsrNvu/buranACcW989V2IkNGTww
 +hLNK892fil/ivYVUBXqCc57nZfwv/503iK3SrL8X1DlUaFXOEFXRt3tjkK01IYO7/06P
 3nods+e+AHb4uMarnls/FVvok89tSuBP24EXE/1YLNwgmL1itoyxJMEccs9Dq9sLMOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vEV1l6XA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vEV1l6XA
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C277980CF0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:10 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c38ac078440so11852266b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196969; x=1793801769;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PR4RH0TgOp+OIaoUkzOXOnaTIGMZF3wUhu6Yq9QrFEM=;
 b=vEV1l6XAtWIrg/14VNWnWPyV/L61m5/+AKzs6NDcb7iXe1RwkrOS/wy+H1FnYov0v6
 d50G0JO5hBOCNtp//pC6ov/FAKwLj2k1rA0ezVEwLKDQWfb/N5Swuq4CwDH5Dq3LASL2
 EkxrE24cE++xwjbNQTYm/jClwAkRzR1cbVE7XB1DmYjQJS+xoNN2/+OBG6WUQWQUainu
 7FX1mG5tY+O853v79MRYOSO+I5Ouo99c2l4MWH3HALQKVdnK/hUtWIi3Ohb6EO4xSMIQ
 KUIY8dCHaMkTDbiiNUrQ+/af3XUlSKRPa167/xfsD+5pL4P0BAG5fxZrJ5UqUFI2V0n1
 YX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196969; x=1793801769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PR4RH0TgOp+OIaoUkzOXOnaTIGMZF3wUhu6Yq9QrFEM=;
 b=ZobYFaIZ4Dbg/HcIco29m9VWsKm+xqbVV3O3F5PDFUR6jDYLWjuMEx7YeugTRZuUPA
 sygdLw+ZzE1g2yp/V4Tj/vbhuhXNqKp+6tSMTJmoA7V0wygY0096gq8SZHzaUJpJ5V28
 UDAlxKx0zZo1YvMcuKMNCvJ2CDLam4/rNxfmTY5MA22cYcGuz3sskgggqrtgjAMoAJY3
 1GrB322YJ1P6+sZScK9Z5RE5jCOLaNhhg1z2FkFk1s+OPFfzl9cHdqOoAh+e+BYAsZgf
 ovYwWACdeENwjy63O93XmES0wtS9pWVoExIIFC5bv/VI2TkI9ULc5TGLOpmHTVo1JAGF
 vAMw==
X-Gm-Message-State: AFq9FYJtDhqhXnKa9fSDpWAAM/YYAcU2nZ76VqGhSDYsZp/ez3/q5Yf2
 34KyNQiHns/2L5L6g1ckhgYZpfRgS4OOTr2tTtjiYHfudgzYe/PPww8zhUDsK6c3Kt5n4otij10
 +c9TZ
X-Gm-Gg: AYBFou03k1ns31hsO9aUOFSb+YBROeLMXSbNxpvb02Xk1mv76gt5+/ykRQe5kJRY/+0
 +LGEK+kjbcGI3fhM7X/K2KINao52N/31Ey6XGdHeW+zAUHBSVDytO8nRMeLtg3Y8VHlBMEc0Kxw
 N22M36cZZj21BA1voqEqqr7LAakEISTn9XL/Ym1qMmcG4bPySnW7KkpngLRYMsz8563xljcSNp+
 cFMytlL1ob40DzbDgvzFHtP+R5K+ohpcGE831YD4Nj/4tlHvHhXKuMhcd3uRbSQp8qyE8zBOImC
 b3wqZ713M2v1oIdAozgKt+MfjdAud2lx2cQ9ygPXzbAk1FqDAwNrBNkjJMuaTppQxtD185cjUQA
 Y+rFPNH97WvxBDWCGZ7+w0QNv+NBYDOoDqQ5L+xgoGK5OpeOtHl7XMJ7ym480eCwzEZOKoiSSnH
 dA1wW8jraM3odFXUmilbh3W8jEEpIseYME/+/YPFWMeixhFRNN75ZFTpkJMcRqbi9dd6pWtyNLO
 8xZanc9ElEZxfe/9zwAhvAuuNSY/iZ0Tf2TrQi200ZY34kLhnX5QU8klZ15gOUg/7A0DrKw6Ksd
 EX6aLhXVW7xPtwep0y0zOODnx9ybOoc8waXKf2WVByoSOe2qllllIMhuVvOvsCqlphLRrJXw+Id
 9aROx0u/wNg==
X-Received: by 2002:a17:906:8f14:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c49bddd28ddmr280193566b.1.1793196968335; 
 Wed, 28 Oct 2026 07:16:08 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 06/30] usb: gadget: udc: make udc-core build in U-Boot
Date: Wed, 28 Oct 2026 15:15:30 +0100
Message-ID: <20261028141554.3073545-7-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the re-imported udc-core.c to U-Boot and build it for every gadget
config. The resynced gadget.h makes usb_ep_enable() and friends real
functions and they live here now.

udc-core only sees controllers that called usb_add_gadget_udc(). Driver
model drivers do that from probe, the others have no probe at all. Add a
weak usb_gadget_udc_bringup() hook so they can bring themselves up when a
gadget driver asks for a UDC. Report what the hook returns, otherwise a
controller that fails to come up only says "No UDC available".

In the kernel udc_start(), udc_stop() and get_frame() are mandatory. In
U-Boot they are not, so check them before calling. Without the check a
driver that does not have them takes the board down instead of failing.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/udc/Makefile   |   1 +
 drivers/usb/gadget/udc/udc-core.c | 929 +++++-------------------------
 include/linux/usb/gadget.h        |   3 +
 3 files changed, 153 insertions(+), 780 deletions(-)

diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 56b9b123fa16..f80ae6e5add5 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
 obj-$(CONFIG_$(PHASE_)DM_USB_GADGET)	+= udc-core.o
+obj-$(CONFIG_$(PHASE_)USB_GADGET)	+= udc-core.o
 obj-y += udc-uclass.o
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 2af62c579cb3..d19f363478b2 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -7,27 +7,17 @@
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
-#define pr_fmt(fmt)	"UDC core: " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/idr.h>
-#include <linux/err.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/compat.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <linux/bug.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched/task_stack.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb.h>
-
-#include "trace.h"
-
-static DEFINE_IDA(gadget_id_numbers);
-
-static const struct bus_type gadget_bus_type;
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -41,7 +31,6 @@ static const struct bus_type gadget_bus_type;
  * @allow_connect: Indicates whether UDC is allowed to be pulled up.
  * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
  * unbound.
- * @vbus_work: work routine to handle VBUS status change notifications.
  * @connect_lock: protects udc->started, gadget->connect,
  * gadget->allow_connect and gadget->deactivate. The routines
  * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
@@ -59,15 +48,13 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	bool				allow_connect;
-	struct work_struct		vbus_work;
 	struct mutex			connect_lock;
 };
 
-static const struct class udc_class;
 static LIST_HEAD(udc_list);
 
 /* Protects udc_list, udc->driver, driver->is_bound, and related calls */
-static DEFINE_MUTEX(udc_lock);
+DEFINE_MUTEX(udc_lock);
 
 /* ------------------------------------------------------------------------- */
 
@@ -84,8 +71,6 @@ void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 {
 	ep->maxpacket_limit = maxpacket_limit;
 	ep->maxpacket = maxpacket_limit;
-
-	trace_usb_ep_set_maxpacket_limit(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
 
@@ -120,9 +105,10 @@ int usb_ep_enable(struct usb_ep *ep)
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
 	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+#ifndef CONFIG_SPL_BUILD
 		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
 			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
-
+#endif
 		ret = -EINVAL;
 		goto out;
 	}
@@ -134,8 +120,6 @@ int usb_ep_enable(struct usb_ep *ep)
 	ep->enabled = true;
 
 out:
-	trace_usb_ep_enable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_enable);
@@ -168,8 +152,6 @@ int usb_ep_disable(struct usb_ep *ep)
 	ep->enabled = false;
 
 out:
-	trace_usb_ep_disable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_disable);
@@ -191,13 +173,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
 struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 						       gfp_t gfp_flags)
 {
-	struct usb_request *req = NULL;
-
-	req = ep->ops->alloc_request(ep, gfp_flags);
-
-	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
-
-	return req;
+	return  ep->ops->alloc_request(ep, gfp_flags);
 }
 EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 
@@ -213,7 +189,6 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	trace_usb_ep_free_request(ep, req, 0);
 	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
@@ -301,8 +276,6 @@ int usb_ep_queue(struct usb_ep *ep,
 	ret = ep->ops->queue(ep, req, gfp_flags);
 
 out:
-	trace_usb_ep_queue(ep, req, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_queue);
@@ -326,12 +299,7 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
  */
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 {
-	int ret;
-
-	ret = ep->ops->dequeue(ep, req);
-	trace_usb_ep_dequeue(ep, req, ret);
-
-	return ret;
+	return ep->ops->dequeue(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_dequeue);
 
@@ -360,12 +328,7 @@ EXPORT_SYMBOL_GPL(usb_ep_dequeue);
  */
 int usb_ep_set_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 1);
-	trace_usb_ep_set_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 1);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_halt);
 
@@ -386,12 +349,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_halt);
  */
 int usb_ep_clear_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 0);
-	trace_usb_ep_clear_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_clear_halt);
 
@@ -416,8 +374,6 @@ int usb_ep_set_wedge(struct usb_ep *ep)
 	else
 		ret = ep->ops->set_halt(ep, 1);
 
-	trace_usb_ep_set_wedge(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
@@ -448,8 +404,6 @@ int usb_ep_fifo_status(struct usb_ep *ep)
 	else
 		ret = -EOPNOTSUPP;
 
-	trace_usb_ep_fifo_status(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
@@ -469,8 +423,6 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
 {
 	if (ep->ops->fifo_flush)
 		ep->ops->fifo_flush(ep);
-
-	trace_usb_ep_fifo_flush(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
@@ -485,13 +437,11 @@ EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
  */
 int usb_gadget_frame_number(struct usb_gadget *gadget)
 {
-	int ret;
-
-	ret = gadget->ops->get_frame(gadget);
 
-	trace_usb_gadget_frame_number(gadget, ret);
+	if (!gadget->ops->get_frame)
+		return -EOPNOTSUPP;
 
-	return ret;
+	return gadget->ops->get_frame(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
 
@@ -520,39 +470,10 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 	ret = gadget->ops->wakeup(gadget);
 
 out:
-	trace_usb_gadget_wakeup(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
-/**
- * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
- * @gadget:the device being configured for remote wakeup
- * @set:value to be configured.
- *
- * set to one to enable remote wakeup feature and zero to disable it.
- *
- * returns zero on success, else negative errno.
- */
-int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
-{
-	int ret = 0;
-
-	if (!gadget->ops->set_remote_wakeup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->set_remote_wakeup(gadget, set);
-
-out:
-	trace_usb_gadget_set_remote_wakeup(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
-
 /**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
@@ -574,8 +495,6 @@ int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 1);
 
 out:
-	trace_usb_gadget_set_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
@@ -602,43 +521,10 @@ int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 0);
 
 out:
-	trace_usb_gadget_clear_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
 
-/**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- * Context: can sleep
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	if (!gadget->ops->vbus_session) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_session(gadget, 1);
-
-out:
-	trace_usb_gadget_vbus_connect(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
-
 /**
  * usb_gadget_vbus_draw - constrain controller's VBUS power usage
  * @gadget:The device whose VBUS usage is being described
@@ -653,21 +539,10 @@ EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
  */
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-	int ret = 0;
-
-	if (!gadget->ops->vbus_draw) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_draw(gadget, mA);
-	if (!ret)
-		gadget->mA = mA;
+	if (!gadget->ops->vbus_draw)
+		return -EOPNOTSUPP;
 
-out:
-	trace_usb_gadget_vbus_draw(gadget, ret);
-
-	return ret;
+	return gadget->ops->vbus_draw(gadget, mA);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
 
@@ -694,8 +569,6 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 	ret = gadget->ops->vbus_session(gadget, 0);
 
 out:
-	trace_usb_gadget_vbus_disconnect(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
@@ -726,8 +599,6 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		gadget->connected = 1;
 
 out:
-	trace_usb_gadget_connect(gadget, ret);
-
 	return ret;
 }
 
@@ -785,8 +656,6 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 out:
-	trace_usb_gadget_disconnect(gadget, ret);
-
 	return ret;
 }
 
@@ -815,170 +684,31 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
-/**
- * usb_gadget_deactivate - deactivate function which is not ready to work
- * @gadget: the peripheral being deactivated
- *
- * This routine may be used during the gadget driver bind() call to prevent
- * the peripheral from ever being visible to the USB host, unless later
- * usb_gadget_activate() is called.  For example, user mode components may
- * need to be activated before the system can talk to hosts.
- *
- * This routine may sleep; it must not be called in interrupt context
- * (such as from within a gadget driver's disconnect() callback).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_deactivate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (gadget->deactivated)
-		goto unlock;
-
-	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
-		if (ret)
-			goto unlock;
-
-		/*
-		 * If gadget was being connected before deactivation, we want
-		 * to reconnect it in usb_gadget_activate().
-		 */
-		gadget->connected = true;
-	}
-	gadget->deactivated = true;
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_deactivate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
-
-/**
- * usb_gadget_activate - activate function which is not ready to work
- * @gadget: the peripheral being activated
- *
- * This routine activates gadget which was previously deactivated with
- * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
- *
- * This routine may sleep; it must not be called in interrupt context.
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_activate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (!gadget->deactivated)
-		goto unlock;
-
-	gadget->deactivated = false;
-
-	/*
-	 * If gadget has been connected before deactivation, or became connected
-	 * while it was being deactivated, we call usb_gadget_connect().
-	 */
-	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_activate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_activate);
-
 /* ------------------------------------------------------------------------- */
 
-#ifdef	CONFIG_HAS_DMA
-
-int usb_gadget_map_request_by_dev(struct device *dev,
+int usb_gadget_map_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
 	if (req->length == 0)
 		return 0;
 
-	if (req->sg_was_mapped) {
-		req->num_mapped_sgs = req->num_sgs;
-		return 0;
-	}
-
-	if (req->num_sgs) {
-		int     mapped;
-
-		mapped = dma_map_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		if (mapped == 0) {
-			dev_err(dev, "failed to map SGs\n");
-			return -EFAULT;
-		}
-
-		req->num_mapped_sgs = mapped;
-	} else {
-		if (is_vmalloc_addr(req->buf)) {
-			dev_err(dev, "buffer is not dma capable\n");
-			return -EFAULT;
-		} else if (object_is_on_stack(req->buf)) {
-			dev_err(dev, "buffer is on stack\n");
-			return -EFAULT;
-		}
-
-		req->dma = dma_map_single(dev, req->buf, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		if (dma_mapping_error(dev, req->dma)) {
-			dev_err(dev, "failed to map buffer\n");
-			return -EFAULT;
-		}
-
-		req->dma_mapped = 1;
-	}
-
+	req->dma = dma_map_single(req->buf, req->length,
+				  is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_map_request_by_dev);
-
-int usb_gadget_map_request(struct usb_gadget *gadget,
-		struct usb_request *req, int is_in)
-{
-	return usb_gadget_map_request_by_dev(gadget->dev.parent, req, is_in);
-}
 EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 
-void usb_gadget_unmap_request_by_dev(struct device *dev,
+void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0 || req->sg_was_mapped)
+	if (req->length == 0)
 		return;
 
-	if (req->num_mapped_sgs) {
-		dma_unmap_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		req->num_mapped_sgs = 0;
-	} else if (req->dma_mapped) {
-		dma_unmap_single(dev, req->dma, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		req->dma_mapped = 0;
-	}
-}
-EXPORT_SYMBOL_GPL(usb_gadget_unmap_request_by_dev);
-
-void usb_gadget_unmap_request(struct usb_gadget *gadget,
-		struct usb_request *req, int is_in)
-{
-	usb_gadget_unmap_request_by_dev(gadget->dev.parent, req, is_in);
+	dma_unmap_single(req->dma, req->length,
+			 is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
-#endif	/* CONFIG_HAS_DMA */
-
 /* ------------------------------------------------------------------------- */
 
 /**
@@ -992,11 +722,6 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
 {
-	if (likely(req->status == 0))
-		usb_led_activity(USB_LED_EVENT_GADGET);
-
-	trace_usb_gadget_giveback_request(ep, req, 0);
-
 	req->complete(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
@@ -1112,71 +837,13 @@ EXPORT_SYMBOL_GPL(usb_gadget_check_config);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_gadget_state_work(struct work_struct *work)
-{
-	struct usb_gadget *gadget = work_to_gadget(work);
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc)
-		sysfs_notify(&udc->dev.kobj, NULL, "state");
-}
-
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
 	gadget->state = state;
-	schedule_work(&gadget->work);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
-/* ------------------------------------------------------------------------- */
-
-/* Acquire connect_lock before calling this function. */
-static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
-{
-	if (udc->vbus)
-		return usb_gadget_connect_locked(udc->gadget);
-	else
-		return usb_gadget_disconnect_locked(udc->gadget);
-}
-
-static void vbus_event_work(struct work_struct *work)
-{
-	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
-
-	mutex_lock(&udc->connect_lock);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-}
-
-/**
- * usb_udc_vbus_handler - updates the udc core vbus status, and try to
- * connect or disconnect gadget
- * @gadget: The gadget which vbus change occurs
- * @status: The vbus status
- *
- * The udc driver calls it when it wants to connect or disconnect gadget
- * according to vbus status.
- *
- * This function can be invoked from interrupt context by irq handlers of
- * the gadget drivers, however, usb_udc_connect_control() has to run in
- * non-atomic context due to the following:
- * a. Some of the gadget driver implementations expect the ->pullup
- * callback to be invoked in non-atomic context.
- * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
- * Hence offload invocation of usb_udc_connect_control() to workqueue.
- */
-void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
-{
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc) {
-		udc->vbus = status;
-		schedule_work(&udc->vbus_work);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
-
 /**
  * usb_gadget_udc_reset - notifies the udc core that bus reset occurs
  * @gadget: The gadget which bus reset occurs
@@ -1219,6 +886,9 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 		return -EBUSY;
 	}
 
+	if (!udc->gadget->ops->udc_start)
+		return -EOPNOTSUPP;
+
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 	if (!ret)
 		udc->started = true;
@@ -1247,7 +917,8 @@ static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
 		return;
 	}
 
-	udc->gadget->ops->udc_stop(udc->gadget);
+	if (udc->gadget->ops->udc_stop)
+		udc->gadget->ops->udc_stop(udc->gadget);
 	udc->started = false;
 }
 
@@ -1325,6 +996,37 @@ static inline void usb_gadget_disable_async_callbacks(struct usb_udc *udc)
 		gadget->ops->udc_async_callbacks(gadget, false);
 }
 
+static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
+{
+	int ret;
+
+	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
+			driver->function);
+
+	udc->driver = driver;
+
+	usb_gadget_udc_set_speed(udc, driver->speed);
+
+	ret = driver->bind(udc->gadget);
+	if (ret)
+		goto err1;
+	ret = usb_gadget_udc_start_locked(udc);
+	if (ret) {
+		driver->unbind(udc->gadget);
+		goto err1;
+	}
+	udc->allow_connect = true;
+	usb_gadget_connect(udc->gadget);
+
+	return 0;
+err1:
+	if (ret != -EISNAM)
+		dev_err(&udc->dev, "failed to start %s: %d\n",
+			udc->driver->function, ret);
+	udc->driver = NULL;
+	return ret;
+}
+
 /**
  * usb_udc_release - release the usb_udc struct
  * @dev: the dev member within usb_udc
@@ -1337,17 +1039,9 @@ static void usb_udc_release(struct device *dev)
 	struct usb_udc *udc;
 
 	udc = container_of(dev, struct usb_udc, dev);
-	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
 	kfree(udc);
 }
 
-static const struct attribute_group *usb_udc_attr_groups[];
-
-static void usb_udc_nop_release(struct device *dev)
-{
-	dev_vdbg(dev, "%s\n", __func__);
-}
-
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1358,16 +1052,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
-
-	if (release)
-		gadget->dev.release = release;
-	else
-		gadget->dev.release = usb_udc_nop_release;
-
-	device_initialize(&gadget->dev);
-	gadget->dev.bus = &gadget_bus_type;
+	gadget->dev.release = release;
 }
 EXPORT_SYMBOL_GPL(usb_initialize_gadget);
 
@@ -1387,15 +1073,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (!udc)
 		goto error;
 
-	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
-	udc->dev.class = &udc_class;
-	udc->dev.groups = usb_udc_attr_groups;
+	udc->dev.class = NULL;
 	udc->dev.parent = gadget->dev.parent;
-	ret = dev_set_name(&udc->dev, "%s",
-			kobject_name(&gadget->dev.parent->kobj));
-	if (ret)
-		goto err_put_udc;
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
@@ -1406,50 +1086,11 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
-	INIT_WORK(&udc->vbus_work, vbus_event_work);
-
-	ret = device_add(&udc->dev);
-	if (ret)
-		goto err_unlist_udc;
 
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
-	udc->vbus = true;
-
-	ret = ida_alloc(&gadget_id_numbers, GFP_KERNEL);
-	if (ret < 0)
-		goto err_del_udc;
-	gadget->id_number = ret;
-	dev_set_name(&gadget->dev, "gadget.%d", ret);
-
-	ret = device_add(&gadget->dev);
-	if (ret)
-		goto err_free_id;
-
-	ret = sysfs_create_link(&udc->dev.kobj,
-				&gadget->dev.kobj, "gadget");
-	if (ret)
-		goto err_del_gadget;
 
 	return 0;
 
- err_del_gadget:
-	device_del(&gadget->dev);
-
- err_free_id:
-	ida_free(&gadget_id_numbers, gadget->id_number);
-
- err_del_udc:
-	flush_work(&gadget->work);
-	device_del(&udc->dev);
-
- err_unlist_udc:
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
-
- err_put_udc:
-	put_device(&udc->dev);
-
  error:
 	return ret;
 }
@@ -1468,13 +1109,8 @@ EXPORT_SYMBOL_GPL(usb_add_gadget);
 int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	int	ret;
-
 	usb_initialize_gadget(parent, gadget, release);
-	ret = usb_add_gadget(gadget);
-	if (ret)
-		usb_put_gadget(gadget);
-	return ret;
+	return usb_add_gadget(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
 
@@ -1499,7 +1135,7 @@ char *usb_get_gadget_udc_name(void)
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		if (!udc->driver) {
-			name = kstrdup(udc->gadget->name, GFP_KERNEL);
+			name = strdup(udc->gadget->name);
 			break;
 		}
 	}
@@ -1522,409 +1158,142 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
-/**
- * usb_del_gadget - deletes a gadget and unregisters its udc
- * @gadget: the gadget to be deleted.
- *
- * This will unbind @gadget, if it is bound.
- * It will not do a final usb_put_gadget().
- */
-void usb_del_gadget(struct usb_gadget *gadget)
+static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
-	struct usb_udc *udc = gadget->udc;
-
-	if (!udc)
-		return;
+	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
+			udc->driver->function);
 
-	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
-
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
+	udc->allow_connect = false;
+	usb_gadget_disconnect(udc->gadget);
+	udc->driver->disconnect(udc->gadget);
+	udc->driver->unbind(udc->gadget);
+	usb_gadget_udc_stop_locked(udc);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
-	sysfs_remove_link(&udc->dev.kobj, "gadget");
-	device_del(&gadget->dev);
-	flush_work(&gadget->work);
-	ida_free(&gadget_id_numbers, gadget->id_number);
-	cancel_work_sync(&udc->vbus_work);
-	device_unregister(&udc->dev);
+	udc->driver = NULL;
 }
-EXPORT_SYMBOL_GPL(usb_del_gadget);
 
 /**
- * usb_del_gadget_udc - unregisters a gadget
- * @gadget: the gadget to be unregistered.
+ * usb_del_gadget_udc - deletes @udc from udc_list
+ * @gadget: the gadget to be removed.
  *
- * Calls usb_del_gadget() and does a final usb_put_gadget().
+ * This, will call usb_gadget_unregister_driver() if
+ * the @udc is still busy.
  */
 void usb_del_gadget_udc(struct usb_gadget *gadget)
 {
-	usb_del_gadget(gadget);
-	usb_put_gadget(gadget);
-}
-EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
-
-/* ------------------------------------------------------------------------- */
-
-static int gadget_match_driver(struct device *dev, const struct device_driver *drv)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	const struct usb_gadget_driver *driver = container_of(drv,
-			struct usb_gadget_driver, driver);
-
-	/* If the driver specifies a udc_name, it must match the UDC's name */
-	if (driver->udc_name &&
-			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
-		return 0;
-
-	/* If the driver is already bound to a gadget, it doesn't match */
-	if (driver->is_bound)
-		return 0;
-
-	/* Otherwise any gadget driver matches any UDC */
-	return 1;
-}
-
-static int gadget_bind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = container_of(dev->driver,
-			struct usb_gadget_driver, driver);
-	int ret = 0;
+	struct usb_udc		*udc = NULL;
 
 	mutex_lock(&udc_lock);
-	if (driver->is_bound) {
-		mutex_unlock(&udc_lock);
-		return -ENXIO;		/* Driver binds to only one gadget */
-	}
-	driver->is_bound = true;
-	udc->driver = driver;
-	mutex_unlock(&udc_lock);
-
-	dev_dbg(&udc->dev, "binding gadget driver [%s]\n", driver->function);
-
-	usb_gadget_udc_set_speed(udc, driver->max_speed);
-
-	ret = driver->bind(udc->gadget, driver);
-	if (ret)
-		goto err_bind;
-
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
-		goto err_start;
-	}
-	usb_gadget_enable_async_callbacks(udc);
-	udc->allow_connect = true;
-	ret = usb_udc_connect_control_locked(udc);
-	if (ret)
-		goto err_connect_control;
-
-	mutex_unlock(&udc->connect_lock);
-
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-	return 0;
-
- err_connect_control:
-	udc->allow_connect = false;
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-
- err_start:
-	driver->unbind(udc->gadget);
-
- err_bind:
-	if (ret != -EISNAM)
-		dev_err(&udc->dev, "failed to start %s: %d\n",
-			driver->function, ret);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
 
-	mutex_lock(&udc_lock);
-	udc->driver = NULL;
-	driver->is_bound = false;
+	dev_err(gadget->dev.parent, "gadget not registered.\n");
 	mutex_unlock(&udc_lock);
 
-	return ret;
-}
-
-static void gadget_unbind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = udc->driver;
-
-	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
-
-	udc->allow_connect = false;
-	cancel_work_sync(&udc->vbus_work);
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	mutex_unlock(&udc->connect_lock);
-
-	udc->driver->unbind(gadget);
+	return;
 
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+found:
+	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
 
-	mutex_lock(&udc_lock);
-	driver->is_bound = false;
-	udc->driver = NULL;
+	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
+	if (udc->driver)
+		usb_gadget_remove_driver(udc);
 }
+EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
-int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
-		struct module *owner, const char *mod_name)
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
-	int ret;
+	struct usb_udc		*udc = NULL;
+	int			ret = -ENODEV;
 
-	if (!driver || !driver->bind || !driver->setup)
+	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	driver->driver.bus = &gadget_bus_type;
-	driver->driver.owner = owner;
-	driver->driver.mod_name = mod_name;
-	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
-	ret = driver_register(&driver->driver);
-	if (ret) {
-		pr_warn("%s: driver registration failed: %d\n",
-				driver->function, ret);
-		return ret;
-	}
-
 	mutex_lock(&udc_lock);
-	if (!driver->is_bound) {
-		if (driver->match_existing_only) {
-			pr_warn("%s: couldn't find an available UDC or it's busy\n",
-					driver->function);
-			ret = -EBUSY;
-		} else {
-			pr_info("%s: couldn't find an available UDC\n",
-					driver->function);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->driver == driver) {
+			usb_gadget_remove_driver(udc);
+			usb_gadget_set_state(udc->gadget,
+					USB_STATE_NOTATTACHED);
 			ret = 0;
+			break;
 		}
-	}
-	mutex_unlock(&udc_lock);
 
-	if (ret)
-		driver_unregister(&driver->driver);
+	mutex_unlock(&udc_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_register_driver_owner);
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (!driver || !driver->unbind)
-		return -EINVAL;
-
-	driver_unregister(&driver->driver);
-	return 0;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_unregister_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static ssize_t srp_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
+/*
+ * u-boot: a controller that is not a driver model device has no probe of its
+ * own, so it never calls usb_add_gadget_udc(). Such drivers implement this
+ * hook and bring themselves up the first time a gadget driver asks for a UDC.
+ */
+__weak int usb_gadget_udc_bringup(void)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-
-	if (sysfs_streq(buf, "1"))
-		usb_gadget_wakeup(udc->gadget);
-
-	return n;
+	return 0;
 }
-static DEVICE_ATTR_WO(srp);
 
-static ssize_t soft_connect_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	ssize_t			ret;
+	struct usb_udc		*udc = NULL;
+	unsigned int		udc_count = 0;
+	int			ret;
 
-	device_lock(&udc->gadget->dev);
-	if (!udc->driver) {
-		dev_err(dev, "soft-connect without a gadget driver\n");
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
 
-	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
-	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
-	} else {
-		dev_err(dev, "unsupported command '%s'\n", buf);
-		ret = -EINVAL;
-		goto out;
+	if (list_empty(&udc_list)) {
+		ret = usb_gadget_udc_bringup();
+		if (ret) {
+#ifndef CONFIG_SPL_BUILD
+			printf("UDC bringup failed: %d\n", ret);
+#endif
+			return ret;
+		}
 	}
 
-	ret = n;
-out:
-	device_unlock(&udc->gadget->dev);
-	return ret;
-}
-static DEVICE_ATTR_WO(soft_connect);
-
-static ssize_t state_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget	*gadget = udc->gadget;
-
-	return sprintf(buf, "%s\n", usb_state_string(gadget->state));
-}
-static DEVICE_ATTR_RO(state);
-
-static ssize_t function_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget_driver *drv;
-	int			rc = 0;
-
 	mutex_lock(&udc_lock);
-	drv = udc->driver;
-	if (drv && drv->function)
-		rc = scnprintf(buf, PAGE_SIZE, "%s\n", drv->function);
-	mutex_unlock(&udc_lock);
-	return rc;
-}
-static DEVICE_ATTR_RO(function);
-
-#define USB_UDC_SPEED_ATTR(name, param)					\
-ssize_t name##_show(struct device *dev,					\
-		struct device_attribute *attr, char *buf)		\
-{									\
-	struct usb_udc *udc = container_of(dev, struct usb_udc, dev);	\
-	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
-			usb_speed_string(udc->gadget->param));		\
-}									\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_SPEED_ATTR(current_speed, speed);
-static USB_UDC_SPEED_ATTR(maximum_speed, max_speed);
-
-#define USB_UDC_ATTR(name)					\
-ssize_t name##_show(struct device *dev,				\
-		struct device_attribute *attr, char *buf)	\
-{								\
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev); \
-	struct usb_gadget	*gadget = udc->gadget;		\
-								\
-	return scnprintf(buf, PAGE_SIZE, "%d\n", gadget->name);	\
-}								\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_ATTR(is_otg);
-static USB_UDC_ATTR(is_a_peripheral);
-static USB_UDC_ATTR(b_hnp_enable);
-static USB_UDC_ATTR(a_hnp_support);
-static USB_UDC_ATTR(a_alt_hnp_support);
-static USB_UDC_ATTR(is_selfpowered);
-
-static struct attribute *usb_udc_attrs[] = {
-	&dev_attr_srp.attr,
-	&dev_attr_soft_connect.attr,
-	&dev_attr_state.attr,
-	&dev_attr_function.attr,
-	&dev_attr_current_speed.attr,
-	&dev_attr_maximum_speed.attr,
-
-	&dev_attr_is_otg.attr,
-	&dev_attr_is_a_peripheral.attr,
-	&dev_attr_b_hnp_enable.attr,
-	&dev_attr_a_hnp_support.attr,
-	&dev_attr_a_alt_hnp_support.attr,
-	&dev_attr_is_selfpowered.attr,
-	NULL,
-};
-
-static const struct attribute_group usb_udc_attr_group = {
-	.attrs = usb_udc_attrs,
-};
-
-static const struct attribute_group *usb_udc_attr_groups[] = {
-	&usb_udc_attr_group,
-	NULL,
-};
-
-static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
-{
-	const struct usb_udc	*udc = container_of(dev, struct usb_udc, dev);
-	int			ret;
+	list_for_each_entry(udc, &udc_list, list) {
+		udc_count++;
 
-	ret = add_uevent_var(env, "USB_UDC_NAME=%s", udc->gadget->name);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_NAME\n");
-		return ret;
+		/* For now we take the first one */
+		if (!udc->driver)
+			goto found;
 	}
 
-	mutex_lock(&udc_lock);
-	if (udc->driver)
-		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
-				udc->driver->function);
+#ifndef CONFIG_SPL_BUILD
+	if (!udc_count)
+		printf("No UDC available in the system\n");
+	else
+		/* When this happens, users should 'unbind <class> <index>'
+		 * using the output of 'dm tree' and looking at the line right
+		 * after the USB peripheral/device controller.
+		 */
+		printf("All UDCs in use (%d available), use the unbind command\n",
+		       udc_count);
+#endif
 	mutex_unlock(&udc_lock);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct class udc_class = {
-	.name		= "udc",
-	.dev_uevent	= usb_udc_uevent,
-};
-
-static const struct bus_type gadget_bus_type = {
-	.name = "gadget",
-	.probe = gadget_bind_driver,
-	.remove = gadget_unbind_driver,
-	.match = gadget_match_driver,
-};
-
-static int __init usb_udc_init(void)
-{
-	int rc;
-
-	rc = class_register(&udc_class);
-	if (rc)
-		return rc;
-
-	rc = bus_register(&gadget_bus_type);
-	if (rc)
-		class_unregister(&udc_class);
-	return rc;
+	return -ENODEV;
+found:
+	ret = udc_bind_to_driver(udc, driver);
+	mutex_unlock(&udc_lock);
+	return ret;
 }
-subsys_initcall(usb_udc_init);
+EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
-static void __exit usb_udc_exit(void)
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
-	bus_unregister(&gadget_bus_type);
-	class_unregister(&udc_class);
+	return usb_gadget_probe_driver(driver);
 }
-module_exit(usb_udc_exit);
+EXPORT_SYMBOL_GPL(usb_gadget_register_driver);
 
 MODULE_DESCRIPTION("UDC Framework");
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7137f0faf3c6..866f6049bb5f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -554,6 +554,9 @@ struct usb_gadget_driver {
  */
 int usb_gadget_register_driver(struct usb_gadget_driver *driver);
 
+/* u-boot: bring up a non driver model UDC on demand, see udc-core.c */
+int usb_gadget_udc_bringup(void);
+
 /**
  * usb_gadget_unregister_driver - unregister a gadget driver
  * @driver:the driver being unregistered
-- 
2.53.0

