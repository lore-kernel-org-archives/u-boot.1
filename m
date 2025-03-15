Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A00C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292F580FDA;
	Sat, 15 Mar 2025 15:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwSeEYGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED8680FDA; Sat, 15 Mar 2025 15:27:11 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD5980ECC
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso6240605e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048828; x=1742653628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77kh4UitdBViMAMVedDzigiE6fHnRQPst8sgvqFp9rc=;
 b=ZwSeEYGC3t21pynpDxFXC7VDheWpS3AknzmszfRmSfwOh0UH7EunCKwdzqEXjQmVXC
 VMbDbCSEtfcJHxTTu1vZAKWBFbAh/ELDK3O/EjqMkYWFADYHWlNGnecw9NB+pmfLA8LE
 IW2UJPpe8hA9SBQz+nUsqWQLBg5R6rwG4F5sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048828; x=1742653628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77kh4UitdBViMAMVedDzigiE6fHnRQPst8sgvqFp9rc=;
 b=A30oXRXO6icv4l5SdjuOiDhCIkd6oaPDhgT6sIJbWaM04ciJs9aQ5wUNw0kbWcul61
 WwS7a4HhVn2ssN3Aaxn7lDbGu4TQI8rk/C3LxwZxUQaeQcb8tTfaw3QAubTTlBOTp9DW
 vUOaW5shylYLojz2TXxVSDmspIHTPO4ZVKkqy/XgH+0e6ykRghBb7jBHVTMUMp6rYzwp
 t7s+Dq6unQuiiCgd2i/ujYyLxm83nzDv7GJVU96w1PaaMTy+SZUbWQXhVpzK9mKi2w/C
 BMP2WrabuTyjVd+dhIOJ4RaM90ongEJgs52Oi+sosxNmRsjIAlQur6eGb7VwqIp6t/fn
 CtcA==
X-Gm-Message-State: AOJu0YzWx5jJkFRmJeELo7LT7BzS9hUNG1g6EDC1purKRlxqvJUT6H+A
 B6k27JxBJrfgb743Yf6dobg2ZR8O93i0Bb4tHssuvtjsPqtqQOEHwvjraob7ldKU5FcypSpzWSh
 /Nw==
X-Gm-Gg: ASbGncsO+GjA+vJ9lCwvx9xsgJDi4T/E+5TwIeHCGm3z7XHocK6BSr2p9b+GmrNLjV/
 Vh7dNwwPGFQMbwK7csBolKuZ46CkBggKEaaoviUnH3dcDELeBuvPcuRYPR70RcNk942VA9dSKzY
 PJqN7eKPEW3GxUbV51yjPnmuVMv5+N+kzOZ2ZI1CR0c6lAM2F5FZx2M0sVZ8TsoU4dA7SdDKVaE
 TbamAUAVzywtl7OeCV72xx/gL+nX9VVfj3RXlojt9ZP9BWicCVE3eYHq28OgrIGOamgipHg9QZB
 x3uqKwPlkKITtqb19+T9R09haTG6Xe3+fQGMzI1uhFRyDuLqt6pn
X-Google-Smtp-Source: AGHT+IGnPBApVcbWs5Tj3jsBk/lary+CMzDCABchHLMdWbOy7PULVObUYnmSvogKsDyBuzwxC0hNTQ==
X-Received: by 2002:a05:6000:1a85:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-3971e876827mr9250980f8f.25.1742048828195; 
 Sat, 15 Mar 2025 07:27:08 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 01/46] boot: Correct ramdisk address
Date: Sat, 15 Mar 2025 14:25:21 +0000
Message-ID: <20250315142643.2600605-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

We must use the ramdisk address for the initrd_addr field, not the kernel
address. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: e05cda3004f ("boot: pxe: Refactor label_run_boot() to avoid")
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/pxe_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 16608c6ebc8..d827b1135bb 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -601,7 +601,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 
 	if (initrd_addr_str) {
 		bmi.conf_ramdisk = initrd_str;
-		bootm_x86_set(&bmi, initrd_addr, hextoul(kernel_addr, NULL));
+		bootm_x86_set(&bmi, initrd_addr,
+			      hextoul(initrd_addr_str, NULL));
 		bootm_x86_set(&bmi, initrd_size,
 			      hextoul(initrd_filesize, NULL));
 	}
-- 
2.43.0

