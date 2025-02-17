Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FF1C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A2180FA4;
	Tue, 18 Feb 2025 06:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JGuHYHlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D57E80BAD; Mon, 17 Feb 2025 19:31:52 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273A8807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-471cdc14e99so34054231cf.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817109; x=1740421909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xo+etGgUiabyluSI/s62aGsyyHoH4bpevw6ZfEdG8/Y=;
 b=JGuHYHlpCygS5E5Wa1HfmaFzrIeEuZ6K2N7to/z16m7nxJXqaTUhH/mWVmPKv6jKV2
 T8wcEfAQvKN4f9QplNUAEl3EKBZx4pFwVahM3uO5nuLS+gece7i0eBU0OaqdYohB//AB
 uWeCNFfn4UZfHhxjez8pKvYWO+d6TZzX2JWc/P0eWPcUY4oOI6ps6027hY6PhEr89wKR
 daDuqR+ZCrLOZzfU05w+dgeSjb9Bmj5QNmadSOnrwqb1qOiEl3b1sFjJO+74gE0FENoK
 5glpy8YllZc8ZxVS7p5xq5GXvR8+hLUcM3R5l/ClDHQOQmWpwU9gn10dGstEefHV0Fgy
 BISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817109; x=1740421909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xo+etGgUiabyluSI/s62aGsyyHoH4bpevw6ZfEdG8/Y=;
 b=cpAcLVgjeV4ji/OK0pw9ALuSMjhXD1EiqJlvRv/nf6XHAhZfyli6b+woZAG8CDzWQ5
 XKHZAntMirPbCINCs9h4SLrjqhc/cO4hAjR21QTns40taGcoiogNMC8uGzrRDuZkAd2V
 0T9MtHmeihsfAJhVRwHE51JnPFFt/SHrrqbsaRA8FglhA2lSP/rZwspp2y58lHiokc9/
 cf97NzIIxD8CkiCqIbyANEm4wVYeV1OPpcIS7H2ECC/v9ISXA86r1FiflyY0C5+23rPF
 AjxtgcT4a2E+v0DoJVg8rvagYO/QJAmr92fMyWQ/cGyPZBwtU29Xox7bGmVUi3G1U0BO
 2g+w==
X-Gm-Message-State: AOJu0YwxUjLgasKUsUkegZmQRuULcRByZ2w82IVCAGRtHMm6x5QaNKeI
 TImYKEMMMsbF/vAAJl1n1fI//LRSFNsEUnY0c+ePC19Jy4lvmjhz2FC2nw==
X-Gm-Gg: ASbGncsMtHMBM1Xp2RYFJ1rpvtVZk0XTUav0kTzhmdFVz15eUpwgmorkFApnV5EQpdC
 Kc+8uCRkq3Oo8xxPMJEO8MxJwwFbITvwhLnfCsUWuT0PW3ZGYQhy66ytCBN7E2U3KjDCQcpiJCE
 3b/kpPecqljRfWdcSjYb+W+Ms0m4erqCd5P1lv3zmH+eVJQ4q03vqs0AVCnSa5Lvhc/cTC3vz2z
 8m/NhdPozG2CfOIaqtgJ3fGHPLoYFmkHv9lIu2xtQxiMDO68+rEnBcx1PFIRPVJCWeLtWTeYC/J
 RQq1h15DF9gB/jpLkeYYUpVCvxDDBUSMDpm59g==
X-Google-Smtp-Source: AGHT+IHyN0qHmH49ysGyGC6MdxMvS1+bh7DS8Xk2/Gik5H9Eu/elKuzbF5VeXlRscH+1GcGCgjWTcw==
X-Received: by 2002:ac8:5808:0:b0:471:825d:aa52 with SMTP id
 d75a77b69052e-471dc2b23c3mr130210591cf.20.1739817108693; 
 Mon, 17 Feb 2025 10:31:48 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:48 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/6] efi_loader: move path out of file_handle
Date: Mon, 17 Feb 2025 13:26:46 -0500
Message-Id: <20250217182648.31294-6-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:28 +0100
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

In order to support renaming via SetInfo(), path must allow for longer
values than what was originally present when file_handle was allocated.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
---

(no changes since v1)

 lib/efi_loader/efi_file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 201fa5f8f3c..6b15c1f3d27 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -40,7 +40,7 @@ struct file_handle {
 	struct fs_dir_stream *dirs;
 	struct fs_dirent *dent;
 
-	char path[0];
+	char *path;
 };
 #define to_fh(x) container_of(x, struct file_handle, base)
 
@@ -178,6 +178,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 		u64 attributes)
 {
 	struct file_handle *fh;
+	char *path;
 	char f0[MAX_UTF8_PER_UTF16] = {0};
 	int plen = 0;
 	int flen = 0;
@@ -194,11 +195,13 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 		plen = strlen(parent->path) + 1;
 	}
 
+	fh = calloc(1, sizeof(*fh));
 	/* +2 is for null and '/' */
-	fh = calloc(1, sizeof(*fh) + plen + (flen * MAX_UTF8_PER_UTF16) + 2);
-	if (!fh)
-		return NULL;
+	path = calloc(1, plen + (flen * MAX_UTF8_PER_UTF16) + 2);
+	if (!fh || !path)
+		goto error;
 
+	fh->path = path;
 	fh->open_mode = open_mode;
 	fh->base = efi_file_handle_protocol;
 	fh->fs = fs;
@@ -245,6 +248,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	return &fh->base;
 
 error:
+	free(fh->path);
 	free(fh);
 	return NULL;
 }
@@ -368,6 +372,7 @@ out:
 static efi_status_t file_close(struct file_handle *fh)
 {
 	fs_closedir(fh->dirs);
+	free(fh->path);
 	free(fh);
 	return EFI_SUCCESS;
 }
-- 
2.34.1

