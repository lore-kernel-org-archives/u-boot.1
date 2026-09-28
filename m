Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C0FCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0B0A80BC0;
	Mon, 28 Sep 2026 21:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnqB-7XJle3l; Mon, 28 Sep 2026 21:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F49B80B33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790631024;
	b=diwU1xe6SSv4JlEx0tR9JY7rz6o1EbSFORWQ1GKuRUbylc6aakR6TjGIg7k3mVhY229m
	 Mj0vlQO+nypzlqPWyY/Ab6HfeGB0BCYNtCxb4ZpBKmNCoru13T6A6b6WFfAfayUFerbWI
	 b1xqMmvr1O+L7rF8DTH+M1pORc21CwWRLkfBQ5uoaUlJEa5poHl+m9TKfVtsbI4KZAdWy
	 MXe19GQafoZ/qVK9iqqeLvc82yqAxhoAkEAbpLS48+ex58r13ho+Yar27Os8tWO2jP6T5
	 6orySoehT0tXsI4a+7E7mbpQu79vZ9b5jctE16oGyz3SLH7r9+OgdOJ2SMNkyT4ON+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790631024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BKgZiabKD/09bdgVc0gYhUMnR9fs2RAlIt9DS4JCyhY=;
	b=oeBeuTTmQuoZul19ZQr4siBwK7vxeNXwBANc8cXlbNYoFRIX4/rzPG7jIJwinTzjmXHL
	 /Fp2ZzU5PYTzkYlWqUJlsx/SN89fqHTw69L6ovu+tUBSVFbpdXv4mU6lmQQCB8shQYqyR
	 t84RVGty3qLYauHQBsA+S3Y2vXc3omOZIWCdpYSmAOQSFXiXWubnll1qQCHNPgSyclLLN
	 h9OgrIcfw3SoHkZlZLkAth0pu8a9ZHwt0piZFN8kA1XyoetpxyGmZSVTkqh2fKetBCBSp
	 W17xPa8bbmjJEdlfQNAwwQxLyyTXNtp0K0bv9iopibf3YeA5C3naFllvej/4fza6kEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790631024;
	bh=BKgZiabKD/09bdgVc0gYhUMnR9fs2RAlIt9DS4JCyhY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v8l8/eAF+PirO65HkrYzJjUfF6kOTltUypvVWCvtjNLlpbpgfJvU3NzlsZXGohrm0
	 oIyFe2VnB28nGwaDpp3sz9cg0nSHg9G8araV+fIz7HW6RtcbQh1OsyU7ieY1+0K5QE
	 WfCpJWgWeGO0pFR1ahHXJnuSee4gfSJL0UjdrgFT8xfTUGU36SX2lv3CHXUCNgKpDP
	 fonpmCV2Y4yINBTOtGyzpUXoup1iCamOTJHrGbwebTN3f64DFFJKm/po/y/+OyapYx
	 8guNVH2WaSHblZZ46YoRNcgyHL1Tyz/7ZA02YoKaBXqZRWoPxx78ynaCw0/NvGdvuh
	 z5kXnxIj2AG0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F49B80B33;
	Mon, 28 Sep 2026 21:30:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E248A61
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3B0040528
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRBzs4xjhXHY for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:30:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8274E40523
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790631022;
 b=V8oNmQszPCULDlysIWAI2n0Mk39YSHsw/gQ+P7rRpQzkZCpDoMGdx83pnr71K1gwuGaa
 3dyTIPU8QpPsAhyPdL8Q0UIyUNYQK/RGxaUP6/57MydPv7Cw3sUiOBUTUwWDgm+KcVawN
 gxFqF+coveQGTK0fDonIe5+OgzBOA9yc1RuEdILHAwSALg58NOXXJaDD22NVV34SI2/QS
 CWHPi+8qIfJrE8ankAUByiGxEFJmj6Ok1HnZ5PhWSlfwlCVT50bpfX0nbApVnRJVbFsbD
 c2UqwwXLD/MGRiwOQVqjGrH3E9TFoT81mZqAoIv0pA/sXQ/egptYFQHD91zJ+UrEFbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790631022;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=BKgZiabKD/09bdgVc0gYhUMnR9fs2RAlIt9DS4JCyhY=;
 b=X4V0yxXyxaG0iieZxWB7lbE6BFrTAGhxBGQPaplo+bhN2U3GxslA/8JgYh2bSAsYnwxu
 bEgu3nD/JFSnha+fsWiZljIJ1zx45NzcU6sfmfKO4xgqbCFApSCu9TmnWNj6xeeIXNJji
 PPJN7jT59pakr/3/6L1X0S0BM74FLH3V9bMb73ZReTJjhOt9c7Hu7pFd1PCeAWY6nC50O
 iXYvFTXm7WWHuGHSMx2cQ9/YfkiwULD78zMV6zgDHs7S/8NRpxZGaxP3GUKzFheri4ThV
 mR1LuM6uObHCGw6OIPXf8NLNVUq+rSksCmYCtemC731Jl4Ni+wtOT/rGsFxThhggYjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lbWNRbNF; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lbWNRbNF
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8274E40523
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:30:20 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4e1dso2644151e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790631019; x=1791235819;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BKgZiabKD/09bdgVc0gYhUMnR9fs2RAlIt9DS4JCyhY=;
 b=lbWNRbNF5/GjvLhbnzExTXltXrt0jLtvlqdFPzkE3izSDJi68tiSMnSQtgBFrZTmvN
 oXlm+9oqif2mkgNP+otIdXO/S+nPvGd/xkRu0SotqkuTqLXJG6PT1/2qIVMKX+A2rKey
 y6AXowpmB64Xzkx+j9M7zA20O7dRggIKoW3oF40zD5I+pQpXiCr+jjSCsZl2KarZpxoY
 8pCirj9la4qOKyE5X/lKm65Uw8yOJ4mIUkk8ScF05wH4gEp7e8q0HKZgiVT0a+Ppkiqy
 Hn9Qdec/Ma6Npspa59pm9YQN207Vhw09/yKvRNJv5maaqWZZD3UuPR2DcHkXGsVhIWWz
 8yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790631019; x=1791235819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKgZiabKD/09bdgVc0gYhUMnR9fs2RAlIt9DS4JCyhY=;
 b=KWIR3Z63vs1339Et0RkPF9svun7Wrwj7z5CzBvz31WmZtwvmC2r04nyk7G9SaL8c4N
 b/al3wVDLkyMbVseBGSl6le8m/rafHQEFEN/2bUfpxweXOyPqo7jzho9zby0rC7RANS8
 ueiC1fFyLCO/iub91u4P9ogca4DyGDvaLl2nSszil2jze3HAGCljkZGDrx7ZPZhV3rNf
 Lz8Xd81aivilgvCUGXz4ExmrurY5nPPI6FYee+tFZoJ0yhpt2bAq305LpKMbgrQ3poMd
 kttScSo/d3E32S+v8I40Kjn2IMvym7VKrSYIiz+O3vsv6m4j2jyTb13eWXOfVdYK61/N
 gi7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnzsv/0tFRqfSAf6Opwf6s5BhAly/i3PWp1qwsmOrYmagIGEX799TjqmfoXfl8YSrRjkgyDZ0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKr8iFY71y2/AWNzaTFHTOL0eJopf7hp082KfzfOiV26lBAcb9S
 iz+NNzixGBZlImAatqMAMmOApIhINkFhp2K7ruhmjreWLzw6NaEf1Vg=
X-Gm-Gg: AYBFou0ZgU8GAV4FRato5q0U/N/oEnvzub09g5sU1o/yWIzRLXUJlzxICcrw4DrZpn6
 xEBc1qjcJwfQVrFltIr+tfX1cGMSqNdVJfTl+Jsh6Gm/yqchPeh9itS70rd9aaBoQMd29uG9dzb
 5RZFPZDgQ2MRh66k+2aryiaLVcjVJbCXnZDH0KaXK11ln9Zm/WpVhqjdwrvTCMJKA1R4UC4QC32
 J0w3/nO2QQ0gx4SmwUF3LSbvEH2E4Nx3oYwUoKOR1jYIpZ3HIiq9wMhChsuVBkU6wLomE5ToQ7g
 W76oT4bb3/0WV0YeHocWESuCAIVcfNeRi/xp8wltlDNLXoo6uFKFso7n/HhxWyr0Qv/RWX69LRw
 IOApoA2Kcb7GTiwewfcWoYUNSJa7R7nbhuOsF6TQfUM8iSJql4b3Tu8z4ZXv8Im2N21zcxxrxGs
 t7YaEkjcIm2LfeoCRqnrqQPSwLcf3a0IO8F8L7JvJYlDL4K1bAjqQYbT80XX83OgqwphEUqjA=
X-Received: by 2002:a05:6512:3186:b0:5b8:c159:a4f6 with SMTP id
 2adb3069b0e04-5b8e09c1137mr5294445e87.16.1790631018387; 
 Mon, 28 Sep 2026 14:30:18 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debc2f3asm831309e87.69.2026.09.28.14.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:30:17 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] net: e1000: use all RX descriptors
Date: Tue, 29 Sep 2026 00:30:11 +0300
Message-ID: <20260928213011.290839-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The driver hands one RX descriptor at a time to the hardware and points
every descriptor at the same buffer, so the ring holds a single frame.
The legacy stack mostly copes, but lwIP opens a TCP window and the peer
sends segments back to back. On QEMU with e1000, lwIP wget of 1 MB
takes about 300 s; virtio-net transfers 20 MiB in under a second.

Give each descriptor its own buffer and keep the ring filled. The ring
grows to 16 descriptors. Descriptors are handed back one cache line at
a time, with one line held back, so that flushing a descriptor never
overwrites a neighbour the hardware has written back meanwhile on
platforms without coherent DMA.

With this change, 1 MB takes under 5 s and 20 MiB take 5.5 s.

A similar change was proposed in 2023 but not merged.

Link: https://lore.kernel.org/u-boot/20230303204844.112105-1-christian.gmeiner@gmail.com/
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---

Notes:
    Tested on qemu_arm64 with e1000 and virtio-net: TFTP of 20 MiB with the
    legacy stack and lwIP, lwIP wget of 300 KB, 1 MB and 20 MiB, test/py
    test_net. Built for qemu_arm and run on cortex-a15: wget and TFTP of
    20 MiB. Not tested on real hardware.

 drivers/net/e1000.c | 87 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index 1c8767dbe..3805fc5d5 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -57,11 +57,21 @@ tested on both gig copper and gig fiber boards
  * move these buffers and the tx/rx pointers to struct e1000_hw.
  */
 DEFINE_ALIGN_BUFFER(struct e1000_tx_desc, tx_base, 16, E1000_BUFFER_ALIGN);
-DEFINE_ALIGN_BUFFER(struct e1000_rx_desc, rx_base, 16, E1000_BUFFER_ALIGN);
-DEFINE_ALIGN_BUFFER(unsigned char, packet, 4096, E1000_BUFFER_ALIGN);
+#define E1000_RX_DESC_NUM	16
+#define E1000_RX_BUF_SIZE	2048
+/*
+ * RX descriptors are handed back to the hardware one cache line at a time,
+ * so that flushing a descriptor never overwrites a neighbour the hardware
+ * has just written back.
+ */
+#define E1000_RX_DESC_BATCH	(ARCH_DMA_MINALIGN / sizeof(struct e1000_rx_desc))
+DEFINE_ALIGN_BUFFER(struct e1000_rx_desc, rx_base, E1000_RX_DESC_NUM,
+		    E1000_BUFFER_ALIGN);
+DEFINE_ALIGN_BUFFER(unsigned char, packet, E1000_RX_DESC_NUM * E1000_RX_BUF_SIZE,
+		    E1000_BUFFER_ALIGN);
 
 static int tx_tail;
-static int rx_tail, rx_last;
+static int rx_last;
 static int num_cards;	/* Number of E1000 devices seen so far */
 
 static struct pci_device_id e1000_supported[] = {
@@ -5120,31 +5130,33 @@ e1000_sw_init(struct e1000_hw *hw)
 	return E1000_SUCCESS;
 }
 
-void
-fill_rx(struct e1000_hw *hw)
+static uchar *e1000_rx_buf(int i)
 {
-	struct e1000_rx_desc *rd;
-	unsigned long flush_start, flush_end;
+	return packet + i * E1000_RX_BUF_SIZE;
+}
 
-	rx_last = rx_tail;
-	rd = rx_base + rx_tail;
-	rx_tail = (rx_tail + 1) % 8;
-	memset(rd, 0, 16);
-	rd->buffer_addr = cpu_to_le64(virt_to_phys(packet));
+/* Reset the descriptors of the RX batch starting at @first */
+static void e1000_arm_rx(int first)
+{
+	struct e1000_rx_desc *rd = rx_base + first;
+	int i;
 
-	/*
-	 * Make sure there are no stale data in WB over this area, which
-	 * might get written into the memory while the e1000 also writes
-	 * into the same memory area.
-	 */
-	invalidate_dcache_range((unsigned long)packet,
-				(unsigned long)packet + 4096);
-	/* Dump the DMA descriptor into RAM. */
-	flush_start = ((unsigned long)rd) & ~(ARCH_DMA_MINALIGN - 1);
-	flush_end = flush_start + roundup(sizeof(*rd), ARCH_DMA_MINALIGN);
-	flush_dcache_range(flush_start, flush_end);
+	BUILD_BUG_ON(sizeof(struct e1000_rx_desc) > ARCH_DMA_MINALIGN ||
+		     E1000_RX_DESC_NUM % E1000_RX_DESC_BATCH ||
+		     E1000_RX_DESC_NUM / E1000_RX_DESC_BATCH < 2 ||
+		     ARCH_DMA_MINALIGN > E1000_BUFFER_ALIGN);
+
+	for (i = first; i < first + E1000_RX_DESC_BATCH; i++, rd++) {
+		uchar *buf = e1000_rx_buf(i);
+
+		memset(rd, 0, sizeof(*rd));
+		rd->buffer_addr = cpu_to_le64(virt_to_phys(buf));
+		invalidate_dcache_range((unsigned long)buf,
+					(unsigned long)buf + E1000_RX_BUF_SIZE);
+	}
 
-	E1000_WRITE_REG(hw, RDT, rx_tail);
+	flush_dcache_range((unsigned long)(rx_base + first),
+			   (unsigned long)(rx_base + first + E1000_RX_DESC_BATCH));
 }
 
 /**
@@ -5279,7 +5291,7 @@ static void
 e1000_configure_rx(struct e1000_hw *hw)
 {
 	unsigned long rctl, ctrl_ext;
-	rx_tail = 0;
+	int i;
 
 	/* make sure receives are disabled while setting up the descriptors */
 	rctl = E1000_READ_REG(hw, RCTL);
@@ -5303,7 +5315,7 @@ e1000_configure_rx(struct e1000_hw *hw)
 	E1000_WRITE_REG(hw, RDBAL, lower_32_bits(virt_to_phys(rx_base)));
 	E1000_WRITE_REG(hw, RDBAH, upper_32_bits(virt_to_phys(rx_base)));
 
-	E1000_WRITE_REG(hw, RDLEN, 128);
+	E1000_WRITE_REG(hw, RDLEN, E1000_RX_DESC_NUM * sizeof(struct e1000_rx_desc));
 
 	/* Setup the HW Rx Head and Tail Descriptor Pointers */
 	E1000_WRITE_REG(hw, RDH, 0);
@@ -5320,7 +5332,11 @@ e1000_configure_rx(struct e1000_hw *hw)
 
 	E1000_WRITE_REG(hw, RCTL, rctl);
 
-	fill_rx(hw);
+	for (i = 0; i < E1000_RX_DESC_NUM; i += E1000_RX_DESC_BATCH)
+		e1000_arm_rx(i);
+	rx_last = 0;
+	/* The hardware owns all descriptors but the last batch */
+	E1000_WRITE_REG(hw, RDT, E1000_RX_DESC_NUM - E1000_RX_DESC_BATCH);
 }
 
 /**************************************************************************
@@ -5346,8 +5362,8 @@ _e1000_poll(struct e1000_hw *hw)
 	/* DEBUGOUT("recv: packet len=%d\n", rd->length); */
 	/* Packet received, make sure the data are re-loaded from RAM. */
 	len = le16_to_cpu(rd->length);
-	invalidate_dcache_range((unsigned long)packet,
-				(unsigned long)packet +
+	invalidate_dcache_range((unsigned long)e1000_rx_buf(rx_last),
+				(unsigned long)e1000_rx_buf(rx_last) +
 				roundup(len, ARCH_DMA_MINALIGN));
 	return len;
 }
@@ -5694,7 +5710,7 @@ static int e1000_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 
 	len = _e1000_poll(hw);
 	if (len)
-		*packetp = packet;
+		*packetp = e1000_rx_buf(rx_last);
 
 	return len ? len : -EAGAIN;
 }
@@ -5702,8 +5718,17 @@ static int e1000_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 static int e1000_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
 	struct e1000_hw *hw = dev_get_priv(dev);
+	int first;
+
+	rx_last = (rx_last + 1) % E1000_RX_DESC_NUM;
+	if (rx_last % E1000_RX_DESC_BATCH)
+		return 0;
 
-	fill_rx(hw);
+	/* Batch processed: re-arm it and release the held-back batch */
+	first = (rx_last + E1000_RX_DESC_NUM - E1000_RX_DESC_BATCH) %
+		E1000_RX_DESC_NUM;
+	e1000_arm_rx(first);
+	E1000_WRITE_REG(hw, RDT, first);
 
 	return 0;
 }
-- 
2.55.0

