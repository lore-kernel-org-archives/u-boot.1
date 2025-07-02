Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8942CC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8D882F8F;
	Wed,  2 Jul 2025 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+lAQ+JR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D3D830E4; Wed,  2 Jul 2025 03:06:08 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFC082CFA
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea080f900cso1089883fac.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418365; x=1752023165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1YJm+H1O4RRvAbqg6sKixsi6ch5VlWB0l5rFNgWD4HU=;
 b=U+lAQ+JRDERICHB6Iq+SXvnB3+Ohht8zwQQQ9B0/Iyyd59dF0HF28gZUqnEjVMZ4CT
 wEtApYO4yGsZ8Qs66CjdwEHfE2fbdPYgcqGpIAHmCjWhU8IEVwhLQ30geNfsqcs+q2kC
 k8zlYzdT/2PK43A3r7KP2CYYt+9EZi4qqY6Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418365; x=1752023165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YJm+H1O4RRvAbqg6sKixsi6ch5VlWB0l5rFNgWD4HU=;
 b=k/qXiCQWQTSx4E2slrQKXLk2Mxx4pn5EQ+8dExyS2bvmhM3WpVsNG3XmjzP4HjdUDx
 /McJk5y3NiwZeEfNN3O248QLmpo+LrpMaUVc5kxorDWR4FuLhV2iKIUIkoUwjVgnD2au
 Pfgl3g54/epSSElFvDKqQfzWeLVc3GDA5ShrIi+yWDW81X83jCAAViDFIO1hvkGRbg/7
 ryz12Ff6ooBYqJL1xyYbJFIzwJ1PyCbK9XF1UMEuotPCjN4BFoxRt4lh/wF/79jYvASV
 vQIKifd6Hd7NkKfh9/hV+3NIjySHba67AA7NOD3QMeliZLB87/Hkp9z77cVNuQJKyf+x
 BUcw==
X-Gm-Message-State: AOJu0Yw4pnD258eLX9El8CZPGpy0Cs+ijxPpKnV97Fs+dmKj55NekM7h
 ZjQbZVbaJwGl7fmuob2ADsR0FD0aSj8jS19PF5tJxC4IDLKkA/ryiHoxFnbg8y+UGOUmnr9PeqI
 v+BQ5C0Q=
X-Gm-Gg: ASbGncsV26znSncVil0Pzke9WY8KoW3dIVz4rlnNAWSp8Ay79VcllhnvpzkVCECjrrx
 AlcvEHMvF1zfctyKgfHyQzdzIR90SHjrslT1u3sKaekxmR3dJbOvZZEVI/fiC5V6oK6HaVNDsdJ
 mPeMWt+Wc0ecFw6nrovkv80tKzRBkFU6EcpII/9LnP1xJ3WaHSrucNhVicoUWQvdYcOvPa/agLV
 J2LxNaTQWea/duL2loByWBMg/WbssRPHIwVBvD/JoOXgjbD7XmXEnb92H6VDQboJ5NdGORrpS0t
 xcMO+iZjly7WunjXIcXfhcCsbBbDj1KYNaVZL3+xsXP1rRCl9UzWMS03hSjecJ/pk+Dh5wD569V
 g/cSmgdSwx7FLM+qpx9Hfzhs=
X-Google-Smtp-Source: AGHT+IFLTAJHsyeUdFIZNe7wG0P1uBzIEKvzqEk7Cgh9xIehXAzhYiNi4hj/pIE13XFSmDtTy1VR6Q==
X-Received: by 2002:a05:6870:f21b:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2f5a8d1e974mr770609fac.5.1751418365155; 
 Tue, 01 Jul 2025 18:06:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b20dfsm3569640fac.25.2025.07.01.18.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:06:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 1/2] boot/android_ab.c: Make use of LBAF for printing lbaint_t
Date: Tue,  1 Jul 2025 19:06:02 -0600
Message-ID: <20250702010603.19354-1-trini@konsulko.com>
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

When printing the contents of an lbaint_t variable we need to use LBAF
to print it in order to get the correct format type depending on 32 or
64bit-ness. Furthermore, printed message should not be split as that
makes finding them harder, so bring this back to a single line.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/android_ab.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index a287eac04fe8..13e82dbcb7fe 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -101,8 +101,7 @@ static int ab_control_create_from_disk(struct blk_desc *dev_desc,
 	abc_blocks = DIV_ROUND_UP(sizeof(struct bootloader_control),
 				  part_info->blksz);
 	if (abc_offset + abc_blocks > part_info->size) {
-		log_err("ANDROID: boot control partition too small. Need at");
-		log_err(" least %lu blocks but have %lu blocks.\n",
+		log_err("ANDROID: boot control partition too small. Need at least %lu blocks but have " LBAF " blocks.\n",
 			abc_offset + abc_blocks, part_info->size);
 		return -EINVAL;
 	}
-- 
2.43.0

