Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507D2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCA1885BC;
	Fri, 26 Apr 2024 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lbfhZFz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8BF885B4; Fri, 26 Apr 2024 16:13:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58047885A3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CAAFB3FE5F
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140827;
 bh=RYQWPn5AeJUd8lxUKHzYcdEuDE0zU69ZgxrUmc6ri9Q=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lbfhZFz7yDIt0bd5V0ri/T8/T43HgFtNktVJBHsLfJWLNs8/WvMWpx2UKygFuJihp
 mRNfkVu5R8ukbeS50cvMOtqMemg4WehdkftgAaf41X5elJiAiMHqUmyyB//zglIElc
 AZDjLvdXDy+5ooP3WBnnsHXG5N1brjl55xNKjqKt5K6BOPGQySJ4fGTYxpHQRJvP+d
 8Upfez+XRF/cUQXYKiiuVQ0zcbOJiZQbRsaWKyYL9isph2iYmSv1m2j4gjGYN7n1O7
 J7WvwXdcFbdNqTHV/UDHw6KvKudIkDBYxHbnw9R12WrOklnbU3678aKUCl0vL516sO
 22qCZa/bMvSyw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34a49f5a6baso1867451f8f.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140827; x=1714745627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYQWPn5AeJUd8lxUKHzYcdEuDE0zU69ZgxrUmc6ri9Q=;
 b=bj46XxUfa3FXgmf/cgQtJ8DNRUEDgxCV0YY9UrwvJWlywLZWk45X5RD42A52KnNuZV
 i444+NMKLbqL0CO0TOxU/sDM8NPha5UILpGiNFX1XVXp9Y0T/iLKB+DW0itJRFC664WP
 Qe/82q1BaiUIUJ0oCBd1bSgGAbdoeLO3X2IDYOrLKJX4IKxieXmCXNhsxN5NI7GiiCpw
 TQxDRHRvC3Wk+JfsHZ/Ow3yQ/FOQrxFxmtlEs4jl4NxjdiroQYupO1jeFSBlEO/tWirT
 tneoE4ZxLIcFNNSSaC1K5PFx0b+wI9UcST+gs7uLtJwdaN2AOI5BEYcAhSUXGRe1ixa5
 Bwjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8EzTN6DIbwYeH2tlVuKy5NiJ44asjKU7gyzdcuwNd/UjIR80MKabVyfObzLb3IDccwDGNanmblzxJKaj0SbDISht81g==
X-Gm-Message-State: AOJu0Yx95kg6dvVrf0gqyCHZGW5RB1QJn5/hqUl4M/E2sBRuOw+FL/cW
 JkLFdbIaLDicOGOZQOVIWk0QePn1cUYGR/55u4TXUhbgffYmccAR6M83qpdtIbqR04133qFidGD
 IUBFW+hYiFPtu7+pZE4poO68ttdOHv04UiRAteD2fEmuzHIhDTITn42HFQLZX8RDZHfg=
X-Received: by 2002:a05:6000:174e:b0:34b:4d4e:c67a with SMTP id
 m14-20020a056000174e00b0034b4d4ec67amr2213812wrf.66.1714140827010; 
 Fri, 26 Apr 2024 07:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiPjDlX1B9Ap5MHDLkWInQLOBv2D0DbN3Z8MdMWyErCFWxLnV40lAeSrCVkz0a8hJxzqJKg==
X-Received: by 2002:a05:6000:174e:b0:34b:4d4e:c67a with SMTP id
 m14-20020a056000174e00b0034b4d4ec67amr2213795wrf.66.1714140826700; 
 Fri, 26 Apr 2024 07:13:46 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:46 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 01/14] efi_loader: pass GUID by address to efi_dp_from_lo
Date: Fri, 26 Apr 2024 16:13:08 +0200
Message-ID: <20240426141321.232236-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

We should not pass GUIDs by value as this requires copying.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h             | 2 +-
 lib/efi_loader/efi_helper.c      | 4 ++--
 lib/efi_loader/efi_load_initrd.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 69442f4e58d..9600941aa32 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -743,7 +743,7 @@ efi_status_t EFIAPI efi_register_protocol_notify(const efi_guid_t *protocol,
 efi_status_t efi_file_size(struct efi_file_handle *fh, efi_uintn_t *size);
 
 /* get a device path from a Boot#### option */
-struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid);
+struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid);
 
 /* get len, string (used in u-boot crypto from a guid */
 const char *guid_to_sha_str(const efi_guid_t *guid);
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 6918fd5e48a..c5d13c0f19c 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -72,7 +72,7 @@ out:
  *
  * Return:	device path or NULL. Caller must free the returned value
  */
-struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid)
+struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid)
 {
 	struct efi_load_option lo;
 	void *var_value;
@@ -92,7 +92,7 @@ struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid)
 	if (ret != EFI_SUCCESS)
 		goto err;
 
-	return efi_dp_from_lo(&lo, &guid);
+	return efi_dp_from_lo(&lo, guid);
 
 err:
 	free(var_value);
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index 67d1f75d525..d91135436c4 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -63,7 +63,7 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
 	 * We can then use this specific return value and not install the
 	 * protocol, while allowing the boot to continue
 	 */
-	dp = efi_get_dp_from_boot(efi_lf2_initrd_guid);
+	dp = efi_get_dp_from_boot(&efi_lf2_initrd_guid);
 	if (!dp)
 		return EFI_INVALID_PARAMETER;
 
-- 
2.43.0

