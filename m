Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5DCD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56201895E6;
	Mon, 25 Nov 2024 01:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XHAp4pUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBB18929F; Mon, 25 Nov 2024 01:58:34 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5E98952A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f43259d220so2793630a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496311; x=1733101111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gz7yp+vvFXRGfhQ088k5HGimD+NNGxnDNN80AafH1l8=;
 b=XHAp4pUd7K9a+gDTYEg5dS9i5ayxeGtBam+Q6KvsJNV8do7hfycQd+JwAaZ0oifnKZ
 QCmAN17td70bvat0muCgD8CXFDNw3v0lur83cxPYPML0ESDjhbHnK7xKDmU239DYn4cc
 WA8hMrBTY2q0OFlEUCgy6qIOM64ekjAo77hdmydjZqolauT3LYk39RIwXew7y+yKvi+D
 aCf2C9Y14ekWRk1rPQq0LPWPVEINATPdncRZmgPsLedvOqACHlgdU+kpAMaQBRWX9c2u
 NM1D1wTNg4WubQoEig5x/EtyEJ92r+T5xBGYgjfi2kLP6PIl2gIRd/WIPA4kxeQwbMqH
 I4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496311; x=1733101111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gz7yp+vvFXRGfhQ088k5HGimD+NNGxnDNN80AafH1l8=;
 b=qtDpXRCG3MoTx04+3eFzWjRfhJLBG1YJhWDQz8N4jcA27xufmBQN+XQ/z2YwXqSDK+
 SXpj0Q8PBmoRSJIyrABKLkAYfLf/ggsaOUdtmd6Fvne0dq/CmVrMafsamsotDrmn5fMa
 FVxpBg/Kk9czK8ecE2no3SHTpd3TpVqOXK9FG3xkcSv6Wk4czVAcYJTdy1d8zCQ6uyio
 IRireZbaAg8CHq3srjwsxV5LE5guntBkwKDOjJkPdhR4zLTgTA5s3Bz+kKNTJFKPYWwo
 X6j6SiE8I7geemqL6yd6R7qlnBVZHqsGR2KNxXd8odUYlI8yg+EotQH6TG0lJk0JdNqi
 lENg==
X-Gm-Message-State: AOJu0YxH5JRoZWy1JPq3qpEjx/YVDW7ra68j8jNsVxRQ5UdqW5ROTlEi
 /IlVHjvfvuiLkz8XPG3seZc2IWCSfwi24BykTEidyaTFfTuSgfxNWGeIU1DvWeo=
X-Gm-Gg: ASbGncuCNDsaRG4bn9RNEttAFm2iMbyoOjCWR+LaCcpk5W4iD/+WtfFspqzgF6tuQ/7
 yXbS7J8ShtrxF5PI1zxvV03yLVazlNVrBiIPMO4Ss0aMZZG8xkqQP8SPDYYnBtAamz1/ACcTcGh
 BDyATrzWTGew2e/EoJurff7SZQgSSaKIBvPkKJlRSKdRGQwn+nrzwTcV5OFKxqc6+ImNnR0vtBo
 faanJVqXKfeTsSoZchFsGJWLJYuQani2NxV1+IeojG1
X-Google-Smtp-Source: AGHT+IEboaeQ5SHnLld3ZL2dFDc06mTTJS2dF2TXoo1Vfe76z6e76gTH3QrqV2BjSof49HtB9Pqhow==
X-Received: by 2002:a05:6a20:1582:b0:1d4:fc66:30e8 with SMTP id
 adf61e73a8af0-1e09e3f0006mr15976086637.10.1732496311053; 
 Sun, 24 Nov 2024 16:58:31 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:30 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 03/14] efi_loader: device_path: add efi_dp_from_ipv4
Date: Sun, 24 Nov 2024 21:58:03 -0300
Message-ID: <20241125005814.236669-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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

Add efi_dp_from_ipv4 to form a device path from an ipv4 address.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v5:
- Add function description to efi_dp_from_ipv4
- Allocate ipv4dp in the stack
- Make efi_dp_from_ipv4 static
- Remove u-boot log messages inside efi routine
- Change (void *)(unitptr_t) to char *

Changes in v4:
- Fix memcpy mistake

Changes in v3:
- Remove some unnecessary void* casts.
- Change sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
  in efi_dp_from_ipv4.

 lib/efi_loader/efi_device_path.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd..96e72f72fc 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -974,6 +974,49 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 	return start;
 }
 
+/**
+ * efi_dp_from_ipv4() - set device path from IPv4 address
+ *
+ * Set the device path to an ethernet device path as provided by
+ * efi_dp_from_eth() concatenated with a device path of subtype
+ * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
+ *
+ * @ip:		IPv4 local address
+ * @mask:	network mask
+ * @srv:	IPv4 remote/server address
+ */
+static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
+					 struct efi_ipv4_address *mask,
+					 struct efi_ipv4_address *srv)
+{
+	struct efi_device_path *dp1, *dp2, *pos;
+	struct {
+		struct efi_device_path_ipv4 ipv4dp;
+		struct efi_device_path end;
+	} dp;
+
+	memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
+	dp.ipv4dp.dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	dp.ipv4dp.dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
+	dp.ipv4dp.dp.length = sizeof(dp.ipv4dp);
+	dp.ipv4dp.protocol = 6;
+	if (ip)
+		memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
+	if (mask)
+		memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
+	if (srv)
+		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
+	pos = &dp.end;
+	memcpy(pos, &END, sizeof(END));
+
+	dp1 = efi_dp_from_eth();
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
+
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

