Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3FC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4447F80C71;
	Thu, 20 Aug 2026 07:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-IQH6DmCuZr; Thu, 20 Aug 2026 07:15:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210123;
	bh=B6NYLk8vT9y71VbnybCBeb3vSd3ilY3xx4Df0yXJpxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NgF0XXdJLh+mF+VLQV499+74t/gAuaeW3qtDq6AdYGFbV6RNxZWht+3Iqjb+tN/yY
	 2A21PGqAtAR2sDcPtZ2Es/im+0kboXbCtc+q3PCy3SLIDREcLNUROYFRs6qgKBigZE
	 +TTkeOqeqKEu7a90bCBW6HVxC/fim17C1KTflhDRk76VKj944lH+wWMZF519uLnym4
	 6/XwxehinQuEIlrFXUPlmQ1SN877Ubn7TOdzb3EpIue1WlAVIcK/X4Mxb4sQ8S29mY
	 MdPvV0uPbR1DkmszqgL3UM/oPtER5VUBxGM4ap/nvf0vdDXXsg++kxjEFzfs0Q3HzT
	 qb4wLrVFiGTZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6331080C75;
	Thu, 20 Aug 2026 07:15:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8427C39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A85640055
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBeXTIp7EWyY for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bL9QB5Fr
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBDCE40253
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so4014835e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210116; x=1787814916;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B6NYLk8vT9y71VbnybCBeb3vSd3ilY3xx4Df0yXJpxk=;
 b=bL9QB5Fr1HhsSm76wpAKm+yDvXtt+557GThky1dCglHbWOqdB1ozDUQuY4LCTU+zOd
 Ies+o4trzgEblg3XAyiAZgl5zD1nrt7DRjDN8xKmks+StP0S9qzkAVMuEg/kSf9HtJd6
 DjuTt2Q1Fl5UDqhkCatfOny+7JpmsmpmuF9kMSN3SdvuqB3l7ME8OTXgFSPmZn+o0dn/
 GDyOjgP8Gxz+4I/GktTnGsdTPNLLTJbiNeF/1tA7ECdffIjZdIDoW7SOWQC1RhXX8Wbq
 P74uxSsoc3Ola95br0NFH3mEftpFZxIG1iYX23Wn41TbH9DJAGKvO6xkrxWrSOnNdNI9
 Z8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210116; x=1787814916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B6NYLk8vT9y71VbnybCBeb3vSd3ilY3xx4Df0yXJpxk=;
 b=eyvpk48nhdywUxS/vDvjg93JwFW9zYJ1AuXSs38rMvI6FPsDbI38yUVx+Jj2pA+hiA
 MQc0ekVCOENtHGG+UUUAT0BMEUUuOie8fhqsXtIWoiBuWHppRgdeRGdRXoMlWfkWM6/X
 Dnik+rCcuK1RiLe2N5fQJlH7XBCwXywa1JeSZCvngEpTj41QzNoMsVmRr7i3oZhI1AZE
 ggz8b9sBlIVj4aBiYZPcocDkBSSh9W38m/ozTXaaZLcwuJ5QmVeUbRoOYN8BjdRTCLBy
 Q8XiVaVuML4I4DfMfEfRYUWbm9OtyCYF6ibPuaVju1sYDILIzhOR54VKT9mb2CvGepca
 8UQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5ZhraE6vJ7creV/2Y1dp8szw7aZtTHPIB1ciBDBc1epXHIz0LFfgJoXlsybFMRIifgdAZTGk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzhYfN7htx6+JEU/qDEwtnVzJNw5pRBWn3+M9d0ig8Gl75Zs6ia
 YNatnY8H9sPFX+kOE6tSyBRyD+cCmaWZTdYotkbmrtQCRCHh3v4RnduE
X-Gm-Gg: AR+sD11E9WkVpUC0C5lYUnk5efug9McKAyVUZNuGRbKIJhhRCUmRMDbScELkL9SGqUZ
 +Jp68r3HAar4TDsaFXOpIxUbgZEGuW6nSJqCpmU/+tAW9WbB3OtAwxlvE4s7zj4n19/AAZt35Er
 vM76KGsftZPRmsX3tQ41cBJSS0p4Sxg/6J6jJmRz5mbQqW6v3DhLF7e9kcjmSTQapoRkv1UmCF2
 yWiugeWqpN8BBoDQ3up18KF5vQtDRu2cJ0N4e/AAfBVioCGZsvO5QS4gnNfpuRdbGl6oG/wo8hO
 +Fcn+9wCaHCuV1kI8F+IEkKvFVh1Yr2cywWENqd1UvHLfWbGwefFSH080aIBmuzJrL9+3wFHJbA
 TJmxbvFIu91tnRoTGhnCVDL6HyjW6pxH4fbQG2t7lOeYrczp3CsXVMwHXkfX6mDBkj0rhTbbMCN
 x0ju29zlqLw0STCKcY40wKgR4D3mH5DMtjrPCSO/4H1gQ5Rtja2i6kjP4j1j+CxPpgqA==
X-Received: by 2002:a05:600c:3e06:b0:499:8d9b:832c with SMTP id
 5b1f17b1804b1-499b06adf9amr35999865e9.4.1787210115356; 
 Thu, 20 Aug 2026 00:15:15 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm158151475e9.11.2026.08.20.00.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:14 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 3/4] dm: core: add ofnode_get_alias_seq()
Date: Thu, 20 Aug 2026 09:15:10 +0200
Message-ID: <20260820071511.1036506-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071511.1036506-1-mehmet.fide@gmail.com>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The sequence number an aliases entry gives a node can only be looked up
for a device, through dev_read_alias_seq(). A driver that has to know
the number of a node it does not own, one it reached through a phandle
for instance, has no livetree call for it and is left with fdtdec.

Move the body of dev_read_alias_seq() to the ofnode level and let both
of its variants call it. No functional change, so the moved lines keep
the ENOTSUPP return, the #if and the fdtdec call they had, which is what
checkpatch complains about here.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/core/ofnode.c | 20 ++++++++++++++++++++
 drivers/core/read.c   | 20 ++------------------
 include/dm/ofnode.h   | 14 ++++++++++++++
 include/dm/read.h     |  8 ++------
 4 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index b5d13c43db1..81d91ce5476 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1233,6 +1233,26 @@ ofnode ofnode_get_aliases_node(const char *name)
 	return ofnode_path(prop);
 }
 
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp)
+{
+	int ret = -ENOTSUPP;
+
+	if (ofnode_is_np(node)) {
+		ret = of_alias_get_id(ofnode_to_np(node), stem);
+		if (ret >= 0) {
+			*seqp = ret;
+			ret = 0;
+		}
+	} else {
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+		ret = fdtdec_get_alias_seq(ofnode_to_fdt(node), stem,
+					   ofnode_to_offset(node), seqp);
+#endif
+	}
+
+	return ret;
+}
+
 int ofnode_get_child_count(ofnode parent)
 {
 	ofnode child;
diff --git a/drivers/core/read.c b/drivers/core/read.c
index ba48862f44b..985f6128d97 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -356,24 +356,8 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass->uc_drv->name;
-	int ret = -ENOTSUPP;
-
-	if (ofnode_is_np(node)) {
-		ret = of_alias_get_id(ofnode_to_np(node), uc_name);
-		if (ret >= 0) {
-			*devnump = ret;
-			ret = 0;
-		}
-	} else {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-		ret = fdtdec_get_alias_seq(gd->fdt_blob, uc_name,
-					   ofnode_to_offset(node), devnump);
-#endif
-	}
-
-	return ret;
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 int dev_read_u32_array(const struct udevice *dev, const char *propname,
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index c905e86b283..2363ca0ed33 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1180,6 +1180,20 @@ const void *ofnode_read_aliases_prop(const char *propname, int *sizep);
  */
 ofnode ofnode_get_aliases_node(const char *propname);
 
+/**
+ * ofnode_get_alias_seq() - get the sequence number of a node from its alias
+ *
+ * The aliases node can name a node with a stem and a number, such as
+ * "serial2". This looks the node up and returns the number.
+ *
+ * @node: Node to look for
+ * @stem: Alias stem, e.g. "serial"
+ * @seqp: Returns the sequence number of the alias, if found
+ * Return: 0 if found, -ENOENT if the node has no such alias, -ENOTSUPP if
+ * there is no device tree to look in
+ */
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp);
+
 struct display_timing;
 /**
  * ofnode_decode_display_timing() - decode display timings
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c..d0c17c3d343 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1168,12 +1168,8 @@ static inline const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 static inline int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-	return fdtdec_get_alias_seq(gd->fdt_blob, dev->uclass->uc_drv->name,
-				    dev_of_offset(dev), devnump);
-#else
-	return -ENOTSUPP;
-#endif
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 static inline int dev_read_u32_array(const struct udevice *dev,
-- 
2.54.0

