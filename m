Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7103606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YA4iZhMw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gi7s4Trw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9244440888;
	Wed, 28 Oct 2026 14:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJ8gX5zOhvYy; Wed, 28 Oct 2026 14:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2E124088E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198892;
	b=EXyyqnW9k7fCFO5LsNAcuqTSPGcu2KPnkcLE/XDxEkjeXI3zTLolDFuHMLCC4hDLiVgQ
	 N75MBX0q0V8ZNrButqB/WGDyLbgyJ3aOe1UzW4mZUGubK71448/3ZJq+TBtnihk4P2C9g
	 h6iFS3SGOojGUtGXPjZq5lUHWSeUGsuBV0YbdEqjRGFx3wQNgG+MyBntPTjMqYMruVyKO
	 Uwi+6lySKvE6yKfOHwg6qnHsc/A5D/5XmmGsBPqxTWbRdvwTZLOMwmz5s/MGgW7vKYnWa
	 Ow5NKlQgFjxtxyzsukz+l7vpvqj+5pQ8/ov+cepO0XTrKnpRnvTfZoncso6tLKF9xyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xXHmoNWFuPPyTQ+eqmyEUu3H6VORjwoPoq0I44fSBIE=;
	b=C+MfASJgArRF05fOvhVXYLZISKjm+FLBC0SSmldsJLig/3uLYKnvA+qJKBAmfJOCn135
	 LLU/AdyUQa88K12/NRhBqMphAHfVoZQrz5DGLU5adT3v9BPJwYo/Z6fEUusFnzVYwh7Fa
	 rcXwFH7+1VUozJPqVy50qHsyk1lwbiSz2KcF8qfdTa9X+FxFu7kdbLnur+7kgEKoodwUY
	 U5f5JMnhpCqmnte4v3sFmLytcBF0gOhjBgWGEq2pMT9XICrnh7OOs80bHdoBfIJ5lMck5
	 O0plWj1ZnA2/v616UdP97drFrDVl527VKeig6iSLxSnDZ9fAvlkP4XWQH2SN2Aj2MAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198892;
	bh=xXHmoNWFuPPyTQ+eqmyEUu3H6VORjwoPoq0I44fSBIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YA4iZhMwUF6rNE7GoP1zcyR0Qrv1duO21h1oEZKBhUmdUEVfsPV7gDCGuFn9cZiP2
	 hpMoeJ4UJgcImwSLyp/O6Yyxyrqwxcd1JikOx3oI8A7xw6ONDuN04vSQ4rTXSXAsUT
	 NXRoEDGz6v14peqeeXbHd2N1Rz2eKfQl0VPnUZzc6T0EhLKwn3nwcPb6L80ox17av4
	 hcqWbRXouIWJUzFZjh55pyHfYvL/slLn6fNTKrXMfN9w8GJkMrh28T06mnmmrTCaoH
	 qYVW6W8CYqcbLSZTJV6k8mlGpOMPqgk/GCxKCM6H/i2bnhlKnchR4J3j10CIN7V/dX
	 CrMkhXEfJYT8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2E124088E;
	Wed, 28 Oct 2026 14:48:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F055529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54E3580CF0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whikcpKYJ90Q for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1401680CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196976;
 b=EvZb9IZsePWJLHz9E9HYDDW+poQCfdggrB1zE77yD8TuCpbOhzec1O2XZ2KrmPaVSjzM
 fo8TyB95WP7/eq+ISLz6wcf5UBYqLp1Hm/fttx4RK6hTaI2gjLYFeJRiTZ2WicUW7eQeR
 YjjLdv5wHAZF5aHbKtV7E4ayyKJc9iV6ecTjHA6qV/ro7I1ZU6sIEiW0taMmG2Urhw6XG
 XIUiFIpAYC1ey3rxiyu42+XzKF3+5EYqmcoI3sQxpfftBSzwc7OBoEPsDROr0uMIxXAXD
 6eCYG1WHAMV6PsaJSdOtVdarwdGE9Bak4r2RQwZ+KAvLkIPNhZMixCYQovNMOa8oOaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196976;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xXHmoNWFuPPyTQ+eqmyEUu3H6VORjwoPoq0I44fSBIE=;
 b=bYwgLqqAlEKKStVCH45a43Y/L/Ali+sLRSAXB+FzL8FJwW1mnUzp1fFXN/agFTMJpsJ1
 JWoz+wwkaEMqiAzWIy/LyS5TjRuFhIxeuTho7G3OO45xJVH5CnQTArz+g5mr1lX60jliz
 GvHF9Xtx9oUDpNl6EI7h9ve7t2S8oW4Wy3W4x/Qmvgy/3NZ0KQsQ34BTMqlWOyyEIM+ay
 fCf2LLWg3YEQ5My4JjDqBAg4/2foVgu4KWF8fEKoa3CNwcp1coGMFH1438xnx9mtpjKfK
 svMvGMncXxwAmjeZhA0wAoZhoAIoRTmp/RfqxfzoKq2DEvnI2Q44vd5852poHvr3Dtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Gi7s4Trw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Gi7s4Trw
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1401680CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1b34ed603so216251a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196974; x=1793801774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xXHmoNWFuPPyTQ+eqmyEUu3H6VORjwoPoq0I44fSBIE=;
 b=Gi7s4TrwLuYMsOii+TU6ZsOOR/ebYjODfzhUDftaMQFz95goY+BkTU/X8Z2uYyOwBX
 tRYJ5bAkMtg62mJyFuP+QIPD82z7FdZ9P7y66q1F/xhXHy/pHOVHsZJCLi5rcJV30KMs
 19ye3p6kC/fK/4C6xyW2axM41il/ENBG2YckdX0dExcEUb5jDgKxCq/nUyJ2W3wrkZSF
 JWiyFKdsErFmJRsBn3A6+vEhgUxFHNpGu9m/M5a+PxK+IWDzknHxyDLZ/f2f1oJeaZ2z
 Q+n30NNgtaN1xpqCy9Ba4Ln1nCrAhO0CcEeFdelgKTbwESiwdvRJ82t5l+gjhLKGrYm6
 7Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196974; x=1793801774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xXHmoNWFuPPyTQ+eqmyEUu3H6VORjwoPoq0I44fSBIE=;
 b=BzpU2CvqjnCiyMQBPl8sgW54TshuHChKTh38KvkqcaJJRMWrzvKdWCfwmFSF//ldKL
 VhmH1NnPpEsOv93rcEk5Va5k1I1uXnNMtUdyNIvdDpd8UEkJJPQga9DK5mwD5SxYcgbR
 BbGn3QRNLaB8CKgaQRNJxMTy+E5e78XyK9j3I3ZoUa6XxfoRWJkbrelNW4StaK7lRoI+
 souQqcTiV2nFqH9qMl2NiORbPvf8T2zGbMbOtqrlaAa2fbHKdOorC7l3rumwYgdDBjDG
 goDN2Dwrzuevvp2047Pzc7gcFWH/YhA4cXRLlyMSYVW7PtX4POZs3vrmTrYb9u66JRia
 aeqw==
X-Gm-Message-State: AFq9FYLGvn8u/i95uObXtiOk2C21nONIS8UN9rmIQLUmkGFw7/Bq6hu7
 LXEVZV79alKHb+uJUn9fRrNJXUcaEpdFiqXYztZ9pVYhCX5OS0b+o+ydJL/VfM/mP6n1cZfaLrr
 W5s8Z
X-Gm-Gg: AYBFou0Sac2YkzoYB8cnbDxHF5mNrU9Km3VM5O5IvDX7Acz9hjdhT3uyHd/0OU/HnY7
 T2Alo0IgGwGW3NFqqkzcdd1CDcbKhBf0M1G5vpYwLk9rFZv1xg8Pix0k4Gpso3kqz0yVhFNuqmT
 mfkpak2TIUNT0GEKGjB/N0l3FblCjMvfP17vBE7L3a1QfbkEu7PF173/FfvGcFp3Rs/FnZmfPPh
 x/aI/T4jeISy9cl6ROm8FMNuRVdSVwQ67KX4RZ2LkEB47j9JT9Q64/3OXywXqpY+b0CAxHDp5LW
 AvUM2naREpbPRBm+GvUUpvfb7pUtgyps3bVUAuk3IpNicWhmJ5xgU/cXu2VBsKlyGFELhtXs8vO
 cnSdYD6C/j6mEN2yaPZ1CcWZfNmQDotmd8VinVgKx+VSZpdy7yNUw0fYz942bEruou2/9wxxGeE
 ij3LlD9nFv2Gxa0VdHjDA3znP4D7USz1usZp6S39YBhpd1ip62PjWuVOTOjpG8ED0xMp2Cr+6uF
 34pA/4wqC332bMFKSIPSCaGCkXpsxyV6igh6xc06eBkaSizSXF+aLFCVqyajcxzZ/mk3+5L+mjO
 Zu/ffcWEenlDTstPvp5LW64zaUqGJ0bAh4A8UFPrD40u7hOV+ShJIriOB9gWGD146V4DFNOT5/M
 SWEhYyfnHTA==
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr311628466b.4.1793196973622; 
 Wed, 28 Oct 2026 07:16:13 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:13 -0700 (PDT)
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
Subject: [PATCH v10 09/30] usb: dwc3: core: adapt to the U-Boot APIs
Date: Wed, 28 Oct 2026 15:15:33 +0100
Message-ID: <20261028141554.3073545-10-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the resynced core build with the U-Boot APIs. Most of it is
renames, like struct udevice and generic_phy_*().

The old U-Boot functions need three changes. dwc3_init() counts the
ports and inits the locks, like dwc3_core_probe() in Linux.
dwc3_uboot_init() uses do_fifo_resize, the new name for
needs_fifo_resize. dwc3_remove() no longer frees dwc->mem, since it is
always NULL there.

phy_set_mode_ext() is a static stub. The old core.c did not set the PHY
mode either.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 126 ++++++++++++++++++++++------------------
 drivers/usb/dwc3/core.h |  27 +++------
 2 files changed, 76 insertions(+), 77 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8db1dd2c29a1..e15c8254b016 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,41 +8,38 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <linux/clk.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/list.h>
+#include <clk.h>
+#include <cpu_func.h>
+#include <malloc.h>
+#include <dwc3-uboot.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/acpi.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/devinfo.h>
-#include <linux/reset.h>
-#include <linux/bitfield.h>
-
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <reset.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb/of.h>
-#include <linux/usb/otg.h>
+#include <linux/bitfield.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+
+#include <version.h>
 
 #include "core.h"
 #include "gadget.h"
 #include "glue.h"
 #include "io.h"
 
-#include "debug.h"
 #include "../host/xhci-ext-caps.h"
 
+#define msleep(a) udelay(a * 1000)
+
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
 static LIST_HEAD(dwc3_list);
@@ -274,7 +271,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(evt->buf);
 }
 
 /**
@@ -290,18 +287,19 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 {
 	struct dwc3_event_buffer	*evt;
 
-	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
+	evt = devm_kzalloc((struct udevice *)dwc->dev, sizeof(*evt), GFP_KERNEL);
 	if (!evt)
 		return ERR_PTR(-ENOMEM);
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
+	evt->cache	= devm_kzalloc((struct udevice *)dwc->dev, length,
+				       GFP_KERNEL);
 	if (!evt->cache)
 		return ERR_PTR(-ENOMEM);
 
-	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
-			&evt->dma, GFP_KERNEL);
+	evt->buf	= dma_alloc_coherent(length,
+					     (unsigned long *)&evt->dma);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
@@ -617,13 +615,13 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 	usb_phy_init(dwc->usb3_phy);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_init(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_init(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_exit_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_init(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_init(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_exit_usb3_phy;
 	}
@@ -651,11 +649,11 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 
 err_exit_usb3_phy:
 	while (--j >= 0)
-		phy_exit(dwc->usb3_generic_phy[j]);
+		generic_phy_exit(dwc->usb3_generic_phy[j]);
 
 err_exit_usb2_phy:
 	while (--i >= 0)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -668,10 +666,10 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_exit(dwc->usb3_generic_phy[i]);
+		generic_phy_exit(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -687,13 +685,13 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_power_on(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_power_off_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_power_on(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_power_on(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_power_off_usb3_phy;
 	}
@@ -702,11 +700,11 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
 err_power_off_usb3_phy:
 	while (--j >= 0)
-		phy_power_off(dwc->usb3_generic_phy[j]);
+		generic_phy_power_off(dwc->usb3_generic_phy[j]);
 
 err_power_off_usb2_phy:
 	while (--i >= 0)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -719,10 +717,10 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_power_off(dwc->usb3_generic_phy[i]);
+		generic_phy_power_off(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -838,7 +836,7 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 /* set global incr burst type configuration registers */
 static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	/* incrx_mode : for INCR burst type. */
 	bool incrx_mode;
 	/* incrx_size : for size of INCRX burst. */
@@ -1079,9 +1077,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
+	 * out which U-Boot version a bug was found.
 	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+	dwc3_writel(dwc->regs, DWC3_GUID, U_BOOT_VERSION_NUM);
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
@@ -1099,13 +1097,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->ulpi_ready = true;
 	}
 
-	if (!dwc->phys_ready) {
-		ret = dwc3_core_get_phy(dwc);
-		if (ret)
-			goto err_exit_ulpi;
-		dwc->phys_ready = true;
-	}
-
 	ret = dwc3_phy_init(dwc);
 	if (ret)
 		goto err_exit_ulpi;
@@ -1270,9 +1261,17 @@ err_exit_ulpi:
 	return ret;
 }
 
+static int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
+{
+	/* TODO */
+	return -ENOSYS;
+}
+#define phy_set_mode(phy, mode) \
+	phy_set_mode_ext(phy, mode, 0)
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	int ret;
 	int i;
 
@@ -1280,8 +1279,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
@@ -1292,8 +1289,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
 		for (i = 0; i < dwc->num_usb2_ports; i++)
 			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
 		for (i = 0; i < dwc->num_usb3_ports; i++)
@@ -1535,11 +1530,29 @@ void dwc3_of_parse(struct dwc3 *dwc)
 
 int dwc3_init(struct dwc3 *dwc)
 {
+	unsigned int hw_mode;
 	int ret;
 	u32 reg;
 
 	dwc3_cache_hwparams(dwc);
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_get_num_ports(dwc);
+		if (ret)
+			return ret;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
+	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
+
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
@@ -1608,7 +1621,6 @@ void dwc3_remove(struct dwc3 *dwc)
 	dwc3_free_event_buffers(dwc);
 	dwc3_core_stop(dwc);
 	dwc3_core_exit(dwc);
-	kfree(dwc->mem);
 }
 #endif
 
@@ -1666,7 +1678,7 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	if (dwc3_dev->hird_threshold)
 		hird_threshold = dwc3_dev->hird_threshold;
 
-	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->do_fifo_resize = dwc3_dev->tx_fifo_resize;
 	dwc->dr_mode = dwc3_dev->dr_mode;
 
 	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c4d7bae2e5f..a9473e9d34b9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -11,27 +11,13 @@
 #ifndef __DRIVERS_USB_DWC3_CORE_H
 #define __DRIVERS_USB_DWC3_CORE_H
 
-#include <linux/device.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
 #include <linux/ioport.h>
-#include <linux/list.h>
 #include <linux/bitops.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
-#include <linux/debugfs.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/role.h>
-#include <linux/ulpi/interface.h>
-
-#include <linux/phy/phy.h>
-
-#include <linux/power_supply.h>
+#include <linux/usb/phy.h>
 
 /*
  * DWC3 Multiport controllers support up to 15 High-Speed PHYs
@@ -745,7 +731,6 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -1178,7 +1163,6 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
 	struct dwc3_request	ep0_usb_req;
-	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
@@ -1186,8 +1170,11 @@ struct dwc3 {
 	/* mode switching lock */
 	struct mutex		mutex;
 
+#if defined(__UBOOT__) && CONFIG_IS_ENABLED(DM_USB)
+	struct udevice		*dev;
+#else
 	struct device		*dev;
-	struct device		*sysdev;
+#endif
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
@@ -1195,7 +1182,7 @@ struct dwc3 {
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	*gadget;
+	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
 	struct clk		*bus_clk;
@@ -1204,7 +1191,7 @@ struct dwc3 {
 	struct clk		*utmi_clk;
 	struct clk		*pipe_clk;
 
-	struct reset_control	*reset;
+	struct reset_ctl	*reset;
 
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
-- 
2.53.0

