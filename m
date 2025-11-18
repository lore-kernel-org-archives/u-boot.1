Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5E7CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E01583E61;
	Tue, 18 Nov 2025 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TSwhi1Hq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A849B83B99; Tue, 18 Nov 2025 19:03:53 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC0E83CDF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso1641259fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489030; x=1764093830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2x6hz7iWb1TDuKpn7hZttSAtZrxq2AnyklnWfww8o9s=;
 b=TSwhi1Hq+sGGWidLHFOFg3BU7BoLlF5Ll3s2YcbSwKl/xVGS3V1Ciboouu46Dx+VDf
 88c8pmQHVstZ1tZCK5AwGRnVp0659nN3kIaaTmmWdQU+1JpXvC1hFYpUwVcZhON5KKTV
 XT49Tj1SLIHDhOYMJ99gfWRdR1TYhMUkiR+10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489030; x=1764093830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x6hz7iWb1TDuKpn7hZttSAtZrxq2AnyklnWfww8o9s=;
 b=LSCl24q5gRFseaitMAdF+IIEuJIrwNbDUHgAuxmlY+EfoaUNacvNuLlcYKeuHOj39g
 y9Xkpu2tjtKWio4ZkcZIUpM+wf9n805Yp59nK8uBvRwxZbdg/3AlcHA0htbGkcRMQbg6
 IqbtGrnAMYYNXSbErEbBwEODueubC85IyrYCOCd7H05EE3Fm8iEthfIinGrhs2I+sJfT
 vysCWWjbC4af7JHNaAUFrR1xA37TNaw0xOucsqoEhPekWYa554aH5tuTEPA+3Lwrk3Tp
 kUgpjwRgm12jfc5OA6kLNS3+6G1sF0KVtfAYxEE6Z/POmuLy/bfmUXPAQJxlWVu4ElkI
 4ZHQ==
X-Gm-Message-State: AOJu0YyBeTWC/mJSmGNIHXNZnUeUXPPMnVm4mh1HYn7sYXeqUEavSM5W
 CDQ3VWRm5rQ5FmXf3UQTy+jg3MWY//UEuu5C0txBwkcAKYVNAn387S3NKSI6/sOEwNldmD4MsdW
 ik+CNlfWj3Q==
X-Gm-Gg: ASbGncsWp8pD0qmKE0kpjC1CcZjz3CLc43dWqA+IV8RchisIb/OQiFXHESEqANmo9Ml
 m8CEeSiXC5LJYVowD1sjievmzTWO9nSQHLuX7Wul1YUcfeCFAc1EuocPrK9nqrEPNXO3LHm+i/X
 Nc8TXrcm1D8Ce4WAD4g99ljU/fnhNBKOJVTTE8o181o9C7ZYSVKrLgysNcabjPDc99L0DMDrbmD
 n3rN3wUmmHGADbo4LZXjJzlMc0YQ+V1VxAMaG4WVjyR1IT+duri99H/VTmLbJX97uKrLu9v6rbz
 2fPI8Q4Yq31f7eogUT6t7ds2C52CjIMMwcDiD/qGc4Pcnt4wNl1aNveCNNPZVmILgt3Fsq84GMa
 /h2FAOLzrCKdZpivJg2RQwqvZ9HI8Zdx0w9yt4e+95qFxdxXISVgW8Y/POxIEk3xrsXDJN2Qltk
 JNb4BQSZia17sxE2WgyjufXPX82Kd2uOlOogAHVBlWtisnmj069Kc8z658gVufF0g=
X-Google-Smtp-Source: AGHT+IFsOgFz/6kScwihfyYZ6c6HjSzv7DJtHKaMo1qgUzG6AjZMCARWyYEhfbJ310EfkdcLwmyJ0Q==
X-Received: by 2002:a05:6871:3419:b0:3e8:96be:8bcd with SMTP id
 586e51a60fabf-3e896be8d7emr5013613fac.12.1763489030337; 
 Tue, 18 Nov 2025 10:03:50 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8952f7e89sm3703134fac.14.2025.11.18.10.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
Subject: [PATCH] bk4r1: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:49 -0600
Message-ID: <20251118180349.590953-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
---
 include/configs/bk4r1.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/bk4r1.h b/include/configs/bk4r1.h
index 6d24c5decd5b..4a0b9edf4579 100644
--- a/include/configs/bk4r1.h
+++ b/include/configs/bk4r1.h
@@ -57,7 +57,6 @@
 /* Extra env settings (including the target-defined ones if any) */
 #define CFG_EXTRA_ENV_SETTINGS \
 	BK4_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"blimg_file=u-boot.vyb\0" \
 	"blimg_addr=0x81000000\0" \
-- 
2.43.0

