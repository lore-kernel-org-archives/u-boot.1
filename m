Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FB606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yqfbXQqV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OoTL0FE6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 913C140568;
	Wed, 28 Oct 2026 03:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87wh21t6uyMA; Wed, 28 Oct 2026 03:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9A3B4058B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156852;
	b=SjOZ0m+0Qb9GaHRetkf4rJzDHIAUGB4ruF3OWFO3FPcV3OCcrf31VySI8l3X+aFuQ4YU
	 DYwEzyAQQMbvQYRTcKY1teAqt8Xj66lAP7ICzZ6GUoX4v/pP4qI+LSVuoQrFmEPAj+tXN
	 pX+ab1zZ0w7dk0Rt0xh6l6kO/IbNJ5W2jv0PdMem+B2oiwxk7ZpHZ9/VnuVd410pCeFCC
	 50cLxI1Y8Li9FLrbCZ1PwzamoFjXnm6LJ9Vtn1ZLO/z6TwvmWwy0fIDYpTi1wB/7GMv3/
	 /wF2ACP8zOE7Yp6UV+qlAEc+1CqSpA7aYqTroVUu0eeIkJsDtHP7pHBgobeZRa+Ulpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
	b=USca5IHrLmPJStJ8Rj0eg33cAA+UCaDg/mh1Wes0km+mUWG/mhgsz8C24m8YvloVnN3H
	 6GZ5t0UIOtiAnDokjkgPrQ7vNb7aut1FQVn5Lx1bnTJLWsPNLQUn4GChz9uijJVJ9xv0D
	 ixlTwYKDhOuEiDsHXQt1ThRIga0/iYFnN4i9gJ7Xcg4oWHHhAQO/AtS4G+z+WlyHLJc2B
	 zQxHJXcxVn4Aeo0NmYv+821Q7QEyJKJnfOZ7KjIBVIK5+J8St+sR4vpwznGCV8qIpWs3P
	 TQyLPAPwFKJXeJdvpD1A/iMkQNspqJC8RtgWE1vwTAWQFT5dNHBqMUvZR8XueKZ+Waw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156851;
	bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yqfbXQqV77uGfFcSARDckRVdr5g5ATvzBaxT6vft2dqamAGAKTHIyjqxCbCSyaAA+
	 EtFK5tbLSd0hv04wahcYzncfZ2vFje9LEGbPf3o8P8Noxn9WO5AsknkYvJXy0vyeUX
	 g/zSvt8YDw4KtIIrzlPuJckZEe1lbik5bOdx0UGfRoBuc3p0x0fY3RSXQ0W4hhGhqM
	 z3/rwj6k4TBgypA3eJCGupFG29x9JehvWLkqcuMJvU5zU/+6AFuM9VxE3rguCZyYik
	 UBtW7AiuLYEDW60LbNnbCSPUuEMjGDJ093LplHShLu/ITIUBWbKGSU/22wc4xUGBB1
	 FOIh4/adAo7Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9A3B4058B;
	Wed, 28 Oct 2026 03:07:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8F214BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AA9E400AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7fv5_uuu1Nn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CDD75400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156848;
 b=S+QaEyCkm2i/GKJtUfRumSTUivYzwwslKceEvEZGIzLIBoVUB+TteM7cInnNSE7KFH4z
 sNMiAtNBLuKrLCBM1yAu75Z6vItCxZSYRl0bQ5k04mMyPdY6at0eFaTQ1Bsq/nI+anqlv
 dIkFl3AFivVBzzNWdowIXXfRi+k7QDULML/I3e8nPTlh13WOynfNdveS1QREMKQKxr5X+
 NB6Q6Wvj4WZNKF4OAOmYt80IrrPY2GBgI2QAQbfNuZCyiSJ/Q23rmejkqcBl4cL00S4ka
 RIAVGzt30zwcyVlhJCaRiknDomQZROk7Et5HPMDZgqqxXgrQvWbdXy1L9dd/nTCgpcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156848;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=D2kbwiR9NeZrdg1WIxQyYD1APmN1jFqbz6b9l6dkCKoapTV4u8RYH/MMmXw1kJ8fiW/+
 PeXp/fXCbu/+1sq/SbEYSOGSR1f9x8ClK/IW+MjyPttyt/KXf8yJzgmR5CvxLe83MDa/R
 QrdOvt81NibrhfkGBq+UO9dhRe49a2mV6HkMniDUPB8DRf+MSVnSLTLsvoEAwTyeqd5OJ
 AOD0HQG3Gz5hvjuH514iCgZt7+WhN90u6yFNKCt5MPgf+oMIYKNvEZCJOuktMSASVoHAZ
 b1qjjQvymxdTLKuQ+m9WSvmAWFHxVICmhjXtNRuzSIyfwpy/E/PB4R6hfGJlH4cbWbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OoTL0FE6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OoTL0FE6
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDD75400F5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:26 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so421097a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156846; x=1793761646;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=OoTL0FE6amyRtOE7BE+1yypJUbOIv5rNgg++EIoPw3zCIB+8zjAtXD9xwkK90EPzQ5
 +s3DToUA4DDSEg9v0/gR4nEune5IKYxzjrll5lkRzpmmQ29Yn+/UVT4h1y6HlUKw4TcC
 Iu1pt/+CMZx6YawKCn1Lqp+e0875hZiHLpvaOUokNzbp4ds+1RVfchdnHkgN3ssXnBCq
 LCkpjITSKjZ0HfNlJ6FO0rkS7OWA/1Dka7kBVonEEKoFjNTIgCJELXRBsUA/ws9qEsFa
 jZkIhaEuKv67ShebzFIsGcCmmM09KkPlMV3HSNlGmVX0vaRuAk4YHRCmILfsIL0Ud5L7
 eAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156846; x=1793761646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U83YmBqz3sSgIIJjkpgaCl2cjHdydcHb+q3UzSlAu5M=;
 b=2eISlJHp3K86g1uSDmXTpG0T0WHRyUrxJJrkK0BuoMpyQoAe2D/rS1O5DxJKc42QOe
 7NLRDJf/sJDT7v9RAeu1WINs8prdNyw4/9WHPVSCvfZxaPrm1oSIMojPKPfif7kTs9S3
 NuZj/Hcjw8frBedb5akPbR3Wx5seUn99Jx8RZLWWD0hRmUaD8MGx4h9j11Whvf5pHUvC
 toFtwPXBy6lP7J8OsirR7cd4hnFNDpu9hSPPOLZFiJgkrzeCBmD+7TxOtmUN1SvbsfSr
 XS8eGud4lC3ZzOlUr/x4pjG5jIXMx2hSDSuu4u4bJ7moR6ZAQonNLD0oFocYxDu/ZD5y
 oO+w==
X-Gm-Message-State: AFq9FYKQ9LaxAHFz0yntaR4vH/d3T0Tntf+AYXyq5FUPwpowtP6Pdm19
 +6RRtHRDKR172xYpRxlPUN8otI2Y0DaRW67T4MkLEHRJmYiVvPn2rP6PL9+jIzUP
X-Gm-Gg: AYBFou2klRy8lRhK12GiTOM/wi2uV/MF1OsGON/guvad5Lu8mwMdCxx2wlKfQV1lbW2
 LBkJzI7RFLpYYbzXpRcQuxWipE0c+sJicoG4giPBQy4nk5GzwOw54QI1Kx+IUd1NSXRS3ZbEAcB
 NVIaDRWEJNvIbWTE1Rl1JAPMFvzQ3B8+RfgfH06vIdBs1mCL9PQxM3Iffdm+aGM4VGO9N3D+GYb
 jAPdalpKEr2WKAPFkqdnYTD9G4PjP50HUpOQ/2WRIYP0fbY2g/0fGH3CAS/z2C21nYN6kPcPpky
 hTBQZYBTTNWyTRBa9E49Nfkh+lA8b2XchsHWfu7cINRTY72BvuSsKERRHWUWREGcUZdM72mwck+
 vkMOJP8OpUeKsSZCpgRVm7m8/2/qoitfCcFsA1tY9bu5ZITMbJ8p+6W6806Eqvggfshal7CSjy3
 h+T6/ydbyQWBmpx3zGeNXkfeJIVD3DTUqQ1aoVDgeqaZYtwtEJIIz7XUfHkcHVzYi13zJWV4HgG
 dwx5tib90kk2QX1/NjFNNH8Kg6L/gyEHQvtLQMm6rZbCfy6iFmmO0rvx83v48wdcmQfuUr7S/ae
 D0ejOjxDSlKwbFccEMkctdBcwjvZMcVi3NcIcTmagxoq9A1KEkLfl8wMH94NnvNml4A4prZKu7M
 Vnf6fI1OqAP6NiyM4DrOhhTBEKXYMTUeIGvUfgHhjBqWswMsJkdw5SbvBqwO0Kk8UcWhhTuwkRk
 ZBi5zass4r
X-Received: by 2002:a17:90b:2645:b0:3ac:9d26:551d with SMTP id
 98e67ed59e1d1-3ae58313b6dmr786167a91.50.1793156846041; 
 Tue, 27 Oct 2026 20:07:26 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:25 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v5 4/5] virtio: sandbox: Let tests emulate the device side of
 a virtqueue
Date: Wed, 28 Oct 2026 11:07:13 +0800
Message-ID: <20261028030714.1608977-5-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
References: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
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

