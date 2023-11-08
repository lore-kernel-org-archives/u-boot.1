Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273CAC4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863B087702;
	Wed,  8 Nov 2023 17:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJp1bTv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDFA6875A7; Wed,  8 Nov 2023 17:49:09 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44C0874A3
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778a47bc09aso468154485a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462146; x=1700066946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAiLrTR09Hyw6FI6W2h/8n3Ex89Q4lC2JliMV02w6uw=;
 b=jJp1bTv/VUQy2Euy8o7UVtihkJk0Vx3Y5Iw1uIeMlFWTiziPYW9Q1PfXH8pL4mthtO
 +Paf6OeiQOEDlHTIgaQzCRqSstOcY7nkIvfBcstDlXtgyqvfsnmObT8h7dL7ggaHe6wg
 hOXgvcRvKlEO/WZF0vjrheCpAn8VBVAPhEcuOgyqMU42ZDY1CPUmlP5tgiXaINl8Tfl+
 srlKRYU1TxS2ZyKaJVbM130CbYTWEBlezS6cD6VGuPS86N1jlKe9qzppkpyqDt/YkzK8
 djlDP0EDtkgOcwFwEhz3k1AyNsaJ//WDTOlM7wGDNkDrpb4Gv6Ah199Wj+j0NtqA5OYr
 aC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462146; x=1700066946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAiLrTR09Hyw6FI6W2h/8n3Ex89Q4lC2JliMV02w6uw=;
 b=ASLYYJc9J0cRE/LqIGfmBAKdlmNkuy9UbmRSg2W5EmHojZk0BMdNTC5kd8FQFRzOSB
 b7+oBs9/qQwUi7wyGpcCqFviwtoht75PaCT+CNJEkmBCl7qCfv5cmfVnDfVqmX0fS9Kn
 SjO2Zxv1JV8zBGzMOR1Gkbzsm6u40HcrN283wvljXRAZgb/23twuQqDjzseAv9xo1U5C
 XgP2i10MkrlZ4SM5OU/Rpx4qBZWKnw89PubTzVaF+xI35a4pH26pqRiyP9JiHOzxaPVN
 CtriAMRCCvfKKNcPMjMQtER3w6cFEaZEJ1+a4REriAP7U8Y8aAGJdD9jORY2auETf+pt
 iq1g==
X-Gm-Message-State: AOJu0YxoQ6kVsl2q6/dX8tqr6bb5ppMcdCrcjU08SJ7b+ejFbRsCC1PF
 4Dw03sNzZAwYv78WW12PSS4=
X-Google-Smtp-Source: AGHT+IFwcOuAu3p7SNeZRR0hgE+61E29VkMi9z/+cuSMdgHDKYlwPUGyMd5woFLKWfmXPh174tJ+Lg==
X-Received: by 2002:a05:620a:248a:b0:775:c335:1ee8 with SMTP id
 i10-20020a05620a248a00b00775c3351ee8mr2333900qkn.54.1699462146383; 
 Wed, 08 Nov 2023 08:49:06 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 vq25-20020a05620a559900b007756c0853a5sm1218342qkn.58.2023.11.08.08.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:05 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 04/26] spl: semihosting: Don't close fd before
 spl_load_simple_fit
Date: Wed,  8 Nov 2023 11:48:36 -0500
Message-Id: <20231108164858.3497420-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

On real hardware, semihosting calls tend to have a large constant
overhead (on the order of tens of milliseconds). Reduce the number of
calls by one by reusing the existing fd in smh_fit_read, and closing it
at the end of spl_smh_load_image.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Fix typo in commit message

Changes in v6:
- New

 common/spl/spl_semihosting.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index f7dd289286d..8f11c29913f 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -24,18 +24,14 @@ static int smh_read_full(long fd, void *memp, size_t len)
 static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
 {
-	long fd;
+	long fd = *(long *)load->priv;
 	ulong ret;
 
-	fd = smh_open(load->filename, MODE_READ | MODE_BINARY);
-	if (fd < 0) {
-		log_debug("could not open %s: %ld\n", load->filename, fd);
+	if (smh_seek(fd, file_offset))
 		return 0;
-	}
+
 	ret = smh_read(fd, buf, size);
-	smh_close(fd);
-
-	return ret;
+	return ret < 0 ? 0 : ret;
 }
 
 static int spl_smh_load_image(struct spl_image_info *spl_image,
@@ -73,11 +69,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = smh_fit_read;
 		load.bl_len = 1;
-		load.filename = filename;
-		load.priv = NULL;
-		smh_close(fd);
+		load.filename = NULL;
+		load.priv = &fd;
 
-		return spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		goto out;
 	}
 
 	ret = spl_parse_image_header(spl_image, bootdev, header);
-- 
2.37.1

