Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60776606A327
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pQ3F/qG7;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=KWNaCZxE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35D6A6079F;
	Sun, 15 Nov 2026 16:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1L7zZVUKvGmu; Sun, 15 Nov 2026 16:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87A9360748
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794758568;
	b=EylX6KsegVvaz1PWJ0RhzPIcJAs2M1eVPSTzix7gaZAMq1Yn+ezBQl0FhGCMayT2Bis7
	 rX8CMQhKf2923+Zh9GYyK4/fcC6cHxlj76qVeBpr90HXV4GvVBgXT+fnQjweleu32HHBZ
	 OZNa26IK11vORUZ0D+c2fXgsB3ORlUX2dLtkmirBmRpUDSX35hrbXtZzF5n0MbJBn5IIL
	 h5G8OeeO9QMGC+BggHaopjKxLUNJgMRn9QkVRzagM24yZMRioGrvh7jDdGdMDHz0kVYIu
	 2yBO3qaPIcD4Q6ickH33eyTrkTbP2j4Uxql5J2WOXN6V9tLryUqYswljZJ9tShvhe4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794758568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9YAflZdv2sN+MsnodwPi+rOemCv8xpLsSu1bVrTIofA=;
	b=An19oOzWOZ4TsHiQ9GzA22j7iQxVgpmv3CCHxBYSIM8nea8KPP7E57bC5Sl3BIxQv6Ot
	 AGvvCLuM7e4jimx5XGo+chMthBnUIjhwuNeu8VfcSwacrx1pk6DCxr8tnUik3Xd2lb56T
	 aCgzea7M2kJxN2mMCgkdECMMUej6S/H7yfWGunmG/M5TL1goZyRzID6X7PogspsBejB1S
	 /FcYE86MpakumageSsyn/WeKLA9wPyblWLWCKjdERh885+oHiU/T2EdDGPO2YjbQv/aov
	 5/rlPi8FrpceQqd1lo+Z0byVZHq+89npLs5zmF6AonkImOjIQYXS04PcKYMy1TxMt3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794758568;
	bh=9YAflZdv2sN+MsnodwPi+rOemCv8xpLsSu1bVrTIofA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pQ3F/qG74bzOhoks7cWH+4PTN3uRvR0Rl2LvcGjJOLoLbTdYaXxlCnsm/IcnmZx2J
	 tFwuV2QW046gsvoxuDIHJ3OF0585aTTDRSsJfVxrkvZPsu7QF9mZB0VsWr7ViQpEQ6
	 TF+gXgYzdEl6fb71n7P1JHjAgByX203D3pUZqfmg1EY5LtvS2KezozQecwi8FyPTXR
	 poTDEJ2UTThZHimDEgYJIaaJLG82stZNRETxzidznksM5i1uoYb3GqE3UX3y7Onj8l
	 EEXCkwcO/XaadAwgadYcMiNt5B3PXnC9iRagA0t7QS/WOMAVK591Of86X2jA7ayWgZ
	 ok/8PXbxRWRBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87A9360748;
	Sun, 15 Nov 2026 16:02:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A5B31E7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2094C40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7hD3EfgwnCA for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 14:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E318F40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=KWNaCZxE
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E318F40050
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:59 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 844203F846
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794753117;
 bh=9YAflZdv2sN+MsnodwPi+rOemCv8xpLsSu1bVrTIofA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KWNaCZxE331STDxa/DvtlbRmG3uN3Yp7JYmqfI8aXBMP32EInsxnybYCCfHGqFzJF
 JHFVM9twd47ifQSo2qv5bFvFug/CbC6pfOKh20KywzrLNDeONUoDoMEruC2qvopAxY
 rt39A6z/LX8UaJvl6WdVJRAdV+1SgLisqBw4rI6syNK/hOsGdxoyd6KIVA+vASWCHv
 DCICofgKusLXeR5SE1qkqsDfMudab7BdVa0BKGsCsYID1BPZoRYmpQUzGLsMhPzI3s
 pZTXtsQAqmbOy+21SvKR4WjjbWGYEGNqKBLyYm2rs/SDJfveaLSEkk58XTecayMNM1
 b8aZ5NembECk1u9csHlfOfS3wVhYY0uoOv6ltS6750euhzZVZKzKIRzAiF1vnxdzbK
 2wKUg2zNBntx+bwiALYEKPs3KbAK0sPR0yY4GmUwehAy1qteLLxTXPOLdPG1Xx+J53
 iisGo6kGi5W+ECiwIu9RHaMH6ANsEr7xh8nfuAxXYwwhbhGmtWOT6XglDIy+oImrM7
 k+ftCgQsgs1n2q3OcVZuAAAz8E0BMgEku2VNs1abEp11GaRHObylD8d5LpNOIKrgb9
 zYuUuhTcc3Hx7aaBakW1h+zu7ULsOYGfqXXVIhbw3EY59vYBz6Uy1SuPi0d3Wx5BOy
 4BjrYEcAeTgEta1UsO07flOw=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ae6fda7a00so2370105a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794753116; x=1795357916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9YAflZdv2sN+MsnodwPi+rOemCv8xpLsSu1bVrTIofA=;
 b=1ECqL9EOz8nBFLXBgNsGfcKn0wJhTcWW6wGXNNamse3VoOeMiIpZtlo5TChSVZt3AB
 qTFnPC5biKD5SBZBJ+dtrbYRlxgLcmtIWqdy421sFOxPxV3MFVHbg7wdqZZMFX76Djue
 YJZTMQ3ULKhDX9weDM0JWNhTCfXBnNJyqPR1wNF0fJLroC04EnLF7NRyFTYJBX999eag
 UD6UCTPnRdyHTzLj//yrgGi5cW2NRatNApfgT2kt244H97JGjICTpATVKI+nZFSiQ/OL
 +xJ2BxRSKwRCwR0BvCVu/snT/0jT1VTTwQ5AhdSIs6h3XfJRjh03udbDlI1eMQoIIFsl
 uBLw==
X-Gm-Message-State: APuU4Z9aREZuqHEIn/UrVqDo9ccGORa3AaVHy/vj6I4ZjZJrki9DKC6A
 4QjCIuWwvnbYXt5TQYa79LglSU1dfTp8DGtO+KOkTU1wAJ3YrD/D+Pl+T5/FeC6OthnrEN/UYvg
 zgAYoBaS8emLVEhpqQIm4Lmm1nfn53iaA6Y/GGO03QbOsTbtehLHdIjzdZSTBEt9UPW1RCEVgN7
 ysS25lwKFNPklBHPkW+Q==
X-Gm-Gg: AYBFou1/O61RzrjWlcA2ew9SSFD3/LJiKz+/v66oOBqVm/nv3Y+C68HuK6FDin+zILZ
 e//fCY8Z6yhy9r/hC41s+Wc9gZQmEBMAP2+K2P3VJCTnV5In9LAPOp/d0keRMCDs4j3LYJH2b6i
 htDrOky7Kk8tb1KK1wDhuBGyvey2085hysVQCaHcWsCiej9s1qHvLshbwDhVoBbmOU9RsJgdr/9
 sog2MhgvRws2yKskOfbUUIq5RrHmR1LsIFy53Y/lFZrNWvqfHEjQXCzYyqWXRR7Q3/GqGpCdbUK
 2OnJhaMZRb9dF1q2EhCuZnSNzoK1a5RvaFoKjQ/p/W9rc7cdcUQaIEY/pp0oCu5+f/uRpI18N9h
 yVWt+WhRdFT5Tt68vuZtRQx/GKQ+/35CBp4NIRUQyLUZSp06SKBUj0ry4d5E/dJRm5w+dRXwCeb
 lvCSwxLa/7uS7XxcbYmePesso0wfaj007IZLk0fGcgXhY=
X-Received: by 2002:a17:90b:2712:b0:3ab:b39f:41da with SMTP id
 98e67ed59e1d1-3b1b09f9c3dmr7188410a91.11.1794753115801; 
 Sun, 15 Nov 2026 06:31:55 -0800 (PST)
X-Received: by 2002:a17:90b:2712:b0:3ab:b39f:41da with SMTP id
 98e67ed59e1d1-3b1b09f9c3dmr7188390a91.11.1794753115365; 
 Sun, 15 Nov 2026 06:31:55 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1bfb607e7sm4297670a91.3.2026.11.15.06.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:31:53 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] boot: fit: bound the external data size on the
 imagemap storage path
Date: Sun, 15 Nov 2026 14:31:13 +0000
Message-ID: <20261115143134.25791-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143134.25791-1-aristo.chen@canonical.com>
References: <20261115143134.25791-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Nov 2026 16:02:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fit_image_load_storage() loads an external-data sub-image by reading it
from the storage device with a transfer sized from the FIT data-size
property. That property is listed in exc_prop[] in boot/image-fit-sig.c,
so it is excluded from the configuration signature and stays under the
control of anyone able to modify the boot medium even when FIT_SIGNATURE
is enabled. The read happens before fit_image_select() checks the image
hash, and for an uncompressed image it goes straight to the load address,
so an inflated data-size overruns the destination before the corruption
can be detected.

Reject an image whose data-size exceeds CONFIG_SYS_BOOTM_LEN before the
read is issued, the same bound load_simple_fit() applies on the SPL path
in commit 8f71d7170f5c ("spl: fit: bound the external data size before
reading it"), and print a message that names the option so that a real
image which trips the limit can be diagnosed.

This is partial hardening, not a complete fix. CONFIG_SYS_BOOTM_LEN is a
conservative ceiling rather than a tight bound on the destination: an
inflated size at or below it is still written to the load address, and
the image hash only rejects the image after that. What the ceiling
removes is the much larger overrun that was possible until now, when the
only limits were the 32-bit data-size itself and the end of the
partition.

The ceiling is also a new limit. In full U-Boot CONFIG_SYS_BOOTM_LEN has
so far only been the default limit bootm applies when it decompresses or
moves the OS image. On the imagemap storage path it now applies to every
external-data sub-image that is read into RAM, ramdisks and loadables
included, so one larger than that can no longer be loaded this way. A
filesystem image that is left on storage for dm-verity is not read and
is not affected. Mention the new use in the help text of the option.

CONFIG_SYS_BOOTM_LEN is only offered when a boot command or a legacy
image format is enabled, none of which IMAGEMAP selects, so make it
depend on IMAGEMAP as well. Without that an IMAGEMAP build that enables
none of them would reference an undefined macro here.

Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
Addresses-Coverity-ID: CID 661899: Insecure data handling (TAINTED_SCALAR)
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/Kconfig     |  5 ++++-
 boot/image-fit.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8c9ddc2ef1d..e2fe399a51b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1178,7 +1178,7 @@ endif # MEASURED_BOOT
 config SYS_BOOTM_LEN
 	hex "Maximum size of a decompressed OS image"
 	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
-		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
+		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT || IMAGEMAP
 	default 0x8000000 if PPC || ARM64 || RISCV
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
 	default 0x800000
@@ -1186,6 +1186,9 @@ config SYS_BOOTM_LEN
 	  This is the maximum size of the buffer that is used to decompress the OS
 	  image in to if attempting to boot a compressed image.
 
+	  With IMAGEMAP it is also the maximum size of an external-data FIT
+	  sub-image that can be read from storage.
+
 config SUPPORT_RAW_INITRD
 	bool "Enable raw initrd images"
 	help
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 75d0f3f72d8..228d5be49c2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2305,6 +2305,26 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	if (fit_image_get_data_size(fit, noffset, &data_sz))
 		return 0;
 
+	/*
+	 * data-size is excluded from the configuration signature (it is in
+	 * exc_prop[] in boot/image-fit-sig.c), so it stays attacker controlled
+	 * even after fit_config_verify() succeeds.  The payload is read below,
+	 * for an uncompressed image straight to its load address, before
+	 * fit_image_select() checks the hash, so an inflated data-size overruns
+	 * the destination before the corruption can be detected.  Reject an
+	 * implausibly large size here, as load_simple_fit() does on the SPL
+	 * path.
+	 *
+	 * CONFIG_SYS_BOOTM_LEN is a conservative ceiling, not a tight bound on
+	 * the destination: an inflated size at or below it is still written
+	 * before the hash check rejects the image.
+	 */
+	if (data_sz > CONFIG_SYS_BOOTM_LEN) {
+		printf("FIT external data too large (%u bytes): increase CONFIG_SYS_BOOTM_LEN\n",
+		       data_sz);
+		return -EFBIG;
+	}
+
 	fit_image_get_comp(fit, noffset, &img_comp);
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
-- 
2.43.0

