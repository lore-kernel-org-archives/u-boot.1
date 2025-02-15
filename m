Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03671C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED8280EB5;
	Sat, 15 Feb 2025 04:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HXiXfmzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB47680DF7; Sat, 15 Feb 2025 04:23:17 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C09806FE
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so8705525ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589793; x=1740194593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=HXiXfmzU9FTkbcDddIEBM35FthYNxODVGnTojx5pVweB83gsZF03hlTdGbezQzNEFH
 gs9CdAKdFES0zZtHxuhY7mLoPb/evLMQflKeZRODIQ6wJvbe3fpcuncFODXVMClxjwDz
 ARcYaZp0pLDok+G/7+XQ3vSq7cYbw25e4PIdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589793; x=1740194593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=EmA7IYlIm8K1BqWao7H7YpCYgXA2zvLuM4e7a5zBJX6UzRvvTMHzHgWLTXRsyj5jPY
 wiBjZNxkUB61CurtoUZGnd6j0au0macq7fluGrOsfuWK6AnFUI+KNVTlk1zOVD8xOeIt
 zctprv3s+gMKVZDmHcxmLGRianY8ts3l1OP6mj3HQDLXRx7/oX8iC+/riugYwQ0ixHyN
 s2z1V+Et7CWyuEOo0Dhdfd4xnp4CO/Mqg3qJJKITgCtMKcq4Ldqe2Okd4mMfMukIO3Rx
 dgf+cbYL4Q1fWHLsL8vTMlb9n8IeS/o7RYiPGwetl2MTU9Dk3UGXPkEE6dUAOS9+88Oy
 Gw8A==
X-Gm-Message-State: AOJu0YyMq9ux+qPvJ9Se5SE851YnmXjBq/Kl1aunggubuFvZSBOQ3WMA
 YVF/O0IxbdWoELmw7yd6srgsx1s2eRjFopjqRsysyTFURzcSXjwgqXecAqHAAn1s24HCaXNSfI4
 =
X-Gm-Gg: ASbGncuOjN4SpIIUeCYWhHP6MNJv9x4LbfZt3eajbVq4V4+qFz2g5l2MvPX1aBxMiPH
 +6wrAd25k2N+5rm3xUXg0OlmCWY5YQiN3CVijCuxpzklEpWLk/IIH2/Qs3D2NOAQOMdNjOpKNRP
 U/azdA98HrpC83azc8UQo4i1ZHaS+lzPw1SVWMekB9jAgytDHTxhkc4o1f7Zt5b1+F9G+ugtmFx
 /Gfda4JfgMzSnkkfM3AoH3L8IMgMDUIOz+3mhXONp9Q9iacRtgjeGGMTmdBGI4eJNIjc3ArUa5E
 BmrUuWdnp2Onqt1z2eyaZlNWN1xd5hAnQ6QU7nTVx2b00I1vKJOi
X-Google-Smtp-Source: AGHT+IHkufxJueBTvf3UuPdhEfRn/g2JBQ0RmGKQbxReK0oxEpjloEyFlds3xhz0sVtDWqLpKbiabg==
X-Received: by 2002:a05:6e02:2408:b0:3d0:4e2b:9bbb with SMTP id
 e9e14a558f8ab-3d2809580eemr18358965ab.21.1739589793489; 
 Fri, 14 Feb 2025 19:23:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/29] video: Use a local mode_info struct in the EFI driver
Date: Fri, 14 Feb 2025 20:22:24 -0700
Message-ID: <20250215032254.4121030-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

There is no need to use the global struct provided by PCI. Declare a
local structure instead, so this can be used on ARM without including
support for PCI ROMs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/efi.c b/drivers/video/efi.c
index a7b6d47f9a1..94d4c93dac3 100644
--- a/drivers/video/efi.c
+++ b/drivers/video/efi.c
@@ -183,6 +183,7 @@ static int efi_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct vesa_state mode_info;
 	struct vesa_mode_info *vesa = &mode_info.vesa;
 	u64 fb;
 	int ret;
-- 
2.43.0

