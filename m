Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503C4C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7CC807CB;
	Thu, 16 Jan 2025 02:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DG8O3/tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B86807B1; Thu, 16 Jan 2025 02:28:19 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7ED80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3cdd57060acso1433015ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990895; x=1737595695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PC1IyTdCtwbe9p3BK/OAlwBq1Kb3dAkGZQHsO0NAGuk=;
 b=DG8O3/tjQSPShh8R7ju83PnNvS6ZCC0LbLDi3nAev4gSR8ERsneR+XpZ4Dfn2xIVKJ
 hH0DW4wsTdKWDnLufcpy7XWgkwB7SaMZ8lbFVFfJ8APCN2m4pXJ2jfmcXTZAg0j7cblU
 D2/5N7QV1CBciE2jfzTBiSq1T6Va4GG+ZN0wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990895; x=1737595695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PC1IyTdCtwbe9p3BK/OAlwBq1Kb3dAkGZQHsO0NAGuk=;
 b=oNV80qGy5pFTbC44XTnr9UaqV4xDgYhuEalA5dGOCYs9bzw011ZAoiVdKPCiCiNoQC
 U2yXDxR14SF8Y1rdDaeXdZ2LItG97tjwewlAejgG+yayf3ayCk4ehyNLcBtsSTb3ofYC
 RcslQnhMFDFJwpsxU8wb9hA7qn29ZuAq19de96DQn9DCt2Te3ZOrinZkG6afkDpiOuXD
 9eqk2VFna9r05N9ADqdiw4IgcP+TKP+tgmJUdZiNCK1H9x03zfUqonmDlCVf0P4Oldy7
 gqMTx5XrIoZ7KoZGHZ/DObhpPFny1LpWdZiVy1kzlztERhDzA7JgLjpfY5wYtLh1CKeX
 vjZw==
X-Gm-Message-State: AOJu0YzaTNXxSjZ5RUs5SHkFUyamY2mu3DlTmyjDBKOQKWHS3Jpeqv1E
 8oFGOZfXLBX4w5UTylHuUmXbnKpgGRvUc+SaiwIn64e2eUeo71nsBQcEWGkcjWLaSDat5rJ+hoo
 =
X-Gm-Gg: ASbGncujcJObMMN95fgqmDpxI+HJNy98CGokgYhzqXajWzFaJEeQpRR0MFJC0/TYX6/
 UGzI0FKSkdh1qJrtxWbUmnLbhMeL8rs95BDPBx8La7eM97AsbdEJDJF98tq0emtlahX/axDf1Lg
 DeFonc/c4WHEejHmjMM46DX3bsMexWkyzawUuuMtVDdcZ2m/tGi7vWdq9kqUFjin3+1NU2/P3De
 PO4BlF8l5KnbBEH96m8Jn7pA1u54W287cVeLobEWVrFi0VM191HTwGarak1ggwHPn3qoSn7hR5S
 kRleUH9GZySRZXwNQA==
X-Google-Smtp-Source: AGHT+IHryTWL+9bDU78PArAg50nzzsrRKwSigBbx2ZpwLQGpOnaMeSuTzhLb3utZoKY5ZQ0w+XMHCQ==
X-Received: by 2002:a05:6e02:1749:b0:3cf:6463:41fc with SMTP id
 e9e14a558f8ab-3cf646342f7mr3677245ab.17.1736990895199; 
 Wed, 15 Jan 2025 17:28:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/22] vbe: Allow loading loadables if there is no firmware
Date: Wed, 15 Jan 2025 18:27:15 -0700
Message-Id: <20250116012723.2820301-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

In some cases only the 'loadable' property is present in the FIT.
Handle this by loading the first such image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 8fe278ba1a9..b935513d44c 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -183,6 +183,13 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
 			     &load_addr, &len);
+	if (ret == -ENOENT) {
+		ret = fit_image_load(&images, addr, &fit_uname,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     image_ph(phase, IH_TYPE_LOADABLE),
+				     BOOTSTAGE_ID_FIT_SPL_START,
+				     FIT_LOAD_IGNORED, &load_addr, &len);
+	}
 	if (ret < 0)
 		return log_msg_ret("ld", ret);
 	node = ret;
-- 
2.34.1

