Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12768C61DE1
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 08:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA43780C77;
	Sun, 30 Aug 2026 08:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bliQ74BG-EaV; Sun, 30 Aug 2026 08:44:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788079454;
	bh=GSSyeiyS7KvHSqYWD5KQ21xWyW4fUUZDyTZ+RVWYh98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=csjlSC2fkt2hTuLQgBn49Vn/k9ZpIr3ezwDdQEHAQZWCuLzson7+h0vkmjPVQCS3k
	 zV1BAml22zDxVbEE+aSwq3005dYO9F0vPudzoBRMqG3kzMTAk3esvLkbw/2wlPOeFQ
	 mwyp7GE7OT5yKj04Ck4J+y54MTnhMZYeMV1Y3UuN8JLcGFNUeGZWPM1zqO5492GEYw
	 xa0StszDZMfJ2D4aKItqaLWexoZASmpwUpLhIi84KQTVlAvlXBWg+QJ+AleXunEZwK
	 CpUQFjBcrjaa9cg/7uE1nzToTt/yyGcvVdqFkgWWHKk57B9vwYb58arifRfkxSIRLB
	 K0+7cdmvsc5IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E43EF80C95;
	Sun, 30 Aug 2026 08:44:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BFFD334
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DEB480C95
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewfZvCLFsIOv for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 08:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=su46L6wT
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BEDA80C77
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:07 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 93718430A8; 
 Sun, 30 Aug 2026 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788079445;
 bh=GSSyeiyS7KvHSqYWD5KQ21xWyW4fUUZDyTZ+RVWYh98=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=su46L6wTGq91+aqqA5D1UmzOLtQaTzp7yA2ZvOVZPrBjZ/XHhSHo/QveU91kzc8rB
 zzgZsYpGI4+hNQA93fbzki06tr04lmXnzrcYVe48d4+RI1ZTNRR8VGr3D/mFg+pg6Q
 Hqw4Qaq6QMQ0C1ZQm6gkgCZbj9ksJrRTRs2ju+WFuEKj/rO1HjUwnwkRjFN5bzRJam
 Oufhy+nVcsmZroKCb2Zpi8LqgNzEZC2Ok5za/FOOCTQVtc+5oRD7UHZ0VAFatIpd3R
 nXP9EswpMQHED7s6B8KzVWbvFjuUqh4yGgsy3+CtrKqUWBC3MPn8yDmmlo7oVeQJGA
 /KGo4rrUstyTHJThgd6lCNmRcCckICZn+jJpbB50JxJMb/+IztCLtTN0lOXWtRaRAP
 F/lC+uwBbY3oqR0G0RHXsCqtc5YMnEkTUeaRxn5OrOjkqDWPUEidb8xWa2idr05STw
 aok3iuc7/aJ+u1HXg0TbpM1w7gtsnKgtyyiI36e0xsHoXqrQAswEVbbPIjFgMwJHmN
 BaeuIqvfMBq9yUlIDDoXMrLJMjecTieitNRKZlEA7XM0ut2Qs5YQsknk5TB0fmhwzf
 +Ca4Ws6Dy+NiSQkHzAYUlN8VCXwPR1ZtamsrTMxM4cevurggVIBqrNkx32brXltCfu
 UonBu9AvpYjXX0LRM8wyJtFU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] efi_loader: consider type of platform_get_rng_device()
 return value
Date: Sun, 30 Aug 2026 10:44:00 +0200
Message-ID: <20260830084400.250238-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
References: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The return value of platform_get_rng_device() is efi_status_t.
It does not fit into an integer variable ret. Use variable status.

The RNG device was available when registering the protocol. When it is no
longer available in GetRng(), this is a device error and not an unsupported
algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
return value of GetRng().

Addresses-Coverity-ID: 532068 Overflowed constant
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	keep the EFI_PRINT() debug message
---
 lib/efi_loader/efi_rng.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index e920eec9d7b..3a831e2232b 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -103,7 +103,7 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
 				  uint8_t *rng_value)
 {
 	int ret;
-	efi_status_t status = EFI_SUCCESS;
+	efi_status_t status;
 	struct udevice *dev;
 	const efi_guid_t rng_raw_guid = EFI_RNG_ALGORITHM_RAW;
 
@@ -123,10 +123,9 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
 		}
 	}
 
-	ret = platform_get_rng_device(&dev);
-	if (ret != EFI_SUCCESS) {
+	status = platform_get_rng_device(&dev);
+	if (status != EFI_SUCCESS) {
 		EFI_PRINT("Rng device not found\n");
-		status = EFI_UNSUPPORTED;
 		goto back;
 	}
 
-- 
2.53.0

