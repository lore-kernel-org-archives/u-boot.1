Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75695CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 10:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D854A83775;
	Fri,  3 Oct 2025 12:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RFbCHdui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7116583710; Fri,  3 Oct 2025 12:42:57 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763C08366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso1175418f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759488175; x=1760092975; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hTYY1luoSapKASH2skwH8bBX8OaBTrAFu1ZYq9ObqzI=;
 b=RFbCHduiiWpglJMQv4zNHjmnXlM1tuvzqKDU7aJdt11Cl1ZFV3un0aGPJyy1NA5YE5
 qEzbhrTTBo3LCo3d5LKoguTRwD+XwiKP1J9y5TgMdeddFcxuMSeFcxINz70pp+hLfSoD
 0CHtG9xO+qVPf1hjKwj+vGyDidzf6nksOo5LslZwBcUTQ2G0lQ0ekEe0PHser3vNf0bN
 WTcV+e7MdSpuvs1kw5fMMvvdVPblrg08FdrWDeuSBxJR0WzoPTJUvfLNPud8cZPLleFf
 sreV1iyxQgQDC/3vyXIkW2uibTg/BTec9cIsAFaWduzK3Gt1Uw44+CvwvcUTEpCu7VxI
 ayOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759488175; x=1760092975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTYY1luoSapKASH2skwH8bBX8OaBTrAFu1ZYq9ObqzI=;
 b=LTItsvFgdV+EwWlbheHDST09lOSdAh87A45y7pCq+H618EqiHHCkk0MJWr2c47Ra/a
 KXYpt/7SjWnDYDNQkjUpMKDZ3sGb0bLCsZoZzE72rKA6bwvdjauBVneDHmF6RFJwvM7i
 1ecI252BSWhAkwWks1gPXkQAcjxrENIFu9yhj3aP+VJYM/yv21jUcZldrFq0yqbjaOyy
 kP4XvUrVZD87aMxM636Ulu8qPS50gcIvLZUrxwMVgR9ZKjs4RJt0iS0bGQz7B3EI0n8V
 8/SIA7b9zi4KgvtdJWioCcQDihmkmfnkwYarxI7znfENm17MahZQMwqdSLp2ewZDQU9C
 Xduw==
X-Gm-Message-State: AOJu0YyeqnNK6u2Eoa9Cvj3VCpA2luB4nkVvz/mvY3MF6bTEzbkapC9m
 2DUn+Pbrbi7ECu3nAA/TxKumoxzYxaDvpy1afzsSoYc3risa+4ADitJ73k4qWxCzeD8o3/6krYX
 VN9BJ
X-Gm-Gg: ASbGncuFJhY5whDUsZXbpELtf/g2whp/WmYLg1Lay1S9L9hjDizGvBmGEJSDSWCJwTc
 hE/uHIczU3RtJwG82qSy2w9iOLjqgwtVCECz/ccd6icUb517Z1ED+uDuvzGO4JAuWF9cNxZJYKI
 DwgyMtG+441xL/+p2GhVtMZrkkW269NBEd3A1AQTAK7rF/riOpCFO0KRjIOpt+EMZTqJGqIYYfE
 MEOqk8keIc64S0KjxSEq6VCPcBcp/91ZWfRUNbHrgyyN6nrxk8hlptGIMgo3z7rZLBxxaAPiGeN
 zb8X7CP2lAJ/F7K0WvoarGQTzFb11fsi3D/0RFw++SMp7Lc19tcDTsdHEO7h5u9BfTsa4NetBJ/
 TydOmGlQI+FCjfTQ4VRdqJU9odCiQFvC1TprHJjvXTpIqFsP+1fYlD2en8hFlPmrt9MYI/YoXBW
 JHTkAdQAvcywc/Lg==
X-Google-Smtp-Source: AGHT+IF+oYZEBJmX2eqwEZbQ3/6aTXJE10yidU76QilLR1/RpDiTtGuWifF/595r6xEUKOnR9+6k/w==
X-Received: by 2002:a5d:64e9:0:b0:3ec:c50c:7164 with SMTP id
 ffacd0b85a97d-4256714bb42mr1628855f8f.15.1759488174887; 
 Fri, 03 Oct 2025 03:42:54 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm7470005f8f.45.2025.10.03.03.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 03:42:54 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 03 Oct 2025 11:42:52 +0100
Subject: [PATCH 3/3] fs: ubifs: Fix and rework error handling in ubifs_finddir
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-fs_ubifs-v1-3-a48d4861670a@linaro.org>
References: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
In-Reply-To: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Add a null check for 'file' before dereferencing it and also rework the
error handling to be a bit more sane.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ubifs/ubifs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 398b076d783af46421bf9dcabb51886a2a3db586..40bad0e7da7afe76a37cbec7d4fc64ad944f198e 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -420,7 +420,6 @@ out:
 static int ubifs_finddir(struct super_block *sb, char *dirname,
 			 unsigned long root_inum, unsigned long *inum)
 {
-	int err;
 	struct qstr nm;
 	union ubifs_key key;
 	struct ubifs_dent_node *dent;
@@ -435,8 +434,8 @@ static int ubifs_finddir(struct super_block *sb, char *dirname,
 	dir = kzalloc(sizeof(struct inode), 0);
 	if (!file || !dentry || !dir) {
 		printf("%s: Error, no memory for malloc!\n", __func__);
-		err = -ENOMEM;
-		goto out;
+		ret = -ENOMEM;
+		goto out_free;
 	}
 
 	dir->i_sb = sb;
@@ -453,7 +452,7 @@ static int ubifs_finddir(struct super_block *sb, char *dirname,
 	nm.name = NULL;
 	dent = ubifs_tnc_next_ent(c, &key, &nm);
 	if (IS_ERR(dent)) {
-		err = PTR_ERR(dent);
+		ret = PTR_ERR(dent);
 		goto out;
 	}
 
@@ -481,7 +480,7 @@ static int ubifs_finddir(struct super_block *sb, char *dirname,
 		nm.name = (char *)dent->name;
 		dent = ubifs_tnc_next_ent(c, &key, &nm);
 		if (IS_ERR(dent)) {
-			err = PTR_ERR(dent);
+			ret = PTR_ERR(dent);
 			goto out;
 		}
 
@@ -492,11 +491,12 @@ static int ubifs_finddir(struct super_block *sb, char *dirname,
 	}
 
 out:
-	if (err != -ENOENT)
-		dbg_gen("cannot find next direntry, error %d", err);
+	if (ret < 0 && ret != -ENOENT)
+		dbg_gen("cannot find next direntry, error %d", ret);
 
 out_free:
-	kfree(file->private_data);
+	if (file)
+		kfree(file->private_data);
 	free(file);
 	free(dentry);
 	free(dir);

-- 
2.47.3

