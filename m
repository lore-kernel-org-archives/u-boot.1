Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7534606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z/Rt38nc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9ubqp1P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB9BE80C76;
	Wed, 28 Oct 2026 03:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msKR5czY_WUq; Wed, 28 Oct 2026 03:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECC3380CE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156847;
	b=iIivcLBesRRMrnOPVUq7JkxOqtGf+eKTrZjWjp1MHT9DuJqs06JPnW7iMI9F49fT4GLH
	 qtwFnNuOt4/u61Q26BcI8ql1tQ7kIJoof4pef2za24S093SWiehxYHpMV40gE2o+I03/z
	 PSwW/EDid7wbbDX7h2tjPRaE0wgl7kGOca8B9igTxS3J77NCtEQ1nBAu5yORAsNGr/LlU
	 pCIBlj5KBvePHFyUAefJC/7wlbFYacKUsNaGygdV3F9WdHswaj1XvHe6PvNifjRKiinTK
	 V5FSWfGUOnYnD0kqHJcUN6l7iUJ1cbi5DOY18Fto1u249esdS5D+x4CWuUTSClogyZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NYU+Hqv6g5WU/N+HQF5HveyR4PShGWf3Pkjqw6D5zV0=;
	b=iVGMb2C1ixW2c1hbiu4FERvC7YDjdxwXyHPRBpsny5l6YNRrndRpoQF+9ofhjXQbQQu3
	 kYfCrbXsPzfEaakCJiz8icQHhAM3zpyDHBIa9Ht/4J53uc5YTfPrJGs4JjhH7bJJC9eKz
	 k2UN8eQdSHzU6aHmU/8s6yH/psvfpCbSHJ8JTZ8pbKqHim1ZfumbhfYqOh5qBHvBawmr3
	 Gn9IZl3jtkZcZJJU7gBOhwGM6OJA9zFTZWMfSXSnYwJ02+nbi3av13juzvzrQoH7DyhEd
	 3rsV6i9YHPiDzqO2lxIcpDIPOkCfl/v/tLgKmyulBYQZ0DttZoxwwmNNNw6/4gjeu9A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9ubqp1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156847;
	bh=NYU+Hqv6g5WU/N+HQF5HveyR4PShGWf3Pkjqw6D5zV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/Rt38ncOeZaGqdF+7FctdkAonacuo24GHfziZGo/9JUZR4OBnBMEc0ETwHSEJhpa
	 afnC8nOD5+kZ+m2ePW+ETENv+TqFcYuD5LIm3sOoxCHp/V3hntrnL5k1bYfrTS8rbb
	 KbEND7GVdywt553f2r2jklJ2Q24sN4z+Eq1x4D5acS1sHEVujITWzKoWkKKkT3bW8l
	 XT1DIluiKG/DSaqgfO0QqhOLv2LM3lxazMpv/Z81iVXjqMQJ31Sd3We8Lm02xDqGAH
	 zQrhgM8/aPSMQ3LIQiE308LZjKnznm3F5PhRfo5sRsXaZIHy/IyusQfEFfpSYgx+Qs
	 eL0a2z31O9mwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECC3380CE8;
	Wed, 28 Oct 2026 03:07:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EE330473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBCA280CE8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEP8MMfoVz2X for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB40F80CBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156843;
 b=IXnk7jOt3O+f9nqFiYUyTe6Z9eogYYJBy/BrpaKz569Y4wYM9YUWu3iCuhlBLtsIBw3c
 QNpLpn083o6GsJ9tbgLoPoXO/NNn9zJW7j6C5ZRWArekkrb8fGU6S97kn9rkCEAu4/495
 r/m08kmSEX17ILCdQ4qO6C/Bb2VcjCBVidYZw7Y5IA1P+g7Lhww0tt589XwYflMAAQOEY
 iUmjpZHQtCcWT/5NQ/SL7ITAiDT4qS7/70cId7TZg3mtFWP22r2KNBOQO76rWCbQhk1Cg
 bQd+2D0cgcHztX6Pf/e9JSXyZgMH6PWANfIOsBT6YmQHJ9qyPIkJIPeYPzhD1S5j3nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156843;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NYU+Hqv6g5WU/N+HQF5HveyR4PShGWf3Pkjqw6D5zV0=;
 b=cFODQEVMnU6Fs+k8JkDIiI/EcWQmGIJgBoklgh8BHEM3WRMfpdB4vyLn0vsBXe0S+8kG
 TfPSBk3G/ZSBW9mnOTy4mp37W6pDHasP3yChHTIwQaZGqAmDlJConJcEMFFZbh/wN15cV
 uh/WPPQyslAX8xCDPh89b0lfYW422IizZsIj1JOro+vTcrK7tEjfMCXrRCikwoFLbF9ck
 msQPM6QaScp7qumgDN05dYaqF4cf11fmTphEb88skO9DyVOAqeu2s1u8zm7yGoRHAMNhh
 xlWHGGhZpucoKxQvsiR4T3UK6mAczjHpwwCgYEzujZjuFpaFpg1FSqlBSn8DKRLgxZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=H9ubqp1P; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=H9ubqp1P
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB40F80CBC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:22 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cdab9e9761cso305527a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156842; x=1793761642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NYU+Hqv6g5WU/N+HQF5HveyR4PShGWf3Pkjqw6D5zV0=;
 b=H9ubqp1P28vB0rJZTnO/sB04DJ5RVbzXPU45wlrkU1UOBXymz3UdWfbIs3vSwT866q
 A1VfjavnBOgZ5LOAbIBrpKO9KPlEwGbwvHvaxqp7Tbpr0WI1E9PDZt+IlAAw8hfK+dxQ
 SJyM6OLLpfUKD8V3WKavP/2KM6zYDDVRPWhx5ZMR4UtStKxataNAK6mUaePXunM0e6jK
 xCpLtiiermYVY1yQN28VEgWBFGbIH4gSGsWRx3KT5AgYtcO84F9C/Umza+Sp/3bx86RY
 L6xQXql9kCf6t6fG3+6p49LhvZorqqx2RoGG1DFUb6CBUqzO/QTrPL1M2pW8bo0g3c6C
 Crlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156842; x=1793761642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NYU+Hqv6g5WU/N+HQF5HveyR4PShGWf3Pkjqw6D5zV0=;
 b=SXGCT8+mEd5HfQRv0dR2wAGxexT90Rs91qoVw/FjQQ+womOZjDZ/r4aiZBs+ZDf2FH
 e9B58WTQlTvsMV4TOJk2OyLuvw7OrF0vIwQh8GOznejp8ZzbQbRqBHz9ZjHnX+uOelXv
 mJG0ZpeablqbVrX97b1lmWQ3WO8G8M5MEXuB+VdIZbak4rLHsrkUDJZ7De+Wp75WljkN
 3Z3vcj5VyEWZYVGY1u6z61byTeDmMcRW0z5GyvrdGGQ6JgLpJhIFlow2b3LEtQdbZ/f/
 zeptBu3FtNf0mp6GzOGgSghPHJQgxiAjOP8yEo9qcdYhMKjeQDePFXFYa68MN+AeQMUS
 YDYQ==
X-Gm-Message-State: AFq9FYIkGYekOGzI9obUhTjfAUjNZ1NwxHakBq4+A987CyvBklyPhiIx
 SVtI7PMDWh3ZkxPhPmoNP08sz+opEApmrMv+8zgFL8HREegrjcO9U9Ls7crQrw1Q
X-Gm-Gg: AYBFou0W2aB7kiRqywKWkI9PIH9OGfJY7plBiypseZKO+BUab8783g6fLC0VVgvePCg
 J5wi1dauHfmeb5pTvGJ0k1E18Ms3p/PZZcgpBx1A/1DhQbsDhFfu6gf7sWNn973146udtEXyh1s
 eH/ZQsbxmKwHO/c5wAlxp/2z98iU3GZu+fjhs42WScCWop1DqJj57m1TBqBXtf5iy/VWb3cNsWF
 f0ZFCBi10mvEf/agX9+ABgMjHGWga5Ryb3DMsLVjHRyzd7xLd766HFVaQj1+qSzRGRYu84CBCw9
 xYSezsbunR0sDumo+eFiWcti2yhDazINDqczvzIf2J3B+gcS493pecYI5Z3ddS2TSTUYNiqcAyF
 YMlmSxGPn1JMnvoY61ENA7rR1lXTI8KFrdlS3VuFR7smdcT97E6RmRRfb52XG0P8tyYExbDwHtJ
 CWBnuQ/K/k3J8fc1Ah8F1jwMXf1tbv/vJHNoMs+SeyCVczdrDfmi4K8lbxiEHbKgdebvBqry0ER
 fJbGoXYOnSVWY+CvrB93y4Qa0OXl3Wl3EAZaUSrYg/P5CK6UdqnmmTK9rkEDRis1xtpgMVA90qT
 tnCmQ7B1ff5CnOtWXLdeGgsZynuPCyJbYHJZSFxbwX0XO34wvIYP8cyxMvw3teBK3Hg/ghsg16a
 2sLDpRoRV7pnFuOVUjrUuUw68osi/MGj3bqFjB89uUO05DOezxFSxKI9MENR/vS/bI9LChlXY5h
 hMzF/1hMps
X-Received: by 2002:a17:90b:53ce:b0:3ac:8fff:5a1b with SMTP id
 98e67ed59e1d1-3ae582348f6mr793779a91.34.1793156841976; 
 Tue, 27 Oct 2026 20:07:21 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:21 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v5 2/5] doc: virtio: List the supported device types
Date: Wed, 28 Oct 2026 11:07:11 +0800
Message-ID: <20261028030714.1608977-3-alan.tseng.cs@gmail.com>
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

The list of supported device types still only named network and block
devices. Turn it into a bulleted list, which is easier to extend, and
add the entropy, 9P and RTC devices. Also note that the virtio RTC
device needs QEMU v11.1.0 or later.

The Development Flow section repeated the old list; point it to the one
at the top instead.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v5:
- Point the Development Flow section to the list of supported devices
  instead of saying only network and block devices are supported
  (Kuan-Wei)
- Keep the Reviewed-by tags of Bin and Simon, as only one sentence
  changed

Changes in v3:
- Retitle from "doc: virtio: Mention the RTC device", as the patch
  lists other devices too (Kuan-Wei)
- Turn the list of devices into a bulleted list (Kuan-Wei)
- Keep the Reviewed-by tags of Bin and Simon, as only the layout changed

 doc/develop/driver-model/virtio.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..30df0e944 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -28,7 +28,13 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
 and PCI transport options are supported in U-Boot.
 
 The VirtIO spec defines a lots of VirtIO device types, however at present only
-network and block device, the most two commonly used devices, are supported.
+the following devices are supported.
+
+  - network
+  - block
+  - entropy (rng)
+  - 9P transport
+  - RTC
 
 The following QEMU targets are supported.
 
@@ -72,6 +78,8 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+The VirtIO RTC device (``-device virtio-rtc-pci`` or
+``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
 Testing
 -------
@@ -246,9 +254,8 @@ So it's easy to tell which device these functions are operating on.
 
 Development Flow
 ----------------
-At present only VirtIO network card (device ID 1) and block device (device
-ID 2) are supported. If you want to develop new driver for new devices,
-please follow the guideline below.
+The supported devices are listed at the top of this document. If you want
+to develop new driver for new devices, please follow the guideline below.
 
 1. add new device ID in virtio.h
 
-- 
2.43.0

