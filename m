Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE31ACD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3150C84E05;
	Sat,  9 May 2026 02:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="AVXB9SM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367BC84E02; Sat,  9 May 2026 02:04:39 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26E384E0B
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12e332315a8so4194842c88.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285075; x=1778889875;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o4rlL6GsBQtVdjKYp4BzTjCiK4suS7EC40S8T/+Wlo=;
 b=AVXB9SM4yFu/Ij1dp0SmnVJgHgdNcDXK12Ee8H6XtzBBIR+iajFfmWbSzdlEQQsFEq
 fO63BztjAbDtb2ByMjV8QDG5asw0lhh9yoxpnZkCDIPOy5duFJkoQELdYgwtnrZYJJVk
 x9oAWTrqt9WJaY1HgdjztAyVLXUv7EjSyDjUq/hFxFXDVfUb49pCk7nUZ+Ay06V/kSQz
 Ys5x3oD4PaoGrDWiR0KaY20M73gLRcfUyJ4VdD/whfLc4+zE10NpUnIzRFFq72j5kNYL
 XbbtwtvOwKDcvOzTdU0Tw+8AjWYLpVwTcauqPAZRkUdfr6LIMHcjBeLQPufK+VNKexNk
 haIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285075; x=1778889875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2o4rlL6GsBQtVdjKYp4BzTjCiK4suS7EC40S8T/+Wlo=;
 b=O3ZiIgfNir8YoXZFlOcD2mPFMy0ILYKFflFRMkgyrwx/yPAO0FK9jedyk+h2fYihtZ
 e0gaEXRSz0nvXawO53oVPFd656Mc16CKiF7aGJyNxGIUCRj9R2OkYHcPo5U/sVTXO97M
 418CZe4ORTN59t5v4D50eheGEjOXZLutmtYv4/kjHUz7/fi8gkkEac7blcqAb2OgrzUe
 FSrkw8u2pGxmLB7XDxTqWCo9OEDH6+mwE8V8YT++nbjOLEDxdeYx4Ve8JWyJOyqrKkSZ
 SVnYEJac8KD/YOeCSpEnFhC1hJUq+wpbcXsE3IwtxFgQPJ5z8q7uyd4X7Qxfo/B4kGTt
 HB7A==
X-Gm-Message-State: AOJu0YyYbcll4wxXxXVbt86GnqLnc9iOp9DcdbUMNmmwWXZKbnJefm4K
 ySnuI6lYnKihwwXGd5NL92H/GnVwbF2POmnUHT0bxByA6Rj9eHnkI86pVjv0pOnRL8n0QQLaQgy
 Fg2m1
X-Gm-Gg: AeBDieuk5u4+sxrg4iC/a6N5h1QkkuD0RvTg7jrKFilGT3WKfn3TOvkaPPfJEHFiJW9
 /g+D2vtpemEdndimJouuS2RS5VBNuJI2PCZ67qznrSqbA/p5bbkejjeygawbiaVN+ix1QJcCfl8
 Zs9iPu8UPgmJVkrAxq39qe15DA0hAxrFMxH1YmrADLjSiMyOoQy72PJHu4BnJZ6A81wycpyEnHe
 YUnr9wkxOqJX3RyP0SFQRNcRBRv7vo+AnWEoFAHynHC5Ksj2wZGdtc0lhywmeq9rv/8iGqCdgoe
 DJw/O9+n+qH3zT155zUY1Lufae69XlLpahfYTJ0phEoRSNzT0knEDsA8puvJQNYCUrc9w5oVaJ2
 BSXaS6hlveE2njnLzPGKnzxkzgy5y5AQFW7POhdiQbIZfYL/107wBKeImVOy8qTofNVODlK7e7I
 IouLIGGK4dDTf0No5yB//NfxiXcC7nbc9JxuT9T4I38Gm/kQKhKckEIItaRjpKCKJ1zjNDCWS8S
 YOW6Y+8P4HzWKG42XEHhcvbCqGuHjEE
X-Received: by 2002:a05:7022:6997:b0:12f:1f67:e743 with SMTP id
 a92af1059eb24-132a83ee5c2mr240403c88.40.1778285074811; 
 Fri, 08 May 2026 17:04:34 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:34 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 01/12] tpm: export tpm_show_device, tpm_set_device,
 and get_tpm
Date: Fri,  8 May 2026 17:04:08 -0700
Message-ID: <ae30e01390285556c4de8ee9289d462c0b59f22b.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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
2.47.3

