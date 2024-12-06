Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD45E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B013B89622;
	Fri,  6 Dec 2024 03:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JscjGxcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31476895E2; Fri,  6 Dec 2024 03:36:40 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD388918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-843e546c7f0so59042639f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452596; x=1734057396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+zZG6fLQOAfN627Etd1WaVgdXszogCdbESqGfPpazw=;
 b=JscjGxcKPMG075iXdXLyBI98mBiEeKusajhi9mUWlLJHm5HANEpefPZb5bmLL9HDP4
 kg0I3PK+tQPt5lf6BhxvXkiWcha3L4VcgvCR2q+NRl5top8cUNrutSIsDvwlZ1onShyB
 pn7DYiZtYa4H7osOh/Th5STwH1n2DCXU3kstA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452596; x=1734057396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+zZG6fLQOAfN627Etd1WaVgdXszogCdbESqGfPpazw=;
 b=wlvs0OqowS+0J5Y9HRoKPTIJDoj7U1TYlnDD/JCFsHp6h6lKSue5Am32uRWqXXgKwO
 RzRMhKDDotMjUPyWHt3Dr9MgHqOSY7OX9HqHtQhd/a/2dfD3KigdTqWZy+5olvp9fNy4
 E/Hw+uZ5C0csV75rZ6ErAhT41kXHJVDr2UMXzbfzM+pJInDUjfy8m4s6jnLogMVmlvBq
 U9LKTDubvUwI/3+fWuejxQzH0/TUcoO0GHstD/NXJ462/xf8dakTFyfkJg9VAHqGVYcF
 JsyKtySVxCHPCgyQ5Or0CoERQfsxqp7/w5OWpk1luwo3Ah3j/mA0WkYr0tegYfEMM2b5
 pRtQ==
X-Gm-Message-State: AOJu0YzRm63+RbSOMUpfeYrYx87PpKxx+W18mMPTurEfRcnhqYVEyjHZ
 h0gpOpRDaiYYUmT9sBsxVCDVi22X5o8iRE6KQpv4H+11dnMT/sQk3my2+uaRr8B6cFYRORM1Px8
 =
X-Gm-Gg: ASbGncuWcX8k+NnmYSMhwAczVz6vE+dAnlQgCzIgE1poNVF7qsZz6xKx+VbuUpi6VMg
 OBhXYAUvQX6pQ/CtAWwarDv37bL5gqgySLzaXSyEmJEGKU1ZOeqKmVtJ0ucI1ruKpShjGRykiD+
 Tx4QyXNC4Y7wo3yio+PfDCkcJo8UqeW6sSBZ/ywXf1aRikrSPrrqTWeDPPh9odJXkfuIjpJi426
 c7iVVtA3vIzFJnGid7/alp/q3RWxs16EqDb/HNGpCw77+jN1a51vy3nuCKXUeLcZNBV7iek+9QO
 LXovBs/RB2o=
X-Google-Smtp-Source: AGHT+IFG7pibK61Kjd8AVdxw7LHwubOAqIltuCSYH0BeQ0d7caLZljL0pyoG45pm7X8mrenapdMiBw==
X-Received: by 2002:a05:6602:6d14:b0:83a:bd82:78e with SMTP id
 ca18e2360f4ac-8447e2d8b94mr227365139f.13.1733452596211; 
 Thu, 05 Dec 2024 18:36:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 01/46] x86: Make do_zboot_states() static
Date: Thu,  5 Dec 2024 19:35:40 -0700
Message-Id: <20241206023626.2456858-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 94e602b8a5b..3035172352a 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -119,8 +119,8 @@ U_BOOT_SUBCMDS(zboot,
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
 )
 
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
+static int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[], int state_mask)
 {
 	int ret = 0;
 
-- 
2.34.1

