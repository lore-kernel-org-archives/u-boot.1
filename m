Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C89606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FQDHtiZX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81EF640900;
	Wed, 21 Oct 2026 14:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WA0f_oq5zsdq; Wed, 21 Oct 2026 14:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB146408E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591793;
	b=YeorQPDdQoBrWRhRZLRlfG8E0zkoMigk8ZUap+mv+7dAdsTyngPF6k52aw3UwnDhv6RG
	 e7WnbmuHsHiylWjb3mlUXd92kGKZnZgQhQhXEmLbpK+RGFBpdeQLeXM+2PZBMf6xOozVP
	 ujisPxi6lTqhnjLy94Cb7vAp2boriKfRwT5YeFuBm+q51s+tnTeDia+0QvniD4JL6zCL5
	 WOdVZRBEdxpXJRvLb4i3biNt72ZvqutQIHoWbbbz9g86BnmO72vDNKGcH+qDROq2ciU2u
	 ASE7huFDzdijsQ48cfbVLfbWehcImJugwE1HBVqRaI/rG7jdf+m4klmuov75+UlLWyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BQrWjb0XegIVABzTD1XMf1vzkl4Y7jfI/omDvc/Lc0s=;
	b=lz9e90AHSevXMWeVUznv0zjGh7729TFzrCA5X0MWgfAIa7nKlGk386xvi3UvcP4J1jXU
	 XmOLwanl9wLpqMfG0p/8ZJSdc+zbx8TWbsL3bj/unOsKmQd6ocWLSZlKgqI1Q+ATCbI1Q
	 A09fhbO30ZMXcyM6p1/4KCemr1QvwUvQaDUCo2x94jt0PoKWEyNW/gTHgRNqqJES+8Afg
	 G0kUR6T6ccHDTb3I0mP8uhbOMMNZ931weWpGxPEQ4sN8vYD5aD7xen8c+bDqHe0p6fBNo
	 EBfnEfZC9egv6qM/DoDnYvg6JeWoSZBv7VZwUUbJfuXjDXkX9zbaw2TrXms/Z/eqB4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591793;
	bh=BQrWjb0XegIVABzTD1XMf1vzkl4Y7jfI/omDvc/Lc0s=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQDHtiZXvYPPdotlQmoidRJgB7YJEs51rr92XNPA5uJgLiP6pX3QUbv/DvUR+RJNC
	 7N7NBdPrzILiOcIm4pU5wLiVbSs3Qe6c659SvmutsZgVAAqrWUNNsEnBln2E+QM24a
	 pwtMB0SxtlgoWsQTljxe+2EcGph9ttEg3UavFdRhXOFPXMAvorSaYso7j6SFtXfzE/
	 A7zOAHm2VhOROz0i1Z05FT7Dd1Imlz/zKmJuTzXTCOpTCEVMI9Hsf7i9SFGzmlj23W
	 NJ65CugrHTLVply/9skEZFOIdz9tXvbTvtXDlxvu9Hsda27yPYytR1xE67MLAiG4J+
	 YlRbSg+4xjZ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB146408E0;
	Wed, 21 Oct 2026 14:09:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B62F3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D346403AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cghwuMw_Y1a7 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 656DD4039F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591792;
 b=Wk01oE5VK7sTw7X2yRZGmP0VIxwp5BitHOSmvO5lsEJEvOoPSh5ZbTTR7BPhCIhv6FmP
 ugSsmxqfQbusIYFmcOoh3Rntm1BEgPA/RJs1xKizkBtK2zTFnXbd8nuQq4/PKfDQA0t93
 Glrbcb9yQ1wO5OcoHZgf/zgdsfO+8WtyVmwkgxYktSofFITrYmzjDslzh/NcTbXqq80Q1
 LFpPmH+uyqyB9pJ3K1HRBX/RCrk49vQwovhah2ZBfzMxQJ7gZTwFtdsGArZM5gOUoIh/3
 IYv3EgPOi+KTQmrZe+bsgsFuSOe19lnsBOmkH5jibvc5qWZCvyzSHY6jSAQslq4Matw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591792;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=BQrWjb0XegIVABzTD1XMf1vzkl4Y7jfI/omDvc/Lc0s=;
 b=STdQkqDAdZg9vaEsqBTT41hhTPmLI4FB6JI3VCVWX83ewnfYCBoVaaWmsO4uSXJPTtEb
 hBS1DLBOQbTtLYs8XjssJD5GGXGxMaKfhgkTo9n5J0WCkyAKfew4HDVMGb0qQENueIGYW
 7FDgom2O6UarQu7fJQLuoVtplVZePKnGH3t5YCK5wUWWKyBy7+finowNFIXR504Z6KwL3
 Ri1lJ5PHhHK5UiilNg/HK0rvY1/zQF52AUv9g9FPSLuVKSxRF9vjHypKz7DUvBqF+z2o6
 rpHtOGJHtjhC+v5Q4BwTqwcTMngFNZUcePqikQqBiRyCqiWFRybgUfU9LSc+k54UxeQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 656DD4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:51 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxf-00000000272-1J9E;
 Wed, 21 Oct 2026 14:09:49 +0000
Date: Wed, 21 Oct 2026 15:09:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 07/11] boot: imagemap: name the device after its partition
Message-ID: <301f7c2a622f7204579280ee9165eba893f07a9d.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imagemap_create() names every device it binds by index "imagemap", so
two mappings taken on one block device appear as two identically named
children and the device tree does not say which partition each covers.
The name also comes straight from the caller, whose string has to outlive
the device for the driver-model pointer to stay valid.

Derive the name from the partition, by name where one was given and by
index otherwise, and hand driver model an allocated copy it releases on
unbind.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: The named path no longer copies the caller's name through a
    fixed-size buffer, which truncated it at 31 characters; the name is
    duplicated directly and the buffer is only used for the
    "imagemap%d" index spelling.

 boot/imagemap.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 0a156e010ec..d46c1430fb7 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <imagemap.h>
 #include <lmb.h>
+#include <malloc.h>
 #include <mapmem.h>
 #include <memalign.h>
 #include <part.h>
@@ -442,6 +443,9 @@ int imagemap_create(struct udevice *dev, const char *name,
 	struct imagemap_plat *plat;
 	struct disk_partition info;
 	struct udevice *imdev;
+	char buf[32];
+	char *devname;
+	const char *base;
 	int ret;
 
 	if (name && *name)
@@ -451,10 +455,28 @@ int imagemap_create(struct udevice *dev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = device_bind_driver(desc->bdev, "imagemap",
-				 name && *name ? name : "imagemap", &imdev);
-	if (ret)
+	/*
+	 * Name the device after the partition it covers, so that two mappings
+	 * on one block device stay distinct in the device tree.
+	 */
+	if (name && *name) {
+		base = name;
+	} else {
+		snprintf(buf, sizeof(buf), "imagemap%d", part);
+		base = buf;
+	}
+
+	/* device_bind_driver() keeps the pointer, so hand it one DM can own */
+	devname = strdup(base);
+	if (!devname)
+		return -ENOMEM;
+
+	ret = device_bind_driver(desc->bdev, "imagemap", devname, &imdev);
+	if (ret) {
+		free(devname);
 		return ret;
+	}
+	device_set_name_alloced(imdev);
 
 	plat = dev_get_plat(imdev);
 	plat->part_start = info.start;
-- 
2.56.0
