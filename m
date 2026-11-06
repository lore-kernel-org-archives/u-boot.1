Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28E606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j9SLf/1e;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+WEL+EZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A598360A59;
	Fri,  6 Nov 2026 21:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXlbLoGUEOTb; Fri,  6 Nov 2026 21:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E70A860A5D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002229;
	b=E1nfAZwaTUIK0KSfjDisbjmukPrTKAx8T501xA0cmGgougYHKdO619BSCV2XLOMniruw
	 dJ/+r412xrBNiftTDAamCR+PTRJJgbJj+yfC7CZ/cTUYgu/yFhwTluJ2lK225bISDbl+U
	 KU9MzUjEIRBCvRuQnCr6DjC2J8peTK/fxlpIjuA/m9K8Xd37B6Ib2B17Vq0LA7vqApY2O
	 NVECEb9zmLAqmOIa8HDnyzPuM0Fy3NcheAGSkl2xG01imBs6SI1byB1DldydjyRZqe5va
	 xbYRFvn1IfOLstBa4VvkvDf3osxuZECrzpzgkcU5vW9Mbgfkx8U6egwuRpqqWzD2KXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5FATnqgeU3A3LQdoX8Ytzm//qqQmfH/FwdGgKhAryo4=;
	b=A3PlkJ8T01gBztUgOOnyuPdgtm9sp6EvC80eef1Yu7nKul4V4rydmDhjkfRGkhZ9597G
	 p51scRv8HLiBBfS2LTJX7XoBolTkgoLk6FEc9i4dIbRs5T5KXjpWuQawYoXdueMFhLc8e
	 YERoEmll5t9xHdSWloox73wcitOALS4mZjAHH9Qdw4tkhv13odaHR70u7E0O/3t9lNO1l
	 tq528yhEJGZDSk66mxRXVBiuhRbzouv4ySiXlx1VRbFpfyECLqGEpzQHaQnpfDO3z6DMb
	 IIxExzFvdpOSd4SgT70X9MIq50PtIs+DZStCLJMm8/8KkVraG0LVthlMQmHTbC/O1xw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002229;
	bh=5FATnqgeU3A3LQdoX8Ytzm//qqQmfH/FwdGgKhAryo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9SLf/1e6PWjZPumBZGoGIi1fahgZDtP9HofYN7cfhXfrm1lOrmaQ9EHJ8rCVdEYY
	 QvHfLCA6gJY9GEnF4WOe/vlX/jrXY+LbrocUD+55+cAqRrZPYX2VOsR6KWEYi4tE+F
	 jMFzmHvoFBOppfaCOd7JhCU8xJyKsAoNf1XYBWA04CxWs5XDvb+mQYhUk9TV4rdOKH
	 M4FzKsWDlo4UfUFxvH4+ChPQ/izModfx2atIP0z/u0HZWpkctUhXBz/zxxVnwLTFQO
	 f3LqGLejRUl4E8L1U7POo0D+WAO3ngi5+35zr98L9gdpQ3rwlqKjB0HKrmdMQtRlf9
	 xsqBbG5fUQNIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E70A860A5D;
	Fri,  6 Nov 2026 21:57:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54E6B31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 520B280F55
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwUVP4gJadPJ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 549E180F50
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Y+WEL+EZ
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 549E180F50
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:05 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so8083625e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002224; x=1794607024;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5FATnqgeU3A3LQdoX8Ytzm//qqQmfH/FwdGgKhAryo4=;
 b=Y+WEL+EZyhjGS6GHOiVclpXXgAVp0XzQ3UICrt9F2E7ANDJ7GYLnKZ4A/u9j0QbW9f
 A42WXs4b98mpOo7d23RLV/xBoTBUfaTbSac/EPDwn9NRmaRzU/HHU3oCb8zI8GLWVXwp
 rwawi6EJfe9SkBIqV99VqgaGrqE/JP1rgbcSp3qHFpjRrtNkCd3liKj6WOWD0tQRKXXH
 X9OgDHRAWMGtOS7HIK4Rxgu9IFEB5UrVKDDF2j9sppiqAS2ZjW9sA0+MVzmmFj65wM5p
 QD1PC0yS7/FBVX0KkYzY/IAsSgahuu08T3NdI5Y815rwnOL6ace3IkFVE6vXcwGhP4uI
 BKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002224; x=1794607024;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FATnqgeU3A3LQdoX8Ytzm//qqQmfH/FwdGgKhAryo4=;
 b=E5cr6yXNHepBR1lRV0KG9yrrC6bSnAtpFxNq0oC3IpZ8YiKIl3diSoIBEsQNhzzM7N
 abRIKXs+X+mSArNNuEm20pBTGdzVHUw4PFUpy2FstTiISnb40iHkOJ9kFcWdJAavcQAI
 g63M4S2pn1eTVQkQnVZ7BM51Q3FZHW9FP8Hgd7dZTzwbW9Uk9RJoXtjk8wEJF21WaqJy
 yfZ/p8qgXEaGWQJSNReSbgJ9R/kcGcadfxWOacbVdENB4V3cw50Cv3ASGFBNJc7J6Igp
 cNxBC8z8KMgmYkDpn0MBb+MChqjW6AuWT3WjVEpKYsqmrdRK6NcOHFxMlekqDQ0RxCA7
 sSoA==
X-Gm-Message-State: APuU4Z/xYe/kN0K5TN2Pzfw+y/ezm6Mo0VYrnVqpkYXzbvbIPQflYFx+
 x1nAxFGUHb7o8PHYff7Ytc8M5iCyrEbt+9d024lI8BZBWnmv5zL1iB+GwRWhhIaEAMI=
X-Gm-Gg: AYBFou2pY1Niwtjdq8YBHnDRn5/uumuPYJKxGcf8QZdhHFeG2G2jj3Z2mQivf0AAkRC
 4Gg12UF6JbYHlvUrkyDUa8MPOuSFBtVpzTIrrNGwundsvE2nkOItKI2W3eh0M+RcwEFT50HH3I6
 FUSNlMxkFY1iDGMx0CIhYpliadibUvDBr8YFrQXUNIej3Y9OSObn1KhPB3WbYRt7laYGJ5d3HGj
 vNsEfcKp3c5/sIxKKxgevmGRmWPsXjhJvwHHjdaibrrWuwkC5ctmpannwggyMFk3Eb19nJnHrcg
 tedhhQBTS8YyqyhjUrj7I9Ym0E9eyKMVqDHsR3j3hXs/4TgBtMty34ib59DUfWAjWxdiTeeO5ci
 x7xkU14lJJNsXu5eGKFq1tb1JzrtD3z98b1nqa6iTrsfYmnG5wDhVv/IOr2Atef/D1A6lAL0SjG
 VdSE8c6PRu+bZcHRj/SwI9TYh4vBiHvIBwEaCPQ9S54UAq8VVeqtmxHS1mZmEDqPK3yTfqS7+la
 JjCVjcmgL7mOiB5uBEEpd/H25MTBT314TN9QxYtBTGLu7sW4dDzKaSBVWWQJu8FevzjuBU0aJeE
 ruiiro39pT8/yOCUZF1jIjT0F1EpyQ0=
X-Received: by 2002:a05:600c:a10c:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4b6dd82ab3cmr49595795e9.8.1794002223840; 
 Fri, 06 Nov 2026 13:57:03 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cb75913sm19496995e9.0.2026.11.06.13.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:57:03 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 07/11] efi_loader: check certificate lengths in
 efi_image_authenticate()
Date: Fri, 06 Nov 2026 21:57:02 +0000
Message-ID: <67663e6c-776c-4452-94d7-e7b04d41af7f@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_authenticate() walks the certificate table of an image by
dwLength, rounded up to a multiple of 8, without checking it against
the table:

- a certificate no longer than its header is skipped, but a dwLength
  of 0, or one that wraps around to 0 when rounded up, does not
  advance the walk, so U-Boot hangs on such an image;
- a dwLength larger than the rest of the table makes
  pkcs7_parse_message() read past the end of the table and of the
  image.

Turn the check that skipped a certificate no longer than its header
into one that rejects the image when a certificate is no longer than
its header or longer than the rest of the table. EDK2's
DxeImageVerificationLib also rejects an image whose certificate table
holds a certificate shorter than its header or longer than the rest of
the table.

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Fixes: 1a44b7059c18 ("efi_loader: image_loader: add a check against certificate type of authenticode")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v3:
- fold the new check and the old "dwLength too small" one into a
  single check (Ilias)

 lib/efi_loader/efi_image_loader.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 417282698fa..8f48d8fb5a5 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -808,14 +808,26 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 	for (wincert = wincerts, wincerts_end = (u8 *)wincerts + wincerts_len;
 	     (u8 *)wincert < wincerts_end;
 	     wincert = (WIN_CERTIFICATE *)
-			((u8 *)wincert + ALIGN(wincert->dwLength, 8))) {
-		if ((u8 *)wincert + sizeof(*wincert) >= wincerts_end)
+			((u8 *)wincert + ALIGN((size_t)wincert->dwLength, 8))) {
+		size_t remaining = wincerts_end - (u8 *)wincert;
+
+		if (sizeof(*wincert) >= remaining)
 			break;
 
-		if (wincert->dwLength <= sizeof(*wincert)) {
-			log_debug("dwLength too small: %u < %zu\n",
-				  wincert->dwLength, sizeof(*wincert));
-			continue;
+		/*
+		 * dwLength includes the WIN_CERTIFICATE header. A certificate
+		 * must hold a signature after its header and end within the
+		 * certificate table. Reject an image with a corrupted
+		 * certificate table: a dwLength of 0 would not advance the
+		 * walk, and one past the end of the table would make the
+		 * signature run past it.
+		 */
+		if (wincert->dwLength <= sizeof(*wincert) ||
+		    wincert->dwLength > remaining) {
+			log_err("Invalid certificate length: %u\n",
+				wincert->dwLength);
+			ret = false;
+			goto out;
 		}
 
 		log_debug("WIN_CERTIFICATE_TYPE: 0x%x\n",
