Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8F0C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 08:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6A882D06;
	Thu, 19 Jun 2025 10:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BHOgE/1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52CB82CDF; Thu, 19 Jun 2025 10:34:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8C982CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750322063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFAvFoXqprm5W5zyzbPI3ZcmYyLib0iMp9SCUQo7PYQ=;
 b=BHOgE/1jadoLzLGJgxBO4q+7DoSNKO3tv9sfvhoT5hTb90ISZvA4m6F6qBnyxZnuRacrcE
 r3Kf6grAIW0oMTEIm/xgicA+ghKWbNMA0TrNjESgLaEy7fpAC18viLwPRtlWvn2zaqJXOD
 /qvYEOugS+k5fB9aVB/rrzZYGSgnXVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-oO0wayThPOWGnOxHUH7GXw-1; Thu, 19 Jun 2025 04:34:22 -0400
X-MC-Unique: oO0wayThPOWGnOxHUH7GXw-1
X-Mimecast-MFC-AGG-ID: oO0wayThPOWGnOxHUH7GXw_1750322061
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so2968725e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322060; x=1750926860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFAvFoXqprm5W5zyzbPI3ZcmYyLib0iMp9SCUQo7PYQ=;
 b=iWbFipBYDqfmzZv/W8nit7A+s0es2nsb8FQ7e945s9THRvKL0uB9CkeFXAnRqcG663
 yxWBude5gUVjVpuxTq9JyQSAmBXxnl5NDndy9Fks0y4cfW7ZaTZUn6P4BuPYbxkjrzYP
 JXPvKbTiBQn9LNtme24oeEwd6//j3YCBFcdNECnX3p1SZH67yczR96mOVQGtgw6JvgAU
 LlfuatbCDzhuOmpxVMmsoIItJH7DiJHRArZtfE8CQgkpj0ZVfPnYm1Iex6P9RJU2MvQn
 3fEIugiNX9re/V8FsO7YPeefEDTpOe3C4/jTAtr36rDQzuNXu9t71YvZ/F5QV5S6wHm5
 JsVw==
X-Gm-Message-State: AOJu0YySo8HtAsuAX+2LeA0JOqfMCCCf7R+YUMi3clbC9X8q6kvmnpfO
 HZQJcPqVJYYYATvye9fzq6V12NEhNhFBybzxMEzveyf6HRs6F0sstWkyg8GxjwXhTxvuGQbRmmN
 gEcdv7pTHIGdyP5A30AYcDWmOErqQX7KZGnouYcur1/GAqyWfFbIIRRuSyviyc/xWTazTFf9H5v
 LhvIb9ngaGfQu1ERZsU+DpHevBHud3wZuvlTtzEA==
X-Gm-Gg: ASbGncuNM3g7AtlenvG/uM+lQ3iAAxKROptZo86ZE368B0CB2eE6wCLg2BaSneLu86X
 GdP8JYYwEqAd43vsHy+Wn/3bwUyRmqKpxsBeG2hp96GC15HdZya/Tykv9w4NAEj4Sx+m4w2p+SJ
 UukLLFdOGxqmZC6O+tnEJH175VF25Xzz35/1haIGn7+kAAjAgIr/C8r4p20J9a7iSa3icjEksUe
 ypdSHW4bPq1QTR7oxUUJwvTGuxF1NS4TkQgqwzdUBrQDi1bwoCQxQdZEoTxwfSMxj0uIlH3eWVs
 Wmh5g1/Fre9L6F/+a1b4NK+g+HTA55ol502Rs0w5n6C0aPu2nCOx
X-Received: by 2002:a05:600c:1e28:b0:442:ffa6:d07e with SMTP id
 5b1f17b1804b1-4533ca46742mr165210555e9.1.1750322060520; 
 Thu, 19 Jun 2025 01:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH5dvHP9pgU5CWnF3igdZoxqAdlfpwKmDKpMTqzrjzHP3KBUtJJYzgsu5cADR1ULmt9CNULA==
X-Received: by 2002:a05:600c:1e28:b0:442:ffa6:d07e with SMTP id
 5b1f17b1804b1-4533ca46742mr165210105e9.1.1750322060108; 
 Thu, 19 Jun 2025 01:34:20 -0700 (PDT)
Received: from localhost (35.pool90-77-212.dynamic.orange.es. [90.77.212.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97a908sm21033595e9.4.2025.06.19.01.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 01:34:19 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mripard@redhat.com, mskrivan@redhat.com, Tom Rini <trini@konsulko.com>,
 eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 alexl@redhat.com, mkorpers@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 2/4] disk: efi: expose the part_get_gpt_pte() helper
 function
Date: Thu, 19 Jun 2025 10:34:00 +0200
Message-ID: <20250619083411.2214491-3-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619083411.2214491-1-javierm@redhat.com>
References: <20250619083411.2214491-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6R_BnzXMSbESrBr6SVJHtbeLnqb7FxhOgDMlrFOffFE_1750322061
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
index d0b1f96adff2..fb1ed534f861 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -215,7 +215,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	return 0;
 }
 
-static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
+int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
diff --git a/include/part.h b/include/part.h
index 7075b2cb1164..b3a3362b2af2 100644
--- a/include/part.h
+++ b/include/part.h
@@ -647,6 +647,20 @@ int gpt_verify_partitions(struct blk_desc *desc,
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

