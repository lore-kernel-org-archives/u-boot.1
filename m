Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C0C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5C082C84;
	Fri, 13 Jun 2025 10:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="i6pmhnYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD66A82C2F; Fri, 13 Jun 2025 10:58:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C88682CA6
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749805113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrHs8D/DvcugM9RieliVwYMmaYUwCOVSx0aUTaSBt8U=;
 b=i6pmhnYyT5UDdcZHPuHmZEEGmy5HhBKHsSDpNCLGTkLk3zwKiiSBQVGeJ6Loe2cqTovgyo
 FCN/mKlloAYvQX9EworhfWYIExdZCqvHNKgsfrYqnCaxxJa0/v7uhrTp5Z1yjfAGBNZxGt
 L+RuqW/ESATazIwudfviLchsj8CvBRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-CSZevVxtO1eWCSawhGUkug-1; Fri, 13 Jun 2025 04:58:30 -0400
X-MC-Unique: CSZevVxtO1eWCSawhGUkug-1
X-Mimecast-MFC-AGG-ID: CSZevVxtO1eWCSawhGUkug_1749805109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so9419155e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749805108; x=1750409908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrHs8D/DvcugM9RieliVwYMmaYUwCOVSx0aUTaSBt8U=;
 b=eLps1P2zFsj9BNKv6Vy/aRBnYh/e4i3LqJ7PBQhxUzn8YQp0NemE9iZdr8GglJWj2F
 nSHjrxPbyu2Mv6Vk7ONR1q+KTGC9J6oYnLRpphDFxm19fs0/7xjX2c8S2J2dpc/LCT0R
 qSSBRvz4xd+V8Xalarh9HoqVEXYdMfbNlKzJ7LKXak6quSzXRZaxupE7OVAMcimc0kVp
 FNpOwYi8ZMXXCDWK4heJvYLV/jhLKSJTKSD4PxZmQ8U2Pwlmt8E0DnpljPRJsyJrCOgC
 8Lluiv/4IQPqanuVDMRX27yTFC8+7GV65Es9gHfUgwol/LUTMM4Aaaae3xVfW2Q28DpN
 KJ9g==
X-Gm-Message-State: AOJu0YwUU7ZE0TyHXbVv/eDOYmLwxhySGgGdQVm+ZSowH+C9mcj7uH7k
 JvD2Fe2lQMVZbh/sAnytQqHes4efJ7yAbQdUbdmLKdsZ01hAoesnY+iY2yJFabe6fEKCVGq5gpI
 9ShcJQP2idsPHt6j4zp/maPWIRAiI1Yek31MDPg3YQQ/gPXUfEue3EDQjvwJ6H0g6ES09+FFdNT
 e/9HdVyskkbp/cVvudzv3bWLV2z/zXsv3yR74XKg==
X-Gm-Gg: ASbGncvG0TH/fat1fdmG7dPgQ1XiyN2lnuKIDGq6JbMYpxjd1WkkgmpDiXqYZJYbn5H
 0VPVGfPmFhL504R0Oyhd9K3OTQkLjSw5aggZrsiiRR1tndCr+y1uIybw6+l0KNFLpLRSkdv20/T
 +aEXL+RgGGgQHSNhtnGcik9yRnuUsWZeVLWfAn9pLpJBz2vek9DzRmYpGgRmhn/O2A97MVyEL21
 ZxehNETv1BzfGZycgKzu6GEf2OVSsfaNWnSMsd9Mb0hJRO5Uo8Rp76N009i/U4hImoubXZBVdVj
 tRnyIrFDBKSqoFIyZ2qU34tNzDYyokTof+V2nejCHjizTGg=
X-Received: by 2002:a05:600c:4fd6:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45334ae6432mr22881135e9.16.1749805108139; 
 Fri, 13 Jun 2025 01:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwlz1l9cF1ojiCfhMCUZ+s5OfIaeo1I7gg5Wq4uwoKfEH0XXjUb8cFmSPWzyI/KSIehV7Vsw==
X-Received: by 2002:a05:600c:4fd6:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45334ae6432mr22880685e9.16.1749805107616; 
 Fri, 13 Jun 2025 01:58:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm45961795e9.6.2025.06.13.01.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 01:58:27 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] disk: efi: expose the part_get_gpt_pte() helper function
Date: Fri, 13 Jun 2025 10:57:37 +0200
Message-ID: <20250613085742.796015-3-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613085742.796015-1-javierm@redhat.com>
References: <20250613085742.796015-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4-1R-CtI-6YXFdADPupHlflezihcXg9ehuJQsW_cF1E_1749805109
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This function will be used by the EFI application disk support code
to provide data required by the EFI_PARTITION_INFORMATION_PROTOCOL.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 disk/part_efi.c |  2 +-
 include/part.h  | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index c7d79e253958..9f7907075887 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -216,7 +216,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	return 0;
 }
 
-static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
+int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
diff --git a/include/part.h b/include/part.h
index fcb3c13dea4d..ae36f23e33bb 100644
--- a/include/part.h
+++ b/include/part.h
@@ -628,6 +628,20 @@ int gpt_verify_partitions(struct blk_desc *desc,
  */
 int get_disk_guid(struct blk_desc *desc, char *guid);
 
+/**
+ * part_get_gpt_pte() - Get the GPT partition table entry of a partition
+ *
+ * This function reads the GPT partition table entry (PTE) for a given
+ * block device and partition number.
+ *
+ * @desc:	block device descriptor
+ * @part:	partition number for which to return the PTE
+ * @gpt_e:	GPT partition table entry
+ *
+ * Return:	0 on success, otherwise error
+ */
+int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
+
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-- 
2.49.0

