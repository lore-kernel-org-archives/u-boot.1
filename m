Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qGy6AAa6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iLl5iMPQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C5BB607EE;
	Wed, 21 Oct 2026 11:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDDLk51aHwZo; Wed, 21 Oct 2026 11:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EA99606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580845;
	b=bWO/oF6NRy6GxBDt6tOD9FJy8jIpzwTeXTRBcuLRAbwk5JtEsSxqzsLkRw+6uBnwsZWS
	 /IApoPbRamdH7OTTHGPFalKy0gTOSnJJ/KClDfWKxrsIkAwJDlF8340SYuwOanl+/SyRT
	 UZaGAvlW39XU5JFWaqI/WyS0QLxYGfhUZR8dEeYZdhMQyu8+DeIlGPg1MSDJFOb1jBhz7
	 TEElH85RzByJOu3rzyy3RLi/N2E8ktWvPw7DqtBmOXWgCYX8TqDJjK5qfVtOJN1CoWeBp
	 PlKEzMHvbAKRz3FOTZpTeRrgYJpXyE07DOWaIszkRVZQPJc+C2+2Ads78DBn5qdYfZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
	b=ND57ZQudgluQPIulZyT7jyiPMsvLWuP5fuGP0B043As4nwv0T4xyB6nWA89SblpMSeRJ
	 LAaOylSOBG+13DEBRZZHP6jih6Nwi/S61fRqwtmmJ45km+rkyKXG6aNTKq+H8FHAEsh1v
	 FbzbGICiYS4nsMt4+lfUtgCYzFxIhNrsdAJKk0IzzUO8wQf2s/Jweo4T6CUZRYnBHO4jP
	 PDWmbBdyHDsIvQSVS6NjNhXTzmJA0PwV9rjbDhiSDJsBTdd8Cng2eVeUpkCHsD1scnGtJ
	 cBadFST+/8HDlhmiWK9aB2fojXMNAXL7YqWUJnGzp+U6bW1M3nxQmfuEIwwQvksklXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580845;
	bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qGy6AAa6QUs9gLKlvgpZw0eHMmY9bnkfVA10xoiCdotFZOrZZWoG6Cgoj9cIR4L2q
	 J3zZqVlg5X56ZG+m0plcdhbCM9jfR1Y00vp0n2QKK8Nh9mCF2rgzqRjVrg64CNTsB2
	 FUPgtJhu1PIBzR42VciAnI5Ripx7tdd2xbS5cNvTP66wjzHtGeuYSVyQxuA5WHN1PF
	 Qp0WstF8z3P1x7kXXA6ZNPLeBaJd8pTcmbEubue9Oe2iyfqAkXDoEdjjM0uQaWJcrX
	 K34xq2x+yeae0BFvUR28tUhWWv61wx0bZXSc8JFRSfgJGL/EbjsT6JNIdrf0TwKdiE
	 0p0GcaYYreyzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EA99606C2;
	Wed, 21 Oct 2026 11:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C4F23A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E93B5810F0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDEAu6R9f6l8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C478810C6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580840;
 b=lzfyuGrbl1FU6DQvyBbBXvjVVTHQBQzRxVDXdbeTGeADnW4tugwt2jRQEASSm9QoXJQj
 rRnxrARLyAOVMclQYrrxp0JrwGyJOj2JjsZGWhj0tb5nZa7iMjS5Uv3ifOnvHDq5OJDtQ
 FqAInWp1gLl8ae7l/HwrlOHE1H1sqTpwzhM6iKjSsgBQWAPETsWmo0S3dNYY0X3UDHsHL
 LOFdEqx1e3+EjRaW7SbgrNGy12x9MrOqc2ooefR+FPZjgd8UGFhhBmUhwRlRXCvZsn8rM
 zvLSAP3qahZCqPiWsJ5LLKvZrsqbjcL5QkBY9l2cl8oDvCt47f9aY17BKZ+DsQWjKQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580840;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=BPuu4uKlh8eqDphqE95zVwh03Mw4ecJdPf5YQTY3J7JCF4Wk5WAFPctqTCViKJAgkDaQ
 uBUdXUfs2yTSvhKkjY5WWRERBWTtluDF9y6qsfrrFq/uN6YqP3qUD70p2lm/g5bkFScQD
 IHEAQaFs9dN5a3PFe2Fjar+VxQkqCsqI/3tYzTMeWo3CB8I6wXdU0Kpp4+VP4RgQL+/vb
 Jn2wXMppEnjwlkfPDX4ExDrD00KxKI/seSQHhAihWVtCJ7fnEMdltrJz83yKebKVk1q5I
 1usgNGWN2zJHxcab5vKVBzIeVu3s92WwGGM3Vqi0KtRLSqr5YL6MHOqk+F2Hodpv+Xw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iLl5iMPQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iLl5iMPQ
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C478810C6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:19 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so478102a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580839; x=1793185639;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=iLl5iMPQL5x5rbDtqg7FDB2PDNXLTDUPH4B8vA9RykAJTYS4lTdbnpQ0Eg6e6mdJjk
 M55987tuNmYW6F10cHVNQ2EM7xq0KXy2mQ+FV4m0F6zVwYAieJNQAfXaDB73A+Iuc4Nw
 qv9FtIVV2z4D0a0QCYe2JgKE+mxiua6MZd6kd6Kd9ej3RPfwX3EeBh11BoPvo9qVq+Ik
 1w8GU11gaGXKRHW08lRc3WnfHauloWjHVtY+Q5R5EqsHYlv/UqAHiSHPVvJ1pFyr0rf9
 MwTx4Fsj7V/xOWMmw8qpcueR5R8Ncr5lBLrqKbA9GVGK+80qLd4sjhJeJ2aFZGs+a74t
 V57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580839; x=1793185639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=L9aShP1SPhXK5UUb3HJ8PzBw+93oiLvrSyG1rNODLIDZ4WhiFSjp4hkQqFIKM2b7Ue
 INQZogMf5nmZhsSLPhcC4hxNIYpD7UB2nlbxmKk4aVOykdn5K6EynFgHY3x1SsI6KpyI
 53CrlTWkCVzykigaqxTYLAmCNz/r5vwR2jF1kmFMK85+lHbuJ4R0P8NsQ19SjKGabafL
 pqjJ3+XuopgFCczCh2+DlmqMoYKTD/mp313OZMo20sWNxBA03ZoCvmv7JqvFq6rEsecv
 hhME/2ONAtZ/boylg2jeecCetcjdtLcWk5M4nQ2wWp4VQ1ea+IMqJ7AxZcnZJ/KqqwvG
 yZAw==
X-Gm-Message-State: AFq9FYKkR9I6rE7r244JvDYYQrCJL05+WjXPKeiFb6hm4B0ZfIbBY+EA
 NW5lXv3w1+t2/No3vDXFpD5+NjlVHJqlaGWGdYUyVmHadDrj/Jkef3wQbWoA0JE0+BU=
X-Gm-Gg: AYBFou3QJGyCrXK5rpLL8CzJF7nd9mLUsL7kP27XJh3sxrVx/uki+qV1gHV6Oz6Guan
 nPWct3g6vGtmYkPDHCrmWF2/3BrUj64yzWY/zzcK19ON7DxJyynY7l6U1guOKRZ1T40fxmDnK8a
 t1QyPlfQfyWU2GsRPySEJcxzA4eLJXi38k9BUhbAcftmx2v4zZViXm0QKKjDEeuzn4vpNOiKjBV
 3oa5e9WFvRo024u2OYGIfsJ2DKCh//0OJdixlKEsBWY+6gkAIKE1nxrfiDxzGtbHU0tGTv8RVgj
 M4/kmwk5pOooleLDya4TeNUsxUeCEkPT4woVrXl+AsG3RHOCv88e+cTIFwvHDfTJhnPcBvRTPtm
 CMYk5ZTz98uCST+t4QuM98rWdypFZ7DzWeDVVWd7b/cSS9dJ3Ucd+K6DuPWlzgGE2JrmayLJoaC
 mX1Bj1Vfs8L62nDlYjNEdHJZqoTmiGJIKf5fSlD1SFJWs7/Lmm+F9KhRwRNhEfsZCyvijHp7PKs
 4mnNqX5U789Ip8RK1MYHbwr666xq8Kyf9OkD1zCKQOHOq2XmbU4DOFZ5B5RhxExBvJ+Z+YeCkeu
 hroF9HBllAbWWZsmalbhGa/3QZKddS/iPU1ru+lY0inI9xFIe+YvnDYVZOlzn2TIbcGt1IHcV9e
 xlA9NXI7HX6vSM6ZrlUhSXwe9N/G1FVJzLpirnZMRKW6pua2msMzCxZFZ
X-Received: by 2002:a17:90b:5744:b0:3aa:ff19:42b8 with SMTP id
 98e67ed59e1d1-3ad86f6686dmr1516154a91.27.1792580838773; 
 Wed, 21 Oct 2026 04:07:18 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:18 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v4 4/5] virtio: sandbox: Let tests emulate the device side of
 a virtqueue
Date: Wed, 21 Oct 2026 19:07:05 +0800
Message-ID: <20261021110706.2947351-5-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
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
(no changes since v3)

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

