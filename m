Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0104C021A4
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 09:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B33F800CF;
	Tue, 11 Feb 2025 10:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JgxevoZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D2A80104; Tue, 11 Feb 2025 10:49:48 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6C680079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 10:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7b80cc3d2so300155566b.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739267386; x=1739872186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K7uYq5BNYXhEpC5tfEIPZMoirAAz8N4n/otzlhZr1VI=;
 b=JgxevoZV59CyyWzndNASdenvbHYHYwxZHHTe69DtKs4YV/k7TCO+f5aPS0uGj1TCPv
 zA+N52BeDPicNBi9GB/qlVm4ITBVdJPUlDv1H6C9bYtoN72hQT0kwUcRG9I63dsTb2rZ
 u/v22Obg+poJk8tvnWKlRF3lhqRKhHEA/VtbTEJqtbdocEuwlgrzt6SulBfH1OJisNxq
 oXokrJBKXXueSLUOHOkNWK55s82G9y7s26UdY3eoJNUI0biXBStE7c7mATdutQ0Y88Nc
 zdfp7L9dQXHhmwH3Yrxdb7/o8Qd1eZfllcM7UTAPhiZyhLw09dZWa1WDXT7G1fgWAyJo
 LuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267386; x=1739872186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7uYq5BNYXhEpC5tfEIPZMoirAAz8N4n/otzlhZr1VI=;
 b=jwVrSR3OpyY0joIJEK5e3jBCMMtg18ADKSiLdAG8b7Gh8Epzs/o1cmB7d/SAlWY+VX
 T8K4LuZVHHwTQHYPzuIMgD4t0RJsYVUtFhusu+y3Ym3BaN/yap4yk6SQDCZ6JRDoWEx2
 qPVrEAwnWIPoz8Gh6elWxAxaN6rmg9HQUFgc22pV+ETdSvms0WTyZyDw2KJHwUXvak5I
 tptJhB8lrtl01f1JCaP6scUZSmmUUl9IqM+nT6dQOC8OYPmsCIv4yZoc5CVF1nkywnUX
 izGyX4mgH+MjZhJ5/AVgdvCeS9JXWM+1I28HPvKPHLsH6WHu+BYwmkia+Rrh0kI7CduJ
 Crqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0EaBNJkUeviUonBfvB+iWl20oxdmKY7rlSwPzoNuYVfecpu5UyUnsyNF3qm4ssdV4RiRKli8=@lists.denx.de
X-Gm-Message-State: AOJu0YzmtxlRmrETdBB5brs56/j7fMc6/E41N1G5CIBQYYcjlpeVstFc
 e+g+Y6WGlbfM8oRvP0gUCtLx4LdfOQjxQHEFpJvpw3K6CVyT/qLPn76OUx8iSvI=
X-Gm-Gg: ASbGncvyu55yikBekAotZiqergs1VgYcEB6Yga4qU8hNp9p+DhhwRJ7KRFrKm8ec7+B
 2mzV1Q+c3oQHM5pjHCQCFlj3iCN+k/Qr6S18dsukR191KrRoXUeIAEfBNHublisFyiZjQzuW45K
 H+DDt+F3mgfxO6w1H/FeHslJaO2dgOmg4a93CXacQq6zeIht+SVtItQqWc3hYc/iBv2ac3eBLtt
 pvvkw0nzbd4C28v59jwswM9jAhsk8CHZYxcKYGj5mm1NpxlZSp3wCrpCtE3QuCj8LcxAw6cOz56
 1/nDZV9mgYXYgMS74BVdrFhz9ml23nkOpWjCPoCS+ibPZmYVn2E=
X-Google-Smtp-Source: AGHT+IFa6FFxpIdLazJWsI/SjIY9vNjyCjz6CLatK+IlmkOCPfQfsSd58KXX6CWsJ2siS6TJlRqdcg==
X-Received: by 2002:a05:6402:3806:b0:5dc:80ba:dda1 with SMTP id
 4fb4d7f45d1cf-5de450026acmr40367268a12.9.1739267386082; 
 Tue, 11 Feb 2025 01:49:46 -0800 (PST)
Received: from hades.. (ppp176092155198.access.hol.gr. [176.92.155.198])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7832a02fcsm937140566b.94.2025.02.11.01.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 01:49:45 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: remove comparisons to string literals from runtime
Date: Tue, 11 Feb 2025 11:49:39 +0200
Message-ID: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

On EFI runtime services, we manage to preserve string literals
by placing the .efi_runtime section just before .data and preserving
it when fixing up the runtime memory by marking surrounding boottime
code as runtime. This is ok for now but will break if we update any
linker scripts and decouple .text and .runtime sections.

So let's define the strings we used to compare in the stack for
runtime services

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_mem.c      | 3 ++-
 lib/efi_loader/efi_variable_tee.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index b265d95dd6ba..985e0baa128d 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 {
 	efi_uintn_t old_size;
 	struct efi_var_entry *var;
+	u16 vtf[] = u"VarToFile";
 	u16 *pdata;
 
 	if (!variable_name || !vendor || !data_size)
@@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 	if (timep)
 		*timep = var->time;
 
-	if (!u16_strcmp(variable_name, u"VarToFile"))
+	if (!u16_strcmp(variable_name, vtf))
 		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
 
 	old_size = *data_size;
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 0d090d051dd4..8d173e58d2f7 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	efi_uintn_t payload_size;
 	efi_uintn_t name_size;
 	u8 *comm_buf = NULL;
+	u16 pk[] = u"PK";
 	bool ro;
 
 	if (!variable_name || variable_name[0] == 0 || !vendor) {
@@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	if (alt_ret != EFI_SUCCESS)
 		goto out;
 
-	if (!u16_strcmp(variable_name, u"PK"))
+	if (!u16_strcmp(variable_name, pk))
 		alt_ret = efi_init_secure_state();
 out:
 	free(comm_buf);
-- 
2.43.0

