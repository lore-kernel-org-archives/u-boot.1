Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5BFC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 12:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E89787EB5;
	Sat, 10 Feb 2024 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bFVJgByW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1919687EAA; Sat, 10 Feb 2024 13:47:01 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9160187EAE
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 13:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 72070CE129D;
 Sat, 10 Feb 2024 12:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABCEBC43390;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707569212;
 bh=l0vhlQ0LfgVNNNNQ5nsfyCvYxkUFdNAIGxRUgW8Brtw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bFVJgByWjz0g7qCxA7m4oqZPGcj7LbWoVie8W6XUdiHycjNk4MrifjSPvj91BsPie
 z7QPMjVi12XmoY1bSALhO+UeGOx1Y+IZtycUzSzetrerxMck56y/FotZO7F/z2SDNI
 zV5ooUGE7bMOYomxPJ7aLEtRn2x4C6edXmmP0+pRKAV572hrB6sj+7CMG8BA96AYDo
 l1rwJ6aQO9eHer+sKVv9PheGHFbDkxBfx7FjZ8zpGDakkK9csrHiKjWRkNBoOAb7ar
 ZDRWzzZjW85mxY+EysHHweX4sAUqrJ81GYZaTJdcWSgs08ZVIERN5JaaOilTM0L3cq
 HPTGzaMDNZM+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE0C4829C;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 10 Feb 2024 13:46:39 +0100
Subject: [PATCH v2 1/6] lib: charset: Fix and extend utf8_to_utf32_stream()
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-vidconsole-utf8-uefi-v2-1-88c03db60de2@jannau.net>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=j@jannau.net;
 h=from:subject:message-id; bh=YrPQYvhVIvEbmI6hJPScftABwGiEyqsG2EZ/Y+5fk0M=;
 b=kA0DAAoWoRs8240vZWYByyZiAGXHcDqhetona71Qdd5ZmeyfYQfuRJjWpAobL4Bw3S0zNYHYU
 4h1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmXHcDoACgkQoRs8240vZWY0EwD8Dhfr
 kHxjXE5nC2Y4+Wu0Mq/zykQ8SebIjTjtKpktEgIA/3NgBZ9+KZ5p5GkJ+g2GRvArI8WOmnndAyi
 x1gR55k0O
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

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/charset.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/charset.h b/include/charset.h
index 44034c71d3..f1050c903d 100644
--- a/include/charset.h
+++ b/include/charset.h
@@ -324,11 +324,21 @@ int utf_to_cp(s32 *c, const u16 *codepage);
 int utf8_to_cp437_stream(u8 c, char *buffer);
 
 /**
- * utf8_to_utf32_stream() - convert UTF-8 stream to UTF-32
+ * utf8_to_utf32_stream() - convert UTF-8 byte stream to Unicode code points
+ *
+ * The function is called for each byte @c in a UTF-8 stream. The byte is
+ * appended to the temporary storage @buffer until the UTF-8 stream in
+ * @buffer describes a Unicode code point.
+ *
+ * When a new code point has been decoded it is returned and buffer[0] is
+ * set to '\0', otherwise the return value is 0.
+ *
+ * The buffer must be at least 5 characters long. Before the first function
+ * invocation buffer[0] must be set to '\0'."
  *
  * @c:		next UTF-8 character to convert
  * @buffer:	buffer, at least 5 characters
- * Return:	next codepage 437 character or 0
+ * Return:	Unicode code point or 0
  */
 int utf8_to_utf32_stream(u8 c, char *buffer);
 

-- 
2.43.0

