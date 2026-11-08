Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0668606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=soG9zM2Y;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEBS+sVL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB2FE60758;
	Sun,  8 Nov 2026 23:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6vQfLaZJ6j7; Sun,  8 Nov 2026 23:34:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D13CA6070D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180865;
	b=tSMBEcs1wlqELgX61W9Qlk5geWOakqCfd2sz2ao51w5eNPk8IxvgjjJC7PCn7xTI41a6
	 taFoV+jYZfTeRU2+qSLf3F1zEk3do1E9MT4RuOhyChfCUViIvQuS+pLil07gvlfefuPVH
	 jwkPtcnkRHwBR46rRxnqdFslqHSpgKCtIKJK1BVwB3T17FX27soSttfwPLB3uV0tYflnm
	 /VyKy/K+FrkI9fJ0JK2rtv04YQl/6xA0v94wwPv8xQiMdzmbieFD9MWQdyALRarJzaEtT
	 Ai0In1gU4SfkAQl/I+9kaFwoufU4Cnpn39IxMYgvUFNcRuOWXRW3M4LpvN54AaoQrNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
	b=dYU5oFqQFVY0ijQvaylmurmOUsQudXxKITmL/eCk+2VnVrno2LqGrtLm/vFno6sxpldz
	 1TJ91VZnOMiTveUbIMFltDJpilohg/5IE+iEoZol+aM7CC1YvPPN87fYtERhepJMfRxCy
	 /L8mRXRIbWTNbprU0bwya6kIGJMF7HXasbIHQe72oaPJny4VUr9dpGElepVLmCqK9PXQZ
	 KrImW0/utyLyVHnmJQXvrUfNtINZLnwat/nCIuIqqV57X/PdinKuTmrFgfaoT5QaJOfRv
	 hsit22e0bvY1LsXovO/WwWuU9Uylj0f1EHgyGSDbTc7TgGQv0mYbLPKeNBCxRV8noLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEBS+sVL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180865;
	bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=soG9zM2Ykg6F+pSEAc4uZptHKQereI3ubdTglKOXCHc8VO4SUrmte2pJIaFtuYCKq
	 wAywKccYhp4vs9xppxLG7CxtW0+n2dMa3mzrj58vyE+8XoEFeY1bOxZodGhPe4RX5I
	 6MzHc1FusV8QgOQaSVTdEsCRB1cz5DHjAfwNltvhOqLkGYu9gbImLWt+SnLy/dvB0y
	 Gu8DqP9EWNSbxwTC3gs9/iinBeHyTe9Qf7g4NLuy2uoKbvzSdbsdzaOCwqsbEBwKFH
	 gYle6Cp0uzC2OkxdzHf9REHJlU70lzsdG8yz4xggumLKodCNuIk0I1D3aiopQm2nPP
	 OwU8tH5sDyFzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D13CA6070D;
	Sun,  8 Nov 2026 23:34:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 342D8932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 221CD6072E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x52X453bqFHF for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D271260719
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xEBS+sVL
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D271260719
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:19 +0000 (UTC)
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso244517c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180859; x=1794785659;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
 b=xEBS+sVLJHrflFSG0/nFs8qTjhQhFwVr8g7EBs168ONG5RwQIPcUyuxSUdMGK8E5Xv
 PtedkRq/YGfY7j9+o2m3NMoI+7w0Kopu6Z5m0Oin0yrk4NT0IR2urVFjUh0Wy2VJ01yG
 nxn2i9joeg6z45blvNkVo8YGXr8W6HMgfWopyNLdln+ij0xrHTnaT0C1PxdjxVZMnTdE
 7gg7mlDm3hthzvyKBnIE6U6avuCyJwZcRsZkRYwhlIRG+xDuJq4fHOG0V+IXIoCPgYqY
 PFynKKSWI+3b6G7Duyozin7kQeE/BhpKhK9hoKlFb3EZZbtX0D4/gYz9cu20567ge3Te
 qeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180859; x=1794785659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
 b=SlbPifGYYWPmBGO/zd7xodB0gcnNPwA3lp7ueRSQWolhZ1OWojsxxtHEk2lldYVFkG
 WFwOkQ5GMCPUB8D9JRPfUIam7cSN1rE1YKzF8+oHvKOuB6q/X2cL5nTTzhGZqcHleqdX
 AQEeugmk51KWqbEvDORgwhsncs4wfahZyrPgex90gsoh9xpUd7nObGsMSLQLNAVbbBn1
 OOQ/fZDc8Ln5zwL4zS037jh3OrouAl1C+Or+wqirZdqoxh93nScFEln+6UJZs8HHabqe
 EWYPJc/Vxe730r6ygZAuH3nKK1WQxjiWrMJAYpsTXCrBgsFjDx4hKAMtwS/FkL5LuemS
 Tk1Q==
X-Gm-Message-State: APuU4Z/TYUCjj3Nc9RZ4Y0A0snxOv09nWsCXfZXEwYzKtwv1icN0vwyr
 jVa167Lb6WD4h4hjqnlkAsV+cF8Gxa6g4kg7SWFjvQB3q8J/0cGbEiMWiVQhbSf5
X-Gm-Gg: AYBFou1Yh98RoeAt62SmjZVKBESpnC7lSicQrSZYw/QH6qweCXcyTewmOmk93KNAsqe
 N5RtqMT0QX6mv8LCavIENFo+yE3rCLM6hLN3Vu1q+LRHOzLi9ghPBxflPy5tV1frYJIyLtwxgx2
 2m5V3Vhe4WXJmrUibjmorz+l/CVpjOdDmt2UMNH8/6+hmZ3hoRluvuna5GFUXMOqiDpof1bVKSa
 q1O9DwHzB5a0UfDRMfX3M8ZKfZst19i1mVtxVvkd5oWB6XMZh7dX7fSwIfLKDuMZyqD8FLHcqV8
 fOcHGYZPGjswXnULkbSAFDE2eUFOa4vHn+oJj/7yWxrG2kkIUIIjgspeels3nk3cu0cN1JjEPit
 E278NN90XgzjkVqMNxKV5nGHCdugg09u4gtwM63Z3RJf2spoupva1MsVD0XMYPAd3prvoXElYnO
 knFIhMWVUfzasd6pKxvVfbQHj5ZO1JG2uw7S2yE37Fzx2EU9knBYwuZgbGBzAzqVtEYLdvs+UmO
 W33QDNIGMXEupEdA7LzwVlJ65Bp8ntrwxDzV1hvOTU670UKaJfPdYAdGylFlbwV+hsM1SWA51a5
 PxyTEJ74H5zMmt5YFlnkHRnoyVWqxAfuE35ieYUA4ODjDqaUyvD+1EMIj42516n2I7nBcPPZuT/
 5kXPECyZZbr4+2I2sSz9oFoPk6CiLOsxaNxM+o/zgkZfDFyarEgGUcfOpvJI2rRPEbYSsKZvnDJ
 nwinjvp/SG
X-Received: by 2002:a05:7022:29b:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-1b39fee1560mr3950167c88.46.1794180858551; 
 Sun, 08 Nov 2026 15:34:18 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:18 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 4/6] virtio: sandbox: Let tests emulate the device side of
 a virtqueue
Date: Mon,  9 Nov 2026 07:34:04 +0800
Message-ID: <20261108233410.1556875-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sandbox virtio transport ignores notifications, so a driver that
waits for the device to answer a request cannot be tested beyond its
probe. The virtio-rng test works around this by writing to the used
ring of the driver's virtqueue before reading.

Add sandbox_virtio_set_notify() so that a test can install a handler
which is called when the driver kicks a virtqueue. The handler can then
process the available ring and fill in the used ring, as a real device
would. Without a handler, notifications are still ignored.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
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

