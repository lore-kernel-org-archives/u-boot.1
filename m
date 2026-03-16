Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6AFF53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B726C8418C;
	Mon, 16 Mar 2026 19:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="z+vSPvgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B890384181; Mon, 16 Mar 2026 19:15:20 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E1684179
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46726528f1cso3327294b6e.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684916; x=1774289716;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SwxsDM+GhSOJdvlm1NHN2FwPlkbuVo0aP/vWR4CNUk=;
 b=z+vSPvgBXklKQvHdCGqUH5C7DuWHDdUX+q3LiUxW5HCxiwHtZV4JBDHYLT2m/GHaYW
 jHIdd773QaW4NoxhL4lkYoT1UeSqDqltPpUz7EvEgr0WmbUb6J8GvzRxKZjn4XCa+nYR
 33MSIuxyoiZyY5OUcmW9QM34WTOxpahf/amOfIHv/nVYoVpg8cs8j3fpJA9odw6bdsc8
 UvAqj9xp6zXPjE9rtvjP5UpHuFiqFPfwC8RhozkpclaQlahv4V2oOtS8+7MgB8RFHYhJ
 CTmtBHCRHMvSbGRH9lLwZkKJkzb4l7by5/C08somHytske4UYsxkzagW4kFSB20QAalK
 887w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684916; x=1774289716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5SwxsDM+GhSOJdvlm1NHN2FwPlkbuVo0aP/vWR4CNUk=;
 b=ZxlMJWHxztpbl2oBbhCUxDAUTUde2jRj6Sqquse5QdH0pvpJi0+eJaPrHj0GzTudlF
 EKzUANMK4HI2qwyqDtHvDqWXPO+H5taq0SSTTjADt9cYjng8kCRAgBZxa9ARdy1eTDju
 /jVLJZp5MDkFqk9wMwcedr+6tHVkoqJVO5XR7FHJa8nSNEccBg+P4vLoMDD4mRbWL2IH
 uganzwpLuZrZ2+hkLatWZfdr1ouyMFIROL/mYzUrRVRpHaqlu8SMnDpfbeB9qS8lVSRZ
 EUNob6cV/1SV32PaaJunSJt1zhLPQ4hAOo+6ywcUHWAJ1QN7/6dS6xlu9Fg6WUeS9yZi
 SYyA==
X-Gm-Message-State: AOJu0Yz3/ou9QtJzwLeuleM5D+DwVHxNmHTzjn01YmRrTiLJo6Wkhqtu
 5UDCo3E/ALv+OP8cZiGzROTSjGqB0tiBvhxI2paNukvlilp624rXwnvWK/EuU/yuMKUWrEXRXX8
 w6dP+L08=
X-Gm-Gg: ATEYQzwNks3yvhiKMbsC6xD9+EfR/UzCjgrh3WBNLuh2APQSDiouvyluezTcgXsPI2/
 5OSxcG7zpqMIPFz2f4YGJL8ZObcfutkqkDueHcd8gB7Xm8Rsx4wLjeCpQRBEZHQUUefqJQ5STLJ
 qDKL/xBgGW48ugWzEL0a7FFeYRB4H+3f/xJ+qTGCM2TWoWsUKrDOdpB6ON2RLxohywJy0LEWWv4
 HEYRnyQjO+PL+6K9Suv2xHB6pRTl1EhMVqjBKbDo2OLgviHwXiXjmpSLHbHSa1XeWv7HiG9Wly8
 370GTGHTdmLtCKwGYIzikTN+COFXAdDRO5p+4udK4UI6R8I1OUKNclwYD4YNdYF/DRuZUYCM299
 8dKrWewzbB9tCWRixJzpoAaCNu/amkrQvp5eucjlXOJ0pJqdorAhxGcc6EyO9gl3UxGYJbzUYgn
 39ztu/ArzRRoLZ0p9ppAU6Pg==
X-Received: by 2002:a05:6808:2385:b0:44f:6a19:433e with SMTP id
 5614622812f47-467570952aamr8397367b6e.15.1773684916447; 
 Mon, 16 Mar 2026 11:15:16 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342c0382sm10403881b6e.10.2026.03.16.11.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:15 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 01/12] tpm:
 export tpm_show_device, tpm_set_device, and get_tpm
Date: Mon, 16 Mar 2026 11:14:30 -0700
Message-ID: <20260316181447.2986278-2-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

From: Aidan <aidan@wolfssl.com>

Remove static scope from tpm_show_device(), tpm_set_device(), and
get_tpm() in cmd/tpm-common.c so they can be called from other
translation units. Add corresponding declarations to
include/tpm-common.h.

wolfTPM's command backend needs these functions for device enumeration
and selection when operating through U-Boot's driver model.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 cmd/tpm-common.c     |  4 ++--
 include/tpm-common.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/cmd/tpm-common.c b/cmd/tpm-common.c
index 1cd57f901b6..30e99e10758 100644
--- a/cmd/tpm-common.c
+++ b/cmd/tpm-common.c
@@ -234,7 +234,7 @@ int type_string_write_vars(const char *type_str, u8 *data,
 	return 0;
 }
 
-static int tpm_show_device(void)
+int tpm_show_device(void)
 {
 	struct udevice *dev;
 	char buf[80];
@@ -253,7 +253,7 @@ static int tpm_show_device(void)
 	return 0;
 }
 
-static int tpm_set_device(unsigned long num)
+int tpm_set_device(unsigned long num)
 {
 	struct udevice *dev;
 	unsigned long n = 0;
diff --git a/include/tpm-common.h b/include/tpm-common.h
index bfb84a931d1..1ea4463fbbe 100644
--- a/include/tpm-common.h
+++ b/include/tpm-common.h
@@ -337,4 +337,26 @@ enum tpm_version tpm_get_version(struct udevice *dev);
 /* Iterate on all TPM devices */
 #define for_each_tpm_device(dev) uclass_foreach_dev_probe(UCLASS_TPM, (dev))
 
+/**
+ * tpm_show_device() - Show all TPM devices
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int tpm_show_device(void);
+
+/**
+ * tpm_set_device() - Set the TPM device to use
+ *
+ * @num: The number of the TPM device to use
+ * Return: 0 on success, -ve on failure
+ */
+int tpm_set_device(unsigned long num);
+
+/**
+ * get_tpm() - Get the TPM device
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int get_tpm(struct udevice **devp);
+
 #endif /* __TPM_COMMON_H */
-- 
2.43.0

