Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C9C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F56A88403;
	Tue, 23 Jul 2024 01:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XKYYUHRg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ri5uDrkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA67488569; Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850A5884C6
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WSc282JSlz9sq6;
 Tue, 23 Jul 2024 01:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c36Ws2Mt/d0kvXQv0U+wAJcmLQ1agqMikhVtNM6dSQ=;
 b=XKYYUHRg9p02gC1S/vDIKrnDznF9LIZr+EfwzfjbhHM7Tlxzy6azlaIbjPRWyKAO5EY5hZ
 2k5JmF7zS/cWB8qBU3sa7ggnJf2PGV43mUHKMeH3hFOoL7d+0S9mLKV3cJ4NJT91RZv85z
 6IO+jRHvJV+NJlmMKTAOHfMD72UXlMGek/ho3hR6UF+XsFZcA/i4MfEqJsFWruZYH9H220
 w8hlQ/ZZVbKtZs6qVewdkujkPCvzShmND8KwXyf7iWIZAGXcjkkggfDqlDj0k05Bf6OQuO
 Ak+c5uQTiRqpE6CGBy/QDvMpN2F/2EgHCwW+/7GNkW27Vvuknb+93aUwlUoz8A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c36Ws2Mt/d0kvXQv0U+wAJcmLQ1agqMikhVtNM6dSQ=;
 b=ri5uDrkD6YThxVs4bidnhRj+Y60T9pHrtI65Wxgdbe/rHn5lT+ft0nVI45g6tInnIYQDZd
 OOMnq7K3O7XmJw209vgVnFpIh2FapW7gBknY9I3NjGLWUnk9jYQV8fD1rcTUjXDovlpHk/
 c6En3P97AF4T7cx9cWdqoJq9xEcs2wZx/mUtMonkFKtFwyaHuuPFOKIIlU8GM7AHzlpe5F
 jRzawX/VxfrQj85SBnhP0tUMo8FE/BWmZHVyjEf2ncWuiUEHcm6Vd/HCYGRT513H6op7Kp
 P3ycuNfGm83n5XTieew+vOKl2KgQATZ8NnQF0gwb4OGFQH8s32pRlVg/H4m+tg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/15] include: firmware: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:23 +0200
Message-ID: <20240722232910.91249-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 52c1a47b96739f25347
X-MBO-RS-META: z1gqpe38tujmq74ozxrs79uyyzxzonio
X-Rspamd-Queue-Id: 4WSc282JSlz9sq6
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/firmware/imx/sci/rpc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/firmware/imx/sci/rpc.h b/include/firmware/imx/sci/rpc.h
index 85af6f3996e..28adec2a8e1 100644
--- a/include/firmware/imx/sci/rpc.h
+++ b/include/firmware/imx/sci/rpc.h
@@ -44,7 +44,6 @@
 #define SC_RPC_SVC_SECO         9U
 #define SC_RPC_SVC_ABORT        10U
 
-
 /* Types */
 
 struct sc_rpc_msg_s {
-- 
2.43.0

