Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA01C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8106884F1;
	Mon, 10 Jun 2024 11:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rD3m9eL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EDF884F1; Mon, 10 Jun 2024 11:11:15 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54485884FD
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4B033F6A3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010671;
 bh=XvlaQBsx4/tGPDaPKekaPaBNVHzorc6wGG0MqDzTrdw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rD3m9eL8PSERbOGps8G8ly19GabXLr5jA6w46+LLq6SNyKNPVVWx674Z0+27orxii
 bDO3Ey7XYyjJcYMGrCToC0R7E7KqreY4XGBIEt7ORYolTtw3dwTN4+Ck/Tbib9dfrF
 9jlJHMsvdubC3OMGS5b8vSYbj7TRIwfxIOZuseR4a4pYISur+XvIgpFM0KykyEB9gY
 VMoF6U2VtH7kUxPc9LIVucKQoZ/rbzTfYgRubXxOPm9m3RvZsfV1heFGlDvwsVOdUW
 EXQyC4T8T6kTPQSuCxIxGxMdplC6EL6InFcheFmdR57kobViorR1tBHuIkL4XmxyIC
 iDH9UaNJ6kC1w==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212a3ddb6bso28242025e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010671; x=1718615471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvlaQBsx4/tGPDaPKekaPaBNVHzorc6wGG0MqDzTrdw=;
 b=wTs3oRtSvCK/hxHUAiflJlJJk81P/cssUhc3S2rEFNdcqubWmYxtry4G5iifZ+SEDo
 WHQjT4eslTztMV1F9mM3+v5RGI7LHAFAFWqx6jnEAupcQ9jEkeTXYk617Tcpf6U5FmHS
 8eTqCrUexaCLrds8ENOc91CxAgVsAaw4A0FEs7xc2aQ0gos2lOzjSjUBGo6l48ykhrJS
 sGb22/TKU6yGgtndKoCEV4pvuaOczTgJD1P8D2ZQvobMxQfDpqA3Lrs5Qam+0HpfmD6j
 CMXZ7Jiijfdf77ib+rLPmKhGScmElyGpR9LvlL6V01DDYivolyJCg0syRfYHckIOAS7s
 c6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXERoUznJ3svcUsj5quAgU4yAP3XJ2hDD/DYuMpOJlffuKMufBlZz9nuEsYtI253n6hX+F0mSK2U/gWD5byDO1n8+Y0w==
X-Gm-Message-State: AOJu0YySHDC9htWfl8UvSlvXqsWg+PCBUnQosEHm2G7ZQV0HgoYP0fm2
 SwPrRvrUANpHD17iWJcDKLb7PFWjA7DencKCBl0FuhXMnmhBN02OOgnRk6c+OqzSGPvhTcLWZVO
 3Rletf+hn+qc69Qc0Th06rHp/FrFgUAkvhysWZnDNKY/dmoIZx29S9ohc1iug35sVYAc=
X-Received: by 2002:a05:600c:4f44:b0:421:205f:52de with SMTP id
 5b1f17b1804b1-42164a32853mr70954205e9.26.1718010671471; 
 Mon, 10 Jun 2024 02:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkInDU95YsXi8LoAPxzWVWI2gYyVmOHKvnYcDp5Weq1SDoqC75u0dMrsFcveEz1yK4fOWYqw==
X-Received: by 2002:a05:600c:4f44:b0:421:205f:52de with SMTP id
 5b1f17b1804b1-42164a32853mr70954065e9.26.1718010671201; 
 Mon, 10 Jun 2024 02:11:11 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:10 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 6/9] efi_loader: return binary from efi_dp_from_lo()
Date: Mon, 10 Jun 2024 11:10:54 +0200
Message-ID: <20240610091057.64463-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	No change
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

