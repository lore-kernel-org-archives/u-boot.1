Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28431C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB4283082;
	Tue, 15 Jul 2025 08:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOtUEAt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7099D82F6F; Tue, 15 Jul 2025 04:53:23 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A19D8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso3242056b3a.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752547999; x=1753152799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4i5a+FhA5t6rGQBjqd2c3vX9DjjrCmChQEIUFCO8nFo=;
 b=mOtUEAt3odOEEfG1V+1ZTyHusQVoh7YANpKXnoIJUGpcikErg/xjcuH2eL1Xi618AU
 VVeWzzW02rYEcsL0dzOEVjlB3hju0Gb4IX12OmfI4w/0Z2x2OwtU2NarG1hPmeKsoSCo
 NO2uUb2Ux7FMiI1+fNLbEqTbusGuImi4FnfMEGPsgutixICqyzY4dcfafUB/ywLWxwdJ
 TG1vjVWYUzYXtxm0hzzO+Tf2WPasAWV01RS3OXXfqq7dE+ZW8FmfKJlKo0NPzzdxoUFs
 LE45GdKtizCeVtRxoGOF1oyzZ9gwf3BtPdwd+SKhs2yMi/IaPiCaBjwes7DIzLc54MiW
 d1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752547999; x=1753152799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4i5a+FhA5t6rGQBjqd2c3vX9DjjrCmChQEIUFCO8nFo=;
 b=QLAZjj/Mw4Pi1A5YWeu0czR7tXypeZXgg/BaGNWDyqoqFKlYuP/m+5lv97udB54/MO
 uCfXAfmBnbeTU82zNiWhbTZO4BRQgrTyRDsyGlGdCy0TQgwxe3TiM5YAlMYj5PpbnENQ
 wNu1ABk+kd8m8DODORCgspVa+N26R0EX6z5LQq9eIg2LbE4WdfB/82CeiexTQsbVreOl
 vp+VtYp56rTgEXNdVi8tPDFXyhR0v2vDBukgN14Avbl5RXIPxwHSnHFR0N00pkFA4o7m
 O6c1rPKDeNaxN8LMzPib2Jsmwq66GQQ/0N0Nb2mb0eY38e14Pp0HkK+WkeqpbGEFLXM1
 UZBA==
X-Gm-Message-State: AOJu0YyFoYKh2XSuoKYJwpL0Wnbvh2LrJR+pRHc0YAzILUyNpsgnQXLd
 P+jn2x5/uWN44OTMbiojSya9LwDI5MYY5t0OGHu7deicONNmkXxwyBq8cgaF4A==
X-Gm-Gg: ASbGncv3ZuThPI4cxv0BJ5hTbyseK68+3NoL60CwM+fO3QgotU4DByCnnTIS/X+k0K1
 mc967uIWw9K/6v+fs9ePMvT6fYyX8D3YnAbI2hsWQdav79lhqMsbMSbiuKSMZwR9dEwQKXsPCXP
 242s+Jxj9Q2i4jNP5khE2k1PePGe4n4l8evJi0QFGpe9WRR8uf7pZqL6IF8VNJFwvNMhe26QhEG
 vanUvjOPY9i8HOnwP/PiwO6WWQuBUw1upePU/otkRaneacmgNCJ0piSMa9+30PIvmkYydo8dFiL
 JZRhILVnQqjHxuKvNXUC/jD24FQjyjszruIit+DKKJ8XXWjsHS6Yj/u+koFxgDhVBBuTHTEucza
 BOsmGBDyiObVyXAkRRZeWDcwJl3aR3tRXYgKOgAfzL8BQh7D9E480TJ+RU5IyTaETc7l3ezZHkg
 ==
X-Google-Smtp-Source: AGHT+IFgGagU9OBWGgw5v2OB7zOBhcCj31TqIWByWAO0HdByaYTvzsh5fNqwKcdXmq1VuDD8RaHYRg==
X-Received: by 2002:a05:6a00:10c7:b0:748:2e7b:3308 with SMTP id
 d2e1a72fcca58-755b28e7327mr1735547b3a.6.1752547999386; 
 Mon, 14 Jul 2025 19:53:19 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4ca28sm11777889b3a.134.2025.07.14.19.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 19:53:19 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ravi@prevas.dk, sjg@chromium.org,
 jan.kiszka@siemens.com, baocheng.su@siemens.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/3] tools: fit_image: validate existence of default
 configuration node
Date: Tue, 15 Jul 2025 02:52:52 +0000
Message-ID: <20250715025307.2013-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715025307.2013-1-aristo.chen@canonical.com>
References: <20250715025307.2013-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

When a FIT image declares a default configuration via the
'configurations/default' property, it must reference a valid subnode
under the /configurations node. If the named default does not exist,
U-Boot will fail to boot the image when no explicit configuration is
provided.

This patch adds a validation step in mkimage to check that the
referenced default configuration node is present. If not, mkimage will
print an error and abort.

This helps catch malformed or outdated ITS files early at build time
instead of deferring failure to runtime.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 8717dc9a3b1..8a1f6c185dd 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -756,6 +756,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	}
 
 	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);
+	const char *default_conf =
+		(char *)fdt_getprop(fdt, confs, FIT_DEFAULT_PROP, NULL);
 	static const char * const props[] = { FIT_KERNEL_PROP,
 					      FIT_RAMDISK_PROP,
 					      FIT_FDT_PROP,
@@ -764,6 +766,14 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 					      FIT_FIRMWARE_PROP,
 					      FIT_SCRIPT_PROP};
 
+	if (default_conf && fdt_subnode_offset(fdt, confs, default_conf) < 0) {
+		fprintf(stderr,
+			"Error: Default configuration '%s' not found under /configurations\n",
+			default_conf);
+		ret = FDT_ERR_NOTFOUND;
+		goto err_munmap;
+	}
+
 	fdt_for_each_subnode(node, fdt, confs) {
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
 
-- 
2.43.0

