Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB3606A324
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UxmDSBtr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpbkOHrR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7781440835;
	Tue, 20 Oct 2026 09:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZJeHLcEpkom; Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FC1F40856
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488391;
	b=qnUfhSjtlhafAUcbDYTyN4Dqv1sFNLtdpu0OJ6/66A45KC047KMka2dzPLrRC/9yoD1y
	 xUf8wQpcSM3JV3JIxFSLo352bROFVYk70yOAtNcYl4sob9WGxUh7xB0tORxEkDVtOEAUw
	 JMaMDcVcaXe/Z2ov+M5ZXTXCyfqxnW7TDu9T3KwVKEKPFNrjrEFBLNql5FUMLuaTrrgCt
	 PMZS5fv0C51JDDKbsre3H+7NX4TmAR/h2oauwfKXVrFHaoY253mXpS3mgIGfO/sRU51uI
	 fuWoarCIZ2y9XLGE2VRWtJZv0ZhK/QEfX15RR5qP7seyGPZv4t+Kyzn+zGaiv/BRLkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NyM2T95MazrzdnFF4PPZhswHAEBjrsapLRwiHOd53DM=;
	b=F+l5CPJn068TDfOjJ+pDvtwR9x7ta/8Mq41t+U7tbcyiZmSiCKtUVi4Qg+RpWBXNkekj
	 d0IZgIE3k2ul1jeikZowFU3IqqdkMkydxFEEL9xsKsMixPuQSAHUodLhb6Bvz9VpJQll9
	 E43idkogWbkxWkVdEGGCYY4KOH9qwpovDJeXlE8Kqi7zMRRtIJvwLJBhCzpeNH0Jzds0O
	 1rsa/FyQahvu9+OTm+ysP+PeQ8ilgRPWmV3SH1BXOAZhmlIZnwy/Tz51KSrZz1MAhDoGd
	 VOZD3a8bsBiglDiVBJvlslOzyRgVgiEp2eM/5GqIL7/3qvObpADvZXeoJSDiPafIKgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488391;
	bh=NyM2T95MazrzdnFF4PPZhswHAEBjrsapLRwiHOd53DM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UxmDSBtrSUIeYugwTBZ1CcSZRQlljlZWWDgpX9IxtEMLa9U7gDBIE/Dqw395iEVAo
	 9WZR8VKHJyzZD2muoHtGcQWj9+Zx30hPmJYKs8OcNjRYyuhYIpDe/zyTasOtH44/Hi
	 uuuWRCB0GqbcU0j7S8XLE+KZtDh9N079s5CcduIU68E68/ZlIpZjidxo9RTh5/hsWC
	 es/X4RUY2qE7tu/BKPT+R1wjPkXXtPbVSeAMUrOj1rVhxGQzK0poSbE58owNeWKr9h
	 zAO5djgIIzJjSbmvs+YYq3lapjjvls6J49prRr7gMG14PO/xKPoyoMgVtlSp/IwoAN
	 jFYLVtzcSGsoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FC1F40856;
	Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 466363A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C8F340328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XknleuK8WlMB for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 835A64016F
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488384;
 b=ip8rCkFe1+lIqw5jmK/zaiiupONC5lsLIIAGhlztXy6lXgjKA9laNV9j5xqabdHpphu5
 6+C7OmCwdAo7tCCzu2kuAJMAQZzNDqBqcX3kxtC5SSb6r0UBAEw8etpOG7+3Q+S63H2x8
 ucjd99G+CAAfq70dvxXFFaU4H1XtOthDVX+qfGttE1439/y2dAQCfxL0/9hbISJ9o/K5I
 5RT8LyH/rc6OkvmfG71YMUdvinFaGqn5YYfT6/2HA2wcssZPRX6w9Zqkv6UZVI7Yfr6jm
 fxGbQxg2h2GPUhUtS7hx+QW3hHIkuKOSz1pat6puhzOeUGtDovf0zu0hAvlaNvm9pMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488384;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=NyM2T95MazrzdnFF4PPZhswHAEBjrsapLRwiHOd53DM=;
 b=orhOHRDux/jysX7YbcflrVa5dHVEcpXaZ73ue1LBKWto2ETqThdMhCYntAPWcO0sUIxU
 tL2QTUoP+kvmsYM/fG+JjH1n+BL2/zzdEBt04hlGjnH0pcBN+c/9RSBl5TFrEQG3ByTdL
 khDYyLlOrFxeAZ7PWFSKioRau0f+DLYWDzEuTE5s5vzbFvy4qVwkFkIWNJBxr9UlmdGfO
 X8lJJr+zsxBhA757ecC4VTkE4G+tFyRMv4POS31AHadbthzqLZ0SQommSYyS5r82ZIzv3
 TE55mlLgNLy4UWERK2pKc9kHKGM03dHLSmWi31zmFLZIFWSpVNhFE50/dPviyHusl0w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JpbkOHrR; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JpbkOHrR
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 835A64016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AB48439C2;
 Tue, 20 Oct 2026 09:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6211F000C4;
 Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488384;
 bh=NyM2T95MazrzdnFF4PPZhswHAEBjrsapLRwiHOd53DM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JpbkOHrRj9PlsveP8vQDWuiE5v5cqvJADUkaUsINEjcg5HVNC/S2dukOYUA0iZa2L
 gd0etzMr5/yOC8+Kwyu+CxhdCLozMZRhsGmnx3qA7JiICXMz34kZFc10yiYCaQ0YW5
 YgrnSXV+ciwkFgHztK9ZOjKUaXyIkW4zWJ1YsJIS9Kr23GvOqkmNmkrkRmElxZ0fOv
 yHQ9Khih8Ss0/U37o/iTy7oZCMsjbRnbyFxMlfYeUF5pvsjyXu4jNt63xDtTfPvXva
 AFj0I0wY1WzjKwrh4RpnGskaeIysVhbTF4Bk1IyL/8Z+64tdIKR1Lyvx6VBrLftNa2
 CaVT2GjfjxydQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:55 +0200
Subject: [PATCH v2 06/10] test/py: android: Add setup_android_v{4,2}_image
 subfunctions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-6-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=D2JKF12ba1TT09dKSdL1UcRBoYnamyv/5cNH0pzv7Wk=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9Z14/XLD3Y9nXzsQaJulndJo9/TyOXXD24yrLl+poGn6
 hOPtY9gJ6MxCwMjF4OsmCKL3kun5dvks/YFC69lgBnEygQyhYGLUwAmErWZ/X/yT41GqYygWk5p
 W8ln56V0Uub8mvVi37y6783rslK6nvxOcVPy/FXisYojVf+hb7L0dGH/P6UroxuC9Sq+c5c+k/A
 3eMX/PCBgl+A7/bZNXZULpn8y6F+Wc+CvzIQIX/YDT84oemXmCm+rNNnOn9bsXZ1lGvLa9F1JVG
 OWyjTm3d5nTIOVlCcVS/h8Dm93Z22YIqA6ceo1vfP9XStnvA07cCIl8uBu/h9JvIl+nhJ5a6+1l
 slrXnp/9LbKSYfz+yxStkaeTDGY9YzP2G3RhVefXlV17VjlZtm9Wm39r5o7Qf9PbXjjEKdiojJV
 mbFVImP6erUl02Y7r+aq5eVa5yg9NcssxWnB9rpqpS9zAA==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To split out the logic even further, do each image creation in a
separate function.

This will make it cleaner to add future images as well.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index b5fede8ebf0b..abdc6cd28744 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -56,8 +56,8 @@ def create_gpt_image(ubman, mmc_dev, required_parts, images):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-def setup_android_image(ubman):
-    mmc_dev = 7
+def setup_android_v4_image(ubman):
+    """Create mmc7.img: boot image v4 with vendor_boot partitions."""
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
@@ -69,9 +69,10 @@ def setup_android_image(ubman):
         (2, 'bootv4.img', test_abootimg.boot_img_hex),
         (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
     ]
-    create_gpt_image(ubman, mmc_dev, required_parts, images)
+    create_gpt_image(ubman, 7, required_parts, images)
 
-    mmc_dev = 8
+def setup_android_v2_image(ubman):
+    """Create mmc8.img: boot image v2 without vendor_boot."""
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
@@ -80,4 +81,9 @@ def setup_android_image(ubman):
     images = [
         (2, 'boot.img', test_abootimg.img_hex),
     ]
-    create_gpt_image(ubman, mmc_dev, required_parts, images)
+    create_gpt_image(ubman, 8, required_parts, images)
+
+def setup_android_image(ubman):
+    """Create disk images with Android partitions."""
+    setup_android_v4_image(ubman)
+    setup_android_v2_image(ubman)

-- 
2.56.0

