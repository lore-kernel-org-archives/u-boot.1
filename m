Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E53D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE2D893E2;
	Tue, 12 Nov 2024 03:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="goEUfS0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D1489393; Mon, 11 Nov 2024 22:10:17 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319CB89398
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso52904085ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359414; x=1731964214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLnDpRFpsVjG8Vw4xEE3e6amJCZa/7xUxUJTkHI8G/A=;
 b=goEUfS0VCHWngCukVFyb2oyF/V82si3CbgmreyQxmgncO7L3C4G8Vwqx/8Z7vdnJeh
 mNcQCz3VtGKew6F+HEDMp5c4g6bruwEQRlrGd58Pc7EjFzKah0AX/6WubzF3Ch0E4jLR
 VQE/Tb1xq+NdDqb5JzmK4DAErETxXjYEV3MhWWJO3ZDnb62Zzl/C/FpcHUanHotHlsYY
 xDVvxwBkkKDBkkJlXYtRKBoXgCDc6FBP2aFz/lOA5r5DnOoCmKNUKMKo2jTOkei3qS7g
 algxEV2pmPmuL0quQ/qH6cZpDFM85nii2WhMCZhR01nQIVyGHdjajQIex74p2avl4PeA
 nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359414; x=1731964214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLnDpRFpsVjG8Vw4xEE3e6amJCZa/7xUxUJTkHI8G/A=;
 b=XaWCnAhExh0pZJMSindhFN2Ab8ELe3N2KNtWs0rpV9ydoMJ8rtdePhf0bdl9DXY59t
 KBVw6/6tt5U7gYI9KyfJ1ULRV1wyplXpdTLJQnm9gopSe++CM0bZqQZwUaHY7eYWXE3I
 +tbxc45XDwy4ifB5nucaZiyzdD8jHFSvpIc+XK2mbm8QS4l9O8HW4KcsmHulI5gciWBe
 wMgE5vTJgcOs4139q0BGfXreqy1ZltQ/hnXwWhLtXMVucj2wIdY5ov39tazl96fV171F
 80Nl5Dh7pryvo1UUjDJ99bAxPncc33YQMWyVy3cFkywmjzaRq1aHA325g1iQE8ZL77YC
 Vdnw==
X-Gm-Message-State: AOJu0YyhLBNJ8Ih62R1pr0CJM82/xo//Dkli52sV2TYWrMrmXXnknNzX
 Fju/sKJLQvjapTdmmatxaJ8HfgKzZ8E333L8DkPSAjV3lsxWrFt2sd3uahvI
X-Google-Smtp-Source: AGHT+IGvMUsu1p/+w+3algDYZRr/hjINTCWQCwulfD9y2Q6zCaHvVW0QgScF7INDF0ZyXQeJGPNs1A==
X-Received: by 2002:a17:903:404b:b0:20c:e4c3:27a3 with SMTP id
 d9443c01a7336-21183d55551mr132302705ad.43.1731359413681; 
 Mon, 11 Nov 2024 13:10:13 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:13 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 04/15] efi_loader: device_path: add efi_dp_from_ipv4
Date: Mon, 11 Nov 2024 18:09:48 -0300
Message-ID: <20241111210959.560738-5-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Add efi_dp_from_ipv4 to form a device path from an ipv4 address.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v3:
- Removed some unnecessary void* casts.
- Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
  in efi_dp_from_ipv4.

 lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd..82a45da1fa 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 	return start;
 }
 
+struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
+					 struct efi_ipv4_address *mask,
+					 struct efi_ipv4_address *srv)
+{
+	struct efi_device_path *dp1, *dp2;
+	efi_uintn_t ipv4dp_len;
+	struct efi_device_path_ipv4 *ipv4dp;
+	char *pos;
+
+	ipv4dp_len = sizeof(*ipv4dp);
+	ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
+	if (!ipv4dp) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+
+	ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
+	ipv4dp->dp.length = ipv4dp_len;
+	ipv4dp->protocol = 6;
+	if (ip)
+		memcpy(&ipv4dp->local_ip_address, (void *)&ip, 4);
+	if (mask)
+		memcpy(&ipv4dp->subnet_mask, (void *)&mask, 4);
+	if (srv)
+		memcpy(&ipv4dp->subnet_mask, (void *)&srv, 4);
+	pos = (void *)((uintptr_t)ipv4dp + ipv4dp_len);
+	memcpy(pos, &END, sizeof(END));
+
+	dp1 = efi_dp_from_eth();
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
+
+	efi_free_pool(ipv4dp);
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

