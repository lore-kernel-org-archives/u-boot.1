Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFECC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C75960BC8;
	Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxaEEtpdmCzm; Thu, 17 Sep 2026 17:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 49AE760B9C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665599;
	b=FcCzg+tnSX4U8XaI7F3OGLyrxz2nYpXm5dYG0OhyTeip0pBvNYD31eVkfU3KypXf+jVT
	 Tld7xsS94VOSxv8YA+lCkezocc0Bvm6MPM0vz+Y6BkGVWU/RQqZOqWgH/xy/cShNP6Lrd
	 cJHKpb75hWGxxjNXVmHIrNkzUaxSyR+iahBZYW5omwDLXxRctjKrjZa3N8B2xY3O+5XGA
	 sT+hjjg5vbyprXbJWS/N/3rJTA7QDNUnjNUguuJ+aHMmtozkwptxUAkl9qaJkVoYSq2Er
	 I871hKZGldmMgQ5RMd3A6EIrPutDNFIiLd9CM8BrN8BUu2jTDeMitkX6QXH/GHhym/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CHWhqDqnrwe3RyI3vIar38oIfAK5U2qCmBp+cnvbo+Q=;
	b=ir71WVQ+XqW1YlILdemTlWjpLOc5WyurpwsGt8/Hw1ZIxPmgcifCa+Dn7BpSViBhd35I
	 cgUjKzkro5eg9iI76+RFWom01QUUxf5s4FM8HVtX97bVH0k4Y0qOlrV3kAXIlVr9fzigF
	 edKFXGKNBECxfT1O/gCSmpmDD9nM4RaG5ionmtzrQwyWRGtutL6FvEmkjORnssWsGp2py
	 FreJTIJIhw0aOVyJ0xnc2LLpWiIYXRKUeo2QgZjCarURcnSX6dFzRR1RVdvQsEPKZfGJT
	 bHpV9CZu/+JhYM+0QhWtOnAzMBNSkjAKRGThn2sxuFaJqJiw5F19fa/d30MOVX3sV7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665599;
	bh=CHWhqDqnrwe3RyI3vIar38oIfAK5U2qCmBp+cnvbo+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zPX970kMa7auXH1EwRAr4ZgYQat4vg2L0wX6BW+eyFGf0aNusNg1WFYA4pld8lCOi
	 gJqB3HcBG51hc1JDIjs3Dz4cMR6lFOz/5JU5DTIAD2snwv+6raEsCrtYzmftrJoXJR
	 X42lSxwTFXyCsRttbNmSjJ/66jrbZpK65pI6yrT63k64toEg6TbQgDYsYBJMVBFdYr
	 QKCLQarmC89XenDRO1dNbOufoqtalk4gWrnkLkL7rTOJrQa2DyvrSZPGkUAYYFTFRs
	 qO8ueCv4Dy4jQS6s3yacetwl1j93+BEHbDyQMZw5/3wb/d5FlO1VjZScJpMVc7wnEq
	 SrPp2NdnCJ6pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49AE760B9C;
	Thu, 17 Sep 2026 17:19:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CBAE13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E6108108A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLpJLFCEP0rW for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7981D807E6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665542;
 b=BTL0llpmP77oIgr1DqBx87loV1KKmPmeE8p1E9PdCvY/uU8yvTe5rCJLbSZPr+2LJTgn
 AjM3VApMHRzoBQGivyfsiu4azukfXzrUpI76zI7x2r2/Sv9rY6TkATswT7vSw4XFSDwEc
 c/M4jxjVgd7RTJJT6UVyQj9wqj5p+ZwegN5AOY/euUBWXiYZlfqkVDCGmM1o5mz1fJOfT
 F+9kHyVr0HrYdZEC583T4KfkUZ5cFW4q12o6j4ceXcYHDYSyL6WWZ6Ny22pZTK5JsOVGv
 iBRytxpLBil0DPBwP5oa6kaHXLlPNkIJ69fEhklhGnQgJ0EiOmoQAGHih/71pC3PkYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665542;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=CHWhqDqnrwe3RyI3vIar38oIfAK5U2qCmBp+cnvbo+Q=;
 b=c93pLJgpkOl0nQQtZMtXGri1f08H7TwCXuQuSqb1fuHVxX9IFBI8MnHKkVUFNQ/5g7a5
 Gsupm+b818DKldX2oMNZ5k1bnbJeBMjKuLlVzjZrWGruRNpGw3+is8XgwiK90nWfVWci7
 A91TR+i65e68rd0fzlCWwhPRqqqcgeHxz9Cw6gMALOr63Gx9XaoGBnBdLnpf/2PwfREMb
 bxRvKIGABnC4dkeD+Prs76iJLEGnHODORYyUxWaQXzmmXkWud0eCxB0iVWWFFZGDiQSRH
 h3+UDuBIdg+fzoqksF9ggOg6DYAwsoCEnfKyq4ahiDf1oxFnHSW93Hiy61mWRgaHK6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=RDg9sELY; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=RDg9sELY
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7981D807E6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289761596;
 Thu, 17 Sep 2026 10:18:58 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9AFB3F7B4;
 Thu, 17 Sep 2026 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665541; bh=tv01tGwrVe7Lg5QbuVm9E4yQqDTYz0ji7Ik/E/d73Sw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RDg9sELYi/D4B3CGpiJwHFZ88eWlpeP6FU89Fb/1yKqyDZVlebyh3sjLIgnYWSd9+
 bS5Xr3CG8vRR+Cgp0bJVLdutftVUFH7hpbHjAz+qvajWAsWEKla8f/Ml7Sk5S3a4Or
 tYQJVYvRdx38FtHaYI7Ft+HbELwjIL648KdTGBAk=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 14/24] efi_loader: fwu_arm_psa: Skip accepting payload
 after set_image()
Date: Thu, 17 Sep 2026 18:18:00 +0100
Message-ID: <20260917171810.4122899-15-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Do not update the acceptance metadata bit after updating an image.

The update agent (secure world) is responsible for setting the acceptance
bit in the metadata. Implement local no-op accept and clear-acceptance
hooks to avoid modifying shared multi-bank FWU metadata.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_capsule.c |  7 ++++---
 lib/efi_loader/fwu_arm_psa.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index ef2cb7fabe1..fe14eebf867 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -676,7 +676,7 @@ static efi_status_t efi_capsule_update_firmware(
 			goto out;
 		}
 
-		if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE) || IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
 			image_type_id = &image->update_image_type_id;
 			if (!fw_accept_os) {
 				/*
@@ -698,8 +698,9 @@ static efi_status_t efi_capsule_update_firmware(
 				goto out;
 			}
 
-			log_debug("%s the accepted bit for Image %pUs\n",
-				  fw_accept_os ? "Cleared" : "Set",
+			log_debug("%s %s the accepted bit for Image %pUs\n",
+				  IS_ENABLED(CONFIG_FWU_ARM_PSA) ? "PSA will" : "",
+				  fw_accept_os ? "clear" : "set",
 				  image_type_id);
 		}
 
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 91ad6ce5b21..83c876d5d8a 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -1224,3 +1224,41 @@ efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
 
 	return EFI_SUCCESS;
 }
+
+/**
+ * fwu_accept_image() - Dummy hook for accepting an image
+ * @img_type_id: Unused image type GUID
+ * @bank: Unused bank index
+ *
+ * For Arm PSA, accepting images is either at ExitBootServices() or in the OS.
+ * The setting of the acceptance bit can be skipped as it is not used in Arm PSA.
+ *
+ * Return: EFI_SUCCESS always.
+ *
+ */
+int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
+{
+	(void)img_type_id;
+	(void)bank;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * fwu_clear_accept_image() - Dummy hook for clearing image acceptance
+ * @img_type_id: Unused image type GUID
+ * @bank: Unused bank index
+ *
+ * For Arm PSA, accepting images is either at ExitBootServices() or in the OS.
+ * The setting of the acceptance bit can be skipped as it is not used in Arm PSA.
+ *
+ * Return: EFI_SUCCESS always.
+ *
+ */
+int fwu_clear_accept_image(efi_guid_t *img_type_id, u32 bank)
+{
+	(void)img_type_id;
+	(void)bank;
+
+	return EFI_SUCCESS;
+}
-- 
2.43.0

