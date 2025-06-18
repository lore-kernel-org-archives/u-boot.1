Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57072C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E16482D21;
	Wed, 18 Jun 2025 10:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IiLImgUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67C982C55; Wed, 18 Jun 2025 10:01:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B34882CD5
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750233670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72rclahfRVHmBA+LNrvhUeOaGKWs5CN0pLgB149oawU=;
 b=IiLImgUg8Toz03Mx8HNveO7cMqKS006G6N82rTdyelRZe1d7FMshgSX6CcLSHP1chFQbQG
 TKnKiJZPe85qX0EsbFr69O/tXahe9ETSeerJWNQQbZ6OkG7wmEMNLNypNlcN3JQTg1cgRw
 tSR3QvtGrhlfvKU2sm+nczeKamVHLeM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-ynvV8AAlO16palyEtExWFQ-1; Wed, 18 Jun 2025 04:01:09 -0400
X-MC-Unique: ynvV8AAlO16palyEtExWFQ-1
X-Mimecast-MFC-AGG-ID: ynvV8AAlO16palyEtExWFQ_1750233668
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so3360788f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750233667; x=1750838467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72rclahfRVHmBA+LNrvhUeOaGKWs5CN0pLgB149oawU=;
 b=hxgMaqrXGVMVZpiqPoPPMJUrblnXhEfz3wyCPRqhTUYiAiyVsl9UFuYkk+wHBGpF8t
 Sd8MGPFtEFUIvzWLginwRGXSzTb0iCVusUmJij0wGRJgUUwNcp9/Wc8NWJ2Umq3/W5z7
 2SI6snMTI9Yt1eMDq0c4eZ4j9ecYUAUJ5jXCDRtnF1gDhqxqvTZn+wxMahn+9jwcyCCa
 2tlEPT8Nu0e14tVOdyf2NMpzHwT2+6kggzgykQCEMaX1DmePH4i7yn6NQr5FU4lfn4Ne
 x30+6bLsuubC/Ptft2ELHXj0ZHj6Eg7ng6Oi0W+rUSk3QOnB8OQPTqm5T6xfz84Be4vz
 1nag==
X-Gm-Message-State: AOJu0YzcreXe8QJ5N/JWJusZZYTYaY9s3no5qAY7wx1Q01G+i5XMQMre
 lcZUMiKfdlusTjOnh+GjSsE/SOSap2WQx68RiRYsKy/49lY2DyOVdxXd7+Q9KDKwm4IVEQzjoIA
 H32CmigxUiwGYVAUWOa0STlAmDx3bgcqQQofXs5aJsvzCD6bgHY9hpQ8DfcVSdjFVe8hRqd2njQ
 Xk5rFhX3+aiM60TA1Bva68dJXfA/0Qnu9Z3WCbdw==
X-Gm-Gg: ASbGncvL06CJi59vitkx/2mDRIs8WQiH92cCp1IfUfekjPKLOlchN6sHzFMk0Zi5rFK
 5AQZEsCF6lWmgu4JGu6ErYAV/JX+NoT9h9QWpfME1Mjjbg+DClHe0FWkgQDEWRAXUXxwx0ojetm
 dU3UMwBJGBkWlXszbgH7yORum+8EJ0DvFcmbCeFC6RsG3VrVhnFf14eTrS+Ggjcr7yB4KRqe8U3
 i/u67vUDteASlSG5LKLSHl/6jnVtgJrmi9JjPd3Enr+N1ONvtvLlRTv6RKG1+JdZ/Ksqpbo3K8P
 pmpu9VGFEz4FoX1yzCGMWORN6Q2Bs6+vTRDFrerTOSAN5Gc=
X-Received: by 2002:a05:6000:18af:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3a572367e04mr14372168f8f.2.1750233667354; 
 Wed, 18 Jun 2025 01:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELUoctWIHcbt/pQc+LdRsp6UusiPUZV1pNSH1jH0EJ75qtyuLMUd+1CXzhjKHjGWfKMkKXiQ==
X-Received: by 2002:a05:6000:18af:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3a572367e04mr14372097f8f.2.1750233666649; 
 Wed, 18 Jun 2025 01:01:06 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2ca65sm16265338f8f.77.2025.06.18.01.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 01:01:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mripard@redhat.com,
 Tom Rini <trini@konsulko.com>, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 2/4] disk: efi: expose the part_get_gpt_pte() helper
 function
Date: Wed, 18 Jun 2025 10:00:36 +0200
Message-ID: <20250618080056.1973311-3-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618080056.1973311-1-javierm@redhat.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _w-Jvn4WSMfKKU9uD2gXGFo-KarbxmAvd0SU7kNySjY_1750233668
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

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

