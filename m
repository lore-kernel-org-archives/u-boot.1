Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AE6C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 20:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1590282B44;
	Tue, 15 Apr 2025 22:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="khwwd0qH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4398A81F7E; Tue, 15 Apr 2025 22:49:58 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8F182A27
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 22:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso30636665e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744750195; x=1745354995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpI66hsnd4VVAxKYGujgtBn62XBm84cFwii+PeTWgiQ=;
 b=khwwd0qHcxZAEl5uZjN+RzNYgEuWet6yOzfTCN/x8qjLCwK6pWkBm+3rmrTjMyfuVR
 dhUHjjFkBGzqA/4j39z5Sz/aoFIbS1puxe2NyLntmiHnSkTFA6giSsfWGTF3vrO1arr1
 BdDF/YWUT3R22Wld3rVaTjP19gFbXkNBAM58HAdhVesxJmJsGbrxWaaHkWTTZYRhQTCz
 MDmDUAEXPlDA6zT20LRCRsvatzs3YDVX/H7ZYLZvtx+PX3ZO6F7gS2XiCI7ceB2RIkmB
 ebHwRRBUslJGyXoNZ/WJNKn3OiLsNyKbEHVHh31komddAQgHp2gY2aG91TIZmPOOwtfN
 kf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744750195; x=1745354995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpI66hsnd4VVAxKYGujgtBn62XBm84cFwii+PeTWgiQ=;
 b=p1HubHBQsAS43a8Zy5qggf4niXPFsc/DwO+uaYZboQVH7CWUwiXFTZoTWR4eJYlouR
 qVD6kG25S2G2ZJq32kzTrgD/yOZMrnOG7cER9hu/SWDtL3tpVMa89/bHgyhe1CTOVn0e
 oLQFdOER8QFQbioAvBiYwx6iHFdgF5BR1zemdNI1t3CDf0lVzxQ3OKrHYPc7UM/ZpZpV
 cJcCW0h3uuUDwGqyf1VHRCxrsuOk3BatEWqa4duKpkVJvmjld2FDwCsIrkDOg72QNyr9
 d4ALRI/B88PjuwBKMW0HgxCigRQ9QrS1OEAGFVMOk3LgIZK1NLNGojvzT4QDiDrSrS1u
 IAnQ==
X-Gm-Message-State: AOJu0YwbZ6TQWc3SFFaOSIVeaK6Fi8R5HTOktxW0VZlQvRBxvoDEQdaC
 SzztquZpzUV9LZD9PpYMIIZpNIXOnLVJnAc7fRsx443j5E7UPZI0nXCEJPWzTI6WrQzyx9amBxl
 qKJQ=
X-Gm-Gg: ASbGnctIlJ5tqD1BjPBqrHLWceVN0w2MX22WaIhmGguorEbCzb8zdpEpkmDJnC7ZqPD
 Ze9DXUVJWEa54LyfvoM+bhfF0fFT+hBCyfpCFtKbNb5N5tVymEIjU/98gOr4wOqrfZHOQOSNpfB
 u5K7RXylT7LXCMIDVL1IPcvAzgvvrmeaiZ76Bv2AhLE2KhsJUVEiJ6XPJ9g+GmQcVIUTNGmkuzV
 hoDIlsdKLFHsRDprRlJPG8SaxG+bKo+hI2y7W5DLabLnH3LBZJAGmRZ0oqf2lQg5vS+fd+xqaWI
 T1Bj8sggdbB3Hxni5NlsmyqWzi+VmiU0o4VdtJtnRap4PGNd
X-Google-Smtp-Source: AGHT+IGS6+czcN81Nki3bjUD0PgTJqLyzrHSIQU0aY3A2CcbfV1oerOmkZMa0TVdeKOTMO5djQI7Mw==
X-Received: by 2002:a05:600c:5107:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4405a0f94a3mr3613025e9.21.1744750195578; 
 Tue, 15 Apr 2025 13:49:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3ed7sm617675e9.24.2025.04.15.13.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 13:49:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 1/2] lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID
Date: Tue, 15 Apr 2025 22:49:02 +0200
Message-ID: <20250415204917.1250109-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415204917.1250109-1-jerome.forissier@linaro.org>
References: <20250415204917.1250109-1-jerome.forissier@linaro.org>
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

The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
configuration options. It is "system" if CONFIG_PARTITION_TYPE_GUID is
enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
enabled. In addition, the unit test in test/common/print.c is incorrect
because it expects only "system" (or a hex GUID).

Make things more consistent by using a clear and unique name: "EFI
System Partition" whatever the configuration, and update the unit test
accordingly.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
- Remove useless braces in if expression
- Change partition name and make it the same for all configs. Update the
  commit subject.

 lib/uuid.c          | 4 ++--
 test/common/print.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 75658778044..4ad2cca64c5 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -68,7 +68,7 @@ static const struct {
 } list_guid[] = {
 #ifndef USE_HOSTCC
 #ifdef CONFIG_PARTITION_TYPE_GUID
-	{"system",	PARTITION_SYSTEM_GUID},
+	{"EFI System Partition", PARTITION_SYSTEM_GUID},
 	{"mbr",		LEGACY_MBR_PARTITION_GUID},
 	{"msft",	PARTITION_MSFT_RESERVED_GUID},
 	{"data",	PARTITION_BASIC_DATA_GUID},
@@ -184,7 +184,7 @@ static const struct {
 		EFI_TCG2_PROTOCOL_GUID,
 		},
 	{
-		"System Partition",
+		"EFI System Partition",
 		PARTITION_SYSTEM_GUID
 	},
 	{
diff --git a/test/common/print.c b/test/common/print.c
index e3711b10809..c48efc2783f 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
 	sprintf(str, "%pUL", guid);
 	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
 	sprintf(str, "%pUs", guid_esp);
-	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
-		ut_asserteq_str("system", str);
-	} else {
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
+	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
+		ut_asserteq_str("EFI System Partition", str);
+	else
 		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
-	}
 	ret = snprintf(str, 4, "%pUL", guid);
 	ut_asserteq(0, str[3]);
 	ut_asserteq(36, ret);
-- 
2.43.0

