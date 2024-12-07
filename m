Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4A0E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8AD8919F;
	Sat,  7 Dec 2024 18:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kZfyIXwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B17B89338; Sat,  7 Dec 2024 18:26:41 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA1A388DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so115108339f.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592396; x=1734197196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fOVaUbxSDJQRCfCvQ51TYMcbMsmkYpFVeSIAd7BULc=;
 b=kZfyIXwRgIEVOy6M2EK/QHjSAhS079LxWRCzu/zt4uneNrWnJ8fJL4dtryuA6hW+MP
 eoUcP93CRm4bdZPHBVkzSgQEtzyUKPBnRzAA3vNjpQQd0ziveINQBLtXikIU+PbmDBIo
 E7zKsF0lqy0Us9Nt3O0nhaVAn5y8HH7FXbAx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592396; x=1734197196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fOVaUbxSDJQRCfCvQ51TYMcbMsmkYpFVeSIAd7BULc=;
 b=IE6McKi6twfyQtxlxzkOJqMfsCM4QEbk3ihOOAit8PkR6LqiqUFVv9pZVb0o5QSus0
 62ZzYFJJcu+uadNOLRUp56KcttcNywFDQnEzBmJcowhgdhVPZpWVFYa+hxjqE7cbfLB8
 NB8378bl5crgWgC+JwXwyqsyAjJgRsknR1L0ZHGFnY6Irk09JWysOevUqB2xwXlrTv2N
 qQe0kTnvsLx+1wd3LADC+uD8G9SIX5l2ZWivPmEYaiI7EhfaZx5TlsfXMz4GBKyWSPJG
 zG7wBOH6MDCVNF+K5cTK6nItK1FybGeglo6MB4pdQ1i3LEJgzBMbrqPUltyqXJx6BiHX
 YTVw==
X-Gm-Message-State: AOJu0YwttIuiyDiXvJ/vXRLMKkHHDIea6qzyzP5FlM3hdQGrODJUzGmU
 YG/SlxXkFOkCvb+SvAJcxT3rUc9VWu92Kw7n3bncjSmZdVL44LB79mPj1RdWgp9VNkmDGOklgE4
 =
X-Gm-Gg: ASbGnct37X5roxnX7sQ8EI3ZER5+jF1NVnHuMYZCbVxgeXknsl3TcQtLBhgOOg/V5s1
 NwJXhQXnNPNhPVIgcSz8+Xk/skkmGJMKKbcaukdmWpPu2IzCyovKfODwGWQA4PwtjxNN0s0B7fE
 n/OytDAMN2CQHmCcOEPLakByLdszOALvXOpa3qVap2BXLuQZMosUawwi/HxG4L1euzdykeWax94
 lNFA8vTl5GV7kPCGaZlK1X6R+sVQ02xLcT1/BIbz5OXs/rVlHGDRgHMQaUbdrEyCF2Z6tzOzx0N
 C2U8r10A5IQ=
X-Google-Smtp-Source: AGHT+IHCwPe1njNqhPQUmFV6SheIl+hLwnw4lM5cf905/6iaobgZhxdxg0sFT8aKjBPJQ3K7oam7Xw==
X-Received: by 2002:a05:6602:158c:b0:82c:f7b1:a9fb with SMTP id
 ca18e2360f4ac-8447e04ccaemr648923039f.5.1733592396425; 
 Sat, 07 Dec 2024 09:26:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/19] spl: Add some more debugging to load_simple_fit()
Date: Sat,  7 Dec 2024 10:24:07 -0700
Message-Id: <20241207172412.1124558-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

Add debugging of image-loading progress. Fix a stale comment in the
function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_fit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ef40a50082c..ac8462577ff 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -190,7 +190,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
- * @sector:	the start sector of the FIT image on the device
+ * @fit_offset:	the offset of the FIT image on the device
  * @ctx:	points to the FIT context structure
  * @node:	offset of the DT node describing the image to load (relative
  *		to @fit)
@@ -243,11 +243,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
+		log_debug("read offset %x = offset from fit %lx\n",
+			  offset, (ulong)offset + ctx->ext_data_offset);
 		offset += ctx->ext_data_offset;
 		external_data = true;
 	}
 
 	if (external_data) {
+		ulong read_offset;
 		void *src_ptr;
 
 		/* External data */
@@ -270,6 +273,10 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 
 		overhead = get_aligned_image_overhead(info, offset);
 		size = get_aligned_image_size(info, length, offset);
+		read_offset = fit_offset + get_aligned_image_offset(info,
+							    offset);
+		log_debug("reading from offset %x / %lx size %lx to %p: ",
+			  offset, read_offset, size, src_ptr);
 
 		if (info->read(info,
 			       fit_offset +
@@ -336,6 +343,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		else
 			image_info->entry_point = FDT_ERROR;
 	}
+	log_debug("- done loading\n");
 
 	upl_add_image(fit, node, load_addr, length);
 
-- 
2.34.1

