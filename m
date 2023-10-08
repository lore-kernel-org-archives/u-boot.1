Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A4E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B73186D61;
	Sun,  8 Oct 2023 23:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L5xL8cLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C683F86D3C; Sun,  8 Oct 2023 23:36:54 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78DC86CDB
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso155557039f.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801011; x=1697405811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QI83SYUKYoewvGrzl5EFufiorhsHxK5NJ/jH3EZLwXo=;
 b=L5xL8cLozn9cyW4Iqt5tX0Tp7QAt2nj7+Inppt/xR4o51GCgTBLo029SfDpBMjNIzC
 pE+yQr40Yy+08g2p6PwCJGLIBq0OhF2j5APLyI/wSTuEYYdZGE88b0A1PlCpbkIcS4bi
 ddpZb41G3jqViUfUJs4OsoeCKaO2zZyJl1VoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801011; x=1697405811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QI83SYUKYoewvGrzl5EFufiorhsHxK5NJ/jH3EZLwXo=;
 b=tdMYV/aeuWuPdJ/x6p7lJVaEq0iZDskFzh0Nx2GPkVNyNXD3aU3r5Uv/Pvo2iXntwG
 dLPCRFb4KVBro3fVXtJ8Z72/q4djlHnHTOhgCApeexq6b4FF1glEt3SmIXMir0Yj2TnI
 8YgRm3vksIM3K20D0BWrVRf/GUzRjVQj7fbSPwvUnQP0coN9mKHkYd+sIaSiWsHjT9VZ
 PImpybCFrIxzJMYx7HGsitZpEDKBg2JFvfNEDmahWLdGmcKSJvhItn6kHD/u03+H/IhB
 mZqUK+CQBpPDeZgs48Q945ewAsV11rDhkRBZ5NWLYK6F5VjZIz56wd832huyCh5Udf5p
 /NeQ==
X-Gm-Message-State: AOJu0YwF2QxTKrHOc9GEdBOcdtVjwwPay3nDbKOW27tslEl9u87VJeCf
 HfdOvudv/TzDEQur8oxpca42+ah1cizKx9+MGUo=
X-Google-Smtp-Source: AGHT+IGaGWxETDCwRgpR+1ArtJ0N6XyJU7K8s+CT9qoSQB+2MLHzg5dIxeV3fvejx+UB6znD5GDYMQ==
X-Received: by 2002:a6b:919:0:b0:792:8230:c175 with SMTP id
 t25-20020a6b0919000000b007928230c175mr14416130ioi.6.1696801011296; 
 Sun, 08 Oct 2023 14:36:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/5] smbios: Refactor 32-bit code into an else statement
Date: Sun,  8 Oct 2023 15:36:40 -0600
Message-ID: <20231008213646.622002-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
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

In preparation for adding support for SMBIOS3 move this code into an
else statement. There is no functional change.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/smbios.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..96f67cd6ad7b 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -509,14 +509,6 @@ ulong write_smbios_table(ulong addr)
 		len += tmp;
 	}
 
-	memcpy(se->anchor, "_SM_", 4);
-	se->length = sizeof(struct smbios_entry);
-	se->major_ver = SMBIOS_MAJOR_VER;
-	se->minor_ver = SMBIOS_MINOR_VER;
-	se->max_struct_size = max_struct_size;
-	memcpy(se->intermediate_anchor, "_DMI_", 5);
-	se->struct_table_length = len;
-
 	/*
 	 * We must use a pointer here so things work correctly on sandbox. The
 	 * user of this table is not aware of the mapping of addresses to
@@ -532,16 +524,28 @@ ulong write_smbios_table(ulong addr)
 		       (unsigned long long)table_addr);
 		addr = 0;
 		goto out;
+	} else {
+		memcpy(se->anchor, "_SM_", 4);
+		se->length = sizeof(struct smbios_entry);
+		se->major_ver = SMBIOS_MAJOR_VER;
+		se->minor_ver = SMBIOS_MINOR_VER;
+		se->max_struct_size = max_struct_size;
+		memcpy(se->intermediate_anchor, "_DMI_", 5);
+		se->struct_table_length = len;
+
+		se->struct_table_address = table_addr;
+
+		se->struct_count = handle;
+
+		/* calculate checksums */
+		istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
+		isize = sizeof(struct smbios_entry) -
+			SMBIOS_INTERMEDIATE_OFFSET;
+		se->intermediate_checksum = table_compute_checksum(istart,
+								   isize);
+		se->checksum = table_compute_checksum(se,
+					      sizeof(struct smbios_entry));
 	}
-	se->struct_table_address = table_addr;
-
-	se->struct_count = handle;
-
-	/* calculate checksums */
-	istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
-	isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
-	se->intermediate_checksum = table_compute_checksum(istart, isize);
-	se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
 out:
 	unmap_sysmem(se);
 
-- 
2.42.0.609.gbb76f46606-goog

