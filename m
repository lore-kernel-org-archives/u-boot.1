Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E8FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D945C8912F;
	Fri, 26 Apr 2024 16:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QStmpgU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FD4885AF; Fri, 26 Apr 2024 16:14:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375B188634
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A73F424B0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140840;
 bh=i0UZ4f/PmmTQVTWSiiPWRp3lEjXpXAgbrhZDgcBBmOA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QStmpgU5hB5TSxv81Qrwa2HbtHQ/Z+mzC5PbWXP2KkbqSxYxZ4NqNAi7ezqNHDVsU
 nSEZKtP5rzt0syIQH04CEldejLbxrxtPncgPC3QgD4UL2r11uPmu+XoX4Ef2kY6u0U
 JpMu6lgGjhotfvjPpChPlJ6L5F4CNNl6AjtK9JDNL65Qz670hhwlNSnflORePBLCZl
 M220q2/fAyUFuG2AzLblkT4HQ38RSdPOKlhM2Zw4/WAXEMgOt/qoUVg3hUf+lEQzmp
 0lStFA9vXP+YyM5LjXadPRM0XIcN8ATfZs5ok2kFDvjyaT1Gatqv6RyqmRmnJ6FIps
 xSlu2aHuZgKiA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-346b8ef7e10so1388574f8f.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140838; x=1714745638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0UZ4f/PmmTQVTWSiiPWRp3lEjXpXAgbrhZDgcBBmOA=;
 b=BHbvj+db9Q4aIIz3BPOYRqw9mLCk54+ElDwMfTZ8BqhvK1UqamgR6FPdcmF9/2Sk4K
 AA4LTAbfwbapVi/MOfkXhX3j43VHGg6Ym1REdHekn0+Ldwl3fZysBhHWwnGx6E63wY0r
 j0jTPQJn3xx4z/mJoUnZjHWl+FJN4J+5LAL+MUbLMxLsTcVc/IFlrly27Z7EoVkKb7Kk
 kRA9pMys3RG/kEyFUax7/EKCCW+fFStbH8+Dc6S6mJ0oU6Dxl5W2CAACC/lkkUoEa+xG
 NAXN9UIwn79pvJGeRtiGBxPZKDr9srKqG2s3YhHuEbvLYiqfxfchrZKbMpjiSxxZMoIy
 ofhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyGLinYaKf6ALxTmT66A8lE6Q8JV0okZ2US5yqdhY3TZReSGowFb29XOzquvwis1y5Uv3MiE9Vks/hpnro/uKRu7E5Zw==
X-Gm-Message-State: AOJu0Ywm/eAG9rapihxYQjTXYGVWxPsIvdj9kOh7BtnvphiK46KXzoTE
 lbUQThm35o77dbjPgWKqJdaZ75Rq5D67k7oyBtNwDAde7hRgPUqJE8GQkzqfeFENCd1cpdXXgBl
 gOuOqmUGxdlTZg/uy/dcoCKHWlQVu9/HEwDmjwV33EcayNhMg0qrpQJL4V0Hy1TA1di0=
X-Received: by 2002:a5d:456b:0:b0:343:7d6b:d30 with SMTP id
 a11-20020a5d456b000000b003437d6b0d30mr1739211wrc.12.1714140837874; 
 Fri, 26 Apr 2024 07:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHltPI3tuj7jam9cW0JTT7M+a7Jl2Yhlm1xXTFV+dtHTSLtVlxnrQhqu8mpFbfCxIz69QpLrw==
X-Received: by 2002:a5d:456b:0:b0:343:7d6b:d30 with SMTP id
 a11-20020a5d456b000000b003437d6b0d30mr1739200wrc.12.1714140837536; 
 Fri, 26 Apr 2024 07:13:57 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:57 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 12/14] efi_loader: return binary from efi_dp_from_lo()
Date: Fri, 26 Apr 2024 16:13:19 +0200
Message-ID: <20240426141321.232236-13-heinrich.schuchardt@canonical.com>
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

Up to now efi_dp_from_lo() only could return the initrd or fdt device-path.
Allow returning the binary device-path to.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 75fe95c9c1e..c8893f5626b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1140,17 +1140,18 @@ ssize_t efi_dp_check_length(const struct efi_device_path *dp,
 }
 
 /**
- * efi_dp_from_lo() - Get the instance of a VenMedia node in a
- *                    multi-instance device path that matches
- *                    a specific GUID. This kind of device paths
- *                    is found in Boot#### options describing an
- *                    initrd location
+ * efi_dp_from_lo() - get device-path from load option
  *
- * @lo:		EFI_LOAD_OPTION containing a valid device path
- * @guid:	guid to search for
+ * The load options in U-Boot may contain multiple concatenated device-paths.
+ * The first device-path indicates the EFI binary to execute. Subsequent
+ * device-paths start with a VenMedia node where the GUID identifies the
+ * function (initrd or fdt).
+ *
+ * @lo:		EFI load option containing a valid device path
+ * @guid:	GUID identifying device-path or NULL for the EFI binary
  *
  * Return:
- * device path including the VenMedia node or NULL.
+ * device path excluding the matched VenMedia node or NULL.
  * Caller must free the returned value.
  */
 struct
@@ -1161,6 +1162,9 @@ efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
 	struct efi_device_path_vendor *vendor;
 	int lo_len = lo->file_path_length;
 
+	if (!guid)
+		return efi_dp_dup(fp);
+
 	for (; lo_len >=  sizeof(struct efi_device_path);
 	     lo_len -= fp->length, fp = (void *)fp + fp->length) {
 		if (lo_len < 0 || efi_dp_check_length(fp, lo_len) < 0)
-- 
2.43.0

