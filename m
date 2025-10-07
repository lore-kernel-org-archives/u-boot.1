Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BD5CCA472
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 12:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 013CA83FFD;
	Tue,  7 Oct 2025 14:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rwkh6L2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77718400F; Tue,  7 Oct 2025 14:04:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BAA83918
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 14:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so2889009f8f.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838657; x=1760443457; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OxwD2JYyt6c8YC2dJT1jspxp5xjKG8iMx9eAEiFlhoo=;
 b=rwkh6L2wSqjOFV1Qz6lJRv/4xKXZzOWO8w+bSu7gBHTsnLRJ4cdtAMlpJIbEOgTgaK
 gzIALtwBFKgc7wY20eBkdQFHFR2Pr1PuSf2uk1A7xsOJ394Pgra/MBh/NmsHUbgnQNTd
 VVCxaN1vWrA8Ks+05LbSYe6mdjOtIenSvFfsZvJl0yjxVAaLiZIL/BZukjvEa5TemVub
 rCvFXPSL8AhrqOhFT67C2wgxAhNS4aY7kv317Tp6tZS54tycs00OyMaFiWXxygeYaeoE
 9P9+AJw7uSm97dO/RivE9G70FM2xBu80pO2xD9kdRFUxMGM+W0Ao2ujsWBgQZfH1EVQl
 ckBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838657; x=1760443457;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxwD2JYyt6c8YC2dJT1jspxp5xjKG8iMx9eAEiFlhoo=;
 b=qinA2i8AFUN5WBligqmobXHK/vGg4rr9DBEDyVGaHJqxig7s1UikdpEKZzwLJXI8zO
 HzNECuAqB9FDvE+4/lujy1oTJYo5Gh2ktKnkeh9hva6m8nf2u6IeJPLkQH893efOdHAc
 MsYD5ozHxUC3TGNA7s4NhP9kLYlrgBkEn4KL6ics2dDn59iSiQJPLYFtY2hwxkqBGXaB
 IbY93ZYvwqoverk2qLA6+pfIf2UuHHGgcYdqx023UWFYGDs4c0G3ydCgB3gE2gvDqKCJ
 auE837M24PdjQgCKEUHF4UfLz2RuLo2YABvse0jO9L2dYz8WDzDo8RqS2SkR4dgsIyvZ
 FfHg==
X-Gm-Message-State: AOJu0YxHDLw1fEjuZSZOzwqJlOGSHq92/1CejHvbSnFFTuf3lxWl2dzu
 9W/sD88uXABRD4mrJEAb787wN5L0yog0Ewg4vcECI0VNsdbg2I+6Ycu2KnXLvdPXWx0=
X-Gm-Gg: ASbGncuHi2Ss/kPrQEVwwJZ44ZbLRaO+O/3VuJXqKPSU8MXxnbusQEiNK1yiSBhQU90
 0IV1kd/wk/H9rgPCyNhWyi9//sQIb9MvFrJ81X/A04VnxkndhkMAAwCCey15dxigdMNvl1iSxeQ
 24QuxG9YG5va+lnLXn2apV1SMGtFYmNsnwti8IH3ZWqRrqxxk2n6c6vM4hHOQ2TrDSbxHkPTtsW
 K/TK3w/kyh6Ud/o/9SGGZLGdjqQDPAO4J/sTqyj70gv2S/6VQYm0UuSed70lcj07B2Jin3PpCqk
 LUtYoX0get6vUD09dxETisllPP4TpRCiRixqUXK+N7hbsQKxikyrsnpQunI78oLwQ2pfkFAWK22
 585Dcvs03szKCpEbf20vqM93FWEz+BXAPb9ztAftLWTEcJb2Z7IJ1SJyWDxc0sM4Cnn4N1xqHwm
 yU
X-Google-Smtp-Source: AGHT+IE5HDP1R1P48VFp/RdfNL5B6erQXU4zjjnye7r0rT8zdbFHa1VrsmXOKtyJvOQY8CAaPC+fpg==
X-Received: by 2002:a5d:5d0b:0:b0:3fe:4fa2:8cdc with SMTP id
 ffacd0b85a97d-425671c3b54mr10099084f8f.60.1759838656902; 
 Tue, 07 Oct 2025 05:04:16 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:c90:3de5:5f6:3a69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm25109402f8f.17.2025.10.07.05.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:04:16 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/3] ti_sci: Address some issues found by Smatch
Date: Tue, 07 Oct 2025 13:04:15 +0100
Message-Id: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8B5WgC/zWNwQrCMBBEf6Xs2UgSiKWe/A8pkmy37YImsilFK
 fl304LHN/OY2SCTMGW4NhsIrZw5xQr21ADOPk6keKgMVlunW+vUwo+MrNqAzmHQOAQPVQ4+kwr
 iI867/vJ5IdmLt9DIn+Ph3leeOS9Jvsfhavb02DZaX/7bq1FadUhjZ8loa4fbk6OXdE4yQV9K+
 QFNRf6stgAAAA==
X-Change-ID: 20250725-ti_sci-7bc55cb0cdba
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Prevent a memory leak from a non-freed malloc.
Return an error code on an error path.
Assign a value to a pointer before it is dereferenced.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Add cast when assigning to resp
- Replace malloc with devm_kmalloc
- Link to v1: https://lore.kernel.org/r/20251006-ti_sci-v1-0-9cef92e1022d@linaro.org

---
Andrew Goodbody (3):
      ti_sci: Prevent memory leak
      ti_sci: Provide error code on error exit
      ti_sci: Pointer is never assigned to

 drivers/firmware/ti_sci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
---
base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
change-id: 20250725-ti_sci-7bc55cb0cdba

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

