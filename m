Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC89DD3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0795189633;
	Mon, 25 Nov 2024 01:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/DGtv3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D46895E1; Mon, 25 Nov 2024 01:58:32 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA608952A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72483f6e2fbso3290014b3a.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496308; x=1733101108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yiVtXGen04U2jhRL7NJnx1rM4z0X1yIJqHm3jNX7/A=;
 b=S/DGtv3Vcl0jq0BJ4iO4BeYxAXfueEXh0zQbPtX86BRDu+ClhgOeR7w0qNi4sztqlH
 gOLwS5+y7/VI0fXAkkzlfQ6R7DZA0B2UGOYMTiR3M2GrPwCVIcLhK+zPTjuEqAA/Sz2l
 DPJkYs5yIGHKenFGSK2AsyLD4MayqTlqNQySqXZ5WbaWD6iS0QWPiQs99eKvzVX2d46R
 X8cXUxZOocjd5wysRhf2y7WOf+KbCEYYte9yT6IkhBHCcGJdxQzVgCfr2RiHoEruUAsb
 6y4ozWobx+g99xeeHTNabsjeIQiBQwQM4YEN6KSpTFnODS8TEY6RGM+77taTLr3tL17G
 na8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496308; x=1733101108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yiVtXGen04U2jhRL7NJnx1rM4z0X1yIJqHm3jNX7/A=;
 b=cv//q/RZ74Ip2KjO6gDkHesa7kLL+grGlBTdQxa6k3XQMGWc5izhQo1huQAera7ug4
 5HRJ5kzLnK6+F54tsHbGBIjWRn+J5F/R6QfsdJ1E1fo/TirsfVleh/6sKEttvfDNnDd+
 vkjWe9KnrL/iW1JN8iZ90alduUH6SBhUgWdxyk1hZbQDYSwMuAjDl3AZjikRi8hvNGnt
 ikJTpE0eWbR/ukVg5KjaFguH2/bUa8T/LZ4tWPBJ35iPcFWHNTAtgP0Mg4YGWihrlYfF
 oVyBJEjEkV5bsyGdNuWwARvVZmvXvLSDvtGh2LDNnokSsM1KS40tNf+n9hb4yBV0JYi/
 8mKQ==
X-Gm-Message-State: AOJu0YzRrDRgEQ0wqxxxNF9uBBaMLQMdXLykF266qKLrfSbGzsKBr2E+
 /ozR3v99TReZjkcIrQizR6i4HfS8wkxT6nI9YLTVYqzc+QxvzLHplKvmV1J4oQ0=
X-Gm-Gg: ASbGnctwmVxrin5qCS09ta9mkWEGgHWDOVmUQOPpp7Dgi/FcyAf4cy//lkveG+y0sfD
 WprghM41FEYcL0fjwPXd2DWeT7mXOmndmjp1c/bqhHcExXQk78SPqyQefNDnr6nE8ca1xi7Xe2a
 j0Y6ygxD5Q3QeuQrJl1dUfiMXzbO0+PS8/6nKeZb9pssUGC+lUjHdg6+rAUmbVEErJib9xdBhaL
 0Zv+5Fsa3MkxsQ1vxBf0gJ5vCjpzQygN3Y1YSNhjA5p
X-Google-Smtp-Source: AGHT+IF2/n9gVAAVu56XCEDm1ej8gp2udPHoGnJ9jtRdEBM2lKIQH5FkzyxeCH/C7+9n7HhXW5w9zA==
X-Received: by 2002:a05:6a00:b45:b0:71e:75c0:2545 with SMTP id
 d2e1a72fcca58-724df6ba118mr16379917b3a.25.1732496308467; 
 Sun, 24 Nov 2024 16:58:28 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:28 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 02/14] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Sun, 24 Nov 2024 21:58:02 -0300
Message-ID: <20241125005814.236669-3-adrianox@gmail.com>
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

Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
subtype.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v3)

Changes in v3:
- Removed alignment in struct efi_ipv4_address

 include/efi_api.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93..99ee749522 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -616,6 +616,7 @@ struct efi_device_path_acpi_path {
 #  define DEVICE_PATH_SUB_TYPE_MSG_SCSI		0x02
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB		0x05
 #  define DEVICE_PATH_SUB_TYPE_MSG_MAC_ADDR	0x0b
+#  define DEVICE_PATH_SUB_TYPE_MSG_IPV4		0x0c
 #  define DEVICE_PATH_SUB_TYPE_MSG_UART		0x0e
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS	0x0f
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_WWI	0x10
@@ -691,6 +692,22 @@ struct efi_device_path_uri {
 	u8 uri[];
 } __packed;
 
+struct efi_ipv4_address {
+	u8 ip_addr[4];
+};
+
+struct efi_device_path_ipv4 {
+	struct efi_device_path dp;
+	struct efi_ipv4_address local_ip_address;
+	struct efi_ipv4_address remote_ip_address;
+	u16 local_port;
+	u16 remote_port;
+	u16 protocol;
+	u8 static_ip_address;
+	struct efi_ipv4_address gateway_ip_address;
+	struct efi_ipv4_address subnet_mask;
+} __packed;
+
 #define DEVICE_PATH_TYPE_MEDIA_DEVICE		0x04
 #  define DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH	0x01
 #  define DEVICE_PATH_SUB_TYPE_CDROM_PATH	0x02
-- 
2.43.0

