Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8681CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91DF0408EA;
	Thu,  8 Oct 2026 08:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kebccMWwkeZu; Thu,  8 Oct 2026 08:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD98B407ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448671;
	b=YUMELbfjhlCDsMA4Qsqt6WPtT9mm1UFf0UoqBFamgLLKhPibtrjCkimnHd7zrdYrPr+1
	 OfuLel8PMRkA7dR0G6g4uKmm4KoNGcr7zsTwqK/cajPsGsfWBU5h2zj4/E1i5rVlWzVbc
	 zPVT0U+bQjUh/ZV3f2PeABIQnvxRzl7l/itqeqnRpPcneBt99YPfP34N8lpHay03cCQog
	 XAYHwP5l0CrtkyRjNuwBEfeDjhXagO8P/AUPzohEwGB7y28l7MPLlfmi0B6tSgP6jWH1O
	 Xj5elQl6Zg931PKk1kFJbqxzITFTq7HaYdkOtakSAkoDfY94dMjvuRps6csdl4o8WfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VnGuYfpCdlJ/3Y2ygbd1mtRND2/U1ytrt5IkhL7X0Ug=;
	b=TpJPz0Drbn1Jbv1uc7Z+6VTG03qGDlk26Fj/ZPYoYztplzBpJ21MT+DlQmUJVs3Ceiwv
	 3bZcYhFrrUfxQc4PMAzb9U0Eki7VrYNaLoyI97xLmlEZZ3Rq1P5wcqY25ovEJOE9uDyEg
	 yQk1Bq5ZmPsBTOpXycCArmNqyOPvaeZ2WyQY7JquLc+P7rWcdGtXYplC0EsV0EINdWjbD
	 SoUm6DVV2vEoq05t3t1KNRQqvj2YW2PnVBSOxZAE5Jq+/ivKK3aJByD0HwRmyQXHHd4RY
	 zUN0RxwB1E6l3xil63P6lYzAafn4J5Mn1ZEOVreOQ3Y1qxKPU8T02Itf/UAjiZHAQng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448671;
	bh=VnGuYfpCdlJ/3Y2ygbd1mtRND2/U1ytrt5IkhL7X0Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrrulKu7PU10867mGj34HHFWwyt1OUZpSm3LdZdQ/oWHB2VW3kSJdJb2SXN5gl9p2
	 aPO7OikCFzfLA0+u08j2F/K+5bVlkCvc9IlyOnaGcYCe2Vnp9/Y2kdggoGNKXTJnO1
	 bSEQUcGFadSdVZP89/JOwGQcs+PeXO/J+wyzW+L2JnPh43PogTMwQ5rVdjgGVBervp
	 bjBaPLzsfdcIFE9sUYsqCIP6u8ZJ0tfJAvbBGLACt706o5mJUk93stpQqBujB3osQK
	 ITafy8ajExWzIPXfjIS5pt1zZhO+pAUT/10oB7GJDz0lbkYoYKdO3vEqu9FKokz495
	 M/hKS9n1C3xsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD98B407ED;
	Thu,  8 Oct 2026 08:37:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 693C522B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EFE2606CF
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ho6yPjdwQ33l for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 11095606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442904;
 b=UZF14evNbLjl6+p8baRSCdxcpd9t7Jj/S3ZdeXHnhD2VX7iAFf5fphdw76YAGDizKJwX
 ZVGnvMoPFes5Dq/uBxdCUvtpvljMY28gg5sbjWkWTd1YGFsJb68ZsFqtds0t21l5YXdyD
 pQxueUY8hCvLz12flv6FUEjAsBDtvIxh5X7+BzybCNHI23oXoDtET3gxa85nEEpNeaLC6
 Az3AvZr1LMSfk3WBDGvxk1B2M0cWa+U84WshceTmL6ASMI1kVsDm/mJYXYtpiiThHhQLe
 FJ3jPFOaX2a9Bi4xpc7XwlPOTHOuxVZonIM1f1Hc+Q04Ki96iogNs5+uNHsDxdpUtpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442904;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=VnGuYfpCdlJ/3Y2ygbd1mtRND2/U1ytrt5IkhL7X0Ug=;
 b=V2lsxitq2Ej0im3qQW+p6aQaHUz2l4a55ojF113i2B7aTIl/SsWM0YkX6YdiVVCjWfyT
 vE2HfgOimJ0f65o9s3zRK916LkixuPWg2+GtRT/YZV4BT24scdT0X6FWTm2KIEN4FuuB2
 VbLhjS08Kl4/CcNPkrAdSOsJHpe4WNGnebAnS5puJC1m94GHRlz0vydkxBnuJbxX7GOGZ
 xDWhP45kJz2WzdLYiguw9/EsPblUTLeewQX3+ly5s8NpAZvo5kiLPp+mrow54A+M7xIA+
 SPq0N9aTDEtmjxRBxQwB77I7OkxyyhGIOH/i59mfZRYwUmNGCH/NC70FDxmoLT/NBEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=tBSUQYaG; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tBSUQYaG
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11095606C2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:43 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 98FEB3F60F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791442901;
 bh=VnGuYfpCdlJ/3Y2ygbd1mtRND2/U1ytrt5IkhL7X0Ug=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tBSUQYaGiysD7AmJl9iQ+KMizrt5b9kqc/Pa5H7GyMhRwaZYyjLNTrht6tW7R04ni
 2188s7oF5fttjdBIJgRtGbaZz9Rz7+Zpm7mfRcJINzFr4FmR4SRaLS5XlaxeBlzB7u
 sgL8Jz4ecaEgmqkn7ljbaMpt9IcPGf3L6f0/uJ5lqOp8ywzYbXBfz5YoiMM5uDMCZh
 r9R7xhnrfV1ISmNWxvjCUnLSE3CZTWk4vAUFIZ3Nw4YZ7JkMk4OIQuQWXuTMCf9rty
 c6Z7SjZIL+l1XLqRnznyeTeB6SinjuNa2Gih9cF4soXCMZVKEr77NBya4EjjMPrQ6t
 eVrmnKnQiQrw/JHKAQrfCjnVqjysTGXAZqERGLaipyroeK7HcjY5fyDSyMvQ2Y2smn
 jjZs1nM4LFI64EU76MfYEzkTZc7d38y0vb9VTms6n6k2ERlR6fvMfp6UKBnuUXbB5h
 KpMa5iZHsuxJYFUqCBmiaQRmP6o4WDYhUStP40SipTzRamTbkv0RxFqvBGenfhZbdW
 VPBMnUmqRrjow0rrlNeGqFNZrR7MOmUTSg0MhidKlVILN0Mb5tcWcHVH6lh6JSCxDC
 JHHTOhKtVgGqoWPyj75YCrkXEdQM5KR7MabrgxEfdKGELEpVkQR2Vxhh/ky3bA7ZtR
 CClV5jzsWyu86nmnNM/j1AjQ=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e6188d1e51so14741655ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 00:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442900; x=1792047700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VnGuYfpCdlJ/3Y2ygbd1mtRND2/U1ytrt5IkhL7X0Ug=;
 b=rReHSPNzqCVvSvdzbsIT57sLI1cZK9tLLZzY0YkOScehuZaTB5OH19mEdNz6Wc7E7K
 k3zI0H5PPWVeO9GSj9QQP0unrvem5ZPJTza3HObHNcFaer+3feKfh2kxlFe6a9IeXYsD
 gswQOzPSV9BFcgfIuyp4vF+37BmoLL7zmGifQPwby9Nyx28bO7dJnNFGXnTAzA5qgc4T
 qdejSBUYQPh/mOK1pX9ssG1uYK5hDpIJZI3fxYzXE7uQI6IZ1iWTbraAik+aqNKTyxDE
 WC/2newlT+KPsAuG0moRg76/Ne1u8jWr7zUcBbfvoBF00YMVJyRNURWNajrtcaTvC5tt
 kE+A==
X-Gm-Message-State: AFq9FYI3SXswbymdJtvzaO1+nTSnWnyI3Nk9n+fXN7bouOBLz8draE4y
 bOXMFuXse39rciLCBdrn1pUL7M5luBUb3mlZRGuxPUi0nOtnulCW7oK4jC8267UWQhU66Mf5Q6U
 E+Sr7QCbrg4LcgRvxWEO1QyKdhq4R5s6PXqa1E59DDuqyrM8ansvZrA3CtC9DIhdHbZqpAm0D8l
 edtBSVK39snlJrJnUa6w==
X-Gm-Gg: AYBFou3VUcHLf2XsaQoIjCdKDdZjLJlaqhizU8K1gxvH5Lz/HNY5xnK7nSoHOzOHLsP
 QD7EFpnI9KSl0DArw/UbjpKbc4ebkJJx0I2nKzqMnzKJyGatw3bPYk3kHja1ah0F7qBKD6GLWhm
 MF7fHkMGOFbGfT9s7CM4hFqrdxOdZSdwPtQZ0hkH2ux/iIUVFVPprqtlqjRFSQLNmWw2tDNvtv9
 wKwqguQlkzfr7DN5M+U7qg8arzaKMpSjFfzofU0CJzYkECgdwwxUpxjC3jT2Uc2kLJN2lfppcD6
 iKb0jBQfEAnFbTdmSq9mQd5phtwBczZj8SkbeBNm/D73tqRl/Afm/sEiHfrWYwhm+0m/PosB3hz
 o00Nnj3hyBTyTGfRPsAI88Gm4t/c1AiaSFuk1l36qfzqjkxCedwRkxLlCOvhzOMiVBA==
X-Received: by 2002:a17:903:1990:b0:2e5:334f:f47e with SMTP id
 d9443c01a7336-2e6003b6d56mr38833645ad.21.1791442899965; 
 Thu, 08 Oct 2026 00:01:39 -0700 (PDT)
X-Received: by 2002:a17:903:1990:b0:2e5:334f:f47e with SMTP id
 d9443c01a7336-2e6003b6d56mr38833465ad.21.1791442899540; 
 Thu, 08 Oct 2026 00:01:39 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe0c1sm20245455ad.21.2026.10.08.00.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:01:39 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/2] fit: use FIT_IV_PROP and FIT_IV_HINT for the iv
 properties
Date: Thu,  8 Oct 2026 06:59:48 +0000
Message-ID: <20261008070116.328864-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008070116.328864-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

Commit d0215d8718da ("tools: mkimage: use an explicit iv from the
cipher node when encrypting") added FIT_IV_HINT and FIT_IV_PROP but did
not convert the other places that spell the iv-name-hint and iv
property names out: fit_image_setup_decrypt() on the boot side and
image_aes_add_cipher_data() in mkimage, which stores the IV. Use the
constants there as well.

This includes the iv property of the key node that mkimage adds to the
U-Boot device tree and U-Boot reads back. That node is not part of the
FIT, but lib/rsa/rsa-sign.c already uses FIT_KEY_HINT, FIT_ALGO_PROP and
FIT_KEY_REQUIRED for the properties of the key node it writes.

No functional change intended.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/image-cipher.c   | 6 +++---
 lib/aes/aes-encrypt.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..535c671317d 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -94,8 +94,8 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 		return -1;
 	}
 
-	info->iv = fdt_getprop(fit, cipher_noffset, "iv", NULL);
-	info->ivname = fdt_getprop(fit, cipher_noffset, "iv-name-hint", NULL);
+	info->iv = fdt_getprop(fit, cipher_noffset, FIT_IV_PROP, NULL);
+	info->ivname = fdt_getprop(fit, cipher_noffset, FIT_IV_HINT, NULL);
 
 	if (!info->iv && !info->ivname) {
 		printf("Can't get IV or IV name\n");
@@ -144,7 +144,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 
 	/* read iv */
 	if (!info->iv) {
-		info->iv = fdt_getprop(fdt, noffset, "iv", NULL);
+		info->iv = fdt_getprop(fdt, noffset, FIT_IV_PROP, NULL);
 		if (!info->iv) {
 			printf("Can't get IV in cipher node '%s'\n", node_path);
 			return -1;
diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index 90e1407b4f0..def33a3b324 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -86,7 +86,7 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 
 	if (!keydest && !info->ivname) {
 		/* At least, store the IV in the FIT image */
-		ret = fdt_setprop(fit, node_noffset, "iv",
+		ret = fdt_setprop(fit, node_noffset, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 		goto done;
 	}
@@ -137,11 +137,11 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 
 	if (info->ivname)
 		/* Store the IV in the u-boot device tree */
-		ret = fdt_setprop(keydest, node, "iv",
+		ret = fdt_setprop(keydest, node, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 	else
 		/* Store the IV in the FIT image */
-		ret = fdt_setprop(fit, node_noffset, "iv",
+		ret = fdt_setprop(fit, node_noffset, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 
 	if (!ret)
-- 
2.43.0

