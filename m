Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81185606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cFz/imdG;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XHa6IWv9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25948606FF;
	Mon,  2 Nov 2026 03:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xkS11P2bD-Z; Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2656960743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588698;
	b=biBaNZRd0DhH1x8k70uwe0NzjaZk6c3yRJ8JrM4pgm8pg+gTg3NJgcWTd/AZIeaNGfLs
	 b6JRsQtVzXZSX9V4NJSZ2FSeLPBb7v+DXRuEufyDAfRxzA237ix2IqRP9Kk9rLCVfcGlE
	 ME8ynsW3QGGxmL7Us/LBc611eBoyOWYWJmA+6MH93vgk53ZYN6vFiOtxdAhrQkLdkKf3U
	 4L+ej/5etkzFikKpvV51Q2VtOv2RA+vtkIbl3iG3xfI9aA8obatUKsyUV79lnh8OqURHy
	 DYo7MC45LAAUHZGUTrW/c/Wskct/yb0aA5pnj5DCQQ71mg4c1sgHSvsEr//vUbmzRTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
	b=LRZBdA+35Pczcyy11VjFPSo27pETcCCOiqLPd6pbEc+EmkgYRoZB/CCAYtn7/e8RoSUp
	 QL+JZjYq3omPtqEXTLMyidQvaimGq5MBoJEJWlUDTD6Tmmnb7JinIf3KKPlj0Jx4anXIG
	 MPFBBmP6P9pXoC+NvyhnOxfmX7GMg+TZZF04OFwLlrY2KjVlAamOYcZydGiTeP5ABSthg
	 zQJ11Qa+65X8yw3TE73GxdKd+9wN+YLH6U6m6siDPP8hq7H+ca3A3M3JWY2BOhUADRD8S
	 6mpKbpCcTkAY0PPJ0rpPllZnGOVQSDWH6dbgmQuFl8Lr1M0QPiPao8wU9MBzXnqI+PQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XHa6IWv9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588698;
	bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFz/imdGwleiFgUP9S+Xy+oOdeSj2yTqdhp3L7V9KwxhTZEHeovHFF2XE+E0f1CaO
	 Rg/1/DytKeYLmtiCygqgb9e0NcNOR6plYekXY1aUZHZtShTM8O/giq1wEeBXQCHuj9
	 jSqTzvHiM0N8mfFt9eGL+zF79A5XjdS88IYEjsKzcgUlzooDNjktx3AhY3G7iYnBDM
	 yjulY96q/0YRX2KdK6AXW39Sbmak6FItIG6++jrauKliJkjh0GPAKT+kSCrn0MK60o
	 jIcEG+xoFvT3SuWaJeFuEbUqyVbS/pPARuDy81Utctka6eOwW5EpjuX1JJt6qQOJAG
	 vkJL6laHwN6kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2656960743;
	Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 206AC362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 029FF60741
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8MXFfWo0gXT for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44C8B606FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588695;
 b=gsVYOkZHwoDDddOq8m4536UgenkJJ58GxikqQZ7Pp/cx/pu0k1meKn01DwHiAcgzjYwU
 ZvtI2n128tI4lL/ubl/5o5UdvdHQP1odkeTESX2ANefxM6DnHt765y4in4t74QuDfB7oA
 SYPLBjU1BIaSvd4o1yD107mmkgtBGrSf9yjFf7eYB4odtmqdGrmzV2xFOW8A4/9xkI3+M
 lNW/Icm0G6Nips1GLWJ3WosqzZBl853FuOets1lkNc85H0F4itkdv5XyGTpSMFcqLg81X
 EU0IO5l+JYhXcSwdXSfnqSJ2DIcGiF6I6Ca2KBIXEErM/GNpYHNpnz6VhtcBOltfaQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588695;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
 b=K18jTodFlsih7HkN8QTZCi34NMr+alguCmJDlRXNmmxf0vjitguXaqjuT30/gfV2umRd
 l5y8kwbIhExTmYLTC6asckYkrr5IT6x/LpaIhXUyt16nRUKjM2AKgrX7hM0BCAXAeV2wb
 Jut/IwqzNgxo6CHgA1qLHDHQH/hW8O1f2+fcvk45WcyPjoLbXCXlcr0Ln0rUgOT9Y6B65
 CQNJmLRGV0N+gKEJuZ7QGXd74za27IRivOwnvRSNko1WtAzj9i/mk4sy5MDzXXdfs8iV0
 haH6DbsEQG0OE+7gjUHVidwExE/fItLOAERCxRZIQzqwHeW9afw7/GOu6FanMY9wZIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XHa6IWv9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XHa6IWv9
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44C8B606FF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:54 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ae57dc1ea9so1158955a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588694; x=1794193494;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
 b=XHa6IWv96HYyAVzVoCKCrkT/LH3NfH38RO/eoygYFj8Er3KzayWNtY0TIdda3cSuqq
 hObBdVXrUviDnydT0KtdzpqK0kGEKiBJUd6hyGUCMVVnG2HxITSpUAcu4AI40J4wy4Vq
 Hen9vg0M51RpMM+43CuACz1K5F8zngsPR8z6uobbBigVgmIBD1oUFFFE/Sv1q/lYnNvT
 vqFEh8iZSeCkrucB1uW/d5RPEQVgRdCTZWySH4hPVL5ruB/9rXlGGVjfvdS+Rg5rzuHh
 hA98Lz5lLz//0GU5faUHPggZNWkKCZ1LlLmphv+UgIj+NuLbcFII+JDqJfQp/xVfzJG2
 E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588694; x=1794193494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuNc7seWDLjnb7xvtLz3WlXb89s/8okPW3AQvCFwkM4=;
 b=fkyrQHA/19gnx9CplEOlVSZ4UVruqqyfsUYALnUkEMGNBNTdWNOeGaLu5SY80XyMff
 Sw368qcQICzQXVeHY3UQundE3qznS3Ge8PesfM7wq+CgncPIml16HrRP93MrUjvo6XeY
 ohvCojbN4bb2y9B1b2WBoAv4VrOJGuIg3XvQeA9BOIc5butUtDr21FdqMdBqHXWW59dT
 lozZzQbnRD8K4Dz7ePR7wmjMLNzsNMfZhHcHCQ+i4PfJ8JageADT+0qCUuIv7vZp96NH
 HVWZIKQzizoEKZoJdja6h53DKWa0sN4repMUIBXV1ZSC6oCmezdFo/Ny22AE9ER5JeKp
 ZH9w==
X-Gm-Message-State: APuU4Z8IqUEX2ifhluuVcEur8gBNvkcWUkuX6BVv/9OoIXdcUJ7mpmoI
 Au1HTZX8vdjYILGvXmotu2vAxyyg60g9pjly8jWtQ+4bSs0WnUPw8xk3ji+sgqd9
X-Gm-Gg: AYBFou01K1BIYjI2JhtsdejOUqbdYFmTpQrG1RCUvlisko27iz4eXihp4MGlapxVM9B
 hie/InaXJRFttNn6gtzTdtRXfsZwcet1yTkMdLSaHKAEbbwC3CCZaXAikV2dFHGvVi6U94XCQp6
 oGx4MrxiWT2P5av3wdPUSdF8MZluVQ80rUe0HG/F8CurWnhWk+fiDUtAWP1gIZ+0FrGxygiQQDp
 MV+zIBQHphsroEw9vKHY/dXPxDe/zZuZ1v5viBu7nQrjBpYOd9aa640N9GdN4580qSKGogCY2Fi
 r7MaeCGnAnrj+BX0qCB6QjOXEzho/MxO859LaA6uURjIRMrI0nmdHEhtwv3/ozX+Yfj7p97o/I7
 YD9Pn4NLPz+5MKAtGrg5HG+FGEWY9Q7Tuy35dKhixZ7ahvF01FYORuBfiCYDjXJyUfK90JueTl4
 op8BLIhkrgliHbmAsRPCnjON7/jVHwTdOyplPJk+OaNlnF+tpRdGdxURJWzHXUYkxsnZlGRVQsv
 5ydWBvbH740vQHvvoXsF6DzaIQoJTLgapGIv7wLG056dv8MD39tC3333au1yoRLD3ge1V7hFE/x
 p3sZxQCgIJTXL7O2dGzCMO+D1Qka4fmtHkP25wt3dY45nYAAQTgjLqSC//6Guk+pugtt/PKqK9N
 q+tESsIMn/aH36+E2dtu+zgTweHcp6jSDNMVq3YcL4zEuN7bBLqBUInVseHNotYypw3Vnk6vwel
 yyAWT3uc7Igw==
X-Received: by 2002:a17:90b:1e42:b0:3ac:a1c7:20fd with SMTP id
 98e67ed59e1d1-3ae8957d4ecmr7460642a91.4.1793588694119; 
 Sun, 01 Nov 2026 19:04:54 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:53 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v6 4/6] virtio: sandbox: Let tests emulate the device side of
 a virtqueue
Date: Mon,  2 Nov 2026 11:04:40 +0800
Message-ID: <96b932b76f56f38444f8a03df545b92006ab3c80.1793588058.git.alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793588058.git.alan.tseng.cs@gmail.com>
References: <cover.1793588058.git.alan.tseng.cs@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

