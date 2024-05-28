Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EDEC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D2B8850A;
	Tue, 28 May 2024 16:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wJ+LPPNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEAA8851D; Tue, 28 May 2024 16:43:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E5F8850C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 779A34012D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907393;
 bh=WUMvHXrxRBwOcmZ6Qq+IOIVmYp842ja3fsRUDoRqBT0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wJ+LPPNcLF1sS8Qh4W2lIjLFT9OQK90zzmn+78vofJpK2ux4RuMEP5FIgiD74fZsI
 2QA0W0UNjcx5o1tAG1+ZZamsa3C75O+l1sLm3PxSNa1dOX01W3rQNHo/FPpMRSWu9j
 IjwrnECm9qALgszqC5Tg8y7gms1h+lSP2N6SQbhQnUCqS1FQsnY6BYaDvQUsdrhhP8
 AQE1J8cgAMFPHGsu7dRy9XwJiojz1FSoZjOl2pJS4Z+0ACHSHZIvnxHlahfD/7Q3e5
 FA8UgImA3q9Nyedx+9fBhdMAnlGZgxfgfN5k5J7imSAFohqCeAK9JFxuz0aTuhVBY5
 QxQwxVQAu21kA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5786cf51b65so493769a12.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907391; x=1717512191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUMvHXrxRBwOcmZ6Qq+IOIVmYp842ja3fsRUDoRqBT0=;
 b=Pt5oNYz0ZhQZLxmlSWo8kBlhKj3/Wy0HHqTyWsH9u/+qppoX29JQlfkKGvCcJQrXoh
 uFxfJmAvGJPjkGLa2bZT7RiTe4UCI4EjO1gZlbUDUh95//8FEKT6YvGfN2fb9sGqFWAD
 YI6GOk/++jzsGp3kEcLEEMsk9NbYwL/5IC9kbQdzFCZ1UCgEqeuOpalN/moY4q3K72IJ
 2qhxq7nEKcIULj+o+wbhxwmU1+MLqjgclDKZkT3H5vOJ6yIGMdhhK1a7eu+NJyYC1fyF
 kyTiJKn5+5D5A6E/eivKAFjbA0RxwX+W60GfzmjkaAgy+udUS1zOnCT51pvLYrtr03lE
 p7zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMwcykO4QfGxQ0rxbrDxNTaOWHpyMvwUQ9zk3hwpv2SUFr7y3rr0TDdeiBNveHh9zwZw0otIyHHFMetcLLeeFQKC1Ghg==
X-Gm-Message-State: AOJu0YzVMYEmbmBhaxcCdXbcv/cStU8gLhfVDviPZa/aXUkEeHi4e/Rn
 uIjUT2IpTpHzDo/YAs7Vp3+inPqeImA4LcnIxqhbLl2pSGCfCep+hkn8AeDAT5yu7TXOfEAaZly
 iT39Dj0yZL023m/IamAkbJiBqeBIPLywXmqf1Xqgw3/bfZb95TfN4br6ftzmMAKfBZZxni+dRHo
 I=
X-Received: by 2002:a50:a683:0:b0:578:59f1:e3a3 with SMTP id
 4fb4d7f45d1cf-57859f1e6bemr6343771a12.7.1716907391497; 
 Tue, 28 May 2024 07:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaPVfB5Rwahpm+6GVQA17K1xX38Uv1CXl5nLW48k116XWeVRfuk2ucKZKWICXYik8xGsIsfA==
X-Received: by 2002:a50:a683:0:b0:578:59f1:e3a3 with SMTP id
 4fb4d7f45d1cf-57859f1e6bemr6343754a12.7.1716907391110; 
 Tue, 28 May 2024 07:43:11 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:10 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 6/8] efi_loader: return binary from efi_dp_from_lo()
Date: Tue, 28 May 2024 16:42:50 +0200
Message-ID: <20240528144252.179247-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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

For finding distro supplied device-trees we need to know from which device
we are booting. This can be identified via the device-path of the binary.

Up to now efi_dp_from_lo() only could return the initrd or fdt device-path.
Allow returning the binary device-path, too.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index c8c8d54f733..52e3313c23a 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1133,17 +1133,18 @@ ssize_t efi_dp_check_length(const struct efi_device_path *dp,
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
@@ -1154,6 +1155,9 @@ efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
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

