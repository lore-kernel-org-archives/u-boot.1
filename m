Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6A1125854
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 17:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438FF83FB6;
	Wed, 11 Mar 2026 18:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aUQnfrKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B8084013; Wed, 11 Mar 2026 18:30:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25DF83BC8
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 18:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 552323F5A1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773250239;
 bh=R9bNTLgPA0zLEPR181AfzEuquRJUd2GIO2/EZ1U0cSE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aUQnfrKJQmPXznkXYfq105uVWkvNPSNWmLgW6yaWmrjllyzNh5WB+am5DcnyFgUVI
 Qs5Qy/+RWh1ddIqY1Wr5jbSsaMX94T2MUrwzgBhlNcfZXmfhtP2L6CXbOgAC5QLU3e
 h7zJb93dfHY9SEfB1c/iaVXfC7GGFSrlEUFAlynKeoTHjM6qAuYKpq9aQOe4czfR1v
 Ce5S4i4v0vofmYbW6Q9GOrrld25sEZxJhVVMJ5hB3fgKnvAi5S3JCqZ6UzlCpstVIs
 bxnIKzKi4K0q0RVJUAkrel+GiXIV4nX7vEqYz//ecb2jsHxKo7+8JCJMqXkGg5jc9l
 wQ36/1Z1iyLBMSZ0hW/2Y9CC7Ws0ZfZNI+RNgNwxhOcO/4VvqKhs2PheWeCP/sLOOl
 WgRG20JBFICDEdLFsXxs4lL2NeDvepAAOVVCsNKHwXFEhARDcRIs7SVWiGV4AePSC3
 GxGPqshmmZR5C/SQWjBKlMGL6P3dRB7XrJmSfz/t1db0g746Foo36eJaE92xrfYjRP
 jqNiXGhV6VKWcAnB8/HKMitmjzAMa+EEfHnQRxI4wMo1SQ4ySSI/H65Kjy3uXhVCLm
 /HrOBvExGtcQXQOIK5n/1/0sAgvWjNjuK8CKLDsxg6tHYHm8Lk2nw2w0Mp9L7AYBaJ
 +GeLaMU5TrncdN3u4opLDh1A=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso1477565e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 10:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773250239; x=1773855039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9bNTLgPA0zLEPR181AfzEuquRJUd2GIO2/EZ1U0cSE=;
 b=nSztchuxe3TPSIaLoBYAefHsufVe8MFSzcBNj95qbRMKQNMc6jwL5yizQcgie/LvaH
 MVSMeDaBfqt2a5WFnsqmtk105C/m/oEEUIVN7smkIRPM/XAIbPdDmMdo48fsG+9dNvp8
 rR50B+vd35/CwS0/E1VYZgEgaBCW4MvLIikFKdLCh1eLt3yYgByZGFyOkV0Ke5U3yCIv
 mSpCzM26xpM1iiOrI8sABjI6CBmNsxOWem1X4f1LWIwBp9aNZ7VpFdXIf0STWgnF1cHY
 ScvkOuTWJLv/zRGIyjM44HB5Auc5wxCF9jfXOojy88ls/C5gsIuRc1k3qIhQ5Jk6RQgd
 nRIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeKUfafoUnOyp1b1IfITjP+kDjtaA3dgruhd9ApExm1kuTXiZUM8srGmQGuQAt+2sXWGthnlM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt/4n+nQF5FVPK5RaYgJaRGPyhS1B3OV7oaAs+14QVJLLMyyXL
 JFovJYXylQ2X3uM3GrHSczUSET2sm8Rg72NLc1ctN0QPRgrG88NrRHbsIGvUaOeV+qfCMGYCG2a
 sa0iH2zssWfQwOUuVTjljty3BTI/ALKSWPqNNqimmFDp43ZWFaf/4yD0+MSd17oaSVwSZYG8=
X-Gm-Gg: ATEYQzw4b+xonuEvRA/ZOLMzty08SHMPFeJ4VbaLaGLiQ9SeeYayW0rvDWwtolNtlCu
 GRPY8ID9m/6I1ZTLjJhHaPErXIbQHucJveXJLlm1btoyErufyvQ4URMUALS6uS4Z1fhvTMgDpQk
 2U4TFL13LRCnizySpexrwl5bkxTbbNb6Yk3d65NYhAPRMP9PyTA42Qs4okTbv73oHlhlLIFcl9j
 NN6qbIryKzDgT0dn3kUjt9aG4tFvn5k/qE8HWiGJmbS3X0XBrtJ3u1mswauj+pPIQDUSty0NarS
 iPVkFfuNFC7dNriz3S3bxH5fuoUd4qJpaemYdU6fSJav9KUCC6Y/ftjyBvuvN6BTcdHy0LzFpQ9
 CeZ4Wp6fH65ncuM+Lv041TWVbDojjFU5Neci9cr43wKhBJKUT/c0cvvSHtuqcKx1FiZqqrxTbH2
 b7HYmcKe1LiUcqIQ8SGFMgbzsI6u2i0pFf+rl1mEYxyUXx
X-Received: by 2002:a5d:5f93:0:b0:439:d7db:c526 with SMTP id
 ffacd0b85a97d-439f8206d61mr6444454f8f.29.1773250238932; 
 Wed, 11 Mar 2026 10:30:38 -0700 (PDT)
X-Received: by 2002:a5d:5f93:0:b0:439:d7db:c526 with SMTP id
 ffacd0b85a97d-439f8206d61mr6444388f8f.29.1773250238495; 
 Wed, 11 Mar 2026 10:30:38 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1b287dsm797246f8f.17.2026.03.11.10.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 10:30:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: avoid buffer overrun in efi_var_restore()
Date: Wed, 11 Mar 2026 18:30:33 +0100
Message-ID: <20260311173033.10002-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The value of buf->length comes from outside U-Boot and may be incorrect.
We must avoid to overrun our internal buffer for excessive values.

If buf->length is shorter than the variable file header, the variable
file is invalid.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_var_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 5ea1688dca3..c89a4fce4ff 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -497,6 +497,8 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 	efi_status_t ret;
 
 	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
+	    buf->length > EFI_VAR_BUF_SIZE ||
+	    buf->length < sizeof(struct efi_var_file) ||
 	    buf->crc32 != crc32(0, (u8 *)buf->var,
 				buf->length - sizeof(struct efi_var_file))) {
 		log_err("Invalid EFI variables file\n");
-- 
2.53.0

