Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B585FC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6087880D2C;
	Mon, 24 Aug 2026 19:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwURI44RD5hC; Mon, 24 Aug 2026 19:48:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787600905;
	bh=5WjKBeSzNgmKNBUfooo50Y7oRmdetB5A8DZUD/sTTgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z9HWh+kJNeWPGZRc+wDwQawmwzetrB0QnvSwkUTOgb1XIxz+nJhQMH/BQXafsuyAH
	 sHZnHVW5a5ndG1eFEfmJOANB2qS+n68p3hJmP6ZQXy5UPJFS3AOOA5m7+nyC7kfBdU
	 oMnaqsRRPokMb8eQgcvjwNz9OKpdFPL4iTUUNTQjUvuGdDXJ1su7eXDwVNW3+qZEAs
	 92hZ1MmrI6j2GjGaAW8eHRA82CfMXTDjZuTkmtiYp/L1ZzV7pfZyvAeO/Lsgj8+4QN
	 TVDAegP71M5MQo8jtgFfFeoISnXJlyLN7hGtyhvh/r8AxK4C4eAuyQxNMiljIWa1W/
	 6/M1dkAyAWkGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 972BF80D34;
	Mon, 24 Aug 2026 19:48:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DE164B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 040FF80D34
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duvIUEgeBtt1 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:48:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q1iGGpu2
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 267BF80D2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:21 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-49ff971e903so90616b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787600901; x=1788205701;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5WjKBeSzNgmKNBUfooo50Y7oRmdetB5A8DZUD/sTTgw=;
 b=q1iGGpu2Mh992VHi9hVPDmUNHfjswAR35miagtUGMUxVjwAvTLrXTDwZ8fe9TXQeOt
 nTTrsdwNWi0G42HYRa0QY675yj1xe6TUiVxcKx4YXYztJC07aFWC6OwzrlfWBXJd6PZ2
 ahCnJX/llQUSpCNfuyQ0BYpEGD572VhXFlvA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787600901; x=1788205701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WjKBeSzNgmKNBUfooo50Y7oRmdetB5A8DZUD/sTTgw=;
 b=O6OWtI2JLh4pFylyxKEP4d2nA+LtR63uHkllhXv3uqSISv7Z2BLUDtG6EHa9Z9fJ7+
 qB+iZiRwY4A4LZ8XkK7Mo3xS9iKHonhNTZuZt3aV61BvOy5SiWo40gt7HK7j+xJG69mk
 ziIhgub2DGo9hrbrPM7gzBNf0DBS7W2ZXxjMJOhol7asRNVt832/Cx3J2HYJBQx7lRbN
 /Kc6XprpZNosjbX6N2ebYAiPSOcKxgoAwsZey7+ROXJ+BlqQlblt8St3+6f8/khgKvp+
 CXy/tz5E1myLajdLw7ErsiZ/1zY/hBwZcLZK77+CiNLD4ePucbGhuQk67gj3dpzMqzIL
 ijGg==
X-Gm-Message-State: AFuF++nx3ZeyLX/5bzbOvN6p7oW/saMDr1GoPfbF4PYs5GS3AudGcVfR
 oXKqQtog5TsBeWvYcyJ2cznlHEYJoIGreC2BSnTl94aDqSA4WIdyUN6SGQQHrw+hodiQpJvFn1Y
 bSmHd3y97JE+8
X-Gm-Gg: AR+sD129amoXJpYtRoNU6zgIUDjfOJnPK0HZOk7w+4IvGEYbHOpDCoJqxo6wpK4yuzH
 noRTo+UGBltoUNoiBbYvVqnEAWilsH/DnVYYo/3DBODIk5K3pT4Fh0rg/NkbIL/1QFyq3GB7XHP
 LUbt22oPLn4YuvKHpf5UpHMnnudUB6qg1YiogDCXpR6k8oQZRMkrsJuJY+Yf2d18OS70S6ybhz1
 o48sdhUd5LYd4vsmaEXXAfeDN4w+qpM8rvCSm7Ewm07Ffjl6W2QxCVeP2cY+psxKFXvGrXfVTfH
 yKxr9BPmUKwSg4/jOjkaxsVGrUm9vobzq4V6Yao4jMRMlKbkybxAL3NB18RqoceWDJXHMN705Zt
 qlRYesrGfnsj5BsobIBrDZLyyuUzJ3rebH3wtjYvm9nhXBuxB/Fj4PiqycPWAi1YbUzWbb811zh
 J+SPzBvG9Z0bXCmVCFG9g/D7RxVTYHcHMXT0PdsRPck/xithYesm3HPg2tqEzeD5El3zxFKwjit
 93DUPlgDJlol7q3FBEC1BLKyRx21wObuvJ4++hYmOj0GWMLqfXhD/5lqvyymnRaEnaAmt2XsoVX
 U9npsi8Ar/2v8lBJDE5GihQjFxKDakaBdZBd8qI=
X-Received: by 2002:a05:6808:1483:b0:492:7abc:422e with SMTP id
 5614622812f47-4b35051b043mr1244982b6e.13.1787600900679; 
 Mon, 24 Aug 2026 12:48:20 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b32c6909b1sm4340077b6e.5.2026.08.24.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:48:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>
Subject: [PATCH v2 1/2] lib/fdtdec.c: Disallow overriding
 BLOBLIST_PASSAGE_MANDATORY
Date: Mon, 24 Aug 2026 13:44:01 -0600
Message-ID: <20260824194814.555634-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824194814.555634-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260824194814.555634-1-trini@konsulko.com>
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

When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY enabled, we don't allow
the device tree address to be overridden. However, in fdtdec_setup() we
had been allowing for various cases of not having found the device tree
in the bloblist, or overriding it, to be possible. Add a check after the
bloblist check such that if we have enabled BLOBLIST_PASSAGE_MANDATORY
we return an error at that point.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Based on Raymond's feedback to v1, look harder at this code again and
  introduce a single check earlier on to cause fdtdec_setup to bail out
  in the case of BLOBLIST_PASSAGE_MANDATORY and not found.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>
---
 lib/fdtdec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b91e067106dd..d25535bf36cf 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1845,6 +1845,13 @@ int fdtdec_setup(void)
 		}
 	}
 
+	/*
+	 * If we have bloblist being required to pass the FDT and we reach this
+	 * point, we have a problem and must exit.
+	 */
+	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+		return ret;
+
 	/* Otherwise, the devicetree is typically appended to U-Boot */
 	if (ret) {
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-- 
2.43.0

