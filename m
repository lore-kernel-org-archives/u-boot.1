Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C62BCCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03A576067B;
	Sat, 17 Oct 2026 18:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOyHWfGRc0gh; Sat, 17 Oct 2026 18:46:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2324D60675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262802;
	b=JTJHrQ+dGZtkTRZqJjyGozUp9wkmOKebNlFpBtXZErCWObnWTUGRziuIuOrvQbmMLVeD
	 uY5OPd0d1zLvgJTevJoeziue9QUuQu5yzfZWIFPSAs3EnixWTVzcTEENSBjZ5gym5g5iC
	 DtvnMvAygzcMq00rdyt0JWXy2wh2sBuRBDpgP948BHVhTL2CuIevL5LZz5x3vKGZ6w9WW
	 D4EvfRRJsbnIVSwCWfCRCqbs0/vcjbQdl2BLgqu9OxxsrJaFVYDCcqGr8IczMakdA7RRS
	 1rYvlMcBkZYiex3DYVsySu0rWdYVOSo/0kEmbz3MDlvMiGpQjpPEhGbHkTUgW50ExWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iwkpFUOEwcfVhVZjtvbwB+zogapl37ZTw8si7q749BM=;
	b=rNOIs2Wxi5Xf5+uABb7O89jgbPf9qsSmtUlmGqwJof/8IzAwa1nUj1IeOXRU7Ir73psn
	 gKAblYHyOOFE+ZsgB9EonjIVWTAbYekjIl0kSmMKhDRbZ7brx74OL3xihQHhznOACbP/T
	 staYB6onwWAJOBgneHda8SZAbRAwfB6Upd304PN6AU2+LOpwlBbwgcyrZo4gUXLzZL0bv
	 Y6WxLu7detz2TczIkpEw+BeBU0ybP4peOJdEyHCZvVKh2gCZjndlzlxtxkwI6eTHgG1DC
	 1L4fXOgDpz0uker3aERYEWg9MvBkS/l7ruLRFFsIrcQC5ILelnvrEYI4k+tLf3lAerA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="cS20+H/p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262802;
	bh=iwkpFUOEwcfVhVZjtvbwB+zogapl37ZTw8si7q749BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxOm5izuyaoIGK9cEzl/nrt82I/bjk9D2TSKa9/2nmvx8XhdZ6gBBx26v2zLdSPA9
	 KfMtL+usuCO+qknTjkwQ4G9EkR7FeNXstfu05X5crBLLWqBGGXrV01GpXUul7vzeUz
	 /MPifI06wcZoB9+z1uZfVrWpATNwLfuz6YHFim4nnNLUXCtMw9sMy4c7lA2Gv7UI6v
	 AWHi6G/Ph8itAW5THzA0Y3tB4o3/PyNlZ99qXuNnlYnE7X6a3fKmQksrrUbZ6xzvnC
	 KFeml+j89Uxv0oRvAwyDypFDGxDFgJyfHg2k3vac2YrbhdIA2rKJXKE52mGlETZgA9
	 5uoECfY4Ugc0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2324D60675;
	Sat, 17 Oct 2026 18:46:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CEEED977
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0FDD60632
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxWhZC9nMVDx for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 129CC60626
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262796;
 b=c2HL8OSNGiAzaVlNRp2jSDaWedIPSv1XeTep+orpBCQeA5DnzlJfnnT+5YL5m+uf4pla
 zcjUqu7aMItObCnaSYyoupciW+P6DslHPsohLbYxMJ/ogMItMblwZE5oEUaLc08ACAfCz
 kK8fpjCqjRuiVsh1R0uLqFiLqrTNoAXqGRhVfj8bI0p5nGiNfIjoP+wtWSX66MMtXQVZL
 1Y4OnV1/q+nqS40ZCa5t+8OsV0MaZaxaf8+kGWIhmUiZriwY4eHs0gLtvGTLZQ2PsI2tz
 nE1vSfC56o1xEflm3nrEExtGqqjkvxvoptBPDQrWMYVnnhYhZkatLFC8iS4/SySlt1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262796;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iwkpFUOEwcfVhVZjtvbwB+zogapl37ZTw8si7q749BM=;
 b=aOZwFmSihOYqpTMbL+xMtW413JNg1l6pCNY0Ei8iC4PtLXE0U1MXi1bvaUPlpEFNnA2n
 ZVOdBgvtArhLj9YsF7RXllyMg18+y7WEst5H9rXc615DEMavQ+pOTiVT5JN68taH0AL/U
 +9P1JZFp1WU54A6ujuOWWYogHRjK23VyAo0i8NjXbYL65P2skV9kFySmkQc3leWqWpuBR
 PcAKiveS4unKESYu4fXD1L/Odogj6NtrREQYJft8TSvc/jVJ/zs+pGfJ2962v2ws3DZSx
 xjdLqbnC8k7OrW5+qHx2pFIhiNMQzXA5WEE75kGBEKQM92eFvFHkJFy3Ianpyst5ZwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="cS20+H/p"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cS20+H/p
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 129CC60626
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:35 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so1367794eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262795; x=1792867595;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iwkpFUOEwcfVhVZjtvbwB+zogapl37ZTw8si7q749BM=;
 b=cS20+H/p4TAjo7WvCHMpxsxqLgbmNcuGKpIj9cCm0DsIUwqGwRBco3sJZp/X53bPha
 xOVjGqohIopf6D1+FkuiqMWA6Nxdm7veo6yOPXd4pUQE3coOup/zaJFKF0YJlL3cMR3M
 sxwszNWUtYNRyRiNJkXMuLrGuWuJMHE8iSvMgZftRCuPotdw39XQTHnqmNVRgc3cHhAz
 Eaa4xUu73lUYkA5f6fJCTS7Dvu523N5ez2mjOABpQGxUoCsf/IDTevIVD68eGe+lVfXL
 0ElLbs/QXDxY3nNdHh5EXCs0vr17IY5AqRs3QN/dDU+tvafRkOphYk1qWUzq6/Nt+ga7
 eQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262795; x=1792867595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iwkpFUOEwcfVhVZjtvbwB+zogapl37ZTw8si7q749BM=;
 b=HmqvoqAw4oZKCRREDHHNWSxO/8aC04eD3+zQot3jakGGT47QrSrtl2EumW77CMcyUg
 49r4jCUKJ4QCnJvZejCxFxw3Jkcll3ZIhpk+3LGN7gNciPNjXVDhB/n3lhKg5wcXAQbf
 +C+pDuGulnmG54Zj54fErX1/IKYELHwbL6pQoOn3Ws41Y4PJtP+MWKkXp3a5w41KH+/J
 zwkOtG+nInA8vLXftivnZK3uvhetzslA3gnc3/9cJ3nofO8tERAOBSPajQnAnGG6l1MU
 PoTA59h5Vl62XgzxbpEvR6rGt9ZRQ0nLTIAmLe+FxVyMeYr+qD7PmkcvseHQlhnrfB5+
 x2Eg==
X-Gm-Message-State: AFq9FYIOHR7n1zZ1S+VlTcLwxWejMeXJjXKYbU/atr7CXz0QchFjXSDX
 TJAvNC8xrcU07Bhz+R0ZUFgf2WjsQV5vKdFJUzNYFOxGFJgdTVE/hz1voqaq0wKu
X-Gm-Gg: AYBFou1Le5ZAVjS3GNeDQtIAWL5gh1+UqesDiizJDxvg7ebYbQnSIpnVFXvO8MBA+sI
 k67gt/P+VLA5/y2jB/cIhYoVFg7joCJjPNPxkFKzmvBn80mZMeNaFOzy3ZpCoF1sdGoT2hNeqg5
 ACzYE/y6st0tnkqOfxqXX0AgUErWOOj5PZOfMYQOUY3MjGN7WLFwxxTO17o0kWmqzzKIRVTSkLC
 Yg8Fia23EBOlXfvRz43tKv+nODD9v4Jv3tNMImeHmhllCC5GdoAL4HymqFgQCBTCK312p03RqKJ
 ZftH9XtyBf1r+D4PKjdNDxQgD5fH1rhIRHKLyIFD4Zl/5fLk/zNsgXA+7Xn++XjwKZ5jTKFPLr3
 iCSuxdkpOi0uxJH4GR3aIE/XDoGZrsmu7xCNpZtOTIwnirW62ysZPrv1fOyEl/l6S+ZyTuZ7X3t
 +bdjIkyMQOTyehy4Dz1TDCVnYDvbkmPFHqQILJ1O+PigltVYKu3+NnXwbnQUQs8y1EL6FP2EdEQ
 8hH7VoAJr5MwhL/5EdcZUQj3oC6ohQsN/j/7//Mxyd55LhF4lYzXLKgpU+uifHfNg9w5/c7dFx2
 ZrwbQ3qTxKwAE0qkGuqV33E66e/vpryMHJqz3pcIY0/lDydNFZ9Ylw==
X-Received: by 2002:a05:7022:5f13:b0:159:2c6d:fcc3 with SMTP id
 a92af1059eb24-18512e254abmr3626842c88.33.1792262794618; 
 Sat, 17 Oct 2026 11:46:34 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:34 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 4/5] virtio: sandbox: Let tests emulate the device side of
 a virtqueue
Date: Sun, 18 Oct 2026 02:46:21 +0800
Message-ID: <20261017184622.3925389-5-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The sandbox virtio transport ignores notifications, so a driver that
waits for the device to answer a request cannot be tested beyond its
probe. The virtio-rng test works around this by writing to the used
ring of the driver's virtqueue before reading.

Add sandbox_virtio_set_notify() so that a test can install a handler
which is called when the driver kicks a virtqueue. The handler can then
process the available ring and fill in the used ring, as a real device
would. Without a handler, notifications are still ignored.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Changes in v3:
- New patch, needed by the next one

 arch/sandbox/include/asm/test.h | 25 +++++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 043879002..d95de1095 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -11,6 +11,8 @@
 #include <pci_ids.h>
 
 struct unit_test_state;
+struct udevice;
+struct virtqueue;
 
 /* The sandbox driver always permits an I2C device with this address */
 #define SANDBOX_I2C_TEST_ADDR		0x59
@@ -369,4 +371,27 @@ bool sandbox_sf_bootdev_enabled(void);
  */
 void sandbox_sf_set_enable_bootdevs(bool enable);
 
+/**
+ * typedef sandbox_virtio_notify_t - Emulate the device side of a virtqueue
+ *
+ * @dev: sandbox virtio transport device
+ * @vq: virtqueue that was kicked
+ * Returns: 0 on success, or -ve error code
+ */
+typedef int (*sandbox_virtio_notify_t)(struct udevice *dev,
+				       struct virtqueue *vq);
+
+/**
+ * sandbox_virtio_set_notify() - Set a handler for virtqueue notifications
+ *
+ * The sandbox virtio transport ignores notifications by default. A test can
+ * set a handler here to process the buffers the driver adds, like a real
+ * device would.
+ *
+ * @dev: sandbox virtio transport device
+ * @notify: handler to call, or NULL to ignore notifications again
+ */
+void sandbox_virtio_set_notify(struct udevice *dev,
+			       sandbox_virtio_notify_t notify);
+
 #endif
diff --git a/drivers/virtio/virtio_sandbox.c b/drivers/virtio/virtio_sandbox.c
index 0f1ebef22..3b8a4d5a6 100644
--- a/drivers/virtio/virtio_sandbox.c
+++ b/drivers/virtio/virtio_sandbox.c
@@ -13,6 +13,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <asm/test.h>
 
 struct virtio_sandbox_priv {
 	u8 id;
@@ -22,6 +23,7 @@ struct virtio_sandbox_priv {
 	ulong queue_desc;
 	ulong queue_available;
 	ulong queue_used;
+	sandbox_virtio_notify_t notify;
 };
 
 static int virtio_sandbox_get_config(struct udevice *udev, unsigned int offset,
@@ -150,9 +152,22 @@ static int virtio_sandbox_find_vqs(struct udevice *udev, unsigned int nvqs,
 
 static int virtio_sandbox_notify(struct udevice *udev, struct virtqueue *vq)
 {
+	struct virtio_sandbox_priv *priv = dev_get_priv(udev);
+
+	if (priv->notify)
+		return priv->notify(udev, vq);
+
 	return 0;
 }
 
+void sandbox_virtio_set_notify(struct udevice *udev,
+			       sandbox_virtio_notify_t notify)
+{
+	struct virtio_sandbox_priv *priv = dev_get_priv(udev);
+
+	priv->notify = notify;
+}
+
 static int virtio_sandbox_probe(struct udevice *udev)
 {
 	struct virtio_sandbox_priv *priv = dev_get_priv(udev);
-- 
2.43.0

