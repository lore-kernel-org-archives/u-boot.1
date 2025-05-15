Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF0CC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFDC82BCD;
	Thu, 15 May 2025 15:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBBOwwM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9058E82C03; Thu, 15 May 2025 15:56:51 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841FB82958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54b166fa41bso1233149e87.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747317408; x=1747922208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VhhfyrhJqG9fyOgq8qma8HWO0Ss+WitBjhpJfxmrK+c=;
 b=aBBOwwM9FyDGHulpp2mPk749NeI37YUps/KCPYmMa1tqjXafss5z+YNPT4PYMtF7qz
 aIJSLBaN9jjqmf2XOH76NO+et5bFx9u5WaeLnPlUzhTv2wX62KVhBux0oW9NNJE4j66b
 tyvnSlV2L5Le9p1xCL2Ua6r8qFIRqaI32pcwfyZLNydPxq77yrwt87+Ir67ow8hkVdz4
 kpZXCqO8pjXnP9OnCtWi+0lIuKcU6PnonP1/AH6sgpRL1kKmziPpEiehWK5rISvQlZci
 r+8mCngymi82uDGuzS1jZq6FAyTmvutQ1+WSaq9j+hYGaMk51GAwalTFZ7XQYT564sn/
 YtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747317408; x=1747922208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VhhfyrhJqG9fyOgq8qma8HWO0Ss+WitBjhpJfxmrK+c=;
 b=HKoH4QNkf44GO6g95mdIX7RaWVfp0Vat3Dy2nC19uc3SXrD43rBYut+KFC3UZo13Th
 xH0NYo79obBMEFFKYnYu6DaxNUbe0htsrKaO5yrqwUeZVfbKF7qN/9ztaD08vfVX5U6f
 4NW4OlXQHhgo069tjQ1vhDwy4UOzdm9hK4QaFLHbUG3JWk+Kjw3cqEWypxDlU6qMF/Os
 kbLu5Nomi4XFbn4QjUkBee5cUlAyj9XEV6RnHVUvqIU+2/32os0N+RtvdHkgWQoYhONZ
 GJJPycwGeFZffacNuH1NioCiLL8Cv8lhwJ9UE3Biu/DbdpoIzmTOeK8ywcb3DZEv0hpg
 taxg==
X-Gm-Message-State: AOJu0YxlPFTkp2U50sJ9q/1iV6hunzeFtUig8NT6tx3ahXruu/FoJCNt
 YBMctD+CSuyT5DjI3olXc6pfAKW7LWyBtazBM/fVv5FCwYmNzDj/tAQr2Rrv
X-Gm-Gg: ASbGncu3oL0L3TFQjotB0OaqpaGNvKhAXvG+ze2mhP5xK1kjIfNqgH73C+J8h2wy76C
 rC1a7h+EexF0OBhrTA8bpAuWSUHIW+d9mja7OFEP5L/7Hb9ksHF7J0q9AezNs0EqLw0VYYUCFWE
 n2eSxONJew/+YZonCSyfAK2+e9AxFvWkAy1+d/21QQGk8nlXB3i1itMMACsORmC3W7/CAsgWts2
 QfUDELWyL3qwa/wOSGqFA4TKQ5Ul2LbGdqGh3hS2Qq8R4z/10y8yUktDRG9ZKPtMFsN1/OBaHBw
 aHxtKTSB2VhWgqVPb8B9iI+VXz14KsGQdegI4BvwKHNRxmYKJrvzYE6gP+6fUl8Xsq5i6j6wdm0
 mwFWJoona4h8Pd9VctQ==
X-Google-Smtp-Source: AGHT+IGvd56qWzOmgNYV3en3r1/ihTcD4S3aRHAkhqAAprqixlWrdgpfEb+MLaB3u7SjPdd6QeJvRA==
X-Received: by 2002:a05:6512:224d:b0:549:6cac:6717 with SMTP id
 2adb3069b0e04-550d61d62b8mr2880023e87.53.1747317408208; 
 Thu, 15 May 2025 06:56:48 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-326cfbc01efsm20685031fa.80.2025.05.15.06.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:56:47 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ifwitool: fix memory leak in ifwi_dir_extract
Date: Thu, 15 May 2025 16:56:39 +0300
Message-Id: <20250515135639.1147416-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Static analyzer triggering:
Dynamic memory, referenced by 'subpart_dir_buff.name', is allocated at ifwitool.c:1132 
by calling function 'parse_subpart_dir' at ifwitool.c:1878 and lost at ifwitool.c:1904.

Correct explained:
Added a missing call to buffer_delete() in the function ifwi_dir_extract()
to properly release dynamically allocated memory associated with
subpart_dir_buff.

Previously, in case the requested entry was not found (i == num_entries)
or when buffer_write_file() failed, the function would exit or return
without freeing this memory, leading to a potential memory leak.

This change ensures that all exit paths free the associated buffer
correctly, even before calling exit(-1).

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/ifwitool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/ifwitool.c b/tools/ifwitool.c
index c1defe57737..762161d769e 100644
--- a/tools/ifwitool.c
+++ b/tools/ifwitool.c
@@ -1890,6 +1890,7 @@ static enum ifwi_ret ifwi_dir_extract(int type)
 	if (i == s->h.num_entries) {
 		ERROR("Entry %s not found in subpartition for %s.\n",
 		      param.dentry_name, param.subpart_name);
+		buffer_delete(&subpart_dir_buff);
 		exit(-1);
 	}
 
@@ -1900,12 +1901,15 @@ static enum ifwi_ret ifwi_dir_extract(int type)
 	buffer_splice(&dst, &ifwi_image.subpart_buf[type], s->e[i].offset,
 		      s->e[i].length);
 
-	if (buffer_write_file(&dst, param.file_name))
+	if (buffer_write_file(&dst, param.file_name)) {
+		buffer_delete(&subpart_dir_buff);
 		return COMMAND_ERR;
+	}
 
 	printf("Sub-Partition %s(%d), entry(%s) stored in %s.\n",
 	       param.subpart_name, type, param.dentry_name, param.file_name);
 
+	buffer_delete(&subpart_dir_buff);
 	return NO_ACTION_REQUIRED;
 }
 
-- 
2.30.2

