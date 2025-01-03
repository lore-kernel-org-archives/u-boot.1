Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF035E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 07:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6573580381;
	Fri,  3 Jan 2025 08:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HNKARGRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CD980381; Fri,  3 Jan 2025 08:46:50 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5107B8036D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 08:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2163bd70069so67770435ad.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 23:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735890406; x=1736495206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdLnkhBzW7EMwQWYh/0WM7E54YU5r/fH+yS+kPLmpVE=;
 b=HNKARGRuYmztWVZqM/lmRGms/xjtsEz+NdXfsZRJNUFyKSN4CLEX+ZESg/M2V5D8/9
 rRDBJLtTf1zmQEGtJZE+sQhAKvui8VtU8P0gTMOKtI3H1X08O8xQWKT0FTu4PBJlGJd1
 800oaleWDZ40cJt1/JOft6VvAxfl3iqAors/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735890406; x=1736495206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdLnkhBzW7EMwQWYh/0WM7E54YU5r/fH+yS+kPLmpVE=;
 b=GVX0fRQ98Zvz0NIfRleNuoKQ2HwD4e2FaSRACF7G2bTRURzEhhQQs11l3IdfmExG4y
 XfuWX71TuZrVTEWZXSHkQ/JwjYKpVnsn7L/1s+h3QKVHTm6VsaNBjlbLWsmNvI7AtVlz
 HfvI4RYRy7ThaIb+sNvij4yiB/vp5Y0G28Uz9YmfAesIwKgi/6UVztBo5t2qmDH+8tv8
 d9mgYtBtM+kXiJO0dOfve4zUYAoLScqD5rwFvZ2x/+i2jL36Yy6IiDzKdG3P0iqTijC+
 IHPrcMBbR5W4yIciTbiR1Gej00HgW0UEq9qwv8C7Sn0BGYMe4bb+otYraHcJOi2/emK4
 B61w==
X-Gm-Message-State: AOJu0YylszeFS1H6NNh17LlRRke4hiCj6w6rxKWbMT0JX6Y6ijSjUrEX
 UPlXbp1lKAn7Ab6ckbsDYYC1h1+SnGITTuY6VVxb4ahKq9KdldOqnEVqBvZFe5/l4RWB02ssY5I
 =
X-Gm-Gg: ASbGncutH4v/VqjqT80K4lhC6Dzmcy3YCMPVkMy3DNxVsX/N9lh79vFv50bzT4r7pqt
 QIamsL5r3zQpo17+HkKMYqIrRGAVWQYP3muDT370ad36hA+s6ioxuE0rKy5Es2szvlVSrQdQS8s
 8PYa4E9Y6WJe2SVs6+RdkCKHRa3i1OyD638S1sWyO4yixDbMWe/wEYDMighO69smAJAdr0DIb+0
 JNcdCN3M9b4TrZCcvLRG6otVrzhKaTdYZ1STZmgXi0JeNDpY9s0f51lN/ldfjExtMOAzjN3Oo1v
 n4ptJ44=
X-Google-Smtp-Source: AGHT+IG6sSKGy12+CUlD2r8w9M+y2H7pNlyGaIR105x3fHsnkBPqJN4yuP726UBaDRQjFm/Yvzj71w==
X-Received: by 2002:a05:6a20:8427:b0:1e0:ca95:3cb2 with SMTP id
 adf61e73a8af0-1e5e0458eb9mr85360752637.8.1735890406272; 
 Thu, 02 Jan 2025 23:46:46 -0800 (PST)
Received: from chromium.org (219-89-85-241.adsl.xtra.co.nz. [219.89.85.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9e3fsm19869376a12.73.2025.01.02.23.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 23:46:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] upl: Add a work-around for Tianocore images
Date: Fri,  3 Jan 2025 20:46:07 +1300
Message-ID: <20250103074638.2348387-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103074638.2348387-1-sjg@chromium.org>
References: <20250103074638.2348387-1-sjg@chromium.org>
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

At present Tianocore uses a 'name' property to figure out what each
image is for. However this is not in the UPL spec.

For now, add a work-around so that Tianocore can boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index a9d25f607fe..d8211b2cf77 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -280,6 +280,7 @@ static int add_upl_images(const struct upl *upl, ofnode options)
 
 	alist_for_each(img, &upl->image) {
 		char buf[sizeof(u64) * 4];
+		const char *ptr = NULL;
 		ofnode subnode;
 		char name[30];
 		int len;
@@ -313,6 +314,15 @@ static int add_upl_images(const struct upl *upl, ofnode options)
 		if (ret < 0)
 			return log_msg_ret("uma", ret);
 
+		if (!strcmp(img->description, "UEFI Firmware Volume"))
+			ptr = "uefi-fv";
+		else if (!strcmp(img->description, "BDS Firmware Volume"))
+			ptr = "bds-fv";
+		if (ptr) {
+			ret = ofnode_write_string(node, "name", ptr);
+			if (ret < 0)
+				return log_msg_ret("uma", ret);
+		}
 	}
 
 	return 0;
-- 
2.43.0

