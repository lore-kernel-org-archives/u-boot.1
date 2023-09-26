Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0321BE7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B2086DD9;
	Tue, 26 Sep 2023 11:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RncKx/sQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E922786DDB; Tue, 26 Sep 2023 11:44:11 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1586586AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50335f6b48dso14272617e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721449; x=1696326249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=RncKx/sQM7bUWVs8q0D7Av4/O8Z0Sr3PYilt9U3t1GKL0Oug8awGlpKRdbn8XSYrAf
 jcnMUqocmt96gpbcwFtlWM4X8BULw7BAp6Cb+rWLaFf+tC7APR1uo0FpDEDzMzIUJpDs
 YhqJ49uHRTdYO9kzqTpS8L+q26Ryuh2wXml258XNKMwG4Pl82xgh3F0RxkXpyCWiVXHt
 hz5mUYD7QEVPOr0vbxeApvznbkHrctfC95LFBts98i37tt/0qP3lESS6q6PdO9llYnbM
 OrcI0Mzu/vyMVDU++UmbeUAS3ztFDeTy7vgMqC+b9ydGxMxghKmlwO8dqN9u96YVSPLN
 Ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721449; x=1696326249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=Jgu6YqZi/P/3wWeB8ol4Zu2UReBRxl9WuzVtofIKgM9AKKiRkVNmxCsFS0nob6+E9P
 W7Ri9LaB+lKNHAido6IHaioLiAoy+wYsbL6WWWgkD/RCxuSHjYrla4HwV6xCsnxey38P
 tUfLbqe0PlBI/5kNWJwlZzHWTzftVN2C/mjg3afPbCjJcp5+GDbhj6QKJ3ntp20ySqQd
 IGX7M67+eijsfIdZac0za3v8iIe3LNt+oNh7wjQAwMiKQeUiPhzLwG7CF2G4jfX8AyT2
 +EHw3u/Q766+JUrUA14kvkSTV2RRh3v566bpkVozPFY8RTTgfUTq2Wu7TqOT9zZKJUa/
 6fKQ==
X-Gm-Message-State: AOJu0YwKX/g7IcD5jbjY+dkeH3OJCTa8AX7rKBZK0XaS6WT6+o21CKbr
 vGDi7wWrGYZBY9PbGFRLhWKmzg3k4OdQcKxGpX7TAA==
X-Google-Smtp-Source: AGHT+IGnfFL2TKvKVjs+XOG+TgJpcGEqo+FOO6QvwP2++yAfZLqqrMAU2qQrvgK7zq/aqPTE/xG2YQ==
X-Received: by 2002:a05:6512:1056:b0:503:175e:f005 with SMTP id
 c22-20020a056512105600b00503175ef005mr9597753lfb.38.1695721449183; 
 Tue, 26 Sep 2023 02:44:09 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:44:08 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 12/15] net/lwip: update .gitignore with lwIP
Date: Tue, 26 Sep 2023 15:41:21 +0600
Message-Id: <20230926094124.7024-13-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

ignore lwIP library code and reused files from the lwIP.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 net/lwip/.gitignore

diff --git a/net/lwip/.gitignore b/net/lwip/.gitignore
new file mode 100644
index 0000000000..7b5dacce90
--- /dev/null
+++ b/net/lwip/.gitignore
@@ -0,0 +1,8 @@
+lwip-external
+apps/ping/ping.c
+apps/http/http_client.c
+apps/http/http_client.h
+apps/tftp/tftp.c
+apps/tftp/tftp_client.h
+apps/tftp/tftp_common.h
+apps/tftp/tftp_example.h
-- 
2.30.2

