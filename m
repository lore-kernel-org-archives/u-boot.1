Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F0CF2566
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5A188C4D;
	Sat, 12 Oct 2024 15:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qWUsvUyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C1B889C3; Sat, 12 Oct 2024 15:57:30 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C85D88A3C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99543ab209so417221866b.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728741447; x=1729346247; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gBGmf1rprmzYQLqRsryt+Ss4X3Z5KJ+lnCXbL7jk2xs=;
 b=qWUsvUybHjNybH30+YcThf1ugkyeyhkTgZutEdVTu4bPNxNb5XfBq9E66xFO5J1ege
 aamily56p5DMKJNm1ddfAUWgoSnjsAp9C0lct0b4+7P8xJDpoI+iza/vdOWIV9j/poCd
 VMmCAEPqBOEUhiJKWJ5191dG8V3SvFxmLybNhoIFWaYrlzBWqUCGOiw+GrfPXj8S4R6z
 nX+EasKorvHBuXaYEqahC6eSOcLufrAdkgLlL/2Xw1a28oKB+726Sgaf76gkMKBx8qj9
 lb99Y2bbwOOQw3OPC0Ov3TAhNJPJBCyGOO7koRKLgYwexYm+Y2VOQfvbbynVX1WO73VT
 QC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741447; x=1729346247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBGmf1rprmzYQLqRsryt+Ss4X3Z5KJ+lnCXbL7jk2xs=;
 b=FWAUFA63XyV7rUohpmYbUit3yI/ucS70WqTzAM0Vu9vjiU6sSc/2Pu1NrZzBAX4kOr
 kQLrKiHxorg1VHKfh4YG+rMMi7Tj/np/X3jtotjs9vz3oJ3xqrm0Ik7X0EWdnNGR5u3S
 CoBuMD0kDHspFSojEmGVuDaJTDwLnOlkN6TPu5MZLfd124KTZ68m/mjWDcy2ZOaQk/+y
 4Mk7Wan+zPQ/ZVaUScIdlvm+bV5dCR7pCEhb6Z0h5Bm74JUJaaW1d0VqC9EOeaUnDsHx
 ye5DCdioxpSBZ2EkBjwRRKwEq28ECnrCg1O5as4+wMuTupX95TCN0pnB08Pr39f0jWKL
 0/TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP0aZIVQvAXJLYpKxm0tDmdihwmtW7a/8Dll/kvNxdCrzAV/+rx/bUWZWFDn3ZyFGASVkXpGk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/ql0wTibOdw1LKOYYVXlNxV7zv07qjj17fH6Ypc4FnBuee0su
 7C3dxFtx/rIRLwWU1xAQA7mL6gvni9tmtQyqu4z1XrFB8bseivYLvt7iVjIWku4=
X-Google-Smtp-Source: AGHT+IEmNQtlAIH4mdMnbyd2az/Xnptjv118W/hipnynZ1fU4ltbjsXtkLU/svd9PFOFLyiOfKwQ0w==
X-Received: by 2002:a17:907:7da1:b0:a99:3ac1:2997 with SMTP id
 a640c23a62f3a-a99b938c316mr503407666b.25.1728741447273; 
 Sat, 12 Oct 2024 06:57:27 -0700 (PDT)
Received: from cymric.local ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2c1f4sm324955966b.87.2024.10.12.06.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 06:57:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 12 Oct 2024 15:57:18 +0200
Subject: [PATCH v4 2/4] disk: expose partition type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-b4-qcom-capsule-updates-v4-2-abd05f15255f@linaro.org>
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=8HehlziPOEMlWVgeQSjbATHEoHO/WdJXdIHVz23d518=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBnCoBDlRSI8mGUjepDpR+Sd8tL9rH54x9YB5T8i
 vEw6bbUYhCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZwqAQwAKCRAFgzErGV9k
 tgtRD/4z7Zjf66999uTGXE59YR7Dr/JFQesnaING2RNCzF0A2jWhyTSCiKmwbB/WHFQ+Z9ghc/x
 Lkbit5GRjLu9OVGTqDeEmd3fCddF3o38KTN4QOjNIcNyXt5jZF5UKsHFkZ67P0NVz8we2bP80Dw
 v9AL5WWCRnFJM3a8OSCgIl4GK/m8lnCvJ8iF7tglGZVkwDU2zo9hOrvoKX4PCLb2oioXqw6b56M
 UD1doQTaSlW7akwAmZPH7/+I3BDvmI73i0a+qcJdT2bCABpsouV8OJj+kue9MJMvI7XinGozeTp
 8WRjYqRtDcPcwdcoIJFRc/4o5JEBFESUBwcfSjokhEjtfKXDQSYZzMo1KQcyXIXNQAstdkwrIFD
 Tl7uMmuZqcwSvM8uLT7Dvz0RaerqOm3XmLy9J6I7bNdpluC8fl6DakZwklsJBWLYEmMdR5Ermn0
 aQg78w2WOIpbvmFw9E5ps/Ni0XuydM0UudS8nGtk/WqV/fTYYon9ZXObZhMAjVH8uhQJkkSslLw
 lU4thlNZPzBK93NMxOSZHVLLVD8YD/hPHG2izAHpEt4GoM8hp1PmfYxU6XDsE2Z8KPJXgaaZnMU
 zOv0cczM9G8hWbS+tIa3zm1xzFgepXeKkKQGXcAo3GuqSRvV2NfNV8tJaksupPYaew91Mo/olgA
 LAJSOQPdCHP4T8A==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

GPT partition tables include two bytes worth of vendor defined
attributes, per partition. ChromeOS and Qualcomm both use these (with
different encoding!) to handle A/B slot switching with a retry counter.

Expose these via the disk_partition struct so that they can be parsed by
the relevant board code.

This will be used on Qualcomm boards to determine which slot we're
booting on so that we can flash capsule updates to the correct one.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 disk/part_efi.c | 1 +
 include/part.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 580821a6ee9c..f302a2433cb6 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -291,8 +291,9 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte[part - 1]));
 	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte[part - 1]);
+	info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
 		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
 				(char *)disk_partition_uuid(info),
 				UUID_STR_FORMAT_GUID);
diff --git a/include/part.h b/include/part.h
index 797b542ef1ff..f68ed3bf3930 100644
--- a/include/part.h
+++ b/include/part.h
@@ -73,8 +73,9 @@ struct disk_partition {
 	 * PART_BOOTABLE		the MBR bootable flag is set
 	 * PART_EFI_SYSTEM_PARTITION	the partition is an EFI system partition
 	 */
 	int	bootable;
+	u16	type_flags;	/* top 16 bits of GPT partition attributes	*/
 #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
 	char	uuid[UUID_STR_LEN + 1];	/* filesystem UUID as string, if exists	*/
 #endif
 #ifdef CONFIG_PARTITION_TYPE_GUID

-- 
2.46.2

