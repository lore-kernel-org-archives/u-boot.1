Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACB5EEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7A983E23;
	Thu, 12 Feb 2026 21:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CXh1R16n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25BE383DCA; Thu, 12 Feb 2026 21:45:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAD383E0E
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNjQvj1OQyXmpQck0MdOvmZkbrrtxuGX+BU9idYKd1w=;
 b=CXh1R16nLtuvQM4hrBIxjhSHIyoL+FE+c0pSw99A6IXlI6xmOuQW9KoKDT9CxbM2o6l64i
 Lld3X+nt3JiIYD6BZ2S8YypCfFIzLQigemEh0BLeTQZcyO5OfD5E2SudI12AeMdoiBNHok
 QVkd2nQGhdXlUG0Ng4359SXSndFIUQY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-QlI7NAj-NfijxFR_h3kSLw-1; Thu, 12 Feb 2026 15:45:30 -0500
X-MC-Unique: QlI7NAj-NfijxFR_h3kSLw-1
X-Mimecast-MFC-AGG-ID: QlI7NAj-NfijxFR_h3kSLw_1770929129
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so1508575e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929129; x=1771533929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNjQvj1OQyXmpQck0MdOvmZkbrrtxuGX+BU9idYKd1w=;
 b=llcDwYegjoIEhn6PZnNJcdvuwebTuLH2QMwq8O3yUaL0cMKevQMQUxVBuZQAWK94IL
 XzQXGWudh1uJkKFwaa4/Mc5Tb27C1FnyRyLsLdyra+3pVC2/RPHx8CSfAyoxJEWDj29f
 AoP64ikpFEfJqx7pS6GXpxNv33o/aTpU6csxwxwcgm24uhnMW12CltxnRqRvfTPkoI7g
 IEOwVHbkXzScshhFRsrvj1KMBODo0sUXpKVUkkTzYF+J8Eht5wuEfx2W/YRA/YE6N/3M
 4jpK7jRRSctl4kbkU4xj6GqrOz8w/s5pBh4W+ub+7LCaBvYXnXwju5n11WHK90Rztp8y
 aB8w==
X-Gm-Message-State: AOJu0Yx3ZBOu12CkiWurvKY9fl93bNeUIvbPsQmCpE3b7MxLUfLQ1PUu
 yItOTwCveeMk3qyPFi4epHE1jfG4mdbirwxzjYQGLwPS2zcotpdWiEbBW9qBS5dq0m61pbF8LQj
 nIodT1ebZL2GQm+6qvVd58otQRnlhQsKQ8gf/OBT/ijwa3Rx8lWe5p4AsGXEgnGRt5qVMYCX5dj
 jvFUA5HJHIcHBJB0NM7s6HhL30fEKmpyq93tKIzQ==
X-Gm-Gg: AZuq6aKhKITvZU6/PVQqTrBpXNKigbnRw2yx1L7X49i14AUzii76qmgVxmhwRaZyj0W
 l98JiHxoPKCAFnd9v/g83awH/o1zF++zgoRnhiK1ffrfpiRKimHo88HpJ5yS5RFHVsfqe7v0nhc
 O9nU2g7wy72tL/zah9GtWej6kCRaJr2/3xtqPer4NSa7WkrjsZd8DCKoee8JacZFAyqxEFDAF9D
 /kUPpxG17Y5KwwLwMR1X7Lqr0NAgBvrIqFXXE1crXIHDZT3mor5V3pg0h6bJpucD7c5TDFUE8U2
 qSmMEJXLjsniInklMOeHzNafr/a3we6fYBXUWndJB2IQdVRyt7n2082dsNerHw4c1iqI0ohL9/0
 PFpxmC4y7zqUNKGSBX7tVGe+rQavVb7EOEcTS1olKUMOdJdw=
X-Received: by 2002:a05:600c:1e24:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4837103de29mr6040675e9.20.1770929128770; 
 Thu, 12 Feb 2026 12:45:28 -0800 (PST)
X-Received: by 2002:a05:600c:1e24:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4837103de29mr6040365e9.20.1770929128288; 
 Thu, 12 Feb 2026 12:45:28 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a49dc7sm790085e9.31.2026.02.12.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:27 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/7] efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL
 to support MBR
Date: Thu, 12 Feb 2026 21:45:00 +0100
Message-ID: <20260212204511.619392-7-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: We4wNEbtQuTUTq6Fkgi3HWr3Fx0Twiws4fhF79FLAjg_1770929129
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

The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
partitions. The UEFI specification mentions that both GPT and MBR
partition schemes are supported, but the U-Boot implementation only
supports the former.

This can cause compatibility issues for platforms whose boot ROM only
supports MBR. This change adds support for MBR partition tables to
the protocol, making U-Boot compatible with systems that require a
legacy MBR table.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 lib/efi_loader/efi_disk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 130c4db9606f..f8a57539ec61 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -475,9 +475,12 @@ static efi_status_t efi_disk_add_dev(
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 		case PART_TYPE_DOS:
 			info->type = PARTITION_TYPE_MBR;
-
-			/* TODO: implement support for MBR partition types */
-			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
+			ret = part_get_mbr(desc, part, &info->info.mbr);
+			if (ret) {
+				log_debug("get MBR for part %d failed %ld\n",
+					  part, ret);
+				goto error;
+			}
 			break;
 #endif
 		default:
-- 
2.53.0

