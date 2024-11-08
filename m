Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11674D5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFD0891E8;
	Fri,  8 Nov 2024 14:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhwk07KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA57B88DB6; Fri,  8 Nov 2024 04:45:38 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A0488B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso1355037a91.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037535; x=1731642335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Kz7L2pKD7eSME6VuMWBYK/K9gm5s+bNDFfGLbGGpRs=;
 b=lhwk07KW0/v0657kz7lVAY4lUAgGbmID7Wa4UspVqpSEHjpm/Srm56YDFgdX9x5LUM
 dstDzZHR+G5RhwE3njHNVt/5Ld0FZo4letIeYGH6V7iSh+yDT8vAwN4wPMEJJ6zbZ4vr
 yQecfdEf+npyhWywhubiQJYScrIYeYhOwSjd+FIjpNd2sOb8eG2fi2/U3roGFBGO0Py+
 ABXQTTOAZC0KXIg52scWarhvxeKV7frVe+VyUnlJ1XuCUAyw53ildJJKOzXOYeeh+Oj4
 6+syQrgekPK33TIkgS4rfecsAGS2hIPf9Z4rlvt/70suDKghUlgqcprlLHSI/t6k1Cst
 iPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037535; x=1731642335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Kz7L2pKD7eSME6VuMWBYK/K9gm5s+bNDFfGLbGGpRs=;
 b=MTQwSD4Auwh0tb0TuVfx3Hqyn73SWCXNIRnCXz52IAjmM78+emu6o6wg3PLTDPEYYF
 kfxba52hl9qN2cBcnX+r7Xn2vnRsbi7gr0Ub+UVWL9qQbcp1TrVuRZ7AZCroZ5CSWr7o
 jnj8jrmyQEQzo/6Cy+Jf4eDA5hZUZRB7/E8EIfDtQvs2VJnybdkE2Ef+j3DZzHaPlLOT
 cVnAE+pj0Rg7uNl9Cy+EEktOJvWnDkYyAKTnveaSoD17TnTEPCHSOXlngd1lAXBmlOXB
 n8hStpCiPe7kkEcQcRLN0CQq0jiZhl2xRhHGvmI3okrKHMPvTLAxmxYctKisLwks40Fe
 j4Pg==
X-Gm-Message-State: AOJu0Yya03BvBx5slD5f37WJxAXBzYZU/+BRV3bTVMuWD6iwZjZ/3TBI
 8uLiJLhPjZC8Q9ZzaVVFXcKP+LBBpRc8ifeqRjUMQpJhVaoCV9l9B0piFBML45I=
X-Google-Smtp-Source: AGHT+IF6ZI0ZBfgr4ilOuLBnIpRbJa4DQk2wHSAw94kYnVTyQIPKXcp3iu6c8gSquGWqqMJ17aHEqw==
X-Received: by 2002:a17:90b:4b0d:b0:2e0:894f:198e with SMTP id
 98e67ed59e1d1-2e9b17774f4mr2083966a91.30.1731037535266; 
 Thu, 07 Nov 2024 19:45:35 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5fd1534sm2409364a91.42.2024.11.07.19.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:45:35 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 04/15] efi_loader: device_path: add efi_dp_from_ipv4
Date: Fri,  8 Nov 2024 00:45:29 -0300
Message-ID: <20241108034529.346263-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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
 lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index d7444588aa..3e02341224 100644
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
+	ipv4dp_len = sizeof(struct efi_device_path_ipv4);
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
+		memcpy((void *)&ipv4dp->local_ip_address, (void *)&ip, 4);
+	if (mask)
+		memcpy((void *)&ipv4dp->subnet_mask, (void *)&mask, 4);
+	if (srv)
+		memcpy((void *)&ipv4dp->subnet_mask, (void *)&srv, 4);
+	pos = (char *)ipv4dp + ipv4dp_len;
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

