Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA1C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14B6040DA4;
	Tue, 22 Sep 2026 14:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69EmbLJNYwUl; Tue, 22 Sep 2026 14:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 62BB340A72
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089132;
	b=aHNbv4bBcFDSf2E02Alr1hLlwaJHLkPY7MKN+qa1s3JB9oQT4qzAlwLi6wojEKVKE8wh
	 u0Cl1fuYzx2tyxa3TeSj6SmQtrHxSCcLdZwzhEyWJm986KoyorJX632RYku+lOYtp1NaV
	 oNsxIHhhqJEwjPB9WIOAdCWaaCu1vl/xEvrDY7otuvHrgS4UDS5pjPoz8/CuyHR29dge3
	 Q/mQsSLxP8Ix3rzy8qupeF5OA2i53XHVwO3/PZoo2ShdtkUz8JmKPdyyQcxAmT9hqYaRc
	 LcKSYx360yaiE/Sj8vuSQONzx3uwOFgsJ3sm7BWP80DG/BeUGm5CHey51HYk1gij3jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790089132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
	b=btE6fqcpaoP3Z5Szt9Ca8FlXGY9K6FGLurNeajlJJirwThw0bTDQ+WCloX+PQ0JHJ0T2
	 DlL67W8fGAisHoarFEl+3CtbQRD1QsH1avfsYszWxrtQwWI/49dGy8t4L0L66Mz6e+Kmk
	 /yMDI6LVYUMnOiw7lXy1kg2LQ/+ab0yay81Aw1cVjoeefvzHpYhjnAFbzn3vQ9NNrqVBh
	 IKwk/pqw+xABbEmxmdeLkZKRnnfoclBjv6sGMb1ajoZunZ2Q1h5EKWB75+HP3Doi6rehn
	 RIQ8Jn0BHNTTgAQElHR1LNzgtHZq51kFHIJ4FvvegZ/HmUL0ido1layh4IbXZL8HeeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790089132;
	bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChxJZK/OL5CYqprQMpwprefKuCa63YwclOZO468MS3GLl1VARAyHp9ghoqC+7KkNc
	 rEhH/z0U2zFc7AEle7MkxPDscBIdirURYoYZOEHxQGeYLs+ujw9CC93L1fr2I+ocfT
	 V+WwiWyv69tvrDazn/Hnet0DLdGvo91yrsuZl8NOWZ32xfOyUIEFyA8N7ny93x0FYc
	 EBgQuTBCxqBecBYa9QWBkyDvcKBQbohjCychYyYcfpDbatG7ecZOhG/DAuJ/C2yhjM
	 DB6JCSagCcIsoQLASouKZWnKaF7MJgxQ3anoBtJLf64J7DeEdSA3P/H38/HDAUdFEZ
	 HDILlf1ynVSPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62BB340A72;
	Tue, 22 Sep 2026 14:58:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D6BC352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F2BC80E53
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poSaU6al_zGm for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA67280DB4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790089126;
 b=je7cW6rnAN3dG65hDqxOfkEjBGB7DXKOH+boaYOf1Xs4Ce57R0RR4zIf00Q44ByXgRFX
 tngv+xJgVyTJUQ1vu29krC7Ol4KVD2VU+eugrf8bVmdjP1drTo4Eu73weSZ850T3hk9jo
 QEIVeUoFaMFt/V+voFq71p8wQd6/mwJ3FKpqmU3z8M0nfo9cTdHWLJ9vn0B/eVCPB12Mh
 3NVE5gPoxWDMiEFVxgCGrbx5cgyKtENuVnK3+WJRqNvYPRhtTNEAGandCSVWml38mJrwl
 RBlOb/eyWt2SdYEv1eCpPBhW50TQlpaoxteb4+mcMxk9VYbHJjUL0TTt41CPzKynaYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089126;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
 b=YZt8wuspCjjtmuNqGNOO89fR38lUrR//SRumWCZ5hhqRRcU3t9A6Qy0W4FVrSZ7YUbik
 zJpPf54Ehj8YOHEibMVZ0dxrzBKx358QrJAUh7Zhb/CBtj7jbdKob/xyVgp3sMZNDqcbV
 tVrFJFIK9dCwrt4LfSndJxkfGjVqakGMukX0SL01K30lzBpYe6hGQbDlC2+LLV0Y3LMKl
 Lg5qKHXV6oGtxU4kUj3cqriLEGVC7tLn1OAv/+CjyZjiqwbNfWgr85Jj32Wxc1q0qZICL
 Km7dIsPZCJbxKy9g/jH9+Oyqof418O4i+x3LzP6LvYQks0uUbActzbJHUOPo0e7VMWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=vdmt3SQp; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=vdmt3SQp
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA67280DB4
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DA0F1595;
 Tue, 22 Sep 2026 07:58:41 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D083F632;
 Tue, 22 Sep 2026 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790089124; bh=GSZnFjIv/vcZz1XyfXVJpbrgi5izeUSqIeRUMVXyOJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vdmt3SQpFBvQ1VMl2Ozmc3X5eiHwpI9ab2274//g4J2D0wGTRc6/+jt71oPi4k/3L
 xsK7XEOuQDvbHV0wp1ez7/I74Dt6CP4eQCbVevHtBaqgy6cz239BpdoN1uSUbKdAvi
 oIUxqPUUgFy8XLA6hgBuXifgoQmzfXR3h2W6X6So=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 22 Sep 2026 16:58:40 +0200
Subject: [PATCH 1/2] efi_loader: fix image info authentication attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-authi-v1-1-e943530349bb@arm.com>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
In-Reply-To: <20260922-authi-v1-0-e943530349bb@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=GSZnFjIv/vcZz1XyfXVJpbrgi5izeUSqIeRUMVXyOJ4=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqspehfW5mMBmySTEK5vILTwOCmcWWQB5h+AALr
 hq3N7ZfR1CJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarKXoQAKCRDLSfhWdqMG
 lFnTB/9GYcpG50UTVg9wcs4cJvn9x4HCVRJUvTYySZUJo6BUidDsr0EQSZ+LxpmQTV+s0X/rVTF
 kZzvd6bCAVIR0sUBwhanSa4mRNt5+4uMaE+4wUJHyquU7dptS6Kot3DwfV2gIxkd3MPxTXzuveK
 dQklEih6iarWGL9PNJXOPbunRCmheK4B8NgBdUzTHRoFOd29zvTmV6Xo8NYAhBRHlMMIPXwBme4
 8JH2LT0bU9Vz/ZUCp5pclT8wd44Xit9dqVad6Ny+ZvjH0LXMatsB5QgsVY2sKDczlgc3WfZKsmw
 ZnIRW/8PeA/xZCeYYiDP0nXHYRCbr6f2LaibuBUt+28x3ZfG
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The GetImageInfo() function of the UEFI Firmware Management Protocol
returns the authentication required attribute correctly in
AttributesSetting only for the first image; fix this.

Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
---
 lib/efi_loader/efi_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..84de95f5c23 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -364,7 +364,7 @@ static efi_status_t efi_fill_image_desc_array(
 
 		/* Check if the capsule authentication is enabled */
 		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
-			image_info[0].attributes_setting |=
+			image_info[i].attributes_setting |=
 				IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
 
 		image_info[i].hardware_instance = 1;

-- 
2.53.0

