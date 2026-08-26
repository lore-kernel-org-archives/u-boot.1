Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1346C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 19:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5291E607EE;
	Wed, 26 Aug 2026 19:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNsAbbU_8H6T; Wed, 26 Aug 2026 19:42:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787773343;
	bh=Sg9DqnTAKVUPTPSxa6ATL/g9liYb/ZrVMLVHc+R7pwI=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UM/QYD6Y4o0wojoZW0swrktOrOmFdEiROI3mMI9QpezEsE9JBE2oyiJfqwINB/see
	 6Jvbls3FYukyRLqPbYeIW7NvbW0+iTyeVQj2Rm9Vp8N3JMvKByQwAuDM01LMe5xKam
	 1+cRN0URq+BVyG/JUUPLOzbnvtBIXxEwaIcJojkwIl+vJBcb6ATHA1uZ106mFzxhfS
	 X9uPUDhHO2MCpKp5xKMLDUOondH82b96+9XgyPtasTHmZiu6scNAZQCrlACyyrQVdg
	 8uGf2cmYK1BWfnpTJhK17c/z3S5UhLbE0eZYIze244Png5M8T0V0CVQUeiG2nZevGN
	 EBW4FxqfGMqjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3797607CD;
	Wed, 26 Aug 2026 19:42:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1112341
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6F3E807B6
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VEwcvpSFtkix for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 18:14:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com;
 envelope-from=3cs2pagskbvo0wzkcq1jcpiiqqing.eqow-dqqvnkuvu.w-dqqv-rtqlgev.qti@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=jI2sQwPC
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3133E808C5
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:14:34 +0000 (UTC)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so2477605a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787768074; x=1788372874;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sg9DqnTAKVUPTPSxa6ATL/g9liYb/ZrVMLVHc+R7pwI=;
 b=jI2sQwPCCOfwtWwsKXEvXIB0x7hWSr8fyoJm+IKKuBqmT6dlStb5YI2vPdysBlE/uJ
 66bH4Il4FFMZ56of/A4KbbBdXcMQnhwgBNP2sYP70aKhMLqqfGH6sriwQxEuCtJG9tro
 9KDjVnew310MrsFhfdlxIILJVrgRAXBvgymyoIyrFjFAyT7BO6gGz6fZ+jg1OwSof7w1
 9FtaexOWsz9rLCCfxIrckUIviEmgqFJhU87LIxLYHFOMfNGKUGJFkyjCBORhnsDyKm1W
 Y3Z68Orh0y7Ky3WLUrMwkTdbwZ43hZWJqDNqE8r0sihCteU8sR2VFy0q+gVW4D4oaz+2
 M/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768074; x=1788372874;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sg9DqnTAKVUPTPSxa6ATL/g9liYb/ZrVMLVHc+R7pwI=;
 b=lNGJ2OfewsqBd0ecprFwr8ZdXdJHz8iePpnsz7AgLuoerSwmf56GgDdDyjArFb2RGg
 ggNNRnm6d/Q2c5pc+DgeZPFuDscWmdY8HMmWqoR9IEZ9oVA/VIN6v/p5WslORy3PNbI5
 86gwpf8QDgqkpL3AOx6oz3gP4VmnFzYzn1f6TrzlEEpcVzricubH0c5+QJz1SIOXTEsw
 uCCYtfGxNQsv/FYFhCfguJ8MUlDOncyArHA2lL0M95sHxxkZOJxyojhKWSAo5+sRz+pH
 BwD+cjpHeTqwwCX5SYMwV8Q/1Od6cZKPDtm/WCYe1Oao39dawGBWvYJkN30e6ZQD7mqF
 PeKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtPiC1uLu/r1rnugas0MhE3hdu5wBHNYp8KxG267QaeprYGjnX9iNqqrckDVGoBBpxEj7pJ48=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mF3Y62QAYepEwN0zyP00nfqKFHQz3yoHP3Wlm2pDDKnz4VwTMd
 QsL2xsmdq8zBNZ3aLZcgCaxb0HXjvbgU0aCsz+L5a5WpvX6AUDXw66u8+aY8skYj6KLhBylu2eK
 1bT/kgQdjjpI9hIe4RUiRL8UXCA==
X-Received: from dlbur21-n2.prod.google.com
 ([2002:a05:7022:ea55:20b0:141:b245:df84])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8b:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-3966d3d9581mr17968551a91.6.1787768073674; 
 Wed, 26 Aug 2026 11:14:33 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:14:19 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826181428.1856166-1-yuxiaozhang@google.com>
Subject: [PATCH] u-boot: fix error check in eth init
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 26 Aug 2026 19:42:20 +0000
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

eth_start_udev can fail but errno could still be zero which causes the
function ignores the error silently. This fix catches the error
properly.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

 net/eth-uclass.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5c437143a30..5518268bd68 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -347,12 +347,13 @@ int eth_init(void)
 			debug("Trying %s\n", current->name);
 
 			ret = eth_start_udev(current);
-			if (ret < 0)
-				ret = eth_errno;
-			else
+			if (ret < 0) {
+				if (eth_errno < 0)
+					ret = eth_errno;
+				debug("%s start failed (ret=%d)\n", current->name, ret);
+			} else {
 				break;
-
-			debug("FAIL\n");
+			}
 		} else {
 			debug("PROBE FAIL\n");
 		}
---
base-commit: 4d499701629ec07d32e3dacbf9d9bd43d9e8032f
branch: main

-- 
2.55.0.887.g758fc8c411-goog

