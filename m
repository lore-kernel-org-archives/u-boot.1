Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE5608361A
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=01A2Co4W;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NxY/XKgw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A103E81148;
	Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7M_zd_p9jpHa; Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 996AA81154
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722389;
	b=CLA0nhKGH6/s8R9k5wTCwYLk7av9W2trWDWVjn2x2As+XX235GZZfcmJYD+LbIPlqXkj
	 3DaUNnUXGNEakXFzAxpYB3I8cCw1Re54AQ91NjxEFsF7eXvVUqTynG1bFyNNwFEZQV1Ph
	 mk23sAUTeAVPcLs7Mn1MER14efGN1GkD9Iyno0LhhtVsgOT9GQgRT6gMI5d5YOhgCwLmK
	 5ZvQ7gehN881UnYtJO2ThCmqUmOBg1yoISnIc6hLjoRO5jL4CbKlf1NLKzPMm7KtTgclR
	 bDKmzNDCLgP6gA9ryxf3HntI7W33HFPXcSLJfp42vIEbVjZQW2LquAPIcbQ3Wowq9tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8KwiOgHeQmV22LAIdoSErNfPDDPzNTN71TFqOKSHx9c=;
	b=jySiaEyjBFvLhIl4izqIwidYoGLHbcwNS32kSentYsHUswH6EAY32afwW3xFm91Z0sPM
	 H9lJNeCn83uO9C+6krecc7k7ooxPeJzQ8YVqWhoeCqPhA+EGi/lvKJdgy6Fy8alKnkXvG
	 NlyJGt9ZIp+bNWYTbPCFZ51y1u0bMxn8yJvbkowuoHTcTNx1qUrBd/8fBhb9VmsFcc/oK
	 F4bBqp3M0wl08xwsJYiU9KZrQZbqkGt0N4oJ49l8IecJTJn5esU0P4WZ3JG/PRhpYKnTQ
	 HJvUJv1wziKxtenRuVbIl+TeX9LFVViUW3SGTCKjELhp1eulRn5n3WzsJ3cNU2YOP1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722389;
	bh=8KwiOgHeQmV22LAIdoSErNfPDDPzNTN71TFqOKSHx9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=01A2Co4WZp6UaRoeYhD3vfCTW8XQkbg2Sa4fSeHAl52fwzkgwLh0NDNpIrPYCDfeh
	 pmbb2aJ1riqdrETFyb9MMEuzFAcNPHWwsy52F3jGaSGsZI2JCC7zip3bGzqtbTUW/t
	 v5v20USTSe7YdlKuPRJkYMtUyVFk9Ilng6u8QDoTN9psJc326VCNV9mkBz4/Ka5gnC
	 Q3z305FDcFr9ZgoGCbAbWxiCOU3bJ2y3VBZRX0PLQEkB71jQaGlfw67rZlZuH+75lA
	 0dKk5tIixGgyYwMpBuqSQ0oJItR1JSqnrOYVthXq6Dhr+LuAVleC1coCWvLQVFQbvy
	 tnUDlJBEYMU2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 996AA81154;
	Tue,  3 Nov 2026 16:13:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24D09D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1613260880
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mprYH-IhqDzs for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17A8360856
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722387;
 b=YIND6uyvcHZ2rMQpi+rBgCtIgE4X84hGzFLsQQjvT3SnauvWwmbnRgf3OA9+/UeALNY0
 T1u+Q7ZVTOifI0miat9cBM3Gk2kZ4ok3nGgVT1tohc4LZCfOW2kvcfkXdpjupTjsOd7IO
 7taNgBF0/t/Y9kBBVru+ThOX0QGVdlUWS436LNv0+Xi/1qK+5ToebAexJbwtbbJuBvAOg
 w8BxNsaPwA5/XmznwVfOqK9dtAVdUA8JFv+yseo398abI9stJgbbJ6PyOwaiSzPK4c4OQ
 nK5uvDndL3MCtUs7KoJ7v7Coul1ROPsy2sU8rSGCTphMKTdxk6K06FFqc0wgig+djsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722387;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=8KwiOgHeQmV22LAIdoSErNfPDDPzNTN71TFqOKSHx9c=;
 b=hLpEckUQVt4/TfP7o/PkPgJux9tMZNHiPZUGMjd1kV/wVfJQIMxzR5PmwcsoxH9pmGTY
 o7l338RHaShNgt06Yu8bGnYs2t+w4crNJGm24LPWXj9uH26bWAXI8Gh1qHqayBU5Dx7R2
 qVkyqWO2v1maKDF7J32I01VBWkG90QTkNvaFIgTde0eKcWd4Uejd4+X9N7ARH2KByc7lv
 2VvCJRcXJdTKZmU0DVqq1e85kFusJyDyyRerRLiQ6fMQLaoy96alpqjPJts2oc6ZOHcpk
 ncG3pXmHPh0JRSZWk9XkVHj73LY2kJE8ePJR8IvP4wqfOAi9uXvk/URe95z5gcuhzOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="NxY/XKgw"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NxY/XKgw
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17A8360856
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so9011025e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722385; x=1794327185;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8KwiOgHeQmV22LAIdoSErNfPDDPzNTN71TFqOKSHx9c=;
 b=NxY/XKgwq9SdPPiD5XTEsifGU0Nkoj02Jtv51q+pKLmiQ9eS1ys5wwIN0smPM4uYpR
 3hTjlvpdc4zohZJRCSjskdTYO0fRLvcaTe0g4s8v5HHsKSBoqysopBiM1fHvYRjkv3Vr
 BNYI364ZHErRUgUegi+JSl4MTg3KaiiOhfZR3KFlQOOJudarM/aIg9SwqtbgsIlmdvN+
 rpSUsQ0WAhq0bjd5kRjfNA+E0D3NS7SXAqO6jYWd6snyhTyEkR0KLFeSblXMRVaezOZO
 JeDQzN0tWASOwKFFxYBN7LARuzGUES0YQgWq4zJIWhxEPwiqgNwdohgvQVO95QNaQoj2
 9nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722385; x=1794327185;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8KwiOgHeQmV22LAIdoSErNfPDDPzNTN71TFqOKSHx9c=;
 b=ICf+DHVytN4wxvnMGZeP1ftJkeE5ApS6iEBKCjg2ykbP8ho2+X3G+vmWeahScnTpJb
 VncobJPUt/gBjWASSNG1kyoGIy8hsdF6W6/GALZb++HuhujGmhs6mOgjXYsBXL0OUf1G
 a089hoiPcZ8cZfFxLqkLI5YKNxgOp76CQPPeU+sTCT2/LCLlWKeJHDlto7IOerW3DYOt
 yNvkt2+kdly+8uauFaeu1mUBS1E+6hAZq7jzt5nsG4bOgUSGumTaiuFwcXbZGGgyX1zo
 OHx5vrjt/JXxqJgfOi3Jzs5k9smLRM8PpIvu2l+xTsNkEUV5vho5e8+kP0oOhsA7Ijer
 FEOQ==
X-Gm-Message-State: APuU4Z/z6Onu64Ciruo2s6GarefD6aPqXcEKgtZ4K/ri7SuTfueimln7
 XjgyK0b3EuZPSrrPjwXS8O/gIs6/meqPPgeuFJu6NnEgnYglTiPsVy3isyRQ8EOb8TyjboW6
X-Gm-Gg: AYBFou1Bp2LmKnPFbErOLCRDHDOyyqd+BSCPa6qH8w2cOebDKcUjJLYMGvN5C9Wy+9d
 j9dmFfxLOhswDK2fJQDamSmamJCo+k+X3aRTT68+dmrRYsRKv0ddve7p3opTSWrIsJ2rW0HUQQJ
 yOKOl/lLsHCb98Suqg+quHQjPbyqFfl9+dbLjWYiVo6hYGRQAu2U5hDlrQqwTDF8GZKCeSv6xX6
 M9Qd+M6Jlqn3Sl9+qf5hIOn/PHW7nx1f0xzTjhl4PNvI2Z5SbKjNf+SC+W3Pqy3IOZVqceEO+Y7
 ePadu3qwOvwGaIlN5S/x6w1oiII48/QWjzKxp/sFRS5MkbIe7ppzojGVq7UDlGepHgDYJyFd4wO
 icYMb8a9DbX5Me/1TxfOpMZiEiPnzI+ZtDdwsI0wsLPAaV5zp05GXb2ynK8BxvUFjZKJM72PZEt
 Upz5e0bPhrzeuntDQwc23VZIKe9Guj91xS1tCI5Dkq87w3OwHjrsWzU7uTGSN0YyknI+bq+N+qG
 VL7GzWKqSuE1llFS7z4ARD58NGJNvsozaYM/ZXqLy4n+YIdXMgsuQ7Brd0ovxQvHh2TdRYGFqrp
 fhUYV0X65y8ha6pgsEhSdDrBqDgCLy4=
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ac17e10724mr312761305e9.16.1793722384668; 
 Tue, 03 Nov 2026 08:13:04 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm67944845e9.9.2026.11.03.08.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:04 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 07/11] efi_loader: check certificate lengths in
 efi_image_authenticate()
Date: Tue, 03 Nov 2026 16:13:03 +0000
Message-ID: <b509d1f3-50f0-4b3f-97fa-724862cc92fe@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_authenticate() walks the certificate table of an image by
dwLength, rounded up to a multiple of 8, without checking it:

- a dwLength of 0, or one that wraps around to 0 when rounded up,
  does not advance the walk, so U-Boot hangs on such an image;
- a dwLength larger than the rest of the table makes
  pkcs7_parse_message() read past the end of the table and of the
  image.

As EDK2's DxeImageVerificationLib does, reject an image whose
certificate table holds a certificate shorter than its header or
longer than the rest of the table.

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Fixes: 1a44b7059c18 ("efi_loader: image_loader: add a check against certificate type of authenticode")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 73e96b63671..5a784bfb43a 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -808,10 +808,27 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
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
 
+		/*
+		 * dwLength includes the WIN_CERTIFICATE header. A shorter one
+		 * would not advance the walk, and one longer than the rest of
+		 * the certificate table would make the signature run past its
+		 * end. Like EDK2, reject an image with such a corrupted
+		 * certificate table.
+		 */
+		if (wincert->dwLength < sizeof(*wincert) ||
+		    wincert->dwLength > remaining) {
+			log_err("Invalid certificate length: %u\n",
+				wincert->dwLength);
+			ret = false;
+			goto out;
+		}
+
 		if (wincert->dwLength <= sizeof(*wincert)) {
 			log_debug("dwLength too small: %u < %zu\n",
 				  wincert->dwLength, sizeof(*wincert));
