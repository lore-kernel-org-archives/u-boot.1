Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842A5E810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC03586DE6;
	Wed, 27 Sep 2023 14:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="eajSbWNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FAE786DDC; Wed, 27 Sep 2023 14:00:30 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4466686DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so9873951f8f.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1695816027; x=1696420827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAdi2EWZzTDAIksYzTj+cyuG9bllcR8Yg8ANFM5c92o=;
 b=eajSbWNEjkRX3hFi5fnBN/VibEbmzGq/Cmo+nQMzvZ1iY3dgLhauk/x+Fphoc94MOv
 LdELSWztykT0tiukwKLxHXvMT2Vy80E3z4vBA4A77aUcY7AAqRXygRP0KYJg5i+39PYN
 6OjvDW0YfQ2Wd57AbjroT+ox7kcBNPECmPFQJULoG3W1+vJVm1eSeXZWrsBs1VMBAKIR
 +WBketQ68n6iXnEJy/EutEM5Uw8a4ySLf35mS/FKVmSMqvnjiqOQ9Pl/dei5qnUbi3Tn
 l3t1nt9ZVs3FWZVDJyUMW4Ga/a+4GpyDZ3MVArrs6V1gH0/JDAM0Ap4oW/DAKtr3vXPe
 +vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695816027; x=1696420827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAdi2EWZzTDAIksYzTj+cyuG9bllcR8Yg8ANFM5c92o=;
 b=hxEWGLLF21x5CCZWYma1z+JDYg2nYw8NugD91z/OkmstSz6/RA2CsvCg/24BazhC4/
 zK3x7WPiTSjMakwcVr9kvymnU/HqTElbcvEn7VBsfjpdB4S55ARaOQKsFSYBfj62dUgN
 3nk7QTj487TKcgaolVHiDlgI1g1VdM2hrYDWE9FafdNUqO2kRpelMqymZHjQZ4/by27n
 adJI9MzHmfu2nHbqml4LlrL7XdegRVBGdzbvXiww1UFUH1Pbyw+FGlkAh1oR64aWn+QZ
 CZl/Pzvg7iPM7ms3roVS0vfR4sr+1b57C05fJiANyN6AcsVn6snz8dCawvPBramWXFjz
 Xchw==
X-Gm-Message-State: AOJu0Yy8ODDIxlLwmjOpZxsxIMKc3o+qn5h564/l/t97h9rv2RRgW9XT
 /+fvpXSI/w+bdsXkP6z6C3ggvO92w0U2taBQS7Q=
X-Google-Smtp-Source: AGHT+IEB2ClM+MCbVBDaDkm+U37GfOPtmwIAn/DTLbiz7W/j/SlGmBWgTXXyJJdb2B8C2yQ7O5hz2g==
X-Received: by 2002:a05:6000:c4:b0:31f:fb63:12d8 with SMTP id
 q4-20020a05600000c400b0031ffb6312d8mr1445679wrx.44.1695816026918; 
 Wed, 27 Sep 2023 05:00:26 -0700 (PDT)
Received: from hugo-IdeaPad-3-15ALC6.home
 (ptr-4h549o68tsg3n9xv5up.18120a2.ip6.access.telenet.be.
 [2a02:1810:952e:3700:492a:f3bb:eb68:e461])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d4a8b000000b0031fc4c31d77sm17078557wrq.88.2023.09.27.05.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 05:00:26 -0700 (PDT)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: hugo.cornelis@essensium.com
Subject: [PATCH 1/2] image-host: add a check of the return value of snprintf.
Date: Wed, 27 Sep 2023 13:59:19 +0200
Message-Id: <20230927115920.2471498-2-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
References: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Sep 2023 14:24:03 +0200
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

---
 tools/image-host.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index a6b0a94420..0c92a2ddeb 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -363,6 +363,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	char *algo_name;
 	char filename[128];
 	int ret = -1;
+	int snprintf_return;
 
 	if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
 		printf("Can't get algo name for cipher in image '%s'\n",
@@ -399,8 +400,20 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	}
 
 	/* Read the key in the file */
-	snprintf(filename, sizeof(filename), "%s/%s%s",
+	snprintf_return = snprintf(filename, sizeof(filename), "%s/%s%s",
 		 info->keydir, info->keyname, ".bin");
+	if (snprintf_return >= sizeof(filename))
+	{
+		printf("Can't format the key filename when setting up the cipher: insufficient buffer space\n");
+		ret = -1;
+		goto out;
+	}
+	if (snprintf_return < 0)
+	{
+		printf("Can't format the key filename when setting up the cipher: snprintf error\n");
+		ret = -1;
+		goto out;
+	}
 	info->key = malloc(info->cipher->key_len);
 	if (!info->key) {
 		printf("Can't allocate memory for key\n");
@@ -423,6 +436,18 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		/* Read the IV in the file */
 		snprintf(filename, sizeof(filename), "%s/%s%s",
 			 info->keydir, info->ivname, ".bin");
+		if (snprintf_return >= sizeof(filename))
+		{
+			printf("Can't format the IV filename when setting up the cipher: insufficient buffer space\n");
+			ret = -1;
+			goto out;
+		}
+		if (snprintf_return < 0)
+		{
+			printf("Can't format the IV filename when setting up the cipher: snprintf error\n");
+			ret = -1;
+			goto out;
+		}
 		ret = fit_image_read_data(filename, (unsigned char *)info->iv,
 					  info->cipher->iv_len);
 	} else {
-- 
2.34.1

