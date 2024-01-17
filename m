Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4D9C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1AB878A5;
	Wed, 17 Jan 2024 23:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RA1+4QW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDC787887; Wed, 17 Jan 2024 23:29:36 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBF3878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 67CBCCE1D04;
 Wed, 17 Jan 2024 22:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1AA9C433C7;
 Wed, 17 Jan 2024 22:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530572;
 bh=VBzPAyeMTlsjmIQ6UNDwJPp2daoX5QXO7eMi3Zftqrs=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=RA1+4QW2WVHfONEqoQVRR7eVf/vMNkWHqCYK6wHEswXoHge14sfCzcOKmbH9cTd3y
 Gkaao+K+kj10f1V8hf3MR95PMk62XnQvhBgjQPj+Mdh0J+Qk3DFZ3OWmRAAByWfAiE
 yMCXGyJPaL9k1leBSSfFQJFRs8w3BA/Wie9Yy1/TDRmk9VP7wvOt0o7lexv+BNof4F
 0uJRlhL4AQV4pE8vU5dw5rJU9Y+d0n50Cgvjiy2jzR8a7E4cMvq3HSvdXdHoM2nomR
 ryEdRt1iRlkXQu5ZITuHbgPUO9Yl+fgVnnkTcJiN/w9DmfHni/qqwu3py9mhkyhgvw
 7UkSPMeEBB1dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 90CEAC47258;
 Wed, 17 Jan 2024 22:29:32 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:29:29 +0100
Subject: [PATCH] video: console: Fix buffer overflow in cmd 'font list'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-cmd_font_bitmap_segfault-v1-1-26a9239b3831@jannau.net>
X-B4-Tracking: v=1; b=H4sIAMlUqGUC/x3MQQqEMAxA0atI1hZMEEWvIlJqTTWgVdrOIIh3t
 7h8i/9viByEI/TFDYH/EuXwGVgWYFfjF1YyZwNVVFeIrbL7rN3hk54k7ebUkRdnfltS1lGHTA2
 hRcj5GdjJ9a2H8XleBj1x0moAAAA=
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=j@jannau.net;
 h=from:subject:message-id; bh=oLWLRpQevmWiJT2aHHLeLaW3z9ApfhZ2ZwzHiJ6rOn4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVIaf3PXnjHeGebWX+6dHqYtk6kThugevXPdekG+04w
 1PslqHbUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCKxYgx/pcW1fRbrli7h1J8w
 hUnT/LTc/dVvD5zc8faxu9uHf6Zs2xkZngi8Xzn7rO+BTMkvL6Ns/p/83Kq+k0lLRjX4AEvQlvc
 f2QE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

vidconsole_ops.get_font is documented to return -ENOENT after the last
video_fontdata entry.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/video/console_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console_core.c b/drivers/video/console_core.c
index d17764d0b0..939363653f 100644
--- a/drivers/video/console_core.c
+++ b/drivers/video/console_core.c
@@ -225,7 +225,7 @@ int console_simple_get_font(struct udevice *dev, int seq, struct vidfont_info *i
 {
 	info->name = fonts[seq].name;
 
-	return 0;
+	return info->name ? 0 : -ENOENT;
 }
 
 int console_simple_select_font(struct udevice *dev, const char *name, uint size)

---
base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
change-id: 20240117-cmd_font_bitmap_segfault-cf291e2621c1

Best regards,
-- 
Janne Grunau <j@jannau.net>

