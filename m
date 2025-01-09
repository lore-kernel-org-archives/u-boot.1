Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53776E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0952B80691;
	Thu,  9 Jan 2025 13:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q+uCdFM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDFB80657; Thu,  9 Jan 2025 13:30:48 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F346B80619
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a8180205f3so5940255ab.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425842; x=1737030642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faBNRb8Wy6qfp71muYihpxCJ6/jVPkYdS9m9Uz54Jtk=;
 b=Q+uCdFM2a7bVWb6adsuY/oZe3FwE4h9jih7RJQXXHJh8MEmLxRu0YBsFGyKBQAN4LO
 PQazfJb19SPKGwzcMvsnwnlT8NgwcqZZ3pr7x18zhCTscU0q76XdeQB0NC66IGbvjpuX
 bulan8K41pdmxavauWsQRF7NGu+ovM7As5X/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425842; x=1737030642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faBNRb8Wy6qfp71muYihpxCJ6/jVPkYdS9m9Uz54Jtk=;
 b=D2FThNtSZHIrVdnKZr+6uss5Alt2tVR0kqp9pttt28KsKXgMwb+vJdNTe8RugacUPt
 /oaKKaFMs/7DabcUKJFzDd3x5JYtKS9VBsUl5TDYFiJbBOb4rpqsYcCpASV7VFv9ge74
 R6lN7pwUDXH8F8Yt3BxDGID8KJbWi6R/k6NLTqapnFUMeRNAQwyCsVyYTo1VDj3bavpw
 c2V7Lmy/Si/YllI2Bq3ese0A3mNcDkQKyEG5TG/PgEgE+FppUSL/etxhvFarAPP+8lqV
 mDee+hYnTa5FBJoRwO4vJULOkEaoINN4Jr7RrK2kbkVWJbJMJPkRx3YB/KYDi/kXfLpc
 VsUA==
X-Gm-Message-State: AOJu0Yz5Q9RzHe4SkkP4wlxIf1G9AKLAV+Ip/DXG6j3Pu/vQfZf5Qkaw
 cIFoG1ZZm52OkL+uy8D/kwAW7G2JvFOu5oDptIAOlEavHfHedKr2SGCNUb9BUNOHA+Djm8RMoBE
 =
X-Gm-Gg: ASbGnctVy/gDCTilw260AArvEErNoxfMgVX5serX4K8Bt0wopvkDWm5Jr7PAdV72F9s
 FhC9d2lX2QHblQsCov42djP7EybuuLTX1vDTJhLLVOcTETjmq16RguGV5EGZKVe80Zv7dS3PGcs
 uTVeKhQEmDlqvaCtrD0/bIP7s8j8LtbxnOLKlwcphO0MGxsvHGzozSISv/hvaeq6aGH5RQspd1+
 y0GlzGATOumx5LCGJm8Ni51mNJxkmHOBcIAGzGpJy+wfPzv2lA8r2YAlyQssqFO5w5D8FlPlTB5
 vFuynJwCyTGW9PBoVQ==
X-Google-Smtp-Source: AGHT+IHVkiMhbl/FyfdL7JpIsMFYLAUR7zlqvNoY4j9H0mNNpnVZqaAOalqnXUaVe1QYipzKgjpDyQ==
X-Received: by 2002:a05:6e02:1605:b0:3ce:3395:f7b1 with SMTP id
 e9e14a558f8ab-3ce475fbc60mr20560465ab.9.1736425842653; 
 Thu, 09 Jan 2025 04:30:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/15] vbe: Tidy up error checking with blk_read()
Date: Thu,  9 Jan 2025 05:30:00 -0700
Message-Id: <20250109123010.4005298-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

This function can read fewer blocks than requested, so update the checks
to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index dfe44822430..c7f09c6d090 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -39,6 +39,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	ret = blk_read(blk, blknum, 1, sbuf);
 	if (ret < 0)
 		return log_msg_ret("rd", ret);
+	else if (ret != 1)
+		return log_msg_ret("rd2", -EIO);
 
 	ret = fdt_check_header(sbuf);
 	if (ret < 0)
@@ -127,6 +129,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 			  blknum, full_size, num_blks, base, base_buf, ret);
 		if (ret < 0)
 			return log_msg_ret("rd", ret);
+		if (ret != num_blks)
+			return log_msg_ret("rd", -EIO);
 	}
 	if (load_addrp)
 		*load_addrp = load_addr;
-- 
2.34.1

