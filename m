Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A09C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35170869D1;
	Thu, 24 Aug 2023 21:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzhG6LTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB445868D0; Thu, 24 Aug 2023 21:56:09 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1858683C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7923d27b9f3so7190939f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906965; x=1693511765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et6VpVaGKxM5prPOmsAMwwYGD30KXmFYX7TMtGQ9GLk=;
 b=kzhG6LTAIuhh7W3CSSyotqnH2kQkoDChsPuSnlVjvG9sameeMwiVRZRy6wCNBiABJi
 QxCCyJzBdCk5CqNk9OJe6YX6ZPfGstUm/VI+62wdbrvsLrLYtl7LrS5pSlU3aGfvaVmI
 OIVjE/aL0QIh3GXnK/PLNqJMkU7lZbwlsV2xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906965; x=1693511765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=et6VpVaGKxM5prPOmsAMwwYGD30KXmFYX7TMtGQ9GLk=;
 b=ZJrSii3ee96u+pLrcBXGhtMvGRQEyHh9wqEq+fBf33Sy9CmvDsQ5AheBzup7zLeUjy
 S331eQJuZYjWK89rxY6jUWQfcdIAR/TIZVUSA9NmT7/fsxVSLn6JqgLqe5HIp/eSQrSB
 f0OS08MAhR2q5/zDMaUcg9wZxdNKkDiB93jJBmOhRgRMuQl1Wcux4t+BS4yRcPSYujOh
 CUCP6aQMpvWwaxffkq0jPtb/vtMdbnQ/NUfCUxFTPG6ppSVnRq5JnBjrkyDnXO8+ehAs
 FCl5ehS0fab/+0tCAsh2Z7TYuaDV4xZj+gKq78bJJNyXaIh/jY7O7cNHGvlj+J1MlxLO
 MPTw==
X-Gm-Message-State: AOJu0Yxl9tMThVJGDqwE5BIfCIF2xah7ZBWxQx6bVymBNZKa5DIqgKaw
 +4XOBqe+C0uQ+VNzub8iJ8TulnSHOWPeJ5qbnqY=
X-Google-Smtp-Source: AGHT+IF9Qyo3b+VN8a+LxbJYM+YsmgP1OWgqwNbiLJWvDyy/Jx+Eqdz3otmeXrwyIqNzoAEIxVDqGg==
X-Received: by 2002:a6b:d003:0:b0:787:1d0a:ce81 with SMTP id
 x3-20020a6bd003000000b007871d0ace81mr6982815ioa.13.1692906965727; 
 Thu, 24 Aug 2023 12:56:05 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/23] part: Add comments for static functions
Date: Thu, 24 Aug 2023 13:55:30 -0600
Message-ID: <20230824195553.1685996-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

Some internal functions could do with a few comments, to explain what they
do. Add these, to make the code easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 8035dcb8a429..9190e8806187 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -26,6 +26,12 @@
 /* Check all partition types */
 #define PART_TYPE_ALL		-1
 
+/**
+ * part_driver_get_type() - Get a driver given its type
+ *
+ * @part_type: Partition type to find the driver for
+ * Return: Driver for that type, or NULL if none
+ */
 static struct part_driver *part_driver_get_type(int part_type)
 {
 	struct part_driver *drv =
@@ -42,6 +48,22 @@ static struct part_driver *part_driver_get_type(int part_type)
 	return NULL;
 }
 
+/**
+ * part_driver_lookup_type() - Look up the partition driver for a blk device
+ *
+ * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each parition driver
+ * against the blk device to see if there is a valid partition table acceptable
+ * to that driver.
+ *
+ * If @desc->part_type is already set, it just returns the driver for that
+ * type, without testing if the driver can find a valid partition on the
+ * descriptor.
+ *
+ * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
+ *
+ * @dev_desc: Device descriptor
+ * Return: Driver found, or NULL if none
+ */
 static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 {
 	struct part_driver *drv =
@@ -83,6 +105,16 @@ int part_get_type_by_name(const char *name)
 	return PART_TYPE_UNKNOWN;
 }
 
+/**
+ * get_dev_hwpart() - Get the descriptor for a device with hardware partitions
+ *
+ * @ifname:	Interface name (e.g. "ide", "scsi")
+ * @dev:	Device number (0 for first device on that interface, 1 for
+ *		second, etc.
+ * @hwpart: Hardware partition, or 0 if none (used for MMC)
+ * Return: pointer to the block device, or NULL if not available, or an
+ *	   error occurred.
+ */
 static struct blk_desc *get_dev_hwpart(const char *ifname, int dev, int hwpart)
 {
 	struct blk_desc *desc;
-- 
2.42.0.rc1.204.g551eb34607-goog

