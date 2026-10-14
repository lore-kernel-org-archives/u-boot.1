Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064EACC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A961860816;
	Wed, 14 Oct 2026 08:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-nOpYSuExYG; Wed, 14 Oct 2026 08:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 001C3607CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967202;
	b=fkBdx7jWYDxRL/oyyRZt/qCnRhZlZolxeU7WSShORGU9DzXrn3fj++CLX/2444kQFimZ
	 vFVbdyZhPqybNkGarZR2Jfl+A3wbzuffyj7I7XivWgJYfDt6jDo8WJEwNCsJWwv4T9Pjo
	 oxVCm2c9RrkpR5vMSpy3Jl8MckHSIff4jy86NusqhcaFVsfWDh3suXBAgAQjUzeSRQiGi
	 7InRNvTTgSwejt4htqWArGNcJHKXrKi6NqcG14Y2Mb7K3kuUE6FhctGja7qs0S5s8lXui
	 uRLRV4/zyZOs71rkjRK8EfykcIeeEpf5v6ncbl1UbLPvWOWoI54MMDrBq4aExLPDN2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k843fVKKwwX/UnP+oNxzqOoyoDuqtip3meNjhWUr0eI=;
	b=DAyVD9fBFC5cEfji0H5/XVdTDyfdcw1L2cagr+JFH2EH32q9zlms271sQ0cLTQ91fjbO
	 RW0gtREGdOEUWGhALYRuO/x+OfLRSVQzIxZ/ZEeht/JGpi4butnOxf6VzjKC+wPai6H1x
	 vU52tn5xbqHas2tN/8orxdZG/FnJyDFs8IcfJEvLuAd2hh2gWIVJbh9DcBsYfLLr13+cL
	 f0R/I8SfVTA6iwytcaGfEhxuq+ghz/siZZAK2ZGur3Aow14MWhUpCq3yHbycwmCnPBipm
	 kIk9aqiAg0lgd+eBnowWTs+c/K7WyPJN43/8tgXmN6XySaiBzuGwbN9APEUXJlV1BtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967202;
	bh=k843fVKKwwX/UnP+oNxzqOoyoDuqtip3meNjhWUr0eI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/GuN7OhICP4LiEDXQ2pwZVqV1Up3X6vBl+KHyP/wBpe13O+k19fjYau6rxCzDFgC
	 lkH1zYTr3GppVCHX/toE6FtWW2FyxWExSYBebcMhsETcKVZk7IXaBpXBnDRG2ZYaNl
	 fokzwmASr/3ltRpp/wz8SXzDQrjThVDLkAOn/purWWW900IMQlAY6XXfQIHT81s+aU
	 mRjBnl2lV06z/EqbR+lO7EcG9mlChwBFKndNerRLs7zIbSI/eukwGOVmeEl1iT1ACA
	 NHhGWOoW1WVXw6p/NEjY/ScpK6DhzJgIWXrg9JyNc7+kcbvtzn+rpFfHsEeGzgpJnV
	 bd/q7W3gJnq5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 001C3607CA;
	Wed, 14 Oct 2026 08:40:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 515972E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 433E840080
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ll2ZS4W5FVqK for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8D7B240079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967199;
 b=iq45pKe5VDuvydBpZwv0gd2sReMiznrx09RqfE3FIABOairsaElWHHB49QZpSX8wUoMM
 yB2tZE2+pxVsDS9FRbLPUdvDjDc35soUrgHgCFkSsThHfHxoAJBRp5irYfBAPFXCQch7a
 vkPaRr2DUAutQ4BFfNHpLC5ERcLQUbhgxtCaPlKJFEsYI6P8NpIdwZcfa0Z1QlMyUkDwD
 w6UaA8Qe0SadvjRTn0aQk4tzEJzWy7ohQ262Dp8aIpQUR5g6eU5fsXN1Y+HgiBbr1q3G3
 gOU9qZimJuZ6Ij6Sc7b2XGsCjS02e7VOZWgfHSALKgj+mSghNCYkuJhDoBWFMPkpe6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967199;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=k843fVKKwwX/UnP+oNxzqOoyoDuqtip3meNjhWUr0eI=;
 b=U59mwfhWm0wxyVVqAUw3YRJQV5DQBDtuNUclM/n3Ukphs7CI73niCPA/BbvY+Gl06dz/
 vb5e9pbL64CFo6zrp9v832WoabM4oE6hLhHKH/L6i6y206s//g5Tn+f0XIXuD8zSGmfKP
 c4xDH3gVUgl0+/3MWdb904PF0BhMjPjYJEYiHPjRlWtbYlgk4RANuwkEAuWJL77QTcHzA
 wApK3tK9+1k+HO74yWCSdZKNpUxoUVp6+lYsTlmr8VdZNZBaBKHBD6xMgiJC+iU0dwc2o
 1yJKYOifYU4shdNFKJVXj+5RJd0fbO9jAhJBnlQfNbsLLrC6B4wrklr+hVpANBkIMHw==
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
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D7B240079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:59 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuWi-000000005eQ-1mXS;
 Wed, 14 Oct 2026 08:39:56 +0000
Date: Wed, 14 Oct 2026 09:39:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 07/11] boot: imagemap: name the device after its partition
Message-ID: <13d5094ef59c11f53b32a2f6184ec50258c5f79f.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

imagemap_create() names every device it binds by index "imagemap", so
two mappings taken on one block device appear as two identically named
children and the device tree does not say which partition each covers.
The name also comes straight from the caller, whose string has to outlive
the device for the driver-model pointer to stay valid.

Derive the name from the partition, by name where one was given and by
index otherwise, and hand driver model an allocated copy it releases on
unbind.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index e7222d58c93..57a078fbc55 100644
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
@@ -441,6 +442,8 @@ int imagemap_create(struct udevice *dev, const char *name,
 	struct imagemap_plat *plat;
 	struct disk_partition info;
 	struct udevice *imdev;
+	char buf[32];
+	char *devname;
 	int ret;
 
 	if (name && *name)
@@ -450,10 +453,26 @@ int imagemap_create(struct udevice *dev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = device_bind_driver(desc->bdev, "imagemap",
-				 name && *name ? name : "imagemap", &imdev);
-	if (ret)
+	/*
+	 * Name the device after the partition it covers, so that two mappings
+	 * on one block device stay distinct in the device tree.
+	 */
+	if (name && *name)
+		snprintf(buf, sizeof(buf), "%s", name);
+	else
+		snprintf(buf, sizeof(buf), "imagemap%d", part);
+
+	/* device_bind_driver() keeps the pointer, so hand it one DM can own */
+	devname = strdup(buf);
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
