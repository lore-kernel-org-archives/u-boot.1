Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09443C982D9
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD72D60BD6;
	Thu, 17 Sep 2026 17:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXJJkcQ57i6t; Thu, 17 Sep 2026 17:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E32B460B9C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665612;
	b=lFH9lPGpsX/SvwkWVCHIDVXp3aLKxSvfkstM/SdO84MMQ9lswxH0Z/DFl17wDmP5kNat
	 +6SFVgmIjPB1u/FSbjWyyLPBbeeHwhb6NkEqQdG08YFWSJe0U6Ad4HcSRU8vvul6uI2ge
	 ioqWyOiiWSt9lDoJ9Fy/P408JsTi+oBw8Pc6SuagGMV7wigqa7gLxx6Gq2C31gmuYr8b6
	 6DdHbGgpa0KI94fMAuviXbXU2kdw3zJImyD+eli3mDI3aubGzgQuKmP0AfMBjFLGdsNTH
	 kOZhVDknBc6QR7eWdHn+BrGhwAZmpfWHadsw8DbYAcxBfXY7Zt3DZ89enAXP6gKIdFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PLrL1XY18JG3CNGDKQGP1u9f9ITbj5MdDoabUrH3a/s=;
	b=JdVmsPDHQaNR7H8FYVChytVhjnajhL00xANd0oxyL0ARwigVjBpyQKvQOeR5RiEWvs04
	 k+oVK8z6GUTplhqX3crlmmQd/ktsxlHqI43YipmcSbnl0T7YN7ChG8frmgoBMJwSfAe7E
	 EarBruS0O2FoGgUzuWGxH+U17bXVLkVhxCzpgO3yQVXF4WDiI0Dj4T98LEdg5o9MABTzQ
	 AqzsA/kypaKfI8MYY2ulnd2XQMHbfmqarDo349drK+DaXuaRNLSEKujT76ILPdYuW5etq
	 hAX3NuGq21y26kPwrCse6FR5+kWcyPzR4LdjrCS3t3Xf1mx4wEJNApG9hlISk5wS+Zg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=niW3EiBW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665612;
	bh=PLrL1XY18JG3CNGDKQGP1u9f9ITbj5MdDoabUrH3a/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ERKe66kHANOwUiEY9jAUfmZjnYw+9qdnino0kHKW6xTUMAQhFKSo9XeczKsJyknGY
	 edwy+BGakSBmbwibvs8dudBukr7TEF+I+VAVrfdFlmCgfKwfu1BH+6fNG0ljLHWiu4
	 dvExXvEGpplaf2o0SDLpR6BUvRjHq2K2o8alq+QBkDVmqDYfJBGI0fiSvC5IoVUqcX
	 B3ZdJpoDCbY1jnWpMJVa0rbOnZz9ynLSa5TnPmxJEo2cjOl+O8/GZlNE0RkgQ1SL5e
	 RSu15eSRKcBIrFELetdBYabpSUyRZ/BHOSoakJ6hMYLeyglo6qQAp2Km7ThIRhfEsY
	 MLXbILhdWGAfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E32B460B9C;
	Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AD9B3AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50E2460B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xQUFFOP31v8 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5715C60B58
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665553;
 b=iQb6hh5I2Flgetq6Rcm+fMvww0AR/1m0y0K+FwHm+4KNVCtkAHtCfQJKOLXcYWGN7RyM
 iUJ89MrwbvhXPUZSIH1126Wq2q0FLzwugOEe714b003jpQB22iLx6U/G5/IGNMKeJlPMX
 qM+Nf2Nu3UM9RfNIsJWSftsMSDy0pT0KKBEO8rXoIPXZVDy0RefsxijWWp/7wom8myOim
 s03J2k+iG7gL34kDyn6+rvJ1Wy60yopNitxfiVmihIfsKz3UD5XwpOF2rsvtJmNMjKqb3
 cmBv7bCfP9DVuUinyHym1kdGbDWZgIxRKPy9LXLV6hS/5e5Bf6O78LdoVU2ODmPGvPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665553;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PLrL1XY18JG3CNGDKQGP1u9f9ITbj5MdDoabUrH3a/s=;
 b=qL47Uwj9suIX8mfb5tmtiCaN9tWcreGdKqaxRE7dnsvbaynXsMKbCd7q7RsvROvYK5nP
 vst1JLRaMLhpL0J6Ku9adsmn7Mh/wATu50n7jEmGuCZaWnwMzye10q1GUvAFjJlP12tWw
 xroY03ImXfSGbEWQ7qSC7xbtw4/aVzM+IpG/AE97orDG3IV1PFZOjhvcuVmVUTGkmk/3K
 AEiAUWAyQfQ6wrmETayrl9FAriSXqMVjwOqNa/YRCu5iaoWqhgjnA4NQriNANTgu0xPFW
 f6PQiIGHJHtAeGfFZqSPaBLQjYIj33C8cBTbl6kBo4GfK9uvGaemLjHhai4bP8B+JxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=niW3EiBW; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=niW3EiBW
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5715C60B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A5F1596;
 Thu, 17 Sep 2026 10:19:07 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07BF3F7B4;
 Thu, 17 Sep 2026 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665551; bh=ZffUVXVI/YPqgwmzYkZA/U0YduzqYEd6YFX3fjSqVt0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=niW3EiBWbFDM5qK1M4xk0MmDjyAithaTKrIypUjLdEwnBHtNROfwExw1eTe3Wylya
 2yKF4LDQfoCw8jUduBRl8iTr1Ioxusold3zsu85g73q2E9w0MKm/GlP10Si/ISbyjV
 dJIllaTLknbWloSfMFcG+P0ARz/0bvD5JoHmPtNc=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Emekcan Aras <emekcan.aras@arm.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v6 19/24] efi_loader: capsule: Add runtime capsule flags checks
Date: Thu, 17 Sep 2026 18:18:05 +0100
Message-ID: <20260917171810.4122899-20-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:36 +0000
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

From: Emekcan Aras <emekcan.aras@arm.com>

Add missing checks according to the UEFI specification [1]

checks added for these capsule flags:

CAPSULE_FLAGS_PERSIST_ACROSS_RESET
CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
CAPSULE_FLAGS_INITIATE_RESET

[1]: Table 8.8 Flag Firmware Behavior,
        https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html

Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 26cd5ccd636..6de5de490bc 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -761,6 +761,17 @@ efi_status_t EFIAPI efi_update_capsule(
 			continue;
 		}
 
+		if (capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET) {
+			if (!scatter_gather_list) {
+				ret = EFI_INVALID_PARAMETER;
+				goto out;
+			}
+		} else if (capsule->flags & (CAPSULE_FLAGS_INITIATE_RESET |
+						CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE)) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
 		log_debug("Capsule[%d] (guid:%pUs)\n",
 			  i, &capsule->capsule_guid);
 		ret  = efi_capsule_update_firmware(capsule);
-- 
2.43.0

