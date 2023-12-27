Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D5FC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CF487872;
	Wed, 27 Dec 2023 08:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0wzukqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6965876D7; Wed, 27 Dec 2023 08:40:48 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BCD876D7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so66748405e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662846; x=1704267646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3bxu7VxhipZnEHjH2fk93Miso0D04ID4sOKOLBpxas=;
 b=Q0wzukqv0rxBVfFDfqJroRJWoLj/fUk3GoIeDjbPSF2U1NqvpNXr6FLJxbhhcb1BXJ
 75jS587AzeVHCg8ViJ2ZU86gkDtHPW80UhXQ0utNTymbKSgown4Clv2nYpVdotBlre8S
 PNiYxP8MxP9faYKPDSx594vB4I6fe9KtlddJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662846; x=1704267646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3bxu7VxhipZnEHjH2fk93Miso0D04ID4sOKOLBpxas=;
 b=G0OTgGJIOnoC51c8XNh/eIGtL7o0okaQCZQdic9p4nXpIhT6+0qqMeURJ8DcoZ9opm
 JmQDa/hFferpsTlnpt9VLhfg+BOB1iMm5lUt0uoH8oWTupw6ZaR0j5CxGw1ElpgWM1va
 0zG6Aqi4hwQRt4NP+D32/z+fj7u8IWd2I9dKDu+rAumnV/tcnk2F0q6EYmcVjiKem5gI
 7ITSCeqdT+FVHI4egb6ZKA7d3rOlDJNufqpX6WJx8OCkBs5ItwRWlsIxzLe7ps7JR3Iw
 BrNZ9v9QawM2g8/QEoCETutsmEtVrQqNHV+r08Pl2XcK8zUZxtuL66ecm1DhhIh+Kr3Z
 fE2A==
X-Gm-Message-State: AOJu0Yz8DCk2NJVhi9+9pI2iU9ASrZ+Mm7MQujdf76QpFHrv92dD9lVM
 0DFjqBDrtER5f7lomIygnz4ahXUSG5+shQtLxwv5v06tsuyo
X-Google-Smtp-Source: AGHT+IEQ6Oet9st15QRi15TT5XIo6a/PqJdpr9EwOjpgLSQ3K3fbLi3wjBmIwM99B6d1BQjkn+troQ==
X-Received: by 2002:a05:600c:3509:b0:40d:5a73:3682 with SMTP id
 h9-20020a05600c350900b0040d5a733682mr893684wmq.89.1703662846019; 
 Tue, 26 Dec 2023 23:40:46 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 1/7] smbios: Refactor 32-bit code into an else statement
Date: Wed, 27 Dec 2023 07:40:18 +0000
Message-Id: <20231227074025.2178825-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 lib/smbios.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 45480b01af4..b417f8a9057 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -589,14 +589,6 @@ ulong write_smbios_table(ulong addr)
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
@@ -612,16 +604,28 @@ ulong write_smbios_table(ulong addr)
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
2.34.1

