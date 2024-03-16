Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A251EC48BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171D98801F;
	Sat, 16 Mar 2024 22:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ROA48Naq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7436188041; Sat, 16 Mar 2024 22:50:34 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110EA88054
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1991ECE0976;
 Sat, 16 Mar 2024 21:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52058C433F1;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=W71KpKxoAgOUJu1caUrUk/1rV0LuOiCAbXBWZ0+vXRM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ROA48Naq+Gk+1ffWeQgLh0241MbDbhAiib1ySn+udjRSNwRB7RSc+9mJbR5sjDDv1
 3L/plxxNdamNZIuNXWDLxOwsJJSuFr9DRJqUuyozvw7v7n9Fr5bCMT4xVmpvxKZ2xb
 RYReejjXLlGSmO2eJbm4bvx86R8sG3dgSG4kjn9cYdGOU2kzuYggoIsS0Km9bGd894
 ajtgBKvaVSKhAnqCzI6JAdZiI/7FcoyUBR+0vKGZnVxRpGBSCEjhRpvxDorritDJKK
 KFYOY2IbzqNMUmd99XhcNw+tkcNnShayl5tFk67OxP5JXrjbZkORBZaopij76X87t5
 JLBRS5oZWRwZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 39704C54E68;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 16 Mar 2024 22:50:18 +0100
Subject: [PATCH v3 1/7] lib: charset: Fix and extend utf8_to_utf32_stream()
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-vidconsole-utf8-uefi-v3-1-4e8a3d349447@jannau.net>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=j@jannau.net;
 h=from:subject:message-id; bh=GGDZzVt5+3XbxA+40cxNNbp+I7PDL3t7DkDHx2HZSBs=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIvJ8p0v/Xjrw6KKw4o2PZyrzGs6Wf7ffJsJ2l8vt3
 /X3mrk2HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZitpWR4eipI8ePX76x/vHv
 +ODU42tiPCwU/5o8sQm9+n2nDXN8pibDP/tX88RyF8SITJt7OPKqnw3b71i7WLOZc8Q1V/71+lz
 wlhMA
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
2.44.0

