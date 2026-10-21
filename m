Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F041606A33E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UM1ModqD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmWoD5v8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0008C6079A;
	Wed, 21 Oct 2026 11:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyOU9nIorIsH; Wed, 21 Oct 2026 11:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1035606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580838;
	b=gh2ZsVXztd5rJFfQq9mDuYk+Iq17e/g70x18f/ajQauVpIFOPrOtS0oB3MTTBjK4yW0S
	 MkIoVbGIabsY45yS1bEiYeqNOj1nb7p/xKVZo+6b65VO2OTw3vIkGONEuY1FLvq6Rj5po
	 XfYEpGie0r+1dnsE3iTw6yCNCFtujZ6cEODKCLxdDjGl+J2+6/twrDTRi/SEqkBDUC6Kd
	 /S7BFFjUAwQjqYRORnBzxsUwfT3YLKzO68AwRM3kOepUGY/emqDDLjqMvt3wCIr5WTJLW
	 tqnKtfsajuznhi7TrdmsmuJ2HC7zO5ps6euRNhHtP6qCZ8P6ID2NHK/0VWUdgdAOyRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cEkQ5DEFoKRkAJRF+myZo58ur0F7HgHyMINvc+crHNQ=;
	b=ZBYfnGisw3zOUwGY1voKCYv/Db9aOnP/z8khJpJrLWwhQsTn1q2lSqNESZpg8HKi0v1u
	 dzrnmxH9QLPnxOU8ashufZVWDAZF074IsvcYtKC3r231L9+fRUqZs9B2S4XCQxN4H+7vq
	 A8oWvZmK69bDK3o/PYZXj4pDttgzaS2oR3BVOmJ/Kw0k9O00xO+jFZSGsZO5mHTxSZf0h
	 ScUi6/nSBJiq0cGQtrlhW81KDw4bjQZ4+HZh6bCKq49z66fmEquVEJTLyeHf0unhiv7eH
	 OaAnicgrjlXDVgT2KmRaz7njhsn+rXp5O2wGUbMY47i7RydoxYbq0JBepBpCJbkFahA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580837;
	bh=cEkQ5DEFoKRkAJRF+myZo58ur0F7HgHyMINvc+crHNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UM1ModqDpeJ1ZrN1veM7waG52c21VBARElnDfMQLEMRU5JLKqWaGdDBzrt8P6jSgR
	 Lv/5pZjA9XwjGvycA8HDxmoNPTBPbT9X2ObPKjqQBm2w4mrri/b7A4WrU2Bt0Z7UHW
	 SiJgcjKS0dVUEoEagxnOj72buSIo88NNf/Tzx7rZAL+OPlBn7MUeeYPgTZf3Kk7GM8
	 XttXwgFWE4HBLjbyW9HqoWcmCljz3d1+W7WntG3WdZiCu/AD88robx64Rc/DUdGHRG
	 eVy//bYB8RuQ3Ae/eqZffOhEZOSKZk6t9ji38ReVJvCyHdN+GwUcjKh/apeSE8nB/A
	 VHKoVVPHRWFXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1035606C2;
	Wed, 21 Oct 2026 11:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDCED2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF7EF40761
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kc6v2gt7uX1q for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D14364075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580833;
 b=HN5vPiupMvDtFSgIPMsuMzL0PGR9Ue+mRKprCsIcw4WcdWsCKrT/H5hNZhYakUQ+ddaZ
 9SoI/ekkhvG913nCeY21kbnf9yeyshadVg0mbaWxpex/VWoyG1/Dz0KZoucRuZSRCMJsg
 7FfVGqrJ8T95//9YSpBhKdeNBmX1QH0sgxdhZ9FqvmCFyJvp7/05QMYIsOVccY1F9joyU
 zoBlawVOXfkXw0PUJtlqQ4occ9bP2KPR1fPMiw1mhMMH0Ox4n91JgZ1+P8cPWBBwwhk4l
 WuIhV3nOiNMXPtf3hAYxxnWpSLdwuoIHmFUD1zMPW20v5k/ucawaxlJu2ObCKbKANeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580833;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cEkQ5DEFoKRkAJRF+myZo58ur0F7HgHyMINvc+crHNQ=;
 b=CFbGjCLQmSry872zpHKfWoMiiNQtqcsEB8BL6UYtFkmuv8XI9hg091jF0gzqln5inAXG
 +Un4deIHDytJd6oIDtJ9REY5AWZIH7KEPsw2XuWvsgcwOImfqQfijZXf27H7wjSlULeCH
 +wCydms46HyTb0k8rt/3vZ6GQc6q66IXBg2a7mbhCrT5C9qVIE3KK1cRgBdUiGLVyKbBC
 DVhqPnT2MI3KBYJZ2IiE5tir+EWctSSQVAOz5NlWNGWKVJrIIbu1QCRpIfoQBpPwcTi3n
 0vrp2qtKx1aVI4T23eiU1pMXd7PAB8YkW10o8EPpPAbZROGwm3/7ubo9slwHKv2QLYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PmWoD5v8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PmWoD5v8
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D14364075F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:13 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so359481a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580833; x=1793185633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEkQ5DEFoKRkAJRF+myZo58ur0F7HgHyMINvc+crHNQ=;
 b=PmWoD5v8V5OlFOf7qYKzbL+GhdguDs2HNUqPCUPOAbSRw4PmZ5O/65EPxdJ4fGQE17
 nBx65RIZPW/Nu17m653nJ+96SdPoMjt0b13lhwiyuVQb/ykJn1V375msWp5h8zh3hqCl
 9sNwfqjIkLK+LDZv++32OIHa2vApsPQElW7JaDtugLdFG5DqZPavmxKCLnMdBRRsP9Wm
 CoDMRh/97u9kVrJAUy5qKAWpKPCoIiT041XVzSLmhUPW8d4VVgoaOnQnyFLbQKB1PG4T
 2z83tgsEHiZqsOSRUl/+E1vbYgRPP4qTeXm6vysRFYFbakNBef8SR4WDDO6XwWb3x2vq
 Nxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580833; x=1793185633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEkQ5DEFoKRkAJRF+myZo58ur0F7HgHyMINvc+crHNQ=;
 b=ZlltLLhsMZu4X4SzKsAgfWxOvgF5x/qJzwiDnGWkcYusH1IzCkvu4RBw8qGXHwSXk0
 logtbHZGkJpXQfDLxz6bHW3HBfcIG422Ny1Kr7wA4fk4NCS28w743kUbvVSuAy8boJMj
 Dbk0VWQLQbFIxw5lA7jl22VO+UGPLaIyWO8cPgyN1aZJsBybMAschPYGhJ48fsnxbOMP
 A261gT8/XQGkvPwfiDHpH6HESOYNYebhCUQKhWX26EGPuM7kfWHbU5cTFfVyLAjVOdme
 Z/YwIguLLw8cegAWPMVpzZ2e+liByLGogHfNv8SEkmCxaI/yLdixZXqCrPFpYytszvOC
 Sghg==
X-Gm-Message-State: AFq9FYL5QTIsf1xGdhq5NBF2bRfobhN1gBo5uv5wsqPTSlYgOSMYJVOh
 K6qIYJA+AxuForktBVmvkT6VWaCVH89CHgn/KRNnp2WdXAR5SIjdAwwAIcNtqiWsL68=
X-Gm-Gg: AYBFou2KxTDtN7JlLyHHV4W955d7mJIO0uyLbIXs0n1tHUGXJpSNPvUibPalfzQxGfH
 vRhQGquvMxz/MR7+Kx7j3F4E2XGIb0jgCj/sKohucyv8iiMN+GYbpy9t7GpJvl9n0Qz563scfQ+
 eTQgX2J8/zr5iPrjv397nKDe6RgnKImjHPFt1AFgvULsmvYUcYnIPgngynqiWEDSg+MhutI7TLQ
 wgr2l4wsmwLSEIJSGpyTNEkO5tERJnCrNp67vrTkULDvG7CN287zJ+LVWzD5lOFzZzGT09ccZoH
 y5agH21gnvUIEtuoaMRU3FCOsDNazqYaEzLLtA4+ZRjZTYtkdhXHb54B7SiqRhoZFi7t2c+hCll
 Nk6PF+U5naCHLlurcLJcm8x23xakRKrsD01P9+00f1+5Vrzetz2Pa9Tr65ghpyHub/d/iPYGHXY
 P03NaKmYI38Dzh3CuDENapJX1h9kURY0wKNKd1a8m+GBBpE5p7TQADgBV03+8jdMBKOxQ7Nw3t1
 TZhZ/r4kkKaGSqv4DDLUblPV+n9MKFSko9MjNHmZ0j2MjP0iAubGZZeSyAOnFcdZyKXj1HRhSta
 Zu8rjj8S9hb4YAkk/Bl4O++jQvwsmKjUP+xwpxhMekBL9Cdvj7oy/1+ox19xvXczJ5LyElUHf9g
 tVxFg1slEEcaAE4vNefOzVmCUnKKVzr3uync=
X-Received: by 2002:a17:90b:2812:b0:3ad:6090:a189 with SMTP id
 98e67ed59e1d1-3ad86db5017mr1482433a91.45.1792580832566; 
 Wed, 21 Oct 2026 04:07:12 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:12 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v4 1/5] virtio: rtc: Add virtio RTC driver
Date: Wed, 21 Oct 2026 19:07:02 +0800
Message-ID: <20261021110706.2947351-2-alan.tseng.cs@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---
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

