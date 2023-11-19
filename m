Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24193C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BF987208;
	Sun, 19 Nov 2023 17:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="ionB3nHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285DB871F8; Sun, 19 Nov 2023 17:56:25 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96877870AF
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40838915cecso10014605e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700412977; x=1701017777;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5nX6IGGXEnsvq9FcDECjhzTp2HvilbXo6+4vhCJvpM=;
 b=ionB3nHN0+EH7X3iWHljvUViQUE3MhICYaDf5YOzSI29/SIRhKrVqIP+gKU+mudMcU
 8J8f1JX4v7L4/GuG3XCW0nj9ATXsmfHTWNnxS8ykVUC5eS+ZI4CqW+eEXuXX/OtUvGl6
 nGrhRj+uJgZEWt0A9y0U4oZLzg/dKdd46JucIRWc11EKjgbZ0LU0ZTdKTFkVr6JumE/L
 DeU0wcL29fztTkdc8dzGvw+7bp5WXQkN/xNPE98N0nyMEL4Frk1B54u40wVQJ4f47o46
 sJxWSLMZam9rzY1KaceG28go/Dzi9peTeRuC9i3fLh0qH06QqxDQzmEDZknRPQXSDv8u
 Z5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700412977; x=1701017777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5nX6IGGXEnsvq9FcDECjhzTp2HvilbXo6+4vhCJvpM=;
 b=TkeDZNKWLYOoclYwVxX7yzOACdCEIxb+qt9ulfrKsDfPx1UFoklE3isf3lnQvtoJnp
 1ZI/dd64OewKj+EDJcq1Vdd+An53Bev7BBPfqkWKrvjmWMBh+XsV5Kf9alP3hYGsXb12
 YjbMOThg610Cz10Q3PN3f78teEqoW3HlOsFPvtHLkiGlw5+6ziOdSSWqArEnzFAoaYMm
 AdY6V1Prg3sL71JylFHxiBeYwGb3NoXHsC3HvPeh0VUpJ2HegXitWyc5yGR7VA1bnRyP
 IBLZv803Stllt4An7KTVpottDgPBv6S5ynZ+YYcgMUyHdDkR2EbfVBStggoPKYk1OWxD
 A86g==
X-Gm-Message-State: AOJu0YwWQaPWHo04jKzTUW+5lwbVMQ1uSa6taE0WWtKa613rsB/2eKY8
 +SbDrAFGdhsemEAn6DTe1ndTsV98mB7JA+ZMKNkU5VWe
X-Google-Smtp-Source: AGHT+IFCBREu/z8wUoMdEqJl9R/qwRmmtF6I6seoEjEACkUcxVvJlFXVHtkbbwoFoaQE1vwAp3xC1A==
X-Received: by 2002:a05:600c:4747:b0:404:fc52:a3c6 with SMTP id
 w7-20020a05600c474700b00404fc52a3c6mr3873666wmo.25.1700412976840; 
 Sun, 19 Nov 2023 08:56:16 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b0040684abb623sm14483754wmc.24.2023.11.19.08.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 08:56:16 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 4/4] bootflow: bootmeth_efi: don't free buffer
Date: Sun, 19 Nov 2023 16:55:01 +0000
Message-Id: <20231119165501.1305136-5-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
References: <20231119165501.1305136-1-i@shantur.com>
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

bootmeth_efi doesn't allocate any buffer to load efi in any case.
enable static buffer flag for all cases.

Reviewed-by: Simon Glass <sjg@chromium.org>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

(no changes since v1)

 boot/bootmeth_efi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e884dc6293..446cb73140 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -160,7 +160,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 	if (ret)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
-	bflow->flags |= BOOTFLOWF_STATIC_BUF;
 
 	set_efi_bootdev(desc, bflow);
 
@@ -404,6 +403,12 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	/*
+	 * bootmeth_efi doesn't allocate any buffer neither for blk nor net device
+	 * set flag to avoid freeing static buffer.
+	 */
+	bflow->flags |= BOOTFLOWF_STATIC_BUF;
+
 	if (bootmeth_uses_network(bflow)) {
 		/* we only support reading from one device, so ignore 'dev' */
 		ret = distro_efi_read_bootflow_net(bflow);
-- 
2.40.1

