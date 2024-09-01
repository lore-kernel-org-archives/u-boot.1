Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F8C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6E688D0C;
	Mon,  2 Sep 2024 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dRPIVz9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827C388CF0; Mon,  2 Sep 2024 00:27:46 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C1587CF8
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a35ea3edaso93418539f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229663; x=1725834463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhuRES6RdflloOM8gsZyQPRoox8duyX4YqH2/v1iNGs=;
 b=dRPIVz9VTQytno0DVSgsgzfTUXsB2P+11AVIc6NSJh4xAxUEB8NWSXbtTmzeK9g28j
 QToXZB9lXjZ5jSX5ZMuBG+89Kzg5ClK9XyKFV7mzGQAJVqNWqG7nMPAXsWPkx0Z/LYsp
 86EOq0V4F6m0CfgT4pcMxGbmy1Up77ii+B54g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229663; x=1725834463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhuRES6RdflloOM8gsZyQPRoox8duyX4YqH2/v1iNGs=;
 b=ZMpFJP+d+upODGS2Fgs9EC2ytoSC8v8rMYIIpxW/s1qpbMfHlH2ivxWwev8uPWseb1
 lvWlp6nWc5OdQZ15yEKlt5avJkZwEek4ZKEcpeOAKp5yS6CytqmaurdqdPdD6+xQLDsf
 ZasU2CupDTbknXUyl3DyBFnEeCqje3vB68IulEp2XOUb8RXhO8JmRfTK/U/uwCtXCAWx
 Ep2PAVY/tahsxIiRcz5aacWNBt2IC/Ch6MFmDfYYN2a8VxFlCcrAmUbTn9e/fERpkxU9
 0aVAfuv9u4RxZtWor1bhySjnc5aaObctECggjDvUOG9cxtsLakrBqTqfuJkEYRuitwXD
 vL2Q==
X-Gm-Message-State: AOJu0YxUveBTDvjalY70dE3r8fEfmeAewnT0qNqvkz+/qJut9MenRmxB
 bGLubgzK98VNNQAfLBxHHdojQe3/GiLEhGDF8SqgN2+7K5C25A+WtSA71CbwGxyS+HTs0ZhlIUI
 =
X-Google-Smtp-Source: AGHT+IF/jXmI+AthausWmivfcoRBdd/irVjjYXckoaSv/ZipD9+KPP9/eXHN+on/wWp1TTI04iAdcg==
X-Received: by 2002:a05:6602:640d:b0:82a:2fe8:59af with SMTP id
 ca18e2360f4ac-82a2fe85b24mr957125039f.9.1725229662888; 
 Sun, 01 Sep 2024 15:27:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/8] bootstd: Avoid calling unavailable block functions
Date: Sun,  1 Sep 2024 16:27:28 -0600
Message-Id: <20240901222734.462334-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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

When BLK is not enabled but BOOTSTD is, some features of standard boot
become unavailable. Add a check for this in the only site that is
currently apparent.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 807f8dfb064..64ec4fde493 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -434,6 +434,9 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 	struct uclass *uc;
 	enum uclass_id id;
 
+	if (!CONFIG_IS_ENABLED(BLK))
+		return -ENOSYS;
+
 	ret = label_to_uclass(label, &seq, &method_flags);
 	if (ret < 0)
 		return log_msg_ret("uc", ret);
-- 
2.34.1

