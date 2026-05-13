Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46926CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FAB83FB0;
	Wed, 13 May 2026 02:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="eI/TqdbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0E4838BB; Wed, 13 May 2026 02:26:30 +0200 (CEST)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C19A83CD3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so14830632eec.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631986; x=1779236786;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jzv4BaBxCuRYo/Hjk6azVmFXlnxoOL8vDXscgwE/2yE=;
 b=eI/TqdbUsVWSo0kNuUyQsgsoL347+Wmn0n6OHI3aLHYuY5nj8kzn5puArVAvrEv0ft
 o3vCVq2aXH9X4XeD5bq4HLbLwdTxMiyHy+6rjoYx96GnktfepQEzmz7V/0wCSDLPkWkJ
 UWFMndvM+CWeXld8pXLciX1t0cI6vZslAdZ7+LBuGp7xWTstKY6hKOkw2AIeR/93/GzZ
 wABKP0chiRFqiY0cLmZIU8wQyzdo7LijAGmU7CDaASikCFU0No44G2rBqbcWQTUOpfP+
 RLQu1VXpr6PntQP3qNDzUWNe5ldKoqGbEFy2+m7/K0Bh7a6ka/YxVU6K3NNSDhKrmmhK
 jgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631986; x=1779236786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jzv4BaBxCuRYo/Hjk6azVmFXlnxoOL8vDXscgwE/2yE=;
 b=W99ddNfkAW/nFrz+TMMTm6ESAGvg5l74PZn/F7uIVD0MquWhYA3iU2iv6G/0ltKn5t
 V6dJauw8IlmphTUGliPiedr3h3lrP4Avoh24ynqdtleZmZH/BheGWe1W/KcjV7pacIOd
 Jh+hkarBLaCkkJzu3dGsxmm/wj0rIh++8ahaPzSoQhODekZfEq83Fe0muKhzxuAl5CUJ
 5yz93RoLm01rXeriROJFNAlys8qRHCrkgPHi0lM3+chU2w/bwPXfyXemCJ3B0Sz8vJcn
 1h6SzPkCVbxKQihwwcDLKVYJ0MhzLfDmS8MUe9XRf86O6pz7kQGSX/YmzG+HmMggp4K+
 Qg3g==
X-Gm-Message-State: AOJu0YzWMK/01hJgBQzLL4XRr3JJVG5HcCi90wxDBwa+NqAYrVF5lBYh
 l6mbLw2rRiaOXiSk0e+uqW5/b/V8rEWZjR/2UsGCQKLw6MZyUq0iGnpSYJj8QQIXslhC2jaWoV2
 DcaoZWtk=
X-Gm-Gg: Acq92OHbgLDptdIaNVMga/OsQHVM7qoV5iOMDX71gAujHI5XMKisQUBCq7dbb2MFpLS
 mXgjxOhy2um9dTZ1fLdq8Xr9Xqg9slq2VbxkCVp9kzMsrttrL1vMYhc+X4UK4scNeSIlAqEfUSZ
 834DJDnTqYAGsnhw2f9m0ZT2RzrdUZ3V8boyiCchEVbEihOFQYNw1iA5pVbHZaqg+/ua2mdJ0bS
 XmkvE/l8mZdp5LUUDNy8+ZBo4Jl4elixdWOeNOpQicEuRsGEMp1lruSjvC66bAh2h88pVZkWRS8
 T3XyYA4uCE08nuvPA0eJ3Dmz6wChsxFDjsX/zxMgMqf/DNTSEWWdCapMdhlydTLYdgYzIBHam5v
 CGgEYHIq6Jtdn1V2j5Mhzzi6tXqdJMb56dkBfA0dOpQRCYqPpdjmgDVz3Jp48lBOpQGfEuXHYjU
 LlQfHGNEEKmryaFGLta6+dDxpPf62D5Wu4hHGGCzq+rGH/96Wd4zBTEtdEle4f4DBQd/kIOUP+9
 xQ5fL0nAdILI1u+PYB0YaNJle+I30cT
X-Received: by 2002:a05:7300:a887:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30118da9372mr728637eec.22.1778631986250; 
 Tue, 12 May 2026 17:26:26 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:25 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 01/14] tpm: export tpm_show_device, tpm_set_device,
 and get_tpm
Date: Tue, 12 May 2026 17:26:05 -0700
Message-ID: <20260513002625.76915-1-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:49 +0200
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
2.49.0

