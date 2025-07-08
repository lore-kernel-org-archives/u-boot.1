Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2456C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16152830B4;
	Tue,  8 Jul 2025 13:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n7QlIxu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8326083123; Tue,  8 Jul 2025 13:49:00 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDBA8305C
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC7903F342
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751975337;
 bh=VMt6LaJcHpSEQ31UtHN6hL11Aws07/o4raqXg8GzlAg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=n7QlIxu3B0Llp4b8Qu/WUUU4VUMsAYZRSM5PUnT/SjU5xBFpnbjjkXtNxJQfBrSmD
 Bmxf76on4PGf/EB6i66NG3XovF+fW4EoKMV4al6h7wCfSlZ463Q2tadJ/DX+RW6hey
 zGxp2BgDWYDaZi9cocNwgbLywEVx34gYyXjnGb6XZzlPjzZqxWTy+kMW8IjLZ4EmEK
 Jj176KWKZWipRhTQ+J59eqmps/ea+Z4yQYxzVFe6Vms2SJ36NarAogjgu6FT74vFQF
 RlPIQS0i2svNMg/IAY4U/pYzYj9vxwHRX9mXP1gGi8eozK+eYypSbp+pduVciFokwN
 yVDu+ImZLTZXA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-60728151592so3737769a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751975337; x=1752580137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VMt6LaJcHpSEQ31UtHN6hL11Aws07/o4raqXg8GzlAg=;
 b=MYMW9DsQAucUJlucrFD43fyapwtvIkYHWIOTQMJ2gfSUxo+Nzx6maz/EGWiSito/J5
 5Dby4q4Mv3KSKseWAwUutmANBDB2Ub7z7m+1XGGfsI6Hws0DlELFda1tlSZhK6AqzMr4
 8rMrqVy4vc9xaLz4w1+ZyQIOcRJjbw9z9xbU8yblOl02GNFNbyQRJhrjpmNW9SQyNdD3
 1JdkYPLsT9flWW+Vf9+iGyduYrq7AMVpIzsngx3uUjwOt3923ygM7dA1ktr6xdvJQJx1
 tCj1BsHs5hkwj++v13BtzxlQo38DaUY6xjKtgUZreXRhSq4HidIedLgoQX5jjAhUWrCC
 q4YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuqUtT9Sffv/fKaoftsPaiPwK6sQ3RD+liPb400Dl68k8MJwEmj9+12YH2CrVbR074JdGm19I=@lists.denx.de
X-Gm-Message-State: AOJu0YxW2Z49RtO67LPmBu4kbwOVFGs92w0gBkq7Jf6kaeO32yM0dCmD
 hEICvFizQIVKvUKNAYCrAh6/1Hewl2CrZxHfiFWdXG+GMu6ZItGBk34C2lsFcs/CR0kXDwGjgqK
 BaRmqqtnBe02BcXK0ts7A28hK6d5Zf6bISl59/qM5H2/hIOjBGMOc4EvyPqtiI0L0LtL229Y=
X-Gm-Gg: ASbGncvPTZToi7My2H+fVT6nWX45YJUbKuFZD5f+cmvi0lGW+naXaAnI9sqFrN3/fJP
 n9VSxfgP2z3cUldjH1b0FawrygTM3HWFFNW4VFpRcHQdj5YmFxz0EnUdA9R066UGBOCgSwbAeBK
 i75zhc+y8Jjuv5aMhTqC9HienYnD7JYpyO661LcPWfebVeZ1s6lOhYPh3f42IUj5JMYzsjtHNkD
 pJYLjkB8/YgOwAOcH9eyG7M0WjW6VFXC54ctnomu8IlDOAPNB0Ib8ouGbJ+vvh1nbmJE9UjbLb4
 pEoaygRfyh0JJYfhf7mDD9ttA//3up/vNq0QZnJF/fABtcBAGgOQDUJduCAzPYPd62m4Y6H4U8Q
 HYhScqaz+18gOny6Snz1VfuQq
X-Received: by 2002:a05:6402:2710:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-60fd33866ffmr16744550a12.17.1751975337029; 
 Tue, 08 Jul 2025 04:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEULyGjOy/U0FahAqjva3BJ8G/fjG9EAAFNlOR0BxuzXtINRkN3ybY8LiZ/WDJP1DerZl1ww==
X-Received: by 2002:a05:6402:2710:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-60fd33866ffmr16744512a12.17.1751975336666; 
 Tue, 08 Jul 2025 04:48:56 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb0c79dasm7122141a12.51.2025.07.08.04.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:48:55 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: add missing check in FMP.GetImageInfo()
Date: Tue,  8 Jul 2025 13:48:50 +0200
Message-ID: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The UEFI 2.11 specification, chapter 23.1.3 requires
EFI_FIRMWARE_MANAGEMENT_PROTOCOL.GetImageInfo() to return
EFI_INVALID_PARAMETER if *ImageInfoSize is not too small
and ImageInfo is NULL.

Fixes: f27c20148511 ("efi_loader: add firmware management protocol for FIT image")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_firmware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 75501e21557..216df83de67 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -332,6 +332,8 @@ static efi_status_t efi_fill_image_desc_array(
 
 		return EFI_BUFFER_TOO_SMALL;
 	}
+	if (!image_info)
+		return EFI_INVALID_PARAMETER;
 	*image_info_size = total_size;
 
 	ret = efi_gen_capsule_guids();
-- 
2.48.1

