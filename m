Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13146C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3384984A49;
	Sun, 12 Jul 2026 14:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LBoNKAdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E4B844F6; Sun, 12 Jul 2026 10:50:54 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C514848A1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 10:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c19a37eeaso4410825a12.2
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783846252; x=1784451052; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hrp2nEmTYiRjMz5C8HP5bcSn3U5cDVS1S5+eYXCPJHQ=;
 b=LBoNKAdmXQXZIRVQYtDYSSZethUcmjNKFHfjOkGRPNSm2mGl4vOJBhrZ0JaDIj9Q00
 HOroDWITtPoTzIVMjr39qtTxeVfrCUQ3mO16HeXvL25UizfwU7/Uu8EFv6j8raNRi5aF
 UuKL5/SQiv9y7VyaI6CpxD835AzqEJxRr3IINoevdEosYUruBa6VzVOokrZHNuwjZX3L
 9MuwNB1IRsPsxUbGoQzQdrHNOXRXVWihCNUkOuRvWvumvn1ocJ6fkIKBe6v5dlTpr7f6
 Ad5WOzDsnOh+3j4qahBBfJaiTXFWoyKrAoml0XXVhzl/jZmiX7WJknhXk+j16akhWbar
 Ym2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783846252; x=1784451052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hrp2nEmTYiRjMz5C8HP5bcSn3U5cDVS1S5+eYXCPJHQ=;
 b=PIybjT2pwQ/6MyHFGIQqgA0x8D3fNjwuE8osN43RdTxqKQ4nqC5RBh/Qo2bDOYeTo9
 EduN3Fy2fjBiGbF9xfnxVQ1UpnF6I132DX2g49iE6uHRuQFyNkuhsGVqS6OuDHkEfniu
 yptmj5Fu4reEPPMdMsxgJvd9huIMkGe+D1mZmTGa2x4ZBZDQaPDGP/nmow6KkWxxAABc
 TMDwrpSGmAtIyfjo1R8yuDb4LbLgGzk5vkXqKIdgCcvvd5r1MgaRrG7OFudajo3EDxIH
 KOubtW9/y82bZ1KXtsJ9Jkhjb6VP28wsBJGWN4wUpgKJrU7Gn7pzSW1d9yqgVFZvCkez
 116g==
X-Gm-Message-State: AOJu0Yxdc7XfyKWLhEP1dIkFltzBHyExGvNkWtFHCJpiTIzJuPNcdX6c
 JpKs1t+S+7/1DYE8c+UGIYKELY5ANLPRmvIRp6ngAuRamLXZupTORSrm
X-Gm-Gg: AfdE7clSlQACm5cbOqxOuV/LhH7aJmiXSzMi9Kc70UE7O5x932fnA7V0OFasch8Ggz8
 0R0+FkZA1xyH9WmAxe56xIMCjFHqCRxhJBmZPOBdLQGXB56QL0c1VxKH58ce/M+np30kX9oWXiF
 4E8LC4yjoB2oPG7QFtnmj3DGF5KNzdhKoifo8HeoE+7dXgmZQRTAPQC+r+RrM2M8RlO0SpPi9Js
 Sc8Gnc9HA/T6MIdXrBVR9C9s2RwFvbWFCjDoff2qUc6a3leqdtiCz8heAXQVSJVLHO7KkL/kTOG
 CSLYfibPT4bxgK6hSdBL1lJJAczfmQ4zGUGDzohvOLi04B8kgfAt6C/lq68LYh4laQ8pkf8/mfv
 LLt+989WpEajemXyWqlBZVyn77/DgvnSfLhI8A/VVLRQQYx2o7TFDVuEkll5B7jroU0PFGQtJ9Y
 4JBgkwxToX5LlkSpXRzup6ND9nhq9s9EpjOke7BJCH7YToQ1pde/b0fL6yLS4LO2rb1FsdCmuIQ
 VVfNmP/
X-Received: by 2002:a17:907:f818:b0:c15:cac2:1ec4 with SMTP id
 a640c23a62f3a-c161e870837mr224971566b.1.1783846251800; 
 Sun, 12 Jul 2026 01:50:51 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15de6c565fsm525483966b.2.2026.07.12.01.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 01:50:51 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 12 Jul 2026 10:50:21 +0200
Subject: [PATCH 2/2] avb: free mmc_part allocated by get_partition()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-avb-fix-memory-leaks-v1-2-51d6d5a42631@gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 12 Jul 2026 14:44:41 +0200
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

get_partition() returns a malloc()'d struct mmc_part and only frees it on
its own internal error path. None of its callers - mmc_byte_io(),
get_unique_guid_for_partition() and get_size_of_partition() - free the
returned pointer, so every partition access leaks one struct mmc_part.
A single "avb verify" issues many such accesses (footer, vbmeta and the
hashed image chunks), so the leak accumulates quickly.

Free the descriptor in all three callers. mmc_byte_io() is reworked to
use a single exit path so the partition is released on every return.

Fixes: 3af30e4443aa ("avb2.0: implement AVB ops")
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 common/avb_verify.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 29a3272579c..76c523fd0ba 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -452,6 +452,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	u64 start_offset, start_sector, sectors, residue;
 	u8 *tmp_buf;
 	size_t io_cnt = 0;
+	AvbIOResult io_ret = AVB_IO_RESULT_OK;
 
 	if (!partition || !buffer || io_type > IO_WRITE)
 		return AVB_IO_RESULT_ERROR_IO;
@@ -460,8 +461,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	if (!part)
 		return AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION;
 
-	if (!part->info.blksz)
-		return AVB_IO_RESULT_ERROR_IO;
+	if (!part->info.blksz) {
+		io_ret = AVB_IO_RESULT_ERROR_IO;
+		goto out;
+	}
 
 	start_offset = calc_offset(part, offset);
 	while (num_bytes) {
@@ -489,7 +492,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
-					return AVB_IO_RESULT_ERROR_IO;
+					io_ret = AVB_IO_RESULT_ERROR_IO;
+					goto out;
 				}
 				/*
 				 * if this is not aligned at sector start,
@@ -506,7 +510,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
-					return AVB_IO_RESULT_ERROR_IO;
+					io_ret = AVB_IO_RESULT_ERROR_IO;
+					goto out;
 				}
 				memcpy((void *)tmp_buf +
 					start_offset % part->info.blksz,
@@ -517,7 +522,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				if (ret != 1) {
 					printf("%s: write error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
-					return AVB_IO_RESULT_ERROR_IO;
+					io_ret = AVB_IO_RESULT_ERROR_IO;
+					goto out;
 				}
 			}
 
@@ -543,7 +549,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 
 			if (!ret) {
 				printf("%s: sector read error\n", __func__);
-				return AVB_IO_RESULT_ERROR_IO;
+				io_ret = AVB_IO_RESULT_ERROR_IO;
+				goto out;
 			}
 
 			io_cnt += ret * part->info.blksz;
@@ -557,7 +564,9 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	if (io_type == IO_READ && out_num_read)
 		*out_num_read = io_cnt;
 
-	return AVB_IO_RESULT_OK;
+out:
+	free(part);
+	return io_ret;
 }
 
 /**
@@ -867,12 +876,15 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
 		return AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION;
 
 	uuid_size = sizeof(part->info.uuid);
-	if (uuid_size > guid_buf_size)
+	if (uuid_size > guid_buf_size) {
+		free(part);
 		return AVB_IO_RESULT_ERROR_IO;
+	}
 
 	memcpy(guid_buf, part->info.uuid, uuid_size);
 	guid_buf[uuid_size - 1] = 0;
 
+	free(part);
 	return AVB_IO_RESULT_OK;
 }
 
@@ -903,6 +915,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
 		return AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION;
 
 	*out_size_num_bytes = part->info.blksz * part->info.size;
+	free(part);
 
 	return AVB_IO_RESULT_OK;
 }

-- 
2.53.0

