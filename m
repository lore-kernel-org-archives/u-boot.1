Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D048606A327
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NdQRJOsE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A5Ut8xq7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BFC34057A;
	Wed, 28 Oct 2026 03:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4wV8m8ytFpc; Wed, 28 Oct 2026 03:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2144840568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156845;
	b=taUjEtecb9S3PShxnm9UCQkUqbIg7fvqHvNgFQm9NtqqT9uAinLdzd2We/xAOPR+37KA
	 5/ppl3L31iPqayNWBAyDp72Sk3+hJrR48WLGu8InlpRIn1P65PAABV+giHoxiiHZ8J0h7
	 XPQVJcoToxMBD59aLkYs+96TZptT/WjuSOQiFWze6ZnKEmMt1rHlhHzqCEVLgjYC1XVad
	 UOYsTplkHtkEdrQbYUp0UCURWoW3qCGlPE5X/TAbAzJcSYosl695XwrviKHpnFTwhXEqZ
	 ApAnOzk8E8fMtZdh4IfH8EEfJucCyanKg6IeDxn4/Aj5aZnTrUN5YckiqJlM5+nuFng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ANigT+yl+SZ/NJijzSdvgLFoRArkYIMpJa36inXlQYQ=;
	b=aCmu4rG/IASC/AKnYv0h4FlpqamNADegmA8iA44uPrOn7cLfCsMheii2C80slH0IdLPP
	 3u2yfq0ZMdM+fbbxhmIHjL0hFaKZKu+0CqRpi9QQWhMbwC88zCoPkrPAFR+89nFPvKPE2
	 RiXueDa0o1LBN/q9b9w8CXd1b8qiQ+uNr26/KB2Nkjsp/QovOllOGt2fXi0c4sRZcNzNs
	 FyBsJI5+2YhL4BGCKktz/808+MtAMPMS1+00lIxZKldEE0Hh1rlWL/Y6B+b+tTONB/jnt
	 vOMfXgNT/JYrISD3STG61usV89Sc0fXsPUVGJxaiy/uj0FkBAYe6NnVXl5KKljnqpOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156845;
	bh=ANigT+yl+SZ/NJijzSdvgLFoRArkYIMpJa36inXlQYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NdQRJOsEGITlqXnb1GiUKZ0bFgJwRQuhZGEC1Pd43vDZ6hIml6WSKzpz/gnl0iZW/
	 Y2eddOwDPNl6mLu2hcYi2CnMLwnM0peptg0yFfghf/jaWDHDK5XW9if/P0CwCUcFaL
	 P57UVS1dL8DsrOnbDAwCDwXQ+RWOYI6o98pel6pS0+0b1M20QeHwlrfrSOX1W1ajaG
	 wyienkVRJy9zpQHS0uT7g+ZIxIdf+0W6/+cM241RJONApCGdK7rwNfZqEybgTsC4Gc
	 BjZgiXeN01lXgiAd6hHpwB6bPU2+Pslks0hShN/XTbfpPb2BhiEUMIN3YYfEPALoTj
	 36DDQ5U2xdWpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2144840568;
	Wed, 28 Oct 2026 03:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6A814BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5A756060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsI7tJP3IvM4 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBE0D605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156841;
 b=XgxA4K+YbHW9ZKO1F3z3+9HLaVL2vVYFN2ERUvuWGpXiU4nh7tpqy+nUnCLmY+O7zZb+
 tGnzPqngYpp50q79b3we9FGOSFkaQjmZ4ADhM/zDk6mPlln7HXxctbyPo/AZLIBhsyy3H
 8X4ZN4lL+gu1fKTdvGZKzSgeDdDYu075UQZeX7JaRXzOw8KGEXICuv2E1IP/XUSoANeQ7
 RG9dHg7a3tj5EAB1fo0sc2V/LGBC+/+CYWTgqaxqPexgHCZHlv+EBQxDSoYYXSFOyuoZy
 I0U2bvbNBj/o2o2djwqYepxosFaeGvM6axeX/A7ay9dzFBrlZ/3sJ/6HbwFcshYPR1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156841;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ANigT+yl+SZ/NJijzSdvgLFoRArkYIMpJa36inXlQYQ=;
 b=BW7wJP8DOzuVzsdBnlerFHFFYwVt2edwjk2/cR24yoz6VdxJHXQXcra8AczNCyO5Mo7r
 KiGJUS+HhB7D+pW6vejEPnLoLSg1kpXjIdxP3EsgT69eCI09fB4V5ZryylJyc5mkH1guQ
 01OH1UaKZN9s7qLHFUSS4OXOgKYDuMCYXJNEc6omIBHatXoJkQJnshEeWwXWCNd8l5JDv
 gM1BZth9/PNBf8ES/ZWQ7OsnDxp/+ZQ2y/cjbE/qQSZ+yYrJk7g7Pw0qjudn3WrzYFFdR
 /wHAHhw1yz3ou7dOxIF1BQokGk26/jj1cmuPBrjBVodb88AYhR9MbOf5dv7eWmliOqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=A5Ut8xq7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=A5Ut8xq7
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBE0D605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:20 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so442661a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156840; x=1793761640;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANigT+yl+SZ/NJijzSdvgLFoRArkYIMpJa36inXlQYQ=;
 b=A5Ut8xq7ttHow1iKcon2F3+KyN0pFp8YddYKCtj7ecCAE659/GCVzKZroKatc9k3bD
 344J1UGJhCK904eWp9ilFSbWNJcTo/uF7CPiMAFyzyZeHdpaY05cg7SohFPeF0+05f/p
 Nx7t71ppOXxX89Wp4pZYWhnKa76ZtEWbTb10/eSUrX4hGJc2ankkAfoBXhdllPgobnwt
 vhY7NQu+cCIBVKQ4P38HG1YjdypatX2upzKvh/bzuB6wPKG2TKBUu7hydTK4BfPGIfJI
 hRlI77trON5ThQc1uirMS7HYqdsiExMMo75ERl9VJGF1WojlXwwYspFFw1aprh9zLE8H
 FpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156840; x=1793761640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANigT+yl+SZ/NJijzSdvgLFoRArkYIMpJa36inXlQYQ=;
 b=jxLbUXkZI98HOmQLXuRasY9HQJ+uuzOsTw0iQ9CLxAwKppL4eY/DPimJ4YyTVwmJp7
 O0uHXGY0j6r5GeQ6uVm6Dv5qnfx8f3gN5Q2JRURo0E0rC98Pj3igrf+q4QXHawamDp+4
 j0m49Gr5opp4eYgE8LijchKWmHTz1woaNvR+OD/eESGlXh8jQzwlk6r2jwNVSprlL6qJ
 iT2Qw9H7Ag6FRmWo5ig3hivmJcOLbhMuHGYkzNCdrJIgp/SRXC6TuigK9sldq3xGMGP1
 cgW2GIhLlmvdhBpaIr+/ijjL3scIr6rSUP2sru6LyGlL77QPXicj1vfGpoUVBUvtHJ9j
 7T2Q==
X-Gm-Message-State: AFq9FYInzVSzvbbeujR6tZfk6VJKnrHWF2OXsde+BkImGsME0lxrqtsy
 kzfcJFrELMehe/Xb8O7y7xCL3qhNswC4wv0sOgpTOGhH1fbxK22qxOaqPxbN6yBx
X-Gm-Gg: AYBFou3LSaHfKhZJimMGuupV1DsCXUz/03E05SILoVyo4OcygyfUjJ1w65K+X0f9lNK
 iibWuO1Mxjt2M88l0BLZab1K7qzY9iv+BfMf3dqKxyKS5VuZkkSQsg+BqzjejK+XSTRh2QeVYwx
 cYB8WGRbYGhVwvnu5FN+j38OkUv6PPlpN2kzhjMNwhgWnXE1KCjiNBeI1+TkvmDXrQjCYgk3I8A
 Z6Xq3eHU3dhiiwynJDyZdoS8sAILDl8r6Sx9qK1ZXCf0So6Te9XNQuSSyAaVjWC2IjipFQNP7HY
 U7QkNyOKcVW+H2PvKgbc+2xGSy1oVbXwVZhsQV6HSp4q/DBly1eho4192hhadIpJofe+sTlaayp
 S07uv0UbmLHZjO9GzzwEGDuGg6MAPr3wuO0jm4TpVhTI3k8k+rU940iGDogtD4nO15QM10HoBIK
 zwp5S/wPlWnkuhSXTfPFBQBqHPZ863ZsT86rgmB2+XIOnGrMkMYNNZ0avr4bxjhUFHw/LHlB3Db
 tHn2Ys0A193ewaXi0u84XmxZBUQX2y5A//JhqeFXWTUROOvyO05e17dBx0Hv6xELY4d+rwSu5gk
 7l0533RX2LS3/G3j4NgsG/h4COJbFP4wbq1/ylQ5KjsEEAaAomdp0pTEgyBCIORTYCopGBz3TGL
 zs8kG8zcXxUV/7XmdQQYyL0ougV4/0GQsq/rodHIkljuMatj+jCgGhpEIR4gBuTctysQXmIMiQn
 mxQoNpHkw3CxeoYSNaKLdQMSKnAbK4vg==
X-Received: by 2002:a17:90b:288c:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3ae580a02e2mr838418a91.29.1793156839919; 
 Tue, 27 Oct 2026 20:07:19 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:19 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v5 1/5] virtio: rtc: Add virtio RTC driver
Date: Wed, 28 Oct 2026 11:07:10 +0800
Message-ID: <20261028030714.1608977-2-alan.tseng.cs@gmail.com>
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

QEMU provides a virtio RTC device (virtio-rtc-pci, virtio-rtc-device)
since v11.1.0, but U-Boot has no driver for it.

The virtqueue must not be used before the virtio uclass sets DRIVER_OK,
which happens after probe(), so the clock is looked up on the first read.

Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock, as
it never steps on leap seconds. QEMU master reports such a clock since
"virtio-rtc: Report smeared UTC clock type", but v11.1 reports
VIRTIO_RTC_CLOCK_UTC, so the driver falls back to another UTC clock
rather than leave U-Boot without an RTC there.

The set of clocks never changes, so if none of them is UTC, the driver
remembers it and fails later reads at once.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
(no changes since v4)

Changes in v4:
- Cut the commit message down to why the driver works as it does
  (Kuan-Wei)
- Say that QEMU master now reports a smeared UTC clock and that the
  fallback is for v11.1 (Kuan-Wei)
- Drop the comment on giving up after a failed request, which is plain
  error handling (Kuan-Wei)

Changes in v3:
- Give up on a request after one second instead of polling forever
  (Kuan-Wei)
- Remember that no clock is UTC, so that later reads fail at once
  (Simon)
- Expand the VIRTIO_RTC help text (Simon)
- Drop __packed from the message structs, which are naturally aligned
  (Kuan-Wei)
- Prefer a VIRTIO_RTC_CLOCK_UTC_SMEARED clock as Linux does, fall back
  to the first other UTC clock, and explain why in the commit message
  (Kuan-Wei)
- Stop looking for a clock as soon as a request fails, as Linux does
  (Kuan-Wei)
- Mention in the commit message that sandbox tests follow (Simon)

Changes in v2:
- Look for the UTC clock on the first virtio_rtc_get() instead of in
  probe(), as the virtqueue must not be used before DRIVER_OK (Bin)

 drivers/virtio/Kconfig         |  11 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_rtc.c    | 244 +++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 55b444280..48ab669f3 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,4 +84,15 @@ config VIRTIO_9P
 	help
 	  This enables the 9P transport driver over virtio.
 	  It can be used with QEMU based targets.
+
+config VIRTIO_RTC
+	bool "virtio RTC driver"
+	depends on DM_RTC
+	depends on VIRTIO
+	default y
+	help
+	  This enables the virtio RTC driver, which reads the UTC clock
+	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
+	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
+	  read-only, so the time cannot be set.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 6e7bcfc8e..ddb5ce4eb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
 obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c163b2fd7..c6cf55922 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
 	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
+	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
new file mode 100644
index 000000000..f164c75e0
--- /dev/null
+++ b/drivers/virtio/virtio_rtc.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Driver for the virtio RTC device (virtio device ID 17). The device
+ * exposes one or more read-only clocks through a request virtqueue; this
+ * driver reads a UTC clock, preferring one which smears leap seconds, and
+ * reports it through the RTC uclass.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <log.h>
+#include <rtc.h>
+#include <time.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <linux/types.h>
+
+#define VIRTIO_RTC_TIMEOUT_MS		1000
+
+#define VIRTIO_RTC_REQ_READ		0x0001
+#define VIRTIO_RTC_REQ_CFG		0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
+
+#define VIRTIO_RTC_S_OK			0
+
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_head {
+	u8 status;
+	u8 reserved[7];
+};
+
+/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
+struct virtio_rtc_req_clock {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	__le16 num_clocks;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+	u8 type;
+	u8 leap_second_smearing;
+	u8 flags;
+	u8 reserved[5];
+};
+
+struct virtio_rtc_priv {
+	struct virtqueue *vq;
+	u16 clock_id;
+	bool clock_found;
+	bool no_utc_clock;
+};
+
+static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
+			   void *resp, size_t resp_len)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_resp_head *head = resp;
+	struct virtio_sg req_sg = { req, req_len };
+	struct virtio_sg resp_sg = { resp, resp_len };
+	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
+	unsigned int len;
+	ulong start;
+	int ret;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	start = get_timer(0);
+	while (!virtqueue_get_buf(priv->vq, &len)) {
+		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	}
+
+	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
+		return -EIO;
+
+	if (len < resp_len)
+		return -EPROTO;
+
+	return 0;
+}
+
+static bool virtio_rtc_is_utc(u8 type)
+{
+	return type == VIRTIO_RTC_CLOCK_UTC ||
+	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
+	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
+}
+
+static int virtio_rtc_find_utc_clock(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_head cfg_req = {
+		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
+	};
+	struct virtio_rtc_resp_cfg cfg = {};
+	u16 num_clocks, id, utc_id = 0;
+	bool utc_found = false;
+	int ret;
+
+	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
+	if (ret)
+		return ret;
+
+	num_clocks = le16_to_cpu(cfg.num_clocks);
+	for (id = 0; id < num_clocks; id++) {
+		struct virtio_rtc_req_clock req = {
+			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
+			.clock_id = cpu_to_le16(id),
+		};
+		struct virtio_rtc_resp_clock_cap cap = {};
+
+		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
+		if (ret)
+			return ret;
+
+		/*
+		 * Like Linux, prefer a clock which smears leap seconds, but fall
+		 * back to another UTC clock, which is all that QEMU v11.1 has.
+		 */
+		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
+			utc_id = id;
+			utc_found = true;
+			break;
+		}
+
+		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
+			utc_id = id;
+			utc_found = true;
+		}
+	}
+
+	/* The set of clocks is fixed, so remember that none of them is UTC */
+	if (!utc_found) {
+		priv->no_utc_clock = true;
+		return -ENODEV;
+	}
+
+	priv->clock_id = utc_id;
+	priv->clock_found = true;
+
+	return 0;
+}
+
+static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_clock req = {
+		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
+	};
+	struct virtio_rtc_resp_read resp = {};
+	u64 now;
+	int ret;
+
+	/*
+	 * The virtqueue must not be used before DRIVER_OK, which the virtio
+	 * uclass sets only after probe(), so look for the clock on first use.
+	 */
+	if (priv->no_utc_clock)
+		return -ENODEV;
+
+	if (!priv->clock_found) {
+		ret = virtio_rtc_find_utc_clock(dev);
+		if (ret)
+			return ret;
+	}
+
+	req.clock_id = cpu_to_le16(priv->clock_id);
+
+	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	now = le64_to_cpu(resp.clock_reading);
+	do_div(now, 1000000000U);
+	rtc_to_tm(now, time);
+
+	return 0;
+}
+
+static int virtio_rtc_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	/* The alarm feature is not supported */
+	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
+
+	return 0;
+}
+
+static int virtio_rtc_probe(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret < 0) {
+		debug("%s: virtio_find_vqs failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rtc_ops virtio_rtc_ops = {
+	.get	= virtio_rtc_get,
+};
+
+U_BOOT_DRIVER(virtio_rtc) = {
+	.name	= VIRTIO_RTC_DRV_NAME,
+	.id	= UCLASS_RTC,
+	.bind	= virtio_rtc_bind,
+	.probe	= virtio_rtc_probe,
+	.remove	= virtio_reset,
+	.ops	= &virtio_rtc_ops,
+	.priv_auto	= sizeof(struct virtio_rtc_priv),
+	.flags	= DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index b981eead5..95069a2de 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -32,12 +32,14 @@
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
 #define VIRTIO_ID_9P		9 /* virtio 9p */
-#define VIRTIO_ID_MAX_NUM	10
+#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
+#define VIRTIO_ID_MAX_NUM	18
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
 #define VIRTIO_9P_DRV_NAME	"virtio-9p"
+#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
 
 /* Feature bits for virtio 9P */
 #define VIRTIO_9P_MOUNT_TAG	0
-- 
2.43.0

