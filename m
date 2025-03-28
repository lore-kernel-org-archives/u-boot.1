Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC607C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB428211F;
	Fri, 28 Mar 2025 14:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lsZXACql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4B0820E3; Fri, 28 Mar 2025 14:08:18 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E421B81273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85e14ce87ceso66207639f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167294; x=1743772094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEfxzjAtUZBx2SiiH4dHkmY037Ik3JClsz+buFoZL7I=;
 b=lsZXACqlu343dUfV5x5NlxISDxZHzwgZfsaiSGGrnsSwW90eWcSLtkaL31BsLoEoyE
 cgSRoJ6MbA8s8F+wQjpXfPhMylx9qhJpe5UhhUSaCpjpdVGhMsBIheMK46styB/v0D3w
 bnJ7CVVWLSTkDy3FR3CecvHT+czuYpknicPFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167294; x=1743772094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEfxzjAtUZBx2SiiH4dHkmY037Ik3JClsz+buFoZL7I=;
 b=MuKxJHYlM9RMITrcqgWyO/enjooz/ubc/j5xD+z792Lg9SXtoDuLaJiX4Sv0RMjWOB
 hLZmL8ri+lKX/AjhB4aKQgliLxaz7euMgqI/4Ofh5WjEuR5a5IxCqWTA+0Ia1TNz4MKo
 cS8+2YU1UOtoe0n3mtb3iytv5V3D5PaPkwt+qakeypozUxkbBoky7Yl9lQ0X2qdZcWHs
 n4gSc0Zns66d4HQYieOmMKLUF7AQfrARS+OjKYzi2ruZtCy9Mha1SMnMI9uOLpCH7v+r
 E2Vr8bYqxyPit9itLvUfOPR6+kEnYKdsosIK89M1HrZFSyQnUB4PXMLVHWRAtjKKXe/x
 7TSA==
X-Gm-Message-State: AOJu0YziseIhu3d3O30I8ISnN3Qk2htAZ7DSFLHZkbkSSTmMZ0Poj2oD
 gPrdNFUgyvTevDjlB154yRywhG79H5lQTDUVwW9xbVeeR1ssBVad5JJidJpCLdnEL32L9H7Tl/c
 =
X-Gm-Gg: ASbGncsLI65mjJAYyLaFDGCHVtZlYs9KSd4pjXWJGFw4aW8s/R2zikNfBMYe08PUA44
 gLoxkV8HJiipiAPd02OM+YmAl/Dr06mK8lgtKLJPoRcd38vwpaZLYYVI5TYgiZvKafgO4Dn364Y
 agMBK2eTiz9S4sh2ZvwttVUPds+Ghrkmtq9YIjIe3slQ4KrXb+omzlNKec/HhPAbdTlUzSyA9hp
 ucV75/4SUKN5Hp6+/ozeXJx14g0s9Pb08n+jilLDBPkgf1kYsYgbc5f1JlVdB0+fENlanIMIYu2
 NVhY5GWl1Ti2nzLbQDh1Oh9+rmV3zuC1RevOdSPD2FeSA1mrHjqHz+6rPMvQAQhzF1U74x/aqH7
 qFPSCGw==
X-Google-Smtp-Source: AGHT+IGtPMbfjGK+CUhkIyG3rnRkSIYjS8hGhQv++cAMtbGk/JLOdboeZZUGEmAbXmL6EVENrBonZQ==
X-Received: by 2002:a05:6602:4f4f:b0:85b:468a:2d0d with SMTP id
 ca18e2360f4ac-85e91d3cc56mr230318139f.2.1743167294033; 
 Fri, 28 Mar 2025 06:08:14 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 30/56] expo: Use an abuf to hold strings
Date: Fri, 28 Mar 2025 07:06:17 -0600
Message-ID: <20250328130713.2612648-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

It is more convenient to put strings in an abuf so they can easily be
resized. Adjust the struct accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c    | 4 ++--
 include/expo.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index ba052df932c..ee635116abc 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -86,7 +86,7 @@ int expo_str(struct expo *exp, const char *name, uint id, const char *str)
 		return log_msg_ret("obj", -ENOMEM);
 
 	estr->id = resolve_id(exp, id);
-	estr->str = str;
+	abuf_init_const(&estr->buf, str, strlen(str) + 1);
 	list_add_tail(&estr->sibling, &exp->str_head);
 
 	return estr->id;
@@ -98,7 +98,7 @@ const char *expo_get_str(struct expo *exp, uint id)
 
 	list_for_each_entry(estr, &exp->str_head, sibling) {
 		if (estr->id == id)
-			return estr->str;
+			return estr->buf.data;
 	}
 
 	return NULL;
diff --git a/include/expo.h b/include/expo.h
index 84dc77f771e..b6de0310071 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -134,12 +134,12 @@ struct expo {
  * struct expo_string - a string that can be used in an expo
  *
  * @id: ID number of the string
- * @str: String
+ * @buf: String (contains nul terminator)
  * @sibling: Node to link this object to its siblings
  */
 struct expo_string {
 	uint id;
-	const char *str;
+	struct abuf buf;
 	struct list_head sibling;
 };
 
-- 
2.43.0

