Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64209606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fuvXVIaD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THO3T0dx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B1FB60A51;
	Thu, 22 Oct 2026 13:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mIwd34pRhdEi; Thu, 22 Oct 2026 13:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FD7460A3C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675859;
	b=JAbDnqLOIQOq3ZDc15BIw7gP703YWLA4XOMmJ19DkBQcg8ZWhcPlKBwz4fi4pL7QbACI
	 eokUnWppfo6N3YbYMBfQTUaR11G0WxXX1O/8Ukm+STaa9Y0fDGvKfQgvEFeDQCdj7Skk8
	 lxds3dhQQBQw1Eo2UeoNv+dodjc3UMxj3xwIqTaP/Qvw4lOd0PYEOp1SjY+fro73viKb5
	 e8S9oz7LWW4Kp0NvvQsr+bDoB/WB/VoQQT4O2c63T5rt2kACXmY5AOmUauVoninYjDghL
	 mTp23m/3xYNtFJfbWv45ZIg67JRnc9gAFn6ar565NMceWmHnVLqnTR6sdGXRC5UFetA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VvpIjW7yHisCNhNcZR0eFusscLPUc3q+fjBXsKovCpQ=;
	b=efZpypr6EWHmaUcikVya4Fcu4QoR5vko3SUU62I3++rRExGeYBsE0mRsdnUraVprEYWb
	 BVWBxKfTuP2jtpujSYcCdqtCjRk3SXSfPY6O03rWTPOmMdiBUPOsOSeE0xHbpne5j7riT
	 8VP5KxmsBRqJPiv95Xu+IN8IaySRtJEEr1Gl2wBJfPuioUKMTnCl/pLuVlfp8RJr7J63X
	 zmgrZx3BvXpRPeTaD/U02LwX+GQI3RwjhY9ylpe6MNCyESVwl4vS562jfa7msSo6kMkYD
	 JXiYh8VFy0nS5jQenY2YIrORLLtO06TATcibcXWw2NS2Y5zh8V0YO9pgGoVUbzxEgsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675859;
	bh=VvpIjW7yHisCNhNcZR0eFusscLPUc3q+fjBXsKovCpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fuvXVIaDtQtxsb75VQPtNcS9ZYYSeQOoIRgigvtZxeh68baQ/H+3X4yWAP2pwdISS
	 QOHJoifg5cy/kdOBrdHlIPL4Z3v0voHJJed/xMZeU6zXyVVkUv63zq7zCh6KqDrr1u
	 ewC10WtEJ+NzACDk96mBEdinu0MMTj7XafdkW818EpYbnu3iqVK+p4JBblKubVPwxP
	 0hXg7t/HUNhPPlAsRSmG7mGNvK3g4JBUagc5itbpyBhTTQlEI1tFyoPZIJkLFTmlCX
	 CxO9/HJiRX7Nl2aMBITQBtgL3VPSfrD/prKevLsC/lxuYS10QgZjgDbXzf5GCe6qnn
	 j08vQyGBomZNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FD7460A3C;
	Thu, 22 Oct 2026 13:30:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 557043C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BC4040421
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqB93LF3ABEO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2FB2740086
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675854;
 b=ZV180TUycK6KB4pcsW1CY7PnB+Og9EuxjpCDuQCyXCGQIMOqvwOwY2u9585tleP0p+2k
 JTpbsWUg1yjcyfDmESTkKMYADfaTvWXRvo9KZ/gfE+Xw+l4nWst/eeNOe39rZmQS4X5Ru
 RXyrsmthXkK1A4bYPIPjpzfVrte7nYO9xoy7YXiSQgVln3xlsSlvYPjdMRMs4DVyvDk6y
 OF1acmD7y4R7TGogdYTyAOYWZfVac0ecUwK0iF2NbaR+APNvtdXraBBjtiq/a4DW+mm81
 xzZXMF5Edwd8Y//jc+h87i/LwarPMOwLSwZWHjgGk6YjWMpBpt/hbRTlnO3SQXbyPUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675854;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=VvpIjW7yHisCNhNcZR0eFusscLPUc3q+fjBXsKovCpQ=;
 b=afXzFupjDWTijRsifHVGBhoPMMEY0qgL9uwS3p8e5Bu9KCohlQtRhg8MAvpNno/5O3do
 iAJmxlbxrWSgdPt5ybAdI1mObOXL0sTfzLwfuwCw6PbNEtk4QT18Ceaom1X0Id3n5skKV
 3cSKgfUtRLcwsEIQY8eWzTmexwXEc4gLo8EEojftqqoV37PkbxiHWeF8nnJCxW2lcqA1z
 7Wa6+bZoqcbX+qPzEq9t6h45NSEa3RLQ/3KjyqufaaO5M6eBetZEK9qKozugZ6Om7acG0
 p0EIJnTYp4ZvqHDnPQjqo0aIHD+ryJ0OyPAfjqZ89wHO+TNiXj9BpAViGNiQFE7JrHg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=THO3T0dx; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=THO3T0dx
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FB2740086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2D51447C8;
 Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E221F000C4;
 Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675853;
 bh=VvpIjW7yHisCNhNcZR0eFusscLPUc3q+fjBXsKovCpQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=THO3T0dxy8e2nJAWW0+g+tWVCBgomWHHsjMpM7cHehcKkb6Qc63xgcQOh70s6Pszo
 oVqlw8L9l+NQ9EAtfZL+XI5d0PgGf5cif8s2tawcAGVdC8tzFLGC76/p0QWNE1YK7T
 pBj7V3mLmD2nsWrVrBBk/GzV1bpFkzjyb06B289u4dvtJMdLgJe2xxnSyjlr1R41xI
 jMyiocHsf84zdobkQo94vN6DiKwBIbX6Uf6jFDg6aehfi3wT9fuo9nSp9yolmY7Aew
 WW5wH+Yrrr+2DftehrCf1KYZUKYRiwbaxDiiNDrbFtLPczDA+K+Quglxv6XivaoBPw
 lQjPdoCTsUYtg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:35 +0200
Subject: [PATCH v3 06/10] test/py: android: Add setup_android_v{4,2}_image
 subfunctions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-6-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=JR+HDq/tDsvb0LtfT/ooPw5XPqYVyycyLSvsVWHTkfw=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/8SKfAnA2uUvhWYEudzihz456EvwUX1Unm2
 0XQAVgTvsKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NTZdCACTD4TkGQlQ1z9xy+a9dbwmA9VDj+BRa6ovFxNhqjdhjmceBcjk+FobQDfzfqmTgDVCatn
 HAjb2P1hJizl3gad0CslZI7CzBB6z9nsmmNzDV48G3ykngX3iwvgL0+4kYxVJ5cE6ZTE1yF1tot
 5YA06bDrPYBRWQGBdUL3cb3ITE9KSWngnnaCL0LI4TAvQRlHAtpAIE4/yTCkJmWkC8zkz6jKXq8
 91u7nWCQ/mU8mYU0rWYjhek+FQoFsbraC+BRnRp1cXYEyjHt66V0MgfeZkIVje5MyHQMvtP3tcD
 4Dh/vbFUvqUSeZCsOz7vFC0SSqATfNoM6u6Ezqu8NSIEs0Sj
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 53b5ebc1de19..79e2965f2309 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -68,9 +68,8 @@ def create_gpt_image(ubman, mmc_dev, required_parts, images):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
-    mmc_dev = 7
+def setup_android_v4_image(ubman):
+    """Create mmc7.img: boot image v4 with vendor_boot partitions."""
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
@@ -82,9 +81,10 @@ def setup_android_image(ubman):
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
@@ -93,4 +93,9 @@ def setup_android_image(ubman):
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

