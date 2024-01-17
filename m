Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC36C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60510878A5;
	Wed, 17 Jan 2024 23:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PwUBO4jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AF287B30; Wed, 17 Jan 2024 23:24:39 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375BF8798F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9451F61762;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41D0BC433F1;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=u/sglJJk1DWnWa8IgKOOGYkOD1r0ML0YT0rNxzqH6uU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PwUBO4jr8zt1nVtPBlJskPXA69J3lDugxOxdbDAPWCQPe7LxUQh1/Oaekzw+ftier
 yQpMfF8ctofsgkfo9So6D+lbUsCDgRExMIMOTMO6ebCriMHHgrCeJV9e63IpPtfEQl
 qiwncht3eYSGsr4wfnmhoPpfw2mASF5BKuGGfEYNuEF2QeUBk4NZJKxm+MR6rgvJNs
 Dm8nMid5q9NYNjUKLl1Td3knayvqDlmrQ7JskcPJOmVCTDFMX+7UrWEEYdKs/20UqE
 AmWZZC0uBJsb3CYQnQvDGY5T/aghaJbaMA9Tq/wWrdi5vvjgVeRfRv8/Kxfv4M+7jM
 L7Jb7nCpumrXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7DC47DAF;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:24:27 +0100
Subject: [PATCH RFC 1/6] lib: charset: Fix utf8_to_utf32_stream() return
 value doc string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-vidconsole-utf8-uefi-v1-1-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=j@jannau.net;
 h=from:subject:message-id; bh=8Bj3c/CpUyys+j2k/9GcsKR+Vh5RZAyr/weGo5S8Tqs=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwQveeCzc5eicoDGTYb7reVl1ieLZfhYnttfvVi5ec
 /W8TYhlRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIm0bGVk6NgRyjfvZMLib+sN
 yqLzYmU1mev/2S5K9L5RNP0Ya+aetYwMl1gzFpZ5LOaLVF2o4/p6kkBi7wtrliuXPn568lG2hSW
 TFQA=
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

The comment appears to be copied from utf8_to_cp437_stream() but was not
updated.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/charset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/charset.h b/include/charset.h
index 44034c71d3..714382e1c1 100644
--- a/include/charset.h
+++ b/include/charset.h
@@ -328,7 +328,7 @@ int utf8_to_cp437_stream(u8 c, char *buffer);
  *
  * @c:		next UTF-8 character to convert
  * @buffer:	buffer, at least 5 characters
- * Return:	next codepage 437 character or 0
+ * Return:	next Unicode code point or 0
  */
 int utf8_to_utf32_stream(u8 c, char *buffer);
 

-- 
2.43.0

