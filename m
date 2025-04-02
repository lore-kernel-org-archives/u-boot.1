Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A56C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31DF81703;
	Wed,  2 Apr 2025 16:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2/2yUIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A1C81E1F; Wed,  2 Apr 2025 16:42:25 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC37580FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so4951750f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743604943; x=1744209743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Po/hB/GKfrXJ8vHAZdYaQxwbo9u0HG8vwpGt0NXy++c=;
 b=T2/2yUImRTlBc58FbW4tAiusfqIogHb+C3p/xbUPDMS7DukKbwa7J8SsiLw+D1zdIQ
 3ypaQvCb2xux2jERQVcRRGRiyE1A/ROV3m5JWpYbS09K9eSMaXJuZbdoyd0DVAMkwJ+K
 y4QiesUUNHmn1pppC6y8FoltgLGwe6ubyGDlSYz3PbJwZWXdWuPg+lhNRfvTIpm1uztg
 FXqSB4nnKEtCSTGHmt3eE6m7prpSQAQS9ncbuDi/reTS7EVHsDqRMrGuFwcXB/Fyufwz
 HjTh473npXf7AQbGt+5JeJB5wubjC5yuM6KcXseuoz3N1vWMspl70W+Q71Qf9ELLZgxl
 6bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604943; x=1744209743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Po/hB/GKfrXJ8vHAZdYaQxwbo9u0HG8vwpGt0NXy++c=;
 b=jQuugijKs1DhX2qC/IDIHSbey7ihX7wmenlgt6kXXmHu7pDmdmhzGmTrdGASfVKl+8
 YfVAycpypJTLa+Bued6fbcqQYCiLxpyXfn63RNeHIunl1KCg0+pikVevXrcMgJcHN7Oy
 xshsLN+73BTH6FelAvZVDStNkwVc+goiAbE1r0TpkP+7I8Ohx12sn5MQHME9fvDrt1EY
 wC2Tq9qClkuPW+nZ4KJCuM4E+47y0Zg9W64jBE/XA41QgaaAauqOW9jjl2VJ5SvyrDad
 dumg8oT3xc22uSjCmFdW02CfquRT3rgQsa9eSvyGoRpzNV2eTwsHyHKEC0gXjqE4SXhJ
 u8lg==
X-Gm-Message-State: AOJu0YwBtMwUkWWXzKe85cVP3Hhofstm11JUP6pflwA6n8m72QpRpfeE
 lJ9LCLrAxk2Yy9lvNMH4LIckoTf7ZXE9kQaEijLD/dDaVIRgsCMz
X-Gm-Gg: ASbGncumLnY1YZCqicRoGqjXRzLRcWQ2B6Fqyn6GokxUl56yHam1xPK7Q/zzqYpBCmW
 OiavUg68+g607rmhSa2WJ52ROXkv15io7Fal/Aq4M0AuIvWstqz6fqr0MDNZthsA84RpQWqXXg0
 Cu2lUrV05x9/kqyQe5diDo1iJ2Pz54pDzEjWN2EFgQoOy2goF/uPqXYjuhbzqSG8TgiPibZ5uZJ
 QvFBTpXw7WtsOfG3q1fccpV9SUkpqGUmcZFj6hbKi9ikU9ES8yGfuHwkplPgrMG+9MSLh4wngg9
 alxz+QZvubOZqXP0+H9rmC0sQSsd4PFqvXcHirRGViUTgnZxE/4zMDJzl5PC0iXi36Rq9+dLOYv
 Sng==
X-Google-Smtp-Source: AGHT+IHQssaBfGm3QzuWw3DP70ga0tHqLraprM8ahYLGW1qxUNM3Lm+9WSsJz+yCArVsX0Z6YYDeTA==
X-Received: by 2002:a05:6000:420a:b0:39c:1f02:44ae with SMTP id
 ffacd0b85a97d-39c1f024503mr8945298f8f.27.1743604943056; 
 Wed, 02 Apr 2025 07:42:23 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm17018739f8f.101.2025.04.02.07.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:42:22 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: sjg@chromium.org,
	mkorpershoek@kernel.org
Cc: u-boot@lists.denx.de,
	Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH] bootstd: android:  avoid possible null pointer dereference
Date: Wed,  2 Apr 2025 16:42:19 +0200
Message-ID: <20250402144219.1875067-1-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

- avb_slot_verify_data_free() doesn't check its data parameter
- out_data can be null if avb_slot_verify() fails to allocate memory

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
Another approach would be to fix avb_slot_verify_data_free() to check
its paramter but I believe the goal is not to touch libavb to be closer
to upstream.
---
 boot/bootmeth_android.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 3a59a4e3f6..f431b6ae58 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -481,7 +481,8 @@ static int run_avb_verification(struct bootflow *bflow)
 		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
 			printf("Verification failed, reason: %s\n",
 			       str_avb_slot_error(result));
-			avb_slot_verify_data_free(out_data);
+			if (out_data)
+				avb_slot_verify_data_free(out_data);
 			return log_msg_ret("avb verify", -EIO);
 		}
 		boot_state = AVB_GREEN;
@@ -491,7 +492,8 @@ static int run_avb_verification(struct bootflow *bflow)
 		    result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION) {
 			printf("Unlocked verification failed, reason: %s\n",
 			       str_avb_slot_error(result));
-			avb_slot_verify_data_free(out_data);
+			if (out_data)
+				avb_slot_verify_data_free(out_data);
 			return log_msg_ret("avb verify unlocked", -EIO);
 		}
 		boot_state = AVB_ORANGE;
-- 
2.47.2

